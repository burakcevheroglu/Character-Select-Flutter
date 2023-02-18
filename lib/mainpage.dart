import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final statusProvider = StateProvider<Status>((ref) => Status.first);

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${ref.watch(statusProvider)}'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: 300,
          color: Colors.grey,
          child: Stack(
            clipBehavior: Clip.none,
            children: charStatus(ref.watch(statusProvider))
          ),
        ),
      ),
    );
  }
}

class CharItemWidget extends StatelessWidget {
  const CharItemWidget({
    super.key, required this.placement, required this.char,
  });
  
  final Placement placement;
  final Characters char;
  

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      key: ValueKey(char),
      alignment: charPlacement(placement),
      duration: _duration,
      child: Container(
        width: charSize(placement),
        height: charSize(placement),
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: charEffect(placement),
                image: character(char))),
      ),
    );
  }
}

enum Placement { first, second, third, fourth}
enum Characters { char1, char2, char3, char4}
enum Status { first, second, third, fourth}
const _duration = Duration(milliseconds: 300);

AssetImage character(Characters char){
  switch(char){
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
AlignmentGeometry charPlacement(Placement placement){
  switch(placement) {
    case Placement.first:
      return Alignment.bottomCenter;
    case Placement.second:
      return Alignment.centerRight;
    case Placement.third:
      return Alignment.centerLeft;
    case Placement.fourth:
      return Alignment.topCenter;
  }
}
double charSize(Placement placement){
  switch(placement) {
    case Placement.first:
      return 200;
    case Placement.second:
      return 130;
    case Placement.third:
      return 130;
    case Placement.fourth:
      return 110;
  }
}
ColorFilter? charEffect(Placement placement){
  switch(placement) {
    case Placement.first:
      return null;
    case Placement.second:
      return ColorFilter.mode(Colors.white.withAlpha(200), BlendMode.modulate);
    case Placement.third:
      return ColorFilter.mode(Colors.white.withAlpha(200), BlendMode.modulate);
    case Placement.fourth:
      return ColorFilter.mode(Colors.white.withAlpha(150), BlendMode.modulate);
  }
}
List<Widget> charStatus(Status status){
  switch(status){
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




class BottomButtons extends ConsumerWidget {
  const BottomButtons({
    super.key, required this.bottom
  });

  final double bottom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
        bottom: bottom,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                ref.read(statusProvider.notifier).update((state) => Status.first);
              }, child: const Text('1')),
              ElevatedButton(onPressed: (){
                ref.read(statusProvider.notifier).update((state) => Status.second);
              }, child: const Text('2')),
              ElevatedButton(onPressed: (){
                ref.read(statusProvider.notifier).update((state) => Status.third);
              }, child: const Text('3')),
              ElevatedButton(onPressed: (){
                ref.read(statusProvider.notifier).update((state) => Status.fourth);
              }, child: const Text('4'))
      ],
    ),
        ));
  }
}

class CharacterLines{
  List<Widget> first = const [
    CharItemWidget(placement: Placement.fourth, char: Characters.char4),
    CharItemWidget(placement: Placement.third, char: Characters.char3),
    CharItemWidget(placement: Placement.second, char: Characters.char2),
    CharItemWidget(placement: Placement.first, char: Characters.char1),
    BottomButtons(bottom: -100,)
  ];

  List<Widget> second = const [
    CharItemWidget(placement: Placement.fourth, char: Characters.char3),
    CharItemWidget(placement: Placement.third, char: Characters.char2),
    CharItemWidget(placement: Placement.second, char: Characters.char1),
    CharItemWidget(placement: Placement.first, char: Characters.char4),
    BottomButtons(bottom: -100,)
  ];

  List<Widget> third = const [
    CharItemWidget(placement: Placement.fourth, char: Characters.char2),
    CharItemWidget(placement: Placement.third, char: Characters.char1),
    CharItemWidget(placement: Placement.second, char: Characters.char4),
    CharItemWidget(placement: Placement.first, char: Characters.char3),
    BottomButtons(bottom: -100,)
  ];

  List<Widget> fourth = const [
    CharItemWidget(placement: Placement.fourth, char: Characters.char1),
    CharItemWidget(placement: Placement.third, char: Characters.char4),
    CharItemWidget(placement: Placement.second, char: Characters.char3),
    CharItemWidget(placement: Placement.first, char: Characters.char2),
    BottomButtons(bottom: -100,)
  ];

}
