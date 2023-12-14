import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_trivia/features/num_trivia/presentation/controllers/number_trivia_controller.dart';
import 'package:number_trivia/features/num_trivia/presentation/widgets/loading_widget.dart';
import 'package:number_trivia/features/num_trivia/presentation/widgets/message_display.dart';
import 'package:number_trivia/features/num_trivia/presentation/widgets/trivia_controls.dart';
import 'package:number_trivia/features/num_trivia/presentation/widgets/trivia_display.dart';


class NumberTriviaPage extends GetView<NumberTriviaController> {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            GetBuilder<NumberTriviaController>(
              builder: (controller) => _handleView(controller),
            ),
            const SizedBox(height: 20),
            const TriviaControls()
          ],
        ),
      ),
    );
  }

  Widget _handleView(NumberTriviaController controller) {
    return controller.obx(
      (state) => TriviaDisplay(numberTrivia: state!),
      onEmpty: const MessageDisplay(message: 'Start searching!'),
      onLoading: const LoadingWidget(),
      onError: (error) => MessageDisplay(message: error ?? ''),
    );
  }
}
