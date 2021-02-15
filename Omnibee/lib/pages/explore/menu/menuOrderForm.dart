import 'package:Omnibee/bloc/basket/basket_bloc.dart';
import 'package:Omnibee/bloc/menu_order_form/menu_order_form_bloc.dart';
import 'package:Omnibee/models/menu_modifier.dart';
import 'package:Omnibee/models/models.dart';
import 'package:Omnibee/widgets/largeTextSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodInfo {
  String name;
  List<String> addOns;
  double price;

  FoodInfo({
    this.name,
    this.addOns,
    this.price,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'add_ons': addOns,
        'price': price,
      };
}

class FoodDocument {
  final int index;
  List<FoodInfo> order;

  FoodDocument({
    this.index,
    this.order,
  });
}

class MenuOrderForm extends StatefulWidget {
  @override
  _MenuOrderFormState createState() => _MenuOrderFormState();
}

List<String> selectedAddons = [];

class _MenuOrderFormState extends State<MenuOrderForm> {
  List<ModifierItem> selectedItems = [];
  final _formKey = new GlobalKey<FormState>();
  String sRequests = '';

  Widget _buildModifierList(MenuModifier modifier, int index) {
    return modifier == null
        ? Container()
        : Column(
            children: [
              LargeTextSection(modifier.header),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: modifier.modifierItems.length,
                  itemBuilder: (BuildContext context2, int index2) {
                    ModifierItem item = modifier.modifierItems[index2];
                    return ListTile(
                        title: Text(item.name),
                        subtitle: _getPrice(item.price),
                        trailing: SizedBox(
                          width: 80,
                          child: BlocBuilder<MenuOrderFormBloc,
                              MenuOrderFormState>(builder: (context, state) {
                            return (state is MenuOrderFormLoadSuccess)
                                ? Checkbox(
                                    value: selectedItems.contains(item),
                                    onChanged: (bool isSelected) {
                                      _selectModifier(
                                          isSelected, item, modifier);
                                    },
                                  )
                                : Container();
                          }),
                        ));
                  }),
            ],
          );
  }

  void _selectModifier(
      bool isSelected, ModifierItem item, MenuModifier modifier) {
    bool isNotAlreadySelected = !selectedItems.contains(item);
    bool canSelectMore = _canSelectMore(item, modifier);

    if (isNotAlreadySelected && canSelectMore) {
      BlocProvider.of<MenuOrderFormBloc>(context).add(ModifierAdded(item));
      setState(() {
        selectedItems.add(item);
      });
    } else if (!isNotAlreadySelected) {
      BlocProvider.of<MenuOrderFormBloc>(context).add(ModifierDeleted(item));
      setState(() {
        selectedItems.remove(item);
      });
    }
  }

  Widget _getPrice(double price) {
    return Text(price == 0 ? "" : "+${price.toStringAsFixed(2)}");
  }

  bool _canSelectMore(ModifierItem item, MenuModifier modifier) {
    int totalSelected = 1;
    for (int index = 0; index < selectedItems.length; index++) {
      if (modifier.modifierItems.contains(selectedItems[index])) {
        totalSelected++;
      }
    }
    int maxSelectable = modifier.maxSelectable;
    return maxSelectable == -1 ? true : totalSelected <= modifier.maxSelectable;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuOrderFormBloc, MenuOrderFormState>(
        builder: (context3, state3) {
      return (state3 is MenuOrderFormLoadSuccess)
          ? BlocBuilder<BasketBloc, BasketState>(builder: (context2, state) {
              return (state is BasketLoadSuccess)
                  ? Scaffold(
                      bottomNavigationBar: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: RaisedButton(
                          child: Text('Add to Basket',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor)),
                          onPressed: () {
                            _formKey.currentState.save();

                            MenuItem item = state3.menuItem;
                            print("this is now special request: " + sRequests);
                            item.specialRequests = sRequests;
                            BlocProvider.of<BasketBloc>(context2)
                                .add(MenuItemAdded(item));
                            BlocProvider.of<MenuOrderFormBloc>(context2)
                                .add(ModifierReset());
                            setState(() {
                              selectedItems = [];
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      appBar: AppBar(
                          title: Text(
                        state3.menuItem.name,
                      )),
                      body: SafeArea(
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                                child: Text(
                                  state3.menuItem.description,
                                  //args.desc,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state3.modifiers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _buildModifierList(
                                      state3.modifiers[index],
                                      index,
                                    );
                                  }),
                            ),
                            SliverToBoxAdapter(
                                child: LargeTextSection("Special Requests")),
                            SliverToBoxAdapter(
                              child: Container(
                                  child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  obscureText: false,
                                  onSaved: (text) => setState(() {
                                    sRequests = text;
                                  }),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Requests',
                                  ),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container();
            })
          : Container();
    });
  }
}
