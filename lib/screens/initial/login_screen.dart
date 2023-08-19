import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/login_screen_controller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LoginScreenController>(context,listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<LoginScreenController>(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: 360,
          height: 466,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromRGBO(0, 0, 0, 0.125),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Form(
            key: controller.key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   height: 4,
                //   decoration: BoxDecoration(
                //     color: Colors.blue,
                //     // borderRadius: BorderRadius.circular(16),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'My Grocery',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Sign in to start your session',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                controller.codeSend == false
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controller.emailTED,
                              validator: controller.validateEmailFields,
                              onSaved: controller.saveEmail,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                isDense: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.125),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                suffixIcon: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.125),
                                      ),
                                    ),
                                  ),
                                  child: const Icon(Icons.email),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controller.phoneNoTED,
                              keyboardType: TextInputType.number,
                              validator: controller.validatePhoneNoFields,
                              onSaved: controller.savePhoneNo,
                              decoration: InputDecoration(
                                hintText: 'Phone-No',
                                isDense: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.125),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                suffixIcon: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.125),
                                      ),
                                    ),
                                  ),
                                  child: const Icon(Icons.phone),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    'We will send code to this phone-no to verify you',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (controller.isWeb) {
                                      controller.onSendCodeWeb(context);
                                    } else {
                                      controller.onSendCodeMobile();
                                    }
                                  },
                                  child: const Text('send code'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      )
                    : const SizedBox(),
                controller.codeSend
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controller.smsCodeTED,
                              keyboardType: TextInputType.number,
                              validator: controller.validateSmsCode,
                              onSaved: controller.savePhoneNo,
                              decoration: InputDecoration(
                                hintText: 'SMS Code',
                                isDense: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.125),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                suffixIcon: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.125),
                                      ),
                                    ),
                                  ),
                                  child: const Icon(Icons.code),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Enter code send to your moblie number here',
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: controller.isSelected,
                                        onChanged: (v) {
                                          controller.onCheckBoxButtonClicked();
                                        }),
                                    Text(
                                      'Remember Me',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (controller.isWeb) {
                                      controller.onVerifyCodeWeb(context);
                                    } else {
                                      controller.onVerifyCodeMobile(context);
                                    }
                                  },
                                  child: const Text('Verify'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          controller.isLoading
                              ? Column(
                                  children: const [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text('Loading please wait')
                                  ],
                                )
                              : controller.error == ''
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            controller.error,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                        ],
                      )
                    : const SizedBox()

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Checkbox(
                //               value: controller.isSelected,
                //               onChanged: (v) {
                //                 controller.onCheckBoxButtonClicked();
                //               }),
                //           Text(
                //             'Remember Me',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .bodyText1!
                //                 .copyWith(fontWeight: FontWeight.w700),
                //           )
                //         ],
                //       ),
                //       ElevatedButton(
                //         onPressed: () => controller.login(context),
                //         child: const Text('Sign In'),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
