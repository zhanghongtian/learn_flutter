import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:scoped_model/scoped_model.dart';

/**
 *知识点：
 * todo - 使用自定的小部件
 */
import 'widgets/news/news.dart';

class NewsManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: Column(
                  children: [News()],
                ),
                onRefresh: () {
                  return model.fetchNews();
                });
      },
    );
  }
}
