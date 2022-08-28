import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:prspy/models/player.dart';
import 'package:prspy/models/server.dart';
import 'package:prspy/widgets/custom_player_list.dart';
import 'package:prspy/widgets/custom_server_information_drawer.dart';
import 'package:prspy/widgets/custom_team_tab.dart';

///
///
///
class ServerDetailScreen extends StatefulWidget {
  final Server server;

  ///
  ///
  ///
  const ServerDetailScreen({required this.server, Key? key}) : super(key: key);

  ///
  ///
  ///
  @override
  State<ServerDetailScreen> createState() => _ServerDetailScreenState();
}

///
///
///
class _ServerDetailScreenState extends State<ServerDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: CustomServerInformationDrawer(
          server: widget.server,
        ),
        appBar: AppBar(
          leadingWidth: 30,
          leading: const BackButton(),
          title: SizedBox(
            height: !kIsWeb ? AppBar().preferredSize.height : null,
            child: !kIsWeb
                ? Marquee(
                    text: widget.server.properties.hostname,
                    blankSpace: 150,
                    numberOfRounds: 1,
                  )
                : Text(
                    widget.server.properties.hostname,
                  ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              CustomTeamTab(
                faction: widget.server.properties.map.faction2,
                totalPlayers: widget.server.players
                    .where((Player player) => player.team == 2)
                    .length,
              ),
              CustomTeamTab(
                faction: widget.server.properties.map.faction1,
                totalPlayers: widget.server.players
                    .where((Player player) => player.team == 1)
                    .length,
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            CustomPlayerList(
              players: widget.server.players
                  .where((Player player) => player.team == 2)
                  .toList(),
            ),
            CustomPlayerList(
              players: widget.server.players
                  .where((Player player) => player.team == 1)
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
