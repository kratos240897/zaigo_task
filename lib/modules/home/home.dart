import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaigo_task/bloc/home/home_bloc.dart';
import 'package:zaigo_task/core/base_screen.dart';
import 'package:zaigo_task/data/models/lawyers_reponse.dart';
import 'package:zaigo_task/helpers/utils.dart';

class Home extends BaseScreen {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends BaseScreenState<Home> {
  late HomeBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.stream.listen(_blocListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.add(HomeFetchDataEvent());
    });
    super.initState();
  }

  void _blocListener(HomeState state) {
    if (state is! HomeLoadingState) {
      hideLoading(context);
    }
    if (state is HomeLoadingState) {
      showLoading(context);
    } else if (state is HomeFailedState) {
      showSnackBar('Oops!', state.message, context, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: Column(
          children: [
            _headerInfo(context),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadedState) {
                  return _lawyerList(state);
                }
                return Container();
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: _bottomButtons(context),
    );
  }

  Widget _lawyerList(HomeLoadedState state) {
    return Expanded(
        child: ListView.builder(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
      itemCount: state.lawyers.length,
      itemBuilder: (context, index) {
        final lawyer = state.lawyers[index];
        return _lawyerDetailItem(lawyer, context);
      },
    ));
  }

  Widget _lawyerDetailItem(Data lawyer, BuildContext context) {
    return Container(
      height: height * 0.18,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.note_alt_rounded,
                color: Colors.grey.shade700,
              ),
              hSpace(4.0),
              Text(
                'Order ID: ${lawyer.id}',
                style: TextStyle(
                    color: Colors.grey.shade700, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Icon(
                Icons.access_time_filled,
                color: Colors.grey.shade700,
              ),
              hSpace(4.0),
              Text(
                lawyer.hoursLogged.isNotEmpty
                    ? lawyer.hoursLogged
                    : '9:30AM to 11:30 PM',
                style: TextStyle(
                    color: Colors.grey.shade700, fontWeight: FontWeight.w600),
              )
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSpace(12.0),
                  Text(
                    lawyer.name.isNotEmpty ? lawyer.name : 'Unknown',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  vSpace(4.0),
                  Text(
                    lawyer.address.isNotEmpty ? lawyer.address : 'Unknown',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16.0,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 50.0,
                height: 55.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor),
                child: const Icon(
                  Icons.phone_in_talk_rounded,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 4.0, 4.0, 4.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey.shade300,
            ),
          ),
          Row(
            children: [
              Container(
                color: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: const Text(
                  'STATUS',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              hSpace(4.0),
              const Text(
                'Dispatched',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const Spacer(),
              Icon(
                Icons.business_outlined,
                size: 25.0,
                color: Theme.of(context).primaryColor,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 70.0,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 70.0,
                  alignment: Alignment.center,
                  color: Colors.green,
                  child: Text('Optimize Route',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 70.0,
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text('Reset',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _headerInfo(BuildContext context) {
    return Column(
      children: [
        vSpace(8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const Text('Destination Zip Code: '),
              hSpace(2.0),
              Text(
                '25949',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    shadows: [
                      Shadow(
                          color: Theme.of(context).primaryColor,
                          offset: const Offset(0, -2))
                    ],
                    fontSize: 14.0,
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 1,
                    decorationStyle: TextDecorationStyle.solid),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Bulk Dispatch',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      shadows: [
                        Shadow(
                            color: Theme.of(context).primaryColor,
                            offset: const Offset(0, -2))
                      ],
                      fontSize: 14.0,
                      color: Colors.transparent,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).primaryColor,
                      decorationThickness: 1,
                      decorationStyle: TextDecorationStyle.solid),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      centerTitle: true,
      title: const Text('ECommerce'),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 60.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Select Date and Time',
                hintStyle: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 16.0),
                prefixIcon: const Icon(Icons.calendar_month),
                suffixIcon: const Icon(Icons.equalizer_rounded),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
