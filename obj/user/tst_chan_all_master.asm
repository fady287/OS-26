
obj/user/tst_chan_all_master:     file format elf32-i386


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
  800031:	e8 4f 02 00 00       	call   800285 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#define __AUTOGRADE__ 1
extern volatile bool printStats;

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec fc 00 00 00    	sub    $0xfc,%esp
	printStats = 0;
  800044:	c7 05 00 30 80 00 00 	movl   $0x0,0x803000
  80004b:	00 00 00 

	cprintf_colored(TEXT_yellow,"==============================================\n");
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	68 40 1f 80 00       	push   $0x801f40
  800056:	6a 0e                	push   $0xe
  800058:	e8 83 07 00 00       	call   8007e0 <cprintf_colored>
  80005d:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  800060:	83 ec 08             	sub    $0x8,%esp
  800063:	68 70 1f 80 00       	push   $0x801f70
  800068:	6a 0e                	push   $0xe
  80006a:	e8 71 07 00 00       	call   8007e0 <cprintf_colored>
  80006f:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"==============================================\n");
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 40 1f 80 00       	push   $0x801f40
  80007a:	6a 0e                	push   $0xe
  80007c:	e8 5f 07 00 00       	call   8007e0 <cprintf_colored>
  800081:	83 c4 10             	add    $0x10,%esp


	int envID = sys_getenvid();
  800084:	e8 dd 18 00 00       	call   801966 <sys_getenvid>
  800089:	89 45 d8             	mov    %eax,-0x28(%ebp)
	char slavesCnt[10];
#if __AUTOGRADE__
	int numOfSlaves = 7 ;
  80008c:	c7 45 e4 07 00 00 00 	movl   $0x7,-0x1c(%ebp)
	cprintf("Enter the number of Slave Programs: %d\n", numOfSlaves);
  800093:	83 ec 08             	sub    $0x8,%esp
  800096:	ff 75 e4             	pushl  -0x1c(%ebp)
  800099:	68 cc 1f 80 00       	push   $0x801fcc
  80009e:	e8 10 07 00 00       	call   8007b3 <cprintf>
  8000a3:	83 c4 10             	add    $0x10,%esp
	int numOfSlaves = strtol(slavesCnt, NULL, 10);
#endif

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  8000a6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8000ad:	eb 68                	jmp    800117 <_main+0xdf>
	{
		id = sys_create_env("tstChanAllSlave", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000af:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b4:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8000ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8000bf:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  8000c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ca:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  8000d0:	51                   	push   %ecx
  8000d1:	52                   	push   %edx
  8000d2:	50                   	push   %eax
  8000d3:	68 f4 1f 80 00       	push   $0x801ff4
  8000d8:	e8 34 18 00 00       	call   801911 <sys_create_env>
  8000dd:	83 c4 10             	add    $0x10,%esp
  8000e0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		if (id== E_ENV_CREATION_ERROR)
  8000e3:	83 7d d4 ee          	cmpl   $0xffffffee,-0x2c(%ebp)
  8000e7:	75 1d                	jne    800106 <_main+0xce>
		{
			cprintf_colored(TEXT_TESTERR_CLR, "\n%~insufficient number of processes in the system! only %d slave processes are created\n", i);
  8000e9:	83 ec 04             	sub    $0x4,%esp
  8000ec:	ff 75 e0             	pushl  -0x20(%ebp)
  8000ef:	68 04 20 80 00       	push   $0x802004
  8000f4:	6a 0c                	push   $0xc
  8000f6:	e8 e5 06 00 00       	call   8007e0 <cprintf_colored>
  8000fb:	83 c4 10             	add    $0x10,%esp
			numOfSlaves = i;
  8000fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800101:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			break;
  800104:	eb 19                	jmp    80011f <_main+0xe7>
		}
		sys_run_env(id);
  800106:	83 ec 0c             	sub    $0xc,%esp
  800109:	ff 75 d4             	pushl  -0x2c(%ebp)
  80010c:	e8 1e 18 00 00       	call   80192f <sys_run_env>
  800111:	83 c4 10             	add    $0x10,%esp
	int numOfSlaves = strtol(slavesCnt, NULL, 10);
#endif

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  800114:	ff 45 e0             	incl   -0x20(%ebp)
  800117:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80011a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80011d:	7c 90                	jl     8000af <_main+0x77>
		}
		sys_run_env(id);
	}

	//Wait until all slaves are blocked
	int numOfBlockedProcesses = 0;
  80011f:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
	char cmd1[64] = "__GetChanQueueSize__";
  800126:	8d 45 84             	lea    -0x7c(%ebp),%eax
  800129:	bb 56 21 80 00       	mov    $0x802156,%ebx
  80012e:	ba 15 00 00 00       	mov    $0x15,%edx
  800133:	89 c7                	mov    %eax,%edi
  800135:	89 de                	mov    %ebx,%esi
  800137:	89 d1                	mov    %edx,%ecx
  800139:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80013b:	8d 55 99             	lea    -0x67(%ebp),%edx
  80013e:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  800143:	b0 00                	mov    $0x0,%al
  800145:	89 d7                	mov    %edx,%edi
  800147:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd1, (uint32)(&numOfBlockedProcesses));
  800149:	8d 45 c4             	lea    -0x3c(%ebp),%eax
  80014c:	83 ec 08             	sub    $0x8,%esp
  80014f:	50                   	push   %eax
  800150:	8d 45 84             	lea    -0x7c(%ebp),%eax
  800153:	50                   	push   %eax
  800154:	e8 26 1a 00 00       	call   801b7f <sys_utilities>
  800159:	83 c4 10             	add    $0x10,%esp
	int cnt = 0;
  80015c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	while (numOfBlockedProcesses != numOfSlaves)
  800163:	eb 75                	jmp    8001da <_main+0x1a2>
	{
		env_sleep(5000);
  800165:	83 ec 0c             	sub    $0xc,%esp
  800168:	68 88 13 00 00       	push   $0x1388
  80016d:	e8 99 1a 00 00       	call   801c0b <env_sleep>
  800172:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  800175:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800178:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80017b:	75 1b                	jne    800198 <_main+0x160>
		{
			panic("%~test channels failed! unexpected number of blocked slaves. Expected = %d, Current = %d", numOfSlaves, numOfBlockedProcesses);
  80017d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800180:	83 ec 0c             	sub    $0xc,%esp
  800183:	50                   	push   %eax
  800184:	ff 75 e4             	pushl  -0x1c(%ebp)
  800187:	68 5c 20 80 00       	push   $0x80205c
  80018c:	6a 33                	push   $0x33
  80018e:	68 b5 20 80 00       	push   $0x8020b5
  800193:	e8 4d 03 00 00       	call   8004e5 <_panic>
		}
		char cmd2[64] = "__GetChanQueueSize__";
  800198:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  80019e:	bb 56 21 80 00       	mov    $0x802156,%ebx
  8001a3:	ba 15 00 00 00       	mov    $0x15,%edx
  8001a8:	89 c7                	mov    %eax,%edi
  8001aa:	89 de                	mov    %ebx,%esi
  8001ac:	89 d1                	mov    %edx,%ecx
  8001ae:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001b0:	8d 95 19 ff ff ff    	lea    -0xe7(%ebp),%edx
  8001b6:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  8001bb:	b0 00                	mov    $0x0,%al
  8001bd:	89 d7                	mov    %edx,%edi
  8001bf:	f3 aa                	rep stos %al,%es:(%edi)
		sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
  8001c1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	50                   	push   %eax
  8001c8:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  8001ce:	50                   	push   %eax
  8001cf:	e8 ab 19 00 00       	call   801b7f <sys_utilities>
  8001d4:	83 c4 10             	add    $0x10,%esp
		cnt++ ;
  8001d7:	ff 45 dc             	incl   -0x24(%ebp)
	//Wait until all slaves are blocked
	int numOfBlockedProcesses = 0;
	char cmd1[64] = "__GetChanQueueSize__";
	sys_utilities(cmd1, (uint32)(&numOfBlockedProcesses));
	int cnt = 0;
	while (numOfBlockedProcesses != numOfSlaves)
  8001da:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001dd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8001e0:	75 83                	jne    800165 <_main+0x12d>
		char cmd2[64] = "__GetChanQueueSize__";
		sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
		cnt++ ;
	}

	rsttst();
  8001e2:	e8 40 18 00 00       	call   801a27 <rsttst>

	//Wakeup all
	char cmd3[64] = "__WakeupAll__";
  8001e7:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  8001ed:	bb 96 21 80 00       	mov    $0x802196,%ebx
  8001f2:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001f7:	89 c7                	mov    %eax,%edi
  8001f9:	89 de                	mov    %ebx,%esi
  8001fb:	89 d1                	mov    %edx,%ecx
  8001fd:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001ff:	8d 95 52 ff ff ff    	lea    -0xae(%ebp),%edx
  800205:	b9 32 00 00 00       	mov    $0x32,%ecx
  80020a:	b0 00                	mov    $0x0,%al
  80020c:	89 d7                	mov    %edx,%edi
  80020e:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd3, 0);
  800210:	83 ec 08             	sub    $0x8,%esp
  800213:	6a 00                	push   $0x0
  800215:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  80021b:	50                   	push   %eax
  80021c:	e8 5e 19 00 00       	call   801b7f <sys_utilities>
  800221:	83 c4 10             	add    $0x10,%esp

	//Wait until all slave finished
	cnt = 0;
  800224:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	while (gettst() != numOfSlaves)
  80022b:	eb 2f                	jmp    80025c <_main+0x224>
	{
		env_sleep(5000);
  80022d:	83 ec 0c             	sub    $0xc,%esp
  800230:	68 88 13 00 00       	push   $0x1388
  800235:	e8 d1 19 00 00       	call   801c0b <env_sleep>
  80023a:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  80023d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800240:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800243:	75 14                	jne    800259 <_main+0x221>
		{
			panic("%~test channels failed! not all slaves finished");
  800245:	83 ec 04             	sub    $0x4,%esp
  800248:	68 d0 20 80 00       	push   $0x8020d0
  80024d:	6a 47                	push   $0x47
  80024f:	68 b5 20 80 00       	push   $0x8020b5
  800254:	e8 8c 02 00 00       	call   8004e5 <_panic>
		}
		cnt++ ;
  800259:	ff 45 dc             	incl   -0x24(%ebp)
	char cmd3[64] = "__WakeupAll__";
	sys_utilities(cmd3, 0);

	//Wait until all slave finished
	cnt = 0;
	while (gettst() != numOfSlaves)
  80025c:	e8 40 18 00 00       	call   801aa1 <gettst>
  800261:	89 c2                	mov    %eax,%edx
  800263:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800266:	39 c2                	cmp    %eax,%edx
  800268:	75 c3                	jne    80022d <_main+0x1f5>
			panic("%~test channels failed! not all slaves finished");
		}
		cnt++ ;
	}

	cprintf_colored(TEXT_light_green, "%~\n\nCongratulations!! Test of Channel (sleep & wakeup ALL) completed successfully!!\n\n");
  80026a:	83 ec 08             	sub    $0x8,%esp
  80026d:	68 00 21 80 00       	push   $0x802100
  800272:	6a 0a                	push   $0xa
  800274:	e8 67 05 00 00       	call   8007e0 <cprintf_colored>
  800279:	83 c4 10             	add    $0x10,%esp

	return;
  80027c:	90                   	nop
}
  80027d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800280:	5b                   	pop    %ebx
  800281:	5e                   	pop    %esi
  800282:	5f                   	pop    %edi
  800283:	5d                   	pop    %ebp
  800284:	c3                   	ret    

00800285 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800285:	55                   	push   %ebp
  800286:	89 e5                	mov    %esp,%ebp
  800288:	57                   	push   %edi
  800289:	56                   	push   %esi
  80028a:	53                   	push   %ebx
  80028b:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800291:	e8 e9 16 00 00       	call   80197f <sys_getenvindex>
  800296:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800299:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80029c:	89 d0                	mov    %edx,%eax
  80029e:	c1 e0 03             	shl    $0x3,%eax
  8002a1:	01 d0                	add    %edx,%eax
  8002a3:	c1 e0 06             	shl    $0x6,%eax
  8002a6:	01 d0                	add    %edx,%eax
  8002a8:	c1 e0 03             	shl    $0x3,%eax
  8002ab:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002b0:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ba:	8a 40 10             	mov    0x10(%eax),%al
  8002bd:	84 c0                	test   %al,%al
  8002bf:	74 0d                	je     8002ce <libmain+0x49>
		binaryname = myEnv->prog_name;
  8002c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c6:	83 c0 10             	add    $0x10,%eax
  8002c9:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002ce:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002d2:	7e 0a                	jle    8002de <libmain+0x59>
		binaryname = argv[0];
  8002d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002d7:	8b 00                	mov    (%eax),%eax
  8002d9:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8002de:	83 ec 08             	sub    $0x8,%esp
  8002e1:	ff 75 0c             	pushl  0xc(%ebp)
  8002e4:	ff 75 08             	pushl  0x8(%ebp)
  8002e7:	e8 4c fd ff ff       	call   800038 <_main>
  8002ec:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  8002ef:	a1 00 30 80 00       	mov    0x803000,%eax
  8002f4:	85 c0                	test   %eax,%eax
  8002f6:	0f 84 b7 01 00 00    	je     8004b3 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  8002fc:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800302:	bb 14 23 80 00       	mov    $0x802314,%ebx
  800307:	ba 0e 00 00 00       	mov    $0xe,%edx
  80030c:	89 c7                	mov    %eax,%edi
  80030e:	89 de                	mov    %ebx,%esi
  800310:	89 d1                	mov    %edx,%ecx
  800312:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800314:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80031a:	b9 56 00 00 00       	mov    $0x56,%ecx
  80031f:	b0 00                	mov    $0x0,%al
  800321:	89 d7                	mov    %edx,%edi
  800323:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800325:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80032c:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80032f:	83 ec 08             	sub    $0x8,%esp
  800332:	50                   	push   %eax
  800333:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800339:	50                   	push   %eax
  80033a:	e8 40 18 00 00       	call   801b7f <sys_utilities>
  80033f:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800342:	e8 c0 13 00 00       	call   801707 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800347:	83 ec 0c             	sub    $0xc,%esp
  80034a:	68 f0 21 80 00       	push   $0x8021f0
  80034f:	e8 5f 04 00 00       	call   8007b3 <cprintf>
  800354:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800357:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80035a:	85 c0                	test   %eax,%eax
  80035c:	74 58                	je     8003b6 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80035e:	e8 3a 18 00 00       	call   801b9d <sys_get_optimal_num_faults>
  800363:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800366:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80036c:	bb 78 23 80 00       	mov    $0x802378,%ebx
  800371:	ba 11 00 00 00       	mov    $0x11,%edx
  800376:	89 c7                	mov    %eax,%edi
  800378:	89 de                	mov    %ebx,%esi
  80037a:	89 d1                	mov    %edx,%ecx
  80037c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80037e:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800381:	b9 53 00 00 00       	mov    $0x53,%ecx
  800386:	b0 00                	mov    $0x0,%al
  800388:	89 d7                	mov    %edx,%edi
  80038a:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80038c:	83 ec 08             	sub    $0x8,%esp
  80038f:	ff 75 dc             	pushl  -0x24(%ebp)
  800392:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800398:	50                   	push   %eax
  800399:	e8 e1 17 00 00       	call   801b7f <sys_utilities>
  80039e:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8003a1:	83 ec 08             	sub    $0x8,%esp
  8003a4:	ff 75 dc             	pushl  -0x24(%ebp)
  8003a7:	68 18 22 80 00       	push   $0x802218
  8003ac:	e8 02 04 00 00       	call   8007b3 <cprintf>
  8003b1:	83 c4 10             	add    $0x10,%esp
  8003b4:	eb 59                	jmp    80040f <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bb:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8003c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c6:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8003cc:	83 ec 04             	sub    $0x4,%esp
  8003cf:	52                   	push   %edx
  8003d0:	50                   	push   %eax
  8003d1:	68 3c 22 80 00       	push   $0x80223c
  8003d6:	e8 d8 03 00 00       	call   8007b3 <cprintf>
  8003db:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8003de:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e3:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  8003e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ee:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  8003f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f9:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  8003ff:	51                   	push   %ecx
  800400:	52                   	push   %edx
  800401:	50                   	push   %eax
  800402:	68 64 22 80 00       	push   $0x802264
  800407:	e8 a7 03 00 00       	call   8007b3 <cprintf>
  80040c:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80040f:	a1 20 30 80 00       	mov    0x803020,%eax
  800414:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80041a:	83 ec 08             	sub    $0x8,%esp
  80041d:	50                   	push   %eax
  80041e:	68 bc 22 80 00       	push   $0x8022bc
  800423:	e8 8b 03 00 00       	call   8007b3 <cprintf>
  800428:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80042b:	83 ec 0c             	sub    $0xc,%esp
  80042e:	68 d0 22 80 00       	push   $0x8022d0
  800433:	e8 7b 03 00 00       	call   8007b3 <cprintf>
  800438:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80043b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800442:	eb 28                	jmp    80046c <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800444:	a1 20 30 80 00       	mov    0x803020,%eax
  800449:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80044c:	81 c2 74 04 00 00    	add    $0x474,%edx
  800452:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800455:	83 ec 04             	sub    $0x4,%esp
  800458:	50                   	push   %eax
  800459:	ff 75 e4             	pushl  -0x1c(%ebp)
  80045c:	68 e7 22 80 00       	push   $0x8022e7
  800461:	e8 4d 03 00 00       	call   8007b3 <cprintf>
  800466:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800469:	ff 45 e4             	incl   -0x1c(%ebp)
  80046c:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800470:	7e d2                	jle    800444 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800472:	83 ec 0c             	sub    $0xc,%esp
  800475:	68 f6 22 80 00       	push   $0x8022f6
  80047a:	e8 34 03 00 00       	call   8007b3 <cprintf>
  80047f:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800482:	a1 20 30 80 00       	mov    0x803020,%eax
  800487:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80048d:	83 ec 08             	sub    $0x8,%esp
  800490:	50                   	push   %eax
  800491:	68 fa 22 80 00       	push   $0x8022fa
  800496:	e8 18 03 00 00       	call   8007b3 <cprintf>
  80049b:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80049e:	83 ec 0c             	sub    $0xc,%esp
  8004a1:	68 f0 21 80 00       	push   $0x8021f0
  8004a6:	e8 08 03 00 00       	call   8007b3 <cprintf>
  8004ab:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004ae:	e8 6e 12 00 00       	call   801721 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004b3:	e8 1f 00 00 00       	call   8004d7 <exit>
}
  8004b8:	90                   	nop
  8004b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004bc:	5b                   	pop    %ebx
  8004bd:	5e                   	pop    %esi
  8004be:	5f                   	pop    %edi
  8004bf:	5d                   	pop    %ebp
  8004c0:	c3                   	ret    

008004c1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004c1:	55                   	push   %ebp
  8004c2:	89 e5                	mov    %esp,%ebp
  8004c4:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8004c7:	83 ec 0c             	sub    $0xc,%esp
  8004ca:	6a 00                	push   $0x0
  8004cc:	e8 7a 14 00 00       	call   80194b <sys_destroy_env>
  8004d1:	83 c4 10             	add    $0x10,%esp
}
  8004d4:	90                   	nop
  8004d5:	c9                   	leave  
  8004d6:	c3                   	ret    

008004d7 <exit>:

void
exit(void)
{
  8004d7:	55                   	push   %ebp
  8004d8:	89 e5                	mov    %esp,%ebp
  8004da:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8004dd:	e8 cf 14 00 00       	call   8019b1 <sys_exit_env>
}
  8004e2:	90                   	nop
  8004e3:	c9                   	leave  
  8004e4:	c3                   	ret    

008004e5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004e5:	55                   	push   %ebp
  8004e6:	89 e5                	mov    %esp,%ebp
  8004e8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004eb:	8d 45 10             	lea    0x10(%ebp),%eax
  8004ee:	83 c0 04             	add    $0x4,%eax
  8004f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004f4:	a1 28 31 80 00       	mov    0x803128,%eax
  8004f9:	85 c0                	test   %eax,%eax
  8004fb:	74 16                	je     800513 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004fd:	a1 28 31 80 00       	mov    0x803128,%eax
  800502:	83 ec 08             	sub    $0x8,%esp
  800505:	50                   	push   %eax
  800506:	68 dc 23 80 00       	push   $0x8023dc
  80050b:	e8 a3 02 00 00       	call   8007b3 <cprintf>
  800510:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800513:	a1 04 30 80 00       	mov    0x803004,%eax
  800518:	83 ec 0c             	sub    $0xc,%esp
  80051b:	ff 75 0c             	pushl  0xc(%ebp)
  80051e:	ff 75 08             	pushl  0x8(%ebp)
  800521:	50                   	push   %eax
  800522:	68 e4 23 80 00       	push   $0x8023e4
  800527:	6a 74                	push   $0x74
  800529:	e8 b2 02 00 00       	call   8007e0 <cprintf_colored>
  80052e:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800531:	8b 45 10             	mov    0x10(%ebp),%eax
  800534:	83 ec 08             	sub    $0x8,%esp
  800537:	ff 75 f4             	pushl  -0xc(%ebp)
  80053a:	50                   	push   %eax
  80053b:	e8 04 02 00 00       	call   800744 <vcprintf>
  800540:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800543:	83 ec 08             	sub    $0x8,%esp
  800546:	6a 00                	push   $0x0
  800548:	68 0c 24 80 00       	push   $0x80240c
  80054d:	e8 f2 01 00 00       	call   800744 <vcprintf>
  800552:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800555:	e8 7d ff ff ff       	call   8004d7 <exit>

	// should not return here
	while (1) ;
  80055a:	eb fe                	jmp    80055a <_panic+0x75>

0080055c <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80055c:	55                   	push   %ebp
  80055d:	89 e5                	mov    %esp,%ebp
  80055f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800562:	a1 20 30 80 00       	mov    0x803020,%eax
  800567:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80056d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800570:	39 c2                	cmp    %eax,%edx
  800572:	74 14                	je     800588 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800574:	83 ec 04             	sub    $0x4,%esp
  800577:	68 10 24 80 00       	push   $0x802410
  80057c:	6a 26                	push   $0x26
  80057e:	68 5c 24 80 00       	push   $0x80245c
  800583:	e8 5d ff ff ff       	call   8004e5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800588:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80058f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800596:	e9 c5 00 00 00       	jmp    800660 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  80059b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80059e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a8:	01 d0                	add    %edx,%eax
  8005aa:	8b 00                	mov    (%eax),%eax
  8005ac:	85 c0                	test   %eax,%eax
  8005ae:	75 08                	jne    8005b8 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8005b0:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005b3:	e9 a5 00 00 00       	jmp    80065d <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8005b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005bf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005c6:	eb 69                	jmp    800631 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8005c8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005cd:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005d3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005d6:	89 d0                	mov    %edx,%eax
  8005d8:	01 c0                	add    %eax,%eax
  8005da:	01 d0                	add    %edx,%eax
  8005dc:	c1 e0 03             	shl    $0x3,%eax
  8005df:	01 c8                	add    %ecx,%eax
  8005e1:	8a 40 04             	mov    0x4(%eax),%al
  8005e4:	84 c0                	test   %al,%al
  8005e6:	75 46                	jne    80062e <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ed:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005f3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005f6:	89 d0                	mov    %edx,%eax
  8005f8:	01 c0                	add    %eax,%eax
  8005fa:	01 d0                	add    %edx,%eax
  8005fc:	c1 e0 03             	shl    $0x3,%eax
  8005ff:	01 c8                	add    %ecx,%eax
  800601:	8b 00                	mov    (%eax),%eax
  800603:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800606:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800609:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80060e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800610:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800613:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80061a:	8b 45 08             	mov    0x8(%ebp),%eax
  80061d:	01 c8                	add    %ecx,%eax
  80061f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800621:	39 c2                	cmp    %eax,%edx
  800623:	75 09                	jne    80062e <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800625:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80062c:	eb 15                	jmp    800643 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80062e:	ff 45 e8             	incl   -0x18(%ebp)
  800631:	a1 20 30 80 00       	mov    0x803020,%eax
  800636:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80063c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80063f:	39 c2                	cmp    %eax,%edx
  800641:	77 85                	ja     8005c8 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800643:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800647:	75 14                	jne    80065d <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800649:	83 ec 04             	sub    $0x4,%esp
  80064c:	68 68 24 80 00       	push   $0x802468
  800651:	6a 3a                	push   $0x3a
  800653:	68 5c 24 80 00       	push   $0x80245c
  800658:	e8 88 fe ff ff       	call   8004e5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80065d:	ff 45 f0             	incl   -0x10(%ebp)
  800660:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800663:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800666:	0f 8c 2f ff ff ff    	jl     80059b <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80066c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800673:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80067a:	eb 26                	jmp    8006a2 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80067c:	a1 20 30 80 00       	mov    0x803020,%eax
  800681:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800687:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80068a:	89 d0                	mov    %edx,%eax
  80068c:	01 c0                	add    %eax,%eax
  80068e:	01 d0                	add    %edx,%eax
  800690:	c1 e0 03             	shl    $0x3,%eax
  800693:	01 c8                	add    %ecx,%eax
  800695:	8a 40 04             	mov    0x4(%eax),%al
  800698:	3c 01                	cmp    $0x1,%al
  80069a:	75 03                	jne    80069f <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  80069c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80069f:	ff 45 e0             	incl   -0x20(%ebp)
  8006a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a7:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8006ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006b0:	39 c2                	cmp    %eax,%edx
  8006b2:	77 c8                	ja     80067c <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006b7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006ba:	74 14                	je     8006d0 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8006bc:	83 ec 04             	sub    $0x4,%esp
  8006bf:	68 bc 24 80 00       	push   $0x8024bc
  8006c4:	6a 44                	push   $0x44
  8006c6:	68 5c 24 80 00       	push   $0x80245c
  8006cb:	e8 15 fe ff ff       	call   8004e5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006d0:	90                   	nop
  8006d1:	c9                   	leave  
  8006d2:	c3                   	ret    

008006d3 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8006d3:	55                   	push   %ebp
  8006d4:	89 e5                	mov    %esp,%ebp
  8006d6:	53                   	push   %ebx
  8006d7:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8006da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006dd:	8b 00                	mov    (%eax),%eax
  8006df:	8d 48 01             	lea    0x1(%eax),%ecx
  8006e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006e5:	89 0a                	mov    %ecx,(%edx)
  8006e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8006ea:	88 d1                	mov    %dl,%cl
  8006ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006ef:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f6:	8b 00                	mov    (%eax),%eax
  8006f8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006fd:	75 30                	jne    80072f <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8006ff:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800705:	a0 40 30 80 00       	mov    0x803040,%al
  80070a:	0f b6 c0             	movzbl %al,%eax
  80070d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800710:	8b 09                	mov    (%ecx),%ecx
  800712:	89 cb                	mov    %ecx,%ebx
  800714:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800717:	83 c1 08             	add    $0x8,%ecx
  80071a:	52                   	push   %edx
  80071b:	50                   	push   %eax
  80071c:	53                   	push   %ebx
  80071d:	51                   	push   %ecx
  80071e:	e8 a0 0f 00 00       	call   8016c3 <sys_cputs>
  800723:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800726:	8b 45 0c             	mov    0xc(%ebp),%eax
  800729:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80072f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800732:	8b 40 04             	mov    0x4(%eax),%eax
  800735:	8d 50 01             	lea    0x1(%eax),%edx
  800738:	8b 45 0c             	mov    0xc(%ebp),%eax
  80073b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80073e:	90                   	nop
  80073f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800742:	c9                   	leave  
  800743:	c3                   	ret    

00800744 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800744:	55                   	push   %ebp
  800745:	89 e5                	mov    %esp,%ebp
  800747:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80074d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800754:	00 00 00 
	b.cnt = 0;
  800757:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80075e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800761:	ff 75 0c             	pushl  0xc(%ebp)
  800764:	ff 75 08             	pushl  0x8(%ebp)
  800767:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80076d:	50                   	push   %eax
  80076e:	68 d3 06 80 00       	push   $0x8006d3
  800773:	e8 5a 02 00 00       	call   8009d2 <vprintfmt>
  800778:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  80077b:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800781:	a0 40 30 80 00       	mov    0x803040,%al
  800786:	0f b6 c0             	movzbl %al,%eax
  800789:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  80078f:	52                   	push   %edx
  800790:	50                   	push   %eax
  800791:	51                   	push   %ecx
  800792:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800798:	83 c0 08             	add    $0x8,%eax
  80079b:	50                   	push   %eax
  80079c:	e8 22 0f 00 00       	call   8016c3 <sys_cputs>
  8007a1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007a4:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8007ab:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007b1:	c9                   	leave  
  8007b2:	c3                   	ret    

008007b3 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8007b3:	55                   	push   %ebp
  8007b4:	89 e5                	mov    %esp,%ebp
  8007b6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007b9:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8007c0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c9:	83 ec 08             	sub    $0x8,%esp
  8007cc:	ff 75 f4             	pushl  -0xc(%ebp)
  8007cf:	50                   	push   %eax
  8007d0:	e8 6f ff ff ff       	call   800744 <vcprintf>
  8007d5:	83 c4 10             	add    $0x10,%esp
  8007d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007db:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007de:	c9                   	leave  
  8007df:	c3                   	ret    

008007e0 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8007e0:	55                   	push   %ebp
  8007e1:	89 e5                	mov    %esp,%ebp
  8007e3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007e6:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  8007ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f0:	c1 e0 08             	shl    $0x8,%eax
  8007f3:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  8007f8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007fb:	83 c0 04             	add    $0x4,%eax
  8007fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800801:	8b 45 0c             	mov    0xc(%ebp),%eax
  800804:	83 ec 08             	sub    $0x8,%esp
  800807:	ff 75 f4             	pushl  -0xc(%ebp)
  80080a:	50                   	push   %eax
  80080b:	e8 34 ff ff ff       	call   800744 <vcprintf>
  800810:	83 c4 10             	add    $0x10,%esp
  800813:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800816:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  80081d:	07 00 00 

	return cnt;
  800820:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800823:	c9                   	leave  
  800824:	c3                   	ret    

00800825 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800825:	55                   	push   %ebp
  800826:	89 e5                	mov    %esp,%ebp
  800828:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  80082b:	e8 d7 0e 00 00       	call   801707 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800830:	8d 45 0c             	lea    0xc(%ebp),%eax
  800833:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800836:	8b 45 08             	mov    0x8(%ebp),%eax
  800839:	83 ec 08             	sub    $0x8,%esp
  80083c:	ff 75 f4             	pushl  -0xc(%ebp)
  80083f:	50                   	push   %eax
  800840:	e8 ff fe ff ff       	call   800744 <vcprintf>
  800845:	83 c4 10             	add    $0x10,%esp
  800848:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  80084b:	e8 d1 0e 00 00       	call   801721 <sys_unlock_cons>
	return cnt;
  800850:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800853:	c9                   	leave  
  800854:	c3                   	ret    

00800855 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800855:	55                   	push   %ebp
  800856:	89 e5                	mov    %esp,%ebp
  800858:	53                   	push   %ebx
  800859:	83 ec 14             	sub    $0x14,%esp
  80085c:	8b 45 10             	mov    0x10(%ebp),%eax
  80085f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800862:	8b 45 14             	mov    0x14(%ebp),%eax
  800865:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800868:	8b 45 18             	mov    0x18(%ebp),%eax
  80086b:	ba 00 00 00 00       	mov    $0x0,%edx
  800870:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800873:	77 55                	ja     8008ca <printnum+0x75>
  800875:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800878:	72 05                	jb     80087f <printnum+0x2a>
  80087a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80087d:	77 4b                	ja     8008ca <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80087f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800882:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800885:	8b 45 18             	mov    0x18(%ebp),%eax
  800888:	ba 00 00 00 00       	mov    $0x0,%edx
  80088d:	52                   	push   %edx
  80088e:	50                   	push   %eax
  80088f:	ff 75 f4             	pushl  -0xc(%ebp)
  800892:	ff 75 f0             	pushl  -0x10(%ebp)
  800895:	e8 32 14 00 00       	call   801ccc <__udivdi3>
  80089a:	83 c4 10             	add    $0x10,%esp
  80089d:	83 ec 04             	sub    $0x4,%esp
  8008a0:	ff 75 20             	pushl  0x20(%ebp)
  8008a3:	53                   	push   %ebx
  8008a4:	ff 75 18             	pushl  0x18(%ebp)
  8008a7:	52                   	push   %edx
  8008a8:	50                   	push   %eax
  8008a9:	ff 75 0c             	pushl  0xc(%ebp)
  8008ac:	ff 75 08             	pushl  0x8(%ebp)
  8008af:	e8 a1 ff ff ff       	call   800855 <printnum>
  8008b4:	83 c4 20             	add    $0x20,%esp
  8008b7:	eb 1a                	jmp    8008d3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008b9:	83 ec 08             	sub    $0x8,%esp
  8008bc:	ff 75 0c             	pushl  0xc(%ebp)
  8008bf:	ff 75 20             	pushl  0x20(%ebp)
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	ff d0                	call   *%eax
  8008c7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008ca:	ff 4d 1c             	decl   0x1c(%ebp)
  8008cd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008d1:	7f e6                	jg     8008b9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008d3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008d6:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008e1:	53                   	push   %ebx
  8008e2:	51                   	push   %ecx
  8008e3:	52                   	push   %edx
  8008e4:	50                   	push   %eax
  8008e5:	e8 f2 14 00 00       	call   801ddc <__umoddi3>
  8008ea:	83 c4 10             	add    $0x10,%esp
  8008ed:	05 34 27 80 00       	add    $0x802734,%eax
  8008f2:	8a 00                	mov    (%eax),%al
  8008f4:	0f be c0             	movsbl %al,%eax
  8008f7:	83 ec 08             	sub    $0x8,%esp
  8008fa:	ff 75 0c             	pushl  0xc(%ebp)
  8008fd:	50                   	push   %eax
  8008fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800901:	ff d0                	call   *%eax
  800903:	83 c4 10             	add    $0x10,%esp
}
  800906:	90                   	nop
  800907:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80090a:	c9                   	leave  
  80090b:	c3                   	ret    

0080090c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80090c:	55                   	push   %ebp
  80090d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80090f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800913:	7e 1c                	jle    800931 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800915:	8b 45 08             	mov    0x8(%ebp),%eax
  800918:	8b 00                	mov    (%eax),%eax
  80091a:	8d 50 08             	lea    0x8(%eax),%edx
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	89 10                	mov    %edx,(%eax)
  800922:	8b 45 08             	mov    0x8(%ebp),%eax
  800925:	8b 00                	mov    (%eax),%eax
  800927:	83 e8 08             	sub    $0x8,%eax
  80092a:	8b 50 04             	mov    0x4(%eax),%edx
  80092d:	8b 00                	mov    (%eax),%eax
  80092f:	eb 40                	jmp    800971 <getuint+0x65>
	else if (lflag)
  800931:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800935:	74 1e                	je     800955 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800937:	8b 45 08             	mov    0x8(%ebp),%eax
  80093a:	8b 00                	mov    (%eax),%eax
  80093c:	8d 50 04             	lea    0x4(%eax),%edx
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	89 10                	mov    %edx,(%eax)
  800944:	8b 45 08             	mov    0x8(%ebp),%eax
  800947:	8b 00                	mov    (%eax),%eax
  800949:	83 e8 04             	sub    $0x4,%eax
  80094c:	8b 00                	mov    (%eax),%eax
  80094e:	ba 00 00 00 00       	mov    $0x0,%edx
  800953:	eb 1c                	jmp    800971 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800955:	8b 45 08             	mov    0x8(%ebp),%eax
  800958:	8b 00                	mov    (%eax),%eax
  80095a:	8d 50 04             	lea    0x4(%eax),%edx
  80095d:	8b 45 08             	mov    0x8(%ebp),%eax
  800960:	89 10                	mov    %edx,(%eax)
  800962:	8b 45 08             	mov    0x8(%ebp),%eax
  800965:	8b 00                	mov    (%eax),%eax
  800967:	83 e8 04             	sub    $0x4,%eax
  80096a:	8b 00                	mov    (%eax),%eax
  80096c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800971:	5d                   	pop    %ebp
  800972:	c3                   	ret    

00800973 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800973:	55                   	push   %ebp
  800974:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800976:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80097a:	7e 1c                	jle    800998 <getint+0x25>
		return va_arg(*ap, long long);
  80097c:	8b 45 08             	mov    0x8(%ebp),%eax
  80097f:	8b 00                	mov    (%eax),%eax
  800981:	8d 50 08             	lea    0x8(%eax),%edx
  800984:	8b 45 08             	mov    0x8(%ebp),%eax
  800987:	89 10                	mov    %edx,(%eax)
  800989:	8b 45 08             	mov    0x8(%ebp),%eax
  80098c:	8b 00                	mov    (%eax),%eax
  80098e:	83 e8 08             	sub    $0x8,%eax
  800991:	8b 50 04             	mov    0x4(%eax),%edx
  800994:	8b 00                	mov    (%eax),%eax
  800996:	eb 38                	jmp    8009d0 <getint+0x5d>
	else if (lflag)
  800998:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80099c:	74 1a                	je     8009b8 <getint+0x45>
		return va_arg(*ap, long);
  80099e:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a1:	8b 00                	mov    (%eax),%eax
  8009a3:	8d 50 04             	lea    0x4(%eax),%edx
  8009a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a9:	89 10                	mov    %edx,(%eax)
  8009ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ae:	8b 00                	mov    (%eax),%eax
  8009b0:	83 e8 04             	sub    $0x4,%eax
  8009b3:	8b 00                	mov    (%eax),%eax
  8009b5:	99                   	cltd   
  8009b6:	eb 18                	jmp    8009d0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bb:	8b 00                	mov    (%eax),%eax
  8009bd:	8d 50 04             	lea    0x4(%eax),%edx
  8009c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c3:	89 10                	mov    %edx,(%eax)
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	8b 00                	mov    (%eax),%eax
  8009ca:	83 e8 04             	sub    $0x4,%eax
  8009cd:	8b 00                	mov    (%eax),%eax
  8009cf:	99                   	cltd   
}
  8009d0:	5d                   	pop    %ebp
  8009d1:	c3                   	ret    

008009d2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009d2:	55                   	push   %ebp
  8009d3:	89 e5                	mov    %esp,%ebp
  8009d5:	56                   	push   %esi
  8009d6:	53                   	push   %ebx
  8009d7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009da:	eb 17                	jmp    8009f3 <vprintfmt+0x21>
			if (ch == '\0')
  8009dc:	85 db                	test   %ebx,%ebx
  8009de:	0f 84 c1 03 00 00    	je     800da5 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  8009e4:	83 ec 08             	sub    $0x8,%esp
  8009e7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ea:	53                   	push   %ebx
  8009eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ee:	ff d0                	call   *%eax
  8009f0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f6:	8d 50 01             	lea    0x1(%eax),%edx
  8009f9:	89 55 10             	mov    %edx,0x10(%ebp)
  8009fc:	8a 00                	mov    (%eax),%al
  8009fe:	0f b6 d8             	movzbl %al,%ebx
  800a01:	83 fb 25             	cmp    $0x25,%ebx
  800a04:	75 d6                	jne    8009dc <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a06:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a0a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a11:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a18:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a1f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a26:	8b 45 10             	mov    0x10(%ebp),%eax
  800a29:	8d 50 01             	lea    0x1(%eax),%edx
  800a2c:	89 55 10             	mov    %edx,0x10(%ebp)
  800a2f:	8a 00                	mov    (%eax),%al
  800a31:	0f b6 d8             	movzbl %al,%ebx
  800a34:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a37:	83 f8 5b             	cmp    $0x5b,%eax
  800a3a:	0f 87 3d 03 00 00    	ja     800d7d <vprintfmt+0x3ab>
  800a40:	8b 04 85 58 27 80 00 	mov    0x802758(,%eax,4),%eax
  800a47:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a49:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a4d:	eb d7                	jmp    800a26 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a4f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a53:	eb d1                	jmp    800a26 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a55:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a5c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a5f:	89 d0                	mov    %edx,%eax
  800a61:	c1 e0 02             	shl    $0x2,%eax
  800a64:	01 d0                	add    %edx,%eax
  800a66:	01 c0                	add    %eax,%eax
  800a68:	01 d8                	add    %ebx,%eax
  800a6a:	83 e8 30             	sub    $0x30,%eax
  800a6d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a70:	8b 45 10             	mov    0x10(%ebp),%eax
  800a73:	8a 00                	mov    (%eax),%al
  800a75:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a78:	83 fb 2f             	cmp    $0x2f,%ebx
  800a7b:	7e 3e                	jle    800abb <vprintfmt+0xe9>
  800a7d:	83 fb 39             	cmp    $0x39,%ebx
  800a80:	7f 39                	jg     800abb <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a82:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a85:	eb d5                	jmp    800a5c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a87:	8b 45 14             	mov    0x14(%ebp),%eax
  800a8a:	83 c0 04             	add    $0x4,%eax
  800a8d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a90:	8b 45 14             	mov    0x14(%ebp),%eax
  800a93:	83 e8 04             	sub    $0x4,%eax
  800a96:	8b 00                	mov    (%eax),%eax
  800a98:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a9b:	eb 1f                	jmp    800abc <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a9d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aa1:	79 83                	jns    800a26 <vprintfmt+0x54>
				width = 0;
  800aa3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800aaa:	e9 77 ff ff ff       	jmp    800a26 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800aaf:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ab6:	e9 6b ff ff ff       	jmp    800a26 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800abb:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800abc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ac0:	0f 89 60 ff ff ff    	jns    800a26 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ac6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ac9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800acc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ad3:	e9 4e ff ff ff       	jmp    800a26 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ad8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800adb:	e9 46 ff ff ff       	jmp    800a26 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ae0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae3:	83 c0 04             	add    $0x4,%eax
  800ae6:	89 45 14             	mov    %eax,0x14(%ebp)
  800ae9:	8b 45 14             	mov    0x14(%ebp),%eax
  800aec:	83 e8 04             	sub    $0x4,%eax
  800aef:	8b 00                	mov    (%eax),%eax
  800af1:	83 ec 08             	sub    $0x8,%esp
  800af4:	ff 75 0c             	pushl  0xc(%ebp)
  800af7:	50                   	push   %eax
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	ff d0                	call   *%eax
  800afd:	83 c4 10             	add    $0x10,%esp
			break;
  800b00:	e9 9b 02 00 00       	jmp    800da0 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b05:	8b 45 14             	mov    0x14(%ebp),%eax
  800b08:	83 c0 04             	add    $0x4,%eax
  800b0b:	89 45 14             	mov    %eax,0x14(%ebp)
  800b0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800b11:	83 e8 04             	sub    $0x4,%eax
  800b14:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b16:	85 db                	test   %ebx,%ebx
  800b18:	79 02                	jns    800b1c <vprintfmt+0x14a>
				err = -err;
  800b1a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b1c:	83 fb 64             	cmp    $0x64,%ebx
  800b1f:	7f 0b                	jg     800b2c <vprintfmt+0x15a>
  800b21:	8b 34 9d a0 25 80 00 	mov    0x8025a0(,%ebx,4),%esi
  800b28:	85 f6                	test   %esi,%esi
  800b2a:	75 19                	jne    800b45 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b2c:	53                   	push   %ebx
  800b2d:	68 45 27 80 00       	push   $0x802745
  800b32:	ff 75 0c             	pushl  0xc(%ebp)
  800b35:	ff 75 08             	pushl  0x8(%ebp)
  800b38:	e8 70 02 00 00       	call   800dad <printfmt>
  800b3d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b40:	e9 5b 02 00 00       	jmp    800da0 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b45:	56                   	push   %esi
  800b46:	68 4e 27 80 00       	push   $0x80274e
  800b4b:	ff 75 0c             	pushl  0xc(%ebp)
  800b4e:	ff 75 08             	pushl  0x8(%ebp)
  800b51:	e8 57 02 00 00       	call   800dad <printfmt>
  800b56:	83 c4 10             	add    $0x10,%esp
			break;
  800b59:	e9 42 02 00 00       	jmp    800da0 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800b61:	83 c0 04             	add    $0x4,%eax
  800b64:	89 45 14             	mov    %eax,0x14(%ebp)
  800b67:	8b 45 14             	mov    0x14(%ebp),%eax
  800b6a:	83 e8 04             	sub    $0x4,%eax
  800b6d:	8b 30                	mov    (%eax),%esi
  800b6f:	85 f6                	test   %esi,%esi
  800b71:	75 05                	jne    800b78 <vprintfmt+0x1a6>
				p = "(null)";
  800b73:	be 51 27 80 00       	mov    $0x802751,%esi
			if (width > 0 && padc != '-')
  800b78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b7c:	7e 6d                	jle    800beb <vprintfmt+0x219>
  800b7e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b82:	74 67                	je     800beb <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b84:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b87:	83 ec 08             	sub    $0x8,%esp
  800b8a:	50                   	push   %eax
  800b8b:	56                   	push   %esi
  800b8c:	e8 1e 03 00 00       	call   800eaf <strnlen>
  800b91:	83 c4 10             	add    $0x10,%esp
  800b94:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b97:	eb 16                	jmp    800baf <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b99:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b9d:	83 ec 08             	sub    $0x8,%esp
  800ba0:	ff 75 0c             	pushl  0xc(%ebp)
  800ba3:	50                   	push   %eax
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	ff d0                	call   *%eax
  800ba9:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800bac:	ff 4d e4             	decl   -0x1c(%ebp)
  800baf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bb3:	7f e4                	jg     800b99 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bb5:	eb 34                	jmp    800beb <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bb7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bbb:	74 1c                	je     800bd9 <vprintfmt+0x207>
  800bbd:	83 fb 1f             	cmp    $0x1f,%ebx
  800bc0:	7e 05                	jle    800bc7 <vprintfmt+0x1f5>
  800bc2:	83 fb 7e             	cmp    $0x7e,%ebx
  800bc5:	7e 12                	jle    800bd9 <vprintfmt+0x207>
					putch('?', putdat);
  800bc7:	83 ec 08             	sub    $0x8,%esp
  800bca:	ff 75 0c             	pushl  0xc(%ebp)
  800bcd:	6a 3f                	push   $0x3f
  800bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd2:	ff d0                	call   *%eax
  800bd4:	83 c4 10             	add    $0x10,%esp
  800bd7:	eb 0f                	jmp    800be8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800bd9:	83 ec 08             	sub    $0x8,%esp
  800bdc:	ff 75 0c             	pushl  0xc(%ebp)
  800bdf:	53                   	push   %ebx
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	ff d0                	call   *%eax
  800be5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800be8:	ff 4d e4             	decl   -0x1c(%ebp)
  800beb:	89 f0                	mov    %esi,%eax
  800bed:	8d 70 01             	lea    0x1(%eax),%esi
  800bf0:	8a 00                	mov    (%eax),%al
  800bf2:	0f be d8             	movsbl %al,%ebx
  800bf5:	85 db                	test   %ebx,%ebx
  800bf7:	74 24                	je     800c1d <vprintfmt+0x24b>
  800bf9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bfd:	78 b8                	js     800bb7 <vprintfmt+0x1e5>
  800bff:	ff 4d e0             	decl   -0x20(%ebp)
  800c02:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c06:	79 af                	jns    800bb7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c08:	eb 13                	jmp    800c1d <vprintfmt+0x24b>
				putch(' ', putdat);
  800c0a:	83 ec 08             	sub    $0x8,%esp
  800c0d:	ff 75 0c             	pushl  0xc(%ebp)
  800c10:	6a 20                	push   $0x20
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	ff d0                	call   *%eax
  800c17:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c1a:	ff 4d e4             	decl   -0x1c(%ebp)
  800c1d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c21:	7f e7                	jg     800c0a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c23:	e9 78 01 00 00       	jmp    800da0 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c28:	83 ec 08             	sub    $0x8,%esp
  800c2b:	ff 75 e8             	pushl  -0x18(%ebp)
  800c2e:	8d 45 14             	lea    0x14(%ebp),%eax
  800c31:	50                   	push   %eax
  800c32:	e8 3c fd ff ff       	call   800973 <getint>
  800c37:	83 c4 10             	add    $0x10,%esp
  800c3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c3d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c40:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c43:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c46:	85 d2                	test   %edx,%edx
  800c48:	79 23                	jns    800c6d <vprintfmt+0x29b>
				putch('-', putdat);
  800c4a:	83 ec 08             	sub    $0x8,%esp
  800c4d:	ff 75 0c             	pushl  0xc(%ebp)
  800c50:	6a 2d                	push   $0x2d
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	ff d0                	call   *%eax
  800c57:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c5d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c60:	f7 d8                	neg    %eax
  800c62:	83 d2 00             	adc    $0x0,%edx
  800c65:	f7 da                	neg    %edx
  800c67:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c6a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c6d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c74:	e9 bc 00 00 00       	jmp    800d35 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c79:	83 ec 08             	sub    $0x8,%esp
  800c7c:	ff 75 e8             	pushl  -0x18(%ebp)
  800c7f:	8d 45 14             	lea    0x14(%ebp),%eax
  800c82:	50                   	push   %eax
  800c83:	e8 84 fc ff ff       	call   80090c <getuint>
  800c88:	83 c4 10             	add    $0x10,%esp
  800c8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c8e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c91:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c98:	e9 98 00 00 00       	jmp    800d35 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c9d:	83 ec 08             	sub    $0x8,%esp
  800ca0:	ff 75 0c             	pushl  0xc(%ebp)
  800ca3:	6a 58                	push   $0x58
  800ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca8:	ff d0                	call   *%eax
  800caa:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cad:	83 ec 08             	sub    $0x8,%esp
  800cb0:	ff 75 0c             	pushl  0xc(%ebp)
  800cb3:	6a 58                	push   $0x58
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	ff d0                	call   *%eax
  800cba:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cbd:	83 ec 08             	sub    $0x8,%esp
  800cc0:	ff 75 0c             	pushl  0xc(%ebp)
  800cc3:	6a 58                	push   $0x58
  800cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc8:	ff d0                	call   *%eax
  800cca:	83 c4 10             	add    $0x10,%esp
			break;
  800ccd:	e9 ce 00 00 00       	jmp    800da0 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800cd2:	83 ec 08             	sub    $0x8,%esp
  800cd5:	ff 75 0c             	pushl  0xc(%ebp)
  800cd8:	6a 30                	push   $0x30
  800cda:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdd:	ff d0                	call   *%eax
  800cdf:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ce2:	83 ec 08             	sub    $0x8,%esp
  800ce5:	ff 75 0c             	pushl  0xc(%ebp)
  800ce8:	6a 78                	push   $0x78
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	ff d0                	call   *%eax
  800cef:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800cf2:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf5:	83 c0 04             	add    $0x4,%eax
  800cf8:	89 45 14             	mov    %eax,0x14(%ebp)
  800cfb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cfe:	83 e8 04             	sub    $0x4,%eax
  800d01:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d06:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d0d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d14:	eb 1f                	jmp    800d35 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d16:	83 ec 08             	sub    $0x8,%esp
  800d19:	ff 75 e8             	pushl  -0x18(%ebp)
  800d1c:	8d 45 14             	lea    0x14(%ebp),%eax
  800d1f:	50                   	push   %eax
  800d20:	e8 e7 fb ff ff       	call   80090c <getuint>
  800d25:	83 c4 10             	add    $0x10,%esp
  800d28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d2b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d2e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d35:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d39:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d3c:	83 ec 04             	sub    $0x4,%esp
  800d3f:	52                   	push   %edx
  800d40:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d43:	50                   	push   %eax
  800d44:	ff 75 f4             	pushl  -0xc(%ebp)
  800d47:	ff 75 f0             	pushl  -0x10(%ebp)
  800d4a:	ff 75 0c             	pushl  0xc(%ebp)
  800d4d:	ff 75 08             	pushl  0x8(%ebp)
  800d50:	e8 00 fb ff ff       	call   800855 <printnum>
  800d55:	83 c4 20             	add    $0x20,%esp
			break;
  800d58:	eb 46                	jmp    800da0 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d5a:	83 ec 08             	sub    $0x8,%esp
  800d5d:	ff 75 0c             	pushl  0xc(%ebp)
  800d60:	53                   	push   %ebx
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	ff d0                	call   *%eax
  800d66:	83 c4 10             	add    $0x10,%esp
			break;
  800d69:	eb 35                	jmp    800da0 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800d6b:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800d72:	eb 2c                	jmp    800da0 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800d74:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800d7b:	eb 23                	jmp    800da0 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d7d:	83 ec 08             	sub    $0x8,%esp
  800d80:	ff 75 0c             	pushl  0xc(%ebp)
  800d83:	6a 25                	push   $0x25
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	ff d0                	call   *%eax
  800d8a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d8d:	ff 4d 10             	decl   0x10(%ebp)
  800d90:	eb 03                	jmp    800d95 <vprintfmt+0x3c3>
  800d92:	ff 4d 10             	decl   0x10(%ebp)
  800d95:	8b 45 10             	mov    0x10(%ebp),%eax
  800d98:	48                   	dec    %eax
  800d99:	8a 00                	mov    (%eax),%al
  800d9b:	3c 25                	cmp    $0x25,%al
  800d9d:	75 f3                	jne    800d92 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800d9f:	90                   	nop
		}
	}
  800da0:	e9 35 fc ff ff       	jmp    8009da <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800da5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800da6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800da9:	5b                   	pop    %ebx
  800daa:	5e                   	pop    %esi
  800dab:	5d                   	pop    %ebp
  800dac:	c3                   	ret    

00800dad <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800dad:	55                   	push   %ebp
  800dae:	89 e5                	mov    %esp,%ebp
  800db0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800db3:	8d 45 10             	lea    0x10(%ebp),%eax
  800db6:	83 c0 04             	add    $0x4,%eax
  800db9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800dbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbf:	ff 75 f4             	pushl  -0xc(%ebp)
  800dc2:	50                   	push   %eax
  800dc3:	ff 75 0c             	pushl  0xc(%ebp)
  800dc6:	ff 75 08             	pushl  0x8(%ebp)
  800dc9:	e8 04 fc ff ff       	call   8009d2 <vprintfmt>
  800dce:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800dd1:	90                   	nop
  800dd2:	c9                   	leave  
  800dd3:	c3                   	ret    

00800dd4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800dd4:	55                   	push   %ebp
  800dd5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dda:	8b 40 08             	mov    0x8(%eax),%eax
  800ddd:	8d 50 01             	lea    0x1(%eax),%edx
  800de0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800de6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de9:	8b 10                	mov    (%eax),%edx
  800deb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dee:	8b 40 04             	mov    0x4(%eax),%eax
  800df1:	39 c2                	cmp    %eax,%edx
  800df3:	73 12                	jae    800e07 <sprintputch+0x33>
		*b->buf++ = ch;
  800df5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df8:	8b 00                	mov    (%eax),%eax
  800dfa:	8d 48 01             	lea    0x1(%eax),%ecx
  800dfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e00:	89 0a                	mov    %ecx,(%edx)
  800e02:	8b 55 08             	mov    0x8(%ebp),%edx
  800e05:	88 10                	mov    %dl,(%eax)
}
  800e07:	90                   	nop
  800e08:	5d                   	pop    %ebp
  800e09:	c3                   	ret    

00800e0a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e0a:	55                   	push   %ebp
  800e0b:	89 e5                	mov    %esp,%ebp
  800e0d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e19:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	01 d0                	add    %edx,%eax
  800e21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e24:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e2b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e2f:	74 06                	je     800e37 <vsnprintf+0x2d>
  800e31:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e35:	7f 07                	jg     800e3e <vsnprintf+0x34>
		return -E_INVAL;
  800e37:	b8 03 00 00 00       	mov    $0x3,%eax
  800e3c:	eb 20                	jmp    800e5e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e3e:	ff 75 14             	pushl  0x14(%ebp)
  800e41:	ff 75 10             	pushl  0x10(%ebp)
  800e44:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e47:	50                   	push   %eax
  800e48:	68 d4 0d 80 00       	push   $0x800dd4
  800e4d:	e8 80 fb ff ff       	call   8009d2 <vprintfmt>
  800e52:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e55:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e58:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e5e:	c9                   	leave  
  800e5f:	c3                   	ret    

00800e60 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e60:	55                   	push   %ebp
  800e61:	89 e5                	mov    %esp,%ebp
  800e63:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e66:	8d 45 10             	lea    0x10(%ebp),%eax
  800e69:	83 c0 04             	add    $0x4,%eax
  800e6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e72:	ff 75 f4             	pushl  -0xc(%ebp)
  800e75:	50                   	push   %eax
  800e76:	ff 75 0c             	pushl  0xc(%ebp)
  800e79:	ff 75 08             	pushl  0x8(%ebp)
  800e7c:	e8 89 ff ff ff       	call   800e0a <vsnprintf>
  800e81:	83 c4 10             	add    $0x10,%esp
  800e84:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e87:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e8a:	c9                   	leave  
  800e8b:	c3                   	ret    

00800e8c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e8c:	55                   	push   %ebp
  800e8d:	89 e5                	mov    %esp,%ebp
  800e8f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e99:	eb 06                	jmp    800ea1 <strlen+0x15>
		n++;
  800e9b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e9e:	ff 45 08             	incl   0x8(%ebp)
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	8a 00                	mov    (%eax),%al
  800ea6:	84 c0                	test   %al,%al
  800ea8:	75 f1                	jne    800e9b <strlen+0xf>
		n++;
	return n;
  800eaa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ead:	c9                   	leave  
  800eae:	c3                   	ret    

00800eaf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800eaf:	55                   	push   %ebp
  800eb0:	89 e5                	mov    %esp,%ebp
  800eb2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800eb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ebc:	eb 09                	jmp    800ec7 <strnlen+0x18>
		n++;
  800ebe:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ec1:	ff 45 08             	incl   0x8(%ebp)
  800ec4:	ff 4d 0c             	decl   0xc(%ebp)
  800ec7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ecb:	74 09                	je     800ed6 <strnlen+0x27>
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	8a 00                	mov    (%eax),%al
  800ed2:	84 c0                	test   %al,%al
  800ed4:	75 e8                	jne    800ebe <strnlen+0xf>
		n++;
	return n;
  800ed6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ed9:	c9                   	leave  
  800eda:	c3                   	ret    

00800edb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800edb:	55                   	push   %ebp
  800edc:	89 e5                	mov    %esp,%ebp
  800ede:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ee7:	90                   	nop
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eeb:	8d 50 01             	lea    0x1(%eax),%edx
  800eee:	89 55 08             	mov    %edx,0x8(%ebp)
  800ef1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ef4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ef7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800efa:	8a 12                	mov    (%edx),%dl
  800efc:	88 10                	mov    %dl,(%eax)
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	84 c0                	test   %al,%al
  800f02:	75 e4                	jne    800ee8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f04:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f07:	c9                   	leave  
  800f08:	c3                   	ret    

00800f09 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f09:	55                   	push   %ebp
  800f0a:	89 e5                	mov    %esp,%ebp
  800f0c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f1c:	eb 1f                	jmp    800f3d <strncpy+0x34>
		*dst++ = *src;
  800f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f21:	8d 50 01             	lea    0x1(%eax),%edx
  800f24:	89 55 08             	mov    %edx,0x8(%ebp)
  800f27:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f2a:	8a 12                	mov    (%edx),%dl
  800f2c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f31:	8a 00                	mov    (%eax),%al
  800f33:	84 c0                	test   %al,%al
  800f35:	74 03                	je     800f3a <strncpy+0x31>
			src++;
  800f37:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f3a:	ff 45 fc             	incl   -0x4(%ebp)
  800f3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f40:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f43:	72 d9                	jb     800f1e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f45:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f48:	c9                   	leave  
  800f49:	c3                   	ret    

00800f4a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f4a:	55                   	push   %ebp
  800f4b:	89 e5                	mov    %esp,%ebp
  800f4d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f56:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5a:	74 30                	je     800f8c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f5c:	eb 16                	jmp    800f74 <strlcpy+0x2a>
			*dst++ = *src++;
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	8d 50 01             	lea    0x1(%eax),%edx
  800f64:	89 55 08             	mov    %edx,0x8(%ebp)
  800f67:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f6a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f6d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f70:	8a 12                	mov    (%edx),%dl
  800f72:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f74:	ff 4d 10             	decl   0x10(%ebp)
  800f77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f7b:	74 09                	je     800f86 <strlcpy+0x3c>
  800f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	84 c0                	test   %al,%al
  800f84:	75 d8                	jne    800f5e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f8c:	8b 55 08             	mov    0x8(%ebp),%edx
  800f8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f92:	29 c2                	sub    %eax,%edx
  800f94:	89 d0                	mov    %edx,%eax
}
  800f96:	c9                   	leave  
  800f97:	c3                   	ret    

00800f98 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f98:	55                   	push   %ebp
  800f99:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f9b:	eb 06                	jmp    800fa3 <strcmp+0xb>
		p++, q++;
  800f9d:	ff 45 08             	incl   0x8(%ebp)
  800fa0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	8a 00                	mov    (%eax),%al
  800fa8:	84 c0                	test   %al,%al
  800faa:	74 0e                	je     800fba <strcmp+0x22>
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	8a 10                	mov    (%eax),%dl
  800fb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb4:	8a 00                	mov    (%eax),%al
  800fb6:	38 c2                	cmp    %al,%dl
  800fb8:	74 e3                	je     800f9d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	8a 00                	mov    (%eax),%al
  800fbf:	0f b6 d0             	movzbl %al,%edx
  800fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc5:	8a 00                	mov    (%eax),%al
  800fc7:	0f b6 c0             	movzbl %al,%eax
  800fca:	29 c2                	sub    %eax,%edx
  800fcc:	89 d0                	mov    %edx,%eax
}
  800fce:	5d                   	pop    %ebp
  800fcf:	c3                   	ret    

00800fd0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800fd0:	55                   	push   %ebp
  800fd1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800fd3:	eb 09                	jmp    800fde <strncmp+0xe>
		n--, p++, q++;
  800fd5:	ff 4d 10             	decl   0x10(%ebp)
  800fd8:	ff 45 08             	incl   0x8(%ebp)
  800fdb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800fde:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fe2:	74 17                	je     800ffb <strncmp+0x2b>
  800fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe7:	8a 00                	mov    (%eax),%al
  800fe9:	84 c0                	test   %al,%al
  800feb:	74 0e                	je     800ffb <strncmp+0x2b>
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	8a 10                	mov    (%eax),%dl
  800ff2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff5:	8a 00                	mov    (%eax),%al
  800ff7:	38 c2                	cmp    %al,%dl
  800ff9:	74 da                	je     800fd5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ffb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fff:	75 07                	jne    801008 <strncmp+0x38>
		return 0;
  801001:	b8 00 00 00 00       	mov    $0x0,%eax
  801006:	eb 14                	jmp    80101c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801008:	8b 45 08             	mov    0x8(%ebp),%eax
  80100b:	8a 00                	mov    (%eax),%al
  80100d:	0f b6 d0             	movzbl %al,%edx
  801010:	8b 45 0c             	mov    0xc(%ebp),%eax
  801013:	8a 00                	mov    (%eax),%al
  801015:	0f b6 c0             	movzbl %al,%eax
  801018:	29 c2                	sub    %eax,%edx
  80101a:	89 d0                	mov    %edx,%eax
}
  80101c:	5d                   	pop    %ebp
  80101d:	c3                   	ret    

0080101e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80101e:	55                   	push   %ebp
  80101f:	89 e5                	mov    %esp,%ebp
  801021:	83 ec 04             	sub    $0x4,%esp
  801024:	8b 45 0c             	mov    0xc(%ebp),%eax
  801027:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80102a:	eb 12                	jmp    80103e <strchr+0x20>
		if (*s == c)
  80102c:	8b 45 08             	mov    0x8(%ebp),%eax
  80102f:	8a 00                	mov    (%eax),%al
  801031:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801034:	75 05                	jne    80103b <strchr+0x1d>
			return (char *) s;
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	eb 11                	jmp    80104c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80103b:	ff 45 08             	incl   0x8(%ebp)
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8a 00                	mov    (%eax),%al
  801043:	84 c0                	test   %al,%al
  801045:	75 e5                	jne    80102c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801047:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80104c:	c9                   	leave  
  80104d:	c3                   	ret    

0080104e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80104e:	55                   	push   %ebp
  80104f:	89 e5                	mov    %esp,%ebp
  801051:	83 ec 04             	sub    $0x4,%esp
  801054:	8b 45 0c             	mov    0xc(%ebp),%eax
  801057:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80105a:	eb 0d                	jmp    801069 <strfind+0x1b>
		if (*s == c)
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	8a 00                	mov    (%eax),%al
  801061:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801064:	74 0e                	je     801074 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801066:	ff 45 08             	incl   0x8(%ebp)
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	8a 00                	mov    (%eax),%al
  80106e:	84 c0                	test   %al,%al
  801070:	75 ea                	jne    80105c <strfind+0xe>
  801072:	eb 01                	jmp    801075 <strfind+0x27>
		if (*s == c)
			break;
  801074:	90                   	nop
	return (char *) s;
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801078:	c9                   	leave  
  801079:	c3                   	ret    

0080107a <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  80107a:	55                   	push   %ebp
  80107b:	89 e5                	mov    %esp,%ebp
  80107d:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  801086:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80108a:	76 63                	jbe    8010ef <memset+0x75>
		uint64 data_block = c;
  80108c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108f:	99                   	cltd   
  801090:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801093:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  801096:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801099:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80109c:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  8010a0:	c1 e0 08             	shl    $0x8,%eax
  8010a3:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010a6:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  8010a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010af:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  8010b3:	c1 e0 10             	shl    $0x10,%eax
  8010b6:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010b9:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  8010bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c2:	89 c2                	mov    %eax,%edx
  8010c4:	b8 00 00 00 00       	mov    $0x0,%eax
  8010c9:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010cc:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  8010cf:	eb 18                	jmp    8010e9 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  8010d1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010d4:	8d 41 08             	lea    0x8(%ecx),%eax
  8010d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  8010da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e0:	89 01                	mov    %eax,(%ecx)
  8010e2:	89 51 04             	mov    %edx,0x4(%ecx)
  8010e5:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  8010e9:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010ed:	77 e2                	ja     8010d1 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  8010ef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010f3:	74 23                	je     801118 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8010f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010fb:	eb 0e                	jmp    80110b <memset+0x91>
			*p8++ = (uint8)c;
  8010fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801100:	8d 50 01             	lea    0x1(%eax),%edx
  801103:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801106:	8b 55 0c             	mov    0xc(%ebp),%edx
  801109:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  80110b:	8b 45 10             	mov    0x10(%ebp),%eax
  80110e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801111:	89 55 10             	mov    %edx,0x10(%ebp)
  801114:	85 c0                	test   %eax,%eax
  801116:	75 e5                	jne    8010fd <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
  801120:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801123:	8b 45 0c             	mov    0xc(%ebp),%eax
  801126:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  80112f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801133:	76 24                	jbe    801159 <memcpy+0x3c>
		while(n >= 8){
  801135:	eb 1c                	jmp    801153 <memcpy+0x36>
			*d64 = *s64;
  801137:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80113a:	8b 50 04             	mov    0x4(%eax),%edx
  80113d:	8b 00                	mov    (%eax),%eax
  80113f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801142:	89 01                	mov    %eax,(%ecx)
  801144:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  801147:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  80114b:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  80114f:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801153:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801157:	77 de                	ja     801137 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801159:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80115d:	74 31                	je     801190 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  80115f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801162:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801165:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801168:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  80116b:	eb 16                	jmp    801183 <memcpy+0x66>
			*d8++ = *s8++;
  80116d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801170:	8d 50 01             	lea    0x1(%eax),%edx
  801173:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801176:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801179:	8d 4a 01             	lea    0x1(%edx),%ecx
  80117c:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80117f:	8a 12                	mov    (%edx),%dl
  801181:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801183:	8b 45 10             	mov    0x10(%ebp),%eax
  801186:	8d 50 ff             	lea    -0x1(%eax),%edx
  801189:	89 55 10             	mov    %edx,0x10(%ebp)
  80118c:	85 c0                	test   %eax,%eax
  80118e:	75 dd                	jne    80116d <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801190:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801193:	c9                   	leave  
  801194:	c3                   	ret    

00801195 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801195:	55                   	push   %ebp
  801196:	89 e5                	mov    %esp,%ebp
  801198:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80119b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8011a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011ad:	73 50                	jae    8011ff <memmove+0x6a>
  8011af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b5:	01 d0                	add    %edx,%eax
  8011b7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011ba:	76 43                	jbe    8011ff <memmove+0x6a>
		s += n;
  8011bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8011bf:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8011c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8011c8:	eb 10                	jmp    8011da <memmove+0x45>
			*--d = *--s;
  8011ca:	ff 4d f8             	decl   -0x8(%ebp)
  8011cd:	ff 4d fc             	decl   -0x4(%ebp)
  8011d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011d3:	8a 10                	mov    (%eax),%dl
  8011d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8011da:	8b 45 10             	mov    0x10(%ebp),%eax
  8011dd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011e0:	89 55 10             	mov    %edx,0x10(%ebp)
  8011e3:	85 c0                	test   %eax,%eax
  8011e5:	75 e3                	jne    8011ca <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8011e7:	eb 23                	jmp    80120c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8011e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ec:	8d 50 01             	lea    0x1(%eax),%edx
  8011ef:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011f5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011f8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8011fb:	8a 12                	mov    (%edx),%dl
  8011fd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8011ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801202:	8d 50 ff             	lea    -0x1(%eax),%edx
  801205:	89 55 10             	mov    %edx,0x10(%ebp)
  801208:	85 c0                	test   %eax,%eax
  80120a:	75 dd                	jne    8011e9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80120f:	c9                   	leave  
  801210:	c3                   	ret    

00801211 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801211:	55                   	push   %ebp
  801212:	89 e5                	mov    %esp,%ebp
  801214:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801217:	8b 45 08             	mov    0x8(%ebp),%eax
  80121a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80121d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801220:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801223:	eb 2a                	jmp    80124f <memcmp+0x3e>
		if (*s1 != *s2)
  801225:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801228:	8a 10                	mov    (%eax),%dl
  80122a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122d:	8a 00                	mov    (%eax),%al
  80122f:	38 c2                	cmp    %al,%dl
  801231:	74 16                	je     801249 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801233:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801236:	8a 00                	mov    (%eax),%al
  801238:	0f b6 d0             	movzbl %al,%edx
  80123b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80123e:	8a 00                	mov    (%eax),%al
  801240:	0f b6 c0             	movzbl %al,%eax
  801243:	29 c2                	sub    %eax,%edx
  801245:	89 d0                	mov    %edx,%eax
  801247:	eb 18                	jmp    801261 <memcmp+0x50>
		s1++, s2++;
  801249:	ff 45 fc             	incl   -0x4(%ebp)
  80124c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80124f:	8b 45 10             	mov    0x10(%ebp),%eax
  801252:	8d 50 ff             	lea    -0x1(%eax),%edx
  801255:	89 55 10             	mov    %edx,0x10(%ebp)
  801258:	85 c0                	test   %eax,%eax
  80125a:	75 c9                	jne    801225 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80125c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801261:	c9                   	leave  
  801262:	c3                   	ret    

00801263 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801263:	55                   	push   %ebp
  801264:	89 e5                	mov    %esp,%ebp
  801266:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801269:	8b 55 08             	mov    0x8(%ebp),%edx
  80126c:	8b 45 10             	mov    0x10(%ebp),%eax
  80126f:	01 d0                	add    %edx,%eax
  801271:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801274:	eb 15                	jmp    80128b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801276:	8b 45 08             	mov    0x8(%ebp),%eax
  801279:	8a 00                	mov    (%eax),%al
  80127b:	0f b6 d0             	movzbl %al,%edx
  80127e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801281:	0f b6 c0             	movzbl %al,%eax
  801284:	39 c2                	cmp    %eax,%edx
  801286:	74 0d                	je     801295 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801288:	ff 45 08             	incl   0x8(%ebp)
  80128b:	8b 45 08             	mov    0x8(%ebp),%eax
  80128e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801291:	72 e3                	jb     801276 <memfind+0x13>
  801293:	eb 01                	jmp    801296 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801295:	90                   	nop
	return (void *) s;
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801299:	c9                   	leave  
  80129a:	c3                   	ret    

0080129b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80129b:	55                   	push   %ebp
  80129c:	89 e5                	mov    %esp,%ebp
  80129e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8012a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8012a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012af:	eb 03                	jmp    8012b4 <strtol+0x19>
		s++;
  8012b1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	8a 00                	mov    (%eax),%al
  8012b9:	3c 20                	cmp    $0x20,%al
  8012bb:	74 f4                	je     8012b1 <strtol+0x16>
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	8a 00                	mov    (%eax),%al
  8012c2:	3c 09                	cmp    $0x9,%al
  8012c4:	74 eb                	je     8012b1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c9:	8a 00                	mov    (%eax),%al
  8012cb:	3c 2b                	cmp    $0x2b,%al
  8012cd:	75 05                	jne    8012d4 <strtol+0x39>
		s++;
  8012cf:	ff 45 08             	incl   0x8(%ebp)
  8012d2:	eb 13                	jmp    8012e7 <strtol+0x4c>
	else if (*s == '-')
  8012d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d7:	8a 00                	mov    (%eax),%al
  8012d9:	3c 2d                	cmp    $0x2d,%al
  8012db:	75 0a                	jne    8012e7 <strtol+0x4c>
		s++, neg = 1;
  8012dd:	ff 45 08             	incl   0x8(%ebp)
  8012e0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8012e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012eb:	74 06                	je     8012f3 <strtol+0x58>
  8012ed:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8012f1:	75 20                	jne    801313 <strtol+0x78>
  8012f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f6:	8a 00                	mov    (%eax),%al
  8012f8:	3c 30                	cmp    $0x30,%al
  8012fa:	75 17                	jne    801313 <strtol+0x78>
  8012fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ff:	40                   	inc    %eax
  801300:	8a 00                	mov    (%eax),%al
  801302:	3c 78                	cmp    $0x78,%al
  801304:	75 0d                	jne    801313 <strtol+0x78>
		s += 2, base = 16;
  801306:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80130a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801311:	eb 28                	jmp    80133b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801313:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801317:	75 15                	jne    80132e <strtol+0x93>
  801319:	8b 45 08             	mov    0x8(%ebp),%eax
  80131c:	8a 00                	mov    (%eax),%al
  80131e:	3c 30                	cmp    $0x30,%al
  801320:	75 0c                	jne    80132e <strtol+0x93>
		s++, base = 8;
  801322:	ff 45 08             	incl   0x8(%ebp)
  801325:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80132c:	eb 0d                	jmp    80133b <strtol+0xa0>
	else if (base == 0)
  80132e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801332:	75 07                	jne    80133b <strtol+0xa0>
		base = 10;
  801334:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80133b:	8b 45 08             	mov    0x8(%ebp),%eax
  80133e:	8a 00                	mov    (%eax),%al
  801340:	3c 2f                	cmp    $0x2f,%al
  801342:	7e 19                	jle    80135d <strtol+0xc2>
  801344:	8b 45 08             	mov    0x8(%ebp),%eax
  801347:	8a 00                	mov    (%eax),%al
  801349:	3c 39                	cmp    $0x39,%al
  80134b:	7f 10                	jg     80135d <strtol+0xc2>
			dig = *s - '0';
  80134d:	8b 45 08             	mov    0x8(%ebp),%eax
  801350:	8a 00                	mov    (%eax),%al
  801352:	0f be c0             	movsbl %al,%eax
  801355:	83 e8 30             	sub    $0x30,%eax
  801358:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80135b:	eb 42                	jmp    80139f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	8a 00                	mov    (%eax),%al
  801362:	3c 60                	cmp    $0x60,%al
  801364:	7e 19                	jle    80137f <strtol+0xe4>
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	8a 00                	mov    (%eax),%al
  80136b:	3c 7a                	cmp    $0x7a,%al
  80136d:	7f 10                	jg     80137f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	8a 00                	mov    (%eax),%al
  801374:	0f be c0             	movsbl %al,%eax
  801377:	83 e8 57             	sub    $0x57,%eax
  80137a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80137d:	eb 20                	jmp    80139f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	3c 40                	cmp    $0x40,%al
  801386:	7e 39                	jle    8013c1 <strtol+0x126>
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	8a 00                	mov    (%eax),%al
  80138d:	3c 5a                	cmp    $0x5a,%al
  80138f:	7f 30                	jg     8013c1 <strtol+0x126>
			dig = *s - 'A' + 10;
  801391:	8b 45 08             	mov    0x8(%ebp),%eax
  801394:	8a 00                	mov    (%eax),%al
  801396:	0f be c0             	movsbl %al,%eax
  801399:	83 e8 37             	sub    $0x37,%eax
  80139c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80139f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013a2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013a5:	7d 19                	jge    8013c0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8013a7:	ff 45 08             	incl   0x8(%ebp)
  8013aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013ad:	0f af 45 10          	imul   0x10(%ebp),%eax
  8013b1:	89 c2                	mov    %eax,%edx
  8013b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013b6:	01 d0                	add    %edx,%eax
  8013b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8013bb:	e9 7b ff ff ff       	jmp    80133b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8013c0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8013c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013c5:	74 08                	je     8013cf <strtol+0x134>
		*endptr = (char *) s;
  8013c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8013cd:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8013cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013d3:	74 07                	je     8013dc <strtol+0x141>
  8013d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013d8:	f7 d8                	neg    %eax
  8013da:	eb 03                	jmp    8013df <strtol+0x144>
  8013dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013df:	c9                   	leave  
  8013e0:	c3                   	ret    

008013e1 <ltostr>:

void
ltostr(long value, char *str)
{
  8013e1:	55                   	push   %ebp
  8013e2:	89 e5                	mov    %esp,%ebp
  8013e4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8013e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8013ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8013f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013f9:	79 13                	jns    80140e <ltostr+0x2d>
	{
		neg = 1;
  8013fb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801402:	8b 45 0c             	mov    0xc(%ebp),%eax
  801405:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801408:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80140b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801416:	99                   	cltd   
  801417:	f7 f9                	idiv   %ecx
  801419:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80141c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80141f:	8d 50 01             	lea    0x1(%eax),%edx
  801422:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801425:	89 c2                	mov    %eax,%edx
  801427:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142a:	01 d0                	add    %edx,%eax
  80142c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80142f:	83 c2 30             	add    $0x30,%edx
  801432:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801434:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801437:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80143c:	f7 e9                	imul   %ecx
  80143e:	c1 fa 02             	sar    $0x2,%edx
  801441:	89 c8                	mov    %ecx,%eax
  801443:	c1 f8 1f             	sar    $0x1f,%eax
  801446:	29 c2                	sub    %eax,%edx
  801448:	89 d0                	mov    %edx,%eax
  80144a:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80144d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801451:	75 bb                	jne    80140e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801453:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80145a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80145d:	48                   	dec    %eax
  80145e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801461:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801465:	74 3d                	je     8014a4 <ltostr+0xc3>
		start = 1 ;
  801467:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80146e:	eb 34                	jmp    8014a4 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801470:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801473:	8b 45 0c             	mov    0xc(%ebp),%eax
  801476:	01 d0                	add    %edx,%eax
  801478:	8a 00                	mov    (%eax),%al
  80147a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80147d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801480:	8b 45 0c             	mov    0xc(%ebp),%eax
  801483:	01 c2                	add    %eax,%edx
  801485:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801488:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148b:	01 c8                	add    %ecx,%eax
  80148d:	8a 00                	mov    (%eax),%al
  80148f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801491:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801494:	8b 45 0c             	mov    0xc(%ebp),%eax
  801497:	01 c2                	add    %eax,%edx
  801499:	8a 45 eb             	mov    -0x15(%ebp),%al
  80149c:	88 02                	mov    %al,(%edx)
		start++ ;
  80149e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8014a1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8014a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014a7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014aa:	7c c4                	jl     801470 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014ac:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b2:	01 d0                	add    %edx,%eax
  8014b4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014b7:	90                   	nop
  8014b8:	c9                   	leave  
  8014b9:	c3                   	ret    

008014ba <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8014ba:	55                   	push   %ebp
  8014bb:	89 e5                	mov    %esp,%ebp
  8014bd:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8014c0:	ff 75 08             	pushl  0x8(%ebp)
  8014c3:	e8 c4 f9 ff ff       	call   800e8c <strlen>
  8014c8:	83 c4 04             	add    $0x4,%esp
  8014cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8014ce:	ff 75 0c             	pushl  0xc(%ebp)
  8014d1:	e8 b6 f9 ff ff       	call   800e8c <strlen>
  8014d6:	83 c4 04             	add    $0x4,%esp
  8014d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8014dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8014e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014ea:	eb 17                	jmp    801503 <strcconcat+0x49>
		final[s] = str1[s] ;
  8014ec:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f2:	01 c2                	add    %eax,%edx
  8014f4:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fa:	01 c8                	add    %ecx,%eax
  8014fc:	8a 00                	mov    (%eax),%al
  8014fe:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801500:	ff 45 fc             	incl   -0x4(%ebp)
  801503:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801506:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801509:	7c e1                	jl     8014ec <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80150b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801512:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801519:	eb 1f                	jmp    80153a <strcconcat+0x80>
		final[s++] = str2[i] ;
  80151b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80151e:	8d 50 01             	lea    0x1(%eax),%edx
  801521:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801524:	89 c2                	mov    %eax,%edx
  801526:	8b 45 10             	mov    0x10(%ebp),%eax
  801529:	01 c2                	add    %eax,%edx
  80152b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80152e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801531:	01 c8                	add    %ecx,%eax
  801533:	8a 00                	mov    (%eax),%al
  801535:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801537:	ff 45 f8             	incl   -0x8(%ebp)
  80153a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801540:	7c d9                	jl     80151b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801542:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801545:	8b 45 10             	mov    0x10(%ebp),%eax
  801548:	01 d0                	add    %edx,%eax
  80154a:	c6 00 00             	movb   $0x0,(%eax)
}
  80154d:	90                   	nop
  80154e:	c9                   	leave  
  80154f:	c3                   	ret    

00801550 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801550:	55                   	push   %ebp
  801551:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801553:	8b 45 14             	mov    0x14(%ebp),%eax
  801556:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80155c:	8b 45 14             	mov    0x14(%ebp),%eax
  80155f:	8b 00                	mov    (%eax),%eax
  801561:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801568:	8b 45 10             	mov    0x10(%ebp),%eax
  80156b:	01 d0                	add    %edx,%eax
  80156d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801573:	eb 0c                	jmp    801581 <strsplit+0x31>
			*string++ = 0;
  801575:	8b 45 08             	mov    0x8(%ebp),%eax
  801578:	8d 50 01             	lea    0x1(%eax),%edx
  80157b:	89 55 08             	mov    %edx,0x8(%ebp)
  80157e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801581:	8b 45 08             	mov    0x8(%ebp),%eax
  801584:	8a 00                	mov    (%eax),%al
  801586:	84 c0                	test   %al,%al
  801588:	74 18                	je     8015a2 <strsplit+0x52>
  80158a:	8b 45 08             	mov    0x8(%ebp),%eax
  80158d:	8a 00                	mov    (%eax),%al
  80158f:	0f be c0             	movsbl %al,%eax
  801592:	50                   	push   %eax
  801593:	ff 75 0c             	pushl  0xc(%ebp)
  801596:	e8 83 fa ff ff       	call   80101e <strchr>
  80159b:	83 c4 08             	add    $0x8,%esp
  80159e:	85 c0                	test   %eax,%eax
  8015a0:	75 d3                	jne    801575 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	8a 00                	mov    (%eax),%al
  8015a7:	84 c0                	test   %al,%al
  8015a9:	74 5a                	je     801605 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8015ae:	8b 00                	mov    (%eax),%eax
  8015b0:	83 f8 0f             	cmp    $0xf,%eax
  8015b3:	75 07                	jne    8015bc <strsplit+0x6c>
		{
			return 0;
  8015b5:	b8 00 00 00 00       	mov    $0x0,%eax
  8015ba:	eb 66                	jmp    801622 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8015bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8015bf:	8b 00                	mov    (%eax),%eax
  8015c1:	8d 48 01             	lea    0x1(%eax),%ecx
  8015c4:	8b 55 14             	mov    0x14(%ebp),%edx
  8015c7:	89 0a                	mov    %ecx,(%edx)
  8015c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d3:	01 c2                	add    %eax,%edx
  8015d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d8:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015da:	eb 03                	jmp    8015df <strsplit+0x8f>
			string++;
  8015dc:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015df:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e2:	8a 00                	mov    (%eax),%al
  8015e4:	84 c0                	test   %al,%al
  8015e6:	74 8b                	je     801573 <strsplit+0x23>
  8015e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015eb:	8a 00                	mov    (%eax),%al
  8015ed:	0f be c0             	movsbl %al,%eax
  8015f0:	50                   	push   %eax
  8015f1:	ff 75 0c             	pushl  0xc(%ebp)
  8015f4:	e8 25 fa ff ff       	call   80101e <strchr>
  8015f9:	83 c4 08             	add    $0x8,%esp
  8015fc:	85 c0                	test   %eax,%eax
  8015fe:	74 dc                	je     8015dc <strsplit+0x8c>
			string++;
	}
  801600:	e9 6e ff ff ff       	jmp    801573 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801605:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801606:	8b 45 14             	mov    0x14(%ebp),%eax
  801609:	8b 00                	mov    (%eax),%eax
  80160b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801612:	8b 45 10             	mov    0x10(%ebp),%eax
  801615:	01 d0                	add    %edx,%eax
  801617:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80161d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801622:	c9                   	leave  
  801623:	c3                   	ret    

00801624 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
  801627:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801630:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801637:	eb 4a                	jmp    801683 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801639:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80163c:	8b 45 08             	mov    0x8(%ebp),%eax
  80163f:	01 c2                	add    %eax,%edx
  801641:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801644:	8b 45 0c             	mov    0xc(%ebp),%eax
  801647:	01 c8                	add    %ecx,%eax
  801649:	8a 00                	mov    (%eax),%al
  80164b:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80164d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801650:	8b 45 0c             	mov    0xc(%ebp),%eax
  801653:	01 d0                	add    %edx,%eax
  801655:	8a 00                	mov    (%eax),%al
  801657:	3c 40                	cmp    $0x40,%al
  801659:	7e 25                	jle    801680 <str2lower+0x5c>
  80165b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80165e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801661:	01 d0                	add    %edx,%eax
  801663:	8a 00                	mov    (%eax),%al
  801665:	3c 5a                	cmp    $0x5a,%al
  801667:	7f 17                	jg     801680 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801669:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	01 d0                	add    %edx,%eax
  801671:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801674:	8b 55 08             	mov    0x8(%ebp),%edx
  801677:	01 ca                	add    %ecx,%edx
  801679:	8a 12                	mov    (%edx),%dl
  80167b:	83 c2 20             	add    $0x20,%edx
  80167e:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801680:	ff 45 fc             	incl   -0x4(%ebp)
  801683:	ff 75 0c             	pushl  0xc(%ebp)
  801686:	e8 01 f8 ff ff       	call   800e8c <strlen>
  80168b:	83 c4 04             	add    $0x4,%esp
  80168e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801691:	7f a6                	jg     801639 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801693:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801696:	c9                   	leave  
  801697:	c3                   	ret    

00801698 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801698:	55                   	push   %ebp
  801699:	89 e5                	mov    %esp,%ebp
  80169b:	57                   	push   %edi
  80169c:	56                   	push   %esi
  80169d:	53                   	push   %ebx
  80169e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016aa:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016ad:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016b0:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016b3:	cd 30                	int    $0x30
  8016b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016bb:	83 c4 10             	add    $0x10,%esp
  8016be:	5b                   	pop    %ebx
  8016bf:	5e                   	pop    %esi
  8016c0:	5f                   	pop    %edi
  8016c1:	5d                   	pop    %ebp
  8016c2:	c3                   	ret    

008016c3 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8016c3:	55                   	push   %ebp
  8016c4:	89 e5                	mov    %esp,%ebp
  8016c6:	83 ec 04             	sub    $0x4,%esp
  8016c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016cc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8016cf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016d2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d9:	6a 00                	push   $0x0
  8016db:	51                   	push   %ecx
  8016dc:	52                   	push   %edx
  8016dd:	ff 75 0c             	pushl  0xc(%ebp)
  8016e0:	50                   	push   %eax
  8016e1:	6a 00                	push   $0x0
  8016e3:	e8 b0 ff ff ff       	call   801698 <syscall>
  8016e8:	83 c4 18             	add    $0x18,%esp
}
  8016eb:	90                   	nop
  8016ec:	c9                   	leave  
  8016ed:	c3                   	ret    

008016ee <sys_cgetc>:

int
sys_cgetc(void)
{
  8016ee:	55                   	push   %ebp
  8016ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 02                	push   $0x2
  8016fd:	e8 96 ff ff ff       	call   801698 <syscall>
  801702:	83 c4 18             	add    $0x18,%esp
}
  801705:	c9                   	leave  
  801706:	c3                   	ret    

00801707 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801707:	55                   	push   %ebp
  801708:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 03                	push   $0x3
  801716:	e8 7d ff ff ff       	call   801698 <syscall>
  80171b:	83 c4 18             	add    $0x18,%esp
}
  80171e:	90                   	nop
  80171f:	c9                   	leave  
  801720:	c3                   	ret    

00801721 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801721:	55                   	push   %ebp
  801722:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 04                	push   $0x4
  801730:	e8 63 ff ff ff       	call   801698 <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
}
  801738:	90                   	nop
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80173e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801741:	8b 45 08             	mov    0x8(%ebp),%eax
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	52                   	push   %edx
  80174b:	50                   	push   %eax
  80174c:	6a 08                	push   $0x8
  80174e:	e8 45 ff ff ff       	call   801698 <syscall>
  801753:	83 c4 18             	add    $0x18,%esp
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
  80175b:	56                   	push   %esi
  80175c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80175d:	8b 75 18             	mov    0x18(%ebp),%esi
  801760:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801763:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801766:	8b 55 0c             	mov    0xc(%ebp),%edx
  801769:	8b 45 08             	mov    0x8(%ebp),%eax
  80176c:	56                   	push   %esi
  80176d:	53                   	push   %ebx
  80176e:	51                   	push   %ecx
  80176f:	52                   	push   %edx
  801770:	50                   	push   %eax
  801771:	6a 09                	push   $0x9
  801773:	e8 20 ff ff ff       	call   801698 <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
}
  80177b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80177e:	5b                   	pop    %ebx
  80177f:	5e                   	pop    %esi
  801780:	5d                   	pop    %ebp
  801781:	c3                   	ret    

00801782 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801782:	55                   	push   %ebp
  801783:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	ff 75 08             	pushl  0x8(%ebp)
  801790:	6a 0a                	push   $0xa
  801792:	e8 01 ff ff ff       	call   801698 <syscall>
  801797:	83 c4 18             	add    $0x18,%esp
}
  80179a:	c9                   	leave  
  80179b:	c3                   	ret    

0080179c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80179c:	55                   	push   %ebp
  80179d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	ff 75 0c             	pushl  0xc(%ebp)
  8017a8:	ff 75 08             	pushl  0x8(%ebp)
  8017ab:	6a 0b                	push   $0xb
  8017ad:	e8 e6 fe ff ff       	call   801698 <syscall>
  8017b2:	83 c4 18             	add    $0x18,%esp
}
  8017b5:	c9                   	leave  
  8017b6:	c3                   	ret    

008017b7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017b7:	55                   	push   %ebp
  8017b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 0c                	push   $0xc
  8017c6:	e8 cd fe ff ff       	call   801698 <syscall>
  8017cb:	83 c4 18             	add    $0x18,%esp
}
  8017ce:	c9                   	leave  
  8017cf:	c3                   	ret    

008017d0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017d0:	55                   	push   %ebp
  8017d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 0d                	push   $0xd
  8017df:	e8 b4 fe ff ff       	call   801698 <syscall>
  8017e4:	83 c4 18             	add    $0x18,%esp
}
  8017e7:	c9                   	leave  
  8017e8:	c3                   	ret    

008017e9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017e9:	55                   	push   %ebp
  8017ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 0e                	push   $0xe
  8017f8:	e8 9b fe ff ff       	call   801698 <syscall>
  8017fd:	83 c4 18             	add    $0x18,%esp
}
  801800:	c9                   	leave  
  801801:	c3                   	ret    

00801802 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801802:	55                   	push   %ebp
  801803:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 0f                	push   $0xf
  801811:	e8 82 fe ff ff       	call   801698 <syscall>
  801816:	83 c4 18             	add    $0x18,%esp
}
  801819:	c9                   	leave  
  80181a:	c3                   	ret    

0080181b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80181b:	55                   	push   %ebp
  80181c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	ff 75 08             	pushl  0x8(%ebp)
  801829:	6a 10                	push   $0x10
  80182b:	e8 68 fe ff ff       	call   801698 <syscall>
  801830:	83 c4 18             	add    $0x18,%esp
}
  801833:	c9                   	leave  
  801834:	c3                   	ret    

00801835 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801835:	55                   	push   %ebp
  801836:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	6a 11                	push   $0x11
  801844:	e8 4f fe ff ff       	call   801698 <syscall>
  801849:	83 c4 18             	add    $0x18,%esp
}
  80184c:	90                   	nop
  80184d:	c9                   	leave  
  80184e:	c3                   	ret    

0080184f <sys_cputc>:

void
sys_cputc(const char c)
{
  80184f:	55                   	push   %ebp
  801850:	89 e5                	mov    %esp,%ebp
  801852:	83 ec 04             	sub    $0x4,%esp
  801855:	8b 45 08             	mov    0x8(%ebp),%eax
  801858:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80185b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	50                   	push   %eax
  801868:	6a 01                	push   $0x1
  80186a:	e8 29 fe ff ff       	call   801698 <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
}
  801872:	90                   	nop
  801873:	c9                   	leave  
  801874:	c3                   	ret    

00801875 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801875:	55                   	push   %ebp
  801876:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 14                	push   $0x14
  801884:	e8 0f fe ff ff       	call   801698 <syscall>
  801889:	83 c4 18             	add    $0x18,%esp
}
  80188c:	90                   	nop
  80188d:	c9                   	leave  
  80188e:	c3                   	ret    

0080188f <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  80188f:	55                   	push   %ebp
  801890:	89 e5                	mov    %esp,%ebp
  801892:	83 ec 04             	sub    $0x4,%esp
  801895:	8b 45 10             	mov    0x10(%ebp),%eax
  801898:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  80189b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80189e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a5:	6a 00                	push   $0x0
  8018a7:	51                   	push   %ecx
  8018a8:	52                   	push   %edx
  8018a9:	ff 75 0c             	pushl  0xc(%ebp)
  8018ac:	50                   	push   %eax
  8018ad:	6a 15                	push   $0x15
  8018af:	e8 e4 fd ff ff       	call   801698 <syscall>
  8018b4:	83 c4 18             	add    $0x18,%esp
}
  8018b7:	c9                   	leave  
  8018b8:	c3                   	ret    

008018b9 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8018bc:	8b 55 10             	mov    0x10(%ebp),%edx
  8018bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	52                   	push   %edx
  8018c7:	50                   	push   %eax
  8018c8:	ff 75 08             	pushl  0x8(%ebp)
  8018cb:	6a 16                	push   $0x16
  8018cd:	e8 c6 fd ff ff       	call   801698 <syscall>
  8018d2:	83 c4 18             	add    $0x18,%esp
}
  8018d5:	c9                   	leave  
  8018d6:	c3                   	ret    

008018d7 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8018d7:	55                   	push   %ebp
  8018d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	52                   	push   %edx
  8018e7:	50                   	push   %eax
  8018e8:	6a 17                	push   $0x17
  8018ea:	e8 a9 fd ff ff       	call   801698 <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
}
  8018f2:	c9                   	leave  
  8018f3:	c3                   	ret    

008018f4 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8018f4:	55                   	push   %ebp
  8018f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	52                   	push   %edx
  801904:	50                   	push   %eax
  801905:	6a 18                	push   $0x18
  801907:	e8 8c fd ff ff       	call   801698 <syscall>
  80190c:	83 c4 18             	add    $0x18,%esp
}
  80190f:	c9                   	leave  
  801910:	c3                   	ret    

00801911 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801911:	55                   	push   %ebp
  801912:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801914:	8b 45 08             	mov    0x8(%ebp),%eax
  801917:	6a 00                	push   $0x0
  801919:	ff 75 14             	pushl  0x14(%ebp)
  80191c:	ff 75 10             	pushl  0x10(%ebp)
  80191f:	ff 75 0c             	pushl  0xc(%ebp)
  801922:	50                   	push   %eax
  801923:	6a 19                	push   $0x19
  801925:	e8 6e fd ff ff       	call   801698 <syscall>
  80192a:	83 c4 18             	add    $0x18,%esp
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <sys_run_env>:

void sys_run_env(int32 envId)
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801932:	8b 45 08             	mov    0x8(%ebp),%eax
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	50                   	push   %eax
  80193e:	6a 1a                	push   $0x1a
  801940:	e8 53 fd ff ff       	call   801698 <syscall>
  801945:	83 c4 18             	add    $0x18,%esp
}
  801948:	90                   	nop
  801949:	c9                   	leave  
  80194a:	c3                   	ret    

0080194b <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  80194b:	55                   	push   %ebp
  80194c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80194e:	8b 45 08             	mov    0x8(%ebp),%eax
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	50                   	push   %eax
  80195a:	6a 1b                	push   $0x1b
  80195c:	e8 37 fd ff ff       	call   801698 <syscall>
  801961:	83 c4 18             	add    $0x18,%esp
}
  801964:	c9                   	leave  
  801965:	c3                   	ret    

00801966 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801966:	55                   	push   %ebp
  801967:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 05                	push   $0x5
  801975:	e8 1e fd ff ff       	call   801698 <syscall>
  80197a:	83 c4 18             	add    $0x18,%esp
}
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 06                	push   $0x6
  80198e:	e8 05 fd ff ff       	call   801698 <syscall>
  801993:	83 c4 18             	add    $0x18,%esp
}
  801996:	c9                   	leave  
  801997:	c3                   	ret    

00801998 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 07                	push   $0x7
  8019a7:	e8 ec fc ff ff       	call   801698 <syscall>
  8019ac:	83 c4 18             	add    $0x18,%esp
}
  8019af:	c9                   	leave  
  8019b0:	c3                   	ret    

008019b1 <sys_exit_env>:


void sys_exit_env(void)
{
  8019b1:	55                   	push   %ebp
  8019b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 1c                	push   $0x1c
  8019c0:	e8 d3 fc ff ff       	call   801698 <syscall>
  8019c5:	83 c4 18             	add    $0x18,%esp
}
  8019c8:	90                   	nop
  8019c9:	c9                   	leave  
  8019ca:	c3                   	ret    

008019cb <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019cb:	55                   	push   %ebp
  8019cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	ff 75 10             	pushl  0x10(%ebp)
  8019d5:	ff 75 0c             	pushl  0xc(%ebp)
  8019d8:	ff 75 08             	pushl  0x8(%ebp)
  8019db:	6a 13                	push   $0x13
  8019dd:	e8 b6 fc ff ff       	call   801698 <syscall>
  8019e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e5:	90                   	nop
}
  8019e6:	c9                   	leave  
  8019e7:	c3                   	ret    

008019e8 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019e8:	55                   	push   %ebp
  8019e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 1e                	push   $0x1e
  8019f7:	e8 9c fc ff ff       	call   801698 <syscall>
  8019fc:	83 c4 18             	add    $0x18,%esp
}
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
  801a04:	83 ec 04             	sub    $0x4,%esp
  801a07:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a0d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	50                   	push   %eax
  801a1a:	6a 1f                	push   $0x1f
  801a1c:	e8 77 fc ff ff       	call   801698 <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
	return ;
  801a24:	90                   	nop
}
  801a25:	c9                   	leave  
  801a26:	c3                   	ret    

00801a27 <rsttst>:
void rsttst()
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 21                	push   $0x21
  801a36:	e8 5d fc ff ff       	call   801698 <syscall>
  801a3b:	83 c4 18             	add    $0x18,%esp
	return ;
  801a3e:	90                   	nop
}
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
  801a44:	83 ec 04             	sub    $0x4,%esp
  801a47:	8b 45 14             	mov    0x14(%ebp),%eax
  801a4a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a4d:	8b 55 18             	mov    0x18(%ebp),%edx
  801a50:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a54:	52                   	push   %edx
  801a55:	50                   	push   %eax
  801a56:	ff 75 10             	pushl  0x10(%ebp)
  801a59:	ff 75 0c             	pushl  0xc(%ebp)
  801a5c:	ff 75 08             	pushl  0x8(%ebp)
  801a5f:	6a 20                	push   $0x20
  801a61:	e8 32 fc ff ff       	call   801698 <syscall>
  801a66:	83 c4 18             	add    $0x18,%esp
	return ;
  801a69:	90                   	nop
}
  801a6a:	c9                   	leave  
  801a6b:	c3                   	ret    

00801a6c <chktst>:
void chktst(uint32 n)
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	ff 75 08             	pushl  0x8(%ebp)
  801a7a:	6a 22                	push   $0x22
  801a7c:	e8 17 fc ff ff       	call   801698 <syscall>
  801a81:	83 c4 18             	add    $0x18,%esp
	return ;
  801a84:	90                   	nop
}
  801a85:	c9                   	leave  
  801a86:	c3                   	ret    

00801a87 <inctst>:

void inctst()
{
  801a87:	55                   	push   %ebp
  801a88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 23                	push   $0x23
  801a96:	e8 fd fb ff ff       	call   801698 <syscall>
  801a9b:	83 c4 18             	add    $0x18,%esp
	return ;
  801a9e:	90                   	nop
}
  801a9f:	c9                   	leave  
  801aa0:	c3                   	ret    

00801aa1 <gettst>:
uint32 gettst()
{
  801aa1:	55                   	push   %ebp
  801aa2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 24                	push   $0x24
  801ab0:	e8 e3 fb ff ff       	call   801698 <syscall>
  801ab5:	83 c4 18             	add    $0x18,%esp
}
  801ab8:	c9                   	leave  
  801ab9:	c3                   	ret    

00801aba <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801aba:	55                   	push   %ebp
  801abb:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 25                	push   $0x25
  801ac9:	e8 ca fb ff ff       	call   801698 <syscall>
  801ace:	83 c4 18             	add    $0x18,%esp
  801ad1:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801ad6:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801adb:	c9                   	leave  
  801adc:	c3                   	ret    

00801add <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801add:	55                   	push   %ebp
  801ade:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae3:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	ff 75 08             	pushl  0x8(%ebp)
  801af3:	6a 26                	push   $0x26
  801af5:	e8 9e fb ff ff       	call   801698 <syscall>
  801afa:	83 c4 18             	add    $0x18,%esp
	return ;
  801afd:	90                   	nop
}
  801afe:	c9                   	leave  
  801aff:	c3                   	ret    

00801b00 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b00:	55                   	push   %ebp
  801b01:	89 e5                	mov    %esp,%ebp
  801b03:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b04:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b07:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b10:	6a 00                	push   $0x0
  801b12:	53                   	push   %ebx
  801b13:	51                   	push   %ecx
  801b14:	52                   	push   %edx
  801b15:	50                   	push   %eax
  801b16:	6a 27                	push   $0x27
  801b18:	e8 7b fb ff ff       	call   801698 <syscall>
  801b1d:	83 c4 18             	add    $0x18,%esp
}
  801b20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b28:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	52                   	push   %edx
  801b35:	50                   	push   %eax
  801b36:	6a 28                	push   $0x28
  801b38:	e8 5b fb ff ff       	call   801698 <syscall>
  801b3d:	83 c4 18             	add    $0x18,%esp
}
  801b40:	c9                   	leave  
  801b41:	c3                   	ret    

00801b42 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b42:	55                   	push   %ebp
  801b43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b45:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b48:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4e:	6a 00                	push   $0x0
  801b50:	51                   	push   %ecx
  801b51:	ff 75 10             	pushl  0x10(%ebp)
  801b54:	52                   	push   %edx
  801b55:	50                   	push   %eax
  801b56:	6a 29                	push   $0x29
  801b58:	e8 3b fb ff ff       	call   801698 <syscall>
  801b5d:	83 c4 18             	add    $0x18,%esp
}
  801b60:	c9                   	leave  
  801b61:	c3                   	ret    

00801b62 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801b62:	55                   	push   %ebp
  801b63:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	ff 75 10             	pushl  0x10(%ebp)
  801b6c:	ff 75 0c             	pushl  0xc(%ebp)
  801b6f:	ff 75 08             	pushl  0x8(%ebp)
  801b72:	6a 12                	push   $0x12
  801b74:	e8 1f fb ff ff       	call   801698 <syscall>
  801b79:	83 c4 18             	add    $0x18,%esp
	return ;
  801b7c:	90                   	nop
}
  801b7d:	c9                   	leave  
  801b7e:	c3                   	ret    

00801b7f <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801b7f:	55                   	push   %ebp
  801b80:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801b82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b85:	8b 45 08             	mov    0x8(%ebp),%eax
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	52                   	push   %edx
  801b8f:	50                   	push   %eax
  801b90:	6a 2a                	push   $0x2a
  801b92:	e8 01 fb ff ff       	call   801698 <syscall>
  801b97:	83 c4 18             	add    $0x18,%esp
	return;
  801b9a:	90                   	nop
}
  801b9b:	c9                   	leave  
  801b9c:	c3                   	ret    

00801b9d <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801b9d:	55                   	push   %ebp
  801b9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 2b                	push   $0x2b
  801bac:	e8 e7 fa ff ff       	call   801698 <syscall>
  801bb1:	83 c4 18             	add    $0x18,%esp
}
  801bb4:	c9                   	leave  
  801bb5:	c3                   	ret    

00801bb6 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801bb6:	55                   	push   %ebp
  801bb7:	89 e5                	mov    %esp,%ebp
  801bb9:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801bbc:	83 ec 04             	sub    $0x4,%esp
  801bbf:	68 c8 28 80 00       	push   $0x8028c8
  801bc4:	68 0a 01 00 00       	push   $0x10a
  801bc9:	68 d8 28 80 00       	push   $0x8028d8
  801bce:	e8 12 e9 ff ff       	call   8004e5 <_panic>

00801bd3 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801bd3:	55                   	push   %ebp
  801bd4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	ff 75 0c             	pushl  0xc(%ebp)
  801bdf:	ff 75 08             	pushl  0x8(%ebp)
  801be2:	6a 33                	push   $0x33
  801be4:	e8 af fa ff ff       	call   801698 <syscall>
  801be9:	83 c4 18             	add    $0x18,%esp
	return;
  801bec:	90                   	nop
}
  801bed:	c9                   	leave  
  801bee:	c3                   	ret    

00801bef <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801bf2:	6a 00                	push   $0x0
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	ff 75 0c             	pushl  0xc(%ebp)
  801bfb:	ff 75 08             	pushl  0x8(%ebp)
  801bfe:	6a 34                	push   $0x34
  801c00:	e8 93 fa ff ff       	call   801698 <syscall>
  801c05:	83 c4 18             	add    $0x18,%esp
	return ;
  801c08:	90                   	nop
}
  801c09:	c9                   	leave  
  801c0a:	c3                   	ret    

00801c0b <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801c0b:	55                   	push   %ebp
  801c0c:	89 e5                	mov    %esp,%ebp
  801c0e:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801c11:	8b 55 08             	mov    0x8(%ebp),%edx
  801c14:	89 d0                	mov    %edx,%eax
  801c16:	c1 e0 02             	shl    $0x2,%eax
  801c19:	01 d0                	add    %edx,%eax
  801c1b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c22:	01 d0                	add    %edx,%eax
  801c24:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c2b:	01 d0                	add    %edx,%eax
  801c2d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c34:	01 d0                	add    %edx,%eax
  801c36:	c1 e0 04             	shl    $0x4,%eax
  801c39:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801c3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c43:	0f 31                	rdtsc  
  801c45:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801c48:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c4b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c4e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c51:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c54:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c57:	eb 46                	jmp    801c9f <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c59:	0f 31                	rdtsc  
  801c5b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801c5e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c61:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801c64:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801c67:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801c6a:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801c6d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c70:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c73:	29 c2                	sub    %eax,%edx
  801c75:	89 d0                	mov    %edx,%eax
  801c77:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801c7a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c80:	89 d1                	mov    %edx,%ecx
  801c82:	29 c1                	sub    %eax,%ecx
  801c84:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801c87:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c8a:	39 c2                	cmp    %eax,%edx
  801c8c:	0f 97 c0             	seta   %al
  801c8f:	0f b6 c0             	movzbl %al,%eax
  801c92:	29 c1                	sub    %eax,%ecx
  801c94:	89 c8                	mov    %ecx,%eax
  801c96:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801c99:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801c9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ca2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801ca5:	72 b2                	jb     801c59 <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801ca7:	90                   	nop
  801ca8:	c9                   	leave  
  801ca9:	c3                   	ret    

00801caa <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801caa:	55                   	push   %ebp
  801cab:	89 e5                	mov    %esp,%ebp
  801cad:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801cb0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801cb7:	eb 03                	jmp    801cbc <busy_wait+0x12>
  801cb9:	ff 45 fc             	incl   -0x4(%ebp)
  801cbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cbf:	3b 45 08             	cmp    0x8(%ebp),%eax
  801cc2:	72 f5                	jb     801cb9 <busy_wait+0xf>
	return i;
  801cc4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801cc7:	c9                   	leave  
  801cc8:	c3                   	ret    
  801cc9:	66 90                	xchg   %ax,%ax
  801ccb:	90                   	nop

00801ccc <__udivdi3>:
  801ccc:	55                   	push   %ebp
  801ccd:	57                   	push   %edi
  801cce:	56                   	push   %esi
  801ccf:	53                   	push   %ebx
  801cd0:	83 ec 1c             	sub    $0x1c,%esp
  801cd3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801cd7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801cdb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cdf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ce3:	89 ca                	mov    %ecx,%edx
  801ce5:	89 f8                	mov    %edi,%eax
  801ce7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ceb:	85 f6                	test   %esi,%esi
  801ced:	75 2d                	jne    801d1c <__udivdi3+0x50>
  801cef:	39 cf                	cmp    %ecx,%edi
  801cf1:	77 65                	ja     801d58 <__udivdi3+0x8c>
  801cf3:	89 fd                	mov    %edi,%ebp
  801cf5:	85 ff                	test   %edi,%edi
  801cf7:	75 0b                	jne    801d04 <__udivdi3+0x38>
  801cf9:	b8 01 00 00 00       	mov    $0x1,%eax
  801cfe:	31 d2                	xor    %edx,%edx
  801d00:	f7 f7                	div    %edi
  801d02:	89 c5                	mov    %eax,%ebp
  801d04:	31 d2                	xor    %edx,%edx
  801d06:	89 c8                	mov    %ecx,%eax
  801d08:	f7 f5                	div    %ebp
  801d0a:	89 c1                	mov    %eax,%ecx
  801d0c:	89 d8                	mov    %ebx,%eax
  801d0e:	f7 f5                	div    %ebp
  801d10:	89 cf                	mov    %ecx,%edi
  801d12:	89 fa                	mov    %edi,%edx
  801d14:	83 c4 1c             	add    $0x1c,%esp
  801d17:	5b                   	pop    %ebx
  801d18:	5e                   	pop    %esi
  801d19:	5f                   	pop    %edi
  801d1a:	5d                   	pop    %ebp
  801d1b:	c3                   	ret    
  801d1c:	39 ce                	cmp    %ecx,%esi
  801d1e:	77 28                	ja     801d48 <__udivdi3+0x7c>
  801d20:	0f bd fe             	bsr    %esi,%edi
  801d23:	83 f7 1f             	xor    $0x1f,%edi
  801d26:	75 40                	jne    801d68 <__udivdi3+0x9c>
  801d28:	39 ce                	cmp    %ecx,%esi
  801d2a:	72 0a                	jb     801d36 <__udivdi3+0x6a>
  801d2c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d30:	0f 87 9e 00 00 00    	ja     801dd4 <__udivdi3+0x108>
  801d36:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3b:	89 fa                	mov    %edi,%edx
  801d3d:	83 c4 1c             	add    $0x1c,%esp
  801d40:	5b                   	pop    %ebx
  801d41:	5e                   	pop    %esi
  801d42:	5f                   	pop    %edi
  801d43:	5d                   	pop    %ebp
  801d44:	c3                   	ret    
  801d45:	8d 76 00             	lea    0x0(%esi),%esi
  801d48:	31 ff                	xor    %edi,%edi
  801d4a:	31 c0                	xor    %eax,%eax
  801d4c:	89 fa                	mov    %edi,%edx
  801d4e:	83 c4 1c             	add    $0x1c,%esp
  801d51:	5b                   	pop    %ebx
  801d52:	5e                   	pop    %esi
  801d53:	5f                   	pop    %edi
  801d54:	5d                   	pop    %ebp
  801d55:	c3                   	ret    
  801d56:	66 90                	xchg   %ax,%ax
  801d58:	89 d8                	mov    %ebx,%eax
  801d5a:	f7 f7                	div    %edi
  801d5c:	31 ff                	xor    %edi,%edi
  801d5e:	89 fa                	mov    %edi,%edx
  801d60:	83 c4 1c             	add    $0x1c,%esp
  801d63:	5b                   	pop    %ebx
  801d64:	5e                   	pop    %esi
  801d65:	5f                   	pop    %edi
  801d66:	5d                   	pop    %ebp
  801d67:	c3                   	ret    
  801d68:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d6d:	89 eb                	mov    %ebp,%ebx
  801d6f:	29 fb                	sub    %edi,%ebx
  801d71:	89 f9                	mov    %edi,%ecx
  801d73:	d3 e6                	shl    %cl,%esi
  801d75:	89 c5                	mov    %eax,%ebp
  801d77:	88 d9                	mov    %bl,%cl
  801d79:	d3 ed                	shr    %cl,%ebp
  801d7b:	89 e9                	mov    %ebp,%ecx
  801d7d:	09 f1                	or     %esi,%ecx
  801d7f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d83:	89 f9                	mov    %edi,%ecx
  801d85:	d3 e0                	shl    %cl,%eax
  801d87:	89 c5                	mov    %eax,%ebp
  801d89:	89 d6                	mov    %edx,%esi
  801d8b:	88 d9                	mov    %bl,%cl
  801d8d:	d3 ee                	shr    %cl,%esi
  801d8f:	89 f9                	mov    %edi,%ecx
  801d91:	d3 e2                	shl    %cl,%edx
  801d93:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d97:	88 d9                	mov    %bl,%cl
  801d99:	d3 e8                	shr    %cl,%eax
  801d9b:	09 c2                	or     %eax,%edx
  801d9d:	89 d0                	mov    %edx,%eax
  801d9f:	89 f2                	mov    %esi,%edx
  801da1:	f7 74 24 0c          	divl   0xc(%esp)
  801da5:	89 d6                	mov    %edx,%esi
  801da7:	89 c3                	mov    %eax,%ebx
  801da9:	f7 e5                	mul    %ebp
  801dab:	39 d6                	cmp    %edx,%esi
  801dad:	72 19                	jb     801dc8 <__udivdi3+0xfc>
  801daf:	74 0b                	je     801dbc <__udivdi3+0xf0>
  801db1:	89 d8                	mov    %ebx,%eax
  801db3:	31 ff                	xor    %edi,%edi
  801db5:	e9 58 ff ff ff       	jmp    801d12 <__udivdi3+0x46>
  801dba:	66 90                	xchg   %ax,%ax
  801dbc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801dc0:	89 f9                	mov    %edi,%ecx
  801dc2:	d3 e2                	shl    %cl,%edx
  801dc4:	39 c2                	cmp    %eax,%edx
  801dc6:	73 e9                	jae    801db1 <__udivdi3+0xe5>
  801dc8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801dcb:	31 ff                	xor    %edi,%edi
  801dcd:	e9 40 ff ff ff       	jmp    801d12 <__udivdi3+0x46>
  801dd2:	66 90                	xchg   %ax,%ax
  801dd4:	31 c0                	xor    %eax,%eax
  801dd6:	e9 37 ff ff ff       	jmp    801d12 <__udivdi3+0x46>
  801ddb:	90                   	nop

00801ddc <__umoddi3>:
  801ddc:	55                   	push   %ebp
  801ddd:	57                   	push   %edi
  801dde:	56                   	push   %esi
  801ddf:	53                   	push   %ebx
  801de0:	83 ec 1c             	sub    $0x1c,%esp
  801de3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801de7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801deb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801def:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801df3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801df7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801dfb:	89 f3                	mov    %esi,%ebx
  801dfd:	89 fa                	mov    %edi,%edx
  801dff:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e03:	89 34 24             	mov    %esi,(%esp)
  801e06:	85 c0                	test   %eax,%eax
  801e08:	75 1a                	jne    801e24 <__umoddi3+0x48>
  801e0a:	39 f7                	cmp    %esi,%edi
  801e0c:	0f 86 a2 00 00 00    	jbe    801eb4 <__umoddi3+0xd8>
  801e12:	89 c8                	mov    %ecx,%eax
  801e14:	89 f2                	mov    %esi,%edx
  801e16:	f7 f7                	div    %edi
  801e18:	89 d0                	mov    %edx,%eax
  801e1a:	31 d2                	xor    %edx,%edx
  801e1c:	83 c4 1c             	add    $0x1c,%esp
  801e1f:	5b                   	pop    %ebx
  801e20:	5e                   	pop    %esi
  801e21:	5f                   	pop    %edi
  801e22:	5d                   	pop    %ebp
  801e23:	c3                   	ret    
  801e24:	39 f0                	cmp    %esi,%eax
  801e26:	0f 87 ac 00 00 00    	ja     801ed8 <__umoddi3+0xfc>
  801e2c:	0f bd e8             	bsr    %eax,%ebp
  801e2f:	83 f5 1f             	xor    $0x1f,%ebp
  801e32:	0f 84 ac 00 00 00    	je     801ee4 <__umoddi3+0x108>
  801e38:	bf 20 00 00 00       	mov    $0x20,%edi
  801e3d:	29 ef                	sub    %ebp,%edi
  801e3f:	89 fe                	mov    %edi,%esi
  801e41:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e45:	89 e9                	mov    %ebp,%ecx
  801e47:	d3 e0                	shl    %cl,%eax
  801e49:	89 d7                	mov    %edx,%edi
  801e4b:	89 f1                	mov    %esi,%ecx
  801e4d:	d3 ef                	shr    %cl,%edi
  801e4f:	09 c7                	or     %eax,%edi
  801e51:	89 e9                	mov    %ebp,%ecx
  801e53:	d3 e2                	shl    %cl,%edx
  801e55:	89 14 24             	mov    %edx,(%esp)
  801e58:	89 d8                	mov    %ebx,%eax
  801e5a:	d3 e0                	shl    %cl,%eax
  801e5c:	89 c2                	mov    %eax,%edx
  801e5e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e62:	d3 e0                	shl    %cl,%eax
  801e64:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e68:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e6c:	89 f1                	mov    %esi,%ecx
  801e6e:	d3 e8                	shr    %cl,%eax
  801e70:	09 d0                	or     %edx,%eax
  801e72:	d3 eb                	shr    %cl,%ebx
  801e74:	89 da                	mov    %ebx,%edx
  801e76:	f7 f7                	div    %edi
  801e78:	89 d3                	mov    %edx,%ebx
  801e7a:	f7 24 24             	mull   (%esp)
  801e7d:	89 c6                	mov    %eax,%esi
  801e7f:	89 d1                	mov    %edx,%ecx
  801e81:	39 d3                	cmp    %edx,%ebx
  801e83:	0f 82 87 00 00 00    	jb     801f10 <__umoddi3+0x134>
  801e89:	0f 84 91 00 00 00    	je     801f20 <__umoddi3+0x144>
  801e8f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e93:	29 f2                	sub    %esi,%edx
  801e95:	19 cb                	sbb    %ecx,%ebx
  801e97:	89 d8                	mov    %ebx,%eax
  801e99:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e9d:	d3 e0                	shl    %cl,%eax
  801e9f:	89 e9                	mov    %ebp,%ecx
  801ea1:	d3 ea                	shr    %cl,%edx
  801ea3:	09 d0                	or     %edx,%eax
  801ea5:	89 e9                	mov    %ebp,%ecx
  801ea7:	d3 eb                	shr    %cl,%ebx
  801ea9:	89 da                	mov    %ebx,%edx
  801eab:	83 c4 1c             	add    $0x1c,%esp
  801eae:	5b                   	pop    %ebx
  801eaf:	5e                   	pop    %esi
  801eb0:	5f                   	pop    %edi
  801eb1:	5d                   	pop    %ebp
  801eb2:	c3                   	ret    
  801eb3:	90                   	nop
  801eb4:	89 fd                	mov    %edi,%ebp
  801eb6:	85 ff                	test   %edi,%edi
  801eb8:	75 0b                	jne    801ec5 <__umoddi3+0xe9>
  801eba:	b8 01 00 00 00       	mov    $0x1,%eax
  801ebf:	31 d2                	xor    %edx,%edx
  801ec1:	f7 f7                	div    %edi
  801ec3:	89 c5                	mov    %eax,%ebp
  801ec5:	89 f0                	mov    %esi,%eax
  801ec7:	31 d2                	xor    %edx,%edx
  801ec9:	f7 f5                	div    %ebp
  801ecb:	89 c8                	mov    %ecx,%eax
  801ecd:	f7 f5                	div    %ebp
  801ecf:	89 d0                	mov    %edx,%eax
  801ed1:	e9 44 ff ff ff       	jmp    801e1a <__umoddi3+0x3e>
  801ed6:	66 90                	xchg   %ax,%ax
  801ed8:	89 c8                	mov    %ecx,%eax
  801eda:	89 f2                	mov    %esi,%edx
  801edc:	83 c4 1c             	add    $0x1c,%esp
  801edf:	5b                   	pop    %ebx
  801ee0:	5e                   	pop    %esi
  801ee1:	5f                   	pop    %edi
  801ee2:	5d                   	pop    %ebp
  801ee3:	c3                   	ret    
  801ee4:	3b 04 24             	cmp    (%esp),%eax
  801ee7:	72 06                	jb     801eef <__umoddi3+0x113>
  801ee9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801eed:	77 0f                	ja     801efe <__umoddi3+0x122>
  801eef:	89 f2                	mov    %esi,%edx
  801ef1:	29 f9                	sub    %edi,%ecx
  801ef3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ef7:	89 14 24             	mov    %edx,(%esp)
  801efa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801efe:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f02:	8b 14 24             	mov    (%esp),%edx
  801f05:	83 c4 1c             	add    $0x1c,%esp
  801f08:	5b                   	pop    %ebx
  801f09:	5e                   	pop    %esi
  801f0a:	5f                   	pop    %edi
  801f0b:	5d                   	pop    %ebp
  801f0c:	c3                   	ret    
  801f0d:	8d 76 00             	lea    0x0(%esi),%esi
  801f10:	2b 04 24             	sub    (%esp),%eax
  801f13:	19 fa                	sbb    %edi,%edx
  801f15:	89 d1                	mov    %edx,%ecx
  801f17:	89 c6                	mov    %eax,%esi
  801f19:	e9 71 ff ff ff       	jmp    801e8f <__umoddi3+0xb3>
  801f1e:	66 90                	xchg   %ax,%ax
  801f20:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f24:	72 ea                	jb     801f10 <__umoddi3+0x134>
  801f26:	89 d9                	mov    %ebx,%ecx
  801f28:	e9 62 ff ff ff       	jmp    801e8f <__umoddi3+0xb3>
