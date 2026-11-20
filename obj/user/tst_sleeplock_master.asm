
obj/user/tst_sleeplock_master:     file format elf32-i386


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
  800031:	e8 6c 02 00 00       	call   8002a2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#define __AUTOGRADE__ 1
extern volatile bool printStats ;

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
  800051:	68 60 1f 80 00       	push   $0x801f60
  800056:	6a 0e                	push   $0xe
  800058:	e8 a0 07 00 00       	call   8007fd <cprintf_colored>
  80005d:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  800060:	83 ec 08             	sub    $0x8,%esp
  800063:	68 90 1f 80 00       	push   $0x801f90
  800068:	6a 0e                	push   $0xe
  80006a:	e8 8e 07 00 00       	call   8007fd <cprintf_colored>
  80006f:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_yellow,"==============================================\n");
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 60 1f 80 00       	push   $0x801f60
  80007a:	6a 0e                	push   $0xe
  80007c:	e8 7c 07 00 00       	call   8007fd <cprintf_colored>
  800081:	83 c4 10             	add    $0x10,%esp

	int envID = sys_getenvid();
  800084:	e8 fa 18 00 00       	call   801983 <sys_getenvid>
  800089:	89 45 dc             	mov    %eax,-0x24(%ebp)
	char slavesCnt[10];
#if __AUTOGRADE__
	int numOfSlaves = 7 ;
  80008c:	c7 45 c8 07 00 00 00 	movl   $0x7,-0x38(%ebp)
	cprintf("Enter the number of Slave Programs: %d\n", numOfSlaves);
  800093:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	50                   	push   %eax
  80009a:	68 ec 1f 80 00       	push   $0x801fec
  80009f:	e8 2c 07 00 00       	call   8007d0 <cprintf>
  8000a4:	83 c4 10             	add    $0x10,%esp
#else
	readline("Enter the number of Slave Programs: ", slavesCnt);
	int numOfSlaves = strtol(slavesCnt, NULL, 10);
#endif
	//Save number of slaved to be checked later
	char cmd1[64] = "__NumOfSlaves@Set";
  8000a7:	8d 45 88             	lea    -0x78(%ebp),%eax
  8000aa:	bb 88 21 80 00       	mov    $0x802188,%ebx
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
  8000d5:	e8 c2 1a 00 00       	call   801b9c <sys_utilities>
  8000da:	83 c4 10             	add    $0x10,%esp

	rsttst();
  8000dd:	e8 62 19 00 00       	call   801a44 <rsttst>

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  8000e2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8000e9:	eb 68                	jmp    800153 <_main+0x11b>
	{
		id = sys_create_env("tstSleepLockSlave", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f0:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8000f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8000fb:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  800101:	a1 20 30 80 00       	mov    0x803020,%eax
  800106:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  80010c:	51                   	push   %ecx
  80010d:	52                   	push   %edx
  80010e:	50                   	push   %eax
  80010f:	68 14 20 80 00       	push   $0x802014
  800114:	e8 15 18 00 00       	call   80192e <sys_create_env>
  800119:	83 c4 10             	add    $0x10,%esp
  80011c:	89 45 d8             	mov    %eax,-0x28(%ebp)
		if (id== E_ENV_CREATION_ERROR)
  80011f:	83 7d d8 ee          	cmpl   $0xffffffee,-0x28(%ebp)
  800123:	75 1d                	jne    800142 <_main+0x10a>
		{
			cprintf_colored(TEXT_TESTERR_CLR,"\n%~insufficient number of processes in the system! only %d slave processes are created\n", i);
  800125:	83 ec 04             	sub    $0x4,%esp
  800128:	ff 75 e4             	pushl  -0x1c(%ebp)
  80012b:	68 28 20 80 00       	push   $0x802028
  800130:	6a 0c                	push   $0xc
  800132:	e8 c6 06 00 00       	call   8007fd <cprintf_colored>
  800137:	83 c4 10             	add    $0x10,%esp
			numOfSlaves = i;
  80013a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80013d:	89 45 c8             	mov    %eax,-0x38(%ebp)
			break;
  800140:	eb 19                	jmp    80015b <_main+0x123>
		}
		sys_run_env(id);
  800142:	83 ec 0c             	sub    $0xc,%esp
  800145:	ff 75 d8             	pushl  -0x28(%ebp)
  800148:	e8 ff 17 00 00       	call   80194c <sys_run_env>
  80014d:	83 c4 10             	add    $0x10,%esp

	rsttst();

	//Create and run slave programs that should sleep
	int id;
	for (int i = 0; i < numOfSlaves; ++i)
  800150:	ff 45 e4             	incl   -0x1c(%ebp)
  800153:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800156:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  800159:	7c 90                	jl     8000eb <_main+0xb3>
		}
		sys_run_env(id);
	}

	//Wait until all slaves, except the one inside C.S., are blocked
	int numOfBlockedProcesses = 0;
  80015b:	c7 45 84 00 00 00 00 	movl   $0x0,-0x7c(%ebp)
	char cmd2[64] = "__GetLockQueueSize__";
  800162:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  800168:	bb c8 21 80 00       	mov    $0x8021c8,%ebx
  80016d:	ba 15 00 00 00       	mov    $0x15,%edx
  800172:	89 c7                	mov    %eax,%edi
  800174:	89 de                	mov    %ebx,%esi
  800176:	89 d1                	mov    %edx,%ecx
  800178:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80017a:	8d 95 59 ff ff ff    	lea    -0xa7(%ebp),%edx
  800180:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  800185:	b0 00                	mov    $0x0,%al
  800187:	89 d7                	mov    %edx,%edi
  800189:	f3 aa                	rep stos %al,%es:(%edi)
	sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
  80018b:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80018e:	83 ec 08             	sub    $0x8,%esp
  800191:	50                   	push   %eax
  800192:	8d 85 44 ff ff ff    	lea    -0xbc(%ebp),%eax
  800198:	50                   	push   %eax
  800199:	e8 fe 19 00 00       	call   801b9c <sys_utilities>
  80019e:	83 c4 10             	add    $0x10,%esp
	int cnt = 0;
  8001a1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	while (numOfBlockedProcesses != numOfSlaves-1)
  8001a8:	eb 77                	jmp    800221 <_main+0x1e9>
	{
		env_sleep(5000);
  8001aa:	83 ec 0c             	sub    $0xc,%esp
  8001ad:	68 88 13 00 00       	push   $0x1388
  8001b2:	e8 71 1a 00 00       	call   801c28 <env_sleep>
  8001b7:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  8001ba:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001bd:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  8001c0:	75 1d                	jne    8001df <_main+0x1a7>
		{
			panic("%~test sleeplock failed! unexpected number of blocked slaves. Expected = %d, Current = %d", numOfSlaves-1, numOfBlockedProcesses);
  8001c2:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8001c5:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8001c8:	4a                   	dec    %edx
  8001c9:	83 ec 0c             	sub    $0xc,%esp
  8001cc:	50                   	push   %eax
  8001cd:	52                   	push   %edx
  8001ce:	68 80 20 80 00       	push   $0x802080
  8001d3:	6a 37                	push   $0x37
  8001d5:	68 da 20 80 00       	push   $0x8020da
  8001da:	e8 23 03 00 00       	call   800502 <_panic>
		}
		char cmd3[64] = "__GetLockQueueSize__";
  8001df:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  8001e5:	bb c8 21 80 00       	mov    $0x8021c8,%ebx
  8001ea:	ba 15 00 00 00       	mov    $0x15,%edx
  8001ef:	89 c7                	mov    %eax,%edi
  8001f1:	89 de                	mov    %ebx,%esi
  8001f3:	89 d1                	mov    %edx,%ecx
  8001f5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001f7:	8d 95 19 ff ff ff    	lea    -0xe7(%ebp),%edx
  8001fd:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  800202:	b0 00                	mov    $0x0,%al
  800204:	89 d7                	mov    %edx,%edi
  800206:	f3 aa                	rep stos %al,%es:(%edi)
		sys_utilities(cmd3, (uint32)(&numOfBlockedProcesses));
  800208:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80020b:	83 ec 08             	sub    $0x8,%esp
  80020e:	50                   	push   %eax
  80020f:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
  800215:	50                   	push   %eax
  800216:	e8 81 19 00 00       	call   801b9c <sys_utilities>
  80021b:	83 c4 10             	add    $0x10,%esp
		cnt++ ;
  80021e:	ff 45 e0             	incl   -0x20(%ebp)
	//Wait until all slaves, except the one inside C.S., are blocked
	int numOfBlockedProcesses = 0;
	char cmd2[64] = "__GetLockQueueSize__";
	sys_utilities(cmd2, (uint32)(&numOfBlockedProcesses));
	int cnt = 0;
	while (numOfBlockedProcesses != numOfSlaves-1)
  800221:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800224:	8d 50 ff             	lea    -0x1(%eax),%edx
  800227:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80022a:	39 c2                	cmp    %eax,%edx
  80022c:	0f 85 78 ff ff ff    	jne    8001aa <_main+0x172>
		cnt++ ;
	}
	//cprintf("\numOfBlockedProcesses = %d\n", numOfBlockedProcesses);

	//signal the slave inside the critical section to leave it
	inctst();
  800232:	e8 6d 18 00 00       	call   801aa4 <inctst>

	//Wait until all slave finished
	cnt = 0;
  800237:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	while (gettst() != numOfSlaves +1/*since master already increment it by 1*/)
  80023e:	eb 3a                	jmp    80027a <_main+0x242>
	{
		env_sleep(15000);
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	68 98 3a 00 00       	push   $0x3a98
  800248:	e8 db 19 00 00       	call   801c28 <env_sleep>
  80024d:	83 c4 10             	add    $0x10,%esp
		if (cnt == numOfSlaves)
  800250:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800253:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  800256:	75 1f                	jne    800277 <_main+0x23f>
		{
			panic("%~test sleeplock failed! not all processes finished. Expected %d, Actual %d", numOfSlaves +1, gettst());
  800258:	e8 61 18 00 00       	call   801abe <gettst>
  80025d:	8b 55 c8             	mov    -0x38(%ebp),%edx
  800260:	42                   	inc    %edx
  800261:	83 ec 0c             	sub    $0xc,%esp
  800264:	50                   	push   %eax
  800265:	52                   	push   %edx
  800266:	68 f8 20 80 00       	push   $0x8020f8
  80026b:	6a 49                	push   $0x49
  80026d:	68 da 20 80 00       	push   $0x8020da
  800272:	e8 8b 02 00 00       	call   800502 <_panic>
		}
		cnt++ ;
  800277:	ff 45 e0             	incl   -0x20(%ebp)
	//signal the slave inside the critical section to leave it
	inctst();

	//Wait until all slave finished
	cnt = 0;
	while (gettst() != numOfSlaves +1/*since master already increment it by 1*/)
  80027a:	e8 3f 18 00 00       	call   801abe <gettst>
  80027f:	8b 55 c8             	mov    -0x38(%ebp),%edx
  800282:	42                   	inc    %edx
  800283:	39 d0                	cmp    %edx,%eax
  800285:	75 b9                	jne    800240 <_main+0x208>
			panic("%~test sleeplock failed! not all processes finished. Expected %d, Actual %d", numOfSlaves +1, gettst());
		}
		cnt++ ;
	}

	cprintf_colored(TEXT_light_green, "%~\n\nCongratulations!! Test of Sleep Lock completed successfully!!\n\n");
  800287:	83 ec 08             	sub    $0x8,%esp
  80028a:	68 44 21 80 00       	push   $0x802144
  80028f:	6a 0a                	push   $0xa
  800291:	e8 67 05 00 00       	call   8007fd <cprintf_colored>
  800296:	83 c4 10             	add    $0x10,%esp
}
  800299:	90                   	nop
  80029a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80029d:	5b                   	pop    %ebx
  80029e:	5e                   	pop    %esi
  80029f:	5f                   	pop    %edi
  8002a0:	5d                   	pop    %ebp
  8002a1:	c3                   	ret    

008002a2 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8002a2:	55                   	push   %ebp
  8002a3:	89 e5                	mov    %esp,%ebp
  8002a5:	57                   	push   %edi
  8002a6:	56                   	push   %esi
  8002a7:	53                   	push   %ebx
  8002a8:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8002ae:	e8 e9 16 00 00       	call   80199c <sys_getenvindex>
  8002b3:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8002b6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002b9:	89 d0                	mov    %edx,%eax
  8002bb:	c1 e0 03             	shl    $0x3,%eax
  8002be:	01 d0                	add    %edx,%eax
  8002c0:	c1 e0 06             	shl    $0x6,%eax
  8002c3:	01 d0                	add    %edx,%eax
  8002c5:	c1 e0 03             	shl    $0x3,%eax
  8002c8:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8002cd:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d7:	8a 40 10             	mov    0x10(%eax),%al
  8002da:	84 c0                	test   %al,%al
  8002dc:	74 0d                	je     8002eb <libmain+0x49>
		binaryname = myEnv->prog_name;
  8002de:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e3:	83 c0 10             	add    $0x10,%eax
  8002e6:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8002eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8002ef:	7e 0a                	jle    8002fb <libmain+0x59>
		binaryname = argv[0];
  8002f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f4:	8b 00                	mov    (%eax),%eax
  8002f6:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8002fb:	83 ec 08             	sub    $0x8,%esp
  8002fe:	ff 75 0c             	pushl  0xc(%ebp)
  800301:	ff 75 08             	pushl  0x8(%ebp)
  800304:	e8 2f fd ff ff       	call   800038 <_main>
  800309:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80030c:	a1 00 30 80 00       	mov    0x803000,%eax
  800311:	85 c0                	test   %eax,%eax
  800313:	0f 84 b7 01 00 00    	je     8004d0 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800319:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80031f:	bb 44 23 80 00       	mov    $0x802344,%ebx
  800324:	ba 0e 00 00 00       	mov    $0xe,%edx
  800329:	89 c7                	mov    %eax,%edi
  80032b:	89 de                	mov    %ebx,%esi
  80032d:	89 d1                	mov    %edx,%ecx
  80032f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800331:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800337:	b9 56 00 00 00       	mov    $0x56,%ecx
  80033c:	b0 00                	mov    $0x0,%al
  80033e:	89 d7                	mov    %edx,%edi
  800340:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800342:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800349:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80034c:	83 ec 08             	sub    $0x8,%esp
  80034f:	50                   	push   %eax
  800350:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800356:	50                   	push   %eax
  800357:	e8 40 18 00 00       	call   801b9c <sys_utilities>
  80035c:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  80035f:	e8 c0 13 00 00       	call   801724 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800364:	83 ec 0c             	sub    $0xc,%esp
  800367:	68 20 22 80 00       	push   $0x802220
  80036c:	e8 5f 04 00 00       	call   8007d0 <cprintf>
  800371:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800374:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800377:	85 c0                	test   %eax,%eax
  800379:	74 58                	je     8003d3 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80037b:	e8 3a 18 00 00       	call   801bba <sys_get_optimal_num_faults>
  800380:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800383:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800389:	bb a8 23 80 00       	mov    $0x8023a8,%ebx
  80038e:	ba 11 00 00 00       	mov    $0x11,%edx
  800393:	89 c7                	mov    %eax,%edi
  800395:	89 de                	mov    %ebx,%esi
  800397:	89 d1                	mov    %edx,%ecx
  800399:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80039b:	8d 55 85             	lea    -0x7b(%ebp),%edx
  80039e:	b9 53 00 00 00       	mov    $0x53,%ecx
  8003a3:	b0 00                	mov    $0x0,%al
  8003a5:	89 d7                	mov    %edx,%edi
  8003a7:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8003a9:	83 ec 08             	sub    $0x8,%esp
  8003ac:	ff 75 dc             	pushl  -0x24(%ebp)
  8003af:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003b5:	50                   	push   %eax
  8003b6:	e8 e1 17 00 00       	call   801b9c <sys_utilities>
  8003bb:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8003be:	83 ec 08             	sub    $0x8,%esp
  8003c1:	ff 75 dc             	pushl  -0x24(%ebp)
  8003c4:	68 48 22 80 00       	push   $0x802248
  8003c9:	e8 02 04 00 00       	call   8007d0 <cprintf>
  8003ce:	83 c4 10             	add    $0x10,%esp
  8003d1:	eb 59                	jmp    80042c <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d8:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8003de:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e3:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8003e9:	83 ec 04             	sub    $0x4,%esp
  8003ec:	52                   	push   %edx
  8003ed:	50                   	push   %eax
  8003ee:	68 6c 22 80 00       	push   $0x80226c
  8003f3:	e8 d8 03 00 00       	call   8007d0 <cprintf>
  8003f8:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  8003fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800400:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800406:	a1 20 30 80 00       	mov    0x803020,%eax
  80040b:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800411:	a1 20 30 80 00       	mov    0x803020,%eax
  800416:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80041c:	51                   	push   %ecx
  80041d:	52                   	push   %edx
  80041e:	50                   	push   %eax
  80041f:	68 94 22 80 00       	push   $0x802294
  800424:	e8 a7 03 00 00       	call   8007d0 <cprintf>
  800429:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80042c:	a1 20 30 80 00       	mov    0x803020,%eax
  800431:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800437:	83 ec 08             	sub    $0x8,%esp
  80043a:	50                   	push   %eax
  80043b:	68 ec 22 80 00       	push   $0x8022ec
  800440:	e8 8b 03 00 00       	call   8007d0 <cprintf>
  800445:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800448:	83 ec 0c             	sub    $0xc,%esp
  80044b:	68 00 23 80 00       	push   $0x802300
  800450:	e8 7b 03 00 00       	call   8007d0 <cprintf>
  800455:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800458:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80045f:	eb 28                	jmp    800489 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800461:	a1 20 30 80 00       	mov    0x803020,%eax
  800466:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800469:	81 c2 74 04 00 00    	add    $0x474,%edx
  80046f:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800472:	83 ec 04             	sub    $0x4,%esp
  800475:	50                   	push   %eax
  800476:	ff 75 e4             	pushl  -0x1c(%ebp)
  800479:	68 17 23 80 00       	push   $0x802317
  80047e:	e8 4d 03 00 00       	call   8007d0 <cprintf>
  800483:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800486:	ff 45 e4             	incl   -0x1c(%ebp)
  800489:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  80048d:	7e d2                	jle    800461 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  80048f:	83 ec 0c             	sub    $0xc,%esp
  800492:	68 26 23 80 00       	push   $0x802326
  800497:	e8 34 03 00 00       	call   8007d0 <cprintf>
  80049c:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  80049f:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a4:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8004aa:	83 ec 08             	sub    $0x8,%esp
  8004ad:	50                   	push   %eax
  8004ae:	68 2a 23 80 00       	push   $0x80232a
  8004b3:	e8 18 03 00 00       	call   8007d0 <cprintf>
  8004b8:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8004bb:	83 ec 0c             	sub    $0xc,%esp
  8004be:	68 20 22 80 00       	push   $0x802220
  8004c3:	e8 08 03 00 00       	call   8007d0 <cprintf>
  8004c8:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8004cb:	e8 6e 12 00 00       	call   80173e <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8004d0:	e8 1f 00 00 00       	call   8004f4 <exit>
}
  8004d5:	90                   	nop
  8004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8004d9:	5b                   	pop    %ebx
  8004da:	5e                   	pop    %esi
  8004db:	5f                   	pop    %edi
  8004dc:	5d                   	pop    %ebp
  8004dd:	c3                   	ret    

008004de <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004de:	55                   	push   %ebp
  8004df:	89 e5                	mov    %esp,%ebp
  8004e1:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8004e4:	83 ec 0c             	sub    $0xc,%esp
  8004e7:	6a 00                	push   $0x0
  8004e9:	e8 7a 14 00 00       	call   801968 <sys_destroy_env>
  8004ee:	83 c4 10             	add    $0x10,%esp
}
  8004f1:	90                   	nop
  8004f2:	c9                   	leave  
  8004f3:	c3                   	ret    

008004f4 <exit>:

void
exit(void)
{
  8004f4:	55                   	push   %ebp
  8004f5:	89 e5                	mov    %esp,%ebp
  8004f7:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  8004fa:	e8 cf 14 00 00       	call   8019ce <sys_exit_env>
}
  8004ff:	90                   	nop
  800500:	c9                   	leave  
  800501:	c3                   	ret    

00800502 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800502:	55                   	push   %ebp
  800503:	89 e5                	mov    %esp,%ebp
  800505:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800508:	8d 45 10             	lea    0x10(%ebp),%eax
  80050b:	83 c0 04             	add    $0x4,%eax
  80050e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800511:	a1 28 31 80 00       	mov    0x803128,%eax
  800516:	85 c0                	test   %eax,%eax
  800518:	74 16                	je     800530 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80051a:	a1 28 31 80 00       	mov    0x803128,%eax
  80051f:	83 ec 08             	sub    $0x8,%esp
  800522:	50                   	push   %eax
  800523:	68 0c 24 80 00       	push   $0x80240c
  800528:	e8 a3 02 00 00       	call   8007d0 <cprintf>
  80052d:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800530:	a1 04 30 80 00       	mov    0x803004,%eax
  800535:	83 ec 0c             	sub    $0xc,%esp
  800538:	ff 75 0c             	pushl  0xc(%ebp)
  80053b:	ff 75 08             	pushl  0x8(%ebp)
  80053e:	50                   	push   %eax
  80053f:	68 14 24 80 00       	push   $0x802414
  800544:	6a 74                	push   $0x74
  800546:	e8 b2 02 00 00       	call   8007fd <cprintf_colored>
  80054b:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  80054e:	8b 45 10             	mov    0x10(%ebp),%eax
  800551:	83 ec 08             	sub    $0x8,%esp
  800554:	ff 75 f4             	pushl  -0xc(%ebp)
  800557:	50                   	push   %eax
  800558:	e8 04 02 00 00       	call   800761 <vcprintf>
  80055d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800560:	83 ec 08             	sub    $0x8,%esp
  800563:	6a 00                	push   $0x0
  800565:	68 3c 24 80 00       	push   $0x80243c
  80056a:	e8 f2 01 00 00       	call   800761 <vcprintf>
  80056f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800572:	e8 7d ff ff ff       	call   8004f4 <exit>

	// should not return here
	while (1) ;
  800577:	eb fe                	jmp    800577 <_panic+0x75>

00800579 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800579:	55                   	push   %ebp
  80057a:	89 e5                	mov    %esp,%ebp
  80057c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80057f:	a1 20 30 80 00       	mov    0x803020,%eax
  800584:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  80058a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058d:	39 c2                	cmp    %eax,%edx
  80058f:	74 14                	je     8005a5 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800591:	83 ec 04             	sub    $0x4,%esp
  800594:	68 40 24 80 00       	push   $0x802440
  800599:	6a 26                	push   $0x26
  80059b:	68 8c 24 80 00       	push   $0x80248c
  8005a0:	e8 5d ff ff ff       	call   800502 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8005a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005b3:	e9 c5 00 00 00       	jmp    80067d <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8005b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005bb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c5:	01 d0                	add    %edx,%eax
  8005c7:	8b 00                	mov    (%eax),%eax
  8005c9:	85 c0                	test   %eax,%eax
  8005cb:	75 08                	jne    8005d5 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8005cd:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005d0:	e9 a5 00 00 00       	jmp    80067a <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8005d5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005dc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005e3:	eb 69                	jmp    80064e <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8005e5:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ea:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8005f0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005f3:	89 d0                	mov    %edx,%eax
  8005f5:	01 c0                	add    %eax,%eax
  8005f7:	01 d0                	add    %edx,%eax
  8005f9:	c1 e0 03             	shl    $0x3,%eax
  8005fc:	01 c8                	add    %ecx,%eax
  8005fe:	8a 40 04             	mov    0x4(%eax),%al
  800601:	84 c0                	test   %al,%al
  800603:	75 46                	jne    80064b <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800605:	a1 20 30 80 00       	mov    0x803020,%eax
  80060a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800610:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800613:	89 d0                	mov    %edx,%eax
  800615:	01 c0                	add    %eax,%eax
  800617:	01 d0                	add    %edx,%eax
  800619:	c1 e0 03             	shl    $0x3,%eax
  80061c:	01 c8                	add    %ecx,%eax
  80061e:	8b 00                	mov    (%eax),%eax
  800620:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800623:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800626:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80062b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80062d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800630:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800637:	8b 45 08             	mov    0x8(%ebp),%eax
  80063a:	01 c8                	add    %ecx,%eax
  80063c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80063e:	39 c2                	cmp    %eax,%edx
  800640:	75 09                	jne    80064b <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  800642:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800649:	eb 15                	jmp    800660 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80064b:	ff 45 e8             	incl   -0x18(%ebp)
  80064e:	a1 20 30 80 00       	mov    0x803020,%eax
  800653:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800659:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80065c:	39 c2                	cmp    %eax,%edx
  80065e:	77 85                	ja     8005e5 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800660:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800664:	75 14                	jne    80067a <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  800666:	83 ec 04             	sub    $0x4,%esp
  800669:	68 98 24 80 00       	push   $0x802498
  80066e:	6a 3a                	push   $0x3a
  800670:	68 8c 24 80 00       	push   $0x80248c
  800675:	e8 88 fe ff ff       	call   800502 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80067a:	ff 45 f0             	incl   -0x10(%ebp)
  80067d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800680:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800683:	0f 8c 2f ff ff ff    	jl     8005b8 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800689:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800690:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800697:	eb 26                	jmp    8006bf <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800699:	a1 20 30 80 00       	mov    0x803020,%eax
  80069e:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8006a4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006a7:	89 d0                	mov    %edx,%eax
  8006a9:	01 c0                	add    %eax,%eax
  8006ab:	01 d0                	add    %edx,%eax
  8006ad:	c1 e0 03             	shl    $0x3,%eax
  8006b0:	01 c8                	add    %ecx,%eax
  8006b2:	8a 40 04             	mov    0x4(%eax),%al
  8006b5:	3c 01                	cmp    $0x1,%al
  8006b7:	75 03                	jne    8006bc <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8006b9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006bc:	ff 45 e0             	incl   -0x20(%ebp)
  8006bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8006ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006cd:	39 c2                	cmp    %eax,%edx
  8006cf:	77 c8                	ja     800699 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006d4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006d7:	74 14                	je     8006ed <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8006d9:	83 ec 04             	sub    $0x4,%esp
  8006dc:	68 ec 24 80 00       	push   $0x8024ec
  8006e1:	6a 44                	push   $0x44
  8006e3:	68 8c 24 80 00       	push   $0x80248c
  8006e8:	e8 15 fe ff ff       	call   800502 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006ed:	90                   	nop
  8006ee:	c9                   	leave  
  8006ef:	c3                   	ret    

008006f0 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8006f0:	55                   	push   %ebp
  8006f1:	89 e5                	mov    %esp,%ebp
  8006f3:	53                   	push   %ebx
  8006f4:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  8006f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006fa:	8b 00                	mov    (%eax),%eax
  8006fc:	8d 48 01             	lea    0x1(%eax),%ecx
  8006ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800702:	89 0a                	mov    %ecx,(%edx)
  800704:	8b 55 08             	mov    0x8(%ebp),%edx
  800707:	88 d1                	mov    %dl,%cl
  800709:	8b 55 0c             	mov    0xc(%ebp),%edx
  80070c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800710:	8b 45 0c             	mov    0xc(%ebp),%eax
  800713:	8b 00                	mov    (%eax),%eax
  800715:	3d ff 00 00 00       	cmp    $0xff,%eax
  80071a:	75 30                	jne    80074c <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  80071c:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  800722:	a0 40 30 80 00       	mov    0x803040,%al
  800727:	0f b6 c0             	movzbl %al,%eax
  80072a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80072d:	8b 09                	mov    (%ecx),%ecx
  80072f:	89 cb                	mov    %ecx,%ebx
  800731:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800734:	83 c1 08             	add    $0x8,%ecx
  800737:	52                   	push   %edx
  800738:	50                   	push   %eax
  800739:	53                   	push   %ebx
  80073a:	51                   	push   %ecx
  80073b:	e8 a0 0f 00 00       	call   8016e0 <sys_cputs>
  800740:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800743:	8b 45 0c             	mov    0xc(%ebp),%eax
  800746:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80074c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80074f:	8b 40 04             	mov    0x4(%eax),%eax
  800752:	8d 50 01             	lea    0x1(%eax),%edx
  800755:	8b 45 0c             	mov    0xc(%ebp),%eax
  800758:	89 50 04             	mov    %edx,0x4(%eax)
}
  80075b:	90                   	nop
  80075c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80075f:	c9                   	leave  
  800760:	c3                   	ret    

00800761 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800761:	55                   	push   %ebp
  800762:	89 e5                	mov    %esp,%ebp
  800764:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80076a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800771:	00 00 00 
	b.cnt = 0;
  800774:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80077b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80077e:	ff 75 0c             	pushl  0xc(%ebp)
  800781:	ff 75 08             	pushl  0x8(%ebp)
  800784:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80078a:	50                   	push   %eax
  80078b:	68 f0 06 80 00       	push   $0x8006f0
  800790:	e8 5a 02 00 00       	call   8009ef <vprintfmt>
  800795:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800798:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80079e:	a0 40 30 80 00       	mov    0x803040,%al
  8007a3:	0f b6 c0             	movzbl %al,%eax
  8007a6:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8007ac:	52                   	push   %edx
  8007ad:	50                   	push   %eax
  8007ae:	51                   	push   %ecx
  8007af:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007b5:	83 c0 08             	add    $0x8,%eax
  8007b8:	50                   	push   %eax
  8007b9:	e8 22 0f 00 00       	call   8016e0 <sys_cputs>
  8007be:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007c1:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8007c8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007ce:	c9                   	leave  
  8007cf:	c3                   	ret    

008007d0 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8007d0:	55                   	push   %ebp
  8007d1:	89 e5                	mov    %esp,%ebp
  8007d3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007d6:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8007dd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e6:	83 ec 08             	sub    $0x8,%esp
  8007e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ec:	50                   	push   %eax
  8007ed:	e8 6f ff ff ff       	call   800761 <vcprintf>
  8007f2:	83 c4 10             	add    $0x10,%esp
  8007f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007fb:	c9                   	leave  
  8007fc:	c3                   	ret    

008007fd <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  8007fd:	55                   	push   %ebp
  8007fe:	89 e5                	mov    %esp,%ebp
  800800:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800803:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  80080a:	8b 45 08             	mov    0x8(%ebp),%eax
  80080d:	c1 e0 08             	shl    $0x8,%eax
  800810:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  800815:	8d 45 0c             	lea    0xc(%ebp),%eax
  800818:	83 c0 04             	add    $0x4,%eax
  80081b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80081e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800821:	83 ec 08             	sub    $0x8,%esp
  800824:	ff 75 f4             	pushl  -0xc(%ebp)
  800827:	50                   	push   %eax
  800828:	e8 34 ff ff ff       	call   800761 <vcprintf>
  80082d:	83 c4 10             	add    $0x10,%esp
  800830:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800833:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  80083a:	07 00 00 

	return cnt;
  80083d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800840:	c9                   	leave  
  800841:	c3                   	ret    

00800842 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800842:	55                   	push   %ebp
  800843:	89 e5                	mov    %esp,%ebp
  800845:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800848:	e8 d7 0e 00 00       	call   801724 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  80084d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800850:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800853:	8b 45 08             	mov    0x8(%ebp),%eax
  800856:	83 ec 08             	sub    $0x8,%esp
  800859:	ff 75 f4             	pushl  -0xc(%ebp)
  80085c:	50                   	push   %eax
  80085d:	e8 ff fe ff ff       	call   800761 <vcprintf>
  800862:	83 c4 10             	add    $0x10,%esp
  800865:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800868:	e8 d1 0e 00 00       	call   80173e <sys_unlock_cons>
	return cnt;
  80086d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800870:	c9                   	leave  
  800871:	c3                   	ret    

00800872 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800872:	55                   	push   %ebp
  800873:	89 e5                	mov    %esp,%ebp
  800875:	53                   	push   %ebx
  800876:	83 ec 14             	sub    $0x14,%esp
  800879:	8b 45 10             	mov    0x10(%ebp),%eax
  80087c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80087f:	8b 45 14             	mov    0x14(%ebp),%eax
  800882:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800885:	8b 45 18             	mov    0x18(%ebp),%eax
  800888:	ba 00 00 00 00       	mov    $0x0,%edx
  80088d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800890:	77 55                	ja     8008e7 <printnum+0x75>
  800892:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800895:	72 05                	jb     80089c <printnum+0x2a>
  800897:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80089a:	77 4b                	ja     8008e7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80089c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80089f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8008a2:	8b 45 18             	mov    0x18(%ebp),%eax
  8008a5:	ba 00 00 00 00       	mov    $0x0,%edx
  8008aa:	52                   	push   %edx
  8008ab:	50                   	push   %eax
  8008ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8008af:	ff 75 f0             	pushl  -0x10(%ebp)
  8008b2:	e8 31 14 00 00       	call   801ce8 <__udivdi3>
  8008b7:	83 c4 10             	add    $0x10,%esp
  8008ba:	83 ec 04             	sub    $0x4,%esp
  8008bd:	ff 75 20             	pushl  0x20(%ebp)
  8008c0:	53                   	push   %ebx
  8008c1:	ff 75 18             	pushl  0x18(%ebp)
  8008c4:	52                   	push   %edx
  8008c5:	50                   	push   %eax
  8008c6:	ff 75 0c             	pushl  0xc(%ebp)
  8008c9:	ff 75 08             	pushl  0x8(%ebp)
  8008cc:	e8 a1 ff ff ff       	call   800872 <printnum>
  8008d1:	83 c4 20             	add    $0x20,%esp
  8008d4:	eb 1a                	jmp    8008f0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008d6:	83 ec 08             	sub    $0x8,%esp
  8008d9:	ff 75 0c             	pushl  0xc(%ebp)
  8008dc:	ff 75 20             	pushl  0x20(%ebp)
  8008df:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e2:	ff d0                	call   *%eax
  8008e4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008e7:	ff 4d 1c             	decl   0x1c(%ebp)
  8008ea:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008ee:	7f e6                	jg     8008d6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008f0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008f3:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008fe:	53                   	push   %ebx
  8008ff:	51                   	push   %ecx
  800900:	52                   	push   %edx
  800901:	50                   	push   %eax
  800902:	e8 f1 14 00 00       	call   801df8 <__umoddi3>
  800907:	83 c4 10             	add    $0x10,%esp
  80090a:	05 54 27 80 00       	add    $0x802754,%eax
  80090f:	8a 00                	mov    (%eax),%al
  800911:	0f be c0             	movsbl %al,%eax
  800914:	83 ec 08             	sub    $0x8,%esp
  800917:	ff 75 0c             	pushl  0xc(%ebp)
  80091a:	50                   	push   %eax
  80091b:	8b 45 08             	mov    0x8(%ebp),%eax
  80091e:	ff d0                	call   *%eax
  800920:	83 c4 10             	add    $0x10,%esp
}
  800923:	90                   	nop
  800924:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800927:	c9                   	leave  
  800928:	c3                   	ret    

00800929 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800929:	55                   	push   %ebp
  80092a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80092c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800930:	7e 1c                	jle    80094e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800932:	8b 45 08             	mov    0x8(%ebp),%eax
  800935:	8b 00                	mov    (%eax),%eax
  800937:	8d 50 08             	lea    0x8(%eax),%edx
  80093a:	8b 45 08             	mov    0x8(%ebp),%eax
  80093d:	89 10                	mov    %edx,(%eax)
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	8b 00                	mov    (%eax),%eax
  800944:	83 e8 08             	sub    $0x8,%eax
  800947:	8b 50 04             	mov    0x4(%eax),%edx
  80094a:	8b 00                	mov    (%eax),%eax
  80094c:	eb 40                	jmp    80098e <getuint+0x65>
	else if (lflag)
  80094e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800952:	74 1e                	je     800972 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800954:	8b 45 08             	mov    0x8(%ebp),%eax
  800957:	8b 00                	mov    (%eax),%eax
  800959:	8d 50 04             	lea    0x4(%eax),%edx
  80095c:	8b 45 08             	mov    0x8(%ebp),%eax
  80095f:	89 10                	mov    %edx,(%eax)
  800961:	8b 45 08             	mov    0x8(%ebp),%eax
  800964:	8b 00                	mov    (%eax),%eax
  800966:	83 e8 04             	sub    $0x4,%eax
  800969:	8b 00                	mov    (%eax),%eax
  80096b:	ba 00 00 00 00       	mov    $0x0,%edx
  800970:	eb 1c                	jmp    80098e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800972:	8b 45 08             	mov    0x8(%ebp),%eax
  800975:	8b 00                	mov    (%eax),%eax
  800977:	8d 50 04             	lea    0x4(%eax),%edx
  80097a:	8b 45 08             	mov    0x8(%ebp),%eax
  80097d:	89 10                	mov    %edx,(%eax)
  80097f:	8b 45 08             	mov    0x8(%ebp),%eax
  800982:	8b 00                	mov    (%eax),%eax
  800984:	83 e8 04             	sub    $0x4,%eax
  800987:	8b 00                	mov    (%eax),%eax
  800989:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80098e:	5d                   	pop    %ebp
  80098f:	c3                   	ret    

00800990 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800990:	55                   	push   %ebp
  800991:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800993:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800997:	7e 1c                	jle    8009b5 <getint+0x25>
		return va_arg(*ap, long long);
  800999:	8b 45 08             	mov    0x8(%ebp),%eax
  80099c:	8b 00                	mov    (%eax),%eax
  80099e:	8d 50 08             	lea    0x8(%eax),%edx
  8009a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a4:	89 10                	mov    %edx,(%eax)
  8009a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a9:	8b 00                	mov    (%eax),%eax
  8009ab:	83 e8 08             	sub    $0x8,%eax
  8009ae:	8b 50 04             	mov    0x4(%eax),%edx
  8009b1:	8b 00                	mov    (%eax),%eax
  8009b3:	eb 38                	jmp    8009ed <getint+0x5d>
	else if (lflag)
  8009b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009b9:	74 1a                	je     8009d5 <getint+0x45>
		return va_arg(*ap, long);
  8009bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009be:	8b 00                	mov    (%eax),%eax
  8009c0:	8d 50 04             	lea    0x4(%eax),%edx
  8009c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c6:	89 10                	mov    %edx,(%eax)
  8009c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cb:	8b 00                	mov    (%eax),%eax
  8009cd:	83 e8 04             	sub    $0x4,%eax
  8009d0:	8b 00                	mov    (%eax),%eax
  8009d2:	99                   	cltd   
  8009d3:	eb 18                	jmp    8009ed <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d8:	8b 00                	mov    (%eax),%eax
  8009da:	8d 50 04             	lea    0x4(%eax),%edx
  8009dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e0:	89 10                	mov    %edx,(%eax)
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	8b 00                	mov    (%eax),%eax
  8009e7:	83 e8 04             	sub    $0x4,%eax
  8009ea:	8b 00                	mov    (%eax),%eax
  8009ec:	99                   	cltd   
}
  8009ed:	5d                   	pop    %ebp
  8009ee:	c3                   	ret    

008009ef <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009ef:	55                   	push   %ebp
  8009f0:	89 e5                	mov    %esp,%ebp
  8009f2:	56                   	push   %esi
  8009f3:	53                   	push   %ebx
  8009f4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009f7:	eb 17                	jmp    800a10 <vprintfmt+0x21>
			if (ch == '\0')
  8009f9:	85 db                	test   %ebx,%ebx
  8009fb:	0f 84 c1 03 00 00    	je     800dc2 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800a01:	83 ec 08             	sub    $0x8,%esp
  800a04:	ff 75 0c             	pushl  0xc(%ebp)
  800a07:	53                   	push   %ebx
  800a08:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0b:	ff d0                	call   *%eax
  800a0d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a10:	8b 45 10             	mov    0x10(%ebp),%eax
  800a13:	8d 50 01             	lea    0x1(%eax),%edx
  800a16:	89 55 10             	mov    %edx,0x10(%ebp)
  800a19:	8a 00                	mov    (%eax),%al
  800a1b:	0f b6 d8             	movzbl %al,%ebx
  800a1e:	83 fb 25             	cmp    $0x25,%ebx
  800a21:	75 d6                	jne    8009f9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a23:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a27:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a2e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a35:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a3c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a43:	8b 45 10             	mov    0x10(%ebp),%eax
  800a46:	8d 50 01             	lea    0x1(%eax),%edx
  800a49:	89 55 10             	mov    %edx,0x10(%ebp)
  800a4c:	8a 00                	mov    (%eax),%al
  800a4e:	0f b6 d8             	movzbl %al,%ebx
  800a51:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a54:	83 f8 5b             	cmp    $0x5b,%eax
  800a57:	0f 87 3d 03 00 00    	ja     800d9a <vprintfmt+0x3ab>
  800a5d:	8b 04 85 78 27 80 00 	mov    0x802778(,%eax,4),%eax
  800a64:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a66:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a6a:	eb d7                	jmp    800a43 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a6c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a70:	eb d1                	jmp    800a43 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a72:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a79:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a7c:	89 d0                	mov    %edx,%eax
  800a7e:	c1 e0 02             	shl    $0x2,%eax
  800a81:	01 d0                	add    %edx,%eax
  800a83:	01 c0                	add    %eax,%eax
  800a85:	01 d8                	add    %ebx,%eax
  800a87:	83 e8 30             	sub    $0x30,%eax
  800a8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800a90:	8a 00                	mov    (%eax),%al
  800a92:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a95:	83 fb 2f             	cmp    $0x2f,%ebx
  800a98:	7e 3e                	jle    800ad8 <vprintfmt+0xe9>
  800a9a:	83 fb 39             	cmp    $0x39,%ebx
  800a9d:	7f 39                	jg     800ad8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a9f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800aa2:	eb d5                	jmp    800a79 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800aa4:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa7:	83 c0 04             	add    $0x4,%eax
  800aaa:	89 45 14             	mov    %eax,0x14(%ebp)
  800aad:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab0:	83 e8 04             	sub    $0x4,%eax
  800ab3:	8b 00                	mov    (%eax),%eax
  800ab5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ab8:	eb 1f                	jmp    800ad9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800aba:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800abe:	79 83                	jns    800a43 <vprintfmt+0x54>
				width = 0;
  800ac0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ac7:	e9 77 ff ff ff       	jmp    800a43 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800acc:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ad3:	e9 6b ff ff ff       	jmp    800a43 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ad8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ad9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800add:	0f 89 60 ff ff ff    	jns    800a43 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ae3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ae6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ae9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800af0:	e9 4e ff ff ff       	jmp    800a43 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800af5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800af8:	e9 46 ff ff ff       	jmp    800a43 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800afd:	8b 45 14             	mov    0x14(%ebp),%eax
  800b00:	83 c0 04             	add    $0x4,%eax
  800b03:	89 45 14             	mov    %eax,0x14(%ebp)
  800b06:	8b 45 14             	mov    0x14(%ebp),%eax
  800b09:	83 e8 04             	sub    $0x4,%eax
  800b0c:	8b 00                	mov    (%eax),%eax
  800b0e:	83 ec 08             	sub    $0x8,%esp
  800b11:	ff 75 0c             	pushl  0xc(%ebp)
  800b14:	50                   	push   %eax
  800b15:	8b 45 08             	mov    0x8(%ebp),%eax
  800b18:	ff d0                	call   *%eax
  800b1a:	83 c4 10             	add    $0x10,%esp
			break;
  800b1d:	e9 9b 02 00 00       	jmp    800dbd <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b22:	8b 45 14             	mov    0x14(%ebp),%eax
  800b25:	83 c0 04             	add    $0x4,%eax
  800b28:	89 45 14             	mov    %eax,0x14(%ebp)
  800b2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800b2e:	83 e8 04             	sub    $0x4,%eax
  800b31:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b33:	85 db                	test   %ebx,%ebx
  800b35:	79 02                	jns    800b39 <vprintfmt+0x14a>
				err = -err;
  800b37:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b39:	83 fb 64             	cmp    $0x64,%ebx
  800b3c:	7f 0b                	jg     800b49 <vprintfmt+0x15a>
  800b3e:	8b 34 9d c0 25 80 00 	mov    0x8025c0(,%ebx,4),%esi
  800b45:	85 f6                	test   %esi,%esi
  800b47:	75 19                	jne    800b62 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b49:	53                   	push   %ebx
  800b4a:	68 65 27 80 00       	push   $0x802765
  800b4f:	ff 75 0c             	pushl  0xc(%ebp)
  800b52:	ff 75 08             	pushl  0x8(%ebp)
  800b55:	e8 70 02 00 00       	call   800dca <printfmt>
  800b5a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b5d:	e9 5b 02 00 00       	jmp    800dbd <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b62:	56                   	push   %esi
  800b63:	68 6e 27 80 00       	push   $0x80276e
  800b68:	ff 75 0c             	pushl  0xc(%ebp)
  800b6b:	ff 75 08             	pushl  0x8(%ebp)
  800b6e:	e8 57 02 00 00       	call   800dca <printfmt>
  800b73:	83 c4 10             	add    $0x10,%esp
			break;
  800b76:	e9 42 02 00 00       	jmp    800dbd <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b7b:	8b 45 14             	mov    0x14(%ebp),%eax
  800b7e:	83 c0 04             	add    $0x4,%eax
  800b81:	89 45 14             	mov    %eax,0x14(%ebp)
  800b84:	8b 45 14             	mov    0x14(%ebp),%eax
  800b87:	83 e8 04             	sub    $0x4,%eax
  800b8a:	8b 30                	mov    (%eax),%esi
  800b8c:	85 f6                	test   %esi,%esi
  800b8e:	75 05                	jne    800b95 <vprintfmt+0x1a6>
				p = "(null)";
  800b90:	be 71 27 80 00       	mov    $0x802771,%esi
			if (width > 0 && padc != '-')
  800b95:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b99:	7e 6d                	jle    800c08 <vprintfmt+0x219>
  800b9b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b9f:	74 67                	je     800c08 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800ba1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ba4:	83 ec 08             	sub    $0x8,%esp
  800ba7:	50                   	push   %eax
  800ba8:	56                   	push   %esi
  800ba9:	e8 1e 03 00 00       	call   800ecc <strnlen>
  800bae:	83 c4 10             	add    $0x10,%esp
  800bb1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800bb4:	eb 16                	jmp    800bcc <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bb6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bba:	83 ec 08             	sub    $0x8,%esp
  800bbd:	ff 75 0c             	pushl  0xc(%ebp)
  800bc0:	50                   	push   %eax
  800bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc4:	ff d0                	call   *%eax
  800bc6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800bc9:	ff 4d e4             	decl   -0x1c(%ebp)
  800bcc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bd0:	7f e4                	jg     800bb6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bd2:	eb 34                	jmp    800c08 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bd4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bd8:	74 1c                	je     800bf6 <vprintfmt+0x207>
  800bda:	83 fb 1f             	cmp    $0x1f,%ebx
  800bdd:	7e 05                	jle    800be4 <vprintfmt+0x1f5>
  800bdf:	83 fb 7e             	cmp    $0x7e,%ebx
  800be2:	7e 12                	jle    800bf6 <vprintfmt+0x207>
					putch('?', putdat);
  800be4:	83 ec 08             	sub    $0x8,%esp
  800be7:	ff 75 0c             	pushl  0xc(%ebp)
  800bea:	6a 3f                	push   $0x3f
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
  800bef:	ff d0                	call   *%eax
  800bf1:	83 c4 10             	add    $0x10,%esp
  800bf4:	eb 0f                	jmp    800c05 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800bf6:	83 ec 08             	sub    $0x8,%esp
  800bf9:	ff 75 0c             	pushl  0xc(%ebp)
  800bfc:	53                   	push   %ebx
  800bfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800c00:	ff d0                	call   *%eax
  800c02:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c05:	ff 4d e4             	decl   -0x1c(%ebp)
  800c08:	89 f0                	mov    %esi,%eax
  800c0a:	8d 70 01             	lea    0x1(%eax),%esi
  800c0d:	8a 00                	mov    (%eax),%al
  800c0f:	0f be d8             	movsbl %al,%ebx
  800c12:	85 db                	test   %ebx,%ebx
  800c14:	74 24                	je     800c3a <vprintfmt+0x24b>
  800c16:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c1a:	78 b8                	js     800bd4 <vprintfmt+0x1e5>
  800c1c:	ff 4d e0             	decl   -0x20(%ebp)
  800c1f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c23:	79 af                	jns    800bd4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c25:	eb 13                	jmp    800c3a <vprintfmt+0x24b>
				putch(' ', putdat);
  800c27:	83 ec 08             	sub    $0x8,%esp
  800c2a:	ff 75 0c             	pushl  0xc(%ebp)
  800c2d:	6a 20                	push   $0x20
  800c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c32:	ff d0                	call   *%eax
  800c34:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c37:	ff 4d e4             	decl   -0x1c(%ebp)
  800c3a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c3e:	7f e7                	jg     800c27 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c40:	e9 78 01 00 00       	jmp    800dbd <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c45:	83 ec 08             	sub    $0x8,%esp
  800c48:	ff 75 e8             	pushl  -0x18(%ebp)
  800c4b:	8d 45 14             	lea    0x14(%ebp),%eax
  800c4e:	50                   	push   %eax
  800c4f:	e8 3c fd ff ff       	call   800990 <getint>
  800c54:	83 c4 10             	add    $0x10,%esp
  800c57:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c5a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c60:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c63:	85 d2                	test   %edx,%edx
  800c65:	79 23                	jns    800c8a <vprintfmt+0x29b>
				putch('-', putdat);
  800c67:	83 ec 08             	sub    $0x8,%esp
  800c6a:	ff 75 0c             	pushl  0xc(%ebp)
  800c6d:	6a 2d                	push   $0x2d
  800c6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c72:	ff d0                	call   *%eax
  800c74:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c7d:	f7 d8                	neg    %eax
  800c7f:	83 d2 00             	adc    $0x0,%edx
  800c82:	f7 da                	neg    %edx
  800c84:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c87:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c8a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c91:	e9 bc 00 00 00       	jmp    800d52 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c96:	83 ec 08             	sub    $0x8,%esp
  800c99:	ff 75 e8             	pushl  -0x18(%ebp)
  800c9c:	8d 45 14             	lea    0x14(%ebp),%eax
  800c9f:	50                   	push   %eax
  800ca0:	e8 84 fc ff ff       	call   800929 <getuint>
  800ca5:	83 c4 10             	add    $0x10,%esp
  800ca8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800cae:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cb5:	e9 98 00 00 00       	jmp    800d52 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cba:	83 ec 08             	sub    $0x8,%esp
  800cbd:	ff 75 0c             	pushl  0xc(%ebp)
  800cc0:	6a 58                	push   $0x58
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	ff d0                	call   *%eax
  800cc7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cca:	83 ec 08             	sub    $0x8,%esp
  800ccd:	ff 75 0c             	pushl  0xc(%ebp)
  800cd0:	6a 58                	push   $0x58
  800cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd5:	ff d0                	call   *%eax
  800cd7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cda:	83 ec 08             	sub    $0x8,%esp
  800cdd:	ff 75 0c             	pushl  0xc(%ebp)
  800ce0:	6a 58                	push   $0x58
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	ff d0                	call   *%eax
  800ce7:	83 c4 10             	add    $0x10,%esp
			break;
  800cea:	e9 ce 00 00 00       	jmp    800dbd <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800cef:	83 ec 08             	sub    $0x8,%esp
  800cf2:	ff 75 0c             	pushl  0xc(%ebp)
  800cf5:	6a 30                	push   $0x30
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	ff d0                	call   *%eax
  800cfc:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cff:	83 ec 08             	sub    $0x8,%esp
  800d02:	ff 75 0c             	pushl  0xc(%ebp)
  800d05:	6a 78                	push   $0x78
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	ff d0                	call   *%eax
  800d0c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d12:	83 c0 04             	add    $0x4,%eax
  800d15:	89 45 14             	mov    %eax,0x14(%ebp)
  800d18:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1b:	83 e8 04             	sub    $0x4,%eax
  800d1e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d23:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d2a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d31:	eb 1f                	jmp    800d52 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d33:	83 ec 08             	sub    $0x8,%esp
  800d36:	ff 75 e8             	pushl  -0x18(%ebp)
  800d39:	8d 45 14             	lea    0x14(%ebp),%eax
  800d3c:	50                   	push   %eax
  800d3d:	e8 e7 fb ff ff       	call   800929 <getuint>
  800d42:	83 c4 10             	add    $0x10,%esp
  800d45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d48:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d4b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d52:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d56:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d59:	83 ec 04             	sub    $0x4,%esp
  800d5c:	52                   	push   %edx
  800d5d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d60:	50                   	push   %eax
  800d61:	ff 75 f4             	pushl  -0xc(%ebp)
  800d64:	ff 75 f0             	pushl  -0x10(%ebp)
  800d67:	ff 75 0c             	pushl  0xc(%ebp)
  800d6a:	ff 75 08             	pushl  0x8(%ebp)
  800d6d:	e8 00 fb ff ff       	call   800872 <printnum>
  800d72:	83 c4 20             	add    $0x20,%esp
			break;
  800d75:	eb 46                	jmp    800dbd <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d77:	83 ec 08             	sub    $0x8,%esp
  800d7a:	ff 75 0c             	pushl  0xc(%ebp)
  800d7d:	53                   	push   %ebx
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	ff d0                	call   *%eax
  800d83:	83 c4 10             	add    $0x10,%esp
			break;
  800d86:	eb 35                	jmp    800dbd <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800d88:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800d8f:	eb 2c                	jmp    800dbd <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800d91:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800d98:	eb 23                	jmp    800dbd <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d9a:	83 ec 08             	sub    $0x8,%esp
  800d9d:	ff 75 0c             	pushl  0xc(%ebp)
  800da0:	6a 25                	push   $0x25
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	ff d0                	call   *%eax
  800da7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800daa:	ff 4d 10             	decl   0x10(%ebp)
  800dad:	eb 03                	jmp    800db2 <vprintfmt+0x3c3>
  800daf:	ff 4d 10             	decl   0x10(%ebp)
  800db2:	8b 45 10             	mov    0x10(%ebp),%eax
  800db5:	48                   	dec    %eax
  800db6:	8a 00                	mov    (%eax),%al
  800db8:	3c 25                	cmp    $0x25,%al
  800dba:	75 f3                	jne    800daf <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800dbc:	90                   	nop
		}
	}
  800dbd:	e9 35 fc ff ff       	jmp    8009f7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800dc2:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800dc3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800dc6:	5b                   	pop    %ebx
  800dc7:	5e                   	pop    %esi
  800dc8:	5d                   	pop    %ebp
  800dc9:	c3                   	ret    

00800dca <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800dca:	55                   	push   %ebp
  800dcb:	89 e5                	mov    %esp,%ebp
  800dcd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800dd0:	8d 45 10             	lea    0x10(%ebp),%eax
  800dd3:	83 c0 04             	add    $0x4,%eax
  800dd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800dd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddc:	ff 75 f4             	pushl  -0xc(%ebp)
  800ddf:	50                   	push   %eax
  800de0:	ff 75 0c             	pushl  0xc(%ebp)
  800de3:	ff 75 08             	pushl  0x8(%ebp)
  800de6:	e8 04 fc ff ff       	call   8009ef <vprintfmt>
  800deb:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800dee:	90                   	nop
  800def:	c9                   	leave  
  800df0:	c3                   	ret    

00800df1 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800df1:	55                   	push   %ebp
  800df2:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800df4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df7:	8b 40 08             	mov    0x8(%eax),%eax
  800dfa:	8d 50 01             	lea    0x1(%eax),%edx
  800dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e00:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e06:	8b 10                	mov    (%eax),%edx
  800e08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0b:	8b 40 04             	mov    0x4(%eax),%eax
  800e0e:	39 c2                	cmp    %eax,%edx
  800e10:	73 12                	jae    800e24 <sprintputch+0x33>
		*b->buf++ = ch;
  800e12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e15:	8b 00                	mov    (%eax),%eax
  800e17:	8d 48 01             	lea    0x1(%eax),%ecx
  800e1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e1d:	89 0a                	mov    %ecx,(%edx)
  800e1f:	8b 55 08             	mov    0x8(%ebp),%edx
  800e22:	88 10                	mov    %dl,(%eax)
}
  800e24:	90                   	nop
  800e25:	5d                   	pop    %ebp
  800e26:	c3                   	ret    

00800e27 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e27:	55                   	push   %ebp
  800e28:	89 e5                	mov    %esp,%ebp
  800e2a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e30:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e36:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	01 d0                	add    %edx,%eax
  800e3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e48:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e4c:	74 06                	je     800e54 <vsnprintf+0x2d>
  800e4e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e52:	7f 07                	jg     800e5b <vsnprintf+0x34>
		return -E_INVAL;
  800e54:	b8 03 00 00 00       	mov    $0x3,%eax
  800e59:	eb 20                	jmp    800e7b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e5b:	ff 75 14             	pushl  0x14(%ebp)
  800e5e:	ff 75 10             	pushl  0x10(%ebp)
  800e61:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e64:	50                   	push   %eax
  800e65:	68 f1 0d 80 00       	push   $0x800df1
  800e6a:	e8 80 fb ff ff       	call   8009ef <vprintfmt>
  800e6f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e72:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e75:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e78:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e7b:	c9                   	leave  
  800e7c:	c3                   	ret    

00800e7d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e7d:	55                   	push   %ebp
  800e7e:	89 e5                	mov    %esp,%ebp
  800e80:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e83:	8d 45 10             	lea    0x10(%ebp),%eax
  800e86:	83 c0 04             	add    $0x4,%eax
  800e89:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8f:	ff 75 f4             	pushl  -0xc(%ebp)
  800e92:	50                   	push   %eax
  800e93:	ff 75 0c             	pushl  0xc(%ebp)
  800e96:	ff 75 08             	pushl  0x8(%ebp)
  800e99:	e8 89 ff ff ff       	call   800e27 <vsnprintf>
  800e9e:	83 c4 10             	add    $0x10,%esp
  800ea1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ea4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ea7:	c9                   	leave  
  800ea8:	c3                   	ret    

00800ea9 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ea9:	55                   	push   %ebp
  800eaa:	89 e5                	mov    %esp,%ebp
  800eac:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800eaf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eb6:	eb 06                	jmp    800ebe <strlen+0x15>
		n++;
  800eb8:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ebb:	ff 45 08             	incl   0x8(%ebp)
  800ebe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec1:	8a 00                	mov    (%eax),%al
  800ec3:	84 c0                	test   %al,%al
  800ec5:	75 f1                	jne    800eb8 <strlen+0xf>
		n++;
	return n;
  800ec7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eca:	c9                   	leave  
  800ecb:	c3                   	ret    

00800ecc <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ecc:	55                   	push   %ebp
  800ecd:	89 e5                	mov    %esp,%ebp
  800ecf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ed2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ed9:	eb 09                	jmp    800ee4 <strnlen+0x18>
		n++;
  800edb:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ede:	ff 45 08             	incl   0x8(%ebp)
  800ee1:	ff 4d 0c             	decl   0xc(%ebp)
  800ee4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ee8:	74 09                	je     800ef3 <strnlen+0x27>
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	84 c0                	test   %al,%al
  800ef1:	75 e8                	jne    800edb <strnlen+0xf>
		n++;
	return n;
  800ef3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ef6:	c9                   	leave  
  800ef7:	c3                   	ret    

00800ef8 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ef8:	55                   	push   %ebp
  800ef9:	89 e5                	mov    %esp,%ebp
  800efb:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800efe:	8b 45 08             	mov    0x8(%ebp),%eax
  800f01:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f04:	90                   	nop
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	8d 50 01             	lea    0x1(%eax),%edx
  800f0b:	89 55 08             	mov    %edx,0x8(%ebp)
  800f0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f11:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f14:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f17:	8a 12                	mov    (%edx),%dl
  800f19:	88 10                	mov    %dl,(%eax)
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	84 c0                	test   %al,%al
  800f1f:	75 e4                	jne    800f05 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f21:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f24:	c9                   	leave  
  800f25:	c3                   	ret    

00800f26 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f26:	55                   	push   %ebp
  800f27:	89 e5                	mov    %esp,%ebp
  800f29:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f32:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f39:	eb 1f                	jmp    800f5a <strncpy+0x34>
		*dst++ = *src;
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3e:	8d 50 01             	lea    0x1(%eax),%edx
  800f41:	89 55 08             	mov    %edx,0x8(%ebp)
  800f44:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f47:	8a 12                	mov    (%edx),%dl
  800f49:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4e:	8a 00                	mov    (%eax),%al
  800f50:	84 c0                	test   %al,%al
  800f52:	74 03                	je     800f57 <strncpy+0x31>
			src++;
  800f54:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f57:	ff 45 fc             	incl   -0x4(%ebp)
  800f5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f5d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f60:	72 d9                	jb     800f3b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f62:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f65:	c9                   	leave  
  800f66:	c3                   	ret    

00800f67 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f67:	55                   	push   %ebp
  800f68:	89 e5                	mov    %esp,%ebp
  800f6a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f73:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f77:	74 30                	je     800fa9 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f79:	eb 16                	jmp    800f91 <strlcpy+0x2a>
			*dst++ = *src++;
  800f7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7e:	8d 50 01             	lea    0x1(%eax),%edx
  800f81:	89 55 08             	mov    %edx,0x8(%ebp)
  800f84:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f87:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f8a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f8d:	8a 12                	mov    (%edx),%dl
  800f8f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f91:	ff 4d 10             	decl   0x10(%ebp)
  800f94:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f98:	74 09                	je     800fa3 <strlcpy+0x3c>
  800f9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9d:	8a 00                	mov    (%eax),%al
  800f9f:	84 c0                	test   %al,%al
  800fa1:	75 d8                	jne    800f7b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800fa9:	8b 55 08             	mov    0x8(%ebp),%edx
  800fac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800faf:	29 c2                	sub    %eax,%edx
  800fb1:	89 d0                	mov    %edx,%eax
}
  800fb3:	c9                   	leave  
  800fb4:	c3                   	ret    

00800fb5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fb5:	55                   	push   %ebp
  800fb6:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fb8:	eb 06                	jmp    800fc0 <strcmp+0xb>
		p++, q++;
  800fba:	ff 45 08             	incl   0x8(%ebp)
  800fbd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	84 c0                	test   %al,%al
  800fc7:	74 0e                	je     800fd7 <strcmp+0x22>
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	8a 10                	mov    (%eax),%dl
  800fce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd1:	8a 00                	mov    (%eax),%al
  800fd3:	38 c2                	cmp    %al,%dl
  800fd5:	74 e3                	je     800fba <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	0f b6 d0             	movzbl %al,%edx
  800fdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe2:	8a 00                	mov    (%eax),%al
  800fe4:	0f b6 c0             	movzbl %al,%eax
  800fe7:	29 c2                	sub    %eax,%edx
  800fe9:	89 d0                	mov    %edx,%eax
}
  800feb:	5d                   	pop    %ebp
  800fec:	c3                   	ret    

00800fed <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800fed:	55                   	push   %ebp
  800fee:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ff0:	eb 09                	jmp    800ffb <strncmp+0xe>
		n--, p++, q++;
  800ff2:	ff 4d 10             	decl   0x10(%ebp)
  800ff5:	ff 45 08             	incl   0x8(%ebp)
  800ff8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ffb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fff:	74 17                	je     801018 <strncmp+0x2b>
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
  801004:	8a 00                	mov    (%eax),%al
  801006:	84 c0                	test   %al,%al
  801008:	74 0e                	je     801018 <strncmp+0x2b>
  80100a:	8b 45 08             	mov    0x8(%ebp),%eax
  80100d:	8a 10                	mov    (%eax),%dl
  80100f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801012:	8a 00                	mov    (%eax),%al
  801014:	38 c2                	cmp    %al,%dl
  801016:	74 da                	je     800ff2 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801018:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80101c:	75 07                	jne    801025 <strncmp+0x38>
		return 0;
  80101e:	b8 00 00 00 00       	mov    $0x0,%eax
  801023:	eb 14                	jmp    801039 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	8a 00                	mov    (%eax),%al
  80102a:	0f b6 d0             	movzbl %al,%edx
  80102d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801030:	8a 00                	mov    (%eax),%al
  801032:	0f b6 c0             	movzbl %al,%eax
  801035:	29 c2                	sub    %eax,%edx
  801037:	89 d0                	mov    %edx,%eax
}
  801039:	5d                   	pop    %ebp
  80103a:	c3                   	ret    

0080103b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80103b:	55                   	push   %ebp
  80103c:	89 e5                	mov    %esp,%ebp
  80103e:	83 ec 04             	sub    $0x4,%esp
  801041:	8b 45 0c             	mov    0xc(%ebp),%eax
  801044:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801047:	eb 12                	jmp    80105b <strchr+0x20>
		if (*s == c)
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	8a 00                	mov    (%eax),%al
  80104e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801051:	75 05                	jne    801058 <strchr+0x1d>
			return (char *) s;
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	eb 11                	jmp    801069 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801058:	ff 45 08             	incl   0x8(%ebp)
  80105b:	8b 45 08             	mov    0x8(%ebp),%eax
  80105e:	8a 00                	mov    (%eax),%al
  801060:	84 c0                	test   %al,%al
  801062:	75 e5                	jne    801049 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801064:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801069:	c9                   	leave  
  80106a:	c3                   	ret    

0080106b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80106b:	55                   	push   %ebp
  80106c:	89 e5                	mov    %esp,%ebp
  80106e:	83 ec 04             	sub    $0x4,%esp
  801071:	8b 45 0c             	mov    0xc(%ebp),%eax
  801074:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801077:	eb 0d                	jmp    801086 <strfind+0x1b>
		if (*s == c)
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
  80107c:	8a 00                	mov    (%eax),%al
  80107e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801081:	74 0e                	je     801091 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801083:	ff 45 08             	incl   0x8(%ebp)
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	8a 00                	mov    (%eax),%al
  80108b:	84 c0                	test   %al,%al
  80108d:	75 ea                	jne    801079 <strfind+0xe>
  80108f:	eb 01                	jmp    801092 <strfind+0x27>
		if (*s == c)
			break;
  801091:	90                   	nop
	return (char *) s;
  801092:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801095:	c9                   	leave  
  801096:	c3                   	ret    

00801097 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801097:	55                   	push   %ebp
  801098:	89 e5                	mov    %esp,%ebp
  80109a:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  80109d:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  8010a3:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010a7:	76 63                	jbe    80110c <memset+0x75>
		uint64 data_block = c;
  8010a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ac:	99                   	cltd   
  8010ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010b0:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  8010b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b9:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  8010bd:	c1 e0 08             	shl    $0x8,%eax
  8010c0:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010c3:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  8010c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010cc:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  8010d0:	c1 e0 10             	shl    $0x10,%eax
  8010d3:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010d6:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  8010d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010df:	89 c2                	mov    %eax,%edx
  8010e1:	b8 00 00 00 00       	mov    $0x0,%eax
  8010e6:	09 45 f0             	or     %eax,-0x10(%ebp)
  8010e9:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  8010ec:	eb 18                	jmp    801106 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  8010ee:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010f1:	8d 41 08             	lea    0x8(%ecx),%eax
  8010f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  8010f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010fd:	89 01                	mov    %eax,(%ecx)
  8010ff:	89 51 04             	mov    %edx,0x4(%ecx)
  801102:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801106:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80110a:	77 e2                	ja     8010ee <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  80110c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801110:	74 23                	je     801135 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  801112:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801115:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801118:	eb 0e                	jmp    801128 <memset+0x91>
			*p8++ = (uint8)c;
  80111a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80111d:	8d 50 01             	lea    0x1(%eax),%edx
  801120:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801123:	8b 55 0c             	mov    0xc(%ebp),%edx
  801126:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801128:	8b 45 10             	mov    0x10(%ebp),%eax
  80112b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80112e:	89 55 10             	mov    %edx,0x10(%ebp)
  801131:	85 c0                	test   %eax,%eax
  801133:	75 e5                	jne    80111a <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801135:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801138:	c9                   	leave  
  801139:	c3                   	ret    

0080113a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80113a:	55                   	push   %ebp
  80113b:	89 e5                	mov    %esp,%ebp
  80113d:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  801140:	8b 45 0c             	mov    0xc(%ebp),%eax
  801143:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  80114c:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801150:	76 24                	jbe    801176 <memcpy+0x3c>
		while(n >= 8){
  801152:	eb 1c                	jmp    801170 <memcpy+0x36>
			*d64 = *s64;
  801154:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801157:	8b 50 04             	mov    0x4(%eax),%edx
  80115a:	8b 00                	mov    (%eax),%eax
  80115c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80115f:	89 01                	mov    %eax,(%ecx)
  801161:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  801164:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801168:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  80116c:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801170:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801174:	77 de                	ja     801154 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801176:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80117a:	74 31                	je     8011ad <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  80117c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80117f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801182:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801185:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  801188:	eb 16                	jmp    8011a0 <memcpy+0x66>
			*d8++ = *s8++;
  80118a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80118d:	8d 50 01             	lea    0x1(%eax),%edx
  801190:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801193:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801196:	8d 4a 01             	lea    0x1(%edx),%ecx
  801199:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80119c:	8a 12                	mov    (%edx),%dl
  80119e:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8011a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011a6:	89 55 10             	mov    %edx,0x10(%ebp)
  8011a9:	85 c0                	test   %eax,%eax
  8011ab:	75 dd                	jne    80118a <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8011ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011b0:	c9                   	leave  
  8011b1:	c3                   	ret    

008011b2 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8011b2:	55                   	push   %ebp
  8011b3:	89 e5                	mov    %esp,%ebp
  8011b5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8011c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011ca:	73 50                	jae    80121c <memmove+0x6a>
  8011cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d2:	01 d0                	add    %edx,%eax
  8011d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011d7:	76 43                	jbe    80121c <memmove+0x6a>
		s += n;
  8011d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011dc:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8011df:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8011e5:	eb 10                	jmp    8011f7 <memmove+0x45>
			*--d = *--s;
  8011e7:	ff 4d f8             	decl   -0x8(%ebp)
  8011ea:	ff 4d fc             	decl   -0x4(%ebp)
  8011ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011f0:	8a 10                	mov    (%eax),%dl
  8011f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8011f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011fd:	89 55 10             	mov    %edx,0x10(%ebp)
  801200:	85 c0                	test   %eax,%eax
  801202:	75 e3                	jne    8011e7 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801204:	eb 23                	jmp    801229 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801206:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801209:	8d 50 01             	lea    0x1(%eax),%edx
  80120c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80120f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801212:	8d 4a 01             	lea    0x1(%edx),%ecx
  801215:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801218:	8a 12                	mov    (%edx),%dl
  80121a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80121c:	8b 45 10             	mov    0x10(%ebp),%eax
  80121f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801222:	89 55 10             	mov    %edx,0x10(%ebp)
  801225:	85 c0                	test   %eax,%eax
  801227:	75 dd                	jne    801206 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801229:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80122c:	c9                   	leave  
  80122d:	c3                   	ret    

0080122e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80122e:	55                   	push   %ebp
  80122f:	89 e5                	mov    %esp,%ebp
  801231:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801234:	8b 45 08             	mov    0x8(%ebp),%eax
  801237:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80123a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801240:	eb 2a                	jmp    80126c <memcmp+0x3e>
		if (*s1 != *s2)
  801242:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801245:	8a 10                	mov    (%eax),%dl
  801247:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	38 c2                	cmp    %al,%dl
  80124e:	74 16                	je     801266 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801250:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801253:	8a 00                	mov    (%eax),%al
  801255:	0f b6 d0             	movzbl %al,%edx
  801258:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80125b:	8a 00                	mov    (%eax),%al
  80125d:	0f b6 c0             	movzbl %al,%eax
  801260:	29 c2                	sub    %eax,%edx
  801262:	89 d0                	mov    %edx,%eax
  801264:	eb 18                	jmp    80127e <memcmp+0x50>
		s1++, s2++;
  801266:	ff 45 fc             	incl   -0x4(%ebp)
  801269:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80126c:	8b 45 10             	mov    0x10(%ebp),%eax
  80126f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801272:	89 55 10             	mov    %edx,0x10(%ebp)
  801275:	85 c0                	test   %eax,%eax
  801277:	75 c9                	jne    801242 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801279:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80127e:	c9                   	leave  
  80127f:	c3                   	ret    

00801280 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801280:	55                   	push   %ebp
  801281:	89 e5                	mov    %esp,%ebp
  801283:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801286:	8b 55 08             	mov    0x8(%ebp),%edx
  801289:	8b 45 10             	mov    0x10(%ebp),%eax
  80128c:	01 d0                	add    %edx,%eax
  80128e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801291:	eb 15                	jmp    8012a8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
  801296:	8a 00                	mov    (%eax),%al
  801298:	0f b6 d0             	movzbl %al,%edx
  80129b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129e:	0f b6 c0             	movzbl %al,%eax
  8012a1:	39 c2                	cmp    %eax,%edx
  8012a3:	74 0d                	je     8012b2 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8012a5:	ff 45 08             	incl   0x8(%ebp)
  8012a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012ae:	72 e3                	jb     801293 <memfind+0x13>
  8012b0:	eb 01                	jmp    8012b3 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8012b2:	90                   	nop
	return (void *) s;
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012b6:	c9                   	leave  
  8012b7:	c3                   	ret    

008012b8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8012b8:	55                   	push   %ebp
  8012b9:	89 e5                	mov    %esp,%ebp
  8012bb:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8012be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8012c5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012cc:	eb 03                	jmp    8012d1 <strtol+0x19>
		s++;
  8012ce:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d4:	8a 00                	mov    (%eax),%al
  8012d6:	3c 20                	cmp    $0x20,%al
  8012d8:	74 f4                	je     8012ce <strtol+0x16>
  8012da:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dd:	8a 00                	mov    (%eax),%al
  8012df:	3c 09                	cmp    $0x9,%al
  8012e1:	74 eb                	je     8012ce <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8012e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e6:	8a 00                	mov    (%eax),%al
  8012e8:	3c 2b                	cmp    $0x2b,%al
  8012ea:	75 05                	jne    8012f1 <strtol+0x39>
		s++;
  8012ec:	ff 45 08             	incl   0x8(%ebp)
  8012ef:	eb 13                	jmp    801304 <strtol+0x4c>
	else if (*s == '-')
  8012f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f4:	8a 00                	mov    (%eax),%al
  8012f6:	3c 2d                	cmp    $0x2d,%al
  8012f8:	75 0a                	jne    801304 <strtol+0x4c>
		s++, neg = 1;
  8012fa:	ff 45 08             	incl   0x8(%ebp)
  8012fd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801304:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801308:	74 06                	je     801310 <strtol+0x58>
  80130a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80130e:	75 20                	jne    801330 <strtol+0x78>
  801310:	8b 45 08             	mov    0x8(%ebp),%eax
  801313:	8a 00                	mov    (%eax),%al
  801315:	3c 30                	cmp    $0x30,%al
  801317:	75 17                	jne    801330 <strtol+0x78>
  801319:	8b 45 08             	mov    0x8(%ebp),%eax
  80131c:	40                   	inc    %eax
  80131d:	8a 00                	mov    (%eax),%al
  80131f:	3c 78                	cmp    $0x78,%al
  801321:	75 0d                	jne    801330 <strtol+0x78>
		s += 2, base = 16;
  801323:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801327:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80132e:	eb 28                	jmp    801358 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801330:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801334:	75 15                	jne    80134b <strtol+0x93>
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	8a 00                	mov    (%eax),%al
  80133b:	3c 30                	cmp    $0x30,%al
  80133d:	75 0c                	jne    80134b <strtol+0x93>
		s++, base = 8;
  80133f:	ff 45 08             	incl   0x8(%ebp)
  801342:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801349:	eb 0d                	jmp    801358 <strtol+0xa0>
	else if (base == 0)
  80134b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80134f:	75 07                	jne    801358 <strtol+0xa0>
		base = 10;
  801351:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	8a 00                	mov    (%eax),%al
  80135d:	3c 2f                	cmp    $0x2f,%al
  80135f:	7e 19                	jle    80137a <strtol+0xc2>
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	8a 00                	mov    (%eax),%al
  801366:	3c 39                	cmp    $0x39,%al
  801368:	7f 10                	jg     80137a <strtol+0xc2>
			dig = *s - '0';
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	8a 00                	mov    (%eax),%al
  80136f:	0f be c0             	movsbl %al,%eax
  801372:	83 e8 30             	sub    $0x30,%eax
  801375:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801378:	eb 42                	jmp    8013bc <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80137a:	8b 45 08             	mov    0x8(%ebp),%eax
  80137d:	8a 00                	mov    (%eax),%al
  80137f:	3c 60                	cmp    $0x60,%al
  801381:	7e 19                	jle    80139c <strtol+0xe4>
  801383:	8b 45 08             	mov    0x8(%ebp),%eax
  801386:	8a 00                	mov    (%eax),%al
  801388:	3c 7a                	cmp    $0x7a,%al
  80138a:	7f 10                	jg     80139c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80138c:	8b 45 08             	mov    0x8(%ebp),%eax
  80138f:	8a 00                	mov    (%eax),%al
  801391:	0f be c0             	movsbl %al,%eax
  801394:	83 e8 57             	sub    $0x57,%eax
  801397:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80139a:	eb 20                	jmp    8013bc <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80139c:	8b 45 08             	mov    0x8(%ebp),%eax
  80139f:	8a 00                	mov    (%eax),%al
  8013a1:	3c 40                	cmp    $0x40,%al
  8013a3:	7e 39                	jle    8013de <strtol+0x126>
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	8a 00                	mov    (%eax),%al
  8013aa:	3c 5a                	cmp    $0x5a,%al
  8013ac:	7f 30                	jg     8013de <strtol+0x126>
			dig = *s - 'A' + 10;
  8013ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b1:	8a 00                	mov    (%eax),%al
  8013b3:	0f be c0             	movsbl %al,%eax
  8013b6:	83 e8 37             	sub    $0x37,%eax
  8013b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8013bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013bf:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013c2:	7d 19                	jge    8013dd <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8013c4:	ff 45 08             	incl   0x8(%ebp)
  8013c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013ca:	0f af 45 10          	imul   0x10(%ebp),%eax
  8013ce:	89 c2                	mov    %eax,%edx
  8013d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013d3:	01 d0                	add    %edx,%eax
  8013d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8013d8:	e9 7b ff ff ff       	jmp    801358 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8013dd:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8013de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013e2:	74 08                	je     8013ec <strtol+0x134>
		*endptr = (char *) s;
  8013e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8013ea:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8013ec:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013f0:	74 07                	je     8013f9 <strtol+0x141>
  8013f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013f5:	f7 d8                	neg    %eax
  8013f7:	eb 03                	jmp    8013fc <strtol+0x144>
  8013f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <ltostr>:

void
ltostr(long value, char *str)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
  801401:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801404:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80140b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801412:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801416:	79 13                	jns    80142b <ltostr+0x2d>
	{
		neg = 1;
  801418:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80141f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801422:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801425:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801428:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
  80142e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801433:	99                   	cltd   
  801434:	f7 f9                	idiv   %ecx
  801436:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801439:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80143c:	8d 50 01             	lea    0x1(%eax),%edx
  80143f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801442:	89 c2                	mov    %eax,%edx
  801444:	8b 45 0c             	mov    0xc(%ebp),%eax
  801447:	01 d0                	add    %edx,%eax
  801449:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80144c:	83 c2 30             	add    $0x30,%edx
  80144f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801451:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801454:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801459:	f7 e9                	imul   %ecx
  80145b:	c1 fa 02             	sar    $0x2,%edx
  80145e:	89 c8                	mov    %ecx,%eax
  801460:	c1 f8 1f             	sar    $0x1f,%eax
  801463:	29 c2                	sub    %eax,%edx
  801465:	89 d0                	mov    %edx,%eax
  801467:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  80146a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80146e:	75 bb                	jne    80142b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801470:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801477:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80147a:	48                   	dec    %eax
  80147b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80147e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801482:	74 3d                	je     8014c1 <ltostr+0xc3>
		start = 1 ;
  801484:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80148b:	eb 34                	jmp    8014c1 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  80148d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801490:	8b 45 0c             	mov    0xc(%ebp),%eax
  801493:	01 d0                	add    %edx,%eax
  801495:	8a 00                	mov    (%eax),%al
  801497:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80149a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80149d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a0:	01 c2                	add    %eax,%edx
  8014a2:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8014a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a8:	01 c8                	add    %ecx,%eax
  8014aa:	8a 00                	mov    (%eax),%al
  8014ac:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8014ae:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b4:	01 c2                	add    %eax,%edx
  8014b6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8014b9:	88 02                	mov    %al,(%edx)
		start++ ;
  8014bb:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8014be:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8014c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014c4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014c7:	7c c4                	jl     80148d <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014c9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014cf:	01 d0                	add    %edx,%eax
  8014d1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014d4:	90                   	nop
  8014d5:	c9                   	leave  
  8014d6:	c3                   	ret    

008014d7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8014d7:	55                   	push   %ebp
  8014d8:	89 e5                	mov    %esp,%ebp
  8014da:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8014dd:	ff 75 08             	pushl  0x8(%ebp)
  8014e0:	e8 c4 f9 ff ff       	call   800ea9 <strlen>
  8014e5:	83 c4 04             	add    $0x4,%esp
  8014e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8014eb:	ff 75 0c             	pushl  0xc(%ebp)
  8014ee:	e8 b6 f9 ff ff       	call   800ea9 <strlen>
  8014f3:	83 c4 04             	add    $0x4,%esp
  8014f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8014f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801500:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801507:	eb 17                	jmp    801520 <strcconcat+0x49>
		final[s] = str1[s] ;
  801509:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80150c:	8b 45 10             	mov    0x10(%ebp),%eax
  80150f:	01 c2                	add    %eax,%edx
  801511:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	01 c8                	add    %ecx,%eax
  801519:	8a 00                	mov    (%eax),%al
  80151b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80151d:	ff 45 fc             	incl   -0x4(%ebp)
  801520:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801523:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801526:	7c e1                	jl     801509 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801528:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80152f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801536:	eb 1f                	jmp    801557 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801538:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153b:	8d 50 01             	lea    0x1(%eax),%edx
  80153e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801541:	89 c2                	mov    %eax,%edx
  801543:	8b 45 10             	mov    0x10(%ebp),%eax
  801546:	01 c2                	add    %eax,%edx
  801548:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80154b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154e:	01 c8                	add    %ecx,%eax
  801550:	8a 00                	mov    (%eax),%al
  801552:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801554:	ff 45 f8             	incl   -0x8(%ebp)
  801557:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80155a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80155d:	7c d9                	jl     801538 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80155f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801562:	8b 45 10             	mov    0x10(%ebp),%eax
  801565:	01 d0                	add    %edx,%eax
  801567:	c6 00 00             	movb   $0x0,(%eax)
}
  80156a:	90                   	nop
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801570:	8b 45 14             	mov    0x14(%ebp),%eax
  801573:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801579:	8b 45 14             	mov    0x14(%ebp),%eax
  80157c:	8b 00                	mov    (%eax),%eax
  80157e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801585:	8b 45 10             	mov    0x10(%ebp),%eax
  801588:	01 d0                	add    %edx,%eax
  80158a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801590:	eb 0c                	jmp    80159e <strsplit+0x31>
			*string++ = 0;
  801592:	8b 45 08             	mov    0x8(%ebp),%eax
  801595:	8d 50 01             	lea    0x1(%eax),%edx
  801598:	89 55 08             	mov    %edx,0x8(%ebp)
  80159b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80159e:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a1:	8a 00                	mov    (%eax),%al
  8015a3:	84 c0                	test   %al,%al
  8015a5:	74 18                	je     8015bf <strsplit+0x52>
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	8a 00                	mov    (%eax),%al
  8015ac:	0f be c0             	movsbl %al,%eax
  8015af:	50                   	push   %eax
  8015b0:	ff 75 0c             	pushl  0xc(%ebp)
  8015b3:	e8 83 fa ff ff       	call   80103b <strchr>
  8015b8:	83 c4 08             	add    $0x8,%esp
  8015bb:	85 c0                	test   %eax,%eax
  8015bd:	75 d3                	jne    801592 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8015bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c2:	8a 00                	mov    (%eax),%al
  8015c4:	84 c0                	test   %al,%al
  8015c6:	74 5a                	je     801622 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8015cb:	8b 00                	mov    (%eax),%eax
  8015cd:	83 f8 0f             	cmp    $0xf,%eax
  8015d0:	75 07                	jne    8015d9 <strsplit+0x6c>
		{
			return 0;
  8015d2:	b8 00 00 00 00       	mov    $0x0,%eax
  8015d7:	eb 66                	jmp    80163f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8015d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8015dc:	8b 00                	mov    (%eax),%eax
  8015de:	8d 48 01             	lea    0x1(%eax),%ecx
  8015e1:	8b 55 14             	mov    0x14(%ebp),%edx
  8015e4:	89 0a                	mov    %ecx,(%edx)
  8015e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f0:	01 c2                	add    %eax,%edx
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015f7:	eb 03                	jmp    8015fc <strsplit+0x8f>
			string++;
  8015f9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ff:	8a 00                	mov    (%eax),%al
  801601:	84 c0                	test   %al,%al
  801603:	74 8b                	je     801590 <strsplit+0x23>
  801605:	8b 45 08             	mov    0x8(%ebp),%eax
  801608:	8a 00                	mov    (%eax),%al
  80160a:	0f be c0             	movsbl %al,%eax
  80160d:	50                   	push   %eax
  80160e:	ff 75 0c             	pushl  0xc(%ebp)
  801611:	e8 25 fa ff ff       	call   80103b <strchr>
  801616:	83 c4 08             	add    $0x8,%esp
  801619:	85 c0                	test   %eax,%eax
  80161b:	74 dc                	je     8015f9 <strsplit+0x8c>
			string++;
	}
  80161d:	e9 6e ff ff ff       	jmp    801590 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801622:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801623:	8b 45 14             	mov    0x14(%ebp),%eax
  801626:	8b 00                	mov    (%eax),%eax
  801628:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80162f:	8b 45 10             	mov    0x10(%ebp),%eax
  801632:	01 d0                	add    %edx,%eax
  801634:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80163a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80163f:	c9                   	leave  
  801640:	c3                   	ret    

00801641 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
  801644:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801647:	8b 45 08             	mov    0x8(%ebp),%eax
  80164a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  80164d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801654:	eb 4a                	jmp    8016a0 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801656:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801659:	8b 45 08             	mov    0x8(%ebp),%eax
  80165c:	01 c2                	add    %eax,%edx
  80165e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801661:	8b 45 0c             	mov    0xc(%ebp),%eax
  801664:	01 c8                	add    %ecx,%eax
  801666:	8a 00                	mov    (%eax),%al
  801668:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  80166a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80166d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801670:	01 d0                	add    %edx,%eax
  801672:	8a 00                	mov    (%eax),%al
  801674:	3c 40                	cmp    $0x40,%al
  801676:	7e 25                	jle    80169d <str2lower+0x5c>
  801678:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80167b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80167e:	01 d0                	add    %edx,%eax
  801680:	8a 00                	mov    (%eax),%al
  801682:	3c 5a                	cmp    $0x5a,%al
  801684:	7f 17                	jg     80169d <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801686:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801689:	8b 45 08             	mov    0x8(%ebp),%eax
  80168c:	01 d0                	add    %edx,%eax
  80168e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801691:	8b 55 08             	mov    0x8(%ebp),%edx
  801694:	01 ca                	add    %ecx,%edx
  801696:	8a 12                	mov    (%edx),%dl
  801698:	83 c2 20             	add    $0x20,%edx
  80169b:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  80169d:	ff 45 fc             	incl   -0x4(%ebp)
  8016a0:	ff 75 0c             	pushl  0xc(%ebp)
  8016a3:	e8 01 f8 ff ff       	call   800ea9 <strlen>
  8016a8:	83 c4 04             	add    $0x4,%esp
  8016ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8016ae:	7f a6                	jg     801656 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8016b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016b3:	c9                   	leave  
  8016b4:	c3                   	ret    

008016b5 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016b5:	55                   	push   %ebp
  8016b6:	89 e5                	mov    %esp,%ebp
  8016b8:	57                   	push   %edi
  8016b9:	56                   	push   %esi
  8016ba:	53                   	push   %ebx
  8016bb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016c7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016ca:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016cd:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016d0:	cd 30                	int    $0x30
  8016d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016d8:	83 c4 10             	add    $0x10,%esp
  8016db:	5b                   	pop    %ebx
  8016dc:	5e                   	pop    %esi
  8016dd:	5f                   	pop    %edi
  8016de:	5d                   	pop    %ebp
  8016df:	c3                   	ret    

008016e0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8016e0:	55                   	push   %ebp
  8016e1:	89 e5                	mov    %esp,%ebp
  8016e3:	83 ec 04             	sub    $0x4,%esp
  8016e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8016ec:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016ef:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	6a 00                	push   $0x0
  8016f8:	51                   	push   %ecx
  8016f9:	52                   	push   %edx
  8016fa:	ff 75 0c             	pushl  0xc(%ebp)
  8016fd:	50                   	push   %eax
  8016fe:	6a 00                	push   $0x0
  801700:	e8 b0 ff ff ff       	call   8016b5 <syscall>
  801705:	83 c4 18             	add    $0x18,%esp
}
  801708:	90                   	nop
  801709:	c9                   	leave  
  80170a:	c3                   	ret    

0080170b <sys_cgetc>:

int
sys_cgetc(void)
{
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 02                	push   $0x2
  80171a:	e8 96 ff ff ff       	call   8016b5 <syscall>
  80171f:	83 c4 18             	add    $0x18,%esp
}
  801722:	c9                   	leave  
  801723:	c3                   	ret    

00801724 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801724:	55                   	push   %ebp
  801725:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 03                	push   $0x3
  801733:	e8 7d ff ff ff       	call   8016b5 <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
}
  80173b:	90                   	nop
  80173c:	c9                   	leave  
  80173d:	c3                   	ret    

0080173e <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  80173e:	55                   	push   %ebp
  80173f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 04                	push   $0x4
  80174d:	e8 63 ff ff ff       	call   8016b5 <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
}
  801755:	90                   	nop
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80175b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80175e:	8b 45 08             	mov    0x8(%ebp),%eax
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	52                   	push   %edx
  801768:	50                   	push   %eax
  801769:	6a 08                	push   $0x8
  80176b:	e8 45 ff ff ff       	call   8016b5 <syscall>
  801770:	83 c4 18             	add    $0x18,%esp
}
  801773:	c9                   	leave  
  801774:	c3                   	ret    

00801775 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801775:	55                   	push   %ebp
  801776:	89 e5                	mov    %esp,%ebp
  801778:	56                   	push   %esi
  801779:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80177a:	8b 75 18             	mov    0x18(%ebp),%esi
  80177d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801780:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801783:	8b 55 0c             	mov    0xc(%ebp),%edx
  801786:	8b 45 08             	mov    0x8(%ebp),%eax
  801789:	56                   	push   %esi
  80178a:	53                   	push   %ebx
  80178b:	51                   	push   %ecx
  80178c:	52                   	push   %edx
  80178d:	50                   	push   %eax
  80178e:	6a 09                	push   $0x9
  801790:	e8 20 ff ff ff       	call   8016b5 <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
}
  801798:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80179b:	5b                   	pop    %ebx
  80179c:	5e                   	pop    %esi
  80179d:	5d                   	pop    %ebp
  80179e:	c3                   	ret    

0080179f <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80179f:	55                   	push   %ebp
  8017a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	ff 75 08             	pushl  0x8(%ebp)
  8017ad:	6a 0a                	push   $0xa
  8017af:	e8 01 ff ff ff       	call   8016b5 <syscall>
  8017b4:	83 c4 18             	add    $0x18,%esp
}
  8017b7:	c9                   	leave  
  8017b8:	c3                   	ret    

008017b9 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017b9:	55                   	push   %ebp
  8017ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	ff 75 0c             	pushl  0xc(%ebp)
  8017c5:	ff 75 08             	pushl  0x8(%ebp)
  8017c8:	6a 0b                	push   $0xb
  8017ca:	e8 e6 fe ff ff       	call   8016b5 <syscall>
  8017cf:	83 c4 18             	add    $0x18,%esp
}
  8017d2:	c9                   	leave  
  8017d3:	c3                   	ret    

008017d4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017d4:	55                   	push   %ebp
  8017d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 0c                	push   $0xc
  8017e3:	e8 cd fe ff ff       	call   8016b5 <syscall>
  8017e8:	83 c4 18             	add    $0x18,%esp
}
  8017eb:	c9                   	leave  
  8017ec:	c3                   	ret    

008017ed <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017ed:	55                   	push   %ebp
  8017ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 0d                	push   $0xd
  8017fc:	e8 b4 fe ff ff       	call   8016b5 <syscall>
  801801:	83 c4 18             	add    $0x18,%esp
}
  801804:	c9                   	leave  
  801805:	c3                   	ret    

00801806 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801806:	55                   	push   %ebp
  801807:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 0e                	push   $0xe
  801815:	e8 9b fe ff ff       	call   8016b5 <syscall>
  80181a:	83 c4 18             	add    $0x18,%esp
}
  80181d:	c9                   	leave  
  80181e:	c3                   	ret    

0080181f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80181f:	55                   	push   %ebp
  801820:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 0f                	push   $0xf
  80182e:	e8 82 fe ff ff       	call   8016b5 <syscall>
  801833:	83 c4 18             	add    $0x18,%esp
}
  801836:	c9                   	leave  
  801837:	c3                   	ret    

00801838 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801838:	55                   	push   %ebp
  801839:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	ff 75 08             	pushl  0x8(%ebp)
  801846:	6a 10                	push   $0x10
  801848:	e8 68 fe ff ff       	call   8016b5 <syscall>
  80184d:	83 c4 18             	add    $0x18,%esp
}
  801850:	c9                   	leave  
  801851:	c3                   	ret    

00801852 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801852:	55                   	push   %ebp
  801853:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 11                	push   $0x11
  801861:	e8 4f fe ff ff       	call   8016b5 <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
}
  801869:	90                   	nop
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <sys_cputc>:

void
sys_cputc(const char c)
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
  80186f:	83 ec 04             	sub    $0x4,%esp
  801872:	8b 45 08             	mov    0x8(%ebp),%eax
  801875:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801878:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	6a 00                	push   $0x0
  801884:	50                   	push   %eax
  801885:	6a 01                	push   $0x1
  801887:	e8 29 fe ff ff       	call   8016b5 <syscall>
  80188c:	83 c4 18             	add    $0x18,%esp
}
  80188f:	90                   	nop
  801890:	c9                   	leave  
  801891:	c3                   	ret    

00801892 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801892:	55                   	push   %ebp
  801893:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 14                	push   $0x14
  8018a1:	e8 0f fe ff ff       	call   8016b5 <syscall>
  8018a6:	83 c4 18             	add    $0x18,%esp
}
  8018a9:	90                   	nop
  8018aa:	c9                   	leave  
  8018ab:	c3                   	ret    

008018ac <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8018ac:	55                   	push   %ebp
  8018ad:	89 e5                	mov    %esp,%ebp
  8018af:	83 ec 04             	sub    $0x4,%esp
  8018b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8018b8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018bb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c2:	6a 00                	push   $0x0
  8018c4:	51                   	push   %ecx
  8018c5:	52                   	push   %edx
  8018c6:	ff 75 0c             	pushl  0xc(%ebp)
  8018c9:	50                   	push   %eax
  8018ca:	6a 15                	push   $0x15
  8018cc:	e8 e4 fd ff ff       	call   8016b5 <syscall>
  8018d1:	83 c4 18             	add    $0x18,%esp
}
  8018d4:	c9                   	leave  
  8018d5:	c3                   	ret    

008018d6 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8018d6:	55                   	push   %ebp
  8018d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8018d9:	8b 55 10             	mov    0x10(%ebp),%edx
  8018dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	52                   	push   %edx
  8018e4:	50                   	push   %eax
  8018e5:	ff 75 08             	pushl  0x8(%ebp)
  8018e8:	6a 16                	push   $0x16
  8018ea:	e8 c6 fd ff ff       	call   8016b5 <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
}
  8018f2:	c9                   	leave  
  8018f3:	c3                   	ret    

008018f4 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8018f4:	55                   	push   %ebp
  8018f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	52                   	push   %edx
  801904:	50                   	push   %eax
  801905:	6a 17                	push   $0x17
  801907:	e8 a9 fd ff ff       	call   8016b5 <syscall>
  80190c:	83 c4 18             	add    $0x18,%esp
}
  80190f:	c9                   	leave  
  801910:	c3                   	ret    

00801911 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801911:	55                   	push   %ebp
  801912:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801914:	8b 55 0c             	mov    0xc(%ebp),%edx
  801917:	8b 45 08             	mov    0x8(%ebp),%eax
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	52                   	push   %edx
  801921:	50                   	push   %eax
  801922:	6a 18                	push   $0x18
  801924:	e8 8c fd ff ff       	call   8016b5 <syscall>
  801929:	83 c4 18             	add    $0x18,%esp
}
  80192c:	c9                   	leave  
  80192d:	c3                   	ret    

0080192e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80192e:	55                   	push   %ebp
  80192f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801931:	8b 45 08             	mov    0x8(%ebp),%eax
  801934:	6a 00                	push   $0x0
  801936:	ff 75 14             	pushl  0x14(%ebp)
  801939:	ff 75 10             	pushl  0x10(%ebp)
  80193c:	ff 75 0c             	pushl  0xc(%ebp)
  80193f:	50                   	push   %eax
  801940:	6a 19                	push   $0x19
  801942:	e8 6e fd ff ff       	call   8016b5 <syscall>
  801947:	83 c4 18             	add    $0x18,%esp
}
  80194a:	c9                   	leave  
  80194b:	c3                   	ret    

0080194c <sys_run_env>:

void sys_run_env(int32 envId)
{
  80194c:	55                   	push   %ebp
  80194d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80194f:	8b 45 08             	mov    0x8(%ebp),%eax
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	50                   	push   %eax
  80195b:	6a 1a                	push   $0x1a
  80195d:	e8 53 fd ff ff       	call   8016b5 <syscall>
  801962:	83 c4 18             	add    $0x18,%esp
}
  801965:	90                   	nop
  801966:	c9                   	leave  
  801967:	c3                   	ret    

00801968 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801968:	55                   	push   %ebp
  801969:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  80196b:	8b 45 08             	mov    0x8(%ebp),%eax
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	50                   	push   %eax
  801977:	6a 1b                	push   $0x1b
  801979:	e8 37 fd ff ff       	call   8016b5 <syscall>
  80197e:	83 c4 18             	add    $0x18,%esp
}
  801981:	c9                   	leave  
  801982:	c3                   	ret    

00801983 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801983:	55                   	push   %ebp
  801984:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 05                	push   $0x5
  801992:	e8 1e fd ff ff       	call   8016b5 <syscall>
  801997:	83 c4 18             	add    $0x18,%esp
}
  80199a:	c9                   	leave  
  80199b:	c3                   	ret    

0080199c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80199c:	55                   	push   %ebp
  80199d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 06                	push   $0x6
  8019ab:	e8 05 fd ff ff       	call   8016b5 <syscall>
  8019b0:	83 c4 18             	add    $0x18,%esp
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 07                	push   $0x7
  8019c4:	e8 ec fc ff ff       	call   8016b5 <syscall>
  8019c9:	83 c4 18             	add    $0x18,%esp
}
  8019cc:	c9                   	leave  
  8019cd:	c3                   	ret    

008019ce <sys_exit_env>:


void sys_exit_env(void)
{
  8019ce:	55                   	push   %ebp
  8019cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 1c                	push   $0x1c
  8019dd:	e8 d3 fc ff ff       	call   8016b5 <syscall>
  8019e2:	83 c4 18             	add    $0x18,%esp
}
  8019e5:	90                   	nop
  8019e6:	c9                   	leave  
  8019e7:	c3                   	ret    

008019e8 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019e8:	55                   	push   %ebp
  8019e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	ff 75 10             	pushl  0x10(%ebp)
  8019f2:	ff 75 0c             	pushl  0xc(%ebp)
  8019f5:	ff 75 08             	pushl  0x8(%ebp)
  8019f8:	6a 13                	push   $0x13
  8019fa:	e8 b6 fc ff ff       	call   8016b5 <syscall>
  8019ff:	83 c4 18             	add    $0x18,%esp
	return ;
  801a02:	90                   	nop
}
  801a03:	c9                   	leave  
  801a04:	c3                   	ret    

00801a05 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a05:	55                   	push   %ebp
  801a06:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 00                	push   $0x0
  801a12:	6a 1e                	push   $0x1e
  801a14:	e8 9c fc ff ff       	call   8016b5 <syscall>
  801a19:	83 c4 18             	add    $0x18,%esp
}
  801a1c:	c9                   	leave  
  801a1d:	c3                   	ret    

00801a1e <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a1e:	55                   	push   %ebp
  801a1f:	89 e5                	mov    %esp,%ebp
  801a21:	83 ec 04             	sub    $0x4,%esp
  801a24:	8b 45 08             	mov    0x8(%ebp),%eax
  801a27:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a2a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	50                   	push   %eax
  801a37:	6a 1f                	push   $0x1f
  801a39:	e8 77 fc ff ff       	call   8016b5 <syscall>
  801a3e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a41:	90                   	nop
}
  801a42:	c9                   	leave  
  801a43:	c3                   	ret    

00801a44 <rsttst>:
void rsttst()
{
  801a44:	55                   	push   %ebp
  801a45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 21                	push   $0x21
  801a53:	e8 5d fc ff ff       	call   8016b5 <syscall>
  801a58:	83 c4 18             	add    $0x18,%esp
	return ;
  801a5b:	90                   	nop
}
  801a5c:	c9                   	leave  
  801a5d:	c3                   	ret    

00801a5e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a5e:	55                   	push   %ebp
  801a5f:	89 e5                	mov    %esp,%ebp
  801a61:	83 ec 04             	sub    $0x4,%esp
  801a64:	8b 45 14             	mov    0x14(%ebp),%eax
  801a67:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a6a:	8b 55 18             	mov    0x18(%ebp),%edx
  801a6d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a71:	52                   	push   %edx
  801a72:	50                   	push   %eax
  801a73:	ff 75 10             	pushl  0x10(%ebp)
  801a76:	ff 75 0c             	pushl  0xc(%ebp)
  801a79:	ff 75 08             	pushl  0x8(%ebp)
  801a7c:	6a 20                	push   $0x20
  801a7e:	e8 32 fc ff ff       	call   8016b5 <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
	return ;
  801a86:	90                   	nop
}
  801a87:	c9                   	leave  
  801a88:	c3                   	ret    

00801a89 <chktst>:
void chktst(uint32 n)
{
  801a89:	55                   	push   %ebp
  801a8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	ff 75 08             	pushl  0x8(%ebp)
  801a97:	6a 22                	push   $0x22
  801a99:	e8 17 fc ff ff       	call   8016b5 <syscall>
  801a9e:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa1:	90                   	nop
}
  801aa2:	c9                   	leave  
  801aa3:	c3                   	ret    

00801aa4 <inctst>:

void inctst()
{
  801aa4:	55                   	push   %ebp
  801aa5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	6a 00                	push   $0x0
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 23                	push   $0x23
  801ab3:	e8 fd fb ff ff       	call   8016b5 <syscall>
  801ab8:	83 c4 18             	add    $0x18,%esp
	return ;
  801abb:	90                   	nop
}
  801abc:	c9                   	leave  
  801abd:	c3                   	ret    

00801abe <gettst>:
uint32 gettst()
{
  801abe:	55                   	push   %ebp
  801abf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 24                	push   $0x24
  801acd:	e8 e3 fb ff ff       	call   8016b5 <syscall>
  801ad2:	83 c4 18             	add    $0x18,%esp
}
  801ad5:	c9                   	leave  
  801ad6:	c3                   	ret    

00801ad7 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801ad7:	55                   	push   %ebp
  801ad8:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ada:	6a 00                	push   $0x0
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 25                	push   $0x25
  801ae6:	e8 ca fb ff ff       	call   8016b5 <syscall>
  801aeb:	83 c4 18             	add    $0x18,%esp
  801aee:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  801af3:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    

00801afa <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801afd:	8b 45 08             	mov    0x8(%ebp),%eax
  801b00:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	ff 75 08             	pushl  0x8(%ebp)
  801b10:	6a 26                	push   $0x26
  801b12:	e8 9e fb ff ff       	call   8016b5 <syscall>
  801b17:	83 c4 18             	add    $0x18,%esp
	return ;
  801b1a:	90                   	nop
}
  801b1b:	c9                   	leave  
  801b1c:	c3                   	ret    

00801b1d <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b1d:	55                   	push   %ebp
  801b1e:	89 e5                	mov    %esp,%ebp
  801b20:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b21:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b24:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b27:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2d:	6a 00                	push   $0x0
  801b2f:	53                   	push   %ebx
  801b30:	51                   	push   %ecx
  801b31:	52                   	push   %edx
  801b32:	50                   	push   %eax
  801b33:	6a 27                	push   $0x27
  801b35:	e8 7b fb ff ff       	call   8016b5 <syscall>
  801b3a:	83 c4 18             	add    $0x18,%esp
}
  801b3d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b40:	c9                   	leave  
  801b41:	c3                   	ret    

00801b42 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b42:	55                   	push   %ebp
  801b43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b45:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b48:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 00                	push   $0x0
  801b51:	52                   	push   %edx
  801b52:	50                   	push   %eax
  801b53:	6a 28                	push   $0x28
  801b55:	e8 5b fb ff ff       	call   8016b5 <syscall>
  801b5a:	83 c4 18             	add    $0x18,%esp
}
  801b5d:	c9                   	leave  
  801b5e:	c3                   	ret    

00801b5f <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b5f:	55                   	push   %ebp
  801b60:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b62:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b65:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b68:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6b:	6a 00                	push   $0x0
  801b6d:	51                   	push   %ecx
  801b6e:	ff 75 10             	pushl  0x10(%ebp)
  801b71:	52                   	push   %edx
  801b72:	50                   	push   %eax
  801b73:	6a 29                	push   $0x29
  801b75:	e8 3b fb ff ff       	call   8016b5 <syscall>
  801b7a:	83 c4 18             	add    $0x18,%esp
}
  801b7d:	c9                   	leave  
  801b7e:	c3                   	ret    

00801b7f <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801b7f:	55                   	push   %ebp
  801b80:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	ff 75 10             	pushl  0x10(%ebp)
  801b89:	ff 75 0c             	pushl  0xc(%ebp)
  801b8c:	ff 75 08             	pushl  0x8(%ebp)
  801b8f:	6a 12                	push   $0x12
  801b91:	e8 1f fb ff ff       	call   8016b5 <syscall>
  801b96:	83 c4 18             	add    $0x18,%esp
	return ;
  801b99:	90                   	nop
}
  801b9a:	c9                   	leave  
  801b9b:	c3                   	ret    

00801b9c <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801b9c:	55                   	push   %ebp
  801b9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801b9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	52                   	push   %edx
  801bac:	50                   	push   %eax
  801bad:	6a 2a                	push   $0x2a
  801baf:	e8 01 fb ff ff       	call   8016b5 <syscall>
  801bb4:	83 c4 18             	add    $0x18,%esp
	return;
  801bb7:	90                   	nop
}
  801bb8:	c9                   	leave  
  801bb9:	c3                   	ret    

00801bba <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801bba:	55                   	push   %ebp
  801bbb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 2b                	push   $0x2b
  801bc9:	e8 e7 fa ff ff       	call   8016b5 <syscall>
  801bce:	83 c4 18             	add    $0x18,%esp
}
  801bd1:	c9                   	leave  
  801bd2:	c3                   	ret    

00801bd3 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801bd3:	55                   	push   %ebp
  801bd4:	89 e5                	mov    %esp,%ebp
  801bd6:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801bd9:	83 ec 04             	sub    $0x4,%esp
  801bdc:	68 e8 28 80 00       	push   $0x8028e8
  801be1:	68 0a 01 00 00       	push   $0x10a
  801be6:	68 f8 28 80 00       	push   $0x8028f8
  801beb:	e8 12 e9 ff ff       	call   800502 <_panic>

00801bf0 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801bf0:	55                   	push   %ebp
  801bf1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	ff 75 0c             	pushl  0xc(%ebp)
  801bfc:	ff 75 08             	pushl  0x8(%ebp)
  801bff:	6a 33                	push   $0x33
  801c01:	e8 af fa ff ff       	call   8016b5 <syscall>
  801c06:	83 c4 18             	add    $0x18,%esp
	return;
  801c09:	90                   	nop
}
  801c0a:	c9                   	leave  
  801c0b:	c3                   	ret    

00801c0c <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	ff 75 0c             	pushl  0xc(%ebp)
  801c18:	ff 75 08             	pushl  0x8(%ebp)
  801c1b:	6a 34                	push   $0x34
  801c1d:	e8 93 fa ff ff       	call   8016b5 <syscall>
  801c22:	83 c4 18             	add    $0x18,%esp
	return ;
  801c25:	90                   	nop
}
  801c26:	c9                   	leave  
  801c27:	c3                   	ret    

00801c28 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801c28:	55                   	push   %ebp
  801c29:	89 e5                	mov    %esp,%ebp
  801c2b:	83 ec 30             	sub    $0x30,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801c2e:	8b 55 08             	mov    0x8(%ebp),%edx
  801c31:	89 d0                	mov    %edx,%eax
  801c33:	c1 e0 02             	shl    $0x2,%eax
  801c36:	01 d0                	add    %edx,%eax
  801c38:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c3f:	01 d0                	add    %edx,%eax
  801c41:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c48:	01 d0                	add    %edx,%eax
  801c4a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c51:	01 d0                	add    %edx,%eax
  801c53:	c1 e0 04             	shl    $0x4,%eax
  801c56:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 cycles_counter =0;
  801c59:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c60:	0f 31                	rdtsc  
  801c62:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801c65:	89 55 ec             	mov    %edx,-0x14(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c68:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c6b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c71:	89 55 f4             	mov    %edx,-0xc(%ebp)

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c74:	eb 46                	jmp    801cbc <env_sleep+0x94>
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  801c76:	0f 31                	rdtsc  
  801c78:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801c7b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  801c7e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801c81:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801c84:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801c87:	89 55 e4             	mov    %edx,-0x1c(%ebp)

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801c8a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c90:	29 c2                	sub    %eax,%edx
  801c92:	89 d0                	mov    %edx,%eax
  801c94:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801c97:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c9d:	89 d1                	mov    %edx,%ecx
  801c9f:	29 c1                	sub    %eax,%ecx
  801ca1:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801ca4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ca7:	39 c2                	cmp    %eax,%edx
  801ca9:	0f 97 c0             	seta   %al
  801cac:	0f b6 c0             	movzbl %al,%eax
  801caf:	29 c1                	sub    %eax,%ecx
  801cb1:	89 c8                	mov    %ecx,%eax
  801cb3:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801cb6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801cb9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint32 cycles_counter =0;

	/*2024*/ //USE A USER-SIDE VERSION OF THIS FUNCTION TO AVOID SLOW-DOWN THE PERFORMANCE DUE SYS_CALL (el7 :))
	//struct uint64 baseTime = sys_get_virtual_time() ;
	struct uint64 baseTime = get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801cbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cbf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801cc2:	72 b2                	jb     801c76 <env_sleep+0x4e>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801cc4:	90                   	nop
  801cc5:	c9                   	leave  
  801cc6:	c3                   	ret    

00801cc7 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801cc7:	55                   	push   %ebp
  801cc8:	89 e5                	mov    %esp,%ebp
  801cca:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801ccd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801cd4:	eb 03                	jmp    801cd9 <busy_wait+0x12>
  801cd6:	ff 45 fc             	incl   -0x4(%ebp)
  801cd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cdc:	3b 45 08             	cmp    0x8(%ebp),%eax
  801cdf:	72 f5                	jb     801cd6 <busy_wait+0xf>
	return i;
  801ce1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ce4:	c9                   	leave  
  801ce5:	c3                   	ret    
  801ce6:	66 90                	xchg   %ax,%ax

00801ce8 <__udivdi3>:
  801ce8:	55                   	push   %ebp
  801ce9:	57                   	push   %edi
  801cea:	56                   	push   %esi
  801ceb:	53                   	push   %ebx
  801cec:	83 ec 1c             	sub    $0x1c,%esp
  801cef:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801cf3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801cf7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cfb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801cff:	89 ca                	mov    %ecx,%edx
  801d01:	89 f8                	mov    %edi,%eax
  801d03:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d07:	85 f6                	test   %esi,%esi
  801d09:	75 2d                	jne    801d38 <__udivdi3+0x50>
  801d0b:	39 cf                	cmp    %ecx,%edi
  801d0d:	77 65                	ja     801d74 <__udivdi3+0x8c>
  801d0f:	89 fd                	mov    %edi,%ebp
  801d11:	85 ff                	test   %edi,%edi
  801d13:	75 0b                	jne    801d20 <__udivdi3+0x38>
  801d15:	b8 01 00 00 00       	mov    $0x1,%eax
  801d1a:	31 d2                	xor    %edx,%edx
  801d1c:	f7 f7                	div    %edi
  801d1e:	89 c5                	mov    %eax,%ebp
  801d20:	31 d2                	xor    %edx,%edx
  801d22:	89 c8                	mov    %ecx,%eax
  801d24:	f7 f5                	div    %ebp
  801d26:	89 c1                	mov    %eax,%ecx
  801d28:	89 d8                	mov    %ebx,%eax
  801d2a:	f7 f5                	div    %ebp
  801d2c:	89 cf                	mov    %ecx,%edi
  801d2e:	89 fa                	mov    %edi,%edx
  801d30:	83 c4 1c             	add    $0x1c,%esp
  801d33:	5b                   	pop    %ebx
  801d34:	5e                   	pop    %esi
  801d35:	5f                   	pop    %edi
  801d36:	5d                   	pop    %ebp
  801d37:	c3                   	ret    
  801d38:	39 ce                	cmp    %ecx,%esi
  801d3a:	77 28                	ja     801d64 <__udivdi3+0x7c>
  801d3c:	0f bd fe             	bsr    %esi,%edi
  801d3f:	83 f7 1f             	xor    $0x1f,%edi
  801d42:	75 40                	jne    801d84 <__udivdi3+0x9c>
  801d44:	39 ce                	cmp    %ecx,%esi
  801d46:	72 0a                	jb     801d52 <__udivdi3+0x6a>
  801d48:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d4c:	0f 87 9e 00 00 00    	ja     801df0 <__udivdi3+0x108>
  801d52:	b8 01 00 00 00       	mov    $0x1,%eax
  801d57:	89 fa                	mov    %edi,%edx
  801d59:	83 c4 1c             	add    $0x1c,%esp
  801d5c:	5b                   	pop    %ebx
  801d5d:	5e                   	pop    %esi
  801d5e:	5f                   	pop    %edi
  801d5f:	5d                   	pop    %ebp
  801d60:	c3                   	ret    
  801d61:	8d 76 00             	lea    0x0(%esi),%esi
  801d64:	31 ff                	xor    %edi,%edi
  801d66:	31 c0                	xor    %eax,%eax
  801d68:	89 fa                	mov    %edi,%edx
  801d6a:	83 c4 1c             	add    $0x1c,%esp
  801d6d:	5b                   	pop    %ebx
  801d6e:	5e                   	pop    %esi
  801d6f:	5f                   	pop    %edi
  801d70:	5d                   	pop    %ebp
  801d71:	c3                   	ret    
  801d72:	66 90                	xchg   %ax,%ax
  801d74:	89 d8                	mov    %ebx,%eax
  801d76:	f7 f7                	div    %edi
  801d78:	31 ff                	xor    %edi,%edi
  801d7a:	89 fa                	mov    %edi,%edx
  801d7c:	83 c4 1c             	add    $0x1c,%esp
  801d7f:	5b                   	pop    %ebx
  801d80:	5e                   	pop    %esi
  801d81:	5f                   	pop    %edi
  801d82:	5d                   	pop    %ebp
  801d83:	c3                   	ret    
  801d84:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d89:	89 eb                	mov    %ebp,%ebx
  801d8b:	29 fb                	sub    %edi,%ebx
  801d8d:	89 f9                	mov    %edi,%ecx
  801d8f:	d3 e6                	shl    %cl,%esi
  801d91:	89 c5                	mov    %eax,%ebp
  801d93:	88 d9                	mov    %bl,%cl
  801d95:	d3 ed                	shr    %cl,%ebp
  801d97:	89 e9                	mov    %ebp,%ecx
  801d99:	09 f1                	or     %esi,%ecx
  801d9b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d9f:	89 f9                	mov    %edi,%ecx
  801da1:	d3 e0                	shl    %cl,%eax
  801da3:	89 c5                	mov    %eax,%ebp
  801da5:	89 d6                	mov    %edx,%esi
  801da7:	88 d9                	mov    %bl,%cl
  801da9:	d3 ee                	shr    %cl,%esi
  801dab:	89 f9                	mov    %edi,%ecx
  801dad:	d3 e2                	shl    %cl,%edx
  801daf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801db3:	88 d9                	mov    %bl,%cl
  801db5:	d3 e8                	shr    %cl,%eax
  801db7:	09 c2                	or     %eax,%edx
  801db9:	89 d0                	mov    %edx,%eax
  801dbb:	89 f2                	mov    %esi,%edx
  801dbd:	f7 74 24 0c          	divl   0xc(%esp)
  801dc1:	89 d6                	mov    %edx,%esi
  801dc3:	89 c3                	mov    %eax,%ebx
  801dc5:	f7 e5                	mul    %ebp
  801dc7:	39 d6                	cmp    %edx,%esi
  801dc9:	72 19                	jb     801de4 <__udivdi3+0xfc>
  801dcb:	74 0b                	je     801dd8 <__udivdi3+0xf0>
  801dcd:	89 d8                	mov    %ebx,%eax
  801dcf:	31 ff                	xor    %edi,%edi
  801dd1:	e9 58 ff ff ff       	jmp    801d2e <__udivdi3+0x46>
  801dd6:	66 90                	xchg   %ax,%ax
  801dd8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ddc:	89 f9                	mov    %edi,%ecx
  801dde:	d3 e2                	shl    %cl,%edx
  801de0:	39 c2                	cmp    %eax,%edx
  801de2:	73 e9                	jae    801dcd <__udivdi3+0xe5>
  801de4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801de7:	31 ff                	xor    %edi,%edi
  801de9:	e9 40 ff ff ff       	jmp    801d2e <__udivdi3+0x46>
  801dee:	66 90                	xchg   %ax,%ax
  801df0:	31 c0                	xor    %eax,%eax
  801df2:	e9 37 ff ff ff       	jmp    801d2e <__udivdi3+0x46>
  801df7:	90                   	nop

00801df8 <__umoddi3>:
  801df8:	55                   	push   %ebp
  801df9:	57                   	push   %edi
  801dfa:	56                   	push   %esi
  801dfb:	53                   	push   %ebx
  801dfc:	83 ec 1c             	sub    $0x1c,%esp
  801dff:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e03:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e07:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e0b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e0f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e13:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e17:	89 f3                	mov    %esi,%ebx
  801e19:	89 fa                	mov    %edi,%edx
  801e1b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e1f:	89 34 24             	mov    %esi,(%esp)
  801e22:	85 c0                	test   %eax,%eax
  801e24:	75 1a                	jne    801e40 <__umoddi3+0x48>
  801e26:	39 f7                	cmp    %esi,%edi
  801e28:	0f 86 a2 00 00 00    	jbe    801ed0 <__umoddi3+0xd8>
  801e2e:	89 c8                	mov    %ecx,%eax
  801e30:	89 f2                	mov    %esi,%edx
  801e32:	f7 f7                	div    %edi
  801e34:	89 d0                	mov    %edx,%eax
  801e36:	31 d2                	xor    %edx,%edx
  801e38:	83 c4 1c             	add    $0x1c,%esp
  801e3b:	5b                   	pop    %ebx
  801e3c:	5e                   	pop    %esi
  801e3d:	5f                   	pop    %edi
  801e3e:	5d                   	pop    %ebp
  801e3f:	c3                   	ret    
  801e40:	39 f0                	cmp    %esi,%eax
  801e42:	0f 87 ac 00 00 00    	ja     801ef4 <__umoddi3+0xfc>
  801e48:	0f bd e8             	bsr    %eax,%ebp
  801e4b:	83 f5 1f             	xor    $0x1f,%ebp
  801e4e:	0f 84 ac 00 00 00    	je     801f00 <__umoddi3+0x108>
  801e54:	bf 20 00 00 00       	mov    $0x20,%edi
  801e59:	29 ef                	sub    %ebp,%edi
  801e5b:	89 fe                	mov    %edi,%esi
  801e5d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e61:	89 e9                	mov    %ebp,%ecx
  801e63:	d3 e0                	shl    %cl,%eax
  801e65:	89 d7                	mov    %edx,%edi
  801e67:	89 f1                	mov    %esi,%ecx
  801e69:	d3 ef                	shr    %cl,%edi
  801e6b:	09 c7                	or     %eax,%edi
  801e6d:	89 e9                	mov    %ebp,%ecx
  801e6f:	d3 e2                	shl    %cl,%edx
  801e71:	89 14 24             	mov    %edx,(%esp)
  801e74:	89 d8                	mov    %ebx,%eax
  801e76:	d3 e0                	shl    %cl,%eax
  801e78:	89 c2                	mov    %eax,%edx
  801e7a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e7e:	d3 e0                	shl    %cl,%eax
  801e80:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e84:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e88:	89 f1                	mov    %esi,%ecx
  801e8a:	d3 e8                	shr    %cl,%eax
  801e8c:	09 d0                	or     %edx,%eax
  801e8e:	d3 eb                	shr    %cl,%ebx
  801e90:	89 da                	mov    %ebx,%edx
  801e92:	f7 f7                	div    %edi
  801e94:	89 d3                	mov    %edx,%ebx
  801e96:	f7 24 24             	mull   (%esp)
  801e99:	89 c6                	mov    %eax,%esi
  801e9b:	89 d1                	mov    %edx,%ecx
  801e9d:	39 d3                	cmp    %edx,%ebx
  801e9f:	0f 82 87 00 00 00    	jb     801f2c <__umoddi3+0x134>
  801ea5:	0f 84 91 00 00 00    	je     801f3c <__umoddi3+0x144>
  801eab:	8b 54 24 04          	mov    0x4(%esp),%edx
  801eaf:	29 f2                	sub    %esi,%edx
  801eb1:	19 cb                	sbb    %ecx,%ebx
  801eb3:	89 d8                	mov    %ebx,%eax
  801eb5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801eb9:	d3 e0                	shl    %cl,%eax
  801ebb:	89 e9                	mov    %ebp,%ecx
  801ebd:	d3 ea                	shr    %cl,%edx
  801ebf:	09 d0                	or     %edx,%eax
  801ec1:	89 e9                	mov    %ebp,%ecx
  801ec3:	d3 eb                	shr    %cl,%ebx
  801ec5:	89 da                	mov    %ebx,%edx
  801ec7:	83 c4 1c             	add    $0x1c,%esp
  801eca:	5b                   	pop    %ebx
  801ecb:	5e                   	pop    %esi
  801ecc:	5f                   	pop    %edi
  801ecd:	5d                   	pop    %ebp
  801ece:	c3                   	ret    
  801ecf:	90                   	nop
  801ed0:	89 fd                	mov    %edi,%ebp
  801ed2:	85 ff                	test   %edi,%edi
  801ed4:	75 0b                	jne    801ee1 <__umoddi3+0xe9>
  801ed6:	b8 01 00 00 00       	mov    $0x1,%eax
  801edb:	31 d2                	xor    %edx,%edx
  801edd:	f7 f7                	div    %edi
  801edf:	89 c5                	mov    %eax,%ebp
  801ee1:	89 f0                	mov    %esi,%eax
  801ee3:	31 d2                	xor    %edx,%edx
  801ee5:	f7 f5                	div    %ebp
  801ee7:	89 c8                	mov    %ecx,%eax
  801ee9:	f7 f5                	div    %ebp
  801eeb:	89 d0                	mov    %edx,%eax
  801eed:	e9 44 ff ff ff       	jmp    801e36 <__umoddi3+0x3e>
  801ef2:	66 90                	xchg   %ax,%ax
  801ef4:	89 c8                	mov    %ecx,%eax
  801ef6:	89 f2                	mov    %esi,%edx
  801ef8:	83 c4 1c             	add    $0x1c,%esp
  801efb:	5b                   	pop    %ebx
  801efc:	5e                   	pop    %esi
  801efd:	5f                   	pop    %edi
  801efe:	5d                   	pop    %ebp
  801eff:	c3                   	ret    
  801f00:	3b 04 24             	cmp    (%esp),%eax
  801f03:	72 06                	jb     801f0b <__umoddi3+0x113>
  801f05:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f09:	77 0f                	ja     801f1a <__umoddi3+0x122>
  801f0b:	89 f2                	mov    %esi,%edx
  801f0d:	29 f9                	sub    %edi,%ecx
  801f0f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f13:	89 14 24             	mov    %edx,(%esp)
  801f16:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f1a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f1e:	8b 14 24             	mov    (%esp),%edx
  801f21:	83 c4 1c             	add    $0x1c,%esp
  801f24:	5b                   	pop    %ebx
  801f25:	5e                   	pop    %esi
  801f26:	5f                   	pop    %edi
  801f27:	5d                   	pop    %ebp
  801f28:	c3                   	ret    
  801f29:	8d 76 00             	lea    0x0(%esi),%esi
  801f2c:	2b 04 24             	sub    (%esp),%eax
  801f2f:	19 fa                	sbb    %edi,%edx
  801f31:	89 d1                	mov    %edx,%ecx
  801f33:	89 c6                	mov    %eax,%esi
  801f35:	e9 71 ff ff ff       	jmp    801eab <__umoddi3+0xb3>
  801f3a:	66 90                	xchg   %ax,%ax
  801f3c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f40:	72 ea                	jb     801f2c <__umoddi3+0x134>
  801f42:	89 d9                	mov    %ebx,%ecx
  801f44:	e9 62 ff ff ff       	jmp    801eab <__umoddi3+0xb3>
