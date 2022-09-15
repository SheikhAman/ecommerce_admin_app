import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/order_constants_model.dart';
import '../models/order_model.dart';
import '../utils/constants.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();
  List<OrderModel> orderList = [];

  Future<void> addOrderConstants(OrderConstantsModel model) =>
      DbHelper.addOrderConstants(model);

  Future<void> getOrderConstants() async {
    final snapshot = await DbHelper.getOrderConstants();
    orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrdersByOrderId(
      String oid) {
    return DbHelper.getAllOrdersByOrderId(oid);
  }

  void getAllOrders() {
    DbHelper.getAllOrders().listen((event) {
      orderList = List.generate(event.docs.length,
          (index) => OrderModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  num getTotalOrderByDate(DateTime dateTime) {
    final filteredList = orderList
        .where((element) =>
            element.orderDate.day == dateTime.day &&
            element.orderDate.month == dateTime.month &&
            element.orderDate.year == dateTime.year)
        .toList();
    return filteredList.length;
  }

  num getTotalOrderByDateRange(DateTime dateTime) {
    final filteredList = orderList
        .where(
            (element) => element.orderDate.timestamp.toDate().isAfter(dateTime))
        .toList();

    return filteredList.length;
  }

  num getTotalSaleByDate(DateTime dateTime) {
    num total = 0;
    final filteredList = orderList
        .where((element) =>
            element.orderDate.day == dateTime.day &&
            element.orderDate.month == dateTime.month &&
            element.orderDate.year == dateTime.year)
        .toList();
    for (var order in filteredList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getTotalSaleByDateRange(DateTime dateTime) {
    num total = 0;
    final filteredList = orderList
        .where(
            (element) => element.orderDate.timestamp.toDate().isAfter(dateTime))
        .toList();
    for (var order in filteredList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getAllTimeTotalSale() {
    num total = 0;
    for (var order in orderList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  List<OrderModel> getFilteredListBySingleDay(DateTime dt) {
    return orderList
        .where((orderM) =>
            orderM.orderDate.timestamp.toDate().day == dt.day &&
            orderM.orderDate.timestamp.toDate().month == dt.month &&
            orderM.orderDate.timestamp.toDate().year == dt.year)
        .toList();
  }

  List<OrderModel> getFilteredListByWeek(DateTime dt) {
    return orderList
        .where((orderM) => orderM.orderDate.timestamp.toDate().isAfter(dt))
        .toList();
  }

  List<OrderModel> getFilteredListByDateRange(DateTime dt) {
    return orderList
        .where((orderM) =>
            orderM.orderDate.timestamp.toDate().month == dt.month &&
            orderM.orderDate.timestamp.toDate().year == dt.year)
        .toList();
  }

  List<OrderModel> getFilteredList(OrderFilter filter) {
    var list = <OrderModel>[];
    switch (filter) {
      case OrderFilter.TODAY:
        list = getFilteredListBySingleDay(DateTime.now());
        break;
      case OrderFilter.YESTERDAY:
        list = getFilteredListBySingleDay(
            DateTime.now().subtract(const Duration(days: 1)));
        break;
      case OrderFilter.SEVEN_DAYS:
        list = getFilteredListByWeek(
            DateTime.now().subtract(const Duration(days: 7)));
        break;
      case OrderFilter.THIS_MONTH:
        list = getFilteredListByDateRange(DateTime.now());
        break;
      case OrderFilter.ALL_TIME:
        list = orderList;
        break;
    }
    return list;
  }
}
