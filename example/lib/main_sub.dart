import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/01/02
///

void main() {
  const tooltipContent = Text(
    'Hola Mundo!',
    style: TextStyle(color: Colors.white),
    textAlign: TextAlign.center,
  );

  const tooltipIcon = Icon(
    Icons.info,
    color: Color(0XFFA5A53A),
  );

  runApp(
    MaterialApp(
      title: 'ElTooltip Sub Navigator Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0XFFA5A53A)),
        scaffoldBackgroundColor: const Color(0XFFFFF8C7),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('ElTooltip Sub Navigator Demo')),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 80,
              ),
              Expanded(
                  child: Navigator(
                onDidRemovePage: (page) {},
                pages: [
                  MaterialPage(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ElTooltip(
                            content: tooltipContent,
                            color: const Color(0XFFEA4747),
                            showModal: false,
                            child: tooltipIcon,
                            arrowWrapBuilder: (context, child) {
                              return Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 2),
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: child!,
                              );
                            },
                            contentWrapBuilder: (context, child) {
                              return Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(1, 2),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: child!,
                              );
                            },
                          ),
                          const Spacer(),
                          const ElTooltip(
                            content: tooltipContent,
                            color: Color(0XFFEA4747),
                            child: tooltipIcon,
                          ),
                          const Spacer(),
                          const ElTooltip(
                            content: tooltipContent,
                            color: Color(0XFFEA4747),
                            child: tooltipIcon,
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          ElTooltip(
                            content: tooltipContent,
                            color: Color(0XFFEA4747),
                            child: tooltipIcon,
                          ),
                          Spacer(),
                          ElTooltip(
                            content: tooltipContent,
                            color: Color(0XFFEA4747),
                            child: tooltipIcon,
                          ),
                          Spacer(),
                          ElTooltip(
                            content: tooltipContent,
                            color: Color(0XFFEA4747),
                            child: tooltipIcon,
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          ElTooltip(
                            content: tooltipContent,
                            color: Color(0XFFEA4747),
                            child: tooltipIcon,
                          ),
                          Spacer(),
                          ElTooltip(
                            content: tooltipContent,
                            color: Color(0XFFEA4747),
                            child: tooltipIcon,
                          ),
                          Spacer(),
                          ElTooltip(
                            content: tooltipContent,
                            color: Color(0XFFEA4747),
                            child: tooltipIcon,
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              )),
            ],
          ),
        ),
      ),
    ),
  );
}
