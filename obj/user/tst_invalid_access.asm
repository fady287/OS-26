
obj/user/tst_invalid_access:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 74 02 00 00       	call   8002aa <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

#include <inc/lib.h>
extern volatile bool printStats;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
	printStats = 0;
  800044:	c7 05 00 30 80 00 00 	movl   $0x0,0x803000
  80004b:	00 00 00 

	int eval = 0;
  80004e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	cprintf_colored(TEXT_cyan, "%~PART I: Test the Pointer Validation inside fault_handler(): [70%]\n");
  800055:	83 ec 08             	sub    $0x8,%esp
  800058:	68 60 1f 80 00       	push   $0x801f60
  80005d:	6a 03                	push   $0x3
  80005f:	e8 b3 05 00 00       	call   800617 <cprintf_colored>
  800064:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_cyan, "%~=================================================================\n");
  800067:	83 ec 08             	sub    $0x8,%esp
  80006a:	68 a8 1f 80 00       	push   $0x801fa8
  80006f:	6a 03                	push   $0x3
  800071:	e8 a1 05 00 00       	call   800617 <cprintf_colored>
  800076:	83 c4 10             	add    $0x10,%esp
	rsttst();
  800079:	e8 e0 17 00 00       	call   80185e <rsttst>
	int ID1 = sys_create_env("tia_slave1", (myEnv->page_WS_max_size), (myEnv->page_2nd_WS_size),(myEnv->percentage_of_WS_pages_to_be_removed));
  80007e:	a1 20 30 80 00       	mov    0x803020,%eax
  800083:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  800089:	a1 20 30 80 00       	mov    0x803020,%eax
  80008e:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  800094:	a1 20 30 80 00       	mov    0x803020,%eax
  800099:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  80009f:	51                   	push   %ecx
  8000a0:	52                   	push   %edx
  8000a1:	50                   	push   %eax
  8000a2:	68 ed 1f 80 00       	push   $0x801fed
  8000a7:	e8 9c 16 00 00       	call   801748 <sys_create_env>
  8000ac:	83 c4 10             	add    $0x10,%esp
  8000af:	89 45 e0             	mov    %eax,-0x20(%ebp)
	sys_run_env(ID1);
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	ff 75 e0             	pushl  -0x20(%ebp)
  8000b8:	e8 a9 16 00 00       	call   801766 <sys_run_env>
  8000bd:	83 c4 10             	add    $0x10,%esp

	int ID2 = sys_create_env("tia_slave2", (myEnv->page_WS_max_size), (myEnv->page_2nd_WS_size),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c5:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8000cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d0:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  8000d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8000db:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  8000e1:	51                   	push   %ecx
  8000e2:	52                   	push   %edx
  8000e3:	50                   	push   %eax
  8000e4:	68 f8 1f 80 00       	push   $0x801ff8
  8000e9:	e8 5a 16 00 00       	call   801748 <sys_create_env>
  8000ee:	83 c4 10             	add    $0x10,%esp
  8000f1:	89 45 dc             	mov    %eax,-0x24(%ebp)
	sys_run_env(ID2);
  8000f4:	83 ec 0c             	sub    $0xc,%esp
  8000f7:	ff 75 dc             	pushl  -0x24(%ebp)
  8000fa:	e8 67 16 00 00       	call   801766 <sys_run_env>
  8000ff:	83 c4 10             	add    $0x10,%esp

	int ID3 = sys_create_env("tia_slave3", (myEnv->page_WS_max_size), (myEnv->page_2nd_WS_size),(myEnv->percentage_of_WS_pages_to_be_removed));
  800102:	a1 20 30 80 00       	mov    0x803020,%eax
  800107:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  80010d:	a1 20 30 80 00       	mov    0x803020,%eax
  800112:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  800118:	a1 20 30 80 00       	mov    0x803020,%eax
  80011d:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  800123:	51                   	push   %ecx
  800124:	52                   	push   %edx
  800125:	50                   	push   %eax
  800126:	68 03 20 80 00       	push   $0x802003
  80012b:	e8 18 16 00 00       	call   801748 <sys_create_env>
  800130:	83 c4 10             	add    $0x10,%esp
  800133:	89 45 d8             	mov    %eax,-0x28(%ebp)
	sys_run_env(ID3);
  800136:	83 ec 0c             	sub    $0xc,%esp
  800139:	ff 75 d8             	pushl  -0x28(%ebp)
  80013c:	e8 25 16 00 00       	call   801766 <sys_run_env>
  800141:	83 c4 10             	add    $0x10,%esp
	env_sleep(10000);
  800144:	83 ec 0c             	sub    $0xc,%esp
  800147:	68 10 27 00 00       	push   $0x2710
  80014c:	e8 f1 18 00 00       	call   801a42 <env_sleep>
  800151:	83 c4 10             	add    $0x10,%esp

	char isKernPanicCmd[100] = "__IsKernPanic__" ;
  800154:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
  80015a:	bb 93 21 80 00       	mov    $0x802193,%ebx
  80015f:	ba 04 00 00 00       	mov    $0x4,%edx
  800164:	89 c7                	mov    %eax,%edi
  800166:	89 de                	mov    %ebx,%esi
  800168:	89 d1                	mov    %edx,%ecx
  80016a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  80016c:	8d 55 80             	lea    -0x80(%ebp),%edx
  80016f:	b9 15 00 00 00       	mov    $0x15,%ecx
  800174:	b8 00 00 00 00       	mov    $0x0,%eax
  800179:	89 d7                	mov    %edx,%edi
  80017b:	f3 ab                	rep stos %eax,%es:(%edi)
	int isKernPanic = 0;
  80017d:	c7 85 6c ff ff ff 00 	movl   $0x0,-0x94(%ebp)
  800184:	00 00 00 
	sys_utilities(isKernPanicCmd, (uint32)(&isKernPanic));
  800187:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	50                   	push   %eax
  800191:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
  800197:	50                   	push   %eax
  800198:	e8 19 18 00 00       	call   8019b6 <sys_utilities>
  80019d:	83 c4 10             	add    $0x10,%esp
	if (gettst() != 0 || isKernPanic)
  8001a0:	e8 33 17 00 00       	call   8018d8 <gettst>
  8001a5:	85 c0                	test   %eax,%eax
  8001a7:	75 0a                	jne    8001b3 <_main+0x17b>
  8001a9:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8001af:	85 c0                	test   %eax,%eax
  8001b1:	74 14                	je     8001c7 <_main+0x18f>
		cprintf_colored(TEXT_TESTERR_CLR, "\n%~PART I... Failed.\n");
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	68 0e 20 80 00       	push   $0x80200e
  8001bb:	6a 0c                	push   $0xc
  8001bd:	e8 55 04 00 00       	call   800617 <cprintf_colored>
  8001c2:	83 c4 10             	add    $0x10,%esp
  8001c5:	eb 16                	jmp    8001dd <_main+0x1a5>
	else
	{
		cprintf_colored(TEXT_green, "\n%~PART I... completed successfully\n\n");
  8001c7:	83 ec 08             	sub    $0x8,%esp
  8001ca:	68 24 20 80 00       	push   $0x802024
  8001cf:	6a 02                	push   $0x2
  8001d1:	e8 41 04 00 00       	call   800617 <cprintf_colored>
  8001d6:	83 c4 10             	add    $0x10,%esp
		eval += 70;
  8001d9:	83 45 e4 46          	addl   $0x46,-0x1c(%ebp)
	}

	cprintf_colored(TEXT_cyan, "%~PART II: PLACEMENT: Test the Invalid Access to a NON-EXIST page in Page File, Stack & Heap: [30%]\n");
  8001dd:	83 ec 08             	sub    $0x8,%esp
  8001e0:	68 4c 20 80 00       	push   $0x80204c
  8001e5:	6a 03                	push   $0x3
  8001e7:	e8 2b 04 00 00       	call   800617 <cprintf_colored>
  8001ec:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_cyan, "%~=================================================================================================\n");
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	68 b4 20 80 00       	push   $0x8020b4
  8001f7:	6a 03                	push   $0x3
  8001f9:	e8 19 04 00 00       	call   800617 <cprintf_colored>
  8001fe:	83 c4 10             	add    $0x10,%esp

	rsttst();
  800201:	e8 58 16 00 00       	call   80185e <rsttst>
	int ID4 = sys_create_env("tia_slave4", (myEnv->page_WS_max_size), (myEnv->page_2nd_WS_size),(myEnv->percentage_of_WS_pages_to_be_removed));
  800206:	a1 20 30 80 00       	mov    0x803020,%eax
  80020b:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  800211:	a1 20 30 80 00       	mov    0x803020,%eax
  800216:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  80021c:	a1 20 30 80 00       	mov    0x803020,%eax
  800221:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  800227:	51                   	push   %ecx
  800228:	52                   	push   %edx
  800229:	50                   	push   %eax
  80022a:	68 19 21 80 00       	push   $0x802119
  80022f:	e8 14 15 00 00       	call   801748 <sys_create_env>
  800234:	83 c4 10             	add    $0x10,%esp
  800237:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	sys_run_env(ID4);
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	ff 75 d4             	pushl  -0x2c(%ebp)
  800240:	e8 21 15 00 00       	call   801766 <sys_run_env>
  800245:	83 c4 10             	add    $0x10,%esp

	env_sleep(10000);
  800248:	83 ec 0c             	sub    $0xc,%esp
  80024b:	68 10 27 00 00       	push   $0x2710
  800250:	e8 ed 17 00 00       	call   801a42 <env_sleep>
  800255:	83 c4 10             	add    $0x10,%esp

	if (gettst() != 1)
  800258:	e8 7b 16 00 00       	call   8018d8 <gettst>
  80025d:	83 f8 01             	cmp    $0x1,%eax
  800260:	74 14                	je     800276 <_main+0x23e>
		cprintf_colored(TEXT_TESTERR_CLR, "\n%~PART II... Failed.\n");
  800262:	83 ec 08             	sub    $0x8,%esp
  800265:	68 24 21 80 00       	push   $0x802124
  80026a:	6a 0c                	push   $0xc
  80026c:	e8 a6 03 00 00       	call   800617 <cprintf_colored>
  800271:	83 c4 10             	add    $0x10,%esp
  800274:	eb 16                	jmp    80028c <_main+0x254>
	else
	{
		cprintf_colored(TEXT_green, "\n%~PART II... completed successfully\n\n");
  800276:	83 ec 08             	sub    $0x8,%esp
  800279:	68 3c 21 80 00       	push   $0x80213c
  80027e:	6a 02                	push   $0x2
  800280:	e8 92 03 00 00       	call   800617 <cprintf_colored>
  800285:	83 c4 10             	add    $0x10,%esp
		eval += 30;
  800288:	83 45 e4 1e          	addl   $0x1e,-0x1c(%ebp)
	}
	cprintf_colored(TEXT_light_green, "%~\ntest invalid access completed. Eval = %d%\n\n", eval);
  80028c:	83 ec 04             	sub    $0x4,%esp
  80028f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800292:	68 64 21 80 00       	push   $0x802164
  800297:	6a 0a                	push   $0xa
  800299:	e8 79 03 00 00       	call   800617 <cprintf_colored>
  80029e:	83 c4 10             	add    $0x10,%esp

}
  8002a1:	90                   	nop
  8002a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8002a5:	5b                   	pop    %ebx
  8002a6:	5e                   	pop    %esi
  8002a7:	5f                   	pop    %edi
  8002a8:	5d                   	pop    %ebp
  8002a9:	c3                   	ret    

008002aa <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8002aa:	55                   	push   %ebp
  8002ab:	89 e5                	mov    %esp,%ebp
  8002ad:	57                   	push   %edi
  8002ae:	56                   	push   %esi
  8002af:	53                   	push   %ebx
  8002b0:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8002b6:	e8 fb 14 00 00       	call   8017b6 <sys_getenvindex>
  8002bb:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8002be:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002c1:	89 d0                	mov    %edx,%eax
  8002c3:	c1 e0 03             	shl    $0x3,%eax
  8002c6:	01 d0                	add    %edx,%eax
  8002c8:	c1 e0 06             	shl    $0x6,%eax
  8002cb:	01 d0                	add    %edx,%eax
  8002cd:	c1 e0 03             	shl    $0x3,%eax
  8002d0:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002d5:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002da:	a1 20 30 80 00       	mov    0x803020,%eax
  8002df:	8a 40 10             	mov    0x10(%eax),%al
  8002e2:	84 c0                	test   %al,%al
  8002e4:	74 0d                	je     8002f3 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8002e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002eb:	83 c0 10             	add    $0x10,%eax
  8002ee:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002f3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002f7:	7e 0a                	jle    800303 <libmain+0x59>
		binaryname = argv[0];
  8002f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002fc:	8b 00                	mov    (%eax),%eax
  8002fe:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800303:	83 ec 08             	sub    $0x8,%esp
  800306:	ff 75 0c             	pushl  0xc(%ebp)
  800309:	ff 75 08             	pushl  0x8(%ebp)
  80030c:	e8 27 fd ff ff       	call   800038 <_main>
  800311:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800314:	a1 00 30 80 00       	mov    0x803000,%eax
  800319:	85 c0                	test   %eax,%eax
  80031b:	0f 84 b7 01 00 00    	je     8004d8 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800321:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800327:	bb 34 23 80 00       	mov    $0x802334,%ebx
  80032c:	ba 0e 00 00 00       	mov    $0xe,%edx
  800331:	89 c7                	mov    %eax,%edi
  800333:	89 de                	mov    %ebx,%esi
  800335:	89 d1                	mov    %edx,%ecx
  800337:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800339:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80033f:	b9 56 00 00 00       	mov    $0x56,%ecx
  800344:	b0 00                	mov    $0x0,%al
  800346:	89 d7                	mov    %edx,%edi
  800348:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80034a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800351:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800354:	83 ec 08             	sub    $0x8,%esp
  800357:	50                   	push   %eax
  800358:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80035e:	50                   	push   %eax
  80035f:	e8 52 16 00 00       	call   8019b6 <sys_utilities>
  800364:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800367:	e8 d2 11 00 00       	call   80153e <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80036c:	83 ec 0c             	sub    $0xc,%esp
  80036f:	68 10 22 80 00       	push   $0x802210
  800374:	e8 71 02 00 00       	call   8005ea <cprintf>
  800379:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80037c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80037f:	85 c0                	test   %eax,%eax
  800381:	74 58                	je     8003db <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800383:	e8 4c 16 00 00       	call   8019d4 <sys_get_optimal_num_faults>
  800388:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80038b:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800391:	bb 98 23 80 00       	mov    $0x802398,%ebx
  800396:	ba 11 00 00 00       	mov    $0x11,%edx
  80039b:	89 c7                	mov    %eax,%edi
  80039d:	89 de                	mov    %ebx,%esi
  80039f:	89 d1                	mov    %edx,%ecx
  8003a1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8003a3:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8003a6:	b9 53 00 00 00       	mov    $0x53,%ecx
  8003ab:	b0 00                	mov    $0x0,%al
  8003ad:	89 d7                	mov    %edx,%edi
  8003af:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8003b1:	83 ec 08             	sub    $0x8,%esp
  8003b4:	ff 75 dc             	pushl  -0x24(%ebp)
  8003b7:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003bd:	50                   	push   %eax
  8003be:	e8 f3 15 00 00       	call   8019b6 <sys_utilities>
  8003c3:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8003c6:	83 ec 08             	sub    $0x8,%esp
  8003c9:	ff 75 dc             	pushl  -0x24(%ebp)
  8003cc:	68 38 22 80 00       	push   $0x802238
  8003d1:	e8 14 02 00 00       	call   8005ea <cprintf>
  8003d6:	83 c4 10             	add    $0x10,%esp
  8003d9:	eb 59                	jmp    800434 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003db:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e0:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8003e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003eb:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8003f1:	83 ec 04             	sub    $0x4,%esp
  8003f4:	52                   	push   %edx
  8003f5:	50                   	push   %eax
  8003f6:	68 5c 22 80 00       	push   $0x80225c
  8003fb:	e8 ea 01 00 00       	call   8005ea <cprintf>
  800400:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800403:	a1 20 30 80 00       	mov    0x803020,%eax
  800408:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80040e:	a1 20 30 80 00       	mov    0x803020,%eax
  800413:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800419:	a1 20 30 80 00       	mov    0x803020,%eax
  80041e:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800424:	51                   	push   %ecx
  800425:	52                   	push   %edx
  800426:	50                   	push   %eax
  800427:	68 84 22 80 00       	push   $0x802284
  80042c:	e8 b9 01 00 00       	call   8005ea <cprintf>
  800431:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800434:	a1 20 30 80 00       	mov    0x803020,%eax
  800439:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80043f:	83 ec 08             	sub    $0x8,%esp
  800442:	50                   	push   %eax
  800443:	68 dc 22 80 00       	push   $0x8022dc
  800448:	e8 9d 01 00 00       	call   8005ea <cprintf>
  80044d:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800450:	83 ec 0c             	sub    $0xc,%esp
  800453:	68 f0 22 80 00       	push   $0x8022f0
  800458:	e8 8d 01 00 00       	call   8005ea <cprintf>
  80045d:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800460:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800467:	eb 28                	jmp    800491 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800469:	a1 20 30 80 00       	mov    0x803020,%eax
  80046e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800471:	81 c2 74 04 00 00    	add    $0x474,%edx
  800477:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80047a:	83 ec 04             	sub    $0x4,%esp
  80047d:	50                   	push   %eax
  80047e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800481:	68 07 23 80 00       	push   $0x802307
  800486:	e8 5f 01 00 00       	call   8005ea <cprintf>
  80048b:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80048e:	ff 45 e4             	incl   -0x1c(%ebp)
  800491:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800495:	7e d2                	jle    800469 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800497:	83 ec 0c             	sub    $0xc,%esp
  80049a:	68 16 23 80 00       	push   $0x802316
  80049f:	e8 46 01 00 00       	call   8005ea <cprintf>
  8004a4:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8004a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ac:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8004b2:	83 ec 08             	sub    $0x8,%esp
  8004b5:	50                   	push   %eax
  8004b6:	68 1a 23 80 00       	push   $0x80231a
  8004bb:	e8 2a 01 00 00       	call   8005ea <cprintf>
  8004c0:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8004c3:	83 ec 0c             	sub    $0xc,%esp
  8004c6:	68 10 22 80 00       	push   $0x802210
  8004cb:	e8 1a 01 00 00       	call   8005ea <cprintf>
  8004d0:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004d3:	e8 80 10 00 00       	call   801558 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004d8:	e8 1f 00 00 00       	call   8004fc <exit>
}
  8004dd:	90                   	nop
  8004de:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004e1:	5b                   	pop    %ebx
  8004e2:	5e                   	pop    %esi
  8004e3:	5f                   	pop    %edi
  8004e4:	5d                   	pop    %ebp
  8004e5:	c3                   	ret    

008004e6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004e6:	55                   	push   %ebp
  8004e7:	89 e5                	mov    %esp,%ebp
  8004e9:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8004ec:	83 ec 0c             	sub    $0xc,%esp
  8004ef:	6a 00                	push   $0x0
  8004f1:	e8 8c 12 00 00       	call   801782 <sys_destroy_env>
  8004f6:	83 c4 10             	add    $0x10,%esp
}
  8004f9:	90                   	nop
  8004fa:	c9                   	leave  
  8004fb:	c3                   	ret    

008004fc <exit>:

void
exit(void)
{
  8004fc:	55                   	push   %ebp
  8004fd:	89 e5                	mov    %esp,%ebp
  8004ff:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800502:	e8 e1 12 00 00       	call   8017e8 <sys_exit_env>
}
  800507:	90                   	nop
  800508:	c9                   	leave  
  800509:	c3                   	ret    

0080050a <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  80050a:	55                   	push   %ebp
  80050b:	89 e5                	mov    %esp,%ebp
  80050d:	53                   	push   %ebx
  80050e:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800511:	8b 45 0c             	mov    0xc(%ebp),%eax
  800514:	8b 00                	mov    (%eax),%eax
  800516:	8d 48 01             	lea    0x1(%eax),%ecx
  800519:	8b 55 0c             	mov    0xc(%ebp),%edx
  80051c:	89 0a                	mov    %ecx,(%edx)
  80051e:	8b 55 08             	mov    0x8(%ebp),%edx
  800521:	88 d1                	mov    %dl,%cl
  800523:	8b 55 0c             	mov    0xc(%ebp),%edx
  800526:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80052a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052d:	8b 00                	mov    (%eax),%eax
  80052f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800534:	75 30                	jne    800566 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800536:	8b 15 28 31 80 00    	mov    0x803128,%edx
  80053c:	a0 40 30 80 00       	mov    0x803040,%al
  800541:	0f b6 c0             	movzbl %al,%eax
  800544:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800547:	8b 09                	mov    (%ecx),%ecx
  800549:	89 cb                	mov    %ecx,%ebx
  80054b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80054e:	83 c1 08             	add    $0x8,%ecx
  800551:	52                   	push   %edx
  800552:	50                   	push   %eax
  800553:	53                   	push   %ebx
  800554:	51                   	push   %ecx
  800555:	e8 a0 0f 00 00       	call   8014fa <sys_cputs>
  80055a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80055d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800560:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800566:	8b 45 0c             	mov    0xc(%ebp),%eax
  800569:	8b 40 04             	mov    0x4(%eax),%eax
  80056c:	8d 50 01             	lea    0x1(%eax),%edx
  80056f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800572:	89 50 04             	mov    %edx,0x4(%eax)
}
  800575:	90                   	nop
  800576:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800579:	c9                   	leave  
  80057a:	c3                   	ret    

0080057b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80057b:	55                   	push   %ebp
  80057c:	89 e5                	mov    %esp,%ebp
  80057e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800584:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80058b:	00 00 00 
	b.cnt = 0;
  80058e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800595:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800598:	ff 75 0c             	pushl  0xc(%ebp)
  80059b:	ff 75 08             	pushl  0x8(%ebp)
  80059e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005a4:	50                   	push   %eax
  8005a5:	68 0a 05 80 00       	push   $0x80050a
  8005aa:	e8 5a 02 00 00       	call   800809 <vprintfmt>
  8005af:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8005b2:	8b 15 28 31 80 00    	mov    0x803128,%edx
  8005b8:	a0 40 30 80 00       	mov    0x803040,%al
  8005bd:	0f b6 c0             	movzbl %al,%eax
  8005c0:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8005c6:	52                   	push   %edx
  8005c7:	50                   	push   %eax
  8005c8:	51                   	push   %ecx
  8005c9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005cf:	83 c0 08             	add    $0x8,%eax
  8005d2:	50                   	push   %eax
  8005d3:	e8 22 0f 00 00       	call   8014fa <sys_cputs>
  8005d8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005db:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8005e2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005e8:	c9                   	leave  
  8005e9:	c3                   	ret    

008005ea <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8005ea:	55                   	push   %ebp
  8005eb:	89 e5                	mov    %esp,%ebp
  8005ed:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005f0:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8005f7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800600:	83 ec 08             	sub    $0x8,%esp
  800603:	ff 75 f4             	pushl  -0xc(%ebp)
  800606:	50                   	push   %eax
  800607:	e8 6f ff ff ff       	call   80057b <vcprintf>
  80060c:	83 c4 10             	add    $0x10,%esp
  80060f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800612:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800615:	c9                   	leave  
  800616:	c3                   	ret    

00800617 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800617:	55                   	push   %ebp
  800618:	89 e5                	mov    %esp,%ebp
  80061a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80061d:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800624:	8b 45 08             	mov    0x8(%ebp),%eax
  800627:	c1 e0 08             	shl    $0x8,%eax
  80062a:	a3 28 31 80 00       	mov    %eax,0x803128
	va_start(ap, fmt);
  80062f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800632:	83 c0 04             	add    $0x4,%eax
  800635:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800638:	8b 45 0c             	mov    0xc(%ebp),%eax
  80063b:	83 ec 08             	sub    $0x8,%esp
  80063e:	ff 75 f4             	pushl  -0xc(%ebp)
  800641:	50                   	push   %eax
  800642:	e8 34 ff ff ff       	call   80057b <vcprintf>
  800647:	83 c4 10             	add    $0x10,%esp
  80064a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80064d:	c7 05 28 31 80 00 00 	movl   $0x700,0x803128
  800654:	07 00 00 

	return cnt;
  800657:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80065a:	c9                   	leave  
  80065b:	c3                   	ret    

0080065c <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80065c:	55                   	push   %ebp
  80065d:	89 e5                	mov    %esp,%ebp
  80065f:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800662:	e8 d7 0e 00 00       	call   80153e <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800667:	8d 45 0c             	lea    0xc(%ebp),%eax
  80066a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80066d:	8b 45 08             	mov    0x8(%ebp),%eax
  800670:	83 ec 08             	sub    $0x8,%esp
  800673:	ff 75 f4             	pushl  -0xc(%ebp)
  800676:	50                   	push   %eax
  800677:	e8 ff fe ff ff       	call   80057b <vcprintf>
  80067c:	83 c4 10             	add    $0x10,%esp
  80067f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800682:	e8 d1 0e 00 00       	call   801558 <sys_unlock_cons>
	return cnt;
  800687:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80068a:	c9                   	leave  
  80068b:	c3                   	ret    

0080068c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80068c:	55                   	push   %ebp
  80068d:	89 e5                	mov    %esp,%ebp
  80068f:	53                   	push   %ebx
  800690:	83 ec 14             	sub    $0x14,%esp
  800693:	8b 45 10             	mov    0x10(%ebp),%eax
  800696:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800699:	8b 45 14             	mov    0x14(%ebp),%eax
  80069c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80069f:	8b 45 18             	mov    0x18(%ebp),%eax
  8006a2:	ba 00 00 00 00       	mov    $0x0,%edx
  8006a7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006aa:	77 55                	ja     800701 <printnum+0x75>
  8006ac:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006af:	72 05                	jb     8006b6 <printnum+0x2a>
  8006b1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006b4:	77 4b                	ja     800701 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006b6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006b9:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006bc:	8b 45 18             	mov    0x18(%ebp),%eax
  8006bf:	ba 00 00 00 00       	mov    $0x0,%edx
  8006c4:	52                   	push   %edx
  8006c5:	50                   	push   %eax
  8006c6:	ff 75 f4             	pushl  -0xc(%ebp)
  8006c9:	ff 75 f0             	pushl  -0x10(%ebp)
  8006cc:	e8 1f 16 00 00       	call   801cf0 <__udivdi3>
  8006d1:	83 c4 10             	add    $0x10,%esp
  8006d4:	83 ec 04             	sub    $0x4,%esp
  8006d7:	ff 75 20             	pushl  0x20(%ebp)
  8006da:	53                   	push   %ebx
  8006db:	ff 75 18             	pushl  0x18(%ebp)
  8006de:	52                   	push   %edx
  8006df:	50                   	push   %eax
  8006e0:	ff 75 0c             	pushl  0xc(%ebp)
  8006e3:	ff 75 08             	pushl  0x8(%ebp)
  8006e6:	e8 a1 ff ff ff       	call   80068c <printnum>
  8006eb:	83 c4 20             	add    $0x20,%esp
  8006ee:	eb 1a                	jmp    80070a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006f0:	83 ec 08             	sub    $0x8,%esp
  8006f3:	ff 75 0c             	pushl  0xc(%ebp)
  8006f6:	ff 75 20             	pushl  0x20(%ebp)
  8006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fc:	ff d0                	call   *%eax
  8006fe:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800701:	ff 4d 1c             	decl   0x1c(%ebp)
  800704:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800708:	7f e6                	jg     8006f0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80070a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80070d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800712:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800715:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800718:	53                   	push   %ebx
  800719:	51                   	push   %ecx
  80071a:	52                   	push   %edx
  80071b:	50                   	push   %eax
  80071c:	e8 df 16 00 00       	call   801e00 <__umoddi3>
  800721:	83 c4 10             	add    $0x10,%esp
  800724:	05 14 26 80 00       	add    $0x802614,%eax
  800729:	8a 00                	mov    (%eax),%al
  80072b:	0f be c0             	movsbl %al,%eax
  80072e:	83 ec 08             	sub    $0x8,%esp
  800731:	ff 75 0c             	pushl  0xc(%ebp)
  800734:	50                   	push   %eax
  800735:	8b 45 08             	mov    0x8(%ebp),%eax
  800738:	ff d0                	call   *%eax
  80073a:	83 c4 10             	add    $0x10,%esp
}
  80073d:	90                   	nop
  80073e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800741:	c9                   	leave  
  800742:	c3                   	ret    

00800743 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800743:	55                   	push   %ebp
  800744:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800746:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80074a:	7e 1c                	jle    800768 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80074c:	8b 45 08             	mov    0x8(%ebp),%eax
  80074f:	8b 00                	mov    (%eax),%eax
  800751:	8d 50 08             	lea    0x8(%eax),%edx
  800754:	8b 45 08             	mov    0x8(%ebp),%eax
  800757:	89 10                	mov    %edx,(%eax)
  800759:	8b 45 08             	mov    0x8(%ebp),%eax
  80075c:	8b 00                	mov    (%eax),%eax
  80075e:	83 e8 08             	sub    $0x8,%eax
  800761:	8b 50 04             	mov    0x4(%eax),%edx
  800764:	8b 00                	mov    (%eax),%eax
  800766:	eb 40                	jmp    8007a8 <getuint+0x65>
	else if (lflag)
  800768:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80076c:	74 1e                	je     80078c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80076e:	8b 45 08             	mov    0x8(%ebp),%eax
  800771:	8b 00                	mov    (%eax),%eax
  800773:	8d 50 04             	lea    0x4(%eax),%edx
  800776:	8b 45 08             	mov    0x8(%ebp),%eax
  800779:	89 10                	mov    %edx,(%eax)
  80077b:	8b 45 08             	mov    0x8(%ebp),%eax
  80077e:	8b 00                	mov    (%eax),%eax
  800780:	83 e8 04             	sub    $0x4,%eax
  800783:	8b 00                	mov    (%eax),%eax
  800785:	ba 00 00 00 00       	mov    $0x0,%edx
  80078a:	eb 1c                	jmp    8007a8 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80078c:	8b 45 08             	mov    0x8(%ebp),%eax
  80078f:	8b 00                	mov    (%eax),%eax
  800791:	8d 50 04             	lea    0x4(%eax),%edx
  800794:	8b 45 08             	mov    0x8(%ebp),%eax
  800797:	89 10                	mov    %edx,(%eax)
  800799:	8b 45 08             	mov    0x8(%ebp),%eax
  80079c:	8b 00                	mov    (%eax),%eax
  80079e:	83 e8 04             	sub    $0x4,%eax
  8007a1:	8b 00                	mov    (%eax),%eax
  8007a3:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007a8:	5d                   	pop    %ebp
  8007a9:	c3                   	ret    

008007aa <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007aa:	55                   	push   %ebp
  8007ab:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007ad:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007b1:	7e 1c                	jle    8007cf <getint+0x25>
		return va_arg(*ap, long long);
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	8b 00                	mov    (%eax),%eax
  8007b8:	8d 50 08             	lea    0x8(%eax),%edx
  8007bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007be:	89 10                	mov    %edx,(%eax)
  8007c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c3:	8b 00                	mov    (%eax),%eax
  8007c5:	83 e8 08             	sub    $0x8,%eax
  8007c8:	8b 50 04             	mov    0x4(%eax),%edx
  8007cb:	8b 00                	mov    (%eax),%eax
  8007cd:	eb 38                	jmp    800807 <getint+0x5d>
	else if (lflag)
  8007cf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007d3:	74 1a                	je     8007ef <getint+0x45>
		return va_arg(*ap, long);
  8007d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d8:	8b 00                	mov    (%eax),%eax
  8007da:	8d 50 04             	lea    0x4(%eax),%edx
  8007dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e0:	89 10                	mov    %edx,(%eax)
  8007e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e5:	8b 00                	mov    (%eax),%eax
  8007e7:	83 e8 04             	sub    $0x4,%eax
  8007ea:	8b 00                	mov    (%eax),%eax
  8007ec:	99                   	cltd   
  8007ed:	eb 18                	jmp    800807 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f2:	8b 00                	mov    (%eax),%eax
  8007f4:	8d 50 04             	lea    0x4(%eax),%edx
  8007f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fa:	89 10                	mov    %edx,(%eax)
  8007fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ff:	8b 00                	mov    (%eax),%eax
  800801:	83 e8 04             	sub    $0x4,%eax
  800804:	8b 00                	mov    (%eax),%eax
  800806:	99                   	cltd   
}
  800807:	5d                   	pop    %ebp
  800808:	c3                   	ret    

00800809 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800809:	55                   	push   %ebp
  80080a:	89 e5                	mov    %esp,%ebp
  80080c:	56                   	push   %esi
  80080d:	53                   	push   %ebx
  80080e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800811:	eb 17                	jmp    80082a <vprintfmt+0x21>
			if (ch == '\0')
  800813:	85 db                	test   %ebx,%ebx
  800815:	0f 84 c1 03 00 00    	je     800bdc <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80081b:	83 ec 08             	sub    $0x8,%esp
  80081e:	ff 75 0c             	pushl  0xc(%ebp)
  800821:	53                   	push   %ebx
  800822:	8b 45 08             	mov    0x8(%ebp),%eax
  800825:	ff d0                	call   *%eax
  800827:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80082a:	8b 45 10             	mov    0x10(%ebp),%eax
  80082d:	8d 50 01             	lea    0x1(%eax),%edx
  800830:	89 55 10             	mov    %edx,0x10(%ebp)
  800833:	8a 00                	mov    (%eax),%al
  800835:	0f b6 d8             	movzbl %al,%ebx
  800838:	83 fb 25             	cmp    $0x25,%ebx
  80083b:	75 d6                	jne    800813 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80083d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800841:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800848:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80084f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800856:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80085d:	8b 45 10             	mov    0x10(%ebp),%eax
  800860:	8d 50 01             	lea    0x1(%eax),%edx
  800863:	89 55 10             	mov    %edx,0x10(%ebp)
  800866:	8a 00                	mov    (%eax),%al
  800868:	0f b6 d8             	movzbl %al,%ebx
  80086b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80086e:	83 f8 5b             	cmp    $0x5b,%eax
  800871:	0f 87 3d 03 00 00    	ja     800bb4 <vprintfmt+0x3ab>
  800877:	8b 04 85 38 26 80 00 	mov    0x802638(,%eax,4),%eax
  80087e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800880:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800884:	eb d7                	jmp    80085d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800886:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80088a:	eb d1                	jmp    80085d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80088c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800893:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800896:	89 d0                	mov    %edx,%eax
  800898:	c1 e0 02             	shl    $0x2,%eax
  80089b:	01 d0                	add    %edx,%eax
  80089d:	01 c0                	add    %eax,%eax
  80089f:	01 d8                	add    %ebx,%eax
  8008a1:	83 e8 30             	sub    $0x30,%eax
  8008a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8008aa:	8a 00                	mov    (%eax),%al
  8008ac:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008af:	83 fb 2f             	cmp    $0x2f,%ebx
  8008b2:	7e 3e                	jle    8008f2 <vprintfmt+0xe9>
  8008b4:	83 fb 39             	cmp    $0x39,%ebx
  8008b7:	7f 39                	jg     8008f2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008b9:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008bc:	eb d5                	jmp    800893 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008be:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c1:	83 c0 04             	add    $0x4,%eax
  8008c4:	89 45 14             	mov    %eax,0x14(%ebp)
  8008c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ca:	83 e8 04             	sub    $0x4,%eax
  8008cd:	8b 00                	mov    (%eax),%eax
  8008cf:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008d2:	eb 1f                	jmp    8008f3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008d4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d8:	79 83                	jns    80085d <vprintfmt+0x54>
				width = 0;
  8008da:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008e1:	e9 77 ff ff ff       	jmp    80085d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008e6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008ed:	e9 6b ff ff ff       	jmp    80085d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008f2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008f3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008f7:	0f 89 60 ff ff ff    	jns    80085d <vprintfmt+0x54>
				width = precision, precision = -1;
  8008fd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800900:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800903:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80090a:	e9 4e ff ff ff       	jmp    80085d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80090f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800912:	e9 46 ff ff ff       	jmp    80085d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800917:	8b 45 14             	mov    0x14(%ebp),%eax
  80091a:	83 c0 04             	add    $0x4,%eax
  80091d:	89 45 14             	mov    %eax,0x14(%ebp)
  800920:	8b 45 14             	mov    0x14(%ebp),%eax
  800923:	83 e8 04             	sub    $0x4,%eax
  800926:	8b 00                	mov    (%eax),%eax
  800928:	83 ec 08             	sub    $0x8,%esp
  80092b:	ff 75 0c             	pushl  0xc(%ebp)
  80092e:	50                   	push   %eax
  80092f:	8b 45 08             	mov    0x8(%ebp),%eax
  800932:	ff d0                	call   *%eax
  800934:	83 c4 10             	add    $0x10,%esp
			break;
  800937:	e9 9b 02 00 00       	jmp    800bd7 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80093c:	8b 45 14             	mov    0x14(%ebp),%eax
  80093f:	83 c0 04             	add    $0x4,%eax
  800942:	89 45 14             	mov    %eax,0x14(%ebp)
  800945:	8b 45 14             	mov    0x14(%ebp),%eax
  800948:	83 e8 04             	sub    $0x4,%eax
  80094b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80094d:	85 db                	test   %ebx,%ebx
  80094f:	79 02                	jns    800953 <vprintfmt+0x14a>
				err = -err;
  800951:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800953:	83 fb 64             	cmp    $0x64,%ebx
  800956:	7f 0b                	jg     800963 <vprintfmt+0x15a>
  800958:	8b 34 9d 80 24 80 00 	mov    0x802480(,%ebx,4),%esi
  80095f:	85 f6                	test   %esi,%esi
  800961:	75 19                	jne    80097c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800963:	53                   	push   %ebx
  800964:	68 25 26 80 00       	push   $0x802625
  800969:	ff 75 0c             	pushl  0xc(%ebp)
  80096c:	ff 75 08             	pushl  0x8(%ebp)
  80096f:	e8 70 02 00 00       	call   800be4 <printfmt>
  800974:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800977:	e9 5b 02 00 00       	jmp    800bd7 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80097c:	56                   	push   %esi
  80097d:	68 2e 26 80 00       	push   $0x80262e
  800982:	ff 75 0c             	pushl  0xc(%ebp)
  800985:	ff 75 08             	pushl  0x8(%ebp)
  800988:	e8 57 02 00 00       	call   800be4 <printfmt>
  80098d:	83 c4 10             	add    $0x10,%esp
			break;
  800990:	e9 42 02 00 00       	jmp    800bd7 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800995:	8b 45 14             	mov    0x14(%ebp),%eax
  800998:	83 c0 04             	add    $0x4,%eax
  80099b:	89 45 14             	mov    %eax,0x14(%ebp)
  80099e:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a1:	83 e8 04             	sub    $0x4,%eax
  8009a4:	8b 30                	mov    (%eax),%esi
  8009a6:	85 f6                	test   %esi,%esi
  8009a8:	75 05                	jne    8009af <vprintfmt+0x1a6>
				p = "(null)";
  8009aa:	be 31 26 80 00       	mov    $0x802631,%esi
			if (width > 0 && padc != '-')
  8009af:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009b3:	7e 6d                	jle    800a22 <vprintfmt+0x219>
  8009b5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009b9:	74 67                	je     800a22 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009be:	83 ec 08             	sub    $0x8,%esp
  8009c1:	50                   	push   %eax
  8009c2:	56                   	push   %esi
  8009c3:	e8 1e 03 00 00       	call   800ce6 <strnlen>
  8009c8:	83 c4 10             	add    $0x10,%esp
  8009cb:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009ce:	eb 16                	jmp    8009e6 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009d0:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009d4:	83 ec 08             	sub    $0x8,%esp
  8009d7:	ff 75 0c             	pushl  0xc(%ebp)
  8009da:	50                   	push   %eax
  8009db:	8b 45 08             	mov    0x8(%ebp),%eax
  8009de:	ff d0                	call   *%eax
  8009e0:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009e3:	ff 4d e4             	decl   -0x1c(%ebp)
  8009e6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ea:	7f e4                	jg     8009d0 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009ec:	eb 34                	jmp    800a22 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009ee:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009f2:	74 1c                	je     800a10 <vprintfmt+0x207>
  8009f4:	83 fb 1f             	cmp    $0x1f,%ebx
  8009f7:	7e 05                	jle    8009fe <vprintfmt+0x1f5>
  8009f9:	83 fb 7e             	cmp    $0x7e,%ebx
  8009fc:	7e 12                	jle    800a10 <vprintfmt+0x207>
					putch('?', putdat);
  8009fe:	83 ec 08             	sub    $0x8,%esp
  800a01:	ff 75 0c             	pushl  0xc(%ebp)
  800a04:	6a 3f                	push   $0x3f
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	ff d0                	call   *%eax
  800a0b:	83 c4 10             	add    $0x10,%esp
  800a0e:	eb 0f                	jmp    800a1f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a10:	83 ec 08             	sub    $0x8,%esp
  800a13:	ff 75 0c             	pushl  0xc(%ebp)
  800a16:	53                   	push   %ebx
  800a17:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1a:	ff d0                	call   *%eax
  800a1c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a1f:	ff 4d e4             	decl   -0x1c(%ebp)
  800a22:	89 f0                	mov    %esi,%eax
  800a24:	8d 70 01             	lea    0x1(%eax),%esi
  800a27:	8a 00                	mov    (%eax),%al
  800a29:	0f be d8             	movsbl %al,%ebx
  800a2c:	85 db                	test   %ebx,%ebx
  800a2e:	74 24                	je     800a54 <vprintfmt+0x24b>
  800a30:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a34:	78 b8                	js     8009ee <vprintfmt+0x1e5>
  800a36:	ff 4d e0             	decl   -0x20(%ebp)
  800a39:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a3d:	79 af                	jns    8009ee <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a3f:	eb 13                	jmp    800a54 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a41:	83 ec 08             	sub    $0x8,%esp
  800a44:	ff 75 0c             	pushl  0xc(%ebp)
  800a47:	6a 20                	push   $0x20
  800a49:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4c:	ff d0                	call   *%eax
  800a4e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a51:	ff 4d e4             	decl   -0x1c(%ebp)
  800a54:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a58:	7f e7                	jg     800a41 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a5a:	e9 78 01 00 00       	jmp    800bd7 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a5f:	83 ec 08             	sub    $0x8,%esp
  800a62:	ff 75 e8             	pushl  -0x18(%ebp)
  800a65:	8d 45 14             	lea    0x14(%ebp),%eax
  800a68:	50                   	push   %eax
  800a69:	e8 3c fd ff ff       	call   8007aa <getint>
  800a6e:	83 c4 10             	add    $0x10,%esp
  800a71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a74:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a7d:	85 d2                	test   %edx,%edx
  800a7f:	79 23                	jns    800aa4 <vprintfmt+0x29b>
				putch('-', putdat);
  800a81:	83 ec 08             	sub    $0x8,%esp
  800a84:	ff 75 0c             	pushl  0xc(%ebp)
  800a87:	6a 2d                	push   $0x2d
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	ff d0                	call   *%eax
  800a8e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a97:	f7 d8                	neg    %eax
  800a99:	83 d2 00             	adc    $0x0,%edx
  800a9c:	f7 da                	neg    %edx
  800a9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aa1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800aa4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aab:	e9 bc 00 00 00       	jmp    800b6c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ab0:	83 ec 08             	sub    $0x8,%esp
  800ab3:	ff 75 e8             	pushl  -0x18(%ebp)
  800ab6:	8d 45 14             	lea    0x14(%ebp),%eax
  800ab9:	50                   	push   %eax
  800aba:	e8 84 fc ff ff       	call   800743 <getuint>
  800abf:	83 c4 10             	add    $0x10,%esp
  800ac2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ac8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800acf:	e9 98 00 00 00       	jmp    800b6c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ad4:	83 ec 08             	sub    $0x8,%esp
  800ad7:	ff 75 0c             	pushl  0xc(%ebp)
  800ada:	6a 58                	push   $0x58
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	ff d0                	call   *%eax
  800ae1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ae4:	83 ec 08             	sub    $0x8,%esp
  800ae7:	ff 75 0c             	pushl  0xc(%ebp)
  800aea:	6a 58                	push   $0x58
  800aec:	8b 45 08             	mov    0x8(%ebp),%eax
  800aef:	ff d0                	call   *%eax
  800af1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800af4:	83 ec 08             	sub    $0x8,%esp
  800af7:	ff 75 0c             	pushl  0xc(%ebp)
  800afa:	6a 58                	push   $0x58
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	ff d0                	call   *%eax
  800b01:	83 c4 10             	add    $0x10,%esp
			break;
  800b04:	e9 ce 00 00 00       	jmp    800bd7 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800b09:	83 ec 08             	sub    $0x8,%esp
  800b0c:	ff 75 0c             	pushl  0xc(%ebp)
  800b0f:	6a 30                	push   $0x30
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
  800b14:	ff d0                	call   *%eax
  800b16:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b19:	83 ec 08             	sub    $0x8,%esp
  800b1c:	ff 75 0c             	pushl  0xc(%ebp)
  800b1f:	6a 78                	push   $0x78
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	ff d0                	call   *%eax
  800b26:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b29:	8b 45 14             	mov    0x14(%ebp),%eax
  800b2c:	83 c0 04             	add    $0x4,%eax
  800b2f:	89 45 14             	mov    %eax,0x14(%ebp)
  800b32:	8b 45 14             	mov    0x14(%ebp),%eax
  800b35:	83 e8 04             	sub    $0x4,%eax
  800b38:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b3d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b44:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b4b:	eb 1f                	jmp    800b6c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b4d:	83 ec 08             	sub    $0x8,%esp
  800b50:	ff 75 e8             	pushl  -0x18(%ebp)
  800b53:	8d 45 14             	lea    0x14(%ebp),%eax
  800b56:	50                   	push   %eax
  800b57:	e8 e7 fb ff ff       	call   800743 <getuint>
  800b5c:	83 c4 10             	add    $0x10,%esp
  800b5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b62:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b65:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b6c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b70:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b73:	83 ec 04             	sub    $0x4,%esp
  800b76:	52                   	push   %edx
  800b77:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b7a:	50                   	push   %eax
  800b7b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b7e:	ff 75 f0             	pushl  -0x10(%ebp)
  800b81:	ff 75 0c             	pushl  0xc(%ebp)
  800b84:	ff 75 08             	pushl  0x8(%ebp)
  800b87:	e8 00 fb ff ff       	call   80068c <printnum>
  800b8c:	83 c4 20             	add    $0x20,%esp
			break;
  800b8f:	eb 46                	jmp    800bd7 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b91:	83 ec 08             	sub    $0x8,%esp
  800b94:	ff 75 0c             	pushl  0xc(%ebp)
  800b97:	53                   	push   %ebx
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	ff d0                	call   *%eax
  800b9d:	83 c4 10             	add    $0x10,%esp
			break;
  800ba0:	eb 35                	jmp    800bd7 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800ba2:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800ba9:	eb 2c                	jmp    800bd7 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800bab:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800bb2:	eb 23                	jmp    800bd7 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bb4:	83 ec 08             	sub    $0x8,%esp
  800bb7:	ff 75 0c             	pushl  0xc(%ebp)
  800bba:	6a 25                	push   $0x25
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	ff d0                	call   *%eax
  800bc1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bc4:	ff 4d 10             	decl   0x10(%ebp)
  800bc7:	eb 03                	jmp    800bcc <vprintfmt+0x3c3>
  800bc9:	ff 4d 10             	decl   0x10(%ebp)
  800bcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcf:	48                   	dec    %eax
  800bd0:	8a 00                	mov    (%eax),%al
  800bd2:	3c 25                	cmp    $0x25,%al
  800bd4:	75 f3                	jne    800bc9 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800bd6:	90                   	nop
		}
	}
  800bd7:	e9 35 fc ff ff       	jmp    800811 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800bdc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800bdd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800be0:	5b                   	pop    %ebx
  800be1:	5e                   	pop    %esi
  800be2:	5d                   	pop    %ebp
  800be3:	c3                   	ret    

00800be4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800be4:	55                   	push   %ebp
  800be5:	89 e5                	mov    %esp,%ebp
  800be7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800bea:	8d 45 10             	lea    0x10(%ebp),%eax
  800bed:	83 c0 04             	add    $0x4,%eax
  800bf0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800bf3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf6:	ff 75 f4             	pushl  -0xc(%ebp)
  800bf9:	50                   	push   %eax
  800bfa:	ff 75 0c             	pushl  0xc(%ebp)
  800bfd:	ff 75 08             	pushl  0x8(%ebp)
  800c00:	e8 04 fc ff ff       	call   800809 <vprintfmt>
  800c05:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c08:	90                   	nop
  800c09:	c9                   	leave  
  800c0a:	c3                   	ret    

00800c0b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c0b:	55                   	push   %ebp
  800c0c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c11:	8b 40 08             	mov    0x8(%eax),%eax
  800c14:	8d 50 01             	lea    0x1(%eax),%edx
  800c17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c20:	8b 10                	mov    (%eax),%edx
  800c22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c25:	8b 40 04             	mov    0x4(%eax),%eax
  800c28:	39 c2                	cmp    %eax,%edx
  800c2a:	73 12                	jae    800c3e <sprintputch+0x33>
		*b->buf++ = ch;
  800c2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2f:	8b 00                	mov    (%eax),%eax
  800c31:	8d 48 01             	lea    0x1(%eax),%ecx
  800c34:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c37:	89 0a                	mov    %ecx,(%edx)
  800c39:	8b 55 08             	mov    0x8(%ebp),%edx
  800c3c:	88 10                	mov    %dl,(%eax)
}
  800c3e:	90                   	nop
  800c3f:	5d                   	pop    %ebp
  800c40:	c3                   	ret    

00800c41 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c41:	55                   	push   %ebp
  800c42:	89 e5                	mov    %esp,%ebp
  800c44:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c47:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c50:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	01 d0                	add    %edx,%eax
  800c58:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c5b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c62:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c66:	74 06                	je     800c6e <vsnprintf+0x2d>
  800c68:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c6c:	7f 07                	jg     800c75 <vsnprintf+0x34>
		return -E_INVAL;
  800c6e:	b8 03 00 00 00       	mov    $0x3,%eax
  800c73:	eb 20                	jmp    800c95 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c75:	ff 75 14             	pushl  0x14(%ebp)
  800c78:	ff 75 10             	pushl  0x10(%ebp)
  800c7b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c7e:	50                   	push   %eax
  800c7f:	68 0b 0c 80 00       	push   $0x800c0b
  800c84:	e8 80 fb ff ff       	call   800809 <vprintfmt>
  800c89:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c8f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c92:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c95:	c9                   	leave  
  800c96:	c3                   	ret    

00800c97 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c97:	55                   	push   %ebp
  800c98:	89 e5                	mov    %esp,%ebp
  800c9a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c9d:	8d 45 10             	lea    0x10(%ebp),%eax
  800ca0:	83 c0 04             	add    $0x4,%eax
  800ca3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ca6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca9:	ff 75 f4             	pushl  -0xc(%ebp)
  800cac:	50                   	push   %eax
  800cad:	ff 75 0c             	pushl  0xc(%ebp)
  800cb0:	ff 75 08             	pushl  0x8(%ebp)
  800cb3:	e8 89 ff ff ff       	call   800c41 <vsnprintf>
  800cb8:	83 c4 10             	add    $0x10,%esp
  800cbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cc1:	c9                   	leave  
  800cc2:	c3                   	ret    

00800cc3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cc3:	55                   	push   %ebp
  800cc4:	89 e5                	mov    %esp,%ebp
  800cc6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cc9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cd0:	eb 06                	jmp    800cd8 <strlen+0x15>
		n++;
  800cd2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800cd5:	ff 45 08             	incl   0x8(%ebp)
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	8a 00                	mov    (%eax),%al
  800cdd:	84 c0                	test   %al,%al
  800cdf:	75 f1                	jne    800cd2 <strlen+0xf>
		n++;
	return n;
  800ce1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ce4:	c9                   	leave  
  800ce5:	c3                   	ret    

00800ce6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ce6:	55                   	push   %ebp
  800ce7:	89 e5                	mov    %esp,%ebp
  800ce9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cf3:	eb 09                	jmp    800cfe <strnlen+0x18>
		n++;
  800cf5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cf8:	ff 45 08             	incl   0x8(%ebp)
  800cfb:	ff 4d 0c             	decl   0xc(%ebp)
  800cfe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d02:	74 09                	je     800d0d <strnlen+0x27>
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	8a 00                	mov    (%eax),%al
  800d09:	84 c0                	test   %al,%al
  800d0b:	75 e8                	jne    800cf5 <strnlen+0xf>
		n++;
	return n;
  800d0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d10:	c9                   	leave  
  800d11:	c3                   	ret    

00800d12 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d12:	55                   	push   %ebp
  800d13:	89 e5                	mov    %esp,%ebp
  800d15:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d1e:	90                   	nop
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8d 50 01             	lea    0x1(%eax),%edx
  800d25:	89 55 08             	mov    %edx,0x8(%ebp)
  800d28:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d2b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d2e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d31:	8a 12                	mov    (%edx),%dl
  800d33:	88 10                	mov    %dl,(%eax)
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	84 c0                	test   %al,%al
  800d39:	75 e4                	jne    800d1f <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d3e:	c9                   	leave  
  800d3f:	c3                   	ret    

00800d40 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d40:	55                   	push   %ebp
  800d41:	89 e5                	mov    %esp,%ebp
  800d43:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d46:	8b 45 08             	mov    0x8(%ebp),%eax
  800d49:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d4c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d53:	eb 1f                	jmp    800d74 <strncpy+0x34>
		*dst++ = *src;
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8d 50 01             	lea    0x1(%eax),%edx
  800d5b:	89 55 08             	mov    %edx,0x8(%ebp)
  800d5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d61:	8a 12                	mov    (%edx),%dl
  800d63:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d68:	8a 00                	mov    (%eax),%al
  800d6a:	84 c0                	test   %al,%al
  800d6c:	74 03                	je     800d71 <strncpy+0x31>
			src++;
  800d6e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d71:	ff 45 fc             	incl   -0x4(%ebp)
  800d74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d77:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d7a:	72 d9                	jb     800d55 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d7f:	c9                   	leave  
  800d80:	c3                   	ret    

00800d81 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d81:	55                   	push   %ebp
  800d82:	89 e5                	mov    %esp,%ebp
  800d84:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d8d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d91:	74 30                	je     800dc3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d93:	eb 16                	jmp    800dab <strlcpy+0x2a>
			*dst++ = *src++;
  800d95:	8b 45 08             	mov    0x8(%ebp),%eax
  800d98:	8d 50 01             	lea    0x1(%eax),%edx
  800d9b:	89 55 08             	mov    %edx,0x8(%ebp)
  800d9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800da1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800da4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800da7:	8a 12                	mov    (%edx),%dl
  800da9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800dab:	ff 4d 10             	decl   0x10(%ebp)
  800dae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db2:	74 09                	je     800dbd <strlcpy+0x3c>
  800db4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db7:	8a 00                	mov    (%eax),%al
  800db9:	84 c0                	test   %al,%al
  800dbb:	75 d8                	jne    800d95 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800dc3:	8b 55 08             	mov    0x8(%ebp),%edx
  800dc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc9:	29 c2                	sub    %eax,%edx
  800dcb:	89 d0                	mov    %edx,%eax
}
  800dcd:	c9                   	leave  
  800dce:	c3                   	ret    

00800dcf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800dcf:	55                   	push   %ebp
  800dd0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800dd2:	eb 06                	jmp    800dda <strcmp+0xb>
		p++, q++;
  800dd4:	ff 45 08             	incl   0x8(%ebp)
  800dd7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	8a 00                	mov    (%eax),%al
  800ddf:	84 c0                	test   %al,%al
  800de1:	74 0e                	je     800df1 <strcmp+0x22>
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	8a 10                	mov    (%eax),%dl
  800de8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800deb:	8a 00                	mov    (%eax),%al
  800ded:	38 c2                	cmp    %al,%dl
  800def:	74 e3                	je     800dd4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800df1:	8b 45 08             	mov    0x8(%ebp),%eax
  800df4:	8a 00                	mov    (%eax),%al
  800df6:	0f b6 d0             	movzbl %al,%edx
  800df9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfc:	8a 00                	mov    (%eax),%al
  800dfe:	0f b6 c0             	movzbl %al,%eax
  800e01:	29 c2                	sub    %eax,%edx
  800e03:	89 d0                	mov    %edx,%eax
}
  800e05:	5d                   	pop    %ebp
  800e06:	c3                   	ret    

00800e07 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e07:	55                   	push   %ebp
  800e08:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e0a:	eb 09                	jmp    800e15 <strncmp+0xe>
		n--, p++, q++;
  800e0c:	ff 4d 10             	decl   0x10(%ebp)
  800e0f:	ff 45 08             	incl   0x8(%ebp)
  800e12:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e19:	74 17                	je     800e32 <strncmp+0x2b>
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	8a 00                	mov    (%eax),%al
  800e20:	84 c0                	test   %al,%al
  800e22:	74 0e                	je     800e32 <strncmp+0x2b>
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
  800e27:	8a 10                	mov    (%eax),%dl
  800e29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2c:	8a 00                	mov    (%eax),%al
  800e2e:	38 c2                	cmp    %al,%dl
  800e30:	74 da                	je     800e0c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e32:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e36:	75 07                	jne    800e3f <strncmp+0x38>
		return 0;
  800e38:	b8 00 00 00 00       	mov    $0x0,%eax
  800e3d:	eb 14                	jmp    800e53 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	8a 00                	mov    (%eax),%al
  800e44:	0f b6 d0             	movzbl %al,%edx
  800e47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	0f b6 c0             	movzbl %al,%eax
  800e4f:	29 c2                	sub    %eax,%edx
  800e51:	89 d0                	mov    %edx,%eax
}
  800e53:	5d                   	pop    %ebp
  800e54:	c3                   	ret    

00800e55 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e55:	55                   	push   %ebp
  800e56:	89 e5                	mov    %esp,%ebp
  800e58:	83 ec 04             	sub    $0x4,%esp
  800e5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e61:	eb 12                	jmp    800e75 <strchr+0x20>
		if (*s == c)
  800e63:	8b 45 08             	mov    0x8(%ebp),%eax
  800e66:	8a 00                	mov    (%eax),%al
  800e68:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e6b:	75 05                	jne    800e72 <strchr+0x1d>
			return (char *) s;
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	eb 11                	jmp    800e83 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e72:	ff 45 08             	incl   0x8(%ebp)
  800e75:	8b 45 08             	mov    0x8(%ebp),%eax
  800e78:	8a 00                	mov    (%eax),%al
  800e7a:	84 c0                	test   %al,%al
  800e7c:	75 e5                	jne    800e63 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e83:	c9                   	leave  
  800e84:	c3                   	ret    

00800e85 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e85:	55                   	push   %ebp
  800e86:	89 e5                	mov    %esp,%ebp
  800e88:	83 ec 04             	sub    $0x4,%esp
  800e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e91:	eb 0d                	jmp    800ea0 <strfind+0x1b>
		if (*s == c)
  800e93:	8b 45 08             	mov    0x8(%ebp),%eax
  800e96:	8a 00                	mov    (%eax),%al
  800e98:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e9b:	74 0e                	je     800eab <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e9d:	ff 45 08             	incl   0x8(%ebp)
  800ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea3:	8a 00                	mov    (%eax),%al
  800ea5:	84 c0                	test   %al,%al
  800ea7:	75 ea                	jne    800e93 <strfind+0xe>
  800ea9:	eb 01                	jmp    800eac <strfind+0x27>
		if (*s == c)
			break;
  800eab:	90                   	nop
	return (char *) s;
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eaf:	c9                   	leave  
  800eb0:	c3                   	ret    

00800eb1 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800eb1:	55                   	push   %ebp
  800eb2:	89 e5                	mov    %esp,%ebp
  800eb4:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800ebd:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ec1:	76 63                	jbe    800f26 <memset+0x75>
		uint64 data_block = c;
  800ec3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec6:	99                   	cltd   
  800ec7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eca:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800ecd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ed0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ed3:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800ed7:	c1 e0 08             	shl    $0x8,%eax
  800eda:	09 45 f0             	or     %eax,-0x10(%ebp)
  800edd:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800ee0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ee3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ee6:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800eea:	c1 e0 10             	shl    $0x10,%eax
  800eed:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ef0:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800ef3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ef6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef9:	89 c2                	mov    %eax,%edx
  800efb:	b8 00 00 00 00       	mov    $0x0,%eax
  800f00:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f03:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800f06:	eb 18                	jmp    800f20 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800f08:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f0b:	8d 41 08             	lea    0x8(%ecx),%eax
  800f0e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800f11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f14:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f17:	89 01                	mov    %eax,(%ecx)
  800f19:	89 51 04             	mov    %edx,0x4(%ecx)
  800f1c:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800f20:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f24:	77 e2                	ja     800f08 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800f26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2a:	74 23                	je     800f4f <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800f2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f2f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f32:	eb 0e                	jmp    800f42 <memset+0x91>
			*p8++ = (uint8)c;
  800f34:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f37:	8d 50 01             	lea    0x1(%eax),%edx
  800f3a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f40:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800f42:	8b 45 10             	mov    0x10(%ebp),%eax
  800f45:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f48:	89 55 10             	mov    %edx,0x10(%ebp)
  800f4b:	85 c0                	test   %eax,%eax
  800f4d:	75 e5                	jne    800f34 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f52:	c9                   	leave  
  800f53:	c3                   	ret    

00800f54 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f54:	55                   	push   %ebp
  800f55:	89 e5                	mov    %esp,%ebp
  800f57:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800f66:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f6a:	76 24                	jbe    800f90 <memcpy+0x3c>
		while(n >= 8){
  800f6c:	eb 1c                	jmp    800f8a <memcpy+0x36>
			*d64 = *s64;
  800f6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f71:	8b 50 04             	mov    0x4(%eax),%edx
  800f74:	8b 00                	mov    (%eax),%eax
  800f76:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f79:	89 01                	mov    %eax,(%ecx)
  800f7b:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800f7e:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800f82:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800f86:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800f8a:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f8e:	77 de                	ja     800f6e <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800f90:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f94:	74 31                	je     800fc7 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800f96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f99:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800f9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800fa2:	eb 16                	jmp    800fba <memcpy+0x66>
			*d8++ = *s8++;
  800fa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fa7:	8d 50 01             	lea    0x1(%eax),%edx
  800faa:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800fad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fb0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fb3:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800fb6:	8a 12                	mov    (%edx),%dl
  800fb8:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800fba:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc0:	89 55 10             	mov    %edx,0x10(%ebp)
  800fc3:	85 c0                	test   %eax,%eax
  800fc5:	75 dd                	jne    800fa4 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fca:	c9                   	leave  
  800fcb:	c3                   	ret    

00800fcc <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fcc:	55                   	push   %ebp
  800fcd:	89 e5                	mov    %esp,%ebp
  800fcf:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fde:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fe4:	73 50                	jae    801036 <memmove+0x6a>
  800fe6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fe9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fec:	01 d0                	add    %edx,%eax
  800fee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ff1:	76 43                	jbe    801036 <memmove+0x6a>
		s += n;
  800ff3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ff9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffc:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fff:	eb 10                	jmp    801011 <memmove+0x45>
			*--d = *--s;
  801001:	ff 4d f8             	decl   -0x8(%ebp)
  801004:	ff 4d fc             	decl   -0x4(%ebp)
  801007:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80100a:	8a 10                	mov    (%eax),%dl
  80100c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801011:	8b 45 10             	mov    0x10(%ebp),%eax
  801014:	8d 50 ff             	lea    -0x1(%eax),%edx
  801017:	89 55 10             	mov    %edx,0x10(%ebp)
  80101a:	85 c0                	test   %eax,%eax
  80101c:	75 e3                	jne    801001 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80101e:	eb 23                	jmp    801043 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801020:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801023:	8d 50 01             	lea    0x1(%eax),%edx
  801026:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801029:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80102c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80102f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801032:	8a 12                	mov    (%edx),%dl
  801034:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801036:	8b 45 10             	mov    0x10(%ebp),%eax
  801039:	8d 50 ff             	lea    -0x1(%eax),%edx
  80103c:	89 55 10             	mov    %edx,0x10(%ebp)
  80103f:	85 c0                	test   %eax,%eax
  801041:	75 dd                	jne    801020 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801046:	c9                   	leave  
  801047:	c3                   	ret    

00801048 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801048:	55                   	push   %ebp
  801049:	89 e5                	mov    %esp,%ebp
  80104b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80104e:	8b 45 08             	mov    0x8(%ebp),%eax
  801051:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801054:	8b 45 0c             	mov    0xc(%ebp),%eax
  801057:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80105a:	eb 2a                	jmp    801086 <memcmp+0x3e>
		if (*s1 != *s2)
  80105c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80105f:	8a 10                	mov    (%eax),%dl
  801061:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801064:	8a 00                	mov    (%eax),%al
  801066:	38 c2                	cmp    %al,%dl
  801068:	74 16                	je     801080 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80106a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	0f b6 d0             	movzbl %al,%edx
  801072:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801075:	8a 00                	mov    (%eax),%al
  801077:	0f b6 c0             	movzbl %al,%eax
  80107a:	29 c2                	sub    %eax,%edx
  80107c:	89 d0                	mov    %edx,%eax
  80107e:	eb 18                	jmp    801098 <memcmp+0x50>
		s1++, s2++;
  801080:	ff 45 fc             	incl   -0x4(%ebp)
  801083:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801086:	8b 45 10             	mov    0x10(%ebp),%eax
  801089:	8d 50 ff             	lea    -0x1(%eax),%edx
  80108c:	89 55 10             	mov    %edx,0x10(%ebp)
  80108f:	85 c0                	test   %eax,%eax
  801091:	75 c9                	jne    80105c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801093:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801098:	c9                   	leave  
  801099:	c3                   	ret    

0080109a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80109a:	55                   	push   %ebp
  80109b:	89 e5                	mov    %esp,%ebp
  80109d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010a0:	8b 55 08             	mov    0x8(%ebp),%edx
  8010a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a6:	01 d0                	add    %edx,%eax
  8010a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010ab:	eb 15                	jmp    8010c2 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	8a 00                	mov    (%eax),%al
  8010b2:	0f b6 d0             	movzbl %al,%edx
  8010b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b8:	0f b6 c0             	movzbl %al,%eax
  8010bb:	39 c2                	cmp    %eax,%edx
  8010bd:	74 0d                	je     8010cc <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010bf:	ff 45 08             	incl   0x8(%ebp)
  8010c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010c8:	72 e3                	jb     8010ad <memfind+0x13>
  8010ca:	eb 01                	jmp    8010cd <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010cc:	90                   	nop
	return (void *) s;
  8010cd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010d0:	c9                   	leave  
  8010d1:	c3                   	ret    

008010d2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010d2:	55                   	push   %ebp
  8010d3:	89 e5                	mov    %esp,%ebp
  8010d5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010e6:	eb 03                	jmp    8010eb <strtol+0x19>
		s++;
  8010e8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	8a 00                	mov    (%eax),%al
  8010f0:	3c 20                	cmp    $0x20,%al
  8010f2:	74 f4                	je     8010e8 <strtol+0x16>
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	8a 00                	mov    (%eax),%al
  8010f9:	3c 09                	cmp    $0x9,%al
  8010fb:	74 eb                	je     8010e8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	8a 00                	mov    (%eax),%al
  801102:	3c 2b                	cmp    $0x2b,%al
  801104:	75 05                	jne    80110b <strtol+0x39>
		s++;
  801106:	ff 45 08             	incl   0x8(%ebp)
  801109:	eb 13                	jmp    80111e <strtol+0x4c>
	else if (*s == '-')
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	8a 00                	mov    (%eax),%al
  801110:	3c 2d                	cmp    $0x2d,%al
  801112:	75 0a                	jne    80111e <strtol+0x4c>
		s++, neg = 1;
  801114:	ff 45 08             	incl   0x8(%ebp)
  801117:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80111e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801122:	74 06                	je     80112a <strtol+0x58>
  801124:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801128:	75 20                	jne    80114a <strtol+0x78>
  80112a:	8b 45 08             	mov    0x8(%ebp),%eax
  80112d:	8a 00                	mov    (%eax),%al
  80112f:	3c 30                	cmp    $0x30,%al
  801131:	75 17                	jne    80114a <strtol+0x78>
  801133:	8b 45 08             	mov    0x8(%ebp),%eax
  801136:	40                   	inc    %eax
  801137:	8a 00                	mov    (%eax),%al
  801139:	3c 78                	cmp    $0x78,%al
  80113b:	75 0d                	jne    80114a <strtol+0x78>
		s += 2, base = 16;
  80113d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801141:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801148:	eb 28                	jmp    801172 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80114a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80114e:	75 15                	jne    801165 <strtol+0x93>
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	8a 00                	mov    (%eax),%al
  801155:	3c 30                	cmp    $0x30,%al
  801157:	75 0c                	jne    801165 <strtol+0x93>
		s++, base = 8;
  801159:	ff 45 08             	incl   0x8(%ebp)
  80115c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801163:	eb 0d                	jmp    801172 <strtol+0xa0>
	else if (base == 0)
  801165:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801169:	75 07                	jne    801172 <strtol+0xa0>
		base = 10;
  80116b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	8a 00                	mov    (%eax),%al
  801177:	3c 2f                	cmp    $0x2f,%al
  801179:	7e 19                	jle    801194 <strtol+0xc2>
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
  80117e:	8a 00                	mov    (%eax),%al
  801180:	3c 39                	cmp    $0x39,%al
  801182:	7f 10                	jg     801194 <strtol+0xc2>
			dig = *s - '0';
  801184:	8b 45 08             	mov    0x8(%ebp),%eax
  801187:	8a 00                	mov    (%eax),%al
  801189:	0f be c0             	movsbl %al,%eax
  80118c:	83 e8 30             	sub    $0x30,%eax
  80118f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801192:	eb 42                	jmp    8011d6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801194:	8b 45 08             	mov    0x8(%ebp),%eax
  801197:	8a 00                	mov    (%eax),%al
  801199:	3c 60                	cmp    $0x60,%al
  80119b:	7e 19                	jle    8011b6 <strtol+0xe4>
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	8a 00                	mov    (%eax),%al
  8011a2:	3c 7a                	cmp    $0x7a,%al
  8011a4:	7f 10                	jg     8011b6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a9:	8a 00                	mov    (%eax),%al
  8011ab:	0f be c0             	movsbl %al,%eax
  8011ae:	83 e8 57             	sub    $0x57,%eax
  8011b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011b4:	eb 20                	jmp    8011d6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b9:	8a 00                	mov    (%eax),%al
  8011bb:	3c 40                	cmp    $0x40,%al
  8011bd:	7e 39                	jle    8011f8 <strtol+0x126>
  8011bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	3c 5a                	cmp    $0x5a,%al
  8011c6:	7f 30                	jg     8011f8 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cb:	8a 00                	mov    (%eax),%al
  8011cd:	0f be c0             	movsbl %al,%eax
  8011d0:	83 e8 37             	sub    $0x37,%eax
  8011d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011d9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011dc:	7d 19                	jge    8011f7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011de:	ff 45 08             	incl   0x8(%ebp)
  8011e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e4:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011e8:	89 c2                	mov    %eax,%edx
  8011ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011ed:	01 d0                	add    %edx,%eax
  8011ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011f2:	e9 7b ff ff ff       	jmp    801172 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011f7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011f8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011fc:	74 08                	je     801206 <strtol+0x134>
		*endptr = (char *) s;
  8011fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801201:	8b 55 08             	mov    0x8(%ebp),%edx
  801204:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801206:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80120a:	74 07                	je     801213 <strtol+0x141>
  80120c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80120f:	f7 d8                	neg    %eax
  801211:	eb 03                	jmp    801216 <strtol+0x144>
  801213:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801216:	c9                   	leave  
  801217:	c3                   	ret    

00801218 <ltostr>:

void
ltostr(long value, char *str)
{
  801218:	55                   	push   %ebp
  801219:	89 e5                	mov    %esp,%ebp
  80121b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80121e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801225:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80122c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801230:	79 13                	jns    801245 <ltostr+0x2d>
	{
		neg = 1;
  801232:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801239:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80123f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801242:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801245:	8b 45 08             	mov    0x8(%ebp),%eax
  801248:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80124d:	99                   	cltd   
  80124e:	f7 f9                	idiv   %ecx
  801250:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801253:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801256:	8d 50 01             	lea    0x1(%eax),%edx
  801259:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80125c:	89 c2                	mov    %eax,%edx
  80125e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801261:	01 d0                	add    %edx,%eax
  801263:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801266:	83 c2 30             	add    $0x30,%edx
  801269:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80126b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80126e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801273:	f7 e9                	imul   %ecx
  801275:	c1 fa 02             	sar    $0x2,%edx
  801278:	89 c8                	mov    %ecx,%eax
  80127a:	c1 f8 1f             	sar    $0x1f,%eax
  80127d:	29 c2                	sub    %eax,%edx
  80127f:	89 d0                	mov    %edx,%eax
  801281:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801284:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801288:	75 bb                	jne    801245 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80128a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801291:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801294:	48                   	dec    %eax
  801295:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801298:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80129c:	74 3d                	je     8012db <ltostr+0xc3>
		start = 1 ;
  80129e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012a5:	eb 34                	jmp    8012db <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8012a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ad:	01 d0                	add    %edx,%eax
  8012af:	8a 00                	mov    (%eax),%al
  8012b1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ba:	01 c2                	add    %eax,%edx
  8012bc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c2:	01 c8                	add    %ecx,%eax
  8012c4:	8a 00                	mov    (%eax),%al
  8012c6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ce:	01 c2                	add    %eax,%edx
  8012d0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012d3:	88 02                	mov    %al,(%edx)
		start++ ;
  8012d5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012d8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012e1:	7c c4                	jl     8012a7 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e9:	01 d0                	add    %edx,%eax
  8012eb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012ee:	90                   	nop
  8012ef:	c9                   	leave  
  8012f0:	c3                   	ret    

008012f1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012f1:	55                   	push   %ebp
  8012f2:	89 e5                	mov    %esp,%ebp
  8012f4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012f7:	ff 75 08             	pushl  0x8(%ebp)
  8012fa:	e8 c4 f9 ff ff       	call   800cc3 <strlen>
  8012ff:	83 c4 04             	add    $0x4,%esp
  801302:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801305:	ff 75 0c             	pushl  0xc(%ebp)
  801308:	e8 b6 f9 ff ff       	call   800cc3 <strlen>
  80130d:	83 c4 04             	add    $0x4,%esp
  801310:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801313:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80131a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801321:	eb 17                	jmp    80133a <strcconcat+0x49>
		final[s] = str1[s] ;
  801323:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801326:	8b 45 10             	mov    0x10(%ebp),%eax
  801329:	01 c2                	add    %eax,%edx
  80132b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80132e:	8b 45 08             	mov    0x8(%ebp),%eax
  801331:	01 c8                	add    %ecx,%eax
  801333:	8a 00                	mov    (%eax),%al
  801335:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801337:	ff 45 fc             	incl   -0x4(%ebp)
  80133a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80133d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801340:	7c e1                	jl     801323 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801342:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801349:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801350:	eb 1f                	jmp    801371 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801352:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801355:	8d 50 01             	lea    0x1(%eax),%edx
  801358:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80135b:	89 c2                	mov    %eax,%edx
  80135d:	8b 45 10             	mov    0x10(%ebp),%eax
  801360:	01 c2                	add    %eax,%edx
  801362:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801365:	8b 45 0c             	mov    0xc(%ebp),%eax
  801368:	01 c8                	add    %ecx,%eax
  80136a:	8a 00                	mov    (%eax),%al
  80136c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80136e:	ff 45 f8             	incl   -0x8(%ebp)
  801371:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801374:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801377:	7c d9                	jl     801352 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801379:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80137c:	8b 45 10             	mov    0x10(%ebp),%eax
  80137f:	01 d0                	add    %edx,%eax
  801381:	c6 00 00             	movb   $0x0,(%eax)
}
  801384:	90                   	nop
  801385:	c9                   	leave  
  801386:	c3                   	ret    

00801387 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801387:	55                   	push   %ebp
  801388:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80138a:	8b 45 14             	mov    0x14(%ebp),%eax
  80138d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801393:	8b 45 14             	mov    0x14(%ebp),%eax
  801396:	8b 00                	mov    (%eax),%eax
  801398:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80139f:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a2:	01 d0                	add    %edx,%eax
  8013a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013aa:	eb 0c                	jmp    8013b8 <strsplit+0x31>
			*string++ = 0;
  8013ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8013af:	8d 50 01             	lea    0x1(%eax),%edx
  8013b2:	89 55 08             	mov    %edx,0x8(%ebp)
  8013b5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bb:	8a 00                	mov    (%eax),%al
  8013bd:	84 c0                	test   %al,%al
  8013bf:	74 18                	je     8013d9 <strsplit+0x52>
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	8a 00                	mov    (%eax),%al
  8013c6:	0f be c0             	movsbl %al,%eax
  8013c9:	50                   	push   %eax
  8013ca:	ff 75 0c             	pushl  0xc(%ebp)
  8013cd:	e8 83 fa ff ff       	call   800e55 <strchr>
  8013d2:	83 c4 08             	add    $0x8,%esp
  8013d5:	85 c0                	test   %eax,%eax
  8013d7:	75 d3                	jne    8013ac <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8013d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dc:	8a 00                	mov    (%eax),%al
  8013de:	84 c0                	test   %al,%al
  8013e0:	74 5a                	je     80143c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8013e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8013e5:	8b 00                	mov    (%eax),%eax
  8013e7:	83 f8 0f             	cmp    $0xf,%eax
  8013ea:	75 07                	jne    8013f3 <strsplit+0x6c>
		{
			return 0;
  8013ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8013f1:	eb 66                	jmp    801459 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8013f6:	8b 00                	mov    (%eax),%eax
  8013f8:	8d 48 01             	lea    0x1(%eax),%ecx
  8013fb:	8b 55 14             	mov    0x14(%ebp),%edx
  8013fe:	89 0a                	mov    %ecx,(%edx)
  801400:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801407:	8b 45 10             	mov    0x10(%ebp),%eax
  80140a:	01 c2                	add    %eax,%edx
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801411:	eb 03                	jmp    801416 <strsplit+0x8f>
			string++;
  801413:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	8a 00                	mov    (%eax),%al
  80141b:	84 c0                	test   %al,%al
  80141d:	74 8b                	je     8013aa <strsplit+0x23>
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	0f be c0             	movsbl %al,%eax
  801427:	50                   	push   %eax
  801428:	ff 75 0c             	pushl  0xc(%ebp)
  80142b:	e8 25 fa ff ff       	call   800e55 <strchr>
  801430:	83 c4 08             	add    $0x8,%esp
  801433:	85 c0                	test   %eax,%eax
  801435:	74 dc                	je     801413 <strsplit+0x8c>
			string++;
	}
  801437:	e9 6e ff ff ff       	jmp    8013aa <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80143c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80143d:	8b 45 14             	mov    0x14(%ebp),%eax
  801440:	8b 00                	mov    (%eax),%eax
  801442:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801449:	8b 45 10             	mov    0x10(%ebp),%eax
  80144c:	01 d0                	add    %edx,%eax
  80144e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801454:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801459:	c9                   	leave  
  80145a:	c3                   	ret    

0080145b <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80145b:	55                   	push   %ebp
  80145c:	89 e5                	mov    %esp,%ebp
  80145e:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801467:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80146e:	eb 4a                	jmp    8014ba <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801470:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801473:	8b 45 08             	mov    0x8(%ebp),%eax
  801476:	01 c2                	add    %eax,%edx
  801478:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80147b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147e:	01 c8                	add    %ecx,%eax
  801480:	8a 00                	mov    (%eax),%al
  801482:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801484:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801487:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148a:	01 d0                	add    %edx,%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	3c 40                	cmp    $0x40,%al
  801490:	7e 25                	jle    8014b7 <str2lower+0x5c>
  801492:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801495:	8b 45 0c             	mov    0xc(%ebp),%eax
  801498:	01 d0                	add    %edx,%eax
  80149a:	8a 00                	mov    (%eax),%al
  80149c:	3c 5a                	cmp    $0x5a,%al
  80149e:	7f 17                	jg     8014b7 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8014a0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	01 d0                	add    %edx,%eax
  8014a8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8014ae:	01 ca                	add    %ecx,%edx
  8014b0:	8a 12                	mov    (%edx),%dl
  8014b2:	83 c2 20             	add    $0x20,%edx
  8014b5:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8014b7:	ff 45 fc             	incl   -0x4(%ebp)
  8014ba:	ff 75 0c             	pushl  0xc(%ebp)
  8014bd:	e8 01 f8 ff ff       	call   800cc3 <strlen>
  8014c2:	83 c4 04             	add    $0x4,%esp
  8014c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8014c8:	7f a6                	jg     801470 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8014ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014cd:	c9                   	leave  
  8014ce:	c3                   	ret    

008014cf <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
  8014d2:	57                   	push   %edi
  8014d3:	56                   	push   %esi
  8014d4:	53                   	push   %ebx
  8014d5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014de:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014e1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014e4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014e7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014ea:	cd 30                	int    $0x30
  8014ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014f2:	83 c4 10             	add    $0x10,%esp
  8014f5:	5b                   	pop    %ebx
  8014f6:	5e                   	pop    %esi
  8014f7:	5f                   	pop    %edi
  8014f8:	5d                   	pop    %ebp
  8014f9:	c3                   	ret    

008014fa <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
  8014fd:	83 ec 04             	sub    $0x4,%esp
  801500:	8b 45 10             	mov    0x10(%ebp),%eax
  801503:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801506:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801509:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
  801510:	6a 00                	push   $0x0
  801512:	51                   	push   %ecx
  801513:	52                   	push   %edx
  801514:	ff 75 0c             	pushl  0xc(%ebp)
  801517:	50                   	push   %eax
  801518:	6a 00                	push   $0x0
  80151a:	e8 b0 ff ff ff       	call   8014cf <syscall>
  80151f:	83 c4 18             	add    $0x18,%esp
}
  801522:	90                   	nop
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <sys_cgetc>:

int
sys_cgetc(void)
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 02                	push   $0x2
  801534:	e8 96 ff ff ff       	call   8014cf <syscall>
  801539:	83 c4 18             	add    $0x18,%esp
}
  80153c:	c9                   	leave  
  80153d:	c3                   	ret    

0080153e <sys_lock_cons>:

void sys_lock_cons(void)
{
  80153e:	55                   	push   %ebp
  80153f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 03                	push   $0x3
  80154d:	e8 7d ff ff ff       	call   8014cf <syscall>
  801552:	83 c4 18             	add    $0x18,%esp
}
  801555:	90                   	nop
  801556:	c9                   	leave  
  801557:	c3                   	ret    

00801558 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 04                	push   $0x4
  801567:	e8 63 ff ff ff       	call   8014cf <syscall>
  80156c:	83 c4 18             	add    $0x18,%esp
}
  80156f:	90                   	nop
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801575:	8b 55 0c             	mov    0xc(%ebp),%edx
  801578:	8b 45 08             	mov    0x8(%ebp),%eax
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	52                   	push   %edx
  801582:	50                   	push   %eax
  801583:	6a 08                	push   $0x8
  801585:	e8 45 ff ff ff       	call   8014cf <syscall>
  80158a:	83 c4 18             	add    $0x18,%esp
}
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
  801592:	56                   	push   %esi
  801593:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801594:	8b 75 18             	mov    0x18(%ebp),%esi
  801597:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80159a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80159d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a3:	56                   	push   %esi
  8015a4:	53                   	push   %ebx
  8015a5:	51                   	push   %ecx
  8015a6:	52                   	push   %edx
  8015a7:	50                   	push   %eax
  8015a8:	6a 09                	push   $0x9
  8015aa:	e8 20 ff ff ff       	call   8014cf <syscall>
  8015af:	83 c4 18             	add    $0x18,%esp
}
  8015b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015b5:	5b                   	pop    %ebx
  8015b6:	5e                   	pop    %esi
  8015b7:	5d                   	pop    %ebp
  8015b8:	c3                   	ret    

008015b9 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	ff 75 08             	pushl  0x8(%ebp)
  8015c7:	6a 0a                	push   $0xa
  8015c9:	e8 01 ff ff ff       	call   8014cf <syscall>
  8015ce:	83 c4 18             	add    $0x18,%esp
}
  8015d1:	c9                   	leave  
  8015d2:	c3                   	ret    

008015d3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8015d3:	55                   	push   %ebp
  8015d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	ff 75 0c             	pushl  0xc(%ebp)
  8015df:	ff 75 08             	pushl  0x8(%ebp)
  8015e2:	6a 0b                	push   $0xb
  8015e4:	e8 e6 fe ff ff       	call   8014cf <syscall>
  8015e9:	83 c4 18             	add    $0x18,%esp
}
  8015ec:	c9                   	leave  
  8015ed:	c3                   	ret    

008015ee <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015ee:	55                   	push   %ebp
  8015ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 0c                	push   $0xc
  8015fd:	e8 cd fe ff ff       	call   8014cf <syscall>
  801602:	83 c4 18             	add    $0x18,%esp
}
  801605:	c9                   	leave  
  801606:	c3                   	ret    

00801607 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801607:	55                   	push   %ebp
  801608:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 0d                	push   $0xd
  801616:	e8 b4 fe ff ff       	call   8014cf <syscall>
  80161b:	83 c4 18             	add    $0x18,%esp
}
  80161e:	c9                   	leave  
  80161f:	c3                   	ret    

00801620 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801620:	55                   	push   %ebp
  801621:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 0e                	push   $0xe
  80162f:	e8 9b fe ff ff       	call   8014cf <syscall>
  801634:	83 c4 18             	add    $0x18,%esp
}
  801637:	c9                   	leave  
  801638:	c3                   	ret    

00801639 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801639:	55                   	push   %ebp
  80163a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 0f                	push   $0xf
  801648:	e8 82 fe ff ff       	call   8014cf <syscall>
  80164d:	83 c4 18             	add    $0x18,%esp
}
  801650:	c9                   	leave  
  801651:	c3                   	ret    

00801652 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801652:	55                   	push   %ebp
  801653:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	ff 75 08             	pushl  0x8(%ebp)
  801660:	6a 10                	push   $0x10
  801662:	e8 68 fe ff ff       	call   8014cf <syscall>
  801667:	83 c4 18             	add    $0x18,%esp
}
  80166a:	c9                   	leave  
  80166b:	c3                   	ret    

0080166c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80166c:	55                   	push   %ebp
  80166d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 11                	push   $0x11
  80167b:	e8 4f fe ff ff       	call   8014cf <syscall>
  801680:	83 c4 18             	add    $0x18,%esp
}
  801683:	90                   	nop
  801684:	c9                   	leave  
  801685:	c3                   	ret    

00801686 <sys_cputc>:

void
sys_cputc(const char c)
{
  801686:	55                   	push   %ebp
  801687:	89 e5                	mov    %esp,%ebp
  801689:	83 ec 04             	sub    $0x4,%esp
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801692:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	50                   	push   %eax
  80169f:	6a 01                	push   $0x1
  8016a1:	e8 29 fe ff ff       	call   8014cf <syscall>
  8016a6:	83 c4 18             	add    $0x18,%esp
}
  8016a9:	90                   	nop
  8016aa:	c9                   	leave  
  8016ab:	c3                   	ret    

008016ac <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 14                	push   $0x14
  8016bb:	e8 0f fe ff ff       	call   8014cf <syscall>
  8016c0:	83 c4 18             	add    $0x18,%esp
}
  8016c3:	90                   	nop
  8016c4:	c9                   	leave  
  8016c5:	c3                   	ret    

008016c6 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8016c6:	55                   	push   %ebp
  8016c7:	89 e5                	mov    %esp,%ebp
  8016c9:	83 ec 04             	sub    $0x4,%esp
  8016cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8016cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8016d2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016d5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016dc:	6a 00                	push   $0x0
  8016de:	51                   	push   %ecx
  8016df:	52                   	push   %edx
  8016e0:	ff 75 0c             	pushl  0xc(%ebp)
  8016e3:	50                   	push   %eax
  8016e4:	6a 15                	push   $0x15
  8016e6:	e8 e4 fd ff ff       	call   8014cf <syscall>
  8016eb:	83 c4 18             	add    $0x18,%esp
}
  8016ee:	c9                   	leave  
  8016ef:	c3                   	ret    

008016f0 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8016f3:	8b 55 10             	mov    0x10(%ebp),%edx
  8016f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	52                   	push   %edx
  8016fe:	50                   	push   %eax
  8016ff:	ff 75 08             	pushl  0x8(%ebp)
  801702:	6a 16                	push   $0x16
  801704:	e8 c6 fd ff ff       	call   8014cf <syscall>
  801709:	83 c4 18             	add    $0x18,%esp
}
  80170c:	c9                   	leave  
  80170d:	c3                   	ret    

0080170e <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801711:	8b 55 0c             	mov    0xc(%ebp),%edx
  801714:	8b 45 08             	mov    0x8(%ebp),%eax
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	52                   	push   %edx
  80171e:	50                   	push   %eax
  80171f:	6a 17                	push   $0x17
  801721:	e8 a9 fd ff ff       	call   8014cf <syscall>
  801726:	83 c4 18             	add    $0x18,%esp
}
  801729:	c9                   	leave  
  80172a:	c3                   	ret    

0080172b <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80172e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801731:	8b 45 08             	mov    0x8(%ebp),%eax
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	52                   	push   %edx
  80173b:	50                   	push   %eax
  80173c:	6a 18                	push   $0x18
  80173e:	e8 8c fd ff ff       	call   8014cf <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
}
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80174b:	8b 45 08             	mov    0x8(%ebp),%eax
  80174e:	6a 00                	push   $0x0
  801750:	ff 75 14             	pushl  0x14(%ebp)
  801753:	ff 75 10             	pushl  0x10(%ebp)
  801756:	ff 75 0c             	pushl  0xc(%ebp)
  801759:	50                   	push   %eax
  80175a:	6a 19                	push   $0x19
  80175c:	e8 6e fd ff ff       	call   8014cf <syscall>
  801761:	83 c4 18             	add    $0x18,%esp
}
  801764:	c9                   	leave  
  801765:	c3                   	ret    

00801766 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801766:	55                   	push   %ebp
  801767:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801769:	8b 45 08             	mov    0x8(%ebp),%eax
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	50                   	push   %eax
  801775:	6a 1a                	push   $0x1a
  801777:	e8 53 fd ff ff       	call   8014cf <syscall>
  80177c:	83 c4 18             	add    $0x18,%esp
}
  80177f:	90                   	nop
  801780:	c9                   	leave  
  801781:	c3                   	ret    

00801782 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801782:	55                   	push   %ebp
  801783:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801785:	8b 45 08             	mov    0x8(%ebp),%eax
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	50                   	push   %eax
  801791:	6a 1b                	push   $0x1b
  801793:	e8 37 fd ff ff       	call   8014cf <syscall>
  801798:	83 c4 18             	add    $0x18,%esp
}
  80179b:	c9                   	leave  
  80179c:	c3                   	ret    

0080179d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80179d:	55                   	push   %ebp
  80179e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 05                	push   $0x5
  8017ac:	e8 1e fd ff ff       	call   8014cf <syscall>
  8017b1:	83 c4 18             	add    $0x18,%esp
}
  8017b4:	c9                   	leave  
  8017b5:	c3                   	ret    

008017b6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017b6:	55                   	push   %ebp
  8017b7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 06                	push   $0x6
  8017c5:	e8 05 fd ff ff       	call   8014cf <syscall>
  8017ca:	83 c4 18             	add    $0x18,%esp
}
  8017cd:	c9                   	leave  
  8017ce:	c3                   	ret    

008017cf <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017cf:	55                   	push   %ebp
  8017d0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 07                	push   $0x7
  8017de:	e8 ec fc ff ff       	call   8014cf <syscall>
  8017e3:	83 c4 18             	add    $0x18,%esp
}
  8017e6:	c9                   	leave  
  8017e7:	c3                   	ret    

008017e8 <sys_exit_env>:


void sys_exit_env(void)
{
  8017e8:	55                   	push   %ebp
  8017e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 1c                	push   $0x1c
  8017f7:	e8 d3 fc ff ff       	call   8014cf <syscall>
  8017fc:	83 c4 18             	add    $0x18,%esp
}
  8017ff:	90                   	nop
  801800:	c9                   	leave  
  801801:	c3                   	ret    

00801802 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801802:	55                   	push   %ebp
  801803:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	ff 75 10             	pushl  0x10(%ebp)
  80180c:	ff 75 0c             	pushl  0xc(%ebp)
  80180f:	ff 75 08             	pushl  0x8(%ebp)
  801812:	6a 13                	push   $0x13
  801814:	e8 b6 fc ff ff       	call   8014cf <syscall>
  801819:	83 c4 18             	add    $0x18,%esp
	return ;
  80181c:	90                   	nop
}
  80181d:	c9                   	leave  
  80181e:	c3                   	ret    

0080181f <sys_rcr2>:
uint32 sys_rcr2()
{
  80181f:	55                   	push   %ebp
  801820:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 1e                	push   $0x1e
  80182e:	e8 9c fc ff ff       	call   8014cf <syscall>
  801833:	83 c4 18             	add    $0x18,%esp
}
  801836:	c9                   	leave  
  801837:	c3                   	ret    

00801838 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801838:	55                   	push   %ebp
  801839:	89 e5                	mov    %esp,%ebp
  80183b:	83 ec 04             	sub    $0x4,%esp
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801844:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	50                   	push   %eax
  801851:	6a 1f                	push   $0x1f
  801853:	e8 77 fc ff ff       	call   8014cf <syscall>
  801858:	83 c4 18             	add    $0x18,%esp
	return ;
  80185b:	90                   	nop
}
  80185c:	c9                   	leave  
  80185d:	c3                   	ret    

0080185e <rsttst>:
void rsttst()
{
  80185e:	55                   	push   %ebp
  80185f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 21                	push   $0x21
  80186d:	e8 5d fc ff ff       	call   8014cf <syscall>
  801872:	83 c4 18             	add    $0x18,%esp
	return ;
  801875:	90                   	nop
}
  801876:	c9                   	leave  
  801877:	c3                   	ret    

00801878 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801878:	55                   	push   %ebp
  801879:	89 e5                	mov    %esp,%ebp
  80187b:	83 ec 04             	sub    $0x4,%esp
  80187e:	8b 45 14             	mov    0x14(%ebp),%eax
  801881:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801884:	8b 55 18             	mov    0x18(%ebp),%edx
  801887:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80188b:	52                   	push   %edx
  80188c:	50                   	push   %eax
  80188d:	ff 75 10             	pushl  0x10(%ebp)
  801890:	ff 75 0c             	pushl  0xc(%ebp)
  801893:	ff 75 08             	pushl  0x8(%ebp)
  801896:	6a 20                	push   $0x20
  801898:	e8 32 fc ff ff       	call   8014cf <syscall>
  80189d:	83 c4 18             	add    $0x18,%esp
	return ;
  8018a0:	90                   	nop
}
  8018a1:	c9                   	leave  
  8018a2:	c3                   	ret    

008018a3 <chktst>:
void chktst(uint32 n)
{
  8018a3:	55                   	push   %ebp
  8018a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	ff 75 08             	pushl  0x8(%ebp)
  8018b1:	6a 22                	push   $0x22
  8018b3:	e8 17 fc ff ff       	call   8014cf <syscall>
  8018b8:	83 c4 18             	add    $0x18,%esp
	return ;
  8018bb:	90                   	nop
}
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <inctst>:

void inctst()
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 23                	push   $0x23
  8018cd:	e8 fd fb ff ff       	call   8014cf <syscall>
  8018d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d5:	90                   	nop
}
  8018d6:	c9                   	leave  
  8018d7:	c3                   	ret    

008018d8 <gettst>:
uint32 gettst()
{
  8018d8:	55                   	push   %ebp
  8018d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 24                	push   $0x24
  8018e7:	e8 e3 fb ff ff       	call   8014cf <syscall>
  8018ec:	83 c4 18             	add    $0x18,%esp
}
  8018ef:	c9                   	leave  
  8018f0:	c3                   	ret    

008018f1 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8018f1:	55                   	push   %ebp
  8018f2:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 25                	push   $0x25
  801900:	e8 ca fb ff ff       	call   8014cf <syscall>
  801905:	83 c4 18             	add    $0x18,%esp
  801908:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  80190d:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801912:	c9                   	leave  
  801913:	c3                   	ret    

00801914 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801914:	55                   	push   %ebp
  801915:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801917:	8b 45 08             	mov    0x8(%ebp),%eax
  80191a:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	ff 75 08             	pushl  0x8(%ebp)
  80192a:	6a 26                	push   $0x26
  80192c:	e8 9e fb ff ff       	call   8014cf <syscall>
  801931:	83 c4 18             	add    $0x18,%esp
	return ;
  801934:	90                   	nop
}
  801935:	c9                   	leave  
  801936:	c3                   	ret    

00801937 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801937:	55                   	push   %ebp
  801938:	89 e5                	mov    %esp,%ebp
  80193a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80193b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80193e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801941:	8b 55 0c             	mov    0xc(%ebp),%edx
  801944:	8b 45 08             	mov    0x8(%ebp),%eax
  801947:	6a 00                	push   $0x0
  801949:	53                   	push   %ebx
  80194a:	51                   	push   %ecx
  80194b:	52                   	push   %edx
  80194c:	50                   	push   %eax
  80194d:	6a 27                	push   $0x27
  80194f:	e8 7b fb ff ff       	call   8014cf <syscall>
  801954:	83 c4 18             	add    $0x18,%esp
}
  801957:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80195a:	c9                   	leave  
  80195b:	c3                   	ret    

0080195c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80195c:	55                   	push   %ebp
  80195d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80195f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801962:	8b 45 08             	mov    0x8(%ebp),%eax
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	52                   	push   %edx
  80196c:	50                   	push   %eax
  80196d:	6a 28                	push   $0x28
  80196f:	e8 5b fb ff ff       	call   8014cf <syscall>
  801974:	83 c4 18             	add    $0x18,%esp
}
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80197c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80197f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801982:	8b 45 08             	mov    0x8(%ebp),%eax
  801985:	6a 00                	push   $0x0
  801987:	51                   	push   %ecx
  801988:	ff 75 10             	pushl  0x10(%ebp)
  80198b:	52                   	push   %edx
  80198c:	50                   	push   %eax
  80198d:	6a 29                	push   $0x29
  80198f:	e8 3b fb ff ff       	call   8014cf <syscall>
  801994:	83 c4 18             	add    $0x18,%esp
}
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	ff 75 10             	pushl  0x10(%ebp)
  8019a3:	ff 75 0c             	pushl  0xc(%ebp)
  8019a6:	ff 75 08             	pushl  0x8(%ebp)
  8019a9:	6a 12                	push   $0x12
  8019ab:	e8 1f fb ff ff       	call   8014cf <syscall>
  8019b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8019b3:	90                   	nop
}
  8019b4:	c9                   	leave  
  8019b5:	c3                   	ret    

008019b6 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8019b6:	55                   	push   %ebp
  8019b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8019b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	52                   	push   %edx
  8019c6:	50                   	push   %eax
  8019c7:	6a 2a                	push   $0x2a
  8019c9:	e8 01 fb ff ff       	call   8014cf <syscall>
  8019ce:	83 c4 18             	add    $0x18,%esp
	return;
  8019d1:	90                   	nop
}
  8019d2:	c9                   	leave  
  8019d3:	c3                   	ret    

008019d4 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  8019d4:	55                   	push   %ebp
  8019d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 2b                	push   $0x2b
  8019e3:	e8 e7 fa ff ff       	call   8014cf <syscall>
  8019e8:	83 c4 18             	add    $0x18,%esp
}
  8019eb:	c9                   	leave  
  8019ec:	c3                   	ret    

008019ed <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  8019ed:	55                   	push   %ebp
  8019ee:	89 e5                	mov    %esp,%ebp
  8019f0:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8019f3:	83 ec 04             	sub    $0x4,%esp
  8019f6:	68 a8 27 80 00       	push   $0x8027a8
  8019fb:	68 0a 01 00 00       	push   $0x10a
  801a00:	68 b8 27 80 00       	push   $0x8027b8
  801a05:	e8 f6 00 00 00       	call   801b00 <_panic>

00801a0a <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801a0a:	55                   	push   %ebp
  801a0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	ff 75 0c             	pushl  0xc(%ebp)
  801a16:	ff 75 08             	pushl  0x8(%ebp)
  801a19:	6a 33                	push   $0x33
  801a1b:	e8 af fa ff ff       	call   8014cf <syscall>
  801a20:	83 c4 18             	add    $0x18,%esp
	return;
  801a23:	90                   	nop
}
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	ff 75 0c             	pushl  0xc(%ebp)
  801a32:	ff 75 08             	pushl  0x8(%ebp)
  801a35:	6a 34                	push   $0x34
  801a37:	e8 93 fa ff ff       	call   8014cf <syscall>
  801a3c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a3f:	90                   	nop
}
  801a40:	c9                   	leave  
  801a41:	c3                   	ret    

00801a42 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
  801a45:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801a48:	8b 55 08             	mov    0x8(%ebp),%edx
  801a4b:	89 d0                	mov    %edx,%eax
  801a4d:	c1 e0 02             	shl    $0x2,%eax
  801a50:	01 d0                	add    %edx,%eax
  801a52:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a59:	01 d0                	add    %edx,%eax
  801a5b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a62:	01 d0                	add    %edx,%eax
  801a64:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a6b:	01 d0                	add    %edx,%eax
  801a6d:	c1 e0 04             	shl    $0x4,%eax
  801a70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801a73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801a7a:	0f 31                	rdtsc  
  801a7c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801a7f:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801a82:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a85:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a8b:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801a8e:	eb 46                	jmp    801ad6 <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801a90:	0f 31                	rdtsc  
  801a92:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801a95:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801a98:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801a9b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801a9e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801aa1:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801aa4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801aa7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aaa:	29 c2                	sub    %eax,%edx
  801aac:	89 d0                	mov    %edx,%eax
  801aae:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801ab1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ab7:	89 d1                	mov    %edx,%ecx
  801ab9:	29 c1                	sub    %eax,%ecx
  801abb:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801abe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ac1:	39 c2                	cmp    %eax,%edx
  801ac3:	0f 97 c0             	seta   %al
  801ac6:	0f b6 c0             	movzbl %al,%eax
  801ac9:	29 c1                	sub    %eax,%ecx
  801acb:	89 c8                	mov    %ecx,%eax
  801acd:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801ad0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801ad3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801ad6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ad9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801adc:	72 b2                	jb     801a90 <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801ade:	90                   	nop
  801adf:	c9                   	leave  
  801ae0:	c3                   	ret    

00801ae1 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801ae1:	55                   	push   %ebp
  801ae2:	89 e5                	mov    %esp,%ebp
  801ae4:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801ae7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801aee:	eb 03                	jmp    801af3 <busy_wait+0x12>
  801af0:	ff 45 fc             	incl   -0x4(%ebp)
  801af3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801af6:	3b 45 08             	cmp    0x8(%ebp),%eax
  801af9:	72 f5                	jb     801af0 <busy_wait+0xf>
	return i;
  801afb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801afe:	c9                   	leave  
  801aff:	c3                   	ret    

00801b00 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801b00:	55                   	push   %ebp
  801b01:	89 e5                	mov    %esp,%ebp
  801b03:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801b06:	8d 45 10             	lea    0x10(%ebp),%eax
  801b09:	83 c0 04             	add    $0x4,%eax
  801b0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801b0f:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801b14:	85 c0                	test   %eax,%eax
  801b16:	74 16                	je     801b2e <_panic+0x2e>
		cprintf("%s: ", argv0);
  801b18:	a1 2c 31 80 00       	mov    0x80312c,%eax
  801b1d:	83 ec 08             	sub    $0x8,%esp
  801b20:	50                   	push   %eax
  801b21:	68 c8 27 80 00       	push   $0x8027c8
  801b26:	e8 bf ea ff ff       	call   8005ea <cprintf>
  801b2b:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  801b2e:	a1 04 30 80 00       	mov    0x803004,%eax
  801b33:	83 ec 0c             	sub    $0xc,%esp
  801b36:	ff 75 0c             	pushl  0xc(%ebp)
  801b39:	ff 75 08             	pushl  0x8(%ebp)
  801b3c:	50                   	push   %eax
  801b3d:	68 d0 27 80 00       	push   $0x8027d0
  801b42:	6a 74                	push   $0x74
  801b44:	e8 ce ea ff ff       	call   800617 <cprintf_colored>
  801b49:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  801b4c:	8b 45 10             	mov    0x10(%ebp),%eax
  801b4f:	83 ec 08             	sub    $0x8,%esp
  801b52:	ff 75 f4             	pushl  -0xc(%ebp)
  801b55:	50                   	push   %eax
  801b56:	e8 20 ea ff ff       	call   80057b <vcprintf>
  801b5b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801b5e:	83 ec 08             	sub    $0x8,%esp
  801b61:	6a 00                	push   $0x0
  801b63:	68 f8 27 80 00       	push   $0x8027f8
  801b68:	e8 0e ea ff ff       	call   80057b <vcprintf>
  801b6d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801b70:	e8 87 e9 ff ff       	call   8004fc <exit>

	// should not return here
	while (1) ;
  801b75:	eb fe                	jmp    801b75 <_panic+0x75>

00801b77 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801b77:	55                   	push   %ebp
  801b78:	89 e5                	mov    %esp,%ebp
  801b7a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801b7d:	a1 20 30 80 00       	mov    0x803020,%eax
  801b82:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801b88:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b8b:	39 c2                	cmp    %eax,%edx
  801b8d:	74 14                	je     801ba3 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801b8f:	83 ec 04             	sub    $0x4,%esp
  801b92:	68 fc 27 80 00       	push   $0x8027fc
  801b97:	6a 26                	push   $0x26
  801b99:	68 48 28 80 00       	push   $0x802848
  801b9e:	e8 5d ff ff ff       	call   801b00 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801ba3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801baa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801bb1:	e9 c5 00 00 00       	jmp    801c7b <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  801bb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bb9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc3:	01 d0                	add    %edx,%eax
  801bc5:	8b 00                	mov    (%eax),%eax
  801bc7:	85 c0                	test   %eax,%eax
  801bc9:	75 08                	jne    801bd3 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  801bcb:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801bce:	e9 a5 00 00 00       	jmp    801c78 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  801bd3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801bda:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801be1:	eb 69                	jmp    801c4c <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801be3:	a1 20 30 80 00       	mov    0x803020,%eax
  801be8:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801bee:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801bf1:	89 d0                	mov    %edx,%eax
  801bf3:	01 c0                	add    %eax,%eax
  801bf5:	01 d0                	add    %edx,%eax
  801bf7:	c1 e0 03             	shl    $0x3,%eax
  801bfa:	01 c8                	add    %ecx,%eax
  801bfc:	8a 40 04             	mov    0x4(%eax),%al
  801bff:	84 c0                	test   %al,%al
  801c01:	75 46                	jne    801c49 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c03:	a1 20 30 80 00       	mov    0x803020,%eax
  801c08:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801c0e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c11:	89 d0                	mov    %edx,%eax
  801c13:	01 c0                	add    %eax,%eax
  801c15:	01 d0                	add    %edx,%eax
  801c17:	c1 e0 03             	shl    $0x3,%eax
  801c1a:	01 c8                	add    %ecx,%eax
  801c1c:	8b 00                	mov    (%eax),%eax
  801c1e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801c21:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c24:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801c29:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801c2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c2e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801c35:	8b 45 08             	mov    0x8(%ebp),%eax
  801c38:	01 c8                	add    %ecx,%eax
  801c3a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c3c:	39 c2                	cmp    %eax,%edx
  801c3e:	75 09                	jne    801c49 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  801c40:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801c47:	eb 15                	jmp    801c5e <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c49:	ff 45 e8             	incl   -0x18(%ebp)
  801c4c:	a1 20 30 80 00       	mov    0x803020,%eax
  801c51:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801c57:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c5a:	39 c2                	cmp    %eax,%edx
  801c5c:	77 85                	ja     801be3 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801c5e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801c62:	75 14                	jne    801c78 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  801c64:	83 ec 04             	sub    $0x4,%esp
  801c67:	68 54 28 80 00       	push   $0x802854
  801c6c:	6a 3a                	push   $0x3a
  801c6e:	68 48 28 80 00       	push   $0x802848
  801c73:	e8 88 fe ff ff       	call   801b00 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801c78:	ff 45 f0             	incl   -0x10(%ebp)
  801c7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c7e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801c81:	0f 8c 2f ff ff ff    	jl     801bb6 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801c87:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c8e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801c95:	eb 26                	jmp    801cbd <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801c97:	a1 20 30 80 00       	mov    0x803020,%eax
  801c9c:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  801ca2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ca5:	89 d0                	mov    %edx,%eax
  801ca7:	01 c0                	add    %eax,%eax
  801ca9:	01 d0                	add    %edx,%eax
  801cab:	c1 e0 03             	shl    $0x3,%eax
  801cae:	01 c8                	add    %ecx,%eax
  801cb0:	8a 40 04             	mov    0x4(%eax),%al
  801cb3:	3c 01                	cmp    $0x1,%al
  801cb5:	75 03                	jne    801cba <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  801cb7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801cba:	ff 45 e0             	incl   -0x20(%ebp)
  801cbd:	a1 20 30 80 00       	mov    0x803020,%eax
  801cc2:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  801cc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ccb:	39 c2                	cmp    %eax,%edx
  801ccd:	77 c8                	ja     801c97 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801ccf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cd2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801cd5:	74 14                	je     801ceb <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  801cd7:	83 ec 04             	sub    $0x4,%esp
  801cda:	68 a8 28 80 00       	push   $0x8028a8
  801cdf:	6a 44                	push   $0x44
  801ce1:	68 48 28 80 00       	push   $0x802848
  801ce6:	e8 15 fe ff ff       	call   801b00 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801ceb:	90                   	nop
  801cec:	c9                   	leave  
  801ced:	c3                   	ret    
  801cee:	66 90                	xchg   %ax,%ax

00801cf0 <__udivdi3>:
  801cf0:	55                   	push   %ebp
  801cf1:	57                   	push   %edi
  801cf2:	56                   	push   %esi
  801cf3:	53                   	push   %ebx
  801cf4:	83 ec 1c             	sub    $0x1c,%esp
  801cf7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801cfb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801cff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d03:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d07:	89 ca                	mov    %ecx,%edx
  801d09:	89 f8                	mov    %edi,%eax
  801d0b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d0f:	85 f6                	test   %esi,%esi
  801d11:	75 2d                	jne    801d40 <__udivdi3+0x50>
  801d13:	39 cf                	cmp    %ecx,%edi
  801d15:	77 65                	ja     801d7c <__udivdi3+0x8c>
  801d17:	89 fd                	mov    %edi,%ebp
  801d19:	85 ff                	test   %edi,%edi
  801d1b:	75 0b                	jne    801d28 <__udivdi3+0x38>
  801d1d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d22:	31 d2                	xor    %edx,%edx
  801d24:	f7 f7                	div    %edi
  801d26:	89 c5                	mov    %eax,%ebp
  801d28:	31 d2                	xor    %edx,%edx
  801d2a:	89 c8                	mov    %ecx,%eax
  801d2c:	f7 f5                	div    %ebp
  801d2e:	89 c1                	mov    %eax,%ecx
  801d30:	89 d8                	mov    %ebx,%eax
  801d32:	f7 f5                	div    %ebp
  801d34:	89 cf                	mov    %ecx,%edi
  801d36:	89 fa                	mov    %edi,%edx
  801d38:	83 c4 1c             	add    $0x1c,%esp
  801d3b:	5b                   	pop    %ebx
  801d3c:	5e                   	pop    %esi
  801d3d:	5f                   	pop    %edi
  801d3e:	5d                   	pop    %ebp
  801d3f:	c3                   	ret    
  801d40:	39 ce                	cmp    %ecx,%esi
  801d42:	77 28                	ja     801d6c <__udivdi3+0x7c>
  801d44:	0f bd fe             	bsr    %esi,%edi
  801d47:	83 f7 1f             	xor    $0x1f,%edi
  801d4a:	75 40                	jne    801d8c <__udivdi3+0x9c>
  801d4c:	39 ce                	cmp    %ecx,%esi
  801d4e:	72 0a                	jb     801d5a <__udivdi3+0x6a>
  801d50:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d54:	0f 87 9e 00 00 00    	ja     801df8 <__udivdi3+0x108>
  801d5a:	b8 01 00 00 00       	mov    $0x1,%eax
  801d5f:	89 fa                	mov    %edi,%edx
  801d61:	83 c4 1c             	add    $0x1c,%esp
  801d64:	5b                   	pop    %ebx
  801d65:	5e                   	pop    %esi
  801d66:	5f                   	pop    %edi
  801d67:	5d                   	pop    %ebp
  801d68:	c3                   	ret    
  801d69:	8d 76 00             	lea    0x0(%esi),%esi
  801d6c:	31 ff                	xor    %edi,%edi
  801d6e:	31 c0                	xor    %eax,%eax
  801d70:	89 fa                	mov    %edi,%edx
  801d72:	83 c4 1c             	add    $0x1c,%esp
  801d75:	5b                   	pop    %ebx
  801d76:	5e                   	pop    %esi
  801d77:	5f                   	pop    %edi
  801d78:	5d                   	pop    %ebp
  801d79:	c3                   	ret    
  801d7a:	66 90                	xchg   %ax,%ax
  801d7c:	89 d8                	mov    %ebx,%eax
  801d7e:	f7 f7                	div    %edi
  801d80:	31 ff                	xor    %edi,%edi
  801d82:	89 fa                	mov    %edi,%edx
  801d84:	83 c4 1c             	add    $0x1c,%esp
  801d87:	5b                   	pop    %ebx
  801d88:	5e                   	pop    %esi
  801d89:	5f                   	pop    %edi
  801d8a:	5d                   	pop    %ebp
  801d8b:	c3                   	ret    
  801d8c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d91:	89 eb                	mov    %ebp,%ebx
  801d93:	29 fb                	sub    %edi,%ebx
  801d95:	89 f9                	mov    %edi,%ecx
  801d97:	d3 e6                	shl    %cl,%esi
  801d99:	89 c5                	mov    %eax,%ebp
  801d9b:	88 d9                	mov    %bl,%cl
  801d9d:	d3 ed                	shr    %cl,%ebp
  801d9f:	89 e9                	mov    %ebp,%ecx
  801da1:	09 f1                	or     %esi,%ecx
  801da3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801da7:	89 f9                	mov    %edi,%ecx
  801da9:	d3 e0                	shl    %cl,%eax
  801dab:	89 c5                	mov    %eax,%ebp
  801dad:	89 d6                	mov    %edx,%esi
  801daf:	88 d9                	mov    %bl,%cl
  801db1:	d3 ee                	shr    %cl,%esi
  801db3:	89 f9                	mov    %edi,%ecx
  801db5:	d3 e2                	shl    %cl,%edx
  801db7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dbb:	88 d9                	mov    %bl,%cl
  801dbd:	d3 e8                	shr    %cl,%eax
  801dbf:	09 c2                	or     %eax,%edx
  801dc1:	89 d0                	mov    %edx,%eax
  801dc3:	89 f2                	mov    %esi,%edx
  801dc5:	f7 74 24 0c          	divl   0xc(%esp)
  801dc9:	89 d6                	mov    %edx,%esi
  801dcb:	89 c3                	mov    %eax,%ebx
  801dcd:	f7 e5                	mul    %ebp
  801dcf:	39 d6                	cmp    %edx,%esi
  801dd1:	72 19                	jb     801dec <__udivdi3+0xfc>
  801dd3:	74 0b                	je     801de0 <__udivdi3+0xf0>
  801dd5:	89 d8                	mov    %ebx,%eax
  801dd7:	31 ff                	xor    %edi,%edi
  801dd9:	e9 58 ff ff ff       	jmp    801d36 <__udivdi3+0x46>
  801dde:	66 90                	xchg   %ax,%ax
  801de0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801de4:	89 f9                	mov    %edi,%ecx
  801de6:	d3 e2                	shl    %cl,%edx
  801de8:	39 c2                	cmp    %eax,%edx
  801dea:	73 e9                	jae    801dd5 <__udivdi3+0xe5>
  801dec:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801def:	31 ff                	xor    %edi,%edi
  801df1:	e9 40 ff ff ff       	jmp    801d36 <__udivdi3+0x46>
  801df6:	66 90                	xchg   %ax,%ax
  801df8:	31 c0                	xor    %eax,%eax
  801dfa:	e9 37 ff ff ff       	jmp    801d36 <__udivdi3+0x46>
  801dff:	90                   	nop

00801e00 <__umoddi3>:
  801e00:	55                   	push   %ebp
  801e01:	57                   	push   %edi
  801e02:	56                   	push   %esi
  801e03:	53                   	push   %ebx
  801e04:	83 ec 1c             	sub    $0x1c,%esp
  801e07:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e0b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e0f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e13:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e17:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e1b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e1f:	89 f3                	mov    %esi,%ebx
  801e21:	89 fa                	mov    %edi,%edx
  801e23:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e27:	89 34 24             	mov    %esi,(%esp)
  801e2a:	85 c0                	test   %eax,%eax
  801e2c:	75 1a                	jne    801e48 <__umoddi3+0x48>
  801e2e:	39 f7                	cmp    %esi,%edi
  801e30:	0f 86 a2 00 00 00    	jbe    801ed8 <__umoddi3+0xd8>
  801e36:	89 c8                	mov    %ecx,%eax
  801e38:	89 f2                	mov    %esi,%edx
  801e3a:	f7 f7                	div    %edi
  801e3c:	89 d0                	mov    %edx,%eax
  801e3e:	31 d2                	xor    %edx,%edx
  801e40:	83 c4 1c             	add    $0x1c,%esp
  801e43:	5b                   	pop    %ebx
  801e44:	5e                   	pop    %esi
  801e45:	5f                   	pop    %edi
  801e46:	5d                   	pop    %ebp
  801e47:	c3                   	ret    
  801e48:	39 f0                	cmp    %esi,%eax
  801e4a:	0f 87 ac 00 00 00    	ja     801efc <__umoddi3+0xfc>
  801e50:	0f bd e8             	bsr    %eax,%ebp
  801e53:	83 f5 1f             	xor    $0x1f,%ebp
  801e56:	0f 84 ac 00 00 00    	je     801f08 <__umoddi3+0x108>
  801e5c:	bf 20 00 00 00       	mov    $0x20,%edi
  801e61:	29 ef                	sub    %ebp,%edi
  801e63:	89 fe                	mov    %edi,%esi
  801e65:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e69:	89 e9                	mov    %ebp,%ecx
  801e6b:	d3 e0                	shl    %cl,%eax
  801e6d:	89 d7                	mov    %edx,%edi
  801e6f:	89 f1                	mov    %esi,%ecx
  801e71:	d3 ef                	shr    %cl,%edi
  801e73:	09 c7                	or     %eax,%edi
  801e75:	89 e9                	mov    %ebp,%ecx
  801e77:	d3 e2                	shl    %cl,%edx
  801e79:	89 14 24             	mov    %edx,(%esp)
  801e7c:	89 d8                	mov    %ebx,%eax
  801e7e:	d3 e0                	shl    %cl,%eax
  801e80:	89 c2                	mov    %eax,%edx
  801e82:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e86:	d3 e0                	shl    %cl,%eax
  801e88:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e8c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e90:	89 f1                	mov    %esi,%ecx
  801e92:	d3 e8                	shr    %cl,%eax
  801e94:	09 d0                	or     %edx,%eax
  801e96:	d3 eb                	shr    %cl,%ebx
  801e98:	89 da                	mov    %ebx,%edx
  801e9a:	f7 f7                	div    %edi
  801e9c:	89 d3                	mov    %edx,%ebx
  801e9e:	f7 24 24             	mull   (%esp)
  801ea1:	89 c6                	mov    %eax,%esi
  801ea3:	89 d1                	mov    %edx,%ecx
  801ea5:	39 d3                	cmp    %edx,%ebx
  801ea7:	0f 82 87 00 00 00    	jb     801f34 <__umoddi3+0x134>
  801ead:	0f 84 91 00 00 00    	je     801f44 <__umoddi3+0x144>
  801eb3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801eb7:	29 f2                	sub    %esi,%edx
  801eb9:	19 cb                	sbb    %ecx,%ebx
  801ebb:	89 d8                	mov    %ebx,%eax
  801ebd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ec1:	d3 e0                	shl    %cl,%eax
  801ec3:	89 e9                	mov    %ebp,%ecx
  801ec5:	d3 ea                	shr    %cl,%edx
  801ec7:	09 d0                	or     %edx,%eax
  801ec9:	89 e9                	mov    %ebp,%ecx
  801ecb:	d3 eb                	shr    %cl,%ebx
  801ecd:	89 da                	mov    %ebx,%edx
  801ecf:	83 c4 1c             	add    $0x1c,%esp
  801ed2:	5b                   	pop    %ebx
  801ed3:	5e                   	pop    %esi
  801ed4:	5f                   	pop    %edi
  801ed5:	5d                   	pop    %ebp
  801ed6:	c3                   	ret    
  801ed7:	90                   	nop
  801ed8:	89 fd                	mov    %edi,%ebp
  801eda:	85 ff                	test   %edi,%edi
  801edc:	75 0b                	jne    801ee9 <__umoddi3+0xe9>
  801ede:	b8 01 00 00 00       	mov    $0x1,%eax
  801ee3:	31 d2                	xor    %edx,%edx
  801ee5:	f7 f7                	div    %edi
  801ee7:	89 c5                	mov    %eax,%ebp
  801ee9:	89 f0                	mov    %esi,%eax
  801eeb:	31 d2                	xor    %edx,%edx
  801eed:	f7 f5                	div    %ebp
  801eef:	89 c8                	mov    %ecx,%eax
  801ef1:	f7 f5                	div    %ebp
  801ef3:	89 d0                	mov    %edx,%eax
  801ef5:	e9 44 ff ff ff       	jmp    801e3e <__umoddi3+0x3e>
  801efa:	66 90                	xchg   %ax,%ax
  801efc:	89 c8                	mov    %ecx,%eax
  801efe:	89 f2                	mov    %esi,%edx
  801f00:	83 c4 1c             	add    $0x1c,%esp
  801f03:	5b                   	pop    %ebx
  801f04:	5e                   	pop    %esi
  801f05:	5f                   	pop    %edi
  801f06:	5d                   	pop    %ebp
  801f07:	c3                   	ret    
  801f08:	3b 04 24             	cmp    (%esp),%eax
  801f0b:	72 06                	jb     801f13 <__umoddi3+0x113>
  801f0d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f11:	77 0f                	ja     801f22 <__umoddi3+0x122>
  801f13:	89 f2                	mov    %esi,%edx
  801f15:	29 f9                	sub    %edi,%ecx
  801f17:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f1b:	89 14 24             	mov    %edx,(%esp)
  801f1e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f22:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f26:	8b 14 24             	mov    (%esp),%edx
  801f29:	83 c4 1c             	add    $0x1c,%esp
  801f2c:	5b                   	pop    %ebx
  801f2d:	5e                   	pop    %esi
  801f2e:	5f                   	pop    %edi
  801f2f:	5d                   	pop    %ebp
  801f30:	c3                   	ret    
  801f31:	8d 76 00             	lea    0x0(%esi),%esi
  801f34:	2b 04 24             	sub    (%esp),%eax
  801f37:	19 fa                	sbb    %edi,%edx
  801f39:	89 d1                	mov    %edx,%ecx
  801f3b:	89 c6                	mov    %eax,%esi
  801f3d:	e9 71 ff ff ff       	jmp    801eb3 <__umoddi3+0xb3>
  801f42:	66 90                	xchg   %ax,%ax
  801f44:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f48:	72 ea                	jb     801f34 <__umoddi3+0x134>
  801f4a:	89 d9                	mov    %ebx,%ecx
  801f4c:	e9 62 ff ff ff       	jmp    801eb3 <__umoddi3+0xb3>
