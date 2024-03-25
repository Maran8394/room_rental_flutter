import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_rental/blocs/application/application_bloc.dart';
import 'package:room_rental/models/response_models/notifications_model.dart';
import 'package:room_rental/screens/index_page.dart';
import 'package:room_rental/utils/constants/branding_colors.dart';
import 'package:room_rental/utils/constants/methods.dart';
import 'package:room_rental/utils/constants/routes.dart';
import 'package:room_rental/utils/constants/styles.dart';
import 'package:room_rental/widgets/month_dropdown.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String? selectedMonth;
  ApplicationBloc? _bloc;

  @override
  void initState() {
    super.initState();
    selectedMonth = getCurrentMonth();
    _bloc = ApplicationBloc();
    _bloc!.add(GetNotifications(month: selectedMonth));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackButton(color: BrandingColors.primaryColor),
        title: Text(
          "Notifications",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: BrandingColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MonthDropdown(
              selectedMonth: selectedMonth,
              size: size,
              height: size.height / 20,
              width: size.width / 4,
              onChanged: (val) {
                setState(() {
                  selectedMonth = val;
                });
                _bloc!.add(GetNotifications(month: val!.toLowerCase()));
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<ApplicationBloc, ApplicationState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is GetNotificationsFailedState) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is GetNotificationsDoneState) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: List.generate(
                state.responseData.notifications!.length,
                (index) {
                  NotificationModel model =
                      state.responseData.notifications!.elementAt(index);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 0,
                      color: BrandingColors.containerBorderColor,
                      child: ListTile(
                        dense: true,
                        leading: const Icon(
                          Icons.build_rounded,
                          color: BrandingColors.primaryColor,
                        ),
                        title: Text(
                          model.title!,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        subtitle: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.indexPage,
                              arguments: const IndexingPage(
                                selectedIndex: 1,
                              ),
                            ).then((value) {
                              _bloc!
                                  .add(GetNotifications(month: selectedMonth!));
                            });
                          },
                          child: Text(
                            model.message!,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: BrandingColors.listTileTitleColor
                                          .withOpacity(0.6),
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
