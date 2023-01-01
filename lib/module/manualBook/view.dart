import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/manual_book_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage(
                  "assets/manual_book.jpeg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Manual Book",
                  style: System.data.textStyles!.boldTitleLabel.copyWith(
                    fontSize: 30,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xffF4F4F4),
              child: ListDataComponent<ManualBookModel>(
                enableGetMore: false,
                enableDrag: false,
                controller: listController,
                dataSource: (skip, search) {
                  return ManualBookModel.get(
                    token: System.data.global.token,
                  );
                },
                itemBuilder: (data, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.onTapItem(data?.name ?? "", data?.url ?? "");
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 15, bottom: 15),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: const Offset(3, 5),
                          )
                        ],
                      ),
                      child: Text(
                        data?.name ?? "",
                        style: System.data.textStyles!.basicLabel,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
