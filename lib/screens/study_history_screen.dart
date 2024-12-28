import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'package:flashcard_forge_app/services/repositories/study_session.dart';
import 'package:flashcard_forge_app/widgets/DrawerMenu.dart';
import 'package:flashcard_forge_app/widgets/StudySessionCard.dart';
import 'package:flashcard_forge_app/widgets/CustomSearchBar.dart';
import 'package:flutter/material.dart';

class StudyHistoryScreen extends StatefulWidget {
  const StudyHistoryScreen({super.key});

  @override
  State<StudyHistoryScreen> createState() => _StudyHistoryScreenState();
}

class _StudyHistoryScreenState extends State<StudyHistoryScreen> {
  bool isSearching = false;
  int offset = 0;
  int limit = 15;
  bool hasMore = true;
  bool isLoadingMore = false;
  bool isLoading = false;

  List<StudySessionModel> studyHistory = [];

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
    });
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  bool isSessionDuplicate(StudySessionModel newSession) {
    return studyHistory.any((session) => session.id == newSession.id);
  }

  Future<void> getStudyHistory({bool requestMore = false, bool isRefresh = false, String searchTerm = ""}) async {
    if (!isRefresh && (isLoading || isLoadingMore || !hasMore)) return;

    if (isRefresh) {
      setState(() {
        studyHistory.clear();
        offset = 0;
        limit = 15;
        hasMore = true;
      });
      setLoading(true);
    } else if (requestMore) {
      setState(() {
        isLoadingMore = true;
      });
    } else {
      setLoading(true);
    }

    try {
      List<StudySessionModel>? newSessions = await StudySessionRepository().fetchStudyHistory(limit, offset, searchTerm);
      
      if (newSessions != null && newSessions.isNotEmpty) {
        setState(() {
          studyHistory.addAll(newSessions.where((newSession) => !isSessionDuplicate(newSession)).toList());
          offset += limit;
        });

        if (newSessions.length < limit) {
          setState(() => hasMore = false);
        }
      } else {
        setState(() => hasMore = false);
      }
    } catch (e) {
      //se acontecer um erro lanço um modal aqui
    } finally {
      setLoading(false);
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStudyHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: Theme.of(context).textTheme.bodyMedium!.color,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text("Study History", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _toggleSearch,
            icon: Icon(Icons.search, size: 25, color: Theme.of(context).textTheme.bodyMedium!.color)
          )
        ],
      ),
      drawer: const DrawerMenu(),
      body: Column(
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isSearching
                ? SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: CustomSearchBar(
                        label: "Search a topic",
                        onSearchChanged: (value) {
                          getStudyHistory(isRefresh: true, searchTerm: value);
                        },
                      ),
                  ),
                )
                : const SizedBox.shrink()
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: studyHistory.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Visibility(
                    visible: !isSearching,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Past study sessions",
                        style: TextStyle(fontSize: 19),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  final studySession = studyHistory[index - 1];

                  BorderRadius borderRadius;
                  Border border;

                  if (studyHistory.length == 1) {
                    // Caso com apenas um registro
                    borderRadius = BorderRadius.circular(10); // Bordas completamente arredondadas
                    border = Border.all(color: Colors.blueGrey, width: 0.5);
                  } else if (index == 1) {
                    // Primeiro item
                    borderRadius = const BorderRadius.vertical(top: Radius.circular(10));
                    border = Border.all(color: Colors.blueGrey, width: 0.5);
                  } else if (index == studyHistory.length) {
                    // Último item
                    borderRadius = const BorderRadius.vertical(bottom: Radius.circular(10));
                    border = const Border(
                      left: BorderSide(color: Colors.blueGrey, width: 0.5),
                      right: BorderSide(color: Colors.blueGrey, width: 0.5),
                      bottom: BorderSide(color: Colors.blueGrey, width: 0.5),
                    );
                  } else {
                    // Itens intermediários
                    borderRadius = BorderRadius.zero;
                    border = const Border(
                      left: BorderSide(color: Colors.blueGrey, width: 0.5),
                      right: BorderSide(color: Colors.blueGrey, width: 0.5),
                      bottom: BorderSide(color: Colors.blueGrey, width: 0.5),
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      border: border,
                      borderRadius: borderRadius,
                    ),
                    child: StudySessionCard(session: studySession),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
