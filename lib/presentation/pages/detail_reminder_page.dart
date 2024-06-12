// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app_challenge/core/themes/app_colors.dart';
import 'package:reminder_app_challenge/core/themes/app_textstyles.dart';
import 'package:reminder_app_challenge/data/models/reminder_model.dart';
import 'package:reminder_app_challenge/domain/entities/reminder.dart';
import 'package:reminder_app_challenge/presentation/blocs/cubit/detail_reminder_cubit.dart';
import 'package:reminder_app_challenge/presentation/blocs/cubit/reminder_cubit.dart';

class DetailReminderPage extends StatefulWidget {
  const DetailReminderPage({super.key, this.existingReminder});
  final Reminder? existingReminder;

  @override
  State<DetailReminderPage> createState() => _DetailReminderPageState();
}

class _DetailReminderPageState extends State<DetailReminderPage> {
  @override
  void initState() {
    context.read<DetailReminderCubit>().loadReminder(widget.existingReminder ??
        Reminder(id: DateTime.now().toString(), title: '', description: '', time: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingReminder != null ? 'Details Reminder' : 'Add Reminder'),
        backgroundColor: AppColors.black,
        foregroundColor: Colors.white,
        titleTextStyle: AppTextStyles.title.copyWith(fontSize: 20),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            iconSize: 24,
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pop();
              context.read<ReminderCubit>().loadReminders();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              iconSize: 24,
              padding: EdgeInsets.zero,
              onPressed: () async {
                await context.read<DetailReminderCubit>().updateReminder();
                Navigator.pop(context);
                context.read<ReminderCubit>().loadReminders();
              },
              icon: const Icon(Icons.check_rounded),
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColors.primary),
                  foregroundColor: MaterialStatePropertyAll(AppColors.black)),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xff1D2228),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: BlocBuilder<DetailReminderCubit, Reminder>(
              builder: (context, state) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: widget.existingReminder != null
                              ? TimeOfDay.fromDateTime(widget.existingReminder!.time)
                              : TimeOfDay.now(),
                        );
                        if (time != null) {
                          // context.read<ReminderCubit>().updateTime(time.format(context));
                          context.read<DetailReminderCubit>().updateReminderForm(
                                state.copyWith(
                                  time: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    time.hour,
                                    time.minute,
                                  ),
                                ),
                              );
                        }
                      },
                      child: IgnorePointer(
                        child: ListTile(
                          tileColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          leading: const Icon(Icons.more_time_rounded),
                          title: Text(
                            'Select Time (${state.time.hour}:${state.time.minute.toString().length == 1 ? "0${state.time.minute}" : "${state.time.minute}"})',
                            style: AppTextStyles.title.copyWith(color: AppColors.black),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: RepeatInterval.values
                          .map(
                            (e) => ActionChip.elevated(
                              backgroundColor:
                                  state.repeatInterval.name == e.name ? AppColors.oranye : AppColors.lightGrey,
                              label: Text(
                                e.name,
                                style: AppTextStyles.body.copyWith(
                                  color: state.repeatInterval.name == e.name ? AppColors.white : AppColors.black,
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<DetailReminderCubit>()
                                    .updateReminderForm(state.copyWith(repeatInterval: e));
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), color: AppColors.white.withOpacity(.05)),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        children: [
                          TextField(
                            controller: context.read<DetailReminderCubit>().titleController,
                            cursorColor: AppColors.primary,
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Title', hintStyle: AppTextStyles.bodyMd),
                            onChanged: (value) {
                              context.read<DetailReminderCubit>().titleController.text = value;
                              context.read<DetailReminderCubit>().updateReminderForm(state.copyWith(title: value));
                            },
                          ),
                          const Divider(),
                          TextField(
                            controller: context.read<DetailReminderCubit>().descriptionController,
                            cursorColor: AppColors.primary,
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.white.withOpacity(.4)),
                            minLines: 2,
                            maxLines: 8,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add description...',
                              hintStyle: AppTextStyles.bodyMd.copyWith(
                                color: AppColors.grey.withOpacity(.4),
                              ),
                            ),
                            // expands: true,
                            onChanged: (value) {
                              context.read<DetailReminderCubit>().descriptionController.text = value;
                              context
                                  .read<DetailReminderCubit>()
                                  .updateReminderForm(state.copyWith(description: value));
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            )),
      ),
    );
  }
}
