import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grace_product_seller/app/provider/auth_provider.dart';
import 'package:grace_product_seller/app/provider/dashboard_provider.dart';
import 'package:grace_product_seller/app/provider/order_provider.dart';
import 'package:grace_product_seller/app/styles/styles.dart';
import 'package:provider/provider.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      width: media.width * 1,
      padding: EdgeInsets.all(media.width * 0.04),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: SvgPicture.asset('assets/icons/dashboard.svg'),
              ),
              const Chip(
                label: Text('Lilian'),
                avatar: CircleAvatar(
                    // child: SvgPicture.asset('assets/images/user.svg'),
                    ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Consumer<AuthProvider>(
                          builder: (context, auth, _) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 16.0, 16.0, 0),
                                    child: Text(
                                      'All Agents',
                                      style: TextStyle(
                                          fontSize: media.width * twenty,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Column(
                                    children: auth
                                        .getAgentsList()
                                        .map(
                                          (agent) => ListTile(
                                            leading: const CircleAvatar(),
                                            title: Text(agent.name),
                                            trailing: auth.currentAgent ==
                                                    agent.id
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        buttonColor,
                                                    radius: 15,
                                                    child:
                                                        const Icon(Icons.check),
                                                  )
                                                : const SizedBox(),
                                            onTap: () async {
                                              auth.updateActiveAgent(agent.id);

                                              await Provider.of<
                                                          DashboardProvider>(
                                                      context,
                                                      listen: false)
                                                  .getDashboardData();

                                              // ignore: use_build_context_synchronously
                                              await Provider.of<OrderProvider>(
                                                      context,
                                                      listen: false)
                                                  .getOrders();
                                            },
                                          ),
                                        )
                                        .toList(),
                                  )
                                ]);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Row(
              children: [
                const Text('Data from Agent #'),
                Consumer<AuthProvider>(
                  builder: (context, auth, _) => Text("${auth.currentAgent}"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
