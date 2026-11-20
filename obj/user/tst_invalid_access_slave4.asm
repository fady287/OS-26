
obj/user/tst_invalid_access_slave4:     file format elf32-i386


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
  800031:	e8 75 00 00 00       	call   8000ab <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	//[4] Not in Page File, Not Stack & Not Heap
	uint32 kilo = 1024;
  80003e:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	{
		//uint32 size = 4*kilo;

		//Successful access to allowed space
		unsigned char *x = (unsigned char *)(0x00200000);
  800045:	c7 45 ec 00 00 20 00 	movl   $0x200000,-0x14(%ebp)

		int i=0;
  80004c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(;i< 20;i++)
  800053:	eb 0e                	jmp    800063 <_main+0x2b>
		{
			x[i]=-1;
  800055:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800058:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80005b:	01 d0                	add    %edx,%eax
  80005d:	c6 00 ff             	movb   $0xff,(%eax)

		//Successful access to allowed space
		unsigned char *x = (unsigned char *)(0x00200000);

		int i=0;
		for(;i< 20;i++)
  800060:	ff 45 f4             	incl   -0xc(%ebp)
  800063:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  800067:	7e ec                	jle    800055 <_main+0x1d>
		{
			x[i]=-1;
		}

		inctst();
  800069:	e8 3f 18 00 00       	call   8018ad <inctst>

		//Access to NOT allowed space
		x = (unsigned char *)(0x00200000 - 20);
  80006e:	c7 45 ec ec ff 1f 00 	movl   $0x1fffec,-0x14(%ebp)

		i=0;
  800075:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(;i< 20;i++)
  80007c:	eb 0e                	jmp    80008c <_main+0x54>
		{
			x[i]=-1;
  80007e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800081:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800084:	01 d0                	add    %edx,%eax
  800086:	c6 00 ff             	movb   $0xff,(%eax)

		//Access to NOT allowed space
		x = (unsigned char *)(0x00200000 - 20);

		i=0;
		for(;i< 20;i++)
  800089:	ff 45 f4             	incl   -0xc(%ebp)
  80008c:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  800090:	7e ec                	jle    80007e <_main+0x46>
			x[i]=-1;
		}

	}

	inctst();
  800092:	e8 16 18 00 00       	call   8018ad <inctst>
	panic("tst invalid access failed: Attempt to access page that's not exist in page file, neither stack or heap.\nThe env must be killed and shouldn't return here.");
  800097:	83 ec 04             	sub    $0x4,%esp
  80009a:	68 a0 1c 80 00       	push   $0x801ca0
  80009f:	6a 25                	push   $0x25
  8000a1:	68 3c 1d 80 00       	push   $0x801d3c
  8000a6:	e8 60 02 00 00       	call   80030b <_panic>

008000ab <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8000ab:	55                   	push   %ebp
  8000ac:	89 e5                	mov    %esp,%ebp
  8000ae:	57                   	push   %edi
  8000af:	56                   	push   %esi
  8000b0:	53                   	push   %ebx
  8000b1:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8000b7:	e8 e9 16 00 00       	call   8017a5 <sys_getenvindex>
  8000bc:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8000bf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8000c2:	89 d0                	mov    %edx,%eax
  8000c4:	c1 e0 03             	shl    $0x3,%eax
  8000c7:	01 d0                	add    %edx,%eax
  8000c9:	c1 e0 06             	shl    $0x6,%eax
  8000cc:	01 d0                	add    %edx,%eax
  8000ce:	c1 e0 03             	shl    $0x3,%eax
  8000d1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000d6:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000db:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e0:	8a 40 10             	mov    0x10(%eax),%al
  8000e3:	84 c0                	test   %al,%al
  8000e5:	74 0d                	je     8000f4 <libmain+0x49>
		binaryname = myEnv->prog_name;
  8000e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ec:	83 c0 10             	add    $0x10,%eax
  8000ef:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000f4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000f8:	7e 0a                	jle    800104 <libmain+0x59>
		binaryname = argv[0];
  8000fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000fd:	8b 00                	mov    (%eax),%eax
  8000ff:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800104:	83 ec 08             	sub    $0x8,%esp
  800107:	ff 75 0c             	pushl  0xc(%ebp)
  80010a:	ff 75 08             	pushl  0x8(%ebp)
  80010d:	e8 26 ff ff ff       	call   800038 <_main>
  800112:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800115:	a1 00 30 80 00       	mov    0x803000,%eax
  80011a:	85 c0                	test   %eax,%eax
  80011c:	0f 84 b7 01 00 00    	je     8002d9 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800122:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800128:	bb 9c 1e 80 00       	mov    $0x801e9c,%ebx
  80012d:	ba 0e 00 00 00       	mov    $0xe,%edx
  800132:	89 c7                	mov    %eax,%edi
  800134:	89 de                	mov    %ebx,%esi
  800136:	89 d1                	mov    %edx,%ecx
  800138:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80013a:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800140:	b9 56 00 00 00       	mov    $0x56,%ecx
  800145:	b0 00                	mov    $0x0,%al
  800147:	89 d7                	mov    %edx,%edi
  800149:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  80014b:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800152:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800155:	83 ec 08             	sub    $0x8,%esp
  800158:	50                   	push   %eax
  800159:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  80015f:	50                   	push   %eax
  800160:	e8 40 18 00 00       	call   8019a5 <sys_utilities>
  800165:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800168:	e8 c0 13 00 00       	call   80152d <sys_lock_cons>
		{
			cprintf("**************************************\n");
  80016d:	83 ec 0c             	sub    $0xc,%esp
  800170:	68 78 1d 80 00       	push   $0x801d78
  800175:	e8 5f 04 00 00       	call   8005d9 <cprintf>
  80017a:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  80017d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800180:	85 c0                	test   %eax,%eax
  800182:	74 58                	je     8001dc <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800184:	e8 3a 18 00 00       	call   8019c3 <sys_get_optimal_num_faults>
  800189:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  80018c:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800192:	bb 00 1f 80 00       	mov    $0x801f00,%ebx
  800197:	ba 11 00 00 00       	mov    $0x11,%edx
  80019c:	89 c7                	mov    %eax,%edi
  80019e:	89 de                	mov    %ebx,%esi
  8001a0:	89 d1                	mov    %edx,%ecx
  8001a2:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8001a4:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8001a7:	b9 53 00 00 00       	mov    $0x53,%ecx
  8001ac:	b0 00                	mov    $0x0,%al
  8001ae:	89 d7                	mov    %edx,%edi
  8001b0:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8001b2:	83 ec 08             	sub    $0x8,%esp
  8001b5:	ff 75 dc             	pushl  -0x24(%ebp)
  8001b8:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8001be:	50                   	push   %eax
  8001bf:	e8 e1 17 00 00       	call   8019a5 <sys_utilities>
  8001c4:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8001c7:	83 ec 08             	sub    $0x8,%esp
  8001ca:	ff 75 dc             	pushl  -0x24(%ebp)
  8001cd:	68 a0 1d 80 00       	push   $0x801da0
  8001d2:	e8 02 04 00 00       	call   8005d9 <cprintf>
  8001d7:	83 c4 10             	add    $0x10,%esp
  8001da:	eb 59                	jmp    800235 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e1:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8001e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ec:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8001f2:	83 ec 04             	sub    $0x4,%esp
  8001f5:	52                   	push   %edx
  8001f6:	50                   	push   %eax
  8001f7:	68 c4 1d 80 00       	push   $0x801dc4
  8001fc:	e8 d8 03 00 00       	call   8005d9 <cprintf>
  800201:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800204:	a1 20 30 80 00       	mov    0x803020,%eax
  800209:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  80020f:	a1 20 30 80 00       	mov    0x803020,%eax
  800214:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  80021a:	a1 20 30 80 00       	mov    0x803020,%eax
  80021f:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800225:	51                   	push   %ecx
  800226:	52                   	push   %edx
  800227:	50                   	push   %eax
  800228:	68 ec 1d 80 00       	push   $0x801dec
  80022d:	e8 a7 03 00 00       	call   8005d9 <cprintf>
  800232:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800235:	a1 20 30 80 00       	mov    0x803020,%eax
  80023a:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800240:	83 ec 08             	sub    $0x8,%esp
  800243:	50                   	push   %eax
  800244:	68 44 1e 80 00       	push   $0x801e44
  800249:	e8 8b 03 00 00       	call   8005d9 <cprintf>
  80024e:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800251:	83 ec 0c             	sub    $0xc,%esp
  800254:	68 58 1e 80 00       	push   $0x801e58
  800259:	e8 7b 03 00 00       	call   8005d9 <cprintf>
  80025e:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800261:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800268:	eb 28                	jmp    800292 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  80026a:	a1 20 30 80 00       	mov    0x803020,%eax
  80026f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800272:	81 c2 74 04 00 00    	add    $0x474,%edx
  800278:	8b 04 90             	mov    (%eax,%edx,4),%eax
  80027b:	83 ec 04             	sub    $0x4,%esp
  80027e:	50                   	push   %eax
  80027f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800282:	68 6f 1e 80 00       	push   $0x801e6f
  800287:	e8 4d 03 00 00       	call   8005d9 <cprintf>
  80028c:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  80028f:	ff 45 e4             	incl   -0x1c(%ebp)
  800292:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800296:	7e d2                	jle    80026a <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800298:	83 ec 0c             	sub    $0xc,%esp
  80029b:	68 7e 1e 80 00       	push   $0x801e7e
  8002a0:	e8 34 03 00 00       	call   8005d9 <cprintf>
  8002a5:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8002a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ad:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8002b3:	83 ec 08             	sub    $0x8,%esp
  8002b6:	50                   	push   %eax
  8002b7:	68 82 1e 80 00       	push   $0x801e82
  8002bc:	e8 18 03 00 00       	call   8005d9 <cprintf>
  8002c1:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8002c4:	83 ec 0c             	sub    $0xc,%esp
  8002c7:	68 78 1d 80 00       	push   $0x801d78
  8002cc:	e8 08 03 00 00       	call   8005d9 <cprintf>
  8002d1:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8002d4:	e8 6e 12 00 00       	call   801547 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8002d9:	e8 1f 00 00 00       	call   8002fd <exit>
}
  8002de:	90                   	nop
  8002df:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8002e2:	5b                   	pop    %ebx
  8002e3:	5e                   	pop    %esi
  8002e4:	5f                   	pop    %edi
  8002e5:	5d                   	pop    %ebp
  8002e6:	c3                   	ret    

008002e7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002e7:	55                   	push   %ebp
  8002e8:	89 e5                	mov    %esp,%ebp
  8002ea:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8002ed:	83 ec 0c             	sub    $0xc,%esp
  8002f0:	6a 00                	push   $0x0
  8002f2:	e8 7a 14 00 00       	call   801771 <sys_destroy_env>
  8002f7:	83 c4 10             	add    $0x10,%esp
}
  8002fa:	90                   	nop
  8002fb:	c9                   	leave  
  8002fc:	c3                   	ret    

008002fd <exit>:

void
exit(void)
{
  8002fd:	55                   	push   %ebp
  8002fe:	89 e5                	mov    %esp,%ebp
  800300:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800303:	e8 cf 14 00 00       	call   8017d7 <sys_exit_env>
}
  800308:	90                   	nop
  800309:	c9                   	leave  
  80030a:	c3                   	ret    

0080030b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80030b:	55                   	push   %ebp
  80030c:	89 e5                	mov    %esp,%ebp
  80030e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800311:	8d 45 10             	lea    0x10(%ebp),%eax
  800314:	83 c0 04             	add    $0x4,%eax
  800317:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80031a:	a1 28 31 80 00       	mov    0x803128,%eax
  80031f:	85 c0                	test   %eax,%eax
  800321:	74 16                	je     800339 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800323:	a1 28 31 80 00       	mov    0x803128,%eax
  800328:	83 ec 08             	sub    $0x8,%esp
  80032b:	50                   	push   %eax
  80032c:	68 64 1f 80 00       	push   $0x801f64
  800331:	e8 a3 02 00 00       	call   8005d9 <cprintf>
  800336:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  800339:	a1 04 30 80 00       	mov    0x803004,%eax
  80033e:	83 ec 0c             	sub    $0xc,%esp
  800341:	ff 75 0c             	pushl  0xc(%ebp)
  800344:	ff 75 08             	pushl  0x8(%ebp)
  800347:	50                   	push   %eax
  800348:	68 6c 1f 80 00       	push   $0x801f6c
  80034d:	6a 74                	push   $0x74
  80034f:	e8 b2 02 00 00       	call   800606 <cprintf_colored>
  800354:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  800357:	8b 45 10             	mov    0x10(%ebp),%eax
  80035a:	83 ec 08             	sub    $0x8,%esp
  80035d:	ff 75 f4             	pushl  -0xc(%ebp)
  800360:	50                   	push   %eax
  800361:	e8 04 02 00 00       	call   80056a <vcprintf>
  800366:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800369:	83 ec 08             	sub    $0x8,%esp
  80036c:	6a 00                	push   $0x0
  80036e:	68 94 1f 80 00       	push   $0x801f94
  800373:	e8 f2 01 00 00       	call   80056a <vcprintf>
  800378:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80037b:	e8 7d ff ff ff       	call   8002fd <exit>

	// should not return here
	while (1) ;
  800380:	eb fe                	jmp    800380 <_panic+0x75>

00800382 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800382:	55                   	push   %ebp
  800383:	89 e5                	mov    %esp,%ebp
  800385:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800388:	a1 20 30 80 00       	mov    0x803020,%eax
  80038d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800393:	8b 45 0c             	mov    0xc(%ebp),%eax
  800396:	39 c2                	cmp    %eax,%edx
  800398:	74 14                	je     8003ae <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80039a:	83 ec 04             	sub    $0x4,%esp
  80039d:	68 98 1f 80 00       	push   $0x801f98
  8003a2:	6a 26                	push   $0x26
  8003a4:	68 e4 1f 80 00       	push   $0x801fe4
  8003a9:	e8 5d ff ff ff       	call   80030b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003bc:	e9 c5 00 00 00       	jmp    800486 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  8003c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ce:	01 d0                	add    %edx,%eax
  8003d0:	8b 00                	mov    (%eax),%eax
  8003d2:	85 c0                	test   %eax,%eax
  8003d4:	75 08                	jne    8003de <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  8003d6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003d9:	e9 a5 00 00 00       	jmp    800483 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  8003de:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003e5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003ec:	eb 69                	jmp    800457 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f3:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8003f9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003fc:	89 d0                	mov    %edx,%eax
  8003fe:	01 c0                	add    %eax,%eax
  800400:	01 d0                	add    %edx,%eax
  800402:	c1 e0 03             	shl    $0x3,%eax
  800405:	01 c8                	add    %ecx,%eax
  800407:	8a 40 04             	mov    0x4(%eax),%al
  80040a:	84 c0                	test   %al,%al
  80040c:	75 46                	jne    800454 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80040e:	a1 20 30 80 00       	mov    0x803020,%eax
  800413:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800419:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80041c:	89 d0                	mov    %edx,%eax
  80041e:	01 c0                	add    %eax,%eax
  800420:	01 d0                	add    %edx,%eax
  800422:	c1 e0 03             	shl    $0x3,%eax
  800425:	01 c8                	add    %ecx,%eax
  800427:	8b 00                	mov    (%eax),%eax
  800429:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80042c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80042f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800434:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800436:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800439:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	01 c8                	add    %ecx,%eax
  800445:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800447:	39 c2                	cmp    %eax,%edx
  800449:	75 09                	jne    800454 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  80044b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800452:	eb 15                	jmp    800469 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800454:	ff 45 e8             	incl   -0x18(%ebp)
  800457:	a1 20 30 80 00       	mov    0x803020,%eax
  80045c:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800462:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800465:	39 c2                	cmp    %eax,%edx
  800467:	77 85                	ja     8003ee <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800469:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80046d:	75 14                	jne    800483 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  80046f:	83 ec 04             	sub    $0x4,%esp
  800472:	68 f0 1f 80 00       	push   $0x801ff0
  800477:	6a 3a                	push   $0x3a
  800479:	68 e4 1f 80 00       	push   $0x801fe4
  80047e:	e8 88 fe ff ff       	call   80030b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800483:	ff 45 f0             	incl   -0x10(%ebp)
  800486:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800489:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80048c:	0f 8c 2f ff ff ff    	jl     8003c1 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800492:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800499:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004a0:	eb 26                	jmp    8004c8 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a7:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8004ad:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004b0:	89 d0                	mov    %edx,%eax
  8004b2:	01 c0                	add    %eax,%eax
  8004b4:	01 d0                	add    %edx,%eax
  8004b6:	c1 e0 03             	shl    $0x3,%eax
  8004b9:	01 c8                	add    %ecx,%eax
  8004bb:	8a 40 04             	mov    0x4(%eax),%al
  8004be:	3c 01                	cmp    $0x1,%al
  8004c0:	75 03                	jne    8004c5 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  8004c2:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004c5:	ff 45 e0             	incl   -0x20(%ebp)
  8004c8:	a1 20 30 80 00       	mov    0x803020,%eax
  8004cd:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8004d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004d6:	39 c2                	cmp    %eax,%edx
  8004d8:	77 c8                	ja     8004a2 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004dd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004e0:	74 14                	je     8004f6 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  8004e2:	83 ec 04             	sub    $0x4,%esp
  8004e5:	68 44 20 80 00       	push   $0x802044
  8004ea:	6a 44                	push   $0x44
  8004ec:	68 e4 1f 80 00       	push   $0x801fe4
  8004f1:	e8 15 fe ff ff       	call   80030b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004f6:	90                   	nop
  8004f7:	c9                   	leave  
  8004f8:	c3                   	ret    

008004f9 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  8004f9:	55                   	push   %ebp
  8004fa:	89 e5                	mov    %esp,%ebp
  8004fc:	53                   	push   %ebx
  8004fd:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800500:	8b 45 0c             	mov    0xc(%ebp),%eax
  800503:	8b 00                	mov    (%eax),%eax
  800505:	8d 48 01             	lea    0x1(%eax),%ecx
  800508:	8b 55 0c             	mov    0xc(%ebp),%edx
  80050b:	89 0a                	mov    %ecx,(%edx)
  80050d:	8b 55 08             	mov    0x8(%ebp),%edx
  800510:	88 d1                	mov    %dl,%cl
  800512:	8b 55 0c             	mov    0xc(%ebp),%edx
  800515:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800519:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051c:	8b 00                	mov    (%eax),%eax
  80051e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800523:	75 30                	jne    800555 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800525:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  80052b:	a0 40 30 80 00       	mov    0x803040,%al
  800530:	0f b6 c0             	movzbl %al,%eax
  800533:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800536:	8b 09                	mov    (%ecx),%ecx
  800538:	89 cb                	mov    %ecx,%ebx
  80053a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80053d:	83 c1 08             	add    $0x8,%ecx
  800540:	52                   	push   %edx
  800541:	50                   	push   %eax
  800542:	53                   	push   %ebx
  800543:	51                   	push   %ecx
  800544:	e8 a0 0f 00 00       	call   8014e9 <sys_cputs>
  800549:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80054c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80054f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800555:	8b 45 0c             	mov    0xc(%ebp),%eax
  800558:	8b 40 04             	mov    0x4(%eax),%eax
  80055b:	8d 50 01             	lea    0x1(%eax),%edx
  80055e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800561:	89 50 04             	mov    %edx,0x4(%eax)
}
  800564:	90                   	nop
  800565:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800568:	c9                   	leave  
  800569:	c3                   	ret    

0080056a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80056a:	55                   	push   %ebp
  80056b:	89 e5                	mov    %esp,%ebp
  80056d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800573:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80057a:	00 00 00 
	b.cnt = 0;
  80057d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800584:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800587:	ff 75 0c             	pushl  0xc(%ebp)
  80058a:	ff 75 08             	pushl  0x8(%ebp)
  80058d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800593:	50                   	push   %eax
  800594:	68 f9 04 80 00       	push   $0x8004f9
  800599:	e8 5a 02 00 00       	call   8007f8 <vprintfmt>
  80059e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8005a1:	8b 15 2c 31 80 00    	mov    0x80312c,%edx
  8005a7:	a0 40 30 80 00       	mov    0x803040,%al
  8005ac:	0f b6 c0             	movzbl %al,%eax
  8005af:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8005b5:	52                   	push   %edx
  8005b6:	50                   	push   %eax
  8005b7:	51                   	push   %ecx
  8005b8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005be:	83 c0 08             	add    $0x8,%eax
  8005c1:	50                   	push   %eax
  8005c2:	e8 22 0f 00 00       	call   8014e9 <sys_cputs>
  8005c7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005ca:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
	return b.cnt;
  8005d1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005d7:	c9                   	leave  
  8005d8:	c3                   	ret    

008005d9 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8005d9:	55                   	push   %ebp
  8005da:	89 e5                	mov    %esp,%ebp
  8005dc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005df:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	va_start(ap, fmt);
  8005e6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ef:	83 ec 08             	sub    $0x8,%esp
  8005f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8005f5:	50                   	push   %eax
  8005f6:	e8 6f ff ff ff       	call   80056a <vcprintf>
  8005fb:	83 c4 10             	add    $0x10,%esp
  8005fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800601:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800604:	c9                   	leave  
  800605:	c3                   	ret    

00800606 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800606:	55                   	push   %ebp
  800607:	89 e5                	mov    %esp,%ebp
  800609:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80060c:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800613:	8b 45 08             	mov    0x8(%ebp),%eax
  800616:	c1 e0 08             	shl    $0x8,%eax
  800619:	a3 2c 31 80 00       	mov    %eax,0x80312c
	va_start(ap, fmt);
  80061e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800621:	83 c0 04             	add    $0x4,%eax
  800624:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800627:	8b 45 0c             	mov    0xc(%ebp),%eax
  80062a:	83 ec 08             	sub    $0x8,%esp
  80062d:	ff 75 f4             	pushl  -0xc(%ebp)
  800630:	50                   	push   %eax
  800631:	e8 34 ff ff ff       	call   80056a <vcprintf>
  800636:	83 c4 10             	add    $0x10,%esp
  800639:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  80063c:	c7 05 2c 31 80 00 00 	movl   $0x700,0x80312c
  800643:	07 00 00 

	return cnt;
  800646:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800649:	c9                   	leave  
  80064a:	c3                   	ret    

0080064b <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  80064b:	55                   	push   %ebp
  80064c:	89 e5                	mov    %esp,%ebp
  80064e:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800651:	e8 d7 0e 00 00       	call   80152d <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800656:	8d 45 0c             	lea    0xc(%ebp),%eax
  800659:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  80065c:	8b 45 08             	mov    0x8(%ebp),%eax
  80065f:	83 ec 08             	sub    $0x8,%esp
  800662:	ff 75 f4             	pushl  -0xc(%ebp)
  800665:	50                   	push   %eax
  800666:	e8 ff fe ff ff       	call   80056a <vcprintf>
  80066b:	83 c4 10             	add    $0x10,%esp
  80066e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800671:	e8 d1 0e 00 00       	call   801547 <sys_unlock_cons>
	return cnt;
  800676:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800679:	c9                   	leave  
  80067a:	c3                   	ret    

0080067b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80067b:	55                   	push   %ebp
  80067c:	89 e5                	mov    %esp,%ebp
  80067e:	53                   	push   %ebx
  80067f:	83 ec 14             	sub    $0x14,%esp
  800682:	8b 45 10             	mov    0x10(%ebp),%eax
  800685:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800688:	8b 45 14             	mov    0x14(%ebp),%eax
  80068b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80068e:	8b 45 18             	mov    0x18(%ebp),%eax
  800691:	ba 00 00 00 00       	mov    $0x0,%edx
  800696:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800699:	77 55                	ja     8006f0 <printnum+0x75>
  80069b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80069e:	72 05                	jb     8006a5 <printnum+0x2a>
  8006a0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006a3:	77 4b                	ja     8006f0 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006a5:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006a8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006ab:	8b 45 18             	mov    0x18(%ebp),%eax
  8006ae:	ba 00 00 00 00       	mov    $0x0,%edx
  8006b3:	52                   	push   %edx
  8006b4:	50                   	push   %eax
  8006b5:	ff 75 f4             	pushl  -0xc(%ebp)
  8006b8:	ff 75 f0             	pushl  -0x10(%ebp)
  8006bb:	e8 74 13 00 00       	call   801a34 <__udivdi3>
  8006c0:	83 c4 10             	add    $0x10,%esp
  8006c3:	83 ec 04             	sub    $0x4,%esp
  8006c6:	ff 75 20             	pushl  0x20(%ebp)
  8006c9:	53                   	push   %ebx
  8006ca:	ff 75 18             	pushl  0x18(%ebp)
  8006cd:	52                   	push   %edx
  8006ce:	50                   	push   %eax
  8006cf:	ff 75 0c             	pushl  0xc(%ebp)
  8006d2:	ff 75 08             	pushl  0x8(%ebp)
  8006d5:	e8 a1 ff ff ff       	call   80067b <printnum>
  8006da:	83 c4 20             	add    $0x20,%esp
  8006dd:	eb 1a                	jmp    8006f9 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006df:	83 ec 08             	sub    $0x8,%esp
  8006e2:	ff 75 0c             	pushl  0xc(%ebp)
  8006e5:	ff 75 20             	pushl  0x20(%ebp)
  8006e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006eb:	ff d0                	call   *%eax
  8006ed:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006f0:	ff 4d 1c             	decl   0x1c(%ebp)
  8006f3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006f7:	7f e6                	jg     8006df <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006f9:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006fc:	bb 00 00 00 00       	mov    $0x0,%ebx
  800701:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800704:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800707:	53                   	push   %ebx
  800708:	51                   	push   %ecx
  800709:	52                   	push   %edx
  80070a:	50                   	push   %eax
  80070b:	e8 34 14 00 00       	call   801b44 <__umoddi3>
  800710:	83 c4 10             	add    $0x10,%esp
  800713:	05 b4 22 80 00       	add    $0x8022b4,%eax
  800718:	8a 00                	mov    (%eax),%al
  80071a:	0f be c0             	movsbl %al,%eax
  80071d:	83 ec 08             	sub    $0x8,%esp
  800720:	ff 75 0c             	pushl  0xc(%ebp)
  800723:	50                   	push   %eax
  800724:	8b 45 08             	mov    0x8(%ebp),%eax
  800727:	ff d0                	call   *%eax
  800729:	83 c4 10             	add    $0x10,%esp
}
  80072c:	90                   	nop
  80072d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800730:	c9                   	leave  
  800731:	c3                   	ret    

00800732 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800732:	55                   	push   %ebp
  800733:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800735:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800739:	7e 1c                	jle    800757 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80073b:	8b 45 08             	mov    0x8(%ebp),%eax
  80073e:	8b 00                	mov    (%eax),%eax
  800740:	8d 50 08             	lea    0x8(%eax),%edx
  800743:	8b 45 08             	mov    0x8(%ebp),%eax
  800746:	89 10                	mov    %edx,(%eax)
  800748:	8b 45 08             	mov    0x8(%ebp),%eax
  80074b:	8b 00                	mov    (%eax),%eax
  80074d:	83 e8 08             	sub    $0x8,%eax
  800750:	8b 50 04             	mov    0x4(%eax),%edx
  800753:	8b 00                	mov    (%eax),%eax
  800755:	eb 40                	jmp    800797 <getuint+0x65>
	else if (lflag)
  800757:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80075b:	74 1e                	je     80077b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80075d:	8b 45 08             	mov    0x8(%ebp),%eax
  800760:	8b 00                	mov    (%eax),%eax
  800762:	8d 50 04             	lea    0x4(%eax),%edx
  800765:	8b 45 08             	mov    0x8(%ebp),%eax
  800768:	89 10                	mov    %edx,(%eax)
  80076a:	8b 45 08             	mov    0x8(%ebp),%eax
  80076d:	8b 00                	mov    (%eax),%eax
  80076f:	83 e8 04             	sub    $0x4,%eax
  800772:	8b 00                	mov    (%eax),%eax
  800774:	ba 00 00 00 00       	mov    $0x0,%edx
  800779:	eb 1c                	jmp    800797 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80077b:	8b 45 08             	mov    0x8(%ebp),%eax
  80077e:	8b 00                	mov    (%eax),%eax
  800780:	8d 50 04             	lea    0x4(%eax),%edx
  800783:	8b 45 08             	mov    0x8(%ebp),%eax
  800786:	89 10                	mov    %edx,(%eax)
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	8b 00                	mov    (%eax),%eax
  80078d:	83 e8 04             	sub    $0x4,%eax
  800790:	8b 00                	mov    (%eax),%eax
  800792:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800797:	5d                   	pop    %ebp
  800798:	c3                   	ret    

00800799 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800799:	55                   	push   %ebp
  80079a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80079c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007a0:	7e 1c                	jle    8007be <getint+0x25>
		return va_arg(*ap, long long);
  8007a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a5:	8b 00                	mov    (%eax),%eax
  8007a7:	8d 50 08             	lea    0x8(%eax),%edx
  8007aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ad:	89 10                	mov    %edx,(%eax)
  8007af:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b2:	8b 00                	mov    (%eax),%eax
  8007b4:	83 e8 08             	sub    $0x8,%eax
  8007b7:	8b 50 04             	mov    0x4(%eax),%edx
  8007ba:	8b 00                	mov    (%eax),%eax
  8007bc:	eb 38                	jmp    8007f6 <getint+0x5d>
	else if (lflag)
  8007be:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007c2:	74 1a                	je     8007de <getint+0x45>
		return va_arg(*ap, long);
  8007c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c7:	8b 00                	mov    (%eax),%eax
  8007c9:	8d 50 04             	lea    0x4(%eax),%edx
  8007cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cf:	89 10                	mov    %edx,(%eax)
  8007d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d4:	8b 00                	mov    (%eax),%eax
  8007d6:	83 e8 04             	sub    $0x4,%eax
  8007d9:	8b 00                	mov    (%eax),%eax
  8007db:	99                   	cltd   
  8007dc:	eb 18                	jmp    8007f6 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007de:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e1:	8b 00                	mov    (%eax),%eax
  8007e3:	8d 50 04             	lea    0x4(%eax),%edx
  8007e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e9:	89 10                	mov    %edx,(%eax)
  8007eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ee:	8b 00                	mov    (%eax),%eax
  8007f0:	83 e8 04             	sub    $0x4,%eax
  8007f3:	8b 00                	mov    (%eax),%eax
  8007f5:	99                   	cltd   
}
  8007f6:	5d                   	pop    %ebp
  8007f7:	c3                   	ret    

008007f8 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007f8:	55                   	push   %ebp
  8007f9:	89 e5                	mov    %esp,%ebp
  8007fb:	56                   	push   %esi
  8007fc:	53                   	push   %ebx
  8007fd:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800800:	eb 17                	jmp    800819 <vprintfmt+0x21>
			if (ch == '\0')
  800802:	85 db                	test   %ebx,%ebx
  800804:	0f 84 c1 03 00 00    	je     800bcb <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  80080a:	83 ec 08             	sub    $0x8,%esp
  80080d:	ff 75 0c             	pushl  0xc(%ebp)
  800810:	53                   	push   %ebx
  800811:	8b 45 08             	mov    0x8(%ebp),%eax
  800814:	ff d0                	call   *%eax
  800816:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800819:	8b 45 10             	mov    0x10(%ebp),%eax
  80081c:	8d 50 01             	lea    0x1(%eax),%edx
  80081f:	89 55 10             	mov    %edx,0x10(%ebp)
  800822:	8a 00                	mov    (%eax),%al
  800824:	0f b6 d8             	movzbl %al,%ebx
  800827:	83 fb 25             	cmp    $0x25,%ebx
  80082a:	75 d6                	jne    800802 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80082c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800830:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800837:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80083e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800845:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80084c:	8b 45 10             	mov    0x10(%ebp),%eax
  80084f:	8d 50 01             	lea    0x1(%eax),%edx
  800852:	89 55 10             	mov    %edx,0x10(%ebp)
  800855:	8a 00                	mov    (%eax),%al
  800857:	0f b6 d8             	movzbl %al,%ebx
  80085a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80085d:	83 f8 5b             	cmp    $0x5b,%eax
  800860:	0f 87 3d 03 00 00    	ja     800ba3 <vprintfmt+0x3ab>
  800866:	8b 04 85 d8 22 80 00 	mov    0x8022d8(,%eax,4),%eax
  80086d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80086f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800873:	eb d7                	jmp    80084c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800875:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800879:	eb d1                	jmp    80084c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80087b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800882:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800885:	89 d0                	mov    %edx,%eax
  800887:	c1 e0 02             	shl    $0x2,%eax
  80088a:	01 d0                	add    %edx,%eax
  80088c:	01 c0                	add    %eax,%eax
  80088e:	01 d8                	add    %ebx,%eax
  800890:	83 e8 30             	sub    $0x30,%eax
  800893:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800896:	8b 45 10             	mov    0x10(%ebp),%eax
  800899:	8a 00                	mov    (%eax),%al
  80089b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80089e:	83 fb 2f             	cmp    $0x2f,%ebx
  8008a1:	7e 3e                	jle    8008e1 <vprintfmt+0xe9>
  8008a3:	83 fb 39             	cmp    $0x39,%ebx
  8008a6:	7f 39                	jg     8008e1 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008a8:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008ab:	eb d5                	jmp    800882 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b0:	83 c0 04             	add    $0x4,%eax
  8008b3:	89 45 14             	mov    %eax,0x14(%ebp)
  8008b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b9:	83 e8 04             	sub    $0x4,%eax
  8008bc:	8b 00                	mov    (%eax),%eax
  8008be:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008c1:	eb 1f                	jmp    8008e2 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008c3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008c7:	79 83                	jns    80084c <vprintfmt+0x54>
				width = 0;
  8008c9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008d0:	e9 77 ff ff ff       	jmp    80084c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008d5:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008dc:	e9 6b ff ff ff       	jmp    80084c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008e1:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008e2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008e6:	0f 89 60 ff ff ff    	jns    80084c <vprintfmt+0x54>
				width = precision, precision = -1;
  8008ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008f2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008f9:	e9 4e ff ff ff       	jmp    80084c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008fe:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800901:	e9 46 ff ff ff       	jmp    80084c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800906:	8b 45 14             	mov    0x14(%ebp),%eax
  800909:	83 c0 04             	add    $0x4,%eax
  80090c:	89 45 14             	mov    %eax,0x14(%ebp)
  80090f:	8b 45 14             	mov    0x14(%ebp),%eax
  800912:	83 e8 04             	sub    $0x4,%eax
  800915:	8b 00                	mov    (%eax),%eax
  800917:	83 ec 08             	sub    $0x8,%esp
  80091a:	ff 75 0c             	pushl  0xc(%ebp)
  80091d:	50                   	push   %eax
  80091e:	8b 45 08             	mov    0x8(%ebp),%eax
  800921:	ff d0                	call   *%eax
  800923:	83 c4 10             	add    $0x10,%esp
			break;
  800926:	e9 9b 02 00 00       	jmp    800bc6 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80092b:	8b 45 14             	mov    0x14(%ebp),%eax
  80092e:	83 c0 04             	add    $0x4,%eax
  800931:	89 45 14             	mov    %eax,0x14(%ebp)
  800934:	8b 45 14             	mov    0x14(%ebp),%eax
  800937:	83 e8 04             	sub    $0x4,%eax
  80093a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80093c:	85 db                	test   %ebx,%ebx
  80093e:	79 02                	jns    800942 <vprintfmt+0x14a>
				err = -err;
  800940:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800942:	83 fb 64             	cmp    $0x64,%ebx
  800945:	7f 0b                	jg     800952 <vprintfmt+0x15a>
  800947:	8b 34 9d 20 21 80 00 	mov    0x802120(,%ebx,4),%esi
  80094e:	85 f6                	test   %esi,%esi
  800950:	75 19                	jne    80096b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800952:	53                   	push   %ebx
  800953:	68 c5 22 80 00       	push   $0x8022c5
  800958:	ff 75 0c             	pushl  0xc(%ebp)
  80095b:	ff 75 08             	pushl  0x8(%ebp)
  80095e:	e8 70 02 00 00       	call   800bd3 <printfmt>
  800963:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800966:	e9 5b 02 00 00       	jmp    800bc6 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80096b:	56                   	push   %esi
  80096c:	68 ce 22 80 00       	push   $0x8022ce
  800971:	ff 75 0c             	pushl  0xc(%ebp)
  800974:	ff 75 08             	pushl  0x8(%ebp)
  800977:	e8 57 02 00 00       	call   800bd3 <printfmt>
  80097c:	83 c4 10             	add    $0x10,%esp
			break;
  80097f:	e9 42 02 00 00       	jmp    800bc6 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800984:	8b 45 14             	mov    0x14(%ebp),%eax
  800987:	83 c0 04             	add    $0x4,%eax
  80098a:	89 45 14             	mov    %eax,0x14(%ebp)
  80098d:	8b 45 14             	mov    0x14(%ebp),%eax
  800990:	83 e8 04             	sub    $0x4,%eax
  800993:	8b 30                	mov    (%eax),%esi
  800995:	85 f6                	test   %esi,%esi
  800997:	75 05                	jne    80099e <vprintfmt+0x1a6>
				p = "(null)";
  800999:	be d1 22 80 00       	mov    $0x8022d1,%esi
			if (width > 0 && padc != '-')
  80099e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009a2:	7e 6d                	jle    800a11 <vprintfmt+0x219>
  8009a4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009a8:	74 67                	je     800a11 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009ad:	83 ec 08             	sub    $0x8,%esp
  8009b0:	50                   	push   %eax
  8009b1:	56                   	push   %esi
  8009b2:	e8 1e 03 00 00       	call   800cd5 <strnlen>
  8009b7:	83 c4 10             	add    $0x10,%esp
  8009ba:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009bd:	eb 16                	jmp    8009d5 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009bf:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009c3:	83 ec 08             	sub    $0x8,%esp
  8009c6:	ff 75 0c             	pushl  0xc(%ebp)
  8009c9:	50                   	push   %eax
  8009ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cd:	ff d0                	call   *%eax
  8009cf:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009d2:	ff 4d e4             	decl   -0x1c(%ebp)
  8009d5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009d9:	7f e4                	jg     8009bf <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009db:	eb 34                	jmp    800a11 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009dd:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009e1:	74 1c                	je     8009ff <vprintfmt+0x207>
  8009e3:	83 fb 1f             	cmp    $0x1f,%ebx
  8009e6:	7e 05                	jle    8009ed <vprintfmt+0x1f5>
  8009e8:	83 fb 7e             	cmp    $0x7e,%ebx
  8009eb:	7e 12                	jle    8009ff <vprintfmt+0x207>
					putch('?', putdat);
  8009ed:	83 ec 08             	sub    $0x8,%esp
  8009f0:	ff 75 0c             	pushl  0xc(%ebp)
  8009f3:	6a 3f                	push   $0x3f
  8009f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f8:	ff d0                	call   *%eax
  8009fa:	83 c4 10             	add    $0x10,%esp
  8009fd:	eb 0f                	jmp    800a0e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009ff:	83 ec 08             	sub    $0x8,%esp
  800a02:	ff 75 0c             	pushl  0xc(%ebp)
  800a05:	53                   	push   %ebx
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	ff d0                	call   *%eax
  800a0b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a0e:	ff 4d e4             	decl   -0x1c(%ebp)
  800a11:	89 f0                	mov    %esi,%eax
  800a13:	8d 70 01             	lea    0x1(%eax),%esi
  800a16:	8a 00                	mov    (%eax),%al
  800a18:	0f be d8             	movsbl %al,%ebx
  800a1b:	85 db                	test   %ebx,%ebx
  800a1d:	74 24                	je     800a43 <vprintfmt+0x24b>
  800a1f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a23:	78 b8                	js     8009dd <vprintfmt+0x1e5>
  800a25:	ff 4d e0             	decl   -0x20(%ebp)
  800a28:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a2c:	79 af                	jns    8009dd <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a2e:	eb 13                	jmp    800a43 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a30:	83 ec 08             	sub    $0x8,%esp
  800a33:	ff 75 0c             	pushl  0xc(%ebp)
  800a36:	6a 20                	push   $0x20
  800a38:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3b:	ff d0                	call   *%eax
  800a3d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a40:	ff 4d e4             	decl   -0x1c(%ebp)
  800a43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a47:	7f e7                	jg     800a30 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a49:	e9 78 01 00 00       	jmp    800bc6 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a4e:	83 ec 08             	sub    $0x8,%esp
  800a51:	ff 75 e8             	pushl  -0x18(%ebp)
  800a54:	8d 45 14             	lea    0x14(%ebp),%eax
  800a57:	50                   	push   %eax
  800a58:	e8 3c fd ff ff       	call   800799 <getint>
  800a5d:	83 c4 10             	add    $0x10,%esp
  800a60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a63:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a66:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a69:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a6c:	85 d2                	test   %edx,%edx
  800a6e:	79 23                	jns    800a93 <vprintfmt+0x29b>
				putch('-', putdat);
  800a70:	83 ec 08             	sub    $0x8,%esp
  800a73:	ff 75 0c             	pushl  0xc(%ebp)
  800a76:	6a 2d                	push   $0x2d
  800a78:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7b:	ff d0                	call   *%eax
  800a7d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a80:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a83:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a86:	f7 d8                	neg    %eax
  800a88:	83 d2 00             	adc    $0x0,%edx
  800a8b:	f7 da                	neg    %edx
  800a8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a90:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a93:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a9a:	e9 bc 00 00 00       	jmp    800b5b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a9f:	83 ec 08             	sub    $0x8,%esp
  800aa2:	ff 75 e8             	pushl  -0x18(%ebp)
  800aa5:	8d 45 14             	lea    0x14(%ebp),%eax
  800aa8:	50                   	push   %eax
  800aa9:	e8 84 fc ff ff       	call   800732 <getuint>
  800aae:	83 c4 10             	add    $0x10,%esp
  800ab1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ab4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ab7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800abe:	e9 98 00 00 00       	jmp    800b5b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ac3:	83 ec 08             	sub    $0x8,%esp
  800ac6:	ff 75 0c             	pushl  0xc(%ebp)
  800ac9:	6a 58                	push   $0x58
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	ff d0                	call   *%eax
  800ad0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ad3:	83 ec 08             	sub    $0x8,%esp
  800ad6:	ff 75 0c             	pushl  0xc(%ebp)
  800ad9:	6a 58                	push   $0x58
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	ff d0                	call   *%eax
  800ae0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ae3:	83 ec 08             	sub    $0x8,%esp
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	6a 58                	push   $0x58
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	ff d0                	call   *%eax
  800af0:	83 c4 10             	add    $0x10,%esp
			break;
  800af3:	e9 ce 00 00 00       	jmp    800bc6 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800af8:	83 ec 08             	sub    $0x8,%esp
  800afb:	ff 75 0c             	pushl  0xc(%ebp)
  800afe:	6a 30                	push   $0x30
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	ff d0                	call   *%eax
  800b05:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b08:	83 ec 08             	sub    $0x8,%esp
  800b0b:	ff 75 0c             	pushl  0xc(%ebp)
  800b0e:	6a 78                	push   $0x78
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	ff d0                	call   *%eax
  800b15:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b18:	8b 45 14             	mov    0x14(%ebp),%eax
  800b1b:	83 c0 04             	add    $0x4,%eax
  800b1e:	89 45 14             	mov    %eax,0x14(%ebp)
  800b21:	8b 45 14             	mov    0x14(%ebp),%eax
  800b24:	83 e8 04             	sub    $0x4,%eax
  800b27:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b2c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b33:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b3a:	eb 1f                	jmp    800b5b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b3c:	83 ec 08             	sub    $0x8,%esp
  800b3f:	ff 75 e8             	pushl  -0x18(%ebp)
  800b42:	8d 45 14             	lea    0x14(%ebp),%eax
  800b45:	50                   	push   %eax
  800b46:	e8 e7 fb ff ff       	call   800732 <getuint>
  800b4b:	83 c4 10             	add    $0x10,%esp
  800b4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b51:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b54:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b5b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b5f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b62:	83 ec 04             	sub    $0x4,%esp
  800b65:	52                   	push   %edx
  800b66:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b69:	50                   	push   %eax
  800b6a:	ff 75 f4             	pushl  -0xc(%ebp)
  800b6d:	ff 75 f0             	pushl  -0x10(%ebp)
  800b70:	ff 75 0c             	pushl  0xc(%ebp)
  800b73:	ff 75 08             	pushl  0x8(%ebp)
  800b76:	e8 00 fb ff ff       	call   80067b <printnum>
  800b7b:	83 c4 20             	add    $0x20,%esp
			break;
  800b7e:	eb 46                	jmp    800bc6 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b80:	83 ec 08             	sub    $0x8,%esp
  800b83:	ff 75 0c             	pushl  0xc(%ebp)
  800b86:	53                   	push   %ebx
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8a:	ff d0                	call   *%eax
  800b8c:	83 c4 10             	add    $0x10,%esp
			break;
  800b8f:	eb 35                	jmp    800bc6 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800b91:	c6 05 40 30 80 00 00 	movb   $0x0,0x803040
			break;
  800b98:	eb 2c                	jmp    800bc6 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800b9a:	c6 05 40 30 80 00 01 	movb   $0x1,0x803040
			break;
  800ba1:	eb 23                	jmp    800bc6 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ba3:	83 ec 08             	sub    $0x8,%esp
  800ba6:	ff 75 0c             	pushl  0xc(%ebp)
  800ba9:	6a 25                	push   $0x25
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	ff d0                	call   *%eax
  800bb0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bb3:	ff 4d 10             	decl   0x10(%ebp)
  800bb6:	eb 03                	jmp    800bbb <vprintfmt+0x3c3>
  800bb8:	ff 4d 10             	decl   0x10(%ebp)
  800bbb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbe:	48                   	dec    %eax
  800bbf:	8a 00                	mov    (%eax),%al
  800bc1:	3c 25                	cmp    $0x25,%al
  800bc3:	75 f3                	jne    800bb8 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800bc5:	90                   	nop
		}
	}
  800bc6:	e9 35 fc ff ff       	jmp    800800 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800bcb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800bcc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800bcf:	5b                   	pop    %ebx
  800bd0:	5e                   	pop    %esi
  800bd1:	5d                   	pop    %ebp
  800bd2:	c3                   	ret    

00800bd3 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800bd3:	55                   	push   %ebp
  800bd4:	89 e5                	mov    %esp,%ebp
  800bd6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800bd9:	8d 45 10             	lea    0x10(%ebp),%eax
  800bdc:	83 c0 04             	add    $0x4,%eax
  800bdf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800be2:	8b 45 10             	mov    0x10(%ebp),%eax
  800be5:	ff 75 f4             	pushl  -0xc(%ebp)
  800be8:	50                   	push   %eax
  800be9:	ff 75 0c             	pushl  0xc(%ebp)
  800bec:	ff 75 08             	pushl  0x8(%ebp)
  800bef:	e8 04 fc ff ff       	call   8007f8 <vprintfmt>
  800bf4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bf7:	90                   	nop
  800bf8:	c9                   	leave  
  800bf9:	c3                   	ret    

00800bfa <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bfa:	55                   	push   %ebp
  800bfb:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c00:	8b 40 08             	mov    0x8(%eax),%eax
  800c03:	8d 50 01             	lea    0x1(%eax),%edx
  800c06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c09:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0f:	8b 10                	mov    (%eax),%edx
  800c11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c14:	8b 40 04             	mov    0x4(%eax),%eax
  800c17:	39 c2                	cmp    %eax,%edx
  800c19:	73 12                	jae    800c2d <sprintputch+0x33>
		*b->buf++ = ch;
  800c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1e:	8b 00                	mov    (%eax),%eax
  800c20:	8d 48 01             	lea    0x1(%eax),%ecx
  800c23:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c26:	89 0a                	mov    %ecx,(%edx)
  800c28:	8b 55 08             	mov    0x8(%ebp),%edx
  800c2b:	88 10                	mov    %dl,(%eax)
}
  800c2d:	90                   	nop
  800c2e:	5d                   	pop    %ebp
  800c2f:	c3                   	ret    

00800c30 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c30:	55                   	push   %ebp
  800c31:	89 e5                	mov    %esp,%ebp
  800c33:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c36:	8b 45 08             	mov    0x8(%ebp),%eax
  800c39:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	01 d0                	add    %edx,%eax
  800c47:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c4a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c51:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c55:	74 06                	je     800c5d <vsnprintf+0x2d>
  800c57:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c5b:	7f 07                	jg     800c64 <vsnprintf+0x34>
		return -E_INVAL;
  800c5d:	b8 03 00 00 00       	mov    $0x3,%eax
  800c62:	eb 20                	jmp    800c84 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c64:	ff 75 14             	pushl  0x14(%ebp)
  800c67:	ff 75 10             	pushl  0x10(%ebp)
  800c6a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c6d:	50                   	push   %eax
  800c6e:	68 fa 0b 80 00       	push   $0x800bfa
  800c73:	e8 80 fb ff ff       	call   8007f8 <vprintfmt>
  800c78:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c7e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c81:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c84:	c9                   	leave  
  800c85:	c3                   	ret    

00800c86 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c86:	55                   	push   %ebp
  800c87:	89 e5                	mov    %esp,%ebp
  800c89:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c8c:	8d 45 10             	lea    0x10(%ebp),%eax
  800c8f:	83 c0 04             	add    $0x4,%eax
  800c92:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c95:	8b 45 10             	mov    0x10(%ebp),%eax
  800c98:	ff 75 f4             	pushl  -0xc(%ebp)
  800c9b:	50                   	push   %eax
  800c9c:	ff 75 0c             	pushl  0xc(%ebp)
  800c9f:	ff 75 08             	pushl  0x8(%ebp)
  800ca2:	e8 89 ff ff ff       	call   800c30 <vsnprintf>
  800ca7:	83 c4 10             	add    $0x10,%esp
  800caa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800cad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cb0:	c9                   	leave  
  800cb1:	c3                   	ret    

00800cb2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cb2:	55                   	push   %ebp
  800cb3:	89 e5                	mov    %esp,%ebp
  800cb5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cb8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cbf:	eb 06                	jmp    800cc7 <strlen+0x15>
		n++;
  800cc1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800cc4:	ff 45 08             	incl   0x8(%ebp)
  800cc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cca:	8a 00                	mov    (%eax),%al
  800ccc:	84 c0                	test   %al,%al
  800cce:	75 f1                	jne    800cc1 <strlen+0xf>
		n++;
	return n;
  800cd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cd3:	c9                   	leave  
  800cd4:	c3                   	ret    

00800cd5 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800cd5:	55                   	push   %ebp
  800cd6:	89 e5                	mov    %esp,%ebp
  800cd8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cdb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ce2:	eb 09                	jmp    800ced <strnlen+0x18>
		n++;
  800ce4:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ce7:	ff 45 08             	incl   0x8(%ebp)
  800cea:	ff 4d 0c             	decl   0xc(%ebp)
  800ced:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cf1:	74 09                	je     800cfc <strnlen+0x27>
  800cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf6:	8a 00                	mov    (%eax),%al
  800cf8:	84 c0                	test   %al,%al
  800cfa:	75 e8                	jne    800ce4 <strnlen+0xf>
		n++;
	return n;
  800cfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cff:	c9                   	leave  
  800d00:	c3                   	ret    

00800d01 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d01:	55                   	push   %ebp
  800d02:	89 e5                	mov    %esp,%ebp
  800d04:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d0d:	90                   	nop
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	8d 50 01             	lea    0x1(%eax),%edx
  800d14:	89 55 08             	mov    %edx,0x8(%ebp)
  800d17:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d1a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d1d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d20:	8a 12                	mov    (%edx),%dl
  800d22:	88 10                	mov    %dl,(%eax)
  800d24:	8a 00                	mov    (%eax),%al
  800d26:	84 c0                	test   %al,%al
  800d28:	75 e4                	jne    800d0e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d2d:	c9                   	leave  
  800d2e:	c3                   	ret    

00800d2f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d2f:	55                   	push   %ebp
  800d30:	89 e5                	mov    %esp,%ebp
  800d32:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d3b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d42:	eb 1f                	jmp    800d63 <strncpy+0x34>
		*dst++ = *src;
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8d 50 01             	lea    0x1(%eax),%edx
  800d4a:	89 55 08             	mov    %edx,0x8(%ebp)
  800d4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d50:	8a 12                	mov    (%edx),%dl
  800d52:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	84 c0                	test   %al,%al
  800d5b:	74 03                	je     800d60 <strncpy+0x31>
			src++;
  800d5d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d60:	ff 45 fc             	incl   -0x4(%ebp)
  800d63:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d66:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d69:	72 d9                	jb     800d44 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d6e:	c9                   	leave  
  800d6f:	c3                   	ret    

00800d70 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d70:	55                   	push   %ebp
  800d71:	89 e5                	mov    %esp,%ebp
  800d73:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d7c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d80:	74 30                	je     800db2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d82:	eb 16                	jmp    800d9a <strlcpy+0x2a>
			*dst++ = *src++;
  800d84:	8b 45 08             	mov    0x8(%ebp),%eax
  800d87:	8d 50 01             	lea    0x1(%eax),%edx
  800d8a:	89 55 08             	mov    %edx,0x8(%ebp)
  800d8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d90:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d93:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d96:	8a 12                	mov    (%edx),%dl
  800d98:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d9a:	ff 4d 10             	decl   0x10(%ebp)
  800d9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800da1:	74 09                	je     800dac <strlcpy+0x3c>
  800da3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da6:	8a 00                	mov    (%eax),%al
  800da8:	84 c0                	test   %al,%al
  800daa:	75 d8                	jne    800d84 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800dac:	8b 45 08             	mov    0x8(%ebp),%eax
  800daf:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800db2:	8b 55 08             	mov    0x8(%ebp),%edx
  800db5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db8:	29 c2                	sub    %eax,%edx
  800dba:	89 d0                	mov    %edx,%eax
}
  800dbc:	c9                   	leave  
  800dbd:	c3                   	ret    

00800dbe <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800dbe:	55                   	push   %ebp
  800dbf:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800dc1:	eb 06                	jmp    800dc9 <strcmp+0xb>
		p++, q++;
  800dc3:	ff 45 08             	incl   0x8(%ebp)
  800dc6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800dc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcc:	8a 00                	mov    (%eax),%al
  800dce:	84 c0                	test   %al,%al
  800dd0:	74 0e                	je     800de0 <strcmp+0x22>
  800dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd5:	8a 10                	mov    (%eax),%dl
  800dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dda:	8a 00                	mov    (%eax),%al
  800ddc:	38 c2                	cmp    %al,%dl
  800dde:	74 e3                	je     800dc3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	8a 00                	mov    (%eax),%al
  800de5:	0f b6 d0             	movzbl %al,%edx
  800de8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800deb:	8a 00                	mov    (%eax),%al
  800ded:	0f b6 c0             	movzbl %al,%eax
  800df0:	29 c2                	sub    %eax,%edx
  800df2:	89 d0                	mov    %edx,%eax
}
  800df4:	5d                   	pop    %ebp
  800df5:	c3                   	ret    

00800df6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800df6:	55                   	push   %ebp
  800df7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800df9:	eb 09                	jmp    800e04 <strncmp+0xe>
		n--, p++, q++;
  800dfb:	ff 4d 10             	decl   0x10(%ebp)
  800dfe:	ff 45 08             	incl   0x8(%ebp)
  800e01:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e04:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e08:	74 17                	je     800e21 <strncmp+0x2b>
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	8a 00                	mov    (%eax),%al
  800e0f:	84 c0                	test   %al,%al
  800e11:	74 0e                	je     800e21 <strncmp+0x2b>
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	8a 10                	mov    (%eax),%dl
  800e18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1b:	8a 00                	mov    (%eax),%al
  800e1d:	38 c2                	cmp    %al,%dl
  800e1f:	74 da                	je     800dfb <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e21:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e25:	75 07                	jne    800e2e <strncmp+0x38>
		return 0;
  800e27:	b8 00 00 00 00       	mov    $0x0,%eax
  800e2c:	eb 14                	jmp    800e42 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	8a 00                	mov    (%eax),%al
  800e33:	0f b6 d0             	movzbl %al,%edx
  800e36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e39:	8a 00                	mov    (%eax),%al
  800e3b:	0f b6 c0             	movzbl %al,%eax
  800e3e:	29 c2                	sub    %eax,%edx
  800e40:	89 d0                	mov    %edx,%eax
}
  800e42:	5d                   	pop    %ebp
  800e43:	c3                   	ret    

00800e44 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e44:	55                   	push   %ebp
  800e45:	89 e5                	mov    %esp,%ebp
  800e47:	83 ec 04             	sub    $0x4,%esp
  800e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e50:	eb 12                	jmp    800e64 <strchr+0x20>
		if (*s == c)
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
  800e55:	8a 00                	mov    (%eax),%al
  800e57:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e5a:	75 05                	jne    800e61 <strchr+0x1d>
			return (char *) s;
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	eb 11                	jmp    800e72 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e61:	ff 45 08             	incl   0x8(%ebp)
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	8a 00                	mov    (%eax),%al
  800e69:	84 c0                	test   %al,%al
  800e6b:	75 e5                	jne    800e52 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e6d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e72:	c9                   	leave  
  800e73:	c3                   	ret    

00800e74 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e74:	55                   	push   %ebp
  800e75:	89 e5                	mov    %esp,%ebp
  800e77:	83 ec 04             	sub    $0x4,%esp
  800e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e80:	eb 0d                	jmp    800e8f <strfind+0x1b>
		if (*s == c)
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	8a 00                	mov    (%eax),%al
  800e87:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e8a:	74 0e                	je     800e9a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e8c:	ff 45 08             	incl   0x8(%ebp)
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	8a 00                	mov    (%eax),%al
  800e94:	84 c0                	test   %al,%al
  800e96:	75 ea                	jne    800e82 <strfind+0xe>
  800e98:	eb 01                	jmp    800e9b <strfind+0x27>
		if (*s == c)
			break;
  800e9a:	90                   	nop
	return (char *) s;
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e9e:	c9                   	leave  
  800e9f:	c3                   	ret    

00800ea0 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800ea0:	55                   	push   %ebp
  800ea1:	89 e5                	mov    %esp,%ebp
  800ea3:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800eac:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800eb0:	76 63                	jbe    800f15 <memset+0x75>
		uint64 data_block = c;
  800eb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb5:	99                   	cltd   
  800eb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb9:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800ebc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ebf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ec2:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800ec6:	c1 e0 08             	shl    $0x8,%eax
  800ec9:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ecc:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800ecf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ed2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ed5:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800ed9:	c1 e0 10             	shl    $0x10,%eax
  800edc:	09 45 f0             	or     %eax,-0x10(%ebp)
  800edf:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800ee2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ee5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ee8:	89 c2                	mov    %eax,%edx
  800eea:	b8 00 00 00 00       	mov    $0x0,%eax
  800eef:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ef2:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800ef5:	eb 18                	jmp    800f0f <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800ef7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800efa:	8d 41 08             	lea    0x8(%ecx),%eax
  800efd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800f00:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f03:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f06:	89 01                	mov    %eax,(%ecx)
  800f08:	89 51 04             	mov    %edx,0x4(%ecx)
  800f0b:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800f0f:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f13:	77 e2                	ja     800ef7 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800f15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f19:	74 23                	je     800f3e <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800f1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f21:	eb 0e                	jmp    800f31 <memset+0x91>
			*p8++ = (uint8)c;
  800f23:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f26:	8d 50 01             	lea    0x1(%eax),%edx
  800f29:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f2f:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800f31:	8b 45 10             	mov    0x10(%ebp),%eax
  800f34:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f37:	89 55 10             	mov    %edx,0x10(%ebp)
  800f3a:	85 c0                	test   %eax,%eax
  800f3c:	75 e5                	jne    800f23 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800f3e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f41:	c9                   	leave  
  800f42:	c3                   	ret    

00800f43 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f43:	55                   	push   %ebp
  800f44:	89 e5                	mov    %esp,%ebp
  800f46:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800f49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800f55:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f59:	76 24                	jbe    800f7f <memcpy+0x3c>
		while(n >= 8){
  800f5b:	eb 1c                	jmp    800f79 <memcpy+0x36>
			*d64 = *s64;
  800f5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f60:	8b 50 04             	mov    0x4(%eax),%edx
  800f63:	8b 00                	mov    (%eax),%eax
  800f65:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f68:	89 01                	mov    %eax,(%ecx)
  800f6a:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800f6d:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800f71:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800f75:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800f79:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f7d:	77 de                	ja     800f5d <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800f7f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f83:	74 31                	je     800fb6 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  800f85:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f88:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  800f8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  800f91:	eb 16                	jmp    800fa9 <memcpy+0x66>
			*d8++ = *s8++;
  800f93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f96:	8d 50 01             	lea    0x1(%eax),%edx
  800f99:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800f9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f9f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fa2:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  800fa5:	8a 12                	mov    (%edx),%dl
  800fa7:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  800fa9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fac:	8d 50 ff             	lea    -0x1(%eax),%edx
  800faf:	89 55 10             	mov    %edx,0x10(%ebp)
  800fb2:	85 c0                	test   %eax,%eax
  800fb4:	75 dd                	jne    800f93 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  800fb6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fb9:	c9                   	leave  
  800fba:	c3                   	ret    

00800fbb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fbb:	55                   	push   %ebp
  800fbc:	89 e5                	mov    %esp,%ebp
  800fbe:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fcd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fd0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fd3:	73 50                	jae    801025 <memmove+0x6a>
  800fd5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdb:	01 d0                	add    %edx,%eax
  800fdd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fe0:	76 43                	jbe    801025 <memmove+0x6a>
		s += n;
  800fe2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800fe8:	8b 45 10             	mov    0x10(%ebp),%eax
  800feb:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fee:	eb 10                	jmp    801000 <memmove+0x45>
			*--d = *--s;
  800ff0:	ff 4d f8             	decl   -0x8(%ebp)
  800ff3:	ff 4d fc             	decl   -0x4(%ebp)
  800ff6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff9:	8a 10                	mov    (%eax),%dl
  800ffb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ffe:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801000:	8b 45 10             	mov    0x10(%ebp),%eax
  801003:	8d 50 ff             	lea    -0x1(%eax),%edx
  801006:	89 55 10             	mov    %edx,0x10(%ebp)
  801009:	85 c0                	test   %eax,%eax
  80100b:	75 e3                	jne    800ff0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80100d:	eb 23                	jmp    801032 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80100f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801012:	8d 50 01             	lea    0x1(%eax),%edx
  801015:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801018:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80101b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80101e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801021:	8a 12                	mov    (%edx),%dl
  801023:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801025:	8b 45 10             	mov    0x10(%ebp),%eax
  801028:	8d 50 ff             	lea    -0x1(%eax),%edx
  80102b:	89 55 10             	mov    %edx,0x10(%ebp)
  80102e:	85 c0                	test   %eax,%eax
  801030:	75 dd                	jne    80100f <memmove+0x54>
			*d++ = *s++;

	return dst;
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801035:	c9                   	leave  
  801036:	c3                   	ret    

00801037 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801037:	55                   	push   %ebp
  801038:	89 e5                	mov    %esp,%ebp
  80103a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
  801040:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801043:	8b 45 0c             	mov    0xc(%ebp),%eax
  801046:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801049:	eb 2a                	jmp    801075 <memcmp+0x3e>
		if (*s1 != *s2)
  80104b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80104e:	8a 10                	mov    (%eax),%dl
  801050:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801053:	8a 00                	mov    (%eax),%al
  801055:	38 c2                	cmp    %al,%dl
  801057:	74 16                	je     80106f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801059:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80105c:	8a 00                	mov    (%eax),%al
  80105e:	0f b6 d0             	movzbl %al,%edx
  801061:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801064:	8a 00                	mov    (%eax),%al
  801066:	0f b6 c0             	movzbl %al,%eax
  801069:	29 c2                	sub    %eax,%edx
  80106b:	89 d0                	mov    %edx,%eax
  80106d:	eb 18                	jmp    801087 <memcmp+0x50>
		s1++, s2++;
  80106f:	ff 45 fc             	incl   -0x4(%ebp)
  801072:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801075:	8b 45 10             	mov    0x10(%ebp),%eax
  801078:	8d 50 ff             	lea    -0x1(%eax),%edx
  80107b:	89 55 10             	mov    %edx,0x10(%ebp)
  80107e:	85 c0                	test   %eax,%eax
  801080:	75 c9                	jne    80104b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801082:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801087:	c9                   	leave  
  801088:	c3                   	ret    

00801089 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801089:	55                   	push   %ebp
  80108a:	89 e5                	mov    %esp,%ebp
  80108c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80108f:	8b 55 08             	mov    0x8(%ebp),%edx
  801092:	8b 45 10             	mov    0x10(%ebp),%eax
  801095:	01 d0                	add    %edx,%eax
  801097:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80109a:	eb 15                	jmp    8010b1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80109c:	8b 45 08             	mov    0x8(%ebp),%eax
  80109f:	8a 00                	mov    (%eax),%al
  8010a1:	0f b6 d0             	movzbl %al,%edx
  8010a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a7:	0f b6 c0             	movzbl %al,%eax
  8010aa:	39 c2                	cmp    %eax,%edx
  8010ac:	74 0d                	je     8010bb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010ae:	ff 45 08             	incl   0x8(%ebp)
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010b7:	72 e3                	jb     80109c <memfind+0x13>
  8010b9:	eb 01                	jmp    8010bc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010bb:	90                   	nop
	return (void *) s;
  8010bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010bf:	c9                   	leave  
  8010c0:	c3                   	ret    

008010c1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010c1:	55                   	push   %ebp
  8010c2:	89 e5                	mov    %esp,%ebp
  8010c4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010ce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010d5:	eb 03                	jmp    8010da <strtol+0x19>
		s++;
  8010d7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010da:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dd:	8a 00                	mov    (%eax),%al
  8010df:	3c 20                	cmp    $0x20,%al
  8010e1:	74 f4                	je     8010d7 <strtol+0x16>
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	8a 00                	mov    (%eax),%al
  8010e8:	3c 09                	cmp    $0x9,%al
  8010ea:	74 eb                	je     8010d7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	8a 00                	mov    (%eax),%al
  8010f1:	3c 2b                	cmp    $0x2b,%al
  8010f3:	75 05                	jne    8010fa <strtol+0x39>
		s++;
  8010f5:	ff 45 08             	incl   0x8(%ebp)
  8010f8:	eb 13                	jmp    80110d <strtol+0x4c>
	else if (*s == '-')
  8010fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fd:	8a 00                	mov    (%eax),%al
  8010ff:	3c 2d                	cmp    $0x2d,%al
  801101:	75 0a                	jne    80110d <strtol+0x4c>
		s++, neg = 1;
  801103:	ff 45 08             	incl   0x8(%ebp)
  801106:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80110d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801111:	74 06                	je     801119 <strtol+0x58>
  801113:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801117:	75 20                	jne    801139 <strtol+0x78>
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	8a 00                	mov    (%eax),%al
  80111e:	3c 30                	cmp    $0x30,%al
  801120:	75 17                	jne    801139 <strtol+0x78>
  801122:	8b 45 08             	mov    0x8(%ebp),%eax
  801125:	40                   	inc    %eax
  801126:	8a 00                	mov    (%eax),%al
  801128:	3c 78                	cmp    $0x78,%al
  80112a:	75 0d                	jne    801139 <strtol+0x78>
		s += 2, base = 16;
  80112c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801130:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801137:	eb 28                	jmp    801161 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801139:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80113d:	75 15                	jne    801154 <strtol+0x93>
  80113f:	8b 45 08             	mov    0x8(%ebp),%eax
  801142:	8a 00                	mov    (%eax),%al
  801144:	3c 30                	cmp    $0x30,%al
  801146:	75 0c                	jne    801154 <strtol+0x93>
		s++, base = 8;
  801148:	ff 45 08             	incl   0x8(%ebp)
  80114b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801152:	eb 0d                	jmp    801161 <strtol+0xa0>
	else if (base == 0)
  801154:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801158:	75 07                	jne    801161 <strtol+0xa0>
		base = 10;
  80115a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	8a 00                	mov    (%eax),%al
  801166:	3c 2f                	cmp    $0x2f,%al
  801168:	7e 19                	jle    801183 <strtol+0xc2>
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	3c 39                	cmp    $0x39,%al
  801171:	7f 10                	jg     801183 <strtol+0xc2>
			dig = *s - '0';
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8a 00                	mov    (%eax),%al
  801178:	0f be c0             	movsbl %al,%eax
  80117b:	83 e8 30             	sub    $0x30,%eax
  80117e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801181:	eb 42                	jmp    8011c5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	8a 00                	mov    (%eax),%al
  801188:	3c 60                	cmp    $0x60,%al
  80118a:	7e 19                	jle    8011a5 <strtol+0xe4>
  80118c:	8b 45 08             	mov    0x8(%ebp),%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	3c 7a                	cmp    $0x7a,%al
  801193:	7f 10                	jg     8011a5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	0f be c0             	movsbl %al,%eax
  80119d:	83 e8 57             	sub    $0x57,%eax
  8011a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011a3:	eb 20                	jmp    8011c5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	3c 40                	cmp    $0x40,%al
  8011ac:	7e 39                	jle    8011e7 <strtol+0x126>
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	8a 00                	mov    (%eax),%al
  8011b3:	3c 5a                	cmp    $0x5a,%al
  8011b5:	7f 30                	jg     8011e7 <strtol+0x126>
			dig = *s - 'A' + 10;
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ba:	8a 00                	mov    (%eax),%al
  8011bc:	0f be c0             	movsbl %al,%eax
  8011bf:	83 e8 37             	sub    $0x37,%eax
  8011c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011c8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011cb:	7d 19                	jge    8011e6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011cd:	ff 45 08             	incl   0x8(%ebp)
  8011d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011d3:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011d7:	89 c2                	mov    %eax,%edx
  8011d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011dc:	01 d0                	add    %edx,%eax
  8011de:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011e1:	e9 7b ff ff ff       	jmp    801161 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011e6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011eb:	74 08                	je     8011f5 <strtol+0x134>
		*endptr = (char *) s;
  8011ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f0:	8b 55 08             	mov    0x8(%ebp),%edx
  8011f3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011f5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011f9:	74 07                	je     801202 <strtol+0x141>
  8011fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011fe:	f7 d8                	neg    %eax
  801200:	eb 03                	jmp    801205 <strtol+0x144>
  801202:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801205:	c9                   	leave  
  801206:	c3                   	ret    

00801207 <ltostr>:

void
ltostr(long value, char *str)
{
  801207:	55                   	push   %ebp
  801208:	89 e5                	mov    %esp,%ebp
  80120a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80120d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801214:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80121b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80121f:	79 13                	jns    801234 <ltostr+0x2d>
	{
		neg = 1;
  801221:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801228:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80122e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801231:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801234:	8b 45 08             	mov    0x8(%ebp),%eax
  801237:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80123c:	99                   	cltd   
  80123d:	f7 f9                	idiv   %ecx
  80123f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801242:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801245:	8d 50 01             	lea    0x1(%eax),%edx
  801248:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80124b:	89 c2                	mov    %eax,%edx
  80124d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801250:	01 d0                	add    %edx,%eax
  801252:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801255:	83 c2 30             	add    $0x30,%edx
  801258:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80125a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80125d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801262:	f7 e9                	imul   %ecx
  801264:	c1 fa 02             	sar    $0x2,%edx
  801267:	89 c8                	mov    %ecx,%eax
  801269:	c1 f8 1f             	sar    $0x1f,%eax
  80126c:	29 c2                	sub    %eax,%edx
  80126e:	89 d0                	mov    %edx,%eax
  801270:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801273:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801277:	75 bb                	jne    801234 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801279:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801280:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801283:	48                   	dec    %eax
  801284:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801287:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80128b:	74 3d                	je     8012ca <ltostr+0xc3>
		start = 1 ;
  80128d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801294:	eb 34                	jmp    8012ca <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801296:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801299:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129c:	01 d0                	add    %edx,%eax
  80129e:	8a 00                	mov    (%eax),%al
  8012a0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a9:	01 c2                	add    %eax,%edx
  8012ab:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b1:	01 c8                	add    %ecx,%eax
  8012b3:	8a 00                	mov    (%eax),%al
  8012b5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012b7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bd:	01 c2                	add    %eax,%edx
  8012bf:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012c2:	88 02                	mov    %al,(%edx)
		start++ ;
  8012c4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012c7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012cd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012d0:	7c c4                	jl     801296 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012d2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d8:	01 d0                	add    %edx,%eax
  8012da:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012dd:	90                   	nop
  8012de:	c9                   	leave  
  8012df:	c3                   	ret    

008012e0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
  8012e3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012e6:	ff 75 08             	pushl  0x8(%ebp)
  8012e9:	e8 c4 f9 ff ff       	call   800cb2 <strlen>
  8012ee:	83 c4 04             	add    $0x4,%esp
  8012f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012f4:	ff 75 0c             	pushl  0xc(%ebp)
  8012f7:	e8 b6 f9 ff ff       	call   800cb2 <strlen>
  8012fc:	83 c4 04             	add    $0x4,%esp
  8012ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801302:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801309:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801310:	eb 17                	jmp    801329 <strcconcat+0x49>
		final[s] = str1[s] ;
  801312:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801315:	8b 45 10             	mov    0x10(%ebp),%eax
  801318:	01 c2                	add    %eax,%edx
  80131a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	01 c8                	add    %ecx,%eax
  801322:	8a 00                	mov    (%eax),%al
  801324:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801326:	ff 45 fc             	incl   -0x4(%ebp)
  801329:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80132f:	7c e1                	jl     801312 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801331:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801338:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80133f:	eb 1f                	jmp    801360 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801341:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801344:	8d 50 01             	lea    0x1(%eax),%edx
  801347:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80134a:	89 c2                	mov    %eax,%edx
  80134c:	8b 45 10             	mov    0x10(%ebp),%eax
  80134f:	01 c2                	add    %eax,%edx
  801351:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801354:	8b 45 0c             	mov    0xc(%ebp),%eax
  801357:	01 c8                	add    %ecx,%eax
  801359:	8a 00                	mov    (%eax),%al
  80135b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80135d:	ff 45 f8             	incl   -0x8(%ebp)
  801360:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801363:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801366:	7c d9                	jl     801341 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801368:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80136b:	8b 45 10             	mov    0x10(%ebp),%eax
  80136e:	01 d0                	add    %edx,%eax
  801370:	c6 00 00             	movb   $0x0,(%eax)
}
  801373:	90                   	nop
  801374:	c9                   	leave  
  801375:	c3                   	ret    

00801376 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801376:	55                   	push   %ebp
  801377:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801379:	8b 45 14             	mov    0x14(%ebp),%eax
  80137c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801382:	8b 45 14             	mov    0x14(%ebp),%eax
  801385:	8b 00                	mov    (%eax),%eax
  801387:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80138e:	8b 45 10             	mov    0x10(%ebp),%eax
  801391:	01 d0                	add    %edx,%eax
  801393:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801399:	eb 0c                	jmp    8013a7 <strsplit+0x31>
			*string++ = 0;
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	8d 50 01             	lea    0x1(%eax),%edx
  8013a1:	89 55 08             	mov    %edx,0x8(%ebp)
  8013a4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	8a 00                	mov    (%eax),%al
  8013ac:	84 c0                	test   %al,%al
  8013ae:	74 18                	je     8013c8 <strsplit+0x52>
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	8a 00                	mov    (%eax),%al
  8013b5:	0f be c0             	movsbl %al,%eax
  8013b8:	50                   	push   %eax
  8013b9:	ff 75 0c             	pushl  0xc(%ebp)
  8013bc:	e8 83 fa ff ff       	call   800e44 <strchr>
  8013c1:	83 c4 08             	add    $0x8,%esp
  8013c4:	85 c0                	test   %eax,%eax
  8013c6:	75 d3                	jne    80139b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	8a 00                	mov    (%eax),%al
  8013cd:	84 c0                	test   %al,%al
  8013cf:	74 5a                	je     80142b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8013d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d4:	8b 00                	mov    (%eax),%eax
  8013d6:	83 f8 0f             	cmp    $0xf,%eax
  8013d9:	75 07                	jne    8013e2 <strsplit+0x6c>
		{
			return 0;
  8013db:	b8 00 00 00 00       	mov    $0x0,%eax
  8013e0:	eb 66                	jmp    801448 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8013e5:	8b 00                	mov    (%eax),%eax
  8013e7:	8d 48 01             	lea    0x1(%eax),%ecx
  8013ea:	8b 55 14             	mov    0x14(%ebp),%edx
  8013ed:	89 0a                	mov    %ecx,(%edx)
  8013ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f9:	01 c2                	add    %eax,%edx
  8013fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fe:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801400:	eb 03                	jmp    801405 <strsplit+0x8f>
			string++;
  801402:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801405:	8b 45 08             	mov    0x8(%ebp),%eax
  801408:	8a 00                	mov    (%eax),%al
  80140a:	84 c0                	test   %al,%al
  80140c:	74 8b                	je     801399 <strsplit+0x23>
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	8a 00                	mov    (%eax),%al
  801413:	0f be c0             	movsbl %al,%eax
  801416:	50                   	push   %eax
  801417:	ff 75 0c             	pushl  0xc(%ebp)
  80141a:	e8 25 fa ff ff       	call   800e44 <strchr>
  80141f:	83 c4 08             	add    $0x8,%esp
  801422:	85 c0                	test   %eax,%eax
  801424:	74 dc                	je     801402 <strsplit+0x8c>
			string++;
	}
  801426:	e9 6e ff ff ff       	jmp    801399 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80142b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80142c:	8b 45 14             	mov    0x14(%ebp),%eax
  80142f:	8b 00                	mov    (%eax),%eax
  801431:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801438:	8b 45 10             	mov    0x10(%ebp),%eax
  80143b:	01 d0                	add    %edx,%eax
  80143d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801443:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801448:	c9                   	leave  
  801449:	c3                   	ret    

0080144a <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80144a:	55                   	push   %ebp
  80144b:	89 e5                	mov    %esp,%ebp
  80144d:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801456:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80145d:	eb 4a                	jmp    8014a9 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  80145f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	01 c2                	add    %eax,%edx
  801467:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80146a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146d:	01 c8                	add    %ecx,%eax
  80146f:	8a 00                	mov    (%eax),%al
  801471:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801473:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801476:	8b 45 0c             	mov    0xc(%ebp),%eax
  801479:	01 d0                	add    %edx,%eax
  80147b:	8a 00                	mov    (%eax),%al
  80147d:	3c 40                	cmp    $0x40,%al
  80147f:	7e 25                	jle    8014a6 <str2lower+0x5c>
  801481:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801484:	8b 45 0c             	mov    0xc(%ebp),%eax
  801487:	01 d0                	add    %edx,%eax
  801489:	8a 00                	mov    (%eax),%al
  80148b:	3c 5a                	cmp    $0x5a,%al
  80148d:	7f 17                	jg     8014a6 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  80148f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801492:	8b 45 08             	mov    0x8(%ebp),%eax
  801495:	01 d0                	add    %edx,%eax
  801497:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80149a:	8b 55 08             	mov    0x8(%ebp),%edx
  80149d:	01 ca                	add    %ecx,%edx
  80149f:	8a 12                	mov    (%edx),%dl
  8014a1:	83 c2 20             	add    $0x20,%edx
  8014a4:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8014a6:	ff 45 fc             	incl   -0x4(%ebp)
  8014a9:	ff 75 0c             	pushl  0xc(%ebp)
  8014ac:	e8 01 f8 ff ff       	call   800cb2 <strlen>
  8014b1:	83 c4 04             	add    $0x4,%esp
  8014b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8014b7:	7f a6                	jg     80145f <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8014b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014bc:	c9                   	leave  
  8014bd:	c3                   	ret    

008014be <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014be:	55                   	push   %ebp
  8014bf:	89 e5                	mov    %esp,%ebp
  8014c1:	57                   	push   %edi
  8014c2:	56                   	push   %esi
  8014c3:	53                   	push   %ebx
  8014c4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014cd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014d0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014d3:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014d6:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014d9:	cd 30                	int    $0x30
  8014db:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014e1:	83 c4 10             	add    $0x10,%esp
  8014e4:	5b                   	pop    %ebx
  8014e5:	5e                   	pop    %esi
  8014e6:	5f                   	pop    %edi
  8014e7:	5d                   	pop    %ebp
  8014e8:	c3                   	ret    

008014e9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 04             	sub    $0x4,%esp
  8014ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  8014f5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014f8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ff:	6a 00                	push   $0x0
  801501:	51                   	push   %ecx
  801502:	52                   	push   %edx
  801503:	ff 75 0c             	pushl  0xc(%ebp)
  801506:	50                   	push   %eax
  801507:	6a 00                	push   $0x0
  801509:	e8 b0 ff ff ff       	call   8014be <syscall>
  80150e:	83 c4 18             	add    $0x18,%esp
}
  801511:	90                   	nop
  801512:	c9                   	leave  
  801513:	c3                   	ret    

00801514 <sys_cgetc>:

int
sys_cgetc(void)
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 02                	push   $0x2
  801523:	e8 96 ff ff ff       	call   8014be <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <sys_lock_cons>:

void sys_lock_cons(void)
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 03                	push   $0x3
  80153c:	e8 7d ff ff ff       	call   8014be <syscall>
  801541:	83 c4 18             	add    $0x18,%esp
}
  801544:	90                   	nop
  801545:	c9                   	leave  
  801546:	c3                   	ret    

00801547 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 04                	push   $0x4
  801556:	e8 63 ff ff ff       	call   8014be <syscall>
  80155b:	83 c4 18             	add    $0x18,%esp
}
  80155e:	90                   	nop
  80155f:	c9                   	leave  
  801560:	c3                   	ret    

00801561 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801561:	55                   	push   %ebp
  801562:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801564:	8b 55 0c             	mov    0xc(%ebp),%edx
  801567:	8b 45 08             	mov    0x8(%ebp),%eax
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	52                   	push   %edx
  801571:	50                   	push   %eax
  801572:	6a 08                	push   $0x8
  801574:	e8 45 ff ff ff       	call   8014be <syscall>
  801579:	83 c4 18             	add    $0x18,%esp
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
  801581:	56                   	push   %esi
  801582:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801583:	8b 75 18             	mov    0x18(%ebp),%esi
  801586:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801589:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80158c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	56                   	push   %esi
  801593:	53                   	push   %ebx
  801594:	51                   	push   %ecx
  801595:	52                   	push   %edx
  801596:	50                   	push   %eax
  801597:	6a 09                	push   $0x9
  801599:	e8 20 ff ff ff       	call   8014be <syscall>
  80159e:	83 c4 18             	add    $0x18,%esp
}
  8015a1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015a4:	5b                   	pop    %ebx
  8015a5:	5e                   	pop    %esi
  8015a6:	5d                   	pop    %ebp
  8015a7:	c3                   	ret    

008015a8 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8015a8:	55                   	push   %ebp
  8015a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	ff 75 08             	pushl  0x8(%ebp)
  8015b6:	6a 0a                	push   $0xa
  8015b8:	e8 01 ff ff ff       	call   8014be <syscall>
  8015bd:	83 c4 18             	add    $0x18,%esp
}
  8015c0:	c9                   	leave  
  8015c1:	c3                   	ret    

008015c2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8015c2:	55                   	push   %ebp
  8015c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	ff 75 0c             	pushl  0xc(%ebp)
  8015ce:	ff 75 08             	pushl  0x8(%ebp)
  8015d1:	6a 0b                	push   $0xb
  8015d3:	e8 e6 fe ff ff       	call   8014be <syscall>
  8015d8:	83 c4 18             	add    $0x18,%esp
}
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 0c                	push   $0xc
  8015ec:	e8 cd fe ff ff       	call   8014be <syscall>
  8015f1:	83 c4 18             	add    $0x18,%esp
}
  8015f4:	c9                   	leave  
  8015f5:	c3                   	ret    

008015f6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015f6:	55                   	push   %ebp
  8015f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 0d                	push   $0xd
  801605:	e8 b4 fe ff ff       	call   8014be <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 0e                	push   $0xe
  80161e:	e8 9b fe ff ff       	call   8014be <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
}
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 0f                	push   $0xf
  801637:	e8 82 fe ff ff       	call   8014be <syscall>
  80163c:	83 c4 18             	add    $0x18,%esp
}
  80163f:	c9                   	leave  
  801640:	c3                   	ret    

00801641 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	ff 75 08             	pushl  0x8(%ebp)
  80164f:	6a 10                	push   $0x10
  801651:	e8 68 fe ff ff       	call   8014be <syscall>
  801656:	83 c4 18             	add    $0x18,%esp
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 11                	push   $0x11
  80166a:	e8 4f fe ff ff       	call   8014be <syscall>
  80166f:	83 c4 18             	add    $0x18,%esp
}
  801672:	90                   	nop
  801673:	c9                   	leave  
  801674:	c3                   	ret    

00801675 <sys_cputc>:

void
sys_cputc(const char c)
{
  801675:	55                   	push   %ebp
  801676:	89 e5                	mov    %esp,%ebp
  801678:	83 ec 04             	sub    $0x4,%esp
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801681:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	50                   	push   %eax
  80168e:	6a 01                	push   $0x1
  801690:	e8 29 fe ff ff       	call   8014be <syscall>
  801695:	83 c4 18             	add    $0x18,%esp
}
  801698:	90                   	nop
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 14                	push   $0x14
  8016aa:	e8 0f fe ff ff       	call   8014be <syscall>
  8016af:	83 c4 18             	add    $0x18,%esp
}
  8016b2:	90                   	nop
  8016b3:	c9                   	leave  
  8016b4:	c3                   	ret    

008016b5 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  8016b5:	55                   	push   %ebp
  8016b6:	89 e5                	mov    %esp,%ebp
  8016b8:	83 ec 04             	sub    $0x4,%esp
  8016bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8016be:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  8016c1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8016c4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cb:	6a 00                	push   $0x0
  8016cd:	51                   	push   %ecx
  8016ce:	52                   	push   %edx
  8016cf:	ff 75 0c             	pushl  0xc(%ebp)
  8016d2:	50                   	push   %eax
  8016d3:	6a 15                	push   $0x15
  8016d5:	e8 e4 fd ff ff       	call   8014be <syscall>
  8016da:	83 c4 18             	add    $0x18,%esp
}
  8016dd:	c9                   	leave  
  8016de:	c3                   	ret    

008016df <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  8016df:	55                   	push   %ebp
  8016e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  8016e2:	8b 55 10             	mov    0x10(%ebp),%edx
  8016e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	52                   	push   %edx
  8016ed:	50                   	push   %eax
  8016ee:	ff 75 08             	pushl  0x8(%ebp)
  8016f1:	6a 16                	push   $0x16
  8016f3:	e8 c6 fd ff ff       	call   8014be <syscall>
  8016f8:	83 c4 18             	add    $0x18,%esp
}
  8016fb:	c9                   	leave  
  8016fc:	c3                   	ret    

008016fd <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8016fd:	55                   	push   %ebp
  8016fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801700:	8b 55 0c             	mov    0xc(%ebp),%edx
  801703:	8b 45 08             	mov    0x8(%ebp),%eax
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	52                   	push   %edx
  80170d:	50                   	push   %eax
  80170e:	6a 17                	push   $0x17
  801710:	e8 a9 fd ff ff       	call   8014be <syscall>
  801715:	83 c4 18             	add    $0x18,%esp
}
  801718:	c9                   	leave  
  801719:	c3                   	ret    

0080171a <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  80171a:	55                   	push   %ebp
  80171b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80171d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801720:	8b 45 08             	mov    0x8(%ebp),%eax
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	52                   	push   %edx
  80172a:	50                   	push   %eax
  80172b:	6a 18                	push   $0x18
  80172d:	e8 8c fd ff ff       	call   8014be <syscall>
  801732:	83 c4 18             	add    $0x18,%esp
}
  801735:	c9                   	leave  
  801736:	c3                   	ret    

00801737 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801737:	55                   	push   %ebp
  801738:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80173a:	8b 45 08             	mov    0x8(%ebp),%eax
  80173d:	6a 00                	push   $0x0
  80173f:	ff 75 14             	pushl  0x14(%ebp)
  801742:	ff 75 10             	pushl  0x10(%ebp)
  801745:	ff 75 0c             	pushl  0xc(%ebp)
  801748:	50                   	push   %eax
  801749:	6a 19                	push   $0x19
  80174b:	e8 6e fd ff ff       	call   8014be <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
}
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <sys_run_env>:

void sys_run_env(int32 envId)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801758:	8b 45 08             	mov    0x8(%ebp),%eax
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	50                   	push   %eax
  801764:	6a 1a                	push   $0x1a
  801766:	e8 53 fd ff ff       	call   8014be <syscall>
  80176b:	83 c4 18             	add    $0x18,%esp
}
  80176e:	90                   	nop
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801774:	8b 45 08             	mov    0x8(%ebp),%eax
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	50                   	push   %eax
  801780:	6a 1b                	push   $0x1b
  801782:	e8 37 fd ff ff       	call   8014be <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <sys_getenvid>:

int32 sys_getenvid(void)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 05                	push   $0x5
  80179b:	e8 1e fd ff ff       	call   8014be <syscall>
  8017a0:	83 c4 18             	add    $0x18,%esp
}
  8017a3:	c9                   	leave  
  8017a4:	c3                   	ret    

008017a5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017a5:	55                   	push   %ebp
  8017a6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 06                	push   $0x6
  8017b4:	e8 05 fd ff ff       	call   8014be <syscall>
  8017b9:	83 c4 18             	add    $0x18,%esp
}
  8017bc:	c9                   	leave  
  8017bd:	c3                   	ret    

008017be <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017be:	55                   	push   %ebp
  8017bf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 07                	push   $0x7
  8017cd:	e8 ec fc ff ff       	call   8014be <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
}
  8017d5:	c9                   	leave  
  8017d6:	c3                   	ret    

008017d7 <sys_exit_env>:


void sys_exit_env(void)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 1c                	push   $0x1c
  8017e6:	e8 d3 fc ff ff       	call   8014be <syscall>
  8017eb:	83 c4 18             	add    $0x18,%esp
}
  8017ee:	90                   	nop
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	ff 75 10             	pushl  0x10(%ebp)
  8017fb:	ff 75 0c             	pushl  0xc(%ebp)
  8017fe:	ff 75 08             	pushl  0x8(%ebp)
  801801:	6a 13                	push   $0x13
  801803:	e8 b6 fc ff ff       	call   8014be <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
	return ;
  80180b:	90                   	nop
}
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <sys_rcr2>:
uint32 sys_rcr2()
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	6a 00                	push   $0x0
  80181b:	6a 1e                	push   $0x1e
  80181d:	e8 9c fc ff ff       	call   8014be <syscall>
  801822:	83 c4 18             	add    $0x18,%esp
}
  801825:	c9                   	leave  
  801826:	c3                   	ret    

00801827 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801827:	55                   	push   %ebp
  801828:	89 e5                	mov    %esp,%ebp
  80182a:	83 ec 04             	sub    $0x4,%esp
  80182d:	8b 45 08             	mov    0x8(%ebp),%eax
  801830:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801833:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	50                   	push   %eax
  801840:	6a 1f                	push   $0x1f
  801842:	e8 77 fc ff ff       	call   8014be <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
	return ;
  80184a:	90                   	nop
}
  80184b:	c9                   	leave  
  80184c:	c3                   	ret    

0080184d <rsttst>:
void rsttst()
{
  80184d:	55                   	push   %ebp
  80184e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 21                	push   $0x21
  80185c:	e8 5d fc ff ff       	call   8014be <syscall>
  801861:	83 c4 18             	add    $0x18,%esp
	return ;
  801864:	90                   	nop
}
  801865:	c9                   	leave  
  801866:	c3                   	ret    

00801867 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801867:	55                   	push   %ebp
  801868:	89 e5                	mov    %esp,%ebp
  80186a:	83 ec 04             	sub    $0x4,%esp
  80186d:	8b 45 14             	mov    0x14(%ebp),%eax
  801870:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801873:	8b 55 18             	mov    0x18(%ebp),%edx
  801876:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80187a:	52                   	push   %edx
  80187b:	50                   	push   %eax
  80187c:	ff 75 10             	pushl  0x10(%ebp)
  80187f:	ff 75 0c             	pushl  0xc(%ebp)
  801882:	ff 75 08             	pushl  0x8(%ebp)
  801885:	6a 20                	push   $0x20
  801887:	e8 32 fc ff ff       	call   8014be <syscall>
  80188c:	83 c4 18             	add    $0x18,%esp
	return ;
  80188f:	90                   	nop
}
  801890:	c9                   	leave  
  801891:	c3                   	ret    

00801892 <chktst>:
void chktst(uint32 n)
{
  801892:	55                   	push   %ebp
  801893:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	ff 75 08             	pushl  0x8(%ebp)
  8018a0:	6a 22                	push   $0x22
  8018a2:	e8 17 fc ff ff       	call   8014be <syscall>
  8018a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018aa:	90                   	nop
}
  8018ab:	c9                   	leave  
  8018ac:	c3                   	ret    

008018ad <inctst>:

void inctst()
{
  8018ad:	55                   	push   %ebp
  8018ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 23                	push   $0x23
  8018bc:	e8 fd fb ff ff       	call   8014be <syscall>
  8018c1:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c4:	90                   	nop
}
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <gettst>:
uint32 gettst()
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 24                	push   $0x24
  8018d6:	e8 e3 fb ff ff       	call   8014be <syscall>
  8018db:	83 c4 18             	add    $0x18,%esp
}
  8018de:	c9                   	leave  
  8018df:	c3                   	ret    

008018e0 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  8018e0:	55                   	push   %ebp
  8018e1:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 25                	push   $0x25
  8018ef:	e8 ca fb ff ff       	call   8014be <syscall>
  8018f4:	83 c4 18             	add    $0x18,%esp
  8018f7:	a3 48 30 80 00       	mov    %eax,0x803048
	return uheapPlaceStrategy ;
  8018fc:	a1 48 30 80 00       	mov    0x803048,%eax
}
  801901:	c9                   	leave  
  801902:	c3                   	ret    

00801903 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801903:	55                   	push   %ebp
  801904:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801906:	8b 45 08             	mov    0x8(%ebp),%eax
  801909:	a3 48 30 80 00       	mov    %eax,0x803048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	ff 75 08             	pushl  0x8(%ebp)
  801919:	6a 26                	push   $0x26
  80191b:	e8 9e fb ff ff       	call   8014be <syscall>
  801920:	83 c4 18             	add    $0x18,%esp
	return ;
  801923:	90                   	nop
}
  801924:	c9                   	leave  
  801925:	c3                   	ret    

00801926 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801926:	55                   	push   %ebp
  801927:	89 e5                	mov    %esp,%ebp
  801929:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80192a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80192d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801930:	8b 55 0c             	mov    0xc(%ebp),%edx
  801933:	8b 45 08             	mov    0x8(%ebp),%eax
  801936:	6a 00                	push   $0x0
  801938:	53                   	push   %ebx
  801939:	51                   	push   %ecx
  80193a:	52                   	push   %edx
  80193b:	50                   	push   %eax
  80193c:	6a 27                	push   $0x27
  80193e:	e8 7b fb ff ff       	call   8014be <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
}
  801946:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801949:	c9                   	leave  
  80194a:	c3                   	ret    

0080194b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80194b:	55                   	push   %ebp
  80194c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80194e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801951:	8b 45 08             	mov    0x8(%ebp),%eax
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	52                   	push   %edx
  80195b:	50                   	push   %eax
  80195c:	6a 28                	push   $0x28
  80195e:	e8 5b fb ff ff       	call   8014be <syscall>
  801963:	83 c4 18             	add    $0x18,%esp
}
  801966:	c9                   	leave  
  801967:	c3                   	ret    

00801968 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801968:	55                   	push   %ebp
  801969:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80196b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80196e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801971:	8b 45 08             	mov    0x8(%ebp),%eax
  801974:	6a 00                	push   $0x0
  801976:	51                   	push   %ecx
  801977:	ff 75 10             	pushl  0x10(%ebp)
  80197a:	52                   	push   %edx
  80197b:	50                   	push   %eax
  80197c:	6a 29                	push   $0x29
  80197e:	e8 3b fb ff ff       	call   8014be <syscall>
  801983:	83 c4 18             	add    $0x18,%esp
}
  801986:	c9                   	leave  
  801987:	c3                   	ret    

00801988 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801988:	55                   	push   %ebp
  801989:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	ff 75 10             	pushl  0x10(%ebp)
  801992:	ff 75 0c             	pushl  0xc(%ebp)
  801995:	ff 75 08             	pushl  0x8(%ebp)
  801998:	6a 12                	push   $0x12
  80199a:	e8 1f fb ff ff       	call   8014be <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
	return ;
  8019a2:	90                   	nop
}
  8019a3:	c9                   	leave  
  8019a4:	c3                   	ret    

008019a5 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  8019a5:	55                   	push   %ebp
  8019a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  8019a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	52                   	push   %edx
  8019b5:	50                   	push   %eax
  8019b6:	6a 2a                	push   $0x2a
  8019b8:	e8 01 fb ff ff       	call   8014be <syscall>
  8019bd:	83 c4 18             	add    $0x18,%esp
	return;
  8019c0:	90                   	nop
}
  8019c1:	c9                   	leave  
  8019c2:	c3                   	ret    

008019c3 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  8019c3:	55                   	push   %ebp
  8019c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 2b                	push   $0x2b
  8019d2:	e8 e7 fa ff ff       	call   8014be <syscall>
  8019d7:	83 c4 18             	add    $0x18,%esp
}
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
  8019df:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  8019e2:	83 ec 04             	sub    $0x4,%esp
  8019e5:	68 48 24 80 00       	push   $0x802448
  8019ea:	68 0a 01 00 00       	push   $0x10a
  8019ef:	68 58 24 80 00       	push   $0x802458
  8019f4:	e8 12 e9 ff ff       	call   80030b <_panic>

008019f9 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8019f9:	55                   	push   %ebp
  8019fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	ff 75 0c             	pushl  0xc(%ebp)
  801a05:	ff 75 08             	pushl  0x8(%ebp)
  801a08:	6a 33                	push   $0x33
  801a0a:	e8 af fa ff ff       	call   8014be <syscall>
  801a0f:	83 c4 18             	add    $0x18,%esp
	return;
  801a12:	90                   	nop
}
  801a13:	c9                   	leave  
  801a14:	c3                   	ret    

00801a15 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801a15:	55                   	push   %ebp
  801a16:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	ff 75 0c             	pushl  0xc(%ebp)
  801a21:	ff 75 08             	pushl  0x8(%ebp)
  801a24:	6a 34                	push   $0x34
  801a26:	e8 93 fa ff ff       	call   8014be <syscall>
  801a2b:	83 c4 18             	add    $0x18,%esp
	return ;
  801a2e:	90                   	nop
}
  801a2f:	c9                   	leave  
  801a30:	c3                   	ret    
  801a31:	66 90                	xchg   %ax,%ax
  801a33:	90                   	nop

00801a34 <__udivdi3>:
  801a34:	55                   	push   %ebp
  801a35:	57                   	push   %edi
  801a36:	56                   	push   %esi
  801a37:	53                   	push   %ebx
  801a38:	83 ec 1c             	sub    $0x1c,%esp
  801a3b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a3f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a47:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a4b:	89 ca                	mov    %ecx,%edx
  801a4d:	89 f8                	mov    %edi,%eax
  801a4f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a53:	85 f6                	test   %esi,%esi
  801a55:	75 2d                	jne    801a84 <__udivdi3+0x50>
  801a57:	39 cf                	cmp    %ecx,%edi
  801a59:	77 65                	ja     801ac0 <__udivdi3+0x8c>
  801a5b:	89 fd                	mov    %edi,%ebp
  801a5d:	85 ff                	test   %edi,%edi
  801a5f:	75 0b                	jne    801a6c <__udivdi3+0x38>
  801a61:	b8 01 00 00 00       	mov    $0x1,%eax
  801a66:	31 d2                	xor    %edx,%edx
  801a68:	f7 f7                	div    %edi
  801a6a:	89 c5                	mov    %eax,%ebp
  801a6c:	31 d2                	xor    %edx,%edx
  801a6e:	89 c8                	mov    %ecx,%eax
  801a70:	f7 f5                	div    %ebp
  801a72:	89 c1                	mov    %eax,%ecx
  801a74:	89 d8                	mov    %ebx,%eax
  801a76:	f7 f5                	div    %ebp
  801a78:	89 cf                	mov    %ecx,%edi
  801a7a:	89 fa                	mov    %edi,%edx
  801a7c:	83 c4 1c             	add    $0x1c,%esp
  801a7f:	5b                   	pop    %ebx
  801a80:	5e                   	pop    %esi
  801a81:	5f                   	pop    %edi
  801a82:	5d                   	pop    %ebp
  801a83:	c3                   	ret    
  801a84:	39 ce                	cmp    %ecx,%esi
  801a86:	77 28                	ja     801ab0 <__udivdi3+0x7c>
  801a88:	0f bd fe             	bsr    %esi,%edi
  801a8b:	83 f7 1f             	xor    $0x1f,%edi
  801a8e:	75 40                	jne    801ad0 <__udivdi3+0x9c>
  801a90:	39 ce                	cmp    %ecx,%esi
  801a92:	72 0a                	jb     801a9e <__udivdi3+0x6a>
  801a94:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a98:	0f 87 9e 00 00 00    	ja     801b3c <__udivdi3+0x108>
  801a9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa3:	89 fa                	mov    %edi,%edx
  801aa5:	83 c4 1c             	add    $0x1c,%esp
  801aa8:	5b                   	pop    %ebx
  801aa9:	5e                   	pop    %esi
  801aaa:	5f                   	pop    %edi
  801aab:	5d                   	pop    %ebp
  801aac:	c3                   	ret    
  801aad:	8d 76 00             	lea    0x0(%esi),%esi
  801ab0:	31 ff                	xor    %edi,%edi
  801ab2:	31 c0                	xor    %eax,%eax
  801ab4:	89 fa                	mov    %edi,%edx
  801ab6:	83 c4 1c             	add    $0x1c,%esp
  801ab9:	5b                   	pop    %ebx
  801aba:	5e                   	pop    %esi
  801abb:	5f                   	pop    %edi
  801abc:	5d                   	pop    %ebp
  801abd:	c3                   	ret    
  801abe:	66 90                	xchg   %ax,%ax
  801ac0:	89 d8                	mov    %ebx,%eax
  801ac2:	f7 f7                	div    %edi
  801ac4:	31 ff                	xor    %edi,%edi
  801ac6:	89 fa                	mov    %edi,%edx
  801ac8:	83 c4 1c             	add    $0x1c,%esp
  801acb:	5b                   	pop    %ebx
  801acc:	5e                   	pop    %esi
  801acd:	5f                   	pop    %edi
  801ace:	5d                   	pop    %ebp
  801acf:	c3                   	ret    
  801ad0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ad5:	89 eb                	mov    %ebp,%ebx
  801ad7:	29 fb                	sub    %edi,%ebx
  801ad9:	89 f9                	mov    %edi,%ecx
  801adb:	d3 e6                	shl    %cl,%esi
  801add:	89 c5                	mov    %eax,%ebp
  801adf:	88 d9                	mov    %bl,%cl
  801ae1:	d3 ed                	shr    %cl,%ebp
  801ae3:	89 e9                	mov    %ebp,%ecx
  801ae5:	09 f1                	or     %esi,%ecx
  801ae7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801aeb:	89 f9                	mov    %edi,%ecx
  801aed:	d3 e0                	shl    %cl,%eax
  801aef:	89 c5                	mov    %eax,%ebp
  801af1:	89 d6                	mov    %edx,%esi
  801af3:	88 d9                	mov    %bl,%cl
  801af5:	d3 ee                	shr    %cl,%esi
  801af7:	89 f9                	mov    %edi,%ecx
  801af9:	d3 e2                	shl    %cl,%edx
  801afb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aff:	88 d9                	mov    %bl,%cl
  801b01:	d3 e8                	shr    %cl,%eax
  801b03:	09 c2                	or     %eax,%edx
  801b05:	89 d0                	mov    %edx,%eax
  801b07:	89 f2                	mov    %esi,%edx
  801b09:	f7 74 24 0c          	divl   0xc(%esp)
  801b0d:	89 d6                	mov    %edx,%esi
  801b0f:	89 c3                	mov    %eax,%ebx
  801b11:	f7 e5                	mul    %ebp
  801b13:	39 d6                	cmp    %edx,%esi
  801b15:	72 19                	jb     801b30 <__udivdi3+0xfc>
  801b17:	74 0b                	je     801b24 <__udivdi3+0xf0>
  801b19:	89 d8                	mov    %ebx,%eax
  801b1b:	31 ff                	xor    %edi,%edi
  801b1d:	e9 58 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b22:	66 90                	xchg   %ax,%ax
  801b24:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b28:	89 f9                	mov    %edi,%ecx
  801b2a:	d3 e2                	shl    %cl,%edx
  801b2c:	39 c2                	cmp    %eax,%edx
  801b2e:	73 e9                	jae    801b19 <__udivdi3+0xe5>
  801b30:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b33:	31 ff                	xor    %edi,%edi
  801b35:	e9 40 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b3a:	66 90                	xchg   %ax,%ax
  801b3c:	31 c0                	xor    %eax,%eax
  801b3e:	e9 37 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b43:	90                   	nop

00801b44 <__umoddi3>:
  801b44:	55                   	push   %ebp
  801b45:	57                   	push   %edi
  801b46:	56                   	push   %esi
  801b47:	53                   	push   %ebx
  801b48:	83 ec 1c             	sub    $0x1c,%esp
  801b4b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b4f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b53:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b57:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b5b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b5f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b63:	89 f3                	mov    %esi,%ebx
  801b65:	89 fa                	mov    %edi,%edx
  801b67:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b6b:	89 34 24             	mov    %esi,(%esp)
  801b6e:	85 c0                	test   %eax,%eax
  801b70:	75 1a                	jne    801b8c <__umoddi3+0x48>
  801b72:	39 f7                	cmp    %esi,%edi
  801b74:	0f 86 a2 00 00 00    	jbe    801c1c <__umoddi3+0xd8>
  801b7a:	89 c8                	mov    %ecx,%eax
  801b7c:	89 f2                	mov    %esi,%edx
  801b7e:	f7 f7                	div    %edi
  801b80:	89 d0                	mov    %edx,%eax
  801b82:	31 d2                	xor    %edx,%edx
  801b84:	83 c4 1c             	add    $0x1c,%esp
  801b87:	5b                   	pop    %ebx
  801b88:	5e                   	pop    %esi
  801b89:	5f                   	pop    %edi
  801b8a:	5d                   	pop    %ebp
  801b8b:	c3                   	ret    
  801b8c:	39 f0                	cmp    %esi,%eax
  801b8e:	0f 87 ac 00 00 00    	ja     801c40 <__umoddi3+0xfc>
  801b94:	0f bd e8             	bsr    %eax,%ebp
  801b97:	83 f5 1f             	xor    $0x1f,%ebp
  801b9a:	0f 84 ac 00 00 00    	je     801c4c <__umoddi3+0x108>
  801ba0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ba5:	29 ef                	sub    %ebp,%edi
  801ba7:	89 fe                	mov    %edi,%esi
  801ba9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bad:	89 e9                	mov    %ebp,%ecx
  801baf:	d3 e0                	shl    %cl,%eax
  801bb1:	89 d7                	mov    %edx,%edi
  801bb3:	89 f1                	mov    %esi,%ecx
  801bb5:	d3 ef                	shr    %cl,%edi
  801bb7:	09 c7                	or     %eax,%edi
  801bb9:	89 e9                	mov    %ebp,%ecx
  801bbb:	d3 e2                	shl    %cl,%edx
  801bbd:	89 14 24             	mov    %edx,(%esp)
  801bc0:	89 d8                	mov    %ebx,%eax
  801bc2:	d3 e0                	shl    %cl,%eax
  801bc4:	89 c2                	mov    %eax,%edx
  801bc6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bca:	d3 e0                	shl    %cl,%eax
  801bcc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bd0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bd4:	89 f1                	mov    %esi,%ecx
  801bd6:	d3 e8                	shr    %cl,%eax
  801bd8:	09 d0                	or     %edx,%eax
  801bda:	d3 eb                	shr    %cl,%ebx
  801bdc:	89 da                	mov    %ebx,%edx
  801bde:	f7 f7                	div    %edi
  801be0:	89 d3                	mov    %edx,%ebx
  801be2:	f7 24 24             	mull   (%esp)
  801be5:	89 c6                	mov    %eax,%esi
  801be7:	89 d1                	mov    %edx,%ecx
  801be9:	39 d3                	cmp    %edx,%ebx
  801beb:	0f 82 87 00 00 00    	jb     801c78 <__umoddi3+0x134>
  801bf1:	0f 84 91 00 00 00    	je     801c88 <__umoddi3+0x144>
  801bf7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bfb:	29 f2                	sub    %esi,%edx
  801bfd:	19 cb                	sbb    %ecx,%ebx
  801bff:	89 d8                	mov    %ebx,%eax
  801c01:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c05:	d3 e0                	shl    %cl,%eax
  801c07:	89 e9                	mov    %ebp,%ecx
  801c09:	d3 ea                	shr    %cl,%edx
  801c0b:	09 d0                	or     %edx,%eax
  801c0d:	89 e9                	mov    %ebp,%ecx
  801c0f:	d3 eb                	shr    %cl,%ebx
  801c11:	89 da                	mov    %ebx,%edx
  801c13:	83 c4 1c             	add    $0x1c,%esp
  801c16:	5b                   	pop    %ebx
  801c17:	5e                   	pop    %esi
  801c18:	5f                   	pop    %edi
  801c19:	5d                   	pop    %ebp
  801c1a:	c3                   	ret    
  801c1b:	90                   	nop
  801c1c:	89 fd                	mov    %edi,%ebp
  801c1e:	85 ff                	test   %edi,%edi
  801c20:	75 0b                	jne    801c2d <__umoddi3+0xe9>
  801c22:	b8 01 00 00 00       	mov    $0x1,%eax
  801c27:	31 d2                	xor    %edx,%edx
  801c29:	f7 f7                	div    %edi
  801c2b:	89 c5                	mov    %eax,%ebp
  801c2d:	89 f0                	mov    %esi,%eax
  801c2f:	31 d2                	xor    %edx,%edx
  801c31:	f7 f5                	div    %ebp
  801c33:	89 c8                	mov    %ecx,%eax
  801c35:	f7 f5                	div    %ebp
  801c37:	89 d0                	mov    %edx,%eax
  801c39:	e9 44 ff ff ff       	jmp    801b82 <__umoddi3+0x3e>
  801c3e:	66 90                	xchg   %ax,%ax
  801c40:	89 c8                	mov    %ecx,%eax
  801c42:	89 f2                	mov    %esi,%edx
  801c44:	83 c4 1c             	add    $0x1c,%esp
  801c47:	5b                   	pop    %ebx
  801c48:	5e                   	pop    %esi
  801c49:	5f                   	pop    %edi
  801c4a:	5d                   	pop    %ebp
  801c4b:	c3                   	ret    
  801c4c:	3b 04 24             	cmp    (%esp),%eax
  801c4f:	72 06                	jb     801c57 <__umoddi3+0x113>
  801c51:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c55:	77 0f                	ja     801c66 <__umoddi3+0x122>
  801c57:	89 f2                	mov    %esi,%edx
  801c59:	29 f9                	sub    %edi,%ecx
  801c5b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c5f:	89 14 24             	mov    %edx,(%esp)
  801c62:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c66:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c6a:	8b 14 24             	mov    (%esp),%edx
  801c6d:	83 c4 1c             	add    $0x1c,%esp
  801c70:	5b                   	pop    %ebx
  801c71:	5e                   	pop    %esi
  801c72:	5f                   	pop    %edi
  801c73:	5d                   	pop    %ebp
  801c74:	c3                   	ret    
  801c75:	8d 76 00             	lea    0x0(%esi),%esi
  801c78:	2b 04 24             	sub    (%esp),%eax
  801c7b:	19 fa                	sbb    %edi,%edx
  801c7d:	89 d1                	mov    %edx,%ecx
  801c7f:	89 c6                	mov    %eax,%esi
  801c81:	e9 71 ff ff ff       	jmp    801bf7 <__umoddi3+0xb3>
  801c86:	66 90                	xchg   %ax,%ax
  801c88:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c8c:	72 ea                	jb     801c78 <__umoddi3+0x134>
  801c8e:	89 d9                	mov    %ebx,%ecx
  801c90:	e9 62 ff ff ff       	jmp    801bf7 <__umoddi3+0xb3>
