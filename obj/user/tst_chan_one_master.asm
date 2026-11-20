
obj/user/tst_chan_one_master:     file format elf32-i386


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
  800031:	e8 90 02 00 00       	call   8002c6 <libmain>
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
  80003e:	81 ec 3c 01 00 00    	sub    $0x13c,%esp
	printStats = 0;
  800044:	c7 05 00 30 80 00 00 	movl   $0x0,0x803000
  80004b:	00 00 00 

	cprintf_colored(TEXT_yellow,"==============================================\n");
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	68 80 1f 80 00       	push   $0x801f80
  800056:	6a 0e                	push   $0xe
  800058:	e8 c4 07 00 00       	call   800821 <cprintf_colored>
  80005d:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  800060:	83 ec 08             	sub    $0x8,%esp
  800063:	68 b0 1f 80 00       	push   $0x801fb0
  800068:	6a 0e                	push   $0xe
  80006a:	e8 b2 07 00 00       	call   800821 <cprintf_colored>
  80006f:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"==============================================\n");
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 80 1f 80 00       	push   $0x801f80
  80007a:	6a 0e                	push   $0xe
  80007c:	e8 a0 07 00 00       	call   800821 <cprintf_colored>
  800081:	83 c4 10             	add    $0x10,%esp

	int envID = sys_getenvid();
  800084:	e8 1e 19 00 00       	call   8019a7 <sys_getenvid>
  800089:	89 45 dc             	mov    %eax,-0x24(%ebp)
	char slavesCnt[10];
#if __AUTOGRADE__
	int numOfSlaves = 7 ;
  80008c:	c7 45 c8 07 00 00 00 	movl   $0x7,-0x38(%ebp)
	cprintf("Enter the number of Slave Programs: %d\n", numOfSlaves);
  800093:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	50                   	push   %eax
  80009a:	68 0c 20 80 00       	push   $0x80200c
  80009f:	e8 50 07 00 00       	call   8007f4 <cprintf>
  8000a4:	83 c4 10             	add    $0x10,%esp
	readline("Enter the number of Slave Programs: ", slavesCnt);
	int numOfSlaves = strtol(slavesCnt, NULL, 10);
#endif

	//Save number of slaved to be checked later
	char cmd1[64] = "__NumOfSlaves@Set";
  8000a7:	8d 45 88             	lea    -0x78(%ebp),%eax
  8000aa:	bb 96 21 80 00       	mov    $0x802196,%ebx
  8000af:	ba 12 00 00 00       	mov    $0x12,%edx
  8000b4:	89 c7                	mov    %eax,%edi
  8000b6:	89 de                	mov    %ebx,%esi
  8000b8:	89 d1                	mov    %edx,%ecx
  8000ba:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8000bc:	8d 55 9a             	lea    -0x66(%ebp),%edx
  8000bf:	b9 2e 00 00 00       	mov    $0x2e,%ecx
  8000c4:	b0 00                	mov    $0x0,%al
  8000c6:	89 d7                	mov    %edx,%edi
  8000c8:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd1, (uint32)(&numOfSlaves));
  8000ca:	8d 45 c8             	lea    -0x38(%ebp),%eax
  8000cd:	83 ec 08             	sub    $0x8,%esp
  8000d0:	50                   	push   %eax
  8000d1:	8d 45 88             	lea    -0x78(%ebp),%eax
  8000d4:	50                   	push   %eax
  8000d5:	e8 e6 1a 00 00       	call   801bc0 <sys_utilities>
  8000da:	83 c4 10             	add    $0x10,%esp

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  8000dd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8000e4:	eb 68                	jmp    80014e <_main+0x116>
	{
		id = sys_create_env("tstChanOneSlave", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8000eb:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8000f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f6:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  8000fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800101:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  800107:	51                   	push   %ecx
  800108:	52                   	push   %edx
  800109:	50                   	push   %eax
  80010a:	68 34 20 80 00       	push   $0x802034
  80010f:	e8 3e 18 00 00       	call   801952 <sys_create_env>
  800114:	83 c4 10             	add    $0x10,%esp
  800117:	89 45 d8             	mov    %eax,-0x28(%ebp)
		if (id== E_ENV_CREATION_ERROR)
  80011a:	83 7d d8 ee          	cmpl   $0xffffffee,-0x28(%ebp)
  80011e:	75 1d                	jne    80013d <_main+0x105>
		{
			cprintf_colored(TEXT_TESTERR_CLR, "\n%~insufficient number of processes in the system! only %d slave processes are created\n", i);
  800120:	83 ec 04             	sub    $0x4,%esp
  800123:	ff 75 e4             	pushl  -0x1c(%ebp)
  800126:	68 44 20 80 00       	push   $0x802044
  80012b:	6a 0c                	push   $0xc
  80012d:	e8 ef 06 00 00       	call   800821 <cprintf_colored>
  800132:	83 c4 10             	add    $0x10,%esp
			numOfSlaves = i;
  800135:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800138:	89 45 c8             	mov    %eax,-0x38(%ebp)
			break;
  80013b:	eb 19                	jmp    800156 <_main+0x11e>
		}
		sys_run_env(id);
  80013d:	83 ec 0c             	sub    $0xc,%esp
  800140:	ff 75 d8             	pushl  -0x28(%ebp)
  800143:	e8 28 18 00 00       	call   801970 <sys_run_env>
  800148:	83 c4 10             	add    $0x10,%esp
	char cmd1[64] = "__NumOfSlaves@Set";
	sys_utilities(cmd1, (uint32)(&numOfSlaves));

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  80014b:	ff 45 e4             	incl   -0x1c(%ebp)
  80014e:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800151:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  800154:	7c 90                	jl     8000e6 <_main+0xae>
		}
		sys_run_env(id);
	}

	//Wait until all slaves are blocked
	int numOfBlockedProcesses = 0;
  800156:	c7 45 84 00 00 00 00 	movl   $0x0,-0x7c(%ebp)
	char cmd2[64] = "__GetChanQueueSize__";
  80015d:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  800163:	bb d6 21 80 00       	mov    $0x8021d6,%ebx
  800168:	ba 15 00 00 00       	mov    $0x15,%edx
  80016d:	89 c7                	mov    %eax,%edi
  80016f:	89 de                	mov    %ebx,%esi
  800171:	89 d1                	mov    %edx,%ecx
  800173:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800175:	8d 95 59 ff ff ff    	lea    -0xa7(%ebp),%edx
  80017b:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  800180:	b0 00                	mov    $0x0,%al
  800182:	89 d7                	mov    %edx,%edi
  800184:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
  800186:	8d 45 84             	lea    -0x7c(%ebp),%eax
  800189:	83 ec 08             	sub    $0x8,%esp
  80018c:	50                   	push   %eax
  80018d:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  800193:	50                   	push   %eax
  800194:	e8 27 1a 00 00       	call   801bc0 <sys_utilities>
  800199:	83 c4 10             	add    $0x10,%esp
	int cnt = 0;
  80019c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	while (numOfBlockedProcesses != numOfSlaves)
  8001a3:	eb 76                	jmp    80021b <_main+0x1e3>
	{
		env_sleep(5000);
  8001a5:	83 ec 0c             	sub    $0xc,%esp
  8001a8:	68 88 13 00 00       	push   $0x1388
  8001ad:	e8 9a 1a 00 00       	call   801c4c <env_sleep>
  8001b2:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  8001b5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001b8:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  8001bb:	75 1c                	jne    8001d9 <_main+0x1a1>
		{
			panic("%~test channels failed! unexpected number of blocked slaves. Expected = %d, Current = %d", numOfSlaves, numOfBlockedProcesses);
  8001bd:	8b 55 84             	mov    -0x7c(%ebp),%edx
  8001c0:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001c3:	83 ec 0c             	sub    $0xc,%esp
  8001c6:	52                   	push   %edx
  8001c7:	50                   	push   %eax
  8001c8:	68 9c 20 80 00       	push   $0x80209c
  8001cd:	6a 36                	push   $0x36
  8001cf:	68 f5 20 80 00       	push   $0x8020f5
  8001d4:	e8 4d 03 00 00       	call   800526 <_panic>
		}
		char cmd3[64] = "__GetChanQueueSize__";
  8001d9:	8d 85 c4 fe ff ff    	lea    -0x13c(%ebp),%eax
  8001df:	bb d6 21 80 00       	mov    $0x8021d6,%ebx
  8001e4:	ba 15 00 00 00       	mov    $0x15,%edx
  8001e9:	89 c7                	mov    %eax,%edi
  8001eb:	89 de                	mov    %ebx,%esi
  8001ed:	89 d1                	mov    %edx,%ecx
  8001ef:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001f1:	8d 95 d9 fe ff ff    	lea    -0x127(%ebp),%edx
  8001f7:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  8001fc:	b0 00                	mov    $0x0,%al
  8001fe:	89 d7                	mov    %edx,%edi
  800200:	f3 aa                	rep stos %al,%es:(%edi)
		sys_utilities(cmd3, (uint32)(&numOfBlockedProcesses));
  800202:	8d 45 84             	lea    -0x7c(%ebp),%eax
  800205:	83 ec 08             	sub    $0x8,%esp
  800208:	50                   	push   %eax
  800209:	8d 85 c4 fe ff ff    	lea    -0x13c(%ebp),%eax
  80020f:	50                   	push   %eax
  800210:	e8 ab 19 00 00       	call   801bc0 <sys_utilities>
  800215:	83 c4 10             	add    $0x10,%esp
		cnt++ ;
  800218:	ff 45 e0             	incl   -0x20(%ebp)
	//Wait until all slaves are blocked
	int numOfBlockedProcesses = 0;
	char cmd2[64] = "__GetChanQueueSize__";
	sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
	int cnt = 0;
	while (numOfBlockedProcesses != numOfSlaves)
  80021b:	8b 55 84             	mov    -0x7c(%ebp),%edx
  80021e:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800221:	39 c2                	cmp    %eax,%edx
  800223:	75 80                	jne    8001a5 <_main+0x16d>
		char cmd3[64] = "__GetChanQueueSize__";
		sys_utilities(cmd3, (uint32)(&numOfBlockedProcesses));
		cnt++ ;
	}

	rsttst();
  800225:	e8 3e 18 00 00       	call   801a68 <rsttst>

	//Wakeup one
	char cmd4[64] = "__WakeupOne__";
  80022a:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  800230:	bb 16 22 80 00       	mov    $0x802216,%ebx
  800235:	ba 0e 00 00 00       	mov    $0xe,%edx
  80023a:	89 c7                	mov    %eax,%edi
  80023c:	89 de                	mov    %ebx,%esi
  80023e:	89 d1                	mov    %edx,%ecx
  800240:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800242:	8d 95 12 ff ff ff    	lea    -0xee(%ebp),%edx
  800248:	b9 32 00 00 00       	mov    $0x32,%ecx
  80024d:	b0 00                	mov    $0x0,%al
  80024f:	89 d7                	mov    %edx,%edi
  800251:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd4, 0);
  800253:	83 ec 08             	sub    $0x8,%esp
  800256:	6a 00                	push   $0x0
  800258:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  80025e:	50                   	push   %eax
  80025f:	e8 5c 19 00 00       	call   801bc0 <sys_utilities>
  800264:	83 c4 10             	add    $0x10,%esp

	//Wait until all slave finished
	cnt = 0;
  800267:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	while (gettst() != numOfSlaves)
  80026e:	eb 2f                	jmp    80029f <_main+0x267>
	{
		env_sleep(10000);
  800270:	83 ec 0c             	sub    $0xc,%esp
  800273:	68 10 27 00 00       	push   $0x2710
  800278:	e8 cf 19 00 00       	call   801c4c <env_sleep>
  80027d:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  800280:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800283:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  800286:	75 14                	jne    80029c <_main+0x264>
		{
			panic("%~test channels failed! not all slaves finished");
  800288:	83 ec 04             	sub    $0x4,%esp
  80028b:	68 10 21 80 00       	push   $0x802110
  800290:	6a 4a                	push   $0x4a
  800292:	68 f5 20 80 00       	push   $0x8020f5
  800297:	e8 8a 02 00 00       	call   800526 <_panic>
		}
		cnt++ ;
  80029c:	ff 45 e0             	incl   -0x20(%ebp)
	char cmd4[64] = "__WakeupOne__";
	sys_utilities(cmd4, 0);

	//Wait until all slave finished
	cnt = 0;
	while (gettst() != numOfSlaves)
  80029f:	e8 3e 18 00 00       	call   801ae2 <gettst>
  8002a4:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8002a7:	39 d0                	cmp    %edx,%eax
  8002a9:	75 c5                	jne    800270 <_main+0x238>
			panic("%~test channels failed! not all slaves finished");
		}
		cnt++ ;
	}

	cprintf_colored(TEXT_light_green, "%~\n\nCongratulations!! Test of Channel (sleep & wakeup ONE) completed successfully!!\n\n");
  8002ab:	83 ec 08             	sub    $0x8,%esp
  8002ae:	68 40 21 80 00       	push   $0x802140
  8002b3:	6a 0a                	push   $0xa
  8002b5:	e8 67 05 00 00       	call   800821 <cprintf_colored>
  8002ba:	83 c4 10             	add    $0x10,%esp

	return;
  8002bd:	90                   	nop
}
  8002be:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8002c1:	5b                   	pop    %ebx
  8002c2:	5e                   	pop    %esi
  8002c3:	5f                   	pop    %edi
  8002c4:	5d                   	pop    %ebp
  8002c5:	c3                   	ret    

008002c6 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8002c6:	55                   	push   %ebp
  8002c7:	89 e5                	mov    %esp,%ebp
  8002c9:	57                   	push   %edi
  8002ca:	56                   	push   %esi
  8002cb:	53                   	push   %ebx
  8002cc:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8002d2:	e8 e9 16 00 00       	call   8019c0 <sys_getenvindex>
  8002d7:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8002da:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002dd:	89 d0                	mov    %edx,%eax
  8002df:	c1 e0 03             	shl    $0x3,%eax
  8002e2:	01 d0                	add    %edx,%eax
  8002e4:	c1 e0 06             	shl    $0x6,%eax
  8002e7:	01 d0                	add    %edx,%eax
  8002e9:	c1 e0 03             	shl    $0x3,%eax
  8002ec:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002f1:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002fb:	8a 40 10             	mov    0x10(%eax),%al
  8002fe:	84 c0                	test   %al,%al
  800300:	74 0d                	je     80030f <libmain+0x49>
		binaryname = myEnv->prog_name;
  800302:	a1 20 30 80 00       	mov    0x803020,%eax
  800307:	83 c0 10             	add    $0x10,%eax
  80030a:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80030f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800313:	7e 0a                	jle    80031f <libmain+0x59>
		binaryname = argv[0];
  800315:	8b 45 0c             	mov    0xc(%ebp),%eax
  800318:	8b 00                	mov    (%eax),%eax
  80031a:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80031f:	83 ec 08             	sub    $0x8,%esp
  800322:	ff 75 0c             	pushl  0xc(%ebp)
  800325:	ff 75 08             	pushl  0x8(%ebp)
  800328:	e8 0b fd ff ff       	call   800038 <_main>
  80032d:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800330:	a1 00 30 80 00       	mov    0x803000,%eax
  800335:	85 c0                	test   %eax,%eax
  800337:	0f 84 b7 01 00 00    	je     8004f4 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80033d:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800343:	bb 94 23 80 00       	mov    $0x802394,%ebx
  800348:	ba 0e 00 00 00       	mov    $0xe,%edx
  80034d:	89 c7                	mov    %eax,%edi
  80034f:	89 de                	mov    %ebx,%esi
  800351:	89 d1                	mov    %edx,%ecx
  800353:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800355:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80035b:	b9 56 00 00 00       	mov    $0x56,%ecx
  800360:	b0 00                	mov    $0x0,%al
  800362:	89 d7                	mov    %edx,%edi
  800364:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800366:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80036d:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800370:	83 ec 08             	sub    $0x8,%esp
  800373:	50                   	push   %eax
  800374:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80037a:	50                   	push   %eax
  80037b:	e8 40 18 00 00       	call   801bc0 <sys_utilities>
  800380:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800383:	e8 c0 13 00 00       	call   801748 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800388:	83 ec 0c             	sub    $0xc,%esp
  80038b:	68 70 22 80 00       	push   $0x802270
  800390:	e8 5f 04 00 00       	call   8007f4 <cprintf>
  800395:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800398:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80039b:	85 c0                	test   %eax,%eax
  80039d:	74 58                	je     8003f7 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80039f:	e8 3a 18 00 00       	call   801bde <sys_get_optimal_num_faults>
  8003a4:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8003a7:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003ad:	bb f8 23 80 00       	mov    $0x8023f8,%ebx
  8003b2:	ba 11 00 00 00       	mov    $0x11,%edx
  8003b7:	89 c7                	mov    %eax,%edi
  8003b9:	89 de                	mov    %ebx,%esi
  8003bb:	89 d1                	mov    %edx,%ecx
  8003bd:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8003bf:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8003c2:	b9 53 00 00 00       	mov    $0x53,%ecx
  8003c7:	b0 00                	mov    $0x0,%al
  8003c9:	89 d7                	mov    %edx,%edi
  8003cb:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8003cd:	83 ec 08             	sub    $0x8,%esp
  8003d0:	ff 75 dc             	pushl  -0x24(%ebp)
  8003d3:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003d9:	50                   	push   %eax
  8003da:	e8 e1 17 00 00       	call   801bc0 <sys_utilities>
  8003df:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8003e2:	83 ec 08             	sub    $0x8,%esp
  8003e5:	ff 75 dc             	pushl  -0x24(%ebp)
  8003e8:	68 98 22 80 00       	push   $0x802298
  8003ed:	e8 02 04 00 00       	call   8007f4 <cprintf>
  8003f2:	83 c4 10             	add    $0x10,%esp
  8003f5:	eb 59                	jmp    800450 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003f7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fc:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800402:	a1 20 30 80 00       	mov    0x803020,%eax
  800407:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80040d:	83 ec 04             	sub    $0x4,%esp
  800410:	52                   	push   %edx
  800411:	50                   	push   %eax
  800412:	68 bc 22 80 00       	push   $0x8022bc
  800417:	e8 d8 03 00 00       	call   8007f4 <cprintf>
  80041c:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80041f:	a1 20 30 80 00       	mov    0x803020,%eax
  800424:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80042a:	a1 20 30 80 00       	mov    0x803020,%eax
  80042f:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800435:	a1 20 30 80 00       	mov    0x803020,%eax
  80043a:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800440:	51                   	push   %ecx
  800441:	52                   	push   %edx
  800442:	50                   	push   %eax
  800443:	68 e4 22 80 00       	push   $0x8022e4
  800448:	e8 a7 03 00 00       	call   8007f4 <cprintf>
  80044d:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800450:	a1 20 30 80 00       	mov    0x803020,%eax
  800455:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80045b:	83 ec 08             	sub    $0x8,%esp
  80045e:	50                   	push   %eax
  80045f:	68 3c 23 80 00       	push   $0x80233c
  800464:	e8 8b 03 00 00       	call   8007f4 <cprintf>
  800469:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80046c:	83 ec 0c             	sub    $0xc,%esp
  80046f:	68 50 23 80 00       	push   $0x802350
  800474:	e8 7b 03 00 00       	call   8007f4 <cprintf>
  800479:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80047c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800483:	eb 28                	jmp    8004ad <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800485:	a1 20 30 80 00       	mov    0x803020,%eax
  80048a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80048d:	81 c2 74 04 00 00    	add    $0x474,%edx
  800493:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800496:	83 ec 04             	sub    $0x4,%esp
  800499:	50                   	push   %eax
  80049a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80049d:	68 67 23 80 00       	push   $0x802367
  8004a2:	e8 4d 03 00 00       	call   8007f4 <cprintf>
  8004a7:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8004aa:	ff 45 e4             	incl   -0x1c(%ebp)
  8004ad:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8004b1:	7e d2                	jle    800485 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8004b3:	83 ec 0c             	sub    $0xc,%esp
  8004b6:	68 76 23 80 00       	push   $0x802376
  8004bb:	e8 34 03 00 00       	call   8007f4 <cprintf>
  8004c0:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8004c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c8:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8004ce:	83 ec 08             	sub    $0x8,%esp
  8004d1:	50                   	push   %eax
  8004d2:	68 7a 23 80 00       	push   $0x80237a
  8004d7:	e8 18 03 00 00       	call   8007f4 <cprintf>
  8004dc:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8004df:	83 ec 0c             	sub    $0xc,%esp
  8004e2:	68 70 22 80 00       	push   $0x802270
  8004e7:	e8 08 03 00 00       	call   8007f4 <cprintf>
  8004ec:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004ef:	e8 6e 12 00 00       	call   801762 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004f4:	e8 1f 00 00 00       	call   800518 <exit>
}
  8004f9:	90                   	nop
  8004fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004fd:	5b                   	pop    %ebx
  8004fe:	5e                   	pop    %esi
  8004ff:	5f                   	pop    %edi
  800500:	5d                   	pop    %ebp
  800501:	c3                   	ret    

00800502 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800502:	55                   	push   %ebp
  800503:	89 e5                	mov    %esp,%ebp
  800505:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800508:	83 ec 0c             	sub    $0xc,%esp
  80050b:	6a 00                	push   $0x0
  80050d:	e8 7a 14 00 00       	call   80198c <sys_destroy_env>
  800512:	83 c4 10             	add    $0x10,%esp
}
  800515:	90                   	nop
  800516:	c9                   	leave  
  800517:	c3                   	ret    

00800518 <exit>:

void
exit(void)
{
  800518:	55                   	push   %ebp
  800519:	89 e5                	mov    %esp,%ebp
  80051b:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80051e:	e8 cf 14 00 00       	call   8019f2 <sys_exit_env>
}
  800523:	90                   	nop
  800524:	c9                   	leave  
  800525:	c3                   	ret    

00800526 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800526:	55                   	push   %ebp
  800527:	89 e5                	mov    %esp,%ebp
  800529:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80052c:	8d 45 10             	lea    0x10(%ebp),%eax
  80052f:	83 c0 04             	add    $0x4,%eax
  800532:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800535:	a1 28 31 80 00       	mov    0x803128,%eax
  80053a:	85 c0                	test   %eax,%eax
  80053c:	74 16                	je     800554 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80053e:	a1 28 31 80 00       	mov    0x803128,%eax
  800543:	83 ec 08             	sub    $0x8,%esp
  800546:	50                   	push   %eax
  800547:	68 5c 24 80 00       	push   $0x80245c
  80054c:	e8 a3 02 00 00       	call   8007f4 <cprintf>
  800551:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800554:	a1 04 30 80 00       	mov    0x803004,%eax
  800559:	83 ec 0c             	sub    $0xc,%esp
  80055c:	ff 75 0c             	pushl  0xc(%ebp)
  80055f:	ff 75 08             	pushl  0x8(%ebp)
  800562:	50                   	push   %eax
  800563:	68 64 24 80 00       	push   $0x802464
  800568:	6a 74                	push   $0x74
  80056a:	e8 b2 02 00 00       	call   800821 <cprintf_colored>
  80056f:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800572:	8b 45 10             	mov    0x10(%ebp),%eax
  800575:	83 ec 08             	sub    $0x8,%esp
  800578:	ff 75 f4             	pushl  -0xc(%ebp)
  80057b:	50                   	push   %eax
  80057c:	e8 04 02 00 00       	call   800785 <vcprintf>
  800581:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800584:	83 ec 08             	sub    $0x8,%esp
  800587:	6a 00                	push   $0x0
  800589:	68 8c 24 80 00       	push   $0x80248c
  80058e:	e8 f2 01 00 00       	call   800785 <vcprintf>
  800593:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800596:	e8 7d ff ff ff       	call   800518 <exit>

	// should not return here
	while (1) ;
  80059b:	eb fe                	jmp    80059b <_panic+0x75>

0080059d <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80059d:	55                   	push   %ebp
  80059e:	89 e5                	mov    %esp,%ebp
  8005a0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8005a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a8:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8005ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005b1:	39 c2                	cmp    %eax,%edx
  8005b3:	74 14                	je     8005c9 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8005b5:	83 ec 04             	sub    $0x4,%esp
  8005b8:	68 90 24 80 00       	push   $0x802490
  8005bd:	6a 26                	push   $0x26
  8005bf:	68 dc 24 80 00       	push   $0x8024dc
  8005c4:	e8 5d ff ff ff       	call   800526 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8005c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005d0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005d7:	e9 c5 00 00 00       	jmp    8006a1 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8005dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005df:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e9:	01 d0                	add    %edx,%eax
  8005eb:	8b 00                	mov    (%eax),%eax
  8005ed:	85 c0                	test   %eax,%eax
  8005ef:	75 08                	jne    8005f9 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8005f1:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005f4:	e9 a5 00 00 00       	jmp    80069e <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8005f9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800600:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800607:	eb 69                	jmp    800672 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800609:	a1 20 30 80 00       	mov    0x803020,%eax
  80060e:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800614:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800617:	89 d0                	mov    %edx,%eax
  800619:	01 c0                	add    %eax,%eax
  80061b:	01 d0                	add    %edx,%eax
  80061d:	c1 e0 03             	shl    $0x3,%eax
  800620:	01 c8                	add    %ecx,%eax
  800622:	8a 40 04             	mov    0x4(%eax),%al
  800625:	84 c0                	test   %al,%al
  800627:	75 46                	jne    80066f <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800629:	a1 20 30 80 00       	mov    0x803020,%eax
  80062e:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800634:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800637:	89 d0                	mov    %edx,%eax
  800639:	01 c0                	add    %eax,%eax
  80063b:	01 d0                	add    %edx,%eax
  80063d:	c1 e0 03             	shl    $0x3,%eax
  800640:	01 c8                	add    %ecx,%eax
  800642:	8b 00                	mov    (%eax),%eax
  800644:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800647:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80064a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80064f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800651:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800654:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80065b:	8b 45 08             	mov    0x8(%ebp),%eax
  80065e:	01 c8                	add    %ecx,%eax
  800660:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800662:	39 c2                	cmp    %eax,%edx
  800664:	75 09                	jne    80066f <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800666:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80066d:	eb 15                	jmp    800684 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80066f:	ff 45 e8             	incl   -0x18(%ebp)
  800672:	a1 20 30 80 00       	mov    0x803020,%eax
  800677:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80067d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800680:	39 c2                	cmp    %eax,%edx
  800682:	77 85                	ja     800609 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800684:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800688:	75 14                	jne    80069e <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  80068a:	83 ec 04             	sub    $0x4,%esp
  80068d:	68 e8 24 80 00       	push   $0x8024e8
  800692:	6a 3a                	push   $0x3a
  800694:	68 dc 24 80 00       	push   $0x8024dc
  800699:	e8 88 fe ff ff       	call   800526 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80069e:	ff 45 f0             	incl   -0x10(%ebp)
  8006a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006a4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006a7:	0f 8c 2f ff ff ff    	jl     8005dc <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8006ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8006bb:	eb 26                	jmp    8006e3 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8006bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c2:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8006c8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006cb:	89 d0                	mov    %edx,%eax
  8006cd:	01 c0                	add    %eax,%eax
  8006cf:	01 d0                	add    %edx,%eax
  8006d1:	c1 e0 03             	shl    $0x3,%eax
  8006d4:	01 c8                	add    %ecx,%eax
  8006d6:	8a 40 04             	mov    0x4(%eax),%al
  8006d9:	3c 01                	cmp    $0x1,%al
  8006db:	75 03                	jne    8006e0 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8006dd:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006e0:	ff 45 e0             	incl   -0x20(%ebp)
  8006e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8006e8:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8006ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006f1:	39 c2                	cmp    %eax,%edx
  8006f3:	77 c8                	ja     8006bd <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006f8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006fb:	74 14                	je     800711 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8006fd:	83 ec 04             	sub    $0x4,%esp
  800700:	68 3c 25 80 00       	push   $0x80253c
  800705:	6a 44                	push   $0x44
  800707:	68 dc 24 80 00       	push   $0x8024dc
  80070c:	e8 15 fe ff ff       	call   800526 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800711:	90                   	nop
  800712:	c9                   	leave  
  800713:	c3                   	ret    

00800714 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800714:	55                   	push   %ebp
  800715:	89 e5                	mov    %esp,%ebp
  800717:	53                   	push   %ebx
  800718:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  80071b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80071e:	8b 00                	mov    (%eax),%eax
  800720:	8d 48 01             	lea    0x1(%eax),%ecx
  800723:	8b 55 0c             	mov    0xc(%ebp),%edx
  800726:	89 0a                	mov    %ecx,(%edx)
  800728:	8b 55 08             	mov    0x8(%ebp),%edx
  80072b:	88 d1                	mov    %dl,%cl
  80072d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800730:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800734:	8b 45 0c             	mov    0xc(%ebp),%eax
  800737:	8b 00                	mov    (%eax),%eax
  800739:	3d ff 00 00 00       	cmp    $0xff,%eax
  80073e:	75 30                	jne    800770 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800740:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800746:	a0 40 30 80 00       	mov    0x803040,%al
  80074b:	0f b6 c0             	movzbl %al,%eax
  80074e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800751:	8b 09                	mov    (%ecx),%ecx
  800753:	89 cb                	mov    %ecx,%ebx
  800755:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800758:	83 c1 08             	add    $0x8,%ecx
  80075b:	52                   	push   %edx
  80075c:	50                   	push   %eax
  80075d:	53                   	push   %ebx
  80075e:	51                   	push   %ecx
  80075f:	e8 a0 0f 00 00       	call   801704 <sys_cputs>
  800764:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800767:	8b 45 0c             	mov    0xc(%ebp),%eax
  80076a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800770:	8b 45 0c             	mov    0xc(%ebp),%eax
  800773:	8b 40 04             	mov    0x4(%eax),%eax
  800776:	8d 50 01             	lea    0x1(%eax),%edx
  800779:	8b 45 0c             	mov    0xc(%ebp),%eax
  80077c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80077f:	90                   	nop
  800780:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800783:	c9                   	leave  
  800784:	c3                   	ret    

00800785 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800785:	55                   	push   %ebp
  800786:	89 e5                	mov    %esp,%ebp
  800788:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80078e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800795:	00 00 00 
	b.cnt = 0;
  800798:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80079f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8007a2:	ff 75 0c             	pushl  0xc(%ebp)
  8007a5:	ff 75 08             	pushl  0x8(%ebp)
  8007a8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007ae:	50                   	push   %eax
  8007af:	68 14 07 80 00       	push   $0x800714
  8007b4:	e8 5a 02 00 00       	call   800a13 <vprintfmt>
  8007b9:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8007bc:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8007c2:	a0 40 30 80 00       	mov    0x803040,%al
  8007c7:	0f b6 c0             	movzbl %al,%eax
  8007ca:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8007d0:	52                   	push   %edx
  8007d1:	50                   	push   %eax
  8007d2:	51                   	push   %ecx
  8007d3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007d9:	83 c0 08             	add    $0x8,%eax
  8007dc:	50                   	push   %eax
  8007dd:	e8 22 0f 00 00       	call   801704 <sys_cputs>
  8007e2:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007e5:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8007ec:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007f2:	c9                   	leave  
  8007f3:	c3                   	ret    

008007f4 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8007f4:	55                   	push   %ebp
  8007f5:	89 e5                	mov    %esp,%ebp
  8007f7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007fa:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  800801:	8d 45 0c             	lea    0xc(%ebp),%eax
  800804:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800807:	8b 45 08             	mov    0x8(%ebp),%eax
  80080a:	83 ec 08             	sub    $0x8,%esp
  80080d:	ff 75 f4             	pushl  -0xc(%ebp)
  800810:	50                   	push   %eax
  800811:	e8 6f ff ff ff       	call   800785 <vcprintf>
  800816:	83 c4 10             	add    $0x10,%esp
  800819:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80081c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80081f:	c9                   	leave  
  800820:	c3                   	ret    

00800821 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800821:	55                   	push   %ebp
  800822:	89 e5                	mov    %esp,%ebp
  800824:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800827:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  80082e:	8b 45 08             	mov    0x8(%ebp),%eax
  800831:	c1 e0 08             	shl    $0x8,%eax
  800834:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800839:	8d 45 0c             	lea    0xc(%ebp),%eax
  80083c:	83 c0 04             	add    $0x4,%eax
  80083f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800842:	8b 45 0c             	mov    0xc(%ebp),%eax
  800845:	83 ec 08             	sub    $0x8,%esp
  800848:	ff 75 f4             	pushl  -0xc(%ebp)
  80084b:	50                   	push   %eax
  80084c:	e8 34 ff ff ff       	call   800785 <vcprintf>
  800851:	83 c4 10             	add    $0x10,%esp
  800854:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800857:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  80085e:	07 00 00 

	return cnt;
  800861:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800864:	c9                   	leave  
  800865:	c3                   	ret    

00800866 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800866:	55                   	push   %ebp
  800867:	89 e5                	mov    %esp,%ebp
  800869:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  80086c:	e8 d7 0e 00 00       	call   801748 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800871:	8d 45 0c             	lea    0xc(%ebp),%eax
  800874:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	83 ec 08             	sub    $0x8,%esp
  80087d:	ff 75 f4             	pushl  -0xc(%ebp)
  800880:	50                   	push   %eax
  800881:	e8 ff fe ff ff       	call   800785 <vcprintf>
  800886:	83 c4 10             	add    $0x10,%esp
  800889:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  80088c:	e8 d1 0e 00 00       	call   801762 <sys_unlock_cons>
	return cnt;
  800891:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800894:	c9                   	leave  
  800895:	c3                   	ret    

00800896 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800896:	55                   	push   %ebp
  800897:	89 e5                	mov    %esp,%ebp
  800899:	53                   	push   %ebx
  80089a:	83 ec 14             	sub    $0x14,%esp
  80089d:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8008a9:	8b 45 18             	mov    0x18(%ebp),%eax
  8008ac:	ba 00 00 00 00       	mov    $0x0,%edx
  8008b1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008b4:	77 55                	ja     80090b <printnum+0x75>
  8008b6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008b9:	72 05                	jb     8008c0 <printnum+0x2a>
  8008bb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8008be:	77 4b                	ja     80090b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8008c0:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8008c3:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8008c6:	8b 45 18             	mov    0x18(%ebp),%eax
  8008c9:	ba 00 00 00 00       	mov    $0x0,%edx
  8008ce:	52                   	push   %edx
  8008cf:	50                   	push   %eax
  8008d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8008d3:	ff 75 f0             	pushl  -0x10(%ebp)
  8008d6:	e8 31 14 00 00       	call   801d0c <__udivdi3>
  8008db:	83 c4 10             	add    $0x10,%esp
  8008de:	83 ec 04             	sub    $0x4,%esp
  8008e1:	ff 75 20             	pushl  0x20(%ebp)
  8008e4:	53                   	push   %ebx
  8008e5:	ff 75 18             	pushl  0x18(%ebp)
  8008e8:	52                   	push   %edx
  8008e9:	50                   	push   %eax
  8008ea:	ff 75 0c             	pushl  0xc(%ebp)
  8008ed:	ff 75 08             	pushl  0x8(%ebp)
  8008f0:	e8 a1 ff ff ff       	call   800896 <printnum>
  8008f5:	83 c4 20             	add    $0x20,%esp
  8008f8:	eb 1a                	jmp    800914 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008fa:	83 ec 08             	sub    $0x8,%esp
  8008fd:	ff 75 0c             	pushl  0xc(%ebp)
  800900:	ff 75 20             	pushl  0x20(%ebp)
  800903:	8b 45 08             	mov    0x8(%ebp),%eax
  800906:	ff d0                	call   *%eax
  800908:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80090b:	ff 4d 1c             	decl   0x1c(%ebp)
  80090e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800912:	7f e6                	jg     8008fa <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800914:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800917:	bb 00 00 00 00       	mov    $0x0,%ebx
  80091c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80091f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800922:	53                   	push   %ebx
  800923:	51                   	push   %ecx
  800924:	52                   	push   %edx
  800925:	50                   	push   %eax
  800926:	e8 f1 14 00 00       	call   801e1c <__umoddi3>
  80092b:	83 c4 10             	add    $0x10,%esp
  80092e:	05 b4 27 80 00       	add    $0x8027b4,%eax
  800933:	8a 00                	mov    (%eax),%al
  800935:	0f be c0             	movsbl %al,%eax
  800938:	83 ec 08             	sub    $0x8,%esp
  80093b:	ff 75 0c             	pushl  0xc(%ebp)
  80093e:	50                   	push   %eax
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	ff d0                	call   *%eax
  800944:	83 c4 10             	add    $0x10,%esp
}
  800947:	90                   	nop
  800948:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80094b:	c9                   	leave  
  80094c:	c3                   	ret    

0080094d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80094d:	55                   	push   %ebp
  80094e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800950:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800954:	7e 1c                	jle    800972 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800956:	8b 45 08             	mov    0x8(%ebp),%eax
  800959:	8b 00                	mov    (%eax),%eax
  80095b:	8d 50 08             	lea    0x8(%eax),%edx
  80095e:	8b 45 08             	mov    0x8(%ebp),%eax
  800961:	89 10                	mov    %edx,(%eax)
  800963:	8b 45 08             	mov    0x8(%ebp),%eax
  800966:	8b 00                	mov    (%eax),%eax
  800968:	83 e8 08             	sub    $0x8,%eax
  80096b:	8b 50 04             	mov    0x4(%eax),%edx
  80096e:	8b 00                	mov    (%eax),%eax
  800970:	eb 40                	jmp    8009b2 <getuint+0x65>
	else if (lflag)
  800972:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800976:	74 1e                	je     800996 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800978:	8b 45 08             	mov    0x8(%ebp),%eax
  80097b:	8b 00                	mov    (%eax),%eax
  80097d:	8d 50 04             	lea    0x4(%eax),%edx
  800980:	8b 45 08             	mov    0x8(%ebp),%eax
  800983:	89 10                	mov    %edx,(%eax)
  800985:	8b 45 08             	mov    0x8(%ebp),%eax
  800988:	8b 00                	mov    (%eax),%eax
  80098a:	83 e8 04             	sub    $0x4,%eax
  80098d:	8b 00                	mov    (%eax),%eax
  80098f:	ba 00 00 00 00       	mov    $0x0,%edx
  800994:	eb 1c                	jmp    8009b2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800996:	8b 45 08             	mov    0x8(%ebp),%eax
  800999:	8b 00                	mov    (%eax),%eax
  80099b:	8d 50 04             	lea    0x4(%eax),%edx
  80099e:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a1:	89 10                	mov    %edx,(%eax)
  8009a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a6:	8b 00                	mov    (%eax),%eax
  8009a8:	83 e8 04             	sub    $0x4,%eax
  8009ab:	8b 00                	mov    (%eax),%eax
  8009ad:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8009b2:	5d                   	pop    %ebp
  8009b3:	c3                   	ret    

008009b4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8009b4:	55                   	push   %ebp
  8009b5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009b7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009bb:	7e 1c                	jle    8009d9 <getint+0x25>
		return va_arg(*ap, long long);
  8009bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c0:	8b 00                	mov    (%eax),%eax
  8009c2:	8d 50 08             	lea    0x8(%eax),%edx
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	89 10                	mov    %edx,(%eax)
  8009ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cd:	8b 00                	mov    (%eax),%eax
  8009cf:	83 e8 08             	sub    $0x8,%eax
  8009d2:	8b 50 04             	mov    0x4(%eax),%edx
  8009d5:	8b 00                	mov    (%eax),%eax
  8009d7:	eb 38                	jmp    800a11 <getint+0x5d>
	else if (lflag)
  8009d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009dd:	74 1a                	je     8009f9 <getint+0x45>
		return va_arg(*ap, long);
  8009df:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e2:	8b 00                	mov    (%eax),%eax
  8009e4:	8d 50 04             	lea    0x4(%eax),%edx
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	89 10                	mov    %edx,(%eax)
  8009ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ef:	8b 00                	mov    (%eax),%eax
  8009f1:	83 e8 04             	sub    $0x4,%eax
  8009f4:	8b 00                	mov    (%eax),%eax
  8009f6:	99                   	cltd   
  8009f7:	eb 18                	jmp    800a11 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	8b 00                	mov    (%eax),%eax
  8009fe:	8d 50 04             	lea    0x4(%eax),%edx
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	89 10                	mov    %edx,(%eax)
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	8b 00                	mov    (%eax),%eax
  800a0b:	83 e8 04             	sub    $0x4,%eax
  800a0e:	8b 00                	mov    (%eax),%eax
  800a10:	99                   	cltd   
}
  800a11:	5d                   	pop    %ebp
  800a12:	c3                   	ret    

00800a13 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a13:	55                   	push   %ebp
  800a14:	89 e5                	mov    %esp,%ebp
  800a16:	56                   	push   %esi
  800a17:	53                   	push   %ebx
  800a18:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a1b:	eb 17                	jmp    800a34 <vprintfmt+0x21>
			if (ch == '\0')
  800a1d:	85 db                	test   %ebx,%ebx
  800a1f:	0f 84 c1 03 00 00    	je     800de6 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800a25:	83 ec 08             	sub    $0x8,%esp
  800a28:	ff 75 0c             	pushl  0xc(%ebp)
  800a2b:	53                   	push   %ebx
  800a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2f:	ff d0                	call   *%eax
  800a31:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a34:	8b 45 10             	mov    0x10(%ebp),%eax
  800a37:	8d 50 01             	lea    0x1(%eax),%edx
  800a3a:	89 55 10             	mov    %edx,0x10(%ebp)
  800a3d:	8a 00                	mov    (%eax),%al
  800a3f:	0f b6 d8             	movzbl %al,%ebx
  800a42:	83 fb 25             	cmp    $0x25,%ebx
  800a45:	75 d6                	jne    800a1d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a47:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a4b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a52:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a59:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a60:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a67:	8b 45 10             	mov    0x10(%ebp),%eax
  800a6a:	8d 50 01             	lea    0x1(%eax),%edx
  800a6d:	89 55 10             	mov    %edx,0x10(%ebp)
  800a70:	8a 00                	mov    (%eax),%al
  800a72:	0f b6 d8             	movzbl %al,%ebx
  800a75:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a78:	83 f8 5b             	cmp    $0x5b,%eax
  800a7b:	0f 87 3d 03 00 00    	ja     800dbe <vprintfmt+0x3ab>
  800a81:	8b 04 85 d8 27 80 00 	mov    0x8027d8(,%eax,4),%eax
  800a88:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a8a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a8e:	eb d7                	jmp    800a67 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a90:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a94:	eb d1                	jmp    800a67 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a96:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a9d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800aa0:	89 d0                	mov    %edx,%eax
  800aa2:	c1 e0 02             	shl    $0x2,%eax
  800aa5:	01 d0                	add    %edx,%eax
  800aa7:	01 c0                	add    %eax,%eax
  800aa9:	01 d8                	add    %ebx,%eax
  800aab:	83 e8 30             	sub    $0x30,%eax
  800aae:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800ab1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab4:	8a 00                	mov    (%eax),%al
  800ab6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ab9:	83 fb 2f             	cmp    $0x2f,%ebx
  800abc:	7e 3e                	jle    800afc <vprintfmt+0xe9>
  800abe:	83 fb 39             	cmp    $0x39,%ebx
  800ac1:	7f 39                	jg     800afc <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ac3:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ac6:	eb d5                	jmp    800a9d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ac8:	8b 45 14             	mov    0x14(%ebp),%eax
  800acb:	83 c0 04             	add    $0x4,%eax
  800ace:	89 45 14             	mov    %eax,0x14(%ebp)
  800ad1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad4:	83 e8 04             	sub    $0x4,%eax
  800ad7:	8b 00                	mov    (%eax),%eax
  800ad9:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800adc:	eb 1f                	jmp    800afd <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ade:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ae2:	79 83                	jns    800a67 <vprintfmt+0x54>
				width = 0;
  800ae4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800aeb:	e9 77 ff ff ff       	jmp    800a67 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800af0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800af7:	e9 6b ff ff ff       	jmp    800a67 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800afc:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800afd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b01:	0f 89 60 ff ff ff    	jns    800a67 <vprintfmt+0x54>
				width = precision, precision = -1;
  800b07:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b0d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b14:	e9 4e ff ff ff       	jmp    800a67 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b19:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b1c:	e9 46 ff ff ff       	jmp    800a67 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b21:	8b 45 14             	mov    0x14(%ebp),%eax
  800b24:	83 c0 04             	add    $0x4,%eax
  800b27:	89 45 14             	mov    %eax,0x14(%ebp)
  800b2a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b2d:	83 e8 04             	sub    $0x4,%eax
  800b30:	8b 00                	mov    (%eax),%eax
  800b32:	83 ec 08             	sub    $0x8,%esp
  800b35:	ff 75 0c             	pushl  0xc(%ebp)
  800b38:	50                   	push   %eax
  800b39:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3c:	ff d0                	call   *%eax
  800b3e:	83 c4 10             	add    $0x10,%esp
			break;
  800b41:	e9 9b 02 00 00       	jmp    800de1 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b46:	8b 45 14             	mov    0x14(%ebp),%eax
  800b49:	83 c0 04             	add    $0x4,%eax
  800b4c:	89 45 14             	mov    %eax,0x14(%ebp)
  800b4f:	8b 45 14             	mov    0x14(%ebp),%eax
  800b52:	83 e8 04             	sub    $0x4,%eax
  800b55:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b57:	85 db                	test   %ebx,%ebx
  800b59:	79 02                	jns    800b5d <vprintfmt+0x14a>
				err = -err;
  800b5b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b5d:	83 fb 64             	cmp    $0x64,%ebx
  800b60:	7f 0b                	jg     800b6d <vprintfmt+0x15a>
  800b62:	8b 34 9d 20 26 80 00 	mov    0x802620(,%ebx,4),%esi
  800b69:	85 f6                	test   %esi,%esi
  800b6b:	75 19                	jne    800b86 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b6d:	53                   	push   %ebx
  800b6e:	68 c5 27 80 00       	push   $0x8027c5
  800b73:	ff 75 0c             	pushl  0xc(%ebp)
  800b76:	ff 75 08             	pushl  0x8(%ebp)
  800b79:	e8 70 02 00 00       	call   800dee <printfmt>
  800b7e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b81:	e9 5b 02 00 00       	jmp    800de1 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b86:	56                   	push   %esi
  800b87:	68 ce 27 80 00       	push   $0x8027ce
  800b8c:	ff 75 0c             	pushl  0xc(%ebp)
  800b8f:	ff 75 08             	pushl  0x8(%ebp)
  800b92:	e8 57 02 00 00       	call   800dee <printfmt>
  800b97:	83 c4 10             	add    $0x10,%esp
			break;
  800b9a:	e9 42 02 00 00       	jmp    800de1 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800ba2:	83 c0 04             	add    $0x4,%eax
  800ba5:	89 45 14             	mov    %eax,0x14(%ebp)
  800ba8:	8b 45 14             	mov    0x14(%ebp),%eax
  800bab:	83 e8 04             	sub    $0x4,%eax
  800bae:	8b 30                	mov    (%eax),%esi
  800bb0:	85 f6                	test   %esi,%esi
  800bb2:	75 05                	jne    800bb9 <vprintfmt+0x1a6>
				p = "(null)";
  800bb4:	be d1 27 80 00       	mov    $0x8027d1,%esi
			if (width > 0 && padc != '-')
  800bb9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bbd:	7e 6d                	jle    800c2c <vprintfmt+0x219>
  800bbf:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800bc3:	74 67                	je     800c2c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800bc5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bc8:	83 ec 08             	sub    $0x8,%esp
  800bcb:	50                   	push   %eax
  800bcc:	56                   	push   %esi
  800bcd:	e8 1e 03 00 00       	call   800ef0 <strnlen>
  800bd2:	83 c4 10             	add    $0x10,%esp
  800bd5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800bd8:	eb 16                	jmp    800bf0 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bda:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bde:	83 ec 08             	sub    $0x8,%esp
  800be1:	ff 75 0c             	pushl  0xc(%ebp)
  800be4:	50                   	push   %eax
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
  800be8:	ff d0                	call   *%eax
  800bea:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800bed:	ff 4d e4             	decl   -0x1c(%ebp)
  800bf0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bf4:	7f e4                	jg     800bda <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bf6:	eb 34                	jmp    800c2c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bf8:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bfc:	74 1c                	je     800c1a <vprintfmt+0x207>
  800bfe:	83 fb 1f             	cmp    $0x1f,%ebx
  800c01:	7e 05                	jle    800c08 <vprintfmt+0x1f5>
  800c03:	83 fb 7e             	cmp    $0x7e,%ebx
  800c06:	7e 12                	jle    800c1a <vprintfmt+0x207>
					putch('?', putdat);
  800c08:	83 ec 08             	sub    $0x8,%esp
  800c0b:	ff 75 0c             	pushl  0xc(%ebp)
  800c0e:	6a 3f                	push   $0x3f
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	ff d0                	call   *%eax
  800c15:	83 c4 10             	add    $0x10,%esp
  800c18:	eb 0f                	jmp    800c29 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c1a:	83 ec 08             	sub    $0x8,%esp
  800c1d:	ff 75 0c             	pushl  0xc(%ebp)
  800c20:	53                   	push   %ebx
  800c21:	8b 45 08             	mov    0x8(%ebp),%eax
  800c24:	ff d0                	call   *%eax
  800c26:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c29:	ff 4d e4             	decl   -0x1c(%ebp)
  800c2c:	89 f0                	mov    %esi,%eax
  800c2e:	8d 70 01             	lea    0x1(%eax),%esi
  800c31:	8a 00                	mov    (%eax),%al
  800c33:	0f be d8             	movsbl %al,%ebx
  800c36:	85 db                	test   %ebx,%ebx
  800c38:	74 24                	je     800c5e <vprintfmt+0x24b>
  800c3a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c3e:	78 b8                	js     800bf8 <vprintfmt+0x1e5>
  800c40:	ff 4d e0             	decl   -0x20(%ebp)
  800c43:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c47:	79 af                	jns    800bf8 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c49:	eb 13                	jmp    800c5e <vprintfmt+0x24b>
				putch(' ', putdat);
  800c4b:	83 ec 08             	sub    $0x8,%esp
  800c4e:	ff 75 0c             	pushl  0xc(%ebp)
  800c51:	6a 20                	push   $0x20
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	ff d0                	call   *%eax
  800c58:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c5b:	ff 4d e4             	decl   -0x1c(%ebp)
  800c5e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c62:	7f e7                	jg     800c4b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c64:	e9 78 01 00 00       	jmp    800de1 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c69:	83 ec 08             	sub    $0x8,%esp
  800c6c:	ff 75 e8             	pushl  -0x18(%ebp)
  800c6f:	8d 45 14             	lea    0x14(%ebp),%eax
  800c72:	50                   	push   %eax
  800c73:	e8 3c fd ff ff       	call   8009b4 <getint>
  800c78:	83 c4 10             	add    $0x10,%esp
  800c7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c7e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c84:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c87:	85 d2                	test   %edx,%edx
  800c89:	79 23                	jns    800cae <vprintfmt+0x29b>
				putch('-', putdat);
  800c8b:	83 ec 08             	sub    $0x8,%esp
  800c8e:	ff 75 0c             	pushl  0xc(%ebp)
  800c91:	6a 2d                	push   $0x2d
  800c93:	8b 45 08             	mov    0x8(%ebp),%eax
  800c96:	ff d0                	call   *%eax
  800c98:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ca1:	f7 d8                	neg    %eax
  800ca3:	83 d2 00             	adc    $0x0,%edx
  800ca6:	f7 da                	neg    %edx
  800ca8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800cae:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cb5:	e9 bc 00 00 00       	jmp    800d76 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800cba:	83 ec 08             	sub    $0x8,%esp
  800cbd:	ff 75 e8             	pushl  -0x18(%ebp)
  800cc0:	8d 45 14             	lea    0x14(%ebp),%eax
  800cc3:	50                   	push   %eax
  800cc4:	e8 84 fc ff ff       	call   80094d <getuint>
  800cc9:	83 c4 10             	add    $0x10,%esp
  800ccc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ccf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800cd2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cd9:	e9 98 00 00 00       	jmp    800d76 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cde:	83 ec 08             	sub    $0x8,%esp
  800ce1:	ff 75 0c             	pushl  0xc(%ebp)
  800ce4:	6a 58                	push   $0x58
  800ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce9:	ff d0                	call   *%eax
  800ceb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cee:	83 ec 08             	sub    $0x8,%esp
  800cf1:	ff 75 0c             	pushl  0xc(%ebp)
  800cf4:	6a 58                	push   $0x58
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	ff d0                	call   *%eax
  800cfb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cfe:	83 ec 08             	sub    $0x8,%esp
  800d01:	ff 75 0c             	pushl  0xc(%ebp)
  800d04:	6a 58                	push   $0x58
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	ff d0                	call   *%eax
  800d0b:	83 c4 10             	add    $0x10,%esp
			break;
  800d0e:	e9 ce 00 00 00       	jmp    800de1 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800d13:	83 ec 08             	sub    $0x8,%esp
  800d16:	ff 75 0c             	pushl  0xc(%ebp)
  800d19:	6a 30                	push   $0x30
  800d1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1e:	ff d0                	call   *%eax
  800d20:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d23:	83 ec 08             	sub    $0x8,%esp
  800d26:	ff 75 0c             	pushl  0xc(%ebp)
  800d29:	6a 78                	push   $0x78
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	ff d0                	call   *%eax
  800d30:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d33:	8b 45 14             	mov    0x14(%ebp),%eax
  800d36:	83 c0 04             	add    $0x4,%eax
  800d39:	89 45 14             	mov    %eax,0x14(%ebp)
  800d3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3f:	83 e8 04             	sub    $0x4,%eax
  800d42:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d47:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d4e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d55:	eb 1f                	jmp    800d76 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d57:	83 ec 08             	sub    $0x8,%esp
  800d5a:	ff 75 e8             	pushl  -0x18(%ebp)
  800d5d:	8d 45 14             	lea    0x14(%ebp),%eax
  800d60:	50                   	push   %eax
  800d61:	e8 e7 fb ff ff       	call   80094d <getuint>
  800d66:	83 c4 10             	add    $0x10,%esp
  800d69:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d6c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d6f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d76:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d7a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d7d:	83 ec 04             	sub    $0x4,%esp
  800d80:	52                   	push   %edx
  800d81:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d84:	50                   	push   %eax
  800d85:	ff 75 f4             	pushl  -0xc(%ebp)
  800d88:	ff 75 f0             	pushl  -0x10(%ebp)
  800d8b:	ff 75 0c             	pushl  0xc(%ebp)
  800d8e:	ff 75 08             	pushl  0x8(%ebp)
  800d91:	e8 00 fb ff ff       	call   800896 <printnum>
  800d96:	83 c4 20             	add    $0x20,%esp
			break;
  800d99:	eb 46                	jmp    800de1 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d9b:	83 ec 08             	sub    $0x8,%esp
  800d9e:	ff 75 0c             	pushl  0xc(%ebp)
  800da1:	53                   	push   %ebx
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	ff d0                	call   *%eax
  800da7:	83 c4 10             	add    $0x10,%esp
			break;
  800daa:	eb 35                	jmp    800de1 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800dac:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800db3:	eb 2c                	jmp    800de1 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800db5:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800dbc:	eb 23                	jmp    800de1 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800dbe:	83 ec 08             	sub    $0x8,%esp
  800dc1:	ff 75 0c             	pushl  0xc(%ebp)
  800dc4:	6a 25                	push   $0x25
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	ff d0                	call   *%eax
  800dcb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800dce:	ff 4d 10             	decl   0x10(%ebp)
  800dd1:	eb 03                	jmp    800dd6 <vprintfmt+0x3c3>
  800dd3:	ff 4d 10             	decl   0x10(%ebp)
  800dd6:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd9:	48                   	dec    %eax
  800dda:	8a 00                	mov    (%eax),%al
  800ddc:	3c 25                	cmp    $0x25,%al
  800dde:	75 f3                	jne    800dd3 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800de0:	90                   	nop
		}
	}
  800de1:	e9 35 fc ff ff       	jmp    800a1b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800de6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800de7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800dea:	5b                   	pop    %ebx
  800deb:	5e                   	pop    %esi
  800dec:	5d                   	pop    %ebp
  800ded:	c3                   	ret    

00800dee <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800dee:	55                   	push   %ebp
  800def:	89 e5                	mov    %esp,%ebp
  800df1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800df4:	8d 45 10             	lea    0x10(%ebp),%eax
  800df7:	83 c0 04             	add    $0x4,%eax
  800dfa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800dfd:	8b 45 10             	mov    0x10(%ebp),%eax
  800e00:	ff 75 f4             	pushl  -0xc(%ebp)
  800e03:	50                   	push   %eax
  800e04:	ff 75 0c             	pushl  0xc(%ebp)
  800e07:	ff 75 08             	pushl  0x8(%ebp)
  800e0a:	e8 04 fc ff ff       	call   800a13 <vprintfmt>
  800e0f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800e12:	90                   	nop
  800e13:	c9                   	leave  
  800e14:	c3                   	ret    

00800e15 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800e15:	55                   	push   %ebp
  800e16:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800e18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1b:	8b 40 08             	mov    0x8(%eax),%eax
  800e1e:	8d 50 01             	lea    0x1(%eax),%edx
  800e21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e24:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2a:	8b 10                	mov    (%eax),%edx
  800e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2f:	8b 40 04             	mov    0x4(%eax),%eax
  800e32:	39 c2                	cmp    %eax,%edx
  800e34:	73 12                	jae    800e48 <sprintputch+0x33>
		*b->buf++ = ch;
  800e36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e39:	8b 00                	mov    (%eax),%eax
  800e3b:	8d 48 01             	lea    0x1(%eax),%ecx
  800e3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e41:	89 0a                	mov    %ecx,(%edx)
  800e43:	8b 55 08             	mov    0x8(%ebp),%edx
  800e46:	88 10                	mov    %dl,(%eax)
}
  800e48:	90                   	nop
  800e49:	5d                   	pop    %ebp
  800e4a:	c3                   	ret    

00800e4b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e4b:	55                   	push   %ebp
  800e4c:	89 e5                	mov    %esp,%ebp
  800e4e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
  800e54:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	01 d0                	add    %edx,%eax
  800e62:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e65:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e6c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e70:	74 06                	je     800e78 <vsnprintf+0x2d>
  800e72:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e76:	7f 07                	jg     800e7f <vsnprintf+0x34>
		return -E_INVAL;
  800e78:	b8 03 00 00 00       	mov    $0x3,%eax
  800e7d:	eb 20                	jmp    800e9f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e7f:	ff 75 14             	pushl  0x14(%ebp)
  800e82:	ff 75 10             	pushl  0x10(%ebp)
  800e85:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e88:	50                   	push   %eax
  800e89:	68 15 0e 80 00       	push   $0x800e15
  800e8e:	e8 80 fb ff ff       	call   800a13 <vprintfmt>
  800e93:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e96:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e99:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e9f:	c9                   	leave  
  800ea0:	c3                   	ret    

00800ea1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ea1:	55                   	push   %ebp
  800ea2:	89 e5                	mov    %esp,%ebp
  800ea4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ea7:	8d 45 10             	lea    0x10(%ebp),%eax
  800eaa:	83 c0 04             	add    $0x4,%eax
  800ead:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800eb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb3:	ff 75 f4             	pushl  -0xc(%ebp)
  800eb6:	50                   	push   %eax
  800eb7:	ff 75 0c             	pushl  0xc(%ebp)
  800eba:	ff 75 08             	pushl  0x8(%ebp)
  800ebd:	e8 89 ff ff ff       	call   800e4b <vsnprintf>
  800ec2:	83 c4 10             	add    $0x10,%esp
  800ec5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ec8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ecb:	c9                   	leave  
  800ecc:	c3                   	ret    

00800ecd <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ecd:	55                   	push   %ebp
  800ece:	89 e5                	mov    %esp,%ebp
  800ed0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ed3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eda:	eb 06                	jmp    800ee2 <strlen+0x15>
		n++;
  800edc:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800edf:	ff 45 08             	incl   0x8(%ebp)
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	8a 00                	mov    (%eax),%al
  800ee7:	84 c0                	test   %al,%al
  800ee9:	75 f1                	jne    800edc <strlen+0xf>
		n++;
	return n;
  800eeb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eee:	c9                   	leave  
  800eef:	c3                   	ret    

00800ef0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ef0:	55                   	push   %ebp
  800ef1:	89 e5                	mov    %esp,%ebp
  800ef3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ef6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800efd:	eb 09                	jmp    800f08 <strnlen+0x18>
		n++;
  800eff:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f02:	ff 45 08             	incl   0x8(%ebp)
  800f05:	ff 4d 0c             	decl   0xc(%ebp)
  800f08:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f0c:	74 09                	je     800f17 <strnlen+0x27>
  800f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f11:	8a 00                	mov    (%eax),%al
  800f13:	84 c0                	test   %al,%al
  800f15:	75 e8                	jne    800eff <strnlen+0xf>
		n++;
	return n;
  800f17:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f1a:	c9                   	leave  
  800f1b:	c3                   	ret    

00800f1c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f1c:	55                   	push   %ebp
  800f1d:	89 e5                	mov    %esp,%ebp
  800f1f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f28:	90                   	nop
  800f29:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2c:	8d 50 01             	lea    0x1(%eax),%edx
  800f2f:	89 55 08             	mov    %edx,0x8(%ebp)
  800f32:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f35:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f38:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f3b:	8a 12                	mov    (%edx),%dl
  800f3d:	88 10                	mov    %dl,(%eax)
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	84 c0                	test   %al,%al
  800f43:	75 e4                	jne    800f29 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f45:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f48:	c9                   	leave  
  800f49:	c3                   	ret    

00800f4a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f4a:	55                   	push   %ebp
  800f4b:	89 e5                	mov    %esp,%ebp
  800f4d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f56:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f5d:	eb 1f                	jmp    800f7e <strncpy+0x34>
		*dst++ = *src;
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	8d 50 01             	lea    0x1(%eax),%edx
  800f65:	89 55 08             	mov    %edx,0x8(%ebp)
  800f68:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f6b:	8a 12                	mov    (%edx),%dl
  800f6d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	84 c0                	test   %al,%al
  800f76:	74 03                	je     800f7b <strncpy+0x31>
			src++;
  800f78:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f7b:	ff 45 fc             	incl   -0x4(%ebp)
  800f7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f81:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f84:	72 d9                	jb     800f5f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f86:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f89:	c9                   	leave  
  800f8a:	c3                   	ret    

00800f8b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f8b:	55                   	push   %ebp
  800f8c:	89 e5                	mov    %esp,%ebp
  800f8e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f91:	8b 45 08             	mov    0x8(%ebp),%eax
  800f94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f97:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f9b:	74 30                	je     800fcd <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f9d:	eb 16                	jmp    800fb5 <strlcpy+0x2a>
			*dst++ = *src++;
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	8d 50 01             	lea    0x1(%eax),%edx
  800fa5:	89 55 08             	mov    %edx,0x8(%ebp)
  800fa8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fab:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fae:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800fb1:	8a 12                	mov    (%edx),%dl
  800fb3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800fb5:	ff 4d 10             	decl   0x10(%ebp)
  800fb8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fbc:	74 09                	je     800fc7 <strlcpy+0x3c>
  800fbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	84 c0                	test   %al,%al
  800fc5:	75 d8                	jne    800f9f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800fcd:	8b 55 08             	mov    0x8(%ebp),%edx
  800fd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fd3:	29 c2                	sub    %eax,%edx
  800fd5:	89 d0                	mov    %edx,%eax
}
  800fd7:	c9                   	leave  
  800fd8:	c3                   	ret    

00800fd9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fd9:	55                   	push   %ebp
  800fda:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fdc:	eb 06                	jmp    800fe4 <strcmp+0xb>
		p++, q++;
  800fde:	ff 45 08             	incl   0x8(%ebp)
  800fe1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe7:	8a 00                	mov    (%eax),%al
  800fe9:	84 c0                	test   %al,%al
  800feb:	74 0e                	je     800ffb <strcmp+0x22>
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	8a 10                	mov    (%eax),%dl
  800ff2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff5:	8a 00                	mov    (%eax),%al
  800ff7:	38 c2                	cmp    %al,%dl
  800ff9:	74 e3                	je     800fde <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	8a 00                	mov    (%eax),%al
  801000:	0f b6 d0             	movzbl %al,%edx
  801003:	8b 45 0c             	mov    0xc(%ebp),%eax
  801006:	8a 00                	mov    (%eax),%al
  801008:	0f b6 c0             	movzbl %al,%eax
  80100b:	29 c2                	sub    %eax,%edx
  80100d:	89 d0                	mov    %edx,%eax
}
  80100f:	5d                   	pop    %ebp
  801010:	c3                   	ret    

00801011 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801011:	55                   	push   %ebp
  801012:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801014:	eb 09                	jmp    80101f <strncmp+0xe>
		n--, p++, q++;
  801016:	ff 4d 10             	decl   0x10(%ebp)
  801019:	ff 45 08             	incl   0x8(%ebp)
  80101c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80101f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801023:	74 17                	je     80103c <strncmp+0x2b>
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	8a 00                	mov    (%eax),%al
  80102a:	84 c0                	test   %al,%al
  80102c:	74 0e                	je     80103c <strncmp+0x2b>
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	8a 10                	mov    (%eax),%dl
  801033:	8b 45 0c             	mov    0xc(%ebp),%eax
  801036:	8a 00                	mov    (%eax),%al
  801038:	38 c2                	cmp    %al,%dl
  80103a:	74 da                	je     801016 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80103c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801040:	75 07                	jne    801049 <strncmp+0x38>
		return 0;
  801042:	b8 00 00 00 00       	mov    $0x0,%eax
  801047:	eb 14                	jmp    80105d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	8a 00                	mov    (%eax),%al
  80104e:	0f b6 d0             	movzbl %al,%edx
  801051:	8b 45 0c             	mov    0xc(%ebp),%eax
  801054:	8a 00                	mov    (%eax),%al
  801056:	0f b6 c0             	movzbl %al,%eax
  801059:	29 c2                	sub    %eax,%edx
  80105b:	89 d0                	mov    %edx,%eax
}
  80105d:	5d                   	pop    %ebp
  80105e:	c3                   	ret    

0080105f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80105f:	55                   	push   %ebp
  801060:	89 e5                	mov    %esp,%ebp
  801062:	83 ec 04             	sub    $0x4,%esp
  801065:	8b 45 0c             	mov    0xc(%ebp),%eax
  801068:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80106b:	eb 12                	jmp    80107f <strchr+0x20>
		if (*s == c)
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	8a 00                	mov    (%eax),%al
  801072:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801075:	75 05                	jne    80107c <strchr+0x1d>
			return (char *) s;
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	eb 11                	jmp    80108d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80107c:	ff 45 08             	incl   0x8(%ebp)
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8a 00                	mov    (%eax),%al
  801084:	84 c0                	test   %al,%al
  801086:	75 e5                	jne    80106d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801088:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80108d:	c9                   	leave  
  80108e:	c3                   	ret    

0080108f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80108f:	55                   	push   %ebp
  801090:	89 e5                	mov    %esp,%ebp
  801092:	83 ec 04             	sub    $0x4,%esp
  801095:	8b 45 0c             	mov    0xc(%ebp),%eax
  801098:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80109b:	eb 0d                	jmp    8010aa <strfind+0x1b>
		if (*s == c)
  80109d:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a0:	8a 00                	mov    (%eax),%al
  8010a2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8010a5:	74 0e                	je     8010b5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8010a7:	ff 45 08             	incl   0x8(%ebp)
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	8a 00                	mov    (%eax),%al
  8010af:	84 c0                	test   %al,%al
  8010b1:	75 ea                	jne    80109d <strfind+0xe>
  8010b3:	eb 01                	jmp    8010b6 <strfind+0x27>
		if (*s == c)
			break;
  8010b5:	90                   	nop
	return (char *) s;
  8010b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010b9:	c9                   	leave  
  8010ba:	c3                   	ret    

008010bb <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  8010bb:	55                   	push   %ebp
  8010bc:	89 e5                	mov    %esp,%ebp
  8010be:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  8010c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  8010c7:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010cb:	76 63                	jbe    801130 <memset+0x75>
		uint64 data_block = c;
  8010cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d0:	99                   	cltd   
  8010d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010d4:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  8010d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010dd:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  8010e1:	c1 e0 08             	shl    $0x8,%eax
  8010e4:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010e7:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  8010ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010f0:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  8010f4:	c1 e0 10             	shl    $0x10,%eax
  8010f7:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010fa:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  8010fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801100:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801103:	89 c2                	mov    %eax,%edx
  801105:	b8 00 00 00 00       	mov    $0x0,%eax
  80110a:	09 45 f0             	or     %eax,-0x10(%ebp)
  80110d:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801110:	eb 18                	jmp    80112a <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801112:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801115:	8d 41 08             	lea    0x8(%ecx),%eax
  801118:	89 45 fc             	mov    %eax,-0x4(%ebp)
  80111b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80111e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801121:	89 01                	mov    %eax,(%ecx)
  801123:	89 51 04             	mov    %edx,0x4(%ecx)
  801126:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  80112a:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80112e:	77 e2                	ja     801112 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801130:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801134:	74 23                	je     801159 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  801136:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801139:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  80113c:	eb 0e                	jmp    80114c <memset+0x91>
			*p8++ = (uint8)c;
  80113e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801141:	8d 50 01             	lea    0x1(%eax),%edx
  801144:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801147:	8b 55 0c             	mov    0xc(%ebp),%edx
  80114a:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  80114c:	8b 45 10             	mov    0x10(%ebp),%eax
  80114f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801152:	89 55 10             	mov    %edx,0x10(%ebp)
  801155:	85 c0                	test   %eax,%eax
  801157:	75 e5                	jne    80113e <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801159:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80115c:	c9                   	leave  
  80115d:	c3                   	ret    

0080115e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80115e:	55                   	push   %ebp
  80115f:	89 e5                	mov    %esp,%ebp
  801161:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801164:	8b 45 0c             	mov    0xc(%ebp),%eax
  801167:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801170:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801174:	76 24                	jbe    80119a <memcpy+0x3c>
		while(n >= 8){
  801176:	eb 1c                	jmp    801194 <memcpy+0x36>
			*d64 = *s64;
  801178:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80117b:	8b 50 04             	mov    0x4(%eax),%edx
  80117e:	8b 00                	mov    (%eax),%eax
  801180:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801183:	89 01                	mov    %eax,(%ecx)
  801185:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  801188:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  80118c:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801190:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801194:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801198:	77 de                	ja     801178 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  80119a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80119e:	74 31                	je     8011d1 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8011a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8011a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8011ac:	eb 16                	jmp    8011c4 <memcpy+0x66>
			*d8++ = *s8++;
  8011ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011b1:	8d 50 01             	lea    0x1(%eax),%edx
  8011b4:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8011b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011ba:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011bd:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8011c0:	8a 12                	mov    (%edx),%dl
  8011c2:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8011c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011ca:	89 55 10             	mov    %edx,0x10(%ebp)
  8011cd:	85 c0                	test   %eax,%eax
  8011cf:	75 dd                	jne    8011ae <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8011d1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011d4:	c9                   	leave  
  8011d5:	c3                   	ret    

008011d6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8011d6:	55                   	push   %ebp
  8011d7:	89 e5                	mov    %esp,%ebp
  8011d9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8011e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011eb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011ee:	73 50                	jae    801240 <memmove+0x6a>
  8011f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f6:	01 d0                	add    %edx,%eax
  8011f8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011fb:	76 43                	jbe    801240 <memmove+0x6a>
		s += n;
  8011fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801200:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801203:	8b 45 10             	mov    0x10(%ebp),%eax
  801206:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801209:	eb 10                	jmp    80121b <memmove+0x45>
			*--d = *--s;
  80120b:	ff 4d f8             	decl   -0x8(%ebp)
  80120e:	ff 4d fc             	decl   -0x4(%ebp)
  801211:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801214:	8a 10                	mov    (%eax),%dl
  801216:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801219:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80121b:	8b 45 10             	mov    0x10(%ebp),%eax
  80121e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801221:	89 55 10             	mov    %edx,0x10(%ebp)
  801224:	85 c0                	test   %eax,%eax
  801226:	75 e3                	jne    80120b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801228:	eb 23                	jmp    80124d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80122a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80122d:	8d 50 01             	lea    0x1(%eax),%edx
  801230:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801233:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801236:	8d 4a 01             	lea    0x1(%edx),%ecx
  801239:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80123c:	8a 12                	mov    (%edx),%dl
  80123e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801240:	8b 45 10             	mov    0x10(%ebp),%eax
  801243:	8d 50 ff             	lea    -0x1(%eax),%edx
  801246:	89 55 10             	mov    %edx,0x10(%ebp)
  801249:	85 c0                	test   %eax,%eax
  80124b:	75 dd                	jne    80122a <memmove+0x54>
			*d++ = *s++;

	return dst;
  80124d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801250:	c9                   	leave  
  801251:	c3                   	ret    

00801252 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801252:	55                   	push   %ebp
  801253:	89 e5                	mov    %esp,%ebp
  801255:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801258:	8b 45 08             	mov    0x8(%ebp),%eax
  80125b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80125e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801261:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801264:	eb 2a                	jmp    801290 <memcmp+0x3e>
		if (*s1 != *s2)
  801266:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801269:	8a 10                	mov    (%eax),%dl
  80126b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80126e:	8a 00                	mov    (%eax),%al
  801270:	38 c2                	cmp    %al,%dl
  801272:	74 16                	je     80128a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801274:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801277:	8a 00                	mov    (%eax),%al
  801279:	0f b6 d0             	movzbl %al,%edx
  80127c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80127f:	8a 00                	mov    (%eax),%al
  801281:	0f b6 c0             	movzbl %al,%eax
  801284:	29 c2                	sub    %eax,%edx
  801286:	89 d0                	mov    %edx,%eax
  801288:	eb 18                	jmp    8012a2 <memcmp+0x50>
		s1++, s2++;
  80128a:	ff 45 fc             	incl   -0x4(%ebp)
  80128d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801290:	8b 45 10             	mov    0x10(%ebp),%eax
  801293:	8d 50 ff             	lea    -0x1(%eax),%edx
  801296:	89 55 10             	mov    %edx,0x10(%ebp)
  801299:	85 c0                	test   %eax,%eax
  80129b:	75 c9                	jne    801266 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80129d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012a2:	c9                   	leave  
  8012a3:	c3                   	ret    

008012a4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8012a4:	55                   	push   %ebp
  8012a5:	89 e5                	mov    %esp,%ebp
  8012a7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8012aa:	8b 55 08             	mov    0x8(%ebp),%edx
  8012ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b0:	01 d0                	add    %edx,%eax
  8012b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8012b5:	eb 15                	jmp    8012cc <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ba:	8a 00                	mov    (%eax),%al
  8012bc:	0f b6 d0             	movzbl %al,%edx
  8012bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c2:	0f b6 c0             	movzbl %al,%eax
  8012c5:	39 c2                	cmp    %eax,%edx
  8012c7:	74 0d                	je     8012d6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8012c9:	ff 45 08             	incl   0x8(%ebp)
  8012cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012d2:	72 e3                	jb     8012b7 <memfind+0x13>
  8012d4:	eb 01                	jmp    8012d7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8012d6:	90                   	nop
	return (void *) s;
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012da:	c9                   	leave  
  8012db:	c3                   	ret    

008012dc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8012dc:	55                   	push   %ebp
  8012dd:	89 e5                	mov    %esp,%ebp
  8012df:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8012e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8012e9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012f0:	eb 03                	jmp    8012f5 <strtol+0x19>
		s++;
  8012f2:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f8:	8a 00                	mov    (%eax),%al
  8012fa:	3c 20                	cmp    $0x20,%al
  8012fc:	74 f4                	je     8012f2 <strtol+0x16>
  8012fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801301:	8a 00                	mov    (%eax),%al
  801303:	3c 09                	cmp    $0x9,%al
  801305:	74 eb                	je     8012f2 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801307:	8b 45 08             	mov    0x8(%ebp),%eax
  80130a:	8a 00                	mov    (%eax),%al
  80130c:	3c 2b                	cmp    $0x2b,%al
  80130e:	75 05                	jne    801315 <strtol+0x39>
		s++;
  801310:	ff 45 08             	incl   0x8(%ebp)
  801313:	eb 13                	jmp    801328 <strtol+0x4c>
	else if (*s == '-')
  801315:	8b 45 08             	mov    0x8(%ebp),%eax
  801318:	8a 00                	mov    (%eax),%al
  80131a:	3c 2d                	cmp    $0x2d,%al
  80131c:	75 0a                	jne    801328 <strtol+0x4c>
		s++, neg = 1;
  80131e:	ff 45 08             	incl   0x8(%ebp)
  801321:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801328:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80132c:	74 06                	je     801334 <strtol+0x58>
  80132e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801332:	75 20                	jne    801354 <strtol+0x78>
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	8a 00                	mov    (%eax),%al
  801339:	3c 30                	cmp    $0x30,%al
  80133b:	75 17                	jne    801354 <strtol+0x78>
  80133d:	8b 45 08             	mov    0x8(%ebp),%eax
  801340:	40                   	inc    %eax
  801341:	8a 00                	mov    (%eax),%al
  801343:	3c 78                	cmp    $0x78,%al
  801345:	75 0d                	jne    801354 <strtol+0x78>
		s += 2, base = 16;
  801347:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80134b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801352:	eb 28                	jmp    80137c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801354:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801358:	75 15                	jne    80136f <strtol+0x93>
  80135a:	8b 45 08             	mov    0x8(%ebp),%eax
  80135d:	8a 00                	mov    (%eax),%al
  80135f:	3c 30                	cmp    $0x30,%al
  801361:	75 0c                	jne    80136f <strtol+0x93>
		s++, base = 8;
  801363:	ff 45 08             	incl   0x8(%ebp)
  801366:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80136d:	eb 0d                	jmp    80137c <strtol+0xa0>
	else if (base == 0)
  80136f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801373:	75 07                	jne    80137c <strtol+0xa0>
		base = 10;
  801375:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	3c 2f                	cmp    $0x2f,%al
  801383:	7e 19                	jle    80139e <strtol+0xc2>
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	8a 00                	mov    (%eax),%al
  80138a:	3c 39                	cmp    $0x39,%al
  80138c:	7f 10                	jg     80139e <strtol+0xc2>
			dig = *s - '0';
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	8a 00                	mov    (%eax),%al
  801393:	0f be c0             	movsbl %al,%eax
  801396:	83 e8 30             	sub    $0x30,%eax
  801399:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80139c:	eb 42                	jmp    8013e0 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	8a 00                	mov    (%eax),%al
  8013a3:	3c 60                	cmp    $0x60,%al
  8013a5:	7e 19                	jle    8013c0 <strtol+0xe4>
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	8a 00                	mov    (%eax),%al
  8013ac:	3c 7a                	cmp    $0x7a,%al
  8013ae:	7f 10                	jg     8013c0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	8a 00                	mov    (%eax),%al
  8013b5:	0f be c0             	movsbl %al,%eax
  8013b8:	83 e8 57             	sub    $0x57,%eax
  8013bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013be:	eb 20                	jmp    8013e0 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	8a 00                	mov    (%eax),%al
  8013c5:	3c 40                	cmp    $0x40,%al
  8013c7:	7e 39                	jle    801402 <strtol+0x126>
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cc:	8a 00                	mov    (%eax),%al
  8013ce:	3c 5a                	cmp    $0x5a,%al
  8013d0:	7f 30                	jg     801402 <strtol+0x126>
			dig = *s - 'A' + 10;
  8013d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d5:	8a 00                	mov    (%eax),%al
  8013d7:	0f be c0             	movsbl %al,%eax
  8013da:	83 e8 37             	sub    $0x37,%eax
  8013dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8013e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013e3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013e6:	7d 19                	jge    801401 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8013e8:	ff 45 08             	incl   0x8(%ebp)
  8013eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013ee:	0f af 45 10          	imul   0x10(%ebp),%eax
  8013f2:	89 c2                	mov    %eax,%edx
  8013f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013f7:	01 d0                	add    %edx,%eax
  8013f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8013fc:	e9 7b ff ff ff       	jmp    80137c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801401:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801402:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801406:	74 08                	je     801410 <strtol+0x134>
		*endptr = (char *) s;
  801408:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140b:	8b 55 08             	mov    0x8(%ebp),%edx
  80140e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801410:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801414:	74 07                	je     80141d <strtol+0x141>
  801416:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801419:	f7 d8                	neg    %eax
  80141b:	eb 03                	jmp    801420 <strtol+0x144>
  80141d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801420:	c9                   	leave  
  801421:	c3                   	ret    

00801422 <ltostr>:

void
ltostr(long value, char *str)
{
  801422:	55                   	push   %ebp
  801423:	89 e5                	mov    %esp,%ebp
  801425:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801428:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80142f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801436:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80143a:	79 13                	jns    80144f <ltostr+0x2d>
	{
		neg = 1;
  80143c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801443:	8b 45 0c             	mov    0xc(%ebp),%eax
  801446:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801449:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80144c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801457:	99                   	cltd   
  801458:	f7 f9                	idiv   %ecx
  80145a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80145d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801460:	8d 50 01             	lea    0x1(%eax),%edx
  801463:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801466:	89 c2                	mov    %eax,%edx
  801468:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146b:	01 d0                	add    %edx,%eax
  80146d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801470:	83 c2 30             	add    $0x30,%edx
  801473:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801475:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801478:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80147d:	f7 e9                	imul   %ecx
  80147f:	c1 fa 02             	sar    $0x2,%edx
  801482:	89 c8                	mov    %ecx,%eax
  801484:	c1 f8 1f             	sar    $0x1f,%eax
  801487:	29 c2                	sub    %eax,%edx
  801489:	89 d0                	mov    %edx,%eax
  80148b:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80148e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801492:	75 bb                	jne    80144f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801494:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80149b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80149e:	48                   	dec    %eax
  80149f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8014a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014a6:	74 3d                	je     8014e5 <ltostr+0xc3>
		start = 1 ;
  8014a8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8014af:	eb 34                	jmp    8014e5 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8014b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b7:	01 d0                	add    %edx,%eax
  8014b9:	8a 00                	mov    (%eax),%al
  8014bb:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8014be:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c4:	01 c2                	add    %eax,%edx
  8014c6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8014c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014cc:	01 c8                	add    %ecx,%eax
  8014ce:	8a 00                	mov    (%eax),%al
  8014d0:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8014d2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d8:	01 c2                	add    %eax,%edx
  8014da:	8a 45 eb             	mov    -0x15(%ebp),%al
  8014dd:	88 02                	mov    %al,(%edx)
		start++ ;
  8014df:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8014e2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8014e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014e8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014eb:	7c c4                	jl     8014b1 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014ed:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f3:	01 d0                	add    %edx,%eax
  8014f5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014f8:	90                   	nop
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
  8014fe:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801501:	ff 75 08             	pushl  0x8(%ebp)
  801504:	e8 c4 f9 ff ff       	call   800ecd <strlen>
  801509:	83 c4 04             	add    $0x4,%esp
  80150c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80150f:	ff 75 0c             	pushl  0xc(%ebp)
  801512:	e8 b6 f9 ff ff       	call   800ecd <strlen>
  801517:	83 c4 04             	add    $0x4,%esp
  80151a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80151d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801524:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80152b:	eb 17                	jmp    801544 <strcconcat+0x49>
		final[s] = str1[s] ;
  80152d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801530:	8b 45 10             	mov    0x10(%ebp),%eax
  801533:	01 c2                	add    %eax,%edx
  801535:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	01 c8                	add    %ecx,%eax
  80153d:	8a 00                	mov    (%eax),%al
  80153f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801541:	ff 45 fc             	incl   -0x4(%ebp)
  801544:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801547:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80154a:	7c e1                	jl     80152d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80154c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801553:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80155a:	eb 1f                	jmp    80157b <strcconcat+0x80>
		final[s++] = str2[i] ;
  80155c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80155f:	8d 50 01             	lea    0x1(%eax),%edx
  801562:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801565:	89 c2                	mov    %eax,%edx
  801567:	8b 45 10             	mov    0x10(%ebp),%eax
  80156a:	01 c2                	add    %eax,%edx
  80156c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80156f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801572:	01 c8                	add    %ecx,%eax
  801574:	8a 00                	mov    (%eax),%al
  801576:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801578:	ff 45 f8             	incl   -0x8(%ebp)
  80157b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801581:	7c d9                	jl     80155c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801583:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801586:	8b 45 10             	mov    0x10(%ebp),%eax
  801589:	01 d0                	add    %edx,%eax
  80158b:	c6 00 00             	movb   $0x0,(%eax)
}
  80158e:	90                   	nop
  80158f:	c9                   	leave  
  801590:	c3                   	ret    

00801591 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801591:	55                   	push   %ebp
  801592:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801594:	8b 45 14             	mov    0x14(%ebp),%eax
  801597:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80159d:	8b 45 14             	mov    0x14(%ebp),%eax
  8015a0:	8b 00                	mov    (%eax),%eax
  8015a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ac:	01 d0                	add    %edx,%eax
  8015ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015b4:	eb 0c                	jmp    8015c2 <strsplit+0x31>
			*string++ = 0;
  8015b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b9:	8d 50 01             	lea    0x1(%eax),%edx
  8015bc:	89 55 08             	mov    %edx,0x8(%ebp)
  8015bf:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	8a 00                	mov    (%eax),%al
  8015c7:	84 c0                	test   %al,%al
  8015c9:	74 18                	je     8015e3 <strsplit+0x52>
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	8a 00                	mov    (%eax),%al
  8015d0:	0f be c0             	movsbl %al,%eax
  8015d3:	50                   	push   %eax
  8015d4:	ff 75 0c             	pushl  0xc(%ebp)
  8015d7:	e8 83 fa ff ff       	call   80105f <strchr>
  8015dc:	83 c4 08             	add    $0x8,%esp
  8015df:	85 c0                	test   %eax,%eax
  8015e1:	75 d3                	jne    8015b6 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e6:	8a 00                	mov    (%eax),%al
  8015e8:	84 c0                	test   %al,%al
  8015ea:	74 5a                	je     801646 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8015ef:	8b 00                	mov    (%eax),%eax
  8015f1:	83 f8 0f             	cmp    $0xf,%eax
  8015f4:	75 07                	jne    8015fd <strsplit+0x6c>
		{
			return 0;
  8015f6:	b8 00 00 00 00       	mov    $0x0,%eax
  8015fb:	eb 66                	jmp    801663 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8015fd:	8b 45 14             	mov    0x14(%ebp),%eax
  801600:	8b 00                	mov    (%eax),%eax
  801602:	8d 48 01             	lea    0x1(%eax),%ecx
  801605:	8b 55 14             	mov    0x14(%ebp),%edx
  801608:	89 0a                	mov    %ecx,(%edx)
  80160a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801611:	8b 45 10             	mov    0x10(%ebp),%eax
  801614:	01 c2                	add    %eax,%edx
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80161b:	eb 03                	jmp    801620 <strsplit+0x8f>
			string++;
  80161d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	8a 00                	mov    (%eax),%al
  801625:	84 c0                	test   %al,%al
  801627:	74 8b                	je     8015b4 <strsplit+0x23>
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
  80162c:	8a 00                	mov    (%eax),%al
  80162e:	0f be c0             	movsbl %al,%eax
  801631:	50                   	push   %eax
  801632:	ff 75 0c             	pushl  0xc(%ebp)
  801635:	e8 25 fa ff ff       	call   80105f <strchr>
  80163a:	83 c4 08             	add    $0x8,%esp
  80163d:	85 c0                	test   %eax,%eax
  80163f:	74 dc                	je     80161d <strsplit+0x8c>
			string++;
	}
  801641:	e9 6e ff ff ff       	jmp    8015b4 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801646:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801647:	8b 45 14             	mov    0x14(%ebp),%eax
  80164a:	8b 00                	mov    (%eax),%eax
  80164c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801653:	8b 45 10             	mov    0x10(%ebp),%eax
  801656:	01 d0                	add    %edx,%eax
  801658:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80165e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
  801668:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801671:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801678:	eb 4a                	jmp    8016c4 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80167a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80167d:	8b 45 08             	mov    0x8(%ebp),%eax
  801680:	01 c2                	add    %eax,%edx
  801682:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801685:	8b 45 0c             	mov    0xc(%ebp),%eax
  801688:	01 c8                	add    %ecx,%eax
  80168a:	8a 00                	mov    (%eax),%al
  80168c:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80168e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801691:	8b 45 0c             	mov    0xc(%ebp),%eax
  801694:	01 d0                	add    %edx,%eax
  801696:	8a 00                	mov    (%eax),%al
  801698:	3c 40                	cmp    $0x40,%al
  80169a:	7e 25                	jle    8016c1 <str2lower+0x5c>
  80169c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80169f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a2:	01 d0                	add    %edx,%eax
  8016a4:	8a 00                	mov    (%eax),%al
  8016a6:	3c 5a                	cmp    $0x5a,%al
  8016a8:	7f 17                	jg     8016c1 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8016aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	01 d0                	add    %edx,%eax
  8016b2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8016b5:	8b 55 08             	mov    0x8(%ebp),%edx
  8016b8:	01 ca                	add    %ecx,%edx
  8016ba:	8a 12                	mov    (%edx),%dl
  8016bc:	83 c2 20             	add    $0x20,%edx
  8016bf:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8016c1:	ff 45 fc             	incl   -0x4(%ebp)
  8016c4:	ff 75 0c             	pushl  0xc(%ebp)
  8016c7:	e8 01 f8 ff ff       	call   800ecd <strlen>
  8016cc:	83 c4 04             	add    $0x4,%esp
  8016cf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8016d2:	7f a6                	jg     80167a <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8016d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016d7:	c9                   	leave  
  8016d8:	c3                   	ret    

008016d9 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
  8016dc:	57                   	push   %edi
  8016dd:	56                   	push   %esi
  8016de:	53                   	push   %ebx
  8016df:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016eb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016ee:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016f1:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016f4:	cd 30                	int    $0x30
  8016f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016fc:	83 c4 10             	add    $0x10,%esp
  8016ff:	5b                   	pop    %ebx
  801700:	5e                   	pop    %esi
  801701:	5f                   	pop    %edi
  801702:	5d                   	pop    %ebp
  801703:	c3                   	ret    

00801704 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
  801707:	83 ec 04             	sub    $0x4,%esp
  80170a:	8b 45 10             	mov    0x10(%ebp),%eax
  80170d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801710:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801713:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	6a 00                	push   $0x0
  80171c:	51                   	push   %ecx
  80171d:	52                   	push   %edx
  80171e:	ff 75 0c             	pushl  0xc(%ebp)
  801721:	50                   	push   %eax
  801722:	6a 00                	push   $0x0
  801724:	e8 b0 ff ff ff       	call   8016d9 <syscall>
  801729:	83 c4 18             	add    $0x18,%esp
}
  80172c:	90                   	nop
  80172d:	c9                   	leave  
  80172e:	c3                   	ret    

0080172f <sys_cgetc>:

int
sys_cgetc(void)
{
  80172f:	55                   	push   %ebp
  801730:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 02                	push   $0x2
  80173e:	e8 96 ff ff ff       	call   8016d9 <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
}
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 03                	push   $0x3
  801757:	e8 7d ff ff ff       	call   8016d9 <syscall>
  80175c:	83 c4 18             	add    $0x18,%esp
}
  80175f:	90                   	nop
  801760:	c9                   	leave  
  801761:	c3                   	ret    

00801762 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 04                	push   $0x4
  801771:	e8 63 ff ff ff       	call   8016d9 <syscall>
  801776:	83 c4 18             	add    $0x18,%esp
}
  801779:	90                   	nop
  80177a:	c9                   	leave  
  80177b:	c3                   	ret    

0080177c <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  80177c:	55                   	push   %ebp
  80177d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80177f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801782:	8b 45 08             	mov    0x8(%ebp),%eax
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	52                   	push   %edx
  80178c:	50                   	push   %eax
  80178d:	6a 08                	push   $0x8
  80178f:	e8 45 ff ff ff       	call   8016d9 <syscall>
  801794:	83 c4 18             	add    $0x18,%esp
}
  801797:	c9                   	leave  
  801798:	c3                   	ret    

00801799 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801799:	55                   	push   %ebp
  80179a:	89 e5                	mov    %esp,%ebp
  80179c:	56                   	push   %esi
  80179d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80179e:	8b 75 18             	mov    0x18(%ebp),%esi
  8017a1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017a4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ad:	56                   	push   %esi
  8017ae:	53                   	push   %ebx
  8017af:	51                   	push   %ecx
  8017b0:	52                   	push   %edx
  8017b1:	50                   	push   %eax
  8017b2:	6a 09                	push   $0x9
  8017b4:	e8 20 ff ff ff       	call   8016d9 <syscall>
  8017b9:	83 c4 18             	add    $0x18,%esp
}
  8017bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017bf:	5b                   	pop    %ebx
  8017c0:	5e                   	pop    %esi
  8017c1:	5d                   	pop    %ebp
  8017c2:	c3                   	ret    

008017c3 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8017c3:	55                   	push   %ebp
  8017c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	ff 75 08             	pushl  0x8(%ebp)
  8017d1:	6a 0a                	push   $0xa
  8017d3:	e8 01 ff ff ff       	call   8016d9 <syscall>
  8017d8:	83 c4 18             	add    $0x18,%esp
}
  8017db:	c9                   	leave  
  8017dc:	c3                   	ret    

008017dd <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	ff 75 0c             	pushl  0xc(%ebp)
  8017e9:	ff 75 08             	pushl  0x8(%ebp)
  8017ec:	6a 0b                	push   $0xb
  8017ee:	e8 e6 fe ff ff       	call   8016d9 <syscall>
  8017f3:	83 c4 18             	add    $0x18,%esp
}
  8017f6:	c9                   	leave  
  8017f7:	c3                   	ret    

008017f8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017f8:	55                   	push   %ebp
  8017f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 0c                	push   $0xc
  801807:	e8 cd fe ff ff       	call   8016d9 <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
}
  80180f:	c9                   	leave  
  801810:	c3                   	ret    

00801811 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801811:	55                   	push   %ebp
  801812:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 0d                	push   $0xd
  801820:	e8 b4 fe ff ff       	call   8016d9 <syscall>
  801825:	83 c4 18             	add    $0x18,%esp
}
  801828:	c9                   	leave  
  801829:	c3                   	ret    

0080182a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80182a:	55                   	push   %ebp
  80182b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 0e                	push   $0xe
  801839:	e8 9b fe ff ff       	call   8016d9 <syscall>
  80183e:	83 c4 18             	add    $0x18,%esp
}
  801841:	c9                   	leave  
  801842:	c3                   	ret    

00801843 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801843:	55                   	push   %ebp
  801844:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 0f                	push   $0xf
  801852:	e8 82 fe ff ff       	call   8016d9 <syscall>
  801857:	83 c4 18             	add    $0x18,%esp
}
  80185a:	c9                   	leave  
  80185b:	c3                   	ret    

0080185c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80185c:	55                   	push   %ebp
  80185d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	ff 75 08             	pushl  0x8(%ebp)
  80186a:	6a 10                	push   $0x10
  80186c:	e8 68 fe ff ff       	call   8016d9 <syscall>
  801871:	83 c4 18             	add    $0x18,%esp
}
  801874:	c9                   	leave  
  801875:	c3                   	ret    

00801876 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801876:	55                   	push   %ebp
  801877:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	6a 11                	push   $0x11
  801885:	e8 4f fe ff ff       	call   8016d9 <syscall>
  80188a:	83 c4 18             	add    $0x18,%esp
}
  80188d:	90                   	nop
  80188e:	c9                   	leave  
  80188f:	c3                   	ret    

00801890 <sys_cputc>:

void
sys_cputc(const char c)
{
  801890:	55                   	push   %ebp
  801891:	89 e5                	mov    %esp,%ebp
  801893:	83 ec 04             	sub    $0x4,%esp
  801896:	8b 45 08             	mov    0x8(%ebp),%eax
  801899:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80189c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	50                   	push   %eax
  8018a9:	6a 01                	push   $0x1
  8018ab:	e8 29 fe ff ff       	call   8016d9 <syscall>
  8018b0:	83 c4 18             	add    $0x18,%esp
}
  8018b3:	90                   	nop
  8018b4:	c9                   	leave  
  8018b5:	c3                   	ret    

008018b6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 14                	push   $0x14
  8018c5:	e8 0f fe ff ff       	call   8016d9 <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
}
  8018cd:	90                   	nop
  8018ce:	c9                   	leave  
  8018cf:	c3                   	ret    

008018d0 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8018d0:	55                   	push   %ebp
  8018d1:	89 e5                	mov    %esp,%ebp
  8018d3:	83 ec 04             	sub    $0x4,%esp
  8018d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8018dc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018df:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e6:	6a 00                	push   $0x0
  8018e8:	51                   	push   %ecx
  8018e9:	52                   	push   %edx
  8018ea:	ff 75 0c             	pushl  0xc(%ebp)
  8018ed:	50                   	push   %eax
  8018ee:	6a 15                	push   $0x15
  8018f0:	e8 e4 fd ff ff       	call   8016d9 <syscall>
  8018f5:	83 c4 18             	add    $0x18,%esp
}
  8018f8:	c9                   	leave  
  8018f9:	c3                   	ret    

008018fa <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8018fa:	55                   	push   %ebp
  8018fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8018fd:	8b 55 10             	mov    0x10(%ebp),%edx
  801900:	8b 45 0c             	mov    0xc(%ebp),%eax
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	52                   	push   %edx
  801908:	50                   	push   %eax
  801909:	ff 75 08             	pushl  0x8(%ebp)
  80190c:	6a 16                	push   $0x16
  80190e:	e8 c6 fd ff ff       	call   8016d9 <syscall>
  801913:	83 c4 18             	add    $0x18,%esp
}
  801916:	c9                   	leave  
  801917:	c3                   	ret    

00801918 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801918:	55                   	push   %ebp
  801919:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80191b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80191e:	8b 45 08             	mov    0x8(%ebp),%eax
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	52                   	push   %edx
  801928:	50                   	push   %eax
  801929:	6a 17                	push   $0x17
  80192b:	e8 a9 fd ff ff       	call   8016d9 <syscall>
  801930:	83 c4 18             	add    $0x18,%esp
}
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801938:	8b 55 0c             	mov    0xc(%ebp),%edx
  80193b:	8b 45 08             	mov    0x8(%ebp),%eax
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	52                   	push   %edx
  801945:	50                   	push   %eax
  801946:	6a 18                	push   $0x18
  801948:	e8 8c fd ff ff       	call   8016d9 <syscall>
  80194d:	83 c4 18             	add    $0x18,%esp
}
  801950:	c9                   	leave  
  801951:	c3                   	ret    

00801952 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801955:	8b 45 08             	mov    0x8(%ebp),%eax
  801958:	6a 00                	push   $0x0
  80195a:	ff 75 14             	pushl  0x14(%ebp)
  80195d:	ff 75 10             	pushl  0x10(%ebp)
  801960:	ff 75 0c             	pushl  0xc(%ebp)
  801963:	50                   	push   %eax
  801964:	6a 19                	push   $0x19
  801966:	e8 6e fd ff ff       	call   8016d9 <syscall>
  80196b:	83 c4 18             	add    $0x18,%esp
}
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801973:	8b 45 08             	mov    0x8(%ebp),%eax
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	50                   	push   %eax
  80197f:	6a 1a                	push   $0x1a
  801981:	e8 53 fd ff ff       	call   8016d9 <syscall>
  801986:	83 c4 18             	add    $0x18,%esp
}
  801989:	90                   	nop
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80198f:	8b 45 08             	mov    0x8(%ebp),%eax
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	50                   	push   %eax
  80199b:	6a 1b                	push   $0x1b
  80199d:	e8 37 fd ff ff       	call   8016d9 <syscall>
  8019a2:	83 c4 18             	add    $0x18,%esp
}
  8019a5:	c9                   	leave  
  8019a6:	c3                   	ret    

008019a7 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 05                	push   $0x5
  8019b6:	e8 1e fd ff ff       	call   8016d9 <syscall>
  8019bb:	83 c4 18             	add    $0x18,%esp
}
  8019be:	c9                   	leave  
  8019bf:	c3                   	ret    

008019c0 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019c0:	55                   	push   %ebp
  8019c1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 06                	push   $0x6
  8019cf:	e8 05 fd ff ff       	call   8016d9 <syscall>
  8019d4:	83 c4 18             	add    $0x18,%esp
}
  8019d7:	c9                   	leave  
  8019d8:	c3                   	ret    

008019d9 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019d9:	55                   	push   %ebp
  8019da:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 07                	push   $0x7
  8019e8:	e8 ec fc ff ff       	call   8016d9 <syscall>
  8019ed:	83 c4 18             	add    $0x18,%esp
}
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <sys_exit_env>:


void sys_exit_env(void)
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 1c                	push   $0x1c
  801a01:	e8 d3 fc ff ff       	call   8016d9 <syscall>
  801a06:	83 c4 18             	add    $0x18,%esp
}
  801a09:	90                   	nop
  801a0a:	c9                   	leave  
  801a0b:	c3                   	ret    

00801a0c <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a0c:	55                   	push   %ebp
  801a0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	ff 75 10             	pushl  0x10(%ebp)
  801a16:	ff 75 0c             	pushl  0xc(%ebp)
  801a19:	ff 75 08             	pushl  0x8(%ebp)
  801a1c:	6a 13                	push   $0x13
  801a1e:	e8 b6 fc ff ff       	call   8016d9 <syscall>
  801a23:	83 c4 18             	add    $0x18,%esp
	return ;
  801a26:	90                   	nop
}
  801a27:	c9                   	leave  
  801a28:	c3                   	ret    

00801a29 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a29:	55                   	push   %ebp
  801a2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 1e                	push   $0x1e
  801a38:	e8 9c fc ff ff       	call   8016d9 <syscall>
  801a3d:	83 c4 18             	add    $0x18,%esp
}
  801a40:	c9                   	leave  
  801a41:	c3                   	ret    

00801a42 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
  801a45:	83 ec 04             	sub    $0x4,%esp
  801a48:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a4e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	50                   	push   %eax
  801a5b:	6a 1f                	push   $0x1f
  801a5d:	e8 77 fc ff ff       	call   8016d9 <syscall>
  801a62:	83 c4 18             	add    $0x18,%esp
	return ;
  801a65:	90                   	nop
}
  801a66:	c9                   	leave  
  801a67:	c3                   	ret    

00801a68 <rsttst>:
void rsttst()
{
  801a68:	55                   	push   %ebp
  801a69:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 21                	push   $0x21
  801a77:	e8 5d fc ff ff       	call   8016d9 <syscall>
  801a7c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a7f:	90                   	nop
}
  801a80:	c9                   	leave  
  801a81:	c3                   	ret    

00801a82 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a82:	55                   	push   %ebp
  801a83:	89 e5                	mov    %esp,%ebp
  801a85:	83 ec 04             	sub    $0x4,%esp
  801a88:	8b 45 14             	mov    0x14(%ebp),%eax
  801a8b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a8e:	8b 55 18             	mov    0x18(%ebp),%edx
  801a91:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a95:	52                   	push   %edx
  801a96:	50                   	push   %eax
  801a97:	ff 75 10             	pushl  0x10(%ebp)
  801a9a:	ff 75 0c             	pushl  0xc(%ebp)
  801a9d:	ff 75 08             	pushl  0x8(%ebp)
  801aa0:	6a 20                	push   $0x20
  801aa2:	e8 32 fc ff ff       	call   8016d9 <syscall>
  801aa7:	83 c4 18             	add    $0x18,%esp
	return ;
  801aaa:	90                   	nop
}
  801aab:	c9                   	leave  
  801aac:	c3                   	ret    

00801aad <chktst>:
void chktst(uint32 n)
{
  801aad:	55                   	push   %ebp
  801aae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	ff 75 08             	pushl  0x8(%ebp)
  801abb:	6a 22                	push   $0x22
  801abd:	e8 17 fc ff ff       	call   8016d9 <syscall>
  801ac2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ac5:	90                   	nop
}
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <inctst>:

void inctst()
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 23                	push   $0x23
  801ad7:	e8 fd fb ff ff       	call   8016d9 <syscall>
  801adc:	83 c4 18             	add    $0x18,%esp
	return ;
  801adf:	90                   	nop
}
  801ae0:	c9                   	leave  
  801ae1:	c3                   	ret    

00801ae2 <gettst>:
uint32 gettst()
{
  801ae2:	55                   	push   %ebp
  801ae3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 24                	push   $0x24
  801af1:	e8 e3 fb ff ff       	call   8016d9 <syscall>
  801af6:	83 c4 18             	add    $0x18,%esp
}
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	6a 25                	push   $0x25
  801b0a:	e8 ca fb ff ff       	call   8016d9 <syscall>
  801b0f:	83 c4 18             	add    $0x18,%esp
  801b12:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801b17:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801b1c:	c9                   	leave  
  801b1d:	c3                   	ret    

00801b1e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b1e:	55                   	push   %ebp
  801b1f:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801b21:	8b 45 08             	mov    0x8(%ebp),%eax
  801b24:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	ff 75 08             	pushl  0x8(%ebp)
  801b34:	6a 26                	push   $0x26
  801b36:	e8 9e fb ff ff       	call   8016d9 <syscall>
  801b3b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b3e:	90                   	nop
}
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
  801b44:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b45:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b48:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b51:	6a 00                	push   $0x0
  801b53:	53                   	push   %ebx
  801b54:	51                   	push   %ecx
  801b55:	52                   	push   %edx
  801b56:	50                   	push   %eax
  801b57:	6a 27                	push   $0x27
  801b59:	e8 7b fb ff ff       	call   8016d9 <syscall>
  801b5e:	83 c4 18             	add    $0x18,%esp
}
  801b61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b64:	c9                   	leave  
  801b65:	c3                   	ret    

00801b66 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b66:	55                   	push   %ebp
  801b67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b69:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	52                   	push   %edx
  801b76:	50                   	push   %eax
  801b77:	6a 28                	push   $0x28
  801b79:	e8 5b fb ff ff       	call   8016d9 <syscall>
  801b7e:	83 c4 18             	add    $0x18,%esp
}
  801b81:	c9                   	leave  
  801b82:	c3                   	ret    

00801b83 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b83:	55                   	push   %ebp
  801b84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b86:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b89:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8f:	6a 00                	push   $0x0
  801b91:	51                   	push   %ecx
  801b92:	ff 75 10             	pushl  0x10(%ebp)
  801b95:	52                   	push   %edx
  801b96:	50                   	push   %eax
  801b97:	6a 29                	push   $0x29
  801b99:	e8 3b fb ff ff       	call   8016d9 <syscall>
  801b9e:	83 c4 18             	add    $0x18,%esp
}
  801ba1:	c9                   	leave  
  801ba2:	c3                   	ret    

00801ba3 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801ba3:	55                   	push   %ebp
  801ba4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	ff 75 10             	pushl  0x10(%ebp)
  801bad:	ff 75 0c             	pushl  0xc(%ebp)
  801bb0:	ff 75 08             	pushl  0x8(%ebp)
  801bb3:	6a 12                	push   $0x12
  801bb5:	e8 1f fb ff ff       	call   8016d9 <syscall>
  801bba:	83 c4 18             	add    $0x18,%esp
	return ;
  801bbd:	90                   	nop
}
  801bbe:	c9                   	leave  
  801bbf:	c3                   	ret    

00801bc0 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801bc3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	52                   	push   %edx
  801bd0:	50                   	push   %eax
  801bd1:	6a 2a                	push   $0x2a
  801bd3:	e8 01 fb ff ff       	call   8016d9 <syscall>
  801bd8:	83 c4 18             	add    $0x18,%esp
	return;
  801bdb:	90                   	nop
}
  801bdc:	c9                   	leave  
  801bdd:	c3                   	ret    

00801bde <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801bde:	55                   	push   %ebp
  801bdf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 2b                	push   $0x2b
  801bed:	e8 e7 fa ff ff       	call   8016d9 <syscall>
  801bf2:	83 c4 18             	add    $0x18,%esp
}
  801bf5:	c9                   	leave  
  801bf6:	c3                   	ret    

00801bf7 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801bf7:	55                   	push   %ebp
  801bf8:	89 e5                	mov    %esp,%ebp
  801bfa:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801bfd:	83 ec 04             	sub    $0x4,%esp
  801c00:	68 48 29 80 00       	push   $0x802948
  801c05:	68 0a 01 00 00       	push   $0x10a
  801c0a:	68 58 29 80 00       	push   $0x802958
  801c0f:	e8 12 e9 ff ff       	call   800526 <_panic>

00801c14 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801c14:	55                   	push   %ebp
  801c15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	ff 75 0c             	pushl  0xc(%ebp)
  801c20:	ff 75 08             	pushl  0x8(%ebp)
  801c23:	6a 33                	push   $0x33
  801c25:	e8 af fa ff ff       	call   8016d9 <syscall>
  801c2a:	83 c4 18             	add    $0x18,%esp
	return;
  801c2d:	90                   	nop
}
  801c2e:	c9                   	leave  
  801c2f:	c3                   	ret    

00801c30 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801c30:	55                   	push   %ebp
  801c31:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	ff 75 0c             	pushl  0xc(%ebp)
  801c3c:	ff 75 08             	pushl  0x8(%ebp)
  801c3f:	6a 34                	push   $0x34
  801c41:	e8 93 fa ff ff       	call   8016d9 <syscall>
  801c46:	83 c4 18             	add    $0x18,%esp
	return ;
  801c49:	90                   	nop
}
  801c4a:	c9                   	leave  
  801c4b:	c3                   	ret    

00801c4c <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801c4c:	55                   	push   %ebp
  801c4d:	89 e5                	mov    %esp,%ebp
  801c4f:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801c52:	8b 55 08             	mov    0x8(%ebp),%edx
  801c55:	89 d0                	mov    %edx,%eax
  801c57:	c1 e0 02             	shl    $0x2,%eax
  801c5a:	01 d0                	add    %edx,%eax
  801c5c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c63:	01 d0                	add    %edx,%eax
  801c65:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c6c:	01 d0                	add    %edx,%eax
  801c6e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c75:	01 d0                	add    %edx,%eax
  801c77:	c1 e0 04             	shl    $0x4,%eax
  801c7a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801c7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c84:	0f 31                	rdtsc  
  801c86:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801c89:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c8c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c8f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c92:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c95:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c98:	eb 46                	jmp    801ce0 <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c9a:	0f 31                	rdtsc  
  801c9c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801c9f:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801ca2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ca5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801ca8:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801cab:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801cae:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801cb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cb4:	29 c2                	sub    %eax,%edx
  801cb6:	89 d0                	mov    %edx,%eax
  801cb8:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801cbb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801cbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cc1:	89 d1                	mov    %edx,%ecx
  801cc3:	29 c1                	sub    %eax,%ecx
  801cc5:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801cc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ccb:	39 c2                	cmp    %eax,%edx
  801ccd:	0f 97 c0             	seta   %al
  801cd0:	0f b6 c0             	movzbl %al,%eax
  801cd3:	29 c1                	sub    %eax,%ecx
  801cd5:	89 c8                	mov    %ecx,%eax
  801cd7:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801cda:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801cdd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801ce0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ce3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801ce6:	72 b2                	jb     801c9a <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801ce8:	90                   	nop
  801ce9:	c9                   	leave  
  801cea:	c3                   	ret    

00801ceb <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801ceb:	55                   	push   %ebp
  801cec:	89 e5                	mov    %esp,%ebp
  801cee:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801cf1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801cf8:	eb 03                	jmp    801cfd <busy_wait+0x12>
  801cfa:	ff 45 fc             	incl   -0x4(%ebp)
  801cfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d00:	3b 45 08             	cmp    0x8(%ebp),%eax
  801d03:	72 f5                	jb     801cfa <busy_wait+0xf>
	return i;
  801d05:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801d08:	c9                   	leave  
  801d09:	c3                   	ret    
  801d0a:	66 90                	xchg   %ax,%ax

00801d0c <__udivdi3>:
  801d0c:	55                   	push   %ebp
  801d0d:	57                   	push   %edi
  801d0e:	56                   	push   %esi
  801d0f:	53                   	push   %ebx
  801d10:	83 ec 1c             	sub    $0x1c,%esp
  801d13:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d17:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d1f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d23:	89 ca                	mov    %ecx,%edx
  801d25:	89 f8                	mov    %edi,%eax
  801d27:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d2b:	85 f6                	test   %esi,%esi
  801d2d:	75 2d                	jne    801d5c <__udivdi3+0x50>
  801d2f:	39 cf                	cmp    %ecx,%edi
  801d31:	77 65                	ja     801d98 <__udivdi3+0x8c>
  801d33:	89 fd                	mov    %edi,%ebp
  801d35:	85 ff                	test   %edi,%edi
  801d37:	75 0b                	jne    801d44 <__udivdi3+0x38>
  801d39:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3e:	31 d2                	xor    %edx,%edx
  801d40:	f7 f7                	div    %edi
  801d42:	89 c5                	mov    %eax,%ebp
  801d44:	31 d2                	xor    %edx,%edx
  801d46:	89 c8                	mov    %ecx,%eax
  801d48:	f7 f5                	div    %ebp
  801d4a:	89 c1                	mov    %eax,%ecx
  801d4c:	89 d8                	mov    %ebx,%eax
  801d4e:	f7 f5                	div    %ebp
  801d50:	89 cf                	mov    %ecx,%edi
  801d52:	89 fa                	mov    %edi,%edx
  801d54:	83 c4 1c             	add    $0x1c,%esp
  801d57:	5b                   	pop    %ebx
  801d58:	5e                   	pop    %esi
  801d59:	5f                   	pop    %edi
  801d5a:	5d                   	pop    %ebp
  801d5b:	c3                   	ret    
  801d5c:	39 ce                	cmp    %ecx,%esi
  801d5e:	77 28                	ja     801d88 <__udivdi3+0x7c>
  801d60:	0f bd fe             	bsr    %esi,%edi
  801d63:	83 f7 1f             	xor    $0x1f,%edi
  801d66:	75 40                	jne    801da8 <__udivdi3+0x9c>
  801d68:	39 ce                	cmp    %ecx,%esi
  801d6a:	72 0a                	jb     801d76 <__udivdi3+0x6a>
  801d6c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d70:	0f 87 9e 00 00 00    	ja     801e14 <__udivdi3+0x108>
  801d76:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7b:	89 fa                	mov    %edi,%edx
  801d7d:	83 c4 1c             	add    $0x1c,%esp
  801d80:	5b                   	pop    %ebx
  801d81:	5e                   	pop    %esi
  801d82:	5f                   	pop    %edi
  801d83:	5d                   	pop    %ebp
  801d84:	c3                   	ret    
  801d85:	8d 76 00             	lea    0x0(%esi),%esi
  801d88:	31 ff                	xor    %edi,%edi
  801d8a:	31 c0                	xor    %eax,%eax
  801d8c:	89 fa                	mov    %edi,%edx
  801d8e:	83 c4 1c             	add    $0x1c,%esp
  801d91:	5b                   	pop    %ebx
  801d92:	5e                   	pop    %esi
  801d93:	5f                   	pop    %edi
  801d94:	5d                   	pop    %ebp
  801d95:	c3                   	ret    
  801d96:	66 90                	xchg   %ax,%ax
  801d98:	89 d8                	mov    %ebx,%eax
  801d9a:	f7 f7                	div    %edi
  801d9c:	31 ff                	xor    %edi,%edi
  801d9e:	89 fa                	mov    %edi,%edx
  801da0:	83 c4 1c             	add    $0x1c,%esp
  801da3:	5b                   	pop    %ebx
  801da4:	5e                   	pop    %esi
  801da5:	5f                   	pop    %edi
  801da6:	5d                   	pop    %ebp
  801da7:	c3                   	ret    
  801da8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dad:	89 eb                	mov    %ebp,%ebx
  801daf:	29 fb                	sub    %edi,%ebx
  801db1:	89 f9                	mov    %edi,%ecx
  801db3:	d3 e6                	shl    %cl,%esi
  801db5:	89 c5                	mov    %eax,%ebp
  801db7:	88 d9                	mov    %bl,%cl
  801db9:	d3 ed                	shr    %cl,%ebp
  801dbb:	89 e9                	mov    %ebp,%ecx
  801dbd:	09 f1                	or     %esi,%ecx
  801dbf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801dc3:	89 f9                	mov    %edi,%ecx
  801dc5:	d3 e0                	shl    %cl,%eax
  801dc7:	89 c5                	mov    %eax,%ebp
  801dc9:	89 d6                	mov    %edx,%esi
  801dcb:	88 d9                	mov    %bl,%cl
  801dcd:	d3 ee                	shr    %cl,%esi
  801dcf:	89 f9                	mov    %edi,%ecx
  801dd1:	d3 e2                	shl    %cl,%edx
  801dd3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dd7:	88 d9                	mov    %bl,%cl
  801dd9:	d3 e8                	shr    %cl,%eax
  801ddb:	09 c2                	or     %eax,%edx
  801ddd:	89 d0                	mov    %edx,%eax
  801ddf:	89 f2                	mov    %esi,%edx
  801de1:	f7 74 24 0c          	divl   0xc(%esp)
  801de5:	89 d6                	mov    %edx,%esi
  801de7:	89 c3                	mov    %eax,%ebx
  801de9:	f7 e5                	mul    %ebp
  801deb:	39 d6                	cmp    %edx,%esi
  801ded:	72 19                	jb     801e08 <__udivdi3+0xfc>
  801def:	74 0b                	je     801dfc <__udivdi3+0xf0>
  801df1:	89 d8                	mov    %ebx,%eax
  801df3:	31 ff                	xor    %edi,%edi
  801df5:	e9 58 ff ff ff       	jmp    801d52 <__udivdi3+0x46>
  801dfa:	66 90                	xchg   %ax,%ax
  801dfc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e00:	89 f9                	mov    %edi,%ecx
  801e02:	d3 e2                	shl    %cl,%edx
  801e04:	39 c2                	cmp    %eax,%edx
  801e06:	73 e9                	jae    801df1 <__udivdi3+0xe5>
  801e08:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e0b:	31 ff                	xor    %edi,%edi
  801e0d:	e9 40 ff ff ff       	jmp    801d52 <__udivdi3+0x46>
  801e12:	66 90                	xchg   %ax,%ax
  801e14:	31 c0                	xor    %eax,%eax
  801e16:	e9 37 ff ff ff       	jmp    801d52 <__udivdi3+0x46>
  801e1b:	90                   	nop

00801e1c <__umoddi3>:
  801e1c:	55                   	push   %ebp
  801e1d:	57                   	push   %edi
  801e1e:	56                   	push   %esi
  801e1f:	53                   	push   %ebx
  801e20:	83 ec 1c             	sub    $0x1c,%esp
  801e23:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e27:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e2b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e2f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e33:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e37:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e3b:	89 f3                	mov    %esi,%ebx
  801e3d:	89 fa                	mov    %edi,%edx
  801e3f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e43:	89 34 24             	mov    %esi,(%esp)
  801e46:	85 c0                	test   %eax,%eax
  801e48:	75 1a                	jne    801e64 <__umoddi3+0x48>
  801e4a:	39 f7                	cmp    %esi,%edi
  801e4c:	0f 86 a2 00 00 00    	jbe    801ef4 <__umoddi3+0xd8>
  801e52:	89 c8                	mov    %ecx,%eax
  801e54:	89 f2                	mov    %esi,%edx
  801e56:	f7 f7                	div    %edi
  801e58:	89 d0                	mov    %edx,%eax
  801e5a:	31 d2                	xor    %edx,%edx
  801e5c:	83 c4 1c             	add    $0x1c,%esp
  801e5f:	5b                   	pop    %ebx
  801e60:	5e                   	pop    %esi
  801e61:	5f                   	pop    %edi
  801e62:	5d                   	pop    %ebp
  801e63:	c3                   	ret    
  801e64:	39 f0                	cmp    %esi,%eax
  801e66:	0f 87 ac 00 00 00    	ja     801f18 <__umoddi3+0xfc>
  801e6c:	0f bd e8             	bsr    %eax,%ebp
  801e6f:	83 f5 1f             	xor    $0x1f,%ebp
  801e72:	0f 84 ac 00 00 00    	je     801f24 <__umoddi3+0x108>
  801e78:	bf 20 00 00 00       	mov    $0x20,%edi
  801e7d:	29 ef                	sub    %ebp,%edi
  801e7f:	89 fe                	mov    %edi,%esi
  801e81:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e85:	89 e9                	mov    %ebp,%ecx
  801e87:	d3 e0                	shl    %cl,%eax
  801e89:	89 d7                	mov    %edx,%edi
  801e8b:	89 f1                	mov    %esi,%ecx
  801e8d:	d3 ef                	shr    %cl,%edi
  801e8f:	09 c7                	or     %eax,%edi
  801e91:	89 e9                	mov    %ebp,%ecx
  801e93:	d3 e2                	shl    %cl,%edx
  801e95:	89 14 24             	mov    %edx,(%esp)
  801e98:	89 d8                	mov    %ebx,%eax
  801e9a:	d3 e0                	shl    %cl,%eax
  801e9c:	89 c2                	mov    %eax,%edx
  801e9e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ea2:	d3 e0                	shl    %cl,%eax
  801ea4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ea8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eac:	89 f1                	mov    %esi,%ecx
  801eae:	d3 e8                	shr    %cl,%eax
  801eb0:	09 d0                	or     %edx,%eax
  801eb2:	d3 eb                	shr    %cl,%ebx
  801eb4:	89 da                	mov    %ebx,%edx
  801eb6:	f7 f7                	div    %edi
  801eb8:	89 d3                	mov    %edx,%ebx
  801eba:	f7 24 24             	mull   (%esp)
  801ebd:	89 c6                	mov    %eax,%esi
  801ebf:	89 d1                	mov    %edx,%ecx
  801ec1:	39 d3                	cmp    %edx,%ebx
  801ec3:	0f 82 87 00 00 00    	jb     801f50 <__umoddi3+0x134>
  801ec9:	0f 84 91 00 00 00    	je     801f60 <__umoddi3+0x144>
  801ecf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ed3:	29 f2                	sub    %esi,%edx
  801ed5:	19 cb                	sbb    %ecx,%ebx
  801ed7:	89 d8                	mov    %ebx,%eax
  801ed9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801edd:	d3 e0                	shl    %cl,%eax
  801edf:	89 e9                	mov    %ebp,%ecx
  801ee1:	d3 ea                	shr    %cl,%edx
  801ee3:	09 d0                	or     %edx,%eax
  801ee5:	89 e9                	mov    %ebp,%ecx
  801ee7:	d3 eb                	shr    %cl,%ebx
  801ee9:	89 da                	mov    %ebx,%edx
  801eeb:	83 c4 1c             	add    $0x1c,%esp
  801eee:	5b                   	pop    %ebx
  801eef:	5e                   	pop    %esi
  801ef0:	5f                   	pop    %edi
  801ef1:	5d                   	pop    %ebp
  801ef2:	c3                   	ret    
  801ef3:	90                   	nop
  801ef4:	89 fd                	mov    %edi,%ebp
  801ef6:	85 ff                	test   %edi,%edi
  801ef8:	75 0b                	jne    801f05 <__umoddi3+0xe9>
  801efa:	b8 01 00 00 00       	mov    $0x1,%eax
  801eff:	31 d2                	xor    %edx,%edx
  801f01:	f7 f7                	div    %edi
  801f03:	89 c5                	mov    %eax,%ebp
  801f05:	89 f0                	mov    %esi,%eax
  801f07:	31 d2                	xor    %edx,%edx
  801f09:	f7 f5                	div    %ebp
  801f0b:	89 c8                	mov    %ecx,%eax
  801f0d:	f7 f5                	div    %ebp
  801f0f:	89 d0                	mov    %edx,%eax
  801f11:	e9 44 ff ff ff       	jmp    801e5a <__umoddi3+0x3e>
  801f16:	66 90                	xchg   %ax,%ax
  801f18:	89 c8                	mov    %ecx,%eax
  801f1a:	89 f2                	mov    %esi,%edx
  801f1c:	83 c4 1c             	add    $0x1c,%esp
  801f1f:	5b                   	pop    %ebx
  801f20:	5e                   	pop    %esi
  801f21:	5f                   	pop    %edi
  801f22:	5d                   	pop    %ebp
  801f23:	c3                   	ret    
  801f24:	3b 04 24             	cmp    (%esp),%eax
  801f27:	72 06                	jb     801f2f <__umoddi3+0x113>
  801f29:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f2d:	77 0f                	ja     801f3e <__umoddi3+0x122>
  801f2f:	89 f2                	mov    %esi,%edx
  801f31:	29 f9                	sub    %edi,%ecx
  801f33:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f37:	89 14 24             	mov    %edx,(%esp)
  801f3a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f3e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f42:	8b 14 24             	mov    (%esp),%edx
  801f45:	83 c4 1c             	add    $0x1c,%esp
  801f48:	5b                   	pop    %ebx
  801f49:	5e                   	pop    %esi
  801f4a:	5f                   	pop    %edi
  801f4b:	5d                   	pop    %ebp
  801f4c:	c3                   	ret    
  801f4d:	8d 76 00             	lea    0x0(%esi),%esi
  801f50:	2b 04 24             	sub    (%esp),%eax
  801f53:	19 fa                	sbb    %edi,%edx
  801f55:	89 d1                	mov    %edx,%ecx
  801f57:	89 c6                	mov    %eax,%esi
  801f59:	e9 71 ff ff ff       	jmp    801ecf <__umoddi3+0xb3>
  801f5e:	66 90                	xchg   %ax,%ax
  801f60:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f64:	72 ea                	jb     801f50 <__umoddi3+0x134>
  801f66:	89 d9                	mov    %ebx,%ecx
  801f68:	e9 62 ff ff ff       	jmp    801ecf <__umoddi3+0xb3>
