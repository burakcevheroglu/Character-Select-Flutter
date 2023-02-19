import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final statusProvider = StateProvider<Status>((ref) => Status.first);
final isAnimate = StateProvider<bool>((ref) => false);
final isSelected = StateProvider<bool>((ref) => false);

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.read(statusProvider).toString()),
      ),
      body: Column(
        children: [
           Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 250,
            color: Colors.grey,
            child:Stack(children: (!ref.watch(isSelected)) ? charStatus(ref.watch(statusProvider))
                : [CharItemWidget(
                placement: Placement.none,
                char: statusToCharacter(ref.read(statusProvider))),]
            )
          ),
          const SizedBox(
            height: 100,
          ),
          (!ref.watch(isSelected)) ?  BottomButtons()
          :ElevatedButton(
            onPressed: () {
              ref.read(isSelected.notifier).update((state) => false);
            },
            child: const Icon(Icons.refresh),
          )
          ,
        ],
      )
    );
  }
}

class CharItemWidget extends StatelessWidget {
  const CharItemWidget({
    super.key,
    required this.placement,
    required this.char,
  });

  final Placement placement;
  final Characters char;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      key: ValueKey(char),
      duration: _duration,
      curve: Curves.easeInBack,
      alignment: charPlacement(placement),
      child: AnimatedContainer(
        duration: _duration,
        width: charSize(placement),
        height: charSize(placement),
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: charEffect(placement), image: character(char))),
      ),
    );
  }
}

enum Placement { first, second, third, fourth, none}

enum Characters { char1, char2, char3, char4 }

enum Status { first, second, third, fourth }

const _duration = Duration(milliseconds: 500);

AssetImage character(Characters char) {
  switch (char) {
    case Characters.char1:
      return const AssetImage("assets/char1.png");
    case Characters.char2:
      return const AssetImage("assets/char2.png");
    case Characters.char3:
      return const AssetImage("assets/char3.png");
    case Characters.char4:
      return const AssetImage("assets/char4.png");
  }
}

AlignmentGeometry charPlacement(Placement placement) {
  switch (placement) {
    case Placement.first:
      return Alignment.bottomCenter;
    case Placement.second:
      return Alignment.centerRight;
    case Placement.third:
      return Alignment.topCenter;
    case Placement.fourth:
      return Alignment.centerLeft;
    case Placement.none:
      return Alignment.center;
  }
}

double charSize(Placement placement) {
  switch (placement) {
    case Placement.first:
      return 200;
    case Placement.second:
      return 130;
    case Placement.third:
      return 110;
    case Placement.fourth:
      return 130;
    case Placement.none:
      return 250;
  }
}

ColorFilter? charEffect(Placement placement) {
  switch (placement) {
    case Placement.first:
      return null;
    case Placement.second:
      return ColorFilter.mode(Colors.white.withAlpha(200), BlendMode.modulate);
    case Placement.third:
      return ColorFilter.mode(Colors.white.withAlpha(200), BlendMode.modulate);
    case Placement.fourth:
      return ColorFilter.mode(Colors.white.withAlpha(150), BlendMode.modulate);
    case Placement.none:
      return null;

  }
}

List<Widget> charStatus(Status status) {
  switch (status) {
    case Status.first:
      return CharacterLines().first;
    case Status.second:
      return CharacterLines().second;
    case Status.third:
      return CharacterLines().third;
    case Status.fourth:
      return CharacterLines().fourth;
  }
}

Characters statusToCharacter(Status status) {
  switch (status) {
    case Status.first:
      return Characters.char1;
    case Status.second:
      return Characters.char4;
    case Status.third:
      return Characters.char3;
    case Status.fourth:
      return Characters.char2;
  }
}

class BottomButtons extends ConsumerWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () {
                if (ref.read(statusProvider) != Status.first) {
                  ref
                      .read(statusProvider.notifier)
                      .update((state) => Status.first);
                } else {
                  ref.read(isSelected.notifier).update((state) => true);
                }
              },
              child: const Text('1')),
          ElevatedButton(
              onPressed: () {
                if (ref.read(statusProvider) != Status.second) {
                  ref
                      .read(statusProvider.notifier)
                      .update((state) => Status.second);
                } else {
                  ref.read(isSelected.notifier).update((state) => true);
                }
              },
              child: const Text('2')),
          ElevatedButton(
              onPressed: () {
                if (ref.read(statusProvider) != Status.third) {
                  ref
                      .read(statusProvider.notifier)
                      .update((state) => Status.third);
                } else {
                  ref.read(isSelected.notifier).update((state) => true);
                }
              },
              child: const Text('3')),
          ElevatedButton(
              onPressed: () {
                if (ref.read(statusProvider) != Status.fourth) {
                  ref
                      .read(statusProvider.notifier)
                      .update((state) => Status.fourth);
                } else {
                  ref.read(isSelected.notifier).update((state) => true);
                }
              },
              child: const Text('4'))
        ],
      ),
    );
  }
}

class CharacterLines2 {
  List<Widget> first = const [
    CharItemWidget(placement: Placement.fourth, char: Characters.char4),
    CharItemWidget(placement: Placement.third, char: Characters.char3),
    CharItemWidget(placement: Placement.second, char: Characters.char2),
    CharItemWidget(placement: Placement.first, char: Characters.char1),
  ];

  List<Widget> second = const [
    CharItemWidget(placement: Placement.fourth, char: Characters.char3),
    CharItemWidget(placement: Placement.third, char: Characters.char2),
    CharItemWidget(placement: Placement.second, char: Characters.char1),
    CharItemWidget(placement: Placement.first, char: Characters.char4),
  ];

  List<Widget> third = const [
    CharItemWidget(placement: Placement.fourth, char: Characters.char2),
    CharItemWidget(placement: Placement.third, char: Characters.char1),
    CharItemWidget(placement: Placement.second, char: Characters.char4),
    CharItemWidget(placement: Placement.first, char: Characters.char3),
  ];

  List<Widget> fourth = const [
    CharItemWidget(placement: Placement.fourth, char: Characters.char1),
    CharItemWidget(placement: Placement.third, char: Characters.char4),
    CharItemWidget(placement: Placement.second, char: Characters.char3),
    CharItemWidget(placement: Placement.first, char: Characters.char2),
  ];
}

class CharacterLines {
  List<Widget> first = const [
    CharItemWidget(placement: Placement.fourth, char: Characters.char4),
    CharItemWidget(placement: Placement.third, char: Characters.char3),
    CharItemWidget(placement: Placement.second, char: Characters.char2),
    CharItemWidget(placement: Placement.first, char: Characters.char1),
  ];

  List<Widget> second = const [
    CharItemWidget(placement: Placement.first, char: Characters.char4),
    CharItemWidget(placement: Placement.fourth, char: Characters.char3),
    CharItemWidget(placement: Placement.third, char: Characters.char2),
    CharItemWidget(placement: Placement.second, char: Characters.char1),
  ];

  List<Widget> third = const [
    CharItemWidget(placement: Placement.second, char: Characters.char4),
    CharItemWidget(placement: Placement.first, char: Characters.char3),
    CharItemWidget(placement: Placement.fourth, char: Characters.char2),
    CharItemWidget(placement: Placement.third, char: Characters.char1),
  ];

  List<Widget> fourth = const [
    CharItemWidget(placement: Placement.third, char: Characters.char4),
    CharItemWidget(placement: Placement.second, char: Characters.char3),
    CharItemWidget(placement: Placement.first, char: Characters.char2),
    CharItemWidget(placement: Placement.fourth, char: Characters.char1),
  ];
}
