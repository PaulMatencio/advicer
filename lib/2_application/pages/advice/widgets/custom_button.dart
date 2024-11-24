
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final int ? id ;
  final Function() ? onTap;
  const CustomButton({super.key,required this.id,this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      // !  onTap: () => BlocProvider.of<AdvicerCubit>(context).adviceRequested(id),
      //onTap : onTap?.call(),
      onTap: onTap?.call,
      // ! onTap: () => BlocProvider.of<AdvicerBloc>(context).add(AdviceRequestedEvent()),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: themeData.colorScheme.primaryContainer
              ),
              color: themeData.colorScheme.secondary),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              'Get Advice',
             // style: themeData.textTheme.headline1,
             //!  for golden test ->  style: themeData.textTheme.headlineSmall?.copyWith(color:Colors.yellow),
             //!        -->  copy the themeData and change the color
             // ! style: themeData.textTheme.headlineSmall,
              style: themeData.textTheme.headlineSmall?.copyWith(color:
              onTap == null ? Colors.grey:Theme.of(context).colorScheme.primaryFixed),
            ),
          ),
        ),
      ),
    );
  }
}

