
obj/user/fib_memomize:     file format elf32-i386


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
  800031:	e8 7f 01 00 00       	call   8001b5 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int64 fibonacci(int n, int64 *memo);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	int index=0;
  800041:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	char buff1[256];
	atomic_readline("Please enter Fibonacci index:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 e0 fe ff ff    	lea    -0x120(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 c0 28 80 00       	push   $0x8028c0
  800057:	e8 71 0c 00 00       	call   800ccd <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	index = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 e0 fe ff ff    	lea    -0x120(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 73 11 00 00       	call   8011e5 <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int64 *memo = malloc((index+1) * sizeof(int64));
  800078:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007b:	40                   	inc    %eax
  80007c:	c1 e0 03             	shl    $0x3,%eax
  80007f:	83 ec 0c             	sub    $0xc,%esp
  800082:	50                   	push   %eax
  800083:	e8 cd 15 00 00       	call   801655 <malloc>
  800088:	83 c4 10             	add    $0x10,%esp
  80008b:	89 45 ec             	mov    %eax,-0x14(%ebp)
	for (int i = 0; i <= index; ++i)
  80008e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800095:	eb 1f                	jmp    8000b6 <_main+0x7e>
	{
		memo[i] = 0;
  800097:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80009a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8000a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000a4:	01 d0                	add    %edx,%eax
  8000a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8000ac:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	char buff1[256];
	atomic_readline("Please enter Fibonacci index:", buff1);
	index = strtol(buff1, NULL, 10);

	int64 *memo = malloc((index+1) * sizeof(int64));
	for (int i = 0; i <= index; ++i)
  8000b3:	ff 45 f4             	incl   -0xc(%ebp)
  8000b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000bc:	7e d9                	jle    800097 <_main+0x5f>
	{
		memo[i] = 0;
	}
	int64 res = fibonacci(index, memo) ;
  8000be:	83 ec 08             	sub    $0x8,%esp
  8000c1:	ff 75 ec             	pushl  -0x14(%ebp)
  8000c4:	ff 75 f0             	pushl  -0x10(%ebp)
  8000c7:	e8 35 00 00 00       	call   800101 <fibonacci>
  8000cc:	83 c4 10             	add    $0x10,%esp
  8000cf:	89 45 e0             	mov    %eax,-0x20(%ebp)
  8000d2:	89 55 e4             	mov    %edx,-0x1c(%ebp)

	free(memo);
  8000d5:	83 ec 0c             	sub    $0xc,%esp
  8000d8:	ff 75 ec             	pushl  -0x14(%ebp)
  8000db:	e8 a3 15 00 00       	call   801683 <free>
  8000e0:	83 c4 10             	add    $0x10,%esp

	atomic_cprintf("Fibonacci #%d = %lld\n",index, res);
  8000e3:	ff 75 e4             	pushl  -0x1c(%ebp)
  8000e6:	ff 75 e0             	pushl  -0x20(%ebp)
  8000e9:	ff 75 f0             	pushl  -0x10(%ebp)
  8000ec:	68 de 28 80 00       	push   $0x8028de
  8000f1:	e8 71 04 00 00       	call   800567 <atomic_cprintf>
  8000f6:	83 c4 10             	add    $0x10,%esp
	//To indicate that it's completed successfully
		inctst();
  8000f9:	e8 fb 19 00 00       	call   801af9 <inctst>
	return;
  8000fe:	90                   	nop
}
  8000ff:	c9                   	leave  
  800100:	c3                   	ret    

00800101 <fibonacci>:


int64 fibonacci(int n, int64 *memo)
{
  800101:	55                   	push   %ebp
  800102:	89 e5                	mov    %esp,%ebp
  800104:	57                   	push   %edi
  800105:	56                   	push   %esi
  800106:	53                   	push   %ebx
  800107:	83 ec 0c             	sub    $0xc,%esp
	if (memo[n]!=0)	return memo[n];
  80010a:	8b 45 08             	mov    0x8(%ebp),%eax
  80010d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800114:	8b 45 0c             	mov    0xc(%ebp),%eax
  800117:	01 d0                	add    %edx,%eax
  800119:	8b 50 04             	mov    0x4(%eax),%edx
  80011c:	8b 00                	mov    (%eax),%eax
  80011e:	09 d0                	or     %edx,%eax
  800120:	85 c0                	test   %eax,%eax
  800122:	74 16                	je     80013a <fibonacci+0x39>
  800124:	8b 45 08             	mov    0x8(%ebp),%eax
  800127:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80012e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800131:	01 d0                	add    %edx,%eax
  800133:	8b 50 04             	mov    0x4(%eax),%edx
  800136:	8b 00                	mov    (%eax),%eax
  800138:	eb 73                	jmp    8001ad <fibonacci+0xac>
	if (n <= 1)
  80013a:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  80013e:	7f 23                	jg     800163 <fibonacci+0x62>
		return memo[n] = 1 ;
  800140:	8b 45 08             	mov    0x8(%ebp),%eax
  800143:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80014a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80014d:	01 d0                	add    %edx,%eax
  80014f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  800155:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  80015c:	8b 50 04             	mov    0x4(%eax),%edx
  80015f:	8b 00                	mov    (%eax),%eax
  800161:	eb 4a                	jmp    8001ad <fibonacci+0xac>
	return (memo[n] = fibonacci(n-1, memo) + fibonacci(n-2, memo)) ;
  800163:	8b 45 08             	mov    0x8(%ebp),%eax
  800166:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80016d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800170:	8d 3c 02             	lea    (%edx,%eax,1),%edi
  800173:	8b 45 08             	mov    0x8(%ebp),%eax
  800176:	48                   	dec    %eax
  800177:	83 ec 08             	sub    $0x8,%esp
  80017a:	ff 75 0c             	pushl  0xc(%ebp)
  80017d:	50                   	push   %eax
  80017e:	e8 7e ff ff ff       	call   800101 <fibonacci>
  800183:	83 c4 10             	add    $0x10,%esp
  800186:	89 c3                	mov    %eax,%ebx
  800188:	89 d6                	mov    %edx,%esi
  80018a:	8b 45 08             	mov    0x8(%ebp),%eax
  80018d:	83 e8 02             	sub    $0x2,%eax
  800190:	83 ec 08             	sub    $0x8,%esp
  800193:	ff 75 0c             	pushl  0xc(%ebp)
  800196:	50                   	push   %eax
  800197:	e8 65 ff ff ff       	call   800101 <fibonacci>
  80019c:	83 c4 10             	add    $0x10,%esp
  80019f:	01 d8                	add    %ebx,%eax
  8001a1:	11 f2                	adc    %esi,%edx
  8001a3:	89 07                	mov    %eax,(%edi)
  8001a5:	89 57 04             	mov    %edx,0x4(%edi)
  8001a8:	8b 07                	mov    (%edi),%eax
  8001aa:	8b 57 04             	mov    0x4(%edi),%edx
}
  8001ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8001b0:	5b                   	pop    %ebx
  8001b1:	5e                   	pop    %esi
  8001b2:	5f                   	pop    %edi
  8001b3:	5d                   	pop    %ebp
  8001b4:	c3                   	ret    

008001b5 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  8001b5:	55                   	push   %ebp
  8001b6:	89 e5                	mov    %esp,%ebp
  8001b8:	57                   	push   %edi
  8001b9:	56                   	push   %esi
  8001ba:	53                   	push   %ebx
  8001bb:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  8001c1:	e8 2b 18 00 00       	call   8019f1 <sys_getenvindex>
  8001c6:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  8001c9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8001cc:	89 d0                	mov    %edx,%eax
  8001ce:	c1 e0 03             	shl    $0x3,%eax
  8001d1:	01 d0                	add    %edx,%eax
  8001d3:	c1 e0 06             	shl    $0x6,%eax
  8001d6:	01 d0                	add    %edx,%eax
  8001d8:	c1 e0 03             	shl    $0x3,%eax
  8001db:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001e0:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001e5:	a1 20 40 80 00       	mov    0x804020,%eax
  8001ea:	8a 40 10             	mov    0x10(%eax),%al
  8001ed:	84 c0                	test   %al,%al
  8001ef:	74 0d                	je     8001fe <libmain+0x49>
		binaryname = myEnv->prog_name;
  8001f1:	a1 20 40 80 00       	mov    0x804020,%eax
  8001f6:	83 c0 10             	add    $0x10,%eax
  8001f9:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001fe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800202:	7e 0a                	jle    80020e <libmain+0x59>
		binaryname = argv[0];
  800204:	8b 45 0c             	mov    0xc(%ebp),%eax
  800207:	8b 00                	mov    (%eax),%eax
  800209:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  80020e:	83 ec 08             	sub    $0x8,%esp
  800211:	ff 75 0c             	pushl  0xc(%ebp)
  800214:	ff 75 08             	pushl  0x8(%ebp)
  800217:	e8 1c fe ff ff       	call   800038 <_main>
  80021c:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80021f:	a1 00 40 80 00       	mov    0x804000,%eax
  800224:	85 c0                	test   %eax,%eax
  800226:	0f 84 b7 01 00 00    	je     8003e3 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80022c:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800232:	bb 30 2a 80 00       	mov    $0x802a30,%ebx
  800237:	ba 0e 00 00 00       	mov    $0xe,%edx
  80023c:	89 c7                	mov    %eax,%edi
  80023e:	89 de                	mov    %ebx,%esi
  800240:	89 d1                	mov    %edx,%ecx
  800242:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800244:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  80024a:	b9 56 00 00 00       	mov    $0x56,%ecx
  80024f:	b0 00                	mov    $0x0,%al
  800251:	89 d7                	mov    %edx,%edi
  800253:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800255:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  80025c:	8d 45 d8             	lea    -0x28(%ebp),%eax
  80025f:	83 ec 08             	sub    $0x8,%esp
  800262:	50                   	push   %eax
  800263:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800269:	50                   	push   %eax
  80026a:	e8 82 19 00 00       	call   801bf1 <sys_utilities>
  80026f:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800272:	e8 02 15 00 00       	call   801779 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800277:	83 ec 0c             	sub    $0xc,%esp
  80027a:	68 0c 29 80 00       	push   $0x80290c
  80027f:	e8 71 02 00 00       	call   8004f5 <cprintf>
  800284:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800287:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80028a:	85 c0                	test   %eax,%eax
  80028c:	74 58                	je     8002e6 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  80028e:	e8 7c 19 00 00       	call   801c0f <sys_get_optimal_num_faults>
  800293:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800296:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  80029c:	bb 94 2a 80 00       	mov    $0x802a94,%ebx
  8002a1:	ba 11 00 00 00       	mov    $0x11,%edx
  8002a6:	89 c7                	mov    %eax,%edi
  8002a8:	89 de                	mov    %ebx,%esi
  8002aa:	89 d1                	mov    %edx,%ecx
  8002ac:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8002ae:	8d 55 85             	lea    -0x7b(%ebp),%edx
  8002b1:	b9 53 00 00 00       	mov    $0x53,%ecx
  8002b6:	b0 00                	mov    $0x0,%al
  8002b8:	89 d7                	mov    %edx,%edi
  8002ba:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  8002bc:	83 ec 08             	sub    $0x8,%esp
  8002bf:	ff 75 dc             	pushl  -0x24(%ebp)
  8002c2:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8002c8:	50                   	push   %eax
  8002c9:	e8 23 19 00 00       	call   801bf1 <sys_utilities>
  8002ce:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  8002d1:	83 ec 08             	sub    $0x8,%esp
  8002d4:	ff 75 dc             	pushl  -0x24(%ebp)
  8002d7:	68 34 29 80 00       	push   $0x802934
  8002dc:	e8 14 02 00 00       	call   8004f5 <cprintf>
  8002e1:	83 c4 10             	add    $0x10,%esp
  8002e4:	eb 59                	jmp    80033f <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002e6:	a1 20 40 80 00       	mov    0x804020,%eax
  8002eb:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  8002f1:	a1 20 40 80 00       	mov    0x804020,%eax
  8002f6:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  8002fc:	83 ec 04             	sub    $0x4,%esp
  8002ff:	52                   	push   %edx
  800300:	50                   	push   %eax
  800301:	68 58 29 80 00       	push   $0x802958
  800306:	e8 ea 01 00 00       	call   8004f5 <cprintf>
  80030b:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80030e:	a1 20 40 80 00       	mov    0x804020,%eax
  800313:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800319:	a1 20 40 80 00       	mov    0x804020,%eax
  80031e:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800324:	a1 20 40 80 00       	mov    0x804020,%eax
  800329:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80032f:	51                   	push   %ecx
  800330:	52                   	push   %edx
  800331:	50                   	push   %eax
  800332:	68 80 29 80 00       	push   $0x802980
  800337:	e8 b9 01 00 00       	call   8004f5 <cprintf>
  80033c:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80033f:	a1 20 40 80 00       	mov    0x804020,%eax
  800344:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  80034a:	83 ec 08             	sub    $0x8,%esp
  80034d:	50                   	push   %eax
  80034e:	68 d8 29 80 00       	push   $0x8029d8
  800353:	e8 9d 01 00 00       	call   8004f5 <cprintf>
  800358:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  80035b:	83 ec 0c             	sub    $0xc,%esp
  80035e:	68 ec 29 80 00       	push   $0x8029ec
  800363:	e8 8d 01 00 00       	call   8004f5 <cprintf>
  800368:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  80036b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800372:	eb 28                	jmp    80039c <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800374:	a1 20 40 80 00       	mov    0x804020,%eax
  800379:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80037c:	81 c2 74 04 00 00    	add    $0x474,%edx
  800382:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800385:	83 ec 04             	sub    $0x4,%esp
  800388:	50                   	push   %eax
  800389:	ff 75 e4             	pushl  -0x1c(%ebp)
  80038c:	68 03 2a 80 00       	push   $0x802a03
  800391:	e8 5f 01 00 00       	call   8004f5 <cprintf>
  800396:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800399:	ff 45 e4             	incl   -0x1c(%ebp)
  80039c:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8003a0:	7e d2                	jle    800374 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  8003a2:	83 ec 0c             	sub    $0xc,%esp
  8003a5:	68 12 2a 80 00       	push   $0x802a12
  8003aa:	e8 46 01 00 00       	call   8004f5 <cprintf>
  8003af:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  8003b2:	a1 20 40 80 00       	mov    0x804020,%eax
  8003b7:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  8003bd:	83 ec 08             	sub    $0x8,%esp
  8003c0:	50                   	push   %eax
  8003c1:	68 16 2a 80 00       	push   $0x802a16
  8003c6:	e8 2a 01 00 00       	call   8004f5 <cprintf>
  8003cb:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  8003ce:	83 ec 0c             	sub    $0xc,%esp
  8003d1:	68 0c 29 80 00       	push   $0x80290c
  8003d6:	e8 1a 01 00 00       	call   8004f5 <cprintf>
  8003db:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  8003de:	e8 b0 13 00 00       	call   801793 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  8003e3:	e8 1f 00 00 00       	call   800407 <exit>
}
  8003e8:	90                   	nop
  8003e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8003ec:	5b                   	pop    %ebx
  8003ed:	5e                   	pop    %esi
  8003ee:	5f                   	pop    %edi
  8003ef:	5d                   	pop    %ebp
  8003f0:	c3                   	ret    

008003f1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003f1:	55                   	push   %ebp
  8003f2:	89 e5                	mov    %esp,%ebp
  8003f4:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  8003f7:	83 ec 0c             	sub    $0xc,%esp
  8003fa:	6a 00                	push   $0x0
  8003fc:	e8 bc 15 00 00       	call   8019bd <sys_destroy_env>
  800401:	83 c4 10             	add    $0x10,%esp
}
  800404:	90                   	nop
  800405:	c9                   	leave  
  800406:	c3                   	ret    

00800407 <exit>:

void
exit(void)
{
  800407:	55                   	push   %ebp
  800408:	89 e5                	mov    %esp,%ebp
  80040a:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80040d:	e8 11 16 00 00       	call   801a23 <sys_exit_env>
}
  800412:	90                   	nop
  800413:	c9                   	leave  
  800414:	c3                   	ret    

00800415 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800415:	55                   	push   %ebp
  800416:	89 e5                	mov    %esp,%ebp
  800418:	53                   	push   %ebx
  800419:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  80041c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041f:	8b 00                	mov    (%eax),%eax
  800421:	8d 48 01             	lea    0x1(%eax),%ecx
  800424:	8b 55 0c             	mov    0xc(%ebp),%edx
  800427:	89 0a                	mov    %ecx,(%edx)
  800429:	8b 55 08             	mov    0x8(%ebp),%edx
  80042c:	88 d1                	mov    %dl,%cl
  80042e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800431:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800435:	8b 45 0c             	mov    0xc(%ebp),%eax
  800438:	8b 00                	mov    (%eax),%eax
  80043a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80043f:	75 30                	jne    800471 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800441:	8b 15 28 41 80 00    	mov    0x804128,%edx
  800447:	a0 40 40 80 00       	mov    0x804040,%al
  80044c:	0f b6 c0             	movzbl %al,%eax
  80044f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800452:	8b 09                	mov    (%ecx),%ecx
  800454:	89 cb                	mov    %ecx,%ebx
  800456:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800459:	83 c1 08             	add    $0x8,%ecx
  80045c:	52                   	push   %edx
  80045d:	50                   	push   %eax
  80045e:	53                   	push   %ebx
  80045f:	51                   	push   %ecx
  800460:	e8 d0 12 00 00       	call   801735 <sys_cputs>
  800465:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800468:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800471:	8b 45 0c             	mov    0xc(%ebp),%eax
  800474:	8b 40 04             	mov    0x4(%eax),%eax
  800477:	8d 50 01             	lea    0x1(%eax),%edx
  80047a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800480:	90                   	nop
  800481:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800484:	c9                   	leave  
  800485:	c3                   	ret    

00800486 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800486:	55                   	push   %ebp
  800487:	89 e5                	mov    %esp,%ebp
  800489:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80048f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800496:	00 00 00 
	b.cnt = 0;
  800499:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004a0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004a3:	ff 75 0c             	pushl  0xc(%ebp)
  8004a6:	ff 75 08             	pushl  0x8(%ebp)
  8004a9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004af:	50                   	push   %eax
  8004b0:	68 15 04 80 00       	push   $0x800415
  8004b5:	e8 5a 02 00 00       	call   800714 <vprintfmt>
  8004ba:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  8004bd:	8b 15 28 41 80 00    	mov    0x804128,%edx
  8004c3:	a0 40 40 80 00       	mov    0x804040,%al
  8004c8:	0f b6 c0             	movzbl %al,%eax
  8004cb:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  8004d1:	52                   	push   %edx
  8004d2:	50                   	push   %eax
  8004d3:	51                   	push   %ecx
  8004d4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004da:	83 c0 08             	add    $0x8,%eax
  8004dd:	50                   	push   %eax
  8004de:	e8 52 12 00 00       	call   801735 <sys_cputs>
  8004e3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004e6:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  8004ed:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004f3:	c9                   	leave  
  8004f4:	c3                   	ret    

008004f5 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  8004f5:	55                   	push   %ebp
  8004f6:	89 e5                	mov    %esp,%ebp
  8004f8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004fb:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800502:	8d 45 0c             	lea    0xc(%ebp),%eax
  800505:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800508:	8b 45 08             	mov    0x8(%ebp),%eax
  80050b:	83 ec 08             	sub    $0x8,%esp
  80050e:	ff 75 f4             	pushl  -0xc(%ebp)
  800511:	50                   	push   %eax
  800512:	e8 6f ff ff ff       	call   800486 <vcprintf>
  800517:	83 c4 10             	add    $0x10,%esp
  80051a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80051d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800520:	c9                   	leave  
  800521:	c3                   	ret    

00800522 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800522:	55                   	push   %ebp
  800523:	89 e5                	mov    %esp,%ebp
  800525:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800528:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  80052f:	8b 45 08             	mov    0x8(%ebp),%eax
  800532:	c1 e0 08             	shl    $0x8,%eax
  800535:	a3 28 41 80 00       	mov    %eax,0x804128
	va_start(ap, fmt);
  80053a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80053d:	83 c0 04             	add    $0x4,%eax
  800540:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800543:	8b 45 0c             	mov    0xc(%ebp),%eax
  800546:	83 ec 08             	sub    $0x8,%esp
  800549:	ff 75 f4             	pushl  -0xc(%ebp)
  80054c:	50                   	push   %eax
  80054d:	e8 34 ff ff ff       	call   800486 <vcprintf>
  800552:	83 c4 10             	add    $0x10,%esp
  800555:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800558:	c7 05 28 41 80 00 00 	movl   $0x700,0x804128
  80055f:	07 00 00 

	return cnt;
  800562:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800565:	c9                   	leave  
  800566:	c3                   	ret    

00800567 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800567:	55                   	push   %ebp
  800568:	89 e5                	mov    %esp,%ebp
  80056a:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  80056d:	e8 07 12 00 00       	call   801779 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800572:	8d 45 0c             	lea    0xc(%ebp),%eax
  800575:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800578:	8b 45 08             	mov    0x8(%ebp),%eax
  80057b:	83 ec 08             	sub    $0x8,%esp
  80057e:	ff 75 f4             	pushl  -0xc(%ebp)
  800581:	50                   	push   %eax
  800582:	e8 ff fe ff ff       	call   800486 <vcprintf>
  800587:	83 c4 10             	add    $0x10,%esp
  80058a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  80058d:	e8 01 12 00 00       	call   801793 <sys_unlock_cons>
	return cnt;
  800592:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800595:	c9                   	leave  
  800596:	c3                   	ret    

00800597 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800597:	55                   	push   %ebp
  800598:	89 e5                	mov    %esp,%ebp
  80059a:	53                   	push   %ebx
  80059b:	83 ec 14             	sub    $0x14,%esp
  80059e:	8b 45 10             	mov    0x10(%ebp),%eax
  8005a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005aa:	8b 45 18             	mov    0x18(%ebp),%eax
  8005ad:	ba 00 00 00 00       	mov    $0x0,%edx
  8005b2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005b5:	77 55                	ja     80060c <printnum+0x75>
  8005b7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005ba:	72 05                	jb     8005c1 <printnum+0x2a>
  8005bc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005bf:	77 4b                	ja     80060c <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005c1:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005c4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005c7:	8b 45 18             	mov    0x18(%ebp),%eax
  8005ca:	ba 00 00 00 00       	mov    $0x0,%edx
  8005cf:	52                   	push   %edx
  8005d0:	50                   	push   %eax
  8005d1:	ff 75 f4             	pushl  -0xc(%ebp)
  8005d4:	ff 75 f0             	pushl  -0x10(%ebp)
  8005d7:	e8 80 20 00 00       	call   80265c <__udivdi3>
  8005dc:	83 c4 10             	add    $0x10,%esp
  8005df:	83 ec 04             	sub    $0x4,%esp
  8005e2:	ff 75 20             	pushl  0x20(%ebp)
  8005e5:	53                   	push   %ebx
  8005e6:	ff 75 18             	pushl  0x18(%ebp)
  8005e9:	52                   	push   %edx
  8005ea:	50                   	push   %eax
  8005eb:	ff 75 0c             	pushl  0xc(%ebp)
  8005ee:	ff 75 08             	pushl  0x8(%ebp)
  8005f1:	e8 a1 ff ff ff       	call   800597 <printnum>
  8005f6:	83 c4 20             	add    $0x20,%esp
  8005f9:	eb 1a                	jmp    800615 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005fb:	83 ec 08             	sub    $0x8,%esp
  8005fe:	ff 75 0c             	pushl  0xc(%ebp)
  800601:	ff 75 20             	pushl  0x20(%ebp)
  800604:	8b 45 08             	mov    0x8(%ebp),%eax
  800607:	ff d0                	call   *%eax
  800609:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80060c:	ff 4d 1c             	decl   0x1c(%ebp)
  80060f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800613:	7f e6                	jg     8005fb <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800615:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800618:	bb 00 00 00 00       	mov    $0x0,%ebx
  80061d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800620:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800623:	53                   	push   %ebx
  800624:	51                   	push   %ecx
  800625:	52                   	push   %edx
  800626:	50                   	push   %eax
  800627:	e8 40 21 00 00       	call   80276c <__umoddi3>
  80062c:	83 c4 10             	add    $0x10,%esp
  80062f:	05 14 2d 80 00       	add    $0x802d14,%eax
  800634:	8a 00                	mov    (%eax),%al
  800636:	0f be c0             	movsbl %al,%eax
  800639:	83 ec 08             	sub    $0x8,%esp
  80063c:	ff 75 0c             	pushl  0xc(%ebp)
  80063f:	50                   	push   %eax
  800640:	8b 45 08             	mov    0x8(%ebp),%eax
  800643:	ff d0                	call   *%eax
  800645:	83 c4 10             	add    $0x10,%esp
}
  800648:	90                   	nop
  800649:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80064c:	c9                   	leave  
  80064d:	c3                   	ret    

0080064e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80064e:	55                   	push   %ebp
  80064f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800651:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800655:	7e 1c                	jle    800673 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800657:	8b 45 08             	mov    0x8(%ebp),%eax
  80065a:	8b 00                	mov    (%eax),%eax
  80065c:	8d 50 08             	lea    0x8(%eax),%edx
  80065f:	8b 45 08             	mov    0x8(%ebp),%eax
  800662:	89 10                	mov    %edx,(%eax)
  800664:	8b 45 08             	mov    0x8(%ebp),%eax
  800667:	8b 00                	mov    (%eax),%eax
  800669:	83 e8 08             	sub    $0x8,%eax
  80066c:	8b 50 04             	mov    0x4(%eax),%edx
  80066f:	8b 00                	mov    (%eax),%eax
  800671:	eb 40                	jmp    8006b3 <getuint+0x65>
	else if (lflag)
  800673:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800677:	74 1e                	je     800697 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800679:	8b 45 08             	mov    0x8(%ebp),%eax
  80067c:	8b 00                	mov    (%eax),%eax
  80067e:	8d 50 04             	lea    0x4(%eax),%edx
  800681:	8b 45 08             	mov    0x8(%ebp),%eax
  800684:	89 10                	mov    %edx,(%eax)
  800686:	8b 45 08             	mov    0x8(%ebp),%eax
  800689:	8b 00                	mov    (%eax),%eax
  80068b:	83 e8 04             	sub    $0x4,%eax
  80068e:	8b 00                	mov    (%eax),%eax
  800690:	ba 00 00 00 00       	mov    $0x0,%edx
  800695:	eb 1c                	jmp    8006b3 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	8b 00                	mov    (%eax),%eax
  80069c:	8d 50 04             	lea    0x4(%eax),%edx
  80069f:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a2:	89 10                	mov    %edx,(%eax)
  8006a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a7:	8b 00                	mov    (%eax),%eax
  8006a9:	83 e8 04             	sub    $0x4,%eax
  8006ac:	8b 00                	mov    (%eax),%eax
  8006ae:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006b3:	5d                   	pop    %ebp
  8006b4:	c3                   	ret    

008006b5 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006b5:	55                   	push   %ebp
  8006b6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006b8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006bc:	7e 1c                	jle    8006da <getint+0x25>
		return va_arg(*ap, long long);
  8006be:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c1:	8b 00                	mov    (%eax),%eax
  8006c3:	8d 50 08             	lea    0x8(%eax),%edx
  8006c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c9:	89 10                	mov    %edx,(%eax)
  8006cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ce:	8b 00                	mov    (%eax),%eax
  8006d0:	83 e8 08             	sub    $0x8,%eax
  8006d3:	8b 50 04             	mov    0x4(%eax),%edx
  8006d6:	8b 00                	mov    (%eax),%eax
  8006d8:	eb 38                	jmp    800712 <getint+0x5d>
	else if (lflag)
  8006da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006de:	74 1a                	je     8006fa <getint+0x45>
		return va_arg(*ap, long);
  8006e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e3:	8b 00                	mov    (%eax),%eax
  8006e5:	8d 50 04             	lea    0x4(%eax),%edx
  8006e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006eb:	89 10                	mov    %edx,(%eax)
  8006ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f0:	8b 00                	mov    (%eax),%eax
  8006f2:	83 e8 04             	sub    $0x4,%eax
  8006f5:	8b 00                	mov    (%eax),%eax
  8006f7:	99                   	cltd   
  8006f8:	eb 18                	jmp    800712 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fd:	8b 00                	mov    (%eax),%eax
  8006ff:	8d 50 04             	lea    0x4(%eax),%edx
  800702:	8b 45 08             	mov    0x8(%ebp),%eax
  800705:	89 10                	mov    %edx,(%eax)
  800707:	8b 45 08             	mov    0x8(%ebp),%eax
  80070a:	8b 00                	mov    (%eax),%eax
  80070c:	83 e8 04             	sub    $0x4,%eax
  80070f:	8b 00                	mov    (%eax),%eax
  800711:	99                   	cltd   
}
  800712:	5d                   	pop    %ebp
  800713:	c3                   	ret    

00800714 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800714:	55                   	push   %ebp
  800715:	89 e5                	mov    %esp,%ebp
  800717:	56                   	push   %esi
  800718:	53                   	push   %ebx
  800719:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80071c:	eb 17                	jmp    800735 <vprintfmt+0x21>
			if (ch == '\0')
  80071e:	85 db                	test   %ebx,%ebx
  800720:	0f 84 c1 03 00 00    	je     800ae7 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800726:	83 ec 08             	sub    $0x8,%esp
  800729:	ff 75 0c             	pushl  0xc(%ebp)
  80072c:	53                   	push   %ebx
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	ff d0                	call   *%eax
  800732:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800735:	8b 45 10             	mov    0x10(%ebp),%eax
  800738:	8d 50 01             	lea    0x1(%eax),%edx
  80073b:	89 55 10             	mov    %edx,0x10(%ebp)
  80073e:	8a 00                	mov    (%eax),%al
  800740:	0f b6 d8             	movzbl %al,%ebx
  800743:	83 fb 25             	cmp    $0x25,%ebx
  800746:	75 d6                	jne    80071e <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800748:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80074c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800753:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80075a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800761:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800768:	8b 45 10             	mov    0x10(%ebp),%eax
  80076b:	8d 50 01             	lea    0x1(%eax),%edx
  80076e:	89 55 10             	mov    %edx,0x10(%ebp)
  800771:	8a 00                	mov    (%eax),%al
  800773:	0f b6 d8             	movzbl %al,%ebx
  800776:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800779:	83 f8 5b             	cmp    $0x5b,%eax
  80077c:	0f 87 3d 03 00 00    	ja     800abf <vprintfmt+0x3ab>
  800782:	8b 04 85 38 2d 80 00 	mov    0x802d38(,%eax,4),%eax
  800789:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80078b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80078f:	eb d7                	jmp    800768 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800791:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800795:	eb d1                	jmp    800768 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800797:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80079e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007a1:	89 d0                	mov    %edx,%eax
  8007a3:	c1 e0 02             	shl    $0x2,%eax
  8007a6:	01 d0                	add    %edx,%eax
  8007a8:	01 c0                	add    %eax,%eax
  8007aa:	01 d8                	add    %ebx,%eax
  8007ac:	83 e8 30             	sub    $0x30,%eax
  8007af:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b5:	8a 00                	mov    (%eax),%al
  8007b7:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007ba:	83 fb 2f             	cmp    $0x2f,%ebx
  8007bd:	7e 3e                	jle    8007fd <vprintfmt+0xe9>
  8007bf:	83 fb 39             	cmp    $0x39,%ebx
  8007c2:	7f 39                	jg     8007fd <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007c4:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007c7:	eb d5                	jmp    80079e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007cc:	83 c0 04             	add    $0x4,%eax
  8007cf:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d5:	83 e8 04             	sub    $0x4,%eax
  8007d8:	8b 00                	mov    (%eax),%eax
  8007da:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007dd:	eb 1f                	jmp    8007fe <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007df:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007e3:	79 83                	jns    800768 <vprintfmt+0x54>
				width = 0;
  8007e5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007ec:	e9 77 ff ff ff       	jmp    800768 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007f1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007f8:	e9 6b ff ff ff       	jmp    800768 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007fd:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007fe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800802:	0f 89 60 ff ff ff    	jns    800768 <vprintfmt+0x54>
				width = precision, precision = -1;
  800808:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80080b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80080e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800815:	e9 4e ff ff ff       	jmp    800768 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80081a:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80081d:	e9 46 ff ff ff       	jmp    800768 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800822:	8b 45 14             	mov    0x14(%ebp),%eax
  800825:	83 c0 04             	add    $0x4,%eax
  800828:	89 45 14             	mov    %eax,0x14(%ebp)
  80082b:	8b 45 14             	mov    0x14(%ebp),%eax
  80082e:	83 e8 04             	sub    $0x4,%eax
  800831:	8b 00                	mov    (%eax),%eax
  800833:	83 ec 08             	sub    $0x8,%esp
  800836:	ff 75 0c             	pushl  0xc(%ebp)
  800839:	50                   	push   %eax
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	ff d0                	call   *%eax
  80083f:	83 c4 10             	add    $0x10,%esp
			break;
  800842:	e9 9b 02 00 00       	jmp    800ae2 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800847:	8b 45 14             	mov    0x14(%ebp),%eax
  80084a:	83 c0 04             	add    $0x4,%eax
  80084d:	89 45 14             	mov    %eax,0x14(%ebp)
  800850:	8b 45 14             	mov    0x14(%ebp),%eax
  800853:	83 e8 04             	sub    $0x4,%eax
  800856:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800858:	85 db                	test   %ebx,%ebx
  80085a:	79 02                	jns    80085e <vprintfmt+0x14a>
				err = -err;
  80085c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80085e:	83 fb 64             	cmp    $0x64,%ebx
  800861:	7f 0b                	jg     80086e <vprintfmt+0x15a>
  800863:	8b 34 9d 80 2b 80 00 	mov    0x802b80(,%ebx,4),%esi
  80086a:	85 f6                	test   %esi,%esi
  80086c:	75 19                	jne    800887 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80086e:	53                   	push   %ebx
  80086f:	68 25 2d 80 00       	push   $0x802d25
  800874:	ff 75 0c             	pushl  0xc(%ebp)
  800877:	ff 75 08             	pushl  0x8(%ebp)
  80087a:	e8 70 02 00 00       	call   800aef <printfmt>
  80087f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800882:	e9 5b 02 00 00       	jmp    800ae2 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800887:	56                   	push   %esi
  800888:	68 2e 2d 80 00       	push   $0x802d2e
  80088d:	ff 75 0c             	pushl  0xc(%ebp)
  800890:	ff 75 08             	pushl  0x8(%ebp)
  800893:	e8 57 02 00 00       	call   800aef <printfmt>
  800898:	83 c4 10             	add    $0x10,%esp
			break;
  80089b:	e9 42 02 00 00       	jmp    800ae2 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a3:	83 c0 04             	add    $0x4,%eax
  8008a6:	89 45 14             	mov    %eax,0x14(%ebp)
  8008a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ac:	83 e8 04             	sub    $0x4,%eax
  8008af:	8b 30                	mov    (%eax),%esi
  8008b1:	85 f6                	test   %esi,%esi
  8008b3:	75 05                	jne    8008ba <vprintfmt+0x1a6>
				p = "(null)";
  8008b5:	be 31 2d 80 00       	mov    $0x802d31,%esi
			if (width > 0 && padc != '-')
  8008ba:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008be:	7e 6d                	jle    80092d <vprintfmt+0x219>
  8008c0:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008c4:	74 67                	je     80092d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c9:	83 ec 08             	sub    $0x8,%esp
  8008cc:	50                   	push   %eax
  8008cd:	56                   	push   %esi
  8008ce:	e8 26 05 00 00       	call   800df9 <strnlen>
  8008d3:	83 c4 10             	add    $0x10,%esp
  8008d6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8008d9:	eb 16                	jmp    8008f1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008db:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008df:	83 ec 08             	sub    $0x8,%esp
  8008e2:	ff 75 0c             	pushl  0xc(%ebp)
  8008e5:	50                   	push   %eax
  8008e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e9:	ff d0                	call   *%eax
  8008eb:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008ee:	ff 4d e4             	decl   -0x1c(%ebp)
  8008f1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008f5:	7f e4                	jg     8008db <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008f7:	eb 34                	jmp    80092d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008f9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008fd:	74 1c                	je     80091b <vprintfmt+0x207>
  8008ff:	83 fb 1f             	cmp    $0x1f,%ebx
  800902:	7e 05                	jle    800909 <vprintfmt+0x1f5>
  800904:	83 fb 7e             	cmp    $0x7e,%ebx
  800907:	7e 12                	jle    80091b <vprintfmt+0x207>
					putch('?', putdat);
  800909:	83 ec 08             	sub    $0x8,%esp
  80090c:	ff 75 0c             	pushl  0xc(%ebp)
  80090f:	6a 3f                	push   $0x3f
  800911:	8b 45 08             	mov    0x8(%ebp),%eax
  800914:	ff d0                	call   *%eax
  800916:	83 c4 10             	add    $0x10,%esp
  800919:	eb 0f                	jmp    80092a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80091b:	83 ec 08             	sub    $0x8,%esp
  80091e:	ff 75 0c             	pushl  0xc(%ebp)
  800921:	53                   	push   %ebx
  800922:	8b 45 08             	mov    0x8(%ebp),%eax
  800925:	ff d0                	call   *%eax
  800927:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80092a:	ff 4d e4             	decl   -0x1c(%ebp)
  80092d:	89 f0                	mov    %esi,%eax
  80092f:	8d 70 01             	lea    0x1(%eax),%esi
  800932:	8a 00                	mov    (%eax),%al
  800934:	0f be d8             	movsbl %al,%ebx
  800937:	85 db                	test   %ebx,%ebx
  800939:	74 24                	je     80095f <vprintfmt+0x24b>
  80093b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80093f:	78 b8                	js     8008f9 <vprintfmt+0x1e5>
  800941:	ff 4d e0             	decl   -0x20(%ebp)
  800944:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800948:	79 af                	jns    8008f9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80094a:	eb 13                	jmp    80095f <vprintfmt+0x24b>
				putch(' ', putdat);
  80094c:	83 ec 08             	sub    $0x8,%esp
  80094f:	ff 75 0c             	pushl  0xc(%ebp)
  800952:	6a 20                	push   $0x20
  800954:	8b 45 08             	mov    0x8(%ebp),%eax
  800957:	ff d0                	call   *%eax
  800959:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80095c:	ff 4d e4             	decl   -0x1c(%ebp)
  80095f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800963:	7f e7                	jg     80094c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800965:	e9 78 01 00 00       	jmp    800ae2 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80096a:	83 ec 08             	sub    $0x8,%esp
  80096d:	ff 75 e8             	pushl  -0x18(%ebp)
  800970:	8d 45 14             	lea    0x14(%ebp),%eax
  800973:	50                   	push   %eax
  800974:	e8 3c fd ff ff       	call   8006b5 <getint>
  800979:	83 c4 10             	add    $0x10,%esp
  80097c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80097f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800982:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800985:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800988:	85 d2                	test   %edx,%edx
  80098a:	79 23                	jns    8009af <vprintfmt+0x29b>
				putch('-', putdat);
  80098c:	83 ec 08             	sub    $0x8,%esp
  80098f:	ff 75 0c             	pushl  0xc(%ebp)
  800992:	6a 2d                	push   $0x2d
  800994:	8b 45 08             	mov    0x8(%ebp),%eax
  800997:	ff d0                	call   *%eax
  800999:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80099c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80099f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009a2:	f7 d8                	neg    %eax
  8009a4:	83 d2 00             	adc    $0x0,%edx
  8009a7:	f7 da                	neg    %edx
  8009a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009af:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009b6:	e9 bc 00 00 00       	jmp    800a77 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009bb:	83 ec 08             	sub    $0x8,%esp
  8009be:	ff 75 e8             	pushl  -0x18(%ebp)
  8009c1:	8d 45 14             	lea    0x14(%ebp),%eax
  8009c4:	50                   	push   %eax
  8009c5:	e8 84 fc ff ff       	call   80064e <getuint>
  8009ca:	83 c4 10             	add    $0x10,%esp
  8009cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009d0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8009d3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009da:	e9 98 00 00 00       	jmp    800a77 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 0c             	pushl  0xc(%ebp)
  8009e5:	6a 58                	push   $0x58
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	ff d0                	call   *%eax
  8009ec:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009ef:	83 ec 08             	sub    $0x8,%esp
  8009f2:	ff 75 0c             	pushl  0xc(%ebp)
  8009f5:	6a 58                	push   $0x58
  8009f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fa:	ff d0                	call   *%eax
  8009fc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009ff:	83 ec 08             	sub    $0x8,%esp
  800a02:	ff 75 0c             	pushl  0xc(%ebp)
  800a05:	6a 58                	push   $0x58
  800a07:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0a:	ff d0                	call   *%eax
  800a0c:	83 c4 10             	add    $0x10,%esp
			break;
  800a0f:	e9 ce 00 00 00       	jmp    800ae2 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800a14:	83 ec 08             	sub    $0x8,%esp
  800a17:	ff 75 0c             	pushl  0xc(%ebp)
  800a1a:	6a 30                	push   $0x30
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	ff d0                	call   *%eax
  800a21:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a24:	83 ec 08             	sub    $0x8,%esp
  800a27:	ff 75 0c             	pushl  0xc(%ebp)
  800a2a:	6a 78                	push   $0x78
  800a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2f:	ff d0                	call   *%eax
  800a31:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a34:	8b 45 14             	mov    0x14(%ebp),%eax
  800a37:	83 c0 04             	add    $0x4,%eax
  800a3a:	89 45 14             	mov    %eax,0x14(%ebp)
  800a3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a40:	83 e8 04             	sub    $0x4,%eax
  800a43:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a48:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a4f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a56:	eb 1f                	jmp    800a77 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a58:	83 ec 08             	sub    $0x8,%esp
  800a5b:	ff 75 e8             	pushl  -0x18(%ebp)
  800a5e:	8d 45 14             	lea    0x14(%ebp),%eax
  800a61:	50                   	push   %eax
  800a62:	e8 e7 fb ff ff       	call   80064e <getuint>
  800a67:	83 c4 10             	add    $0x10,%esp
  800a6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a70:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a77:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a7e:	83 ec 04             	sub    $0x4,%esp
  800a81:	52                   	push   %edx
  800a82:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a85:	50                   	push   %eax
  800a86:	ff 75 f4             	pushl  -0xc(%ebp)
  800a89:	ff 75 f0             	pushl  -0x10(%ebp)
  800a8c:	ff 75 0c             	pushl  0xc(%ebp)
  800a8f:	ff 75 08             	pushl  0x8(%ebp)
  800a92:	e8 00 fb ff ff       	call   800597 <printnum>
  800a97:	83 c4 20             	add    $0x20,%esp
			break;
  800a9a:	eb 46                	jmp    800ae2 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a9c:	83 ec 08             	sub    $0x8,%esp
  800a9f:	ff 75 0c             	pushl  0xc(%ebp)
  800aa2:	53                   	push   %ebx
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	ff d0                	call   *%eax
  800aa8:	83 c4 10             	add    $0x10,%esp
			break;
  800aab:	eb 35                	jmp    800ae2 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800aad:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  800ab4:	eb 2c                	jmp    800ae2 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800ab6:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  800abd:	eb 23                	jmp    800ae2 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800abf:	83 ec 08             	sub    $0x8,%esp
  800ac2:	ff 75 0c             	pushl  0xc(%ebp)
  800ac5:	6a 25                	push   $0x25
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	ff d0                	call   *%eax
  800acc:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800acf:	ff 4d 10             	decl   0x10(%ebp)
  800ad2:	eb 03                	jmp    800ad7 <vprintfmt+0x3c3>
  800ad4:	ff 4d 10             	decl   0x10(%ebp)
  800ad7:	8b 45 10             	mov    0x10(%ebp),%eax
  800ada:	48                   	dec    %eax
  800adb:	8a 00                	mov    (%eax),%al
  800add:	3c 25                	cmp    $0x25,%al
  800adf:	75 f3                	jne    800ad4 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800ae1:	90                   	nop
		}
	}
  800ae2:	e9 35 fc ff ff       	jmp    80071c <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ae7:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ae8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800aeb:	5b                   	pop    %ebx
  800aec:	5e                   	pop    %esi
  800aed:	5d                   	pop    %ebp
  800aee:	c3                   	ret    

00800aef <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800aef:	55                   	push   %ebp
  800af0:	89 e5                	mov    %esp,%ebp
  800af2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800af5:	8d 45 10             	lea    0x10(%ebp),%eax
  800af8:	83 c0 04             	add    $0x4,%eax
  800afb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800afe:	8b 45 10             	mov    0x10(%ebp),%eax
  800b01:	ff 75 f4             	pushl  -0xc(%ebp)
  800b04:	50                   	push   %eax
  800b05:	ff 75 0c             	pushl  0xc(%ebp)
  800b08:	ff 75 08             	pushl  0x8(%ebp)
  800b0b:	e8 04 fc ff ff       	call   800714 <vprintfmt>
  800b10:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b13:	90                   	nop
  800b14:	c9                   	leave  
  800b15:	c3                   	ret    

00800b16 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b16:	55                   	push   %ebp
  800b17:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1c:	8b 40 08             	mov    0x8(%eax),%eax
  800b1f:	8d 50 01             	lea    0x1(%eax),%edx
  800b22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b25:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2b:	8b 10                	mov    (%eax),%edx
  800b2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b30:	8b 40 04             	mov    0x4(%eax),%eax
  800b33:	39 c2                	cmp    %eax,%edx
  800b35:	73 12                	jae    800b49 <sprintputch+0x33>
		*b->buf++ = ch;
  800b37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3a:	8b 00                	mov    (%eax),%eax
  800b3c:	8d 48 01             	lea    0x1(%eax),%ecx
  800b3f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b42:	89 0a                	mov    %ecx,(%edx)
  800b44:	8b 55 08             	mov    0x8(%ebp),%edx
  800b47:	88 10                	mov    %dl,(%eax)
}
  800b49:	90                   	nop
  800b4a:	5d                   	pop    %ebp
  800b4b:	c3                   	ret    

00800b4c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b4c:	55                   	push   %ebp
  800b4d:	89 e5                	mov    %esp,%ebp
  800b4f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b61:	01 d0                	add    %edx,%eax
  800b63:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b66:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b6d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b71:	74 06                	je     800b79 <vsnprintf+0x2d>
  800b73:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b77:	7f 07                	jg     800b80 <vsnprintf+0x34>
		return -E_INVAL;
  800b79:	b8 03 00 00 00       	mov    $0x3,%eax
  800b7e:	eb 20                	jmp    800ba0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b80:	ff 75 14             	pushl  0x14(%ebp)
  800b83:	ff 75 10             	pushl  0x10(%ebp)
  800b86:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b89:	50                   	push   %eax
  800b8a:	68 16 0b 80 00       	push   $0x800b16
  800b8f:	e8 80 fb ff ff       	call   800714 <vprintfmt>
  800b94:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b97:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b9a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ba0:	c9                   	leave  
  800ba1:	c3                   	ret    

00800ba2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ba2:	55                   	push   %ebp
  800ba3:	89 e5                	mov    %esp,%ebp
  800ba5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ba8:	8d 45 10             	lea    0x10(%ebp),%eax
  800bab:	83 c0 04             	add    $0x4,%eax
  800bae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bb1:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb4:	ff 75 f4             	pushl  -0xc(%ebp)
  800bb7:	50                   	push   %eax
  800bb8:	ff 75 0c             	pushl  0xc(%ebp)
  800bbb:	ff 75 08             	pushl  0x8(%ebp)
  800bbe:	e8 89 ff ff ff       	call   800b4c <vsnprintf>
  800bc3:	83 c4 10             	add    $0x10,%esp
  800bc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800bc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bcc:	c9                   	leave  
  800bcd:	c3                   	ret    

00800bce <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800bce:	55                   	push   %ebp
  800bcf:	89 e5                	mov    %esp,%ebp
  800bd1:	83 ec 18             	sub    $0x18,%esp
	int i, c, echoing;

	if (prompt != NULL)
  800bd4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bd8:	74 13                	je     800bed <readline+0x1f>
		cprintf("%s", prompt);
  800bda:	83 ec 08             	sub    $0x8,%esp
  800bdd:	ff 75 08             	pushl  0x8(%ebp)
  800be0:	68 a8 2e 80 00       	push   $0x802ea8
  800be5:	e8 0b f9 ff ff       	call   8004f5 <cprintf>
  800bea:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800bed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800bf4:	83 ec 0c             	sub    $0xc,%esp
  800bf7:	6a 00                	push   $0x0
  800bf9:	e8 63 18 00 00       	call   802461 <iscons>
  800bfe:	83 c4 10             	add    $0x10,%esp
  800c01:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800c04:	e8 3f 18 00 00       	call   802448 <getchar>
  800c09:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800c0c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800c10:	79 22                	jns    800c34 <readline+0x66>
			if (c != -E_EOF)
  800c12:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800c16:	0f 84 ad 00 00 00    	je     800cc9 <readline+0xfb>
				cprintf("read error: %e\n", c);
  800c1c:	83 ec 08             	sub    $0x8,%esp
  800c1f:	ff 75 ec             	pushl  -0x14(%ebp)
  800c22:	68 ab 2e 80 00       	push   $0x802eab
  800c27:	e8 c9 f8 ff ff       	call   8004f5 <cprintf>
  800c2c:	83 c4 10             	add    $0x10,%esp
			break;
  800c2f:	e9 95 00 00 00       	jmp    800cc9 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800c34:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800c38:	7e 34                	jle    800c6e <readline+0xa0>
  800c3a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800c41:	7f 2b                	jg     800c6e <readline+0xa0>
			if (echoing)
  800c43:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800c47:	74 0e                	je     800c57 <readline+0x89>
				cputchar(c);
  800c49:	83 ec 0c             	sub    $0xc,%esp
  800c4c:	ff 75 ec             	pushl  -0x14(%ebp)
  800c4f:	e8 d5 17 00 00       	call   802429 <cputchar>
  800c54:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c5a:	8d 50 01             	lea    0x1(%eax),%edx
  800c5d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800c60:	89 c2                	mov    %eax,%edx
  800c62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c65:	01 d0                	add    %edx,%eax
  800c67:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800c6a:	88 10                	mov    %dl,(%eax)
  800c6c:	eb 56                	jmp    800cc4 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800c6e:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800c72:	75 1f                	jne    800c93 <readline+0xc5>
  800c74:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800c78:	7e 19                	jle    800c93 <readline+0xc5>
			if (echoing)
  800c7a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800c7e:	74 0e                	je     800c8e <readline+0xc0>
				cputchar(c);
  800c80:	83 ec 0c             	sub    $0xc,%esp
  800c83:	ff 75 ec             	pushl  -0x14(%ebp)
  800c86:	e8 9e 17 00 00       	call   802429 <cputchar>
  800c8b:	83 c4 10             	add    $0x10,%esp

			i--;
  800c8e:	ff 4d f4             	decl   -0xc(%ebp)
  800c91:	eb 31                	jmp    800cc4 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800c93:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800c97:	74 0a                	je     800ca3 <readline+0xd5>
  800c99:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800c9d:	0f 85 61 ff ff ff    	jne    800c04 <readline+0x36>
			if (echoing)
  800ca3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ca7:	74 0e                	je     800cb7 <readline+0xe9>
				cputchar(c);
  800ca9:	83 ec 0c             	sub    $0xc,%esp
  800cac:	ff 75 ec             	pushl  -0x14(%ebp)
  800caf:	e8 75 17 00 00       	call   802429 <cputchar>
  800cb4:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800cb7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbd:	01 d0                	add    %edx,%eax
  800cbf:	c6 00 00             	movb   $0x0,(%eax)
			break;
  800cc2:	eb 06                	jmp    800cca <readline+0xfc>
		}
	}
  800cc4:	e9 3b ff ff ff       	jmp    800c04 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			break;
  800cc9:	90                   	nop

			buf[i] = 0;
			break;
		}
	}
}
  800cca:	90                   	nop
  800ccb:	c9                   	leave  
  800ccc:	c3                   	ret    

00800ccd <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800ccd:	55                   	push   %ebp
  800cce:	89 e5                	mov    %esp,%ebp
  800cd0:	83 ec 18             	sub    $0x18,%esp
	sys_lock_cons();
  800cd3:	e8 a1 0a 00 00       	call   801779 <sys_lock_cons>
	{
		int i, c, echoing;

		if (prompt != NULL)
  800cd8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800cdc:	74 13                	je     800cf1 <atomic_readline+0x24>
			cprintf("%s", prompt);
  800cde:	83 ec 08             	sub    $0x8,%esp
  800ce1:	ff 75 08             	pushl  0x8(%ebp)
  800ce4:	68 a8 2e 80 00       	push   $0x802ea8
  800ce9:	e8 07 f8 ff ff       	call   8004f5 <cprintf>
  800cee:	83 c4 10             	add    $0x10,%esp

		i = 0;
  800cf1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		echoing = iscons(0);
  800cf8:	83 ec 0c             	sub    $0xc,%esp
  800cfb:	6a 00                	push   $0x0
  800cfd:	e8 5f 17 00 00       	call   802461 <iscons>
  800d02:	83 c4 10             	add    $0x10,%esp
  800d05:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (1) {
			c = getchar();
  800d08:	e8 3b 17 00 00       	call   802448 <getchar>
  800d0d:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (c < 0) {
  800d10:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800d14:	79 22                	jns    800d38 <atomic_readline+0x6b>
				if (c != -E_EOF)
  800d16:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800d1a:	0f 84 ad 00 00 00    	je     800dcd <atomic_readline+0x100>
					cprintf("read error: %e\n", c);
  800d20:	83 ec 08             	sub    $0x8,%esp
  800d23:	ff 75 ec             	pushl  -0x14(%ebp)
  800d26:	68 ab 2e 80 00       	push   $0x802eab
  800d2b:	e8 c5 f7 ff ff       	call   8004f5 <cprintf>
  800d30:	83 c4 10             	add    $0x10,%esp
				break;
  800d33:	e9 95 00 00 00       	jmp    800dcd <atomic_readline+0x100>
			} else if (c >= ' ' && i < BUFLEN-1) {
  800d38:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800d3c:	7e 34                	jle    800d72 <atomic_readline+0xa5>
  800d3e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800d45:	7f 2b                	jg     800d72 <atomic_readline+0xa5>
				if (echoing)
  800d47:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800d4b:	74 0e                	je     800d5b <atomic_readline+0x8e>
					cputchar(c);
  800d4d:	83 ec 0c             	sub    $0xc,%esp
  800d50:	ff 75 ec             	pushl  -0x14(%ebp)
  800d53:	e8 d1 16 00 00       	call   802429 <cputchar>
  800d58:	83 c4 10             	add    $0x10,%esp
				buf[i++] = c;
  800d5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d5e:	8d 50 01             	lea    0x1(%eax),%edx
  800d61:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800d64:	89 c2                	mov    %eax,%edx
  800d66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d69:	01 d0                	add    %edx,%eax
  800d6b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d6e:	88 10                	mov    %dl,(%eax)
  800d70:	eb 56                	jmp    800dc8 <atomic_readline+0xfb>
			} else if (c == '\b' && i > 0) {
  800d72:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800d76:	75 1f                	jne    800d97 <atomic_readline+0xca>
  800d78:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800d7c:	7e 19                	jle    800d97 <atomic_readline+0xca>
				if (echoing)
  800d7e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800d82:	74 0e                	je     800d92 <atomic_readline+0xc5>
					cputchar(c);
  800d84:	83 ec 0c             	sub    $0xc,%esp
  800d87:	ff 75 ec             	pushl  -0x14(%ebp)
  800d8a:	e8 9a 16 00 00       	call   802429 <cputchar>
  800d8f:	83 c4 10             	add    $0x10,%esp
				i--;
  800d92:	ff 4d f4             	decl   -0xc(%ebp)
  800d95:	eb 31                	jmp    800dc8 <atomic_readline+0xfb>
			} else if (c == '\n' || c == '\r') {
  800d97:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800d9b:	74 0a                	je     800da7 <atomic_readline+0xda>
  800d9d:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800da1:	0f 85 61 ff ff ff    	jne    800d08 <atomic_readline+0x3b>
				if (echoing)
  800da7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800dab:	74 0e                	je     800dbb <atomic_readline+0xee>
					cputchar(c);
  800dad:	83 ec 0c             	sub    $0xc,%esp
  800db0:	ff 75 ec             	pushl  -0x14(%ebp)
  800db3:	e8 71 16 00 00       	call   802429 <cputchar>
  800db8:	83 c4 10             	add    $0x10,%esp
				buf[i] = 0;
  800dbb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc1:	01 d0                	add    %edx,%eax
  800dc3:	c6 00 00             	movb   $0x0,(%eax)
				break;
  800dc6:	eb 06                	jmp    800dce <atomic_readline+0x101>
			}
		}
  800dc8:	e9 3b ff ff ff       	jmp    800d08 <atomic_readline+0x3b>
		while (1) {
			c = getchar();
			if (c < 0) {
				if (c != -E_EOF)
					cprintf("read error: %e\n", c);
				break;
  800dcd:	90                   	nop
				buf[i] = 0;
				break;
			}
		}
	}
	sys_unlock_cons();
  800dce:	e8 c0 09 00 00       	call   801793 <sys_unlock_cons>
}
  800dd3:	90                   	nop
  800dd4:	c9                   	leave  
  800dd5:	c3                   	ret    

00800dd6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800dd6:	55                   	push   %ebp
  800dd7:	89 e5                	mov    %esp,%ebp
  800dd9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ddc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800de3:	eb 06                	jmp    800deb <strlen+0x15>
		n++;
  800de5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800de8:	ff 45 08             	incl   0x8(%ebp)
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dee:	8a 00                	mov    (%eax),%al
  800df0:	84 c0                	test   %al,%al
  800df2:	75 f1                	jne    800de5 <strlen+0xf>
		n++;
	return n;
  800df4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800df7:	c9                   	leave  
  800df8:	c3                   	ret    

00800df9 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800df9:	55                   	push   %ebp
  800dfa:	89 e5                	mov    %esp,%ebp
  800dfc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e06:	eb 09                	jmp    800e11 <strnlen+0x18>
		n++;
  800e08:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e0b:	ff 45 08             	incl   0x8(%ebp)
  800e0e:	ff 4d 0c             	decl   0xc(%ebp)
  800e11:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e15:	74 09                	je     800e20 <strnlen+0x27>
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1a:	8a 00                	mov    (%eax),%al
  800e1c:	84 c0                	test   %al,%al
  800e1e:	75 e8                	jne    800e08 <strnlen+0xf>
		n++;
	return n;
  800e20:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e23:	c9                   	leave  
  800e24:	c3                   	ret    

00800e25 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e25:	55                   	push   %ebp
  800e26:	89 e5                	mov    %esp,%ebp
  800e28:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e31:	90                   	nop
  800e32:	8b 45 08             	mov    0x8(%ebp),%eax
  800e35:	8d 50 01             	lea    0x1(%eax),%edx
  800e38:	89 55 08             	mov    %edx,0x8(%ebp)
  800e3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e3e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e41:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e44:	8a 12                	mov    (%edx),%dl
  800e46:	88 10                	mov    %dl,(%eax)
  800e48:	8a 00                	mov    (%eax),%al
  800e4a:	84 c0                	test   %al,%al
  800e4c:	75 e4                	jne    800e32 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e51:	c9                   	leave  
  800e52:	c3                   	ret    

00800e53 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e53:	55                   	push   %ebp
  800e54:	89 e5                	mov    %esp,%ebp
  800e56:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e59:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e66:	eb 1f                	jmp    800e87 <strncpy+0x34>
		*dst++ = *src;
  800e68:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6b:	8d 50 01             	lea    0x1(%eax),%edx
  800e6e:	89 55 08             	mov    %edx,0x8(%ebp)
  800e71:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e74:	8a 12                	mov    (%edx),%dl
  800e76:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7b:	8a 00                	mov    (%eax),%al
  800e7d:	84 c0                	test   %al,%al
  800e7f:	74 03                	je     800e84 <strncpy+0x31>
			src++;
  800e81:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e84:	ff 45 fc             	incl   -0x4(%ebp)
  800e87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e8a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e8d:	72 d9                	jb     800e68 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e8f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e92:	c9                   	leave  
  800e93:	c3                   	ret    

00800e94 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e94:	55                   	push   %ebp
  800e95:	89 e5                	mov    %esp,%ebp
  800e97:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ea0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ea4:	74 30                	je     800ed6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ea6:	eb 16                	jmp    800ebe <strlcpy+0x2a>
			*dst++ = *src++;
  800ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eab:	8d 50 01             	lea    0x1(%eax),%edx
  800eae:	89 55 08             	mov    %edx,0x8(%ebp)
  800eb1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eb4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eb7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800eba:	8a 12                	mov    (%edx),%dl
  800ebc:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ebe:	ff 4d 10             	decl   0x10(%ebp)
  800ec1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec5:	74 09                	je     800ed0 <strlcpy+0x3c>
  800ec7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eca:	8a 00                	mov    (%eax),%al
  800ecc:	84 c0                	test   %al,%al
  800ece:	75 d8                	jne    800ea8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ed6:	8b 55 08             	mov    0x8(%ebp),%edx
  800ed9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800edc:	29 c2                	sub    %eax,%edx
  800ede:	89 d0                	mov    %edx,%eax
}
  800ee0:	c9                   	leave  
  800ee1:	c3                   	ret    

00800ee2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ee2:	55                   	push   %ebp
  800ee3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ee5:	eb 06                	jmp    800eed <strcmp+0xb>
		p++, q++;
  800ee7:	ff 45 08             	incl   0x8(%ebp)
  800eea:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	84 c0                	test   %al,%al
  800ef4:	74 0e                	je     800f04 <strcmp+0x22>
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	8a 10                	mov    (%eax),%dl
  800efb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	38 c2                	cmp    %al,%dl
  800f02:	74 e3                	je     800ee7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f04:	8b 45 08             	mov    0x8(%ebp),%eax
  800f07:	8a 00                	mov    (%eax),%al
  800f09:	0f b6 d0             	movzbl %al,%edx
  800f0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0f:	8a 00                	mov    (%eax),%al
  800f11:	0f b6 c0             	movzbl %al,%eax
  800f14:	29 c2                	sub    %eax,%edx
  800f16:	89 d0                	mov    %edx,%eax
}
  800f18:	5d                   	pop    %ebp
  800f19:	c3                   	ret    

00800f1a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f1a:	55                   	push   %ebp
  800f1b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f1d:	eb 09                	jmp    800f28 <strncmp+0xe>
		n--, p++, q++;
  800f1f:	ff 4d 10             	decl   0x10(%ebp)
  800f22:	ff 45 08             	incl   0x8(%ebp)
  800f25:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f28:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2c:	74 17                	je     800f45 <strncmp+0x2b>
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	8a 00                	mov    (%eax),%al
  800f33:	84 c0                	test   %al,%al
  800f35:	74 0e                	je     800f45 <strncmp+0x2b>
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	8a 10                	mov    (%eax),%dl
  800f3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	38 c2                	cmp    %al,%dl
  800f43:	74 da                	je     800f1f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f45:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f49:	75 07                	jne    800f52 <strncmp+0x38>
		return 0;
  800f4b:	b8 00 00 00 00       	mov    $0x0,%eax
  800f50:	eb 14                	jmp    800f66 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	8a 00                	mov    (%eax),%al
  800f57:	0f b6 d0             	movzbl %al,%edx
  800f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5d:	8a 00                	mov    (%eax),%al
  800f5f:	0f b6 c0             	movzbl %al,%eax
  800f62:	29 c2                	sub    %eax,%edx
  800f64:	89 d0                	mov    %edx,%eax
}
  800f66:	5d                   	pop    %ebp
  800f67:	c3                   	ret    

00800f68 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f68:	55                   	push   %ebp
  800f69:	89 e5                	mov    %esp,%ebp
  800f6b:	83 ec 04             	sub    $0x4,%esp
  800f6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f71:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f74:	eb 12                	jmp    800f88 <strchr+0x20>
		if (*s == c)
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	8a 00                	mov    (%eax),%al
  800f7b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f7e:	75 05                	jne    800f85 <strchr+0x1d>
			return (char *) s;
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	eb 11                	jmp    800f96 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f85:	ff 45 08             	incl   0x8(%ebp)
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8b:	8a 00                	mov    (%eax),%al
  800f8d:	84 c0                	test   %al,%al
  800f8f:	75 e5                	jne    800f76 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f91:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f96:	c9                   	leave  
  800f97:	c3                   	ret    

00800f98 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f98:	55                   	push   %ebp
  800f99:	89 e5                	mov    %esp,%ebp
  800f9b:	83 ec 04             	sub    $0x4,%esp
  800f9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fa4:	eb 0d                	jmp    800fb3 <strfind+0x1b>
		if (*s == c)
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	8a 00                	mov    (%eax),%al
  800fab:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fae:	74 0e                	je     800fbe <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fb0:	ff 45 08             	incl   0x8(%ebp)
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	84 c0                	test   %al,%al
  800fba:	75 ea                	jne    800fa6 <strfind+0xe>
  800fbc:	eb 01                	jmp    800fbf <strfind+0x27>
		if (*s == c)
			break;
  800fbe:	90                   	nop
	return (char *) s;
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc2:	c9                   	leave  
  800fc3:	c3                   	ret    

00800fc4 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800fc4:	55                   	push   %ebp
  800fc5:	89 e5                	mov    %esp,%ebp
  800fc7:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800fd0:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fd4:	76 63                	jbe    801039 <memset+0x75>
		uint64 data_block = c;
  800fd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd9:	99                   	cltd   
  800fda:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fdd:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800fe0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe6:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800fea:	c1 e0 08             	shl    $0x8,%eax
  800fed:	09 45 f0             	or     %eax,-0x10(%ebp)
  800ff0:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800ff3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ff6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ff9:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800ffd:	c1 e0 10             	shl    $0x10,%eax
  801000:	09 45 f0             	or     %eax,-0x10(%ebp)
  801003:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  801006:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801009:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80100c:	89 c2                	mov    %eax,%edx
  80100e:	b8 00 00 00 00       	mov    $0x0,%eax
  801013:	09 45 f0             	or     %eax,-0x10(%ebp)
  801016:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  801019:	eb 18                	jmp    801033 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  80101b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80101e:	8d 41 08             	lea    0x8(%ecx),%eax
  801021:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801024:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801027:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80102a:	89 01                	mov    %eax,(%ecx)
  80102c:	89 51 04             	mov    %edx,0x4(%ecx)
  80102f:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801033:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801037:	77 e2                	ja     80101b <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  801039:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80103d:	74 23                	je     801062 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  80103f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801042:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  801045:	eb 0e                	jmp    801055 <memset+0x91>
			*p8++ = (uint8)c;
  801047:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80104a:	8d 50 01             	lea    0x1(%eax),%edx
  80104d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801050:	8b 55 0c             	mov    0xc(%ebp),%edx
  801053:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  801055:	8b 45 10             	mov    0x10(%ebp),%eax
  801058:	8d 50 ff             	lea    -0x1(%eax),%edx
  80105b:	89 55 10             	mov    %edx,0x10(%ebp)
  80105e:	85 c0                	test   %eax,%eax
  801060:	75 e5                	jne    801047 <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  801062:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801065:	c9                   	leave  
  801066:	c3                   	ret    

00801067 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801067:	55                   	push   %ebp
  801068:	89 e5                	mov    %esp,%ebp
  80106a:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  80106d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801070:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  801073:	8b 45 08             	mov    0x8(%ebp),%eax
  801076:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  801079:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80107d:	76 24                	jbe    8010a3 <memcpy+0x3c>
		while(n >= 8){
  80107f:	eb 1c                	jmp    80109d <memcpy+0x36>
			*d64 = *s64;
  801081:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801084:	8b 50 04             	mov    0x4(%eax),%edx
  801087:	8b 00                	mov    (%eax),%eax
  801089:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80108c:	89 01                	mov    %eax,(%ecx)
  80108e:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  801091:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  801095:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  801099:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  80109d:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8010a1:	77 de                	ja     801081 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  8010a3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010a7:	74 31                	je     8010da <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8010a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8010af:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8010b5:	eb 16                	jmp    8010cd <memcpy+0x66>
			*d8++ = *s8++;
  8010b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010ba:	8d 50 01             	lea    0x1(%eax),%edx
  8010bd:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8010c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010c6:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  8010c9:	8a 12                	mov    (%edx),%dl
  8010cb:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  8010cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010d3:	89 55 10             	mov    %edx,0x10(%ebp)
  8010d6:	85 c0                	test   %eax,%eax
  8010d8:	75 dd                	jne    8010b7 <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  8010da:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010dd:	c9                   	leave  
  8010de:	c3                   	ret    

008010df <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010df:	55                   	push   %ebp
  8010e0:	89 e5                	mov    %esp,%ebp
  8010e2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8010f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010f7:	73 50                	jae    801149 <memmove+0x6a>
  8010f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ff:	01 d0                	add    %edx,%eax
  801101:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801104:	76 43                	jbe    801149 <memmove+0x6a>
		s += n;
  801106:	8b 45 10             	mov    0x10(%ebp),%eax
  801109:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80110c:	8b 45 10             	mov    0x10(%ebp),%eax
  80110f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801112:	eb 10                	jmp    801124 <memmove+0x45>
			*--d = *--s;
  801114:	ff 4d f8             	decl   -0x8(%ebp)
  801117:	ff 4d fc             	decl   -0x4(%ebp)
  80111a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80111d:	8a 10                	mov    (%eax),%dl
  80111f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801122:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801124:	8b 45 10             	mov    0x10(%ebp),%eax
  801127:	8d 50 ff             	lea    -0x1(%eax),%edx
  80112a:	89 55 10             	mov    %edx,0x10(%ebp)
  80112d:	85 c0                	test   %eax,%eax
  80112f:	75 e3                	jne    801114 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801131:	eb 23                	jmp    801156 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801133:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801136:	8d 50 01             	lea    0x1(%eax),%edx
  801139:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80113c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80113f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801142:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801145:	8a 12                	mov    (%edx),%dl
  801147:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801149:	8b 45 10             	mov    0x10(%ebp),%eax
  80114c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80114f:	89 55 10             	mov    %edx,0x10(%ebp)
  801152:	85 c0                	test   %eax,%eax
  801154:	75 dd                	jne    801133 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801159:	c9                   	leave  
  80115a:	c3                   	ret    

0080115b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80115b:	55                   	push   %ebp
  80115c:	89 e5                	mov    %esp,%ebp
  80115e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801167:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80116d:	eb 2a                	jmp    801199 <memcmp+0x3e>
		if (*s1 != *s2)
  80116f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801172:	8a 10                	mov    (%eax),%dl
  801174:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801177:	8a 00                	mov    (%eax),%al
  801179:	38 c2                	cmp    %al,%dl
  80117b:	74 16                	je     801193 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80117d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801180:	8a 00                	mov    (%eax),%al
  801182:	0f b6 d0             	movzbl %al,%edx
  801185:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801188:	8a 00                	mov    (%eax),%al
  80118a:	0f b6 c0             	movzbl %al,%eax
  80118d:	29 c2                	sub    %eax,%edx
  80118f:	89 d0                	mov    %edx,%eax
  801191:	eb 18                	jmp    8011ab <memcmp+0x50>
		s1++, s2++;
  801193:	ff 45 fc             	incl   -0x4(%ebp)
  801196:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801199:	8b 45 10             	mov    0x10(%ebp),%eax
  80119c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80119f:	89 55 10             	mov    %edx,0x10(%ebp)
  8011a2:	85 c0                	test   %eax,%eax
  8011a4:	75 c9                	jne    80116f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8011a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011ab:	c9                   	leave  
  8011ac:	c3                   	ret    

008011ad <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8011ad:	55                   	push   %ebp
  8011ae:	89 e5                	mov    %esp,%ebp
  8011b0:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8011b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8011b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b9:	01 d0                	add    %edx,%eax
  8011bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8011be:	eb 15                	jmp    8011d5 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	0f b6 d0             	movzbl %al,%edx
  8011c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cb:	0f b6 c0             	movzbl %al,%eax
  8011ce:	39 c2                	cmp    %eax,%edx
  8011d0:	74 0d                	je     8011df <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8011d2:	ff 45 08             	incl   0x8(%ebp)
  8011d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8011db:	72 e3                	jb     8011c0 <memfind+0x13>
  8011dd:	eb 01                	jmp    8011e0 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011df:	90                   	nop
	return (void *) s;
  8011e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011e3:	c9                   	leave  
  8011e4:	c3                   	ret    

008011e5 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8011e5:	55                   	push   %ebp
  8011e6:	89 e5                	mov    %esp,%ebp
  8011e8:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8011eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8011f2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011f9:	eb 03                	jmp    8011fe <strtol+0x19>
		s++;
  8011fb:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801201:	8a 00                	mov    (%eax),%al
  801203:	3c 20                	cmp    $0x20,%al
  801205:	74 f4                	je     8011fb <strtol+0x16>
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8a 00                	mov    (%eax),%al
  80120c:	3c 09                	cmp    $0x9,%al
  80120e:	74 eb                	je     8011fb <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	8a 00                	mov    (%eax),%al
  801215:	3c 2b                	cmp    $0x2b,%al
  801217:	75 05                	jne    80121e <strtol+0x39>
		s++;
  801219:	ff 45 08             	incl   0x8(%ebp)
  80121c:	eb 13                	jmp    801231 <strtol+0x4c>
	else if (*s == '-')
  80121e:	8b 45 08             	mov    0x8(%ebp),%eax
  801221:	8a 00                	mov    (%eax),%al
  801223:	3c 2d                	cmp    $0x2d,%al
  801225:	75 0a                	jne    801231 <strtol+0x4c>
		s++, neg = 1;
  801227:	ff 45 08             	incl   0x8(%ebp)
  80122a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801231:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801235:	74 06                	je     80123d <strtol+0x58>
  801237:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80123b:	75 20                	jne    80125d <strtol+0x78>
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	8a 00                	mov    (%eax),%al
  801242:	3c 30                	cmp    $0x30,%al
  801244:	75 17                	jne    80125d <strtol+0x78>
  801246:	8b 45 08             	mov    0x8(%ebp),%eax
  801249:	40                   	inc    %eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	3c 78                	cmp    $0x78,%al
  80124e:	75 0d                	jne    80125d <strtol+0x78>
		s += 2, base = 16;
  801250:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801254:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80125b:	eb 28                	jmp    801285 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80125d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801261:	75 15                	jne    801278 <strtol+0x93>
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	8a 00                	mov    (%eax),%al
  801268:	3c 30                	cmp    $0x30,%al
  80126a:	75 0c                	jne    801278 <strtol+0x93>
		s++, base = 8;
  80126c:	ff 45 08             	incl   0x8(%ebp)
  80126f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801276:	eb 0d                	jmp    801285 <strtol+0xa0>
	else if (base == 0)
  801278:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80127c:	75 07                	jne    801285 <strtol+0xa0>
		base = 10;
  80127e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801285:	8b 45 08             	mov    0x8(%ebp),%eax
  801288:	8a 00                	mov    (%eax),%al
  80128a:	3c 2f                	cmp    $0x2f,%al
  80128c:	7e 19                	jle    8012a7 <strtol+0xc2>
  80128e:	8b 45 08             	mov    0x8(%ebp),%eax
  801291:	8a 00                	mov    (%eax),%al
  801293:	3c 39                	cmp    $0x39,%al
  801295:	7f 10                	jg     8012a7 <strtol+0xc2>
			dig = *s - '0';
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	8a 00                	mov    (%eax),%al
  80129c:	0f be c0             	movsbl %al,%eax
  80129f:	83 e8 30             	sub    $0x30,%eax
  8012a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012a5:	eb 42                	jmp    8012e9 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8012a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012aa:	8a 00                	mov    (%eax),%al
  8012ac:	3c 60                	cmp    $0x60,%al
  8012ae:	7e 19                	jle    8012c9 <strtol+0xe4>
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	8a 00                	mov    (%eax),%al
  8012b5:	3c 7a                	cmp    $0x7a,%al
  8012b7:	7f 10                	jg     8012c9 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8012b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bc:	8a 00                	mov    (%eax),%al
  8012be:	0f be c0             	movsbl %al,%eax
  8012c1:	83 e8 57             	sub    $0x57,%eax
  8012c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012c7:	eb 20                	jmp    8012e9 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8012c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cc:	8a 00                	mov    (%eax),%al
  8012ce:	3c 40                	cmp    $0x40,%al
  8012d0:	7e 39                	jle    80130b <strtol+0x126>
  8012d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d5:	8a 00                	mov    (%eax),%al
  8012d7:	3c 5a                	cmp    $0x5a,%al
  8012d9:	7f 30                	jg     80130b <strtol+0x126>
			dig = *s - 'A' + 10;
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
  8012de:	8a 00                	mov    (%eax),%al
  8012e0:	0f be c0             	movsbl %al,%eax
  8012e3:	83 e8 37             	sub    $0x37,%eax
  8012e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8012e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012ec:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012ef:	7d 19                	jge    80130a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8012f1:	ff 45 08             	incl   0x8(%ebp)
  8012f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f7:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012fb:	89 c2                	mov    %eax,%edx
  8012fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801300:	01 d0                	add    %edx,%eax
  801302:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801305:	e9 7b ff ff ff       	jmp    801285 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80130a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80130b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80130f:	74 08                	je     801319 <strtol+0x134>
		*endptr = (char *) s;
  801311:	8b 45 0c             	mov    0xc(%ebp),%eax
  801314:	8b 55 08             	mov    0x8(%ebp),%edx
  801317:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801319:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80131d:	74 07                	je     801326 <strtol+0x141>
  80131f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801322:	f7 d8                	neg    %eax
  801324:	eb 03                	jmp    801329 <strtol+0x144>
  801326:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801329:	c9                   	leave  
  80132a:	c3                   	ret    

0080132b <ltostr>:

void
ltostr(long value, char *str)
{
  80132b:	55                   	push   %ebp
  80132c:	89 e5                	mov    %esp,%ebp
  80132e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801331:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801338:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80133f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801343:	79 13                	jns    801358 <ltostr+0x2d>
	{
		neg = 1;
  801345:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80134c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801352:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801355:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801360:	99                   	cltd   
  801361:	f7 f9                	idiv   %ecx
  801363:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801366:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801369:	8d 50 01             	lea    0x1(%eax),%edx
  80136c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80136f:	89 c2                	mov    %eax,%edx
  801371:	8b 45 0c             	mov    0xc(%ebp),%eax
  801374:	01 d0                	add    %edx,%eax
  801376:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801379:	83 c2 30             	add    $0x30,%edx
  80137c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80137e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801381:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801386:	f7 e9                	imul   %ecx
  801388:	c1 fa 02             	sar    $0x2,%edx
  80138b:	89 c8                	mov    %ecx,%eax
  80138d:	c1 f8 1f             	sar    $0x1f,%eax
  801390:	29 c2                	sub    %eax,%edx
  801392:	89 d0                	mov    %edx,%eax
  801394:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801397:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80139b:	75 bb                	jne    801358 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80139d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8013a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013a7:	48                   	dec    %eax
  8013a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8013ab:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013af:	74 3d                	je     8013ee <ltostr+0xc3>
		start = 1 ;
  8013b1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8013b8:	eb 34                	jmp    8013ee <ltostr+0xc3>
	{
		char tmp = str[start] ;
  8013ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c0:	01 d0                	add    %edx,%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8013c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013cd:	01 c2                	add    %eax,%edx
  8013cf:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8013d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d5:	01 c8                	add    %ecx,%eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013db:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e1:	01 c2                	add    %eax,%edx
  8013e3:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013e6:	88 02                	mov    %al,(%edx)
		start++ ;
  8013e8:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013eb:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013f1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013f4:	7c c4                	jl     8013ba <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013f6:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fc:	01 d0                	add    %edx,%eax
  8013fe:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801401:	90                   	nop
  801402:	c9                   	leave  
  801403:	c3                   	ret    

00801404 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
  801407:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80140a:	ff 75 08             	pushl  0x8(%ebp)
  80140d:	e8 c4 f9 ff ff       	call   800dd6 <strlen>
  801412:	83 c4 04             	add    $0x4,%esp
  801415:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801418:	ff 75 0c             	pushl  0xc(%ebp)
  80141b:	e8 b6 f9 ff ff       	call   800dd6 <strlen>
  801420:	83 c4 04             	add    $0x4,%esp
  801423:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801426:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80142d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801434:	eb 17                	jmp    80144d <strcconcat+0x49>
		final[s] = str1[s] ;
  801436:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801439:	8b 45 10             	mov    0x10(%ebp),%eax
  80143c:	01 c2                	add    %eax,%edx
  80143e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	01 c8                	add    %ecx,%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80144a:	ff 45 fc             	incl   -0x4(%ebp)
  80144d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801450:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801453:	7c e1                	jl     801436 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801455:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80145c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801463:	eb 1f                	jmp    801484 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801465:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801468:	8d 50 01             	lea    0x1(%eax),%edx
  80146b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80146e:	89 c2                	mov    %eax,%edx
  801470:	8b 45 10             	mov    0x10(%ebp),%eax
  801473:	01 c2                	add    %eax,%edx
  801475:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147b:	01 c8                	add    %ecx,%eax
  80147d:	8a 00                	mov    (%eax),%al
  80147f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801481:	ff 45 f8             	incl   -0x8(%ebp)
  801484:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801487:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80148a:	7c d9                	jl     801465 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80148c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148f:	8b 45 10             	mov    0x10(%ebp),%eax
  801492:	01 d0                	add    %edx,%eax
  801494:	c6 00 00             	movb   $0x0,(%eax)
}
  801497:	90                   	nop
  801498:	c9                   	leave  
  801499:	c3                   	ret    

0080149a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80149d:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8014a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a9:	8b 00                	mov    (%eax),%eax
  8014ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b5:	01 d0                	add    %edx,%eax
  8014b7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014bd:	eb 0c                	jmp    8014cb <strsplit+0x31>
			*string++ = 0;
  8014bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c2:	8d 50 01             	lea    0x1(%eax),%edx
  8014c5:	89 55 08             	mov    %edx,0x8(%ebp)
  8014c8:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ce:	8a 00                	mov    (%eax),%al
  8014d0:	84 c0                	test   %al,%al
  8014d2:	74 18                	je     8014ec <strsplit+0x52>
  8014d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d7:	8a 00                	mov    (%eax),%al
  8014d9:	0f be c0             	movsbl %al,%eax
  8014dc:	50                   	push   %eax
  8014dd:	ff 75 0c             	pushl  0xc(%ebp)
  8014e0:	e8 83 fa ff ff       	call   800f68 <strchr>
  8014e5:	83 c4 08             	add    $0x8,%esp
  8014e8:	85 c0                	test   %eax,%eax
  8014ea:	75 d3                	jne    8014bf <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8014ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ef:	8a 00                	mov    (%eax),%al
  8014f1:	84 c0                	test   %al,%al
  8014f3:	74 5a                	je     80154f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8014f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f8:	8b 00                	mov    (%eax),%eax
  8014fa:	83 f8 0f             	cmp    $0xf,%eax
  8014fd:	75 07                	jne    801506 <strsplit+0x6c>
		{
			return 0;
  8014ff:	b8 00 00 00 00       	mov    $0x0,%eax
  801504:	eb 66                	jmp    80156c <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801506:	8b 45 14             	mov    0x14(%ebp),%eax
  801509:	8b 00                	mov    (%eax),%eax
  80150b:	8d 48 01             	lea    0x1(%eax),%ecx
  80150e:	8b 55 14             	mov    0x14(%ebp),%edx
  801511:	89 0a                	mov    %ecx,(%edx)
  801513:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80151a:	8b 45 10             	mov    0x10(%ebp),%eax
  80151d:	01 c2                	add    %eax,%edx
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
  801522:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801524:	eb 03                	jmp    801529 <strsplit+0x8f>
			string++;
  801526:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801529:	8b 45 08             	mov    0x8(%ebp),%eax
  80152c:	8a 00                	mov    (%eax),%al
  80152e:	84 c0                	test   %al,%al
  801530:	74 8b                	je     8014bd <strsplit+0x23>
  801532:	8b 45 08             	mov    0x8(%ebp),%eax
  801535:	8a 00                	mov    (%eax),%al
  801537:	0f be c0             	movsbl %al,%eax
  80153a:	50                   	push   %eax
  80153b:	ff 75 0c             	pushl  0xc(%ebp)
  80153e:	e8 25 fa ff ff       	call   800f68 <strchr>
  801543:	83 c4 08             	add    $0x8,%esp
  801546:	85 c0                	test   %eax,%eax
  801548:	74 dc                	je     801526 <strsplit+0x8c>
			string++;
	}
  80154a:	e9 6e ff ff ff       	jmp    8014bd <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80154f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801550:	8b 45 14             	mov    0x14(%ebp),%eax
  801553:	8b 00                	mov    (%eax),%eax
  801555:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80155c:	8b 45 10             	mov    0x10(%ebp),%eax
  80155f:	01 d0                	add    %edx,%eax
  801561:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801567:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80156c:	c9                   	leave  
  80156d:	c3                   	ret    

0080156e <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  80156e:	55                   	push   %ebp
  80156f:	89 e5                	mov    %esp,%ebp
  801571:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801574:	8b 45 08             	mov    0x8(%ebp),%eax
  801577:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  80157a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801581:	eb 4a                	jmp    8015cd <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801583:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801586:	8b 45 08             	mov    0x8(%ebp),%eax
  801589:	01 c2                	add    %eax,%edx
  80158b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80158e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801591:	01 c8                	add    %ecx,%eax
  801593:	8a 00                	mov    (%eax),%al
  801595:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801597:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80159a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159d:	01 d0                	add    %edx,%eax
  80159f:	8a 00                	mov    (%eax),%al
  8015a1:	3c 40                	cmp    $0x40,%al
  8015a3:	7e 25                	jle    8015ca <str2lower+0x5c>
  8015a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ab:	01 d0                	add    %edx,%eax
  8015ad:	8a 00                	mov    (%eax),%al
  8015af:	3c 5a                	cmp    $0x5a,%al
  8015b1:	7f 17                	jg     8015ca <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8015b3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b9:	01 d0                	add    %edx,%eax
  8015bb:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015be:	8b 55 08             	mov    0x8(%ebp),%edx
  8015c1:	01 ca                	add    %ecx,%edx
  8015c3:	8a 12                	mov    (%edx),%dl
  8015c5:	83 c2 20             	add    $0x20,%edx
  8015c8:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  8015ca:	ff 45 fc             	incl   -0x4(%ebp)
  8015cd:	ff 75 0c             	pushl  0xc(%ebp)
  8015d0:	e8 01 f8 ff ff       	call   800dd6 <strlen>
  8015d5:	83 c4 04             	add    $0x4,%esp
  8015d8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015db:	7f a6                	jg     801583 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  8015dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015e0:	c9                   	leave  
  8015e1:	c3                   	ret    

008015e2 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  8015e2:	55                   	push   %ebp
  8015e3:	89 e5                	mov    %esp,%ebp
  8015e5:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  8015e8:	a1 08 40 80 00       	mov    0x804008,%eax
  8015ed:	85 c0                	test   %eax,%eax
  8015ef:	74 2d                	je     80161e <uheap_init+0x3c>
	{
		buddy_init();
  8015f1:	e8 87 06 00 00       	call   801c7d <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  8015f6:	e8 31 05 00 00       	call   801b2c <sys_get_uheap_strategy>
  8015fb:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801600:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801607:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  80160a:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801611:	00 00 80 
		__firstTimeFlag = 0;
  801614:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  80161b:	00 00 00 
	}
}
  80161e:	90                   	nop
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
  801624:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801627:	83 ec 04             	sub    $0x4,%esp
  80162a:	68 bc 2e 80 00       	push   $0x802ebc
  80162f:	6a 25                	push   $0x25
  801631:	68 ed 2e 80 00       	push   $0x802eed
  801636:	e8 30 0e 00 00       	call   80246b <_panic>

0080163b <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
  80163e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801641:	83 ec 04             	sub    $0x4,%esp
  801644:	68 fc 2e 80 00       	push   $0x802efc
  801649:	6a 2f                	push   $0x2f
  80164b:	68 ed 2e 80 00       	push   $0x802eed
  801650:	e8 16 0e 00 00       	call   80246b <_panic>

00801655 <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801655:	55                   	push   %ebp
  801656:	89 e5                	mov    %esp,%ebp
  801658:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  80165b:	e8 82 ff ff ff       	call   8015e2 <uheap_init>
	if (size == 0) return NULL ;
  801660:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801664:	75 07                	jne    80166d <malloc+0x18>
  801666:	b8 00 00 00 00       	mov    $0x0,%eax
  80166b:	eb 14                	jmp    801681 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  80166d:	83 ec 04             	sub    $0x4,%esp
  801670:	68 30 2f 80 00       	push   $0x802f30
  801675:	6a 43                	push   $0x43
  801677:	68 ed 2e 80 00       	push   $0x802eed
  80167c:	e8 ea 0d 00 00       	call   80246b <_panic>
}
  801681:	c9                   	leave  
  801682:	c3                   	ret    

00801683 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801683:	55                   	push   %ebp
  801684:	89 e5                	mov    %esp,%ebp
  801686:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801689:	83 ec 04             	sub    $0x4,%esp
  80168c:	68 58 2f 80 00       	push   $0x802f58
  801691:	6a 4e                	push   $0x4e
  801693:	68 ed 2e 80 00       	push   $0x802eed
  801698:	e8 ce 0d 00 00       	call   80246b <_panic>

0080169d <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
  8016a0:	83 ec 18             	sub    $0x18,%esp
  8016a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a6:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8016a9:	e8 34 ff ff ff       	call   8015e2 <uheap_init>
	if (size == 0) return NULL ;
  8016ae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016b2:	75 07                	jne    8016bb <smalloc+0x1e>
  8016b4:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b9:	eb 14                	jmp    8016cf <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  8016bb:	83 ec 04             	sub    $0x4,%esp
  8016be:	68 7c 2f 80 00       	push   $0x802f7c
  8016c3:	6a 5f                	push   $0x5f
  8016c5:	68 ed 2e 80 00       	push   $0x802eed
  8016ca:	e8 9c 0d 00 00       	call   80246b <_panic>
}
  8016cf:	c9                   	leave  
  8016d0:	c3                   	ret    

008016d1 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8016d1:	55                   	push   %ebp
  8016d2:	89 e5                	mov    %esp,%ebp
  8016d4:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8016d7:	e8 06 ff ff ff       	call   8015e2 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  8016dc:	83 ec 04             	sub    $0x4,%esp
  8016df:	68 a4 2f 80 00       	push   $0x802fa4
  8016e4:	6a 6f                	push   $0x6f
  8016e6:	68 ed 2e 80 00       	push   $0x802eed
  8016eb:	e8 7b 0d 00 00       	call   80246b <_panic>

008016f0 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
  8016f3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  8016f6:	83 ec 04             	sub    $0x4,%esp
  8016f9:	68 c8 2f 80 00       	push   $0x802fc8
  8016fe:	6a 7e                	push   $0x7e
  801700:	68 ed 2e 80 00       	push   $0x802eed
  801705:	e8 61 0d 00 00       	call   80246b <_panic>

0080170a <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
  80170d:	57                   	push   %edi
  80170e:	56                   	push   %esi
  80170f:	53                   	push   %ebx
  801710:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801713:	8b 45 08             	mov    0x8(%ebp),%eax
  801716:	8b 55 0c             	mov    0xc(%ebp),%edx
  801719:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80171c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80171f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801722:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801725:	cd 30                	int    $0x30
  801727:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80172a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80172d:	83 c4 10             	add    $0x10,%esp
  801730:	5b                   	pop    %ebx
  801731:	5e                   	pop    %esi
  801732:	5f                   	pop    %edi
  801733:	5d                   	pop    %ebp
  801734:	c3                   	ret    

00801735 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801735:	55                   	push   %ebp
  801736:	89 e5                	mov    %esp,%ebp
  801738:	83 ec 04             	sub    $0x4,%esp
  80173b:	8b 45 10             	mov    0x10(%ebp),%eax
  80173e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801741:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801744:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801748:	8b 45 08             	mov    0x8(%ebp),%eax
  80174b:	6a 00                	push   $0x0
  80174d:	51                   	push   %ecx
  80174e:	52                   	push   %edx
  80174f:	ff 75 0c             	pushl  0xc(%ebp)
  801752:	50                   	push   %eax
  801753:	6a 00                	push   $0x0
  801755:	e8 b0 ff ff ff       	call   80170a <syscall>
  80175a:	83 c4 18             	add    $0x18,%esp
}
  80175d:	90                   	nop
  80175e:	c9                   	leave  
  80175f:	c3                   	ret    

00801760 <sys_cgetc>:

int
sys_cgetc(void)
{
  801760:	55                   	push   %ebp
  801761:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 02                	push   $0x2
  80176f:	e8 96 ff ff ff       	call   80170a <syscall>
  801774:	83 c4 18             	add    $0x18,%esp
}
  801777:	c9                   	leave  
  801778:	c3                   	ret    

00801779 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801779:	55                   	push   %ebp
  80177a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 03                	push   $0x3
  801788:	e8 7d ff ff ff       	call   80170a <syscall>
  80178d:	83 c4 18             	add    $0x18,%esp
}
  801790:	90                   	nop
  801791:	c9                   	leave  
  801792:	c3                   	ret    

00801793 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 04                	push   $0x4
  8017a2:	e8 63 ff ff ff       	call   80170a <syscall>
  8017a7:	83 c4 18             	add    $0x18,%esp
}
  8017aa:	90                   	nop
  8017ab:	c9                   	leave  
  8017ac:	c3                   	ret    

008017ad <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  8017ad:	55                   	push   %ebp
  8017ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	52                   	push   %edx
  8017bd:	50                   	push   %eax
  8017be:	6a 08                	push   $0x8
  8017c0:	e8 45 ff ff ff       	call   80170a <syscall>
  8017c5:	83 c4 18             	add    $0x18,%esp
}
  8017c8:	c9                   	leave  
  8017c9:	c3                   	ret    

008017ca <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017ca:	55                   	push   %ebp
  8017cb:	89 e5                	mov    %esp,%ebp
  8017cd:	56                   	push   %esi
  8017ce:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017cf:	8b 75 18             	mov    0x18(%ebp),%esi
  8017d2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017db:	8b 45 08             	mov    0x8(%ebp),%eax
  8017de:	56                   	push   %esi
  8017df:	53                   	push   %ebx
  8017e0:	51                   	push   %ecx
  8017e1:	52                   	push   %edx
  8017e2:	50                   	push   %eax
  8017e3:	6a 09                	push   $0x9
  8017e5:	e8 20 ff ff ff       	call   80170a <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017f0:	5b                   	pop    %ebx
  8017f1:	5e                   	pop    %esi
  8017f2:	5d                   	pop    %ebp
  8017f3:	c3                   	ret    

008017f4 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	ff 75 08             	pushl  0x8(%ebp)
  801802:	6a 0a                	push   $0xa
  801804:	e8 01 ff ff ff       	call   80170a <syscall>
  801809:	83 c4 18             	add    $0x18,%esp
}
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	ff 75 0c             	pushl  0xc(%ebp)
  80181a:	ff 75 08             	pushl  0x8(%ebp)
  80181d:	6a 0b                	push   $0xb
  80181f:	e8 e6 fe ff ff       	call   80170a <syscall>
  801824:	83 c4 18             	add    $0x18,%esp
}
  801827:	c9                   	leave  
  801828:	c3                   	ret    

00801829 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 0c                	push   $0xc
  801838:	e8 cd fe ff ff       	call   80170a <syscall>
  80183d:	83 c4 18             	add    $0x18,%esp
}
  801840:	c9                   	leave  
  801841:	c3                   	ret    

00801842 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801842:	55                   	push   %ebp
  801843:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 0d                	push   $0xd
  801851:	e8 b4 fe ff ff       	call   80170a <syscall>
  801856:	83 c4 18             	add    $0x18,%esp
}
  801859:	c9                   	leave  
  80185a:	c3                   	ret    

0080185b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80185b:	55                   	push   %ebp
  80185c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 0e                	push   $0xe
  80186a:	e8 9b fe ff ff       	call   80170a <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
}
  801872:	c9                   	leave  
  801873:	c3                   	ret    

00801874 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801874:	55                   	push   %ebp
  801875:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 0f                	push   $0xf
  801883:	e8 82 fe ff ff       	call   80170a <syscall>
  801888:	83 c4 18             	add    $0x18,%esp
}
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	ff 75 08             	pushl  0x8(%ebp)
  80189b:	6a 10                	push   $0x10
  80189d:	e8 68 fe ff ff       	call   80170a <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 11                	push   $0x11
  8018b6:	e8 4f fe ff ff       	call   80170a <syscall>
  8018bb:	83 c4 18             	add    $0x18,%esp
}
  8018be:	90                   	nop
  8018bf:	c9                   	leave  
  8018c0:	c3                   	ret    

008018c1 <sys_cputc>:

void
sys_cputc(const char c)
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
  8018c4:	83 ec 04             	sub    $0x4,%esp
  8018c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ca:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8018cd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	50                   	push   %eax
  8018da:	6a 01                	push   $0x1
  8018dc:	e8 29 fe ff ff       	call   80170a <syscall>
  8018e1:	83 c4 18             	add    $0x18,%esp
}
  8018e4:	90                   	nop
  8018e5:	c9                   	leave  
  8018e6:	c3                   	ret    

008018e7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8018e7:	55                   	push   %ebp
  8018e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 14                	push   $0x14
  8018f6:	e8 0f fe ff ff       	call   80170a <syscall>
  8018fb:	83 c4 18             	add    $0x18,%esp
}
  8018fe:	90                   	nop
  8018ff:	c9                   	leave  
  801900:	c3                   	ret    

00801901 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801901:	55                   	push   %ebp
  801902:	89 e5                	mov    %esp,%ebp
  801904:	83 ec 04             	sub    $0x4,%esp
  801907:	8b 45 10             	mov    0x10(%ebp),%eax
  80190a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  80190d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801910:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801914:	8b 45 08             	mov    0x8(%ebp),%eax
  801917:	6a 00                	push   $0x0
  801919:	51                   	push   %ecx
  80191a:	52                   	push   %edx
  80191b:	ff 75 0c             	pushl  0xc(%ebp)
  80191e:	50                   	push   %eax
  80191f:	6a 15                	push   $0x15
  801921:	e8 e4 fd ff ff       	call   80170a <syscall>
  801926:	83 c4 18             	add    $0x18,%esp
}
  801929:	c9                   	leave  
  80192a:	c3                   	ret    

0080192b <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  80192b:	55                   	push   %ebp
  80192c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  80192e:	8b 55 10             	mov    0x10(%ebp),%edx
  801931:	8b 45 0c             	mov    0xc(%ebp),%eax
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	52                   	push   %edx
  801939:	50                   	push   %eax
  80193a:	ff 75 08             	pushl  0x8(%ebp)
  80193d:	6a 16                	push   $0x16
  80193f:	e8 c6 fd ff ff       	call   80170a <syscall>
  801944:	83 c4 18             	add    $0x18,%esp
}
  801947:	c9                   	leave  
  801948:	c3                   	ret    

00801949 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801949:	55                   	push   %ebp
  80194a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  80194c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80194f:	8b 45 08             	mov    0x8(%ebp),%eax
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	52                   	push   %edx
  801959:	50                   	push   %eax
  80195a:	6a 17                	push   $0x17
  80195c:	e8 a9 fd ff ff       	call   80170a <syscall>
  801961:	83 c4 18             	add    $0x18,%esp
}
  801964:	c9                   	leave  
  801965:	c3                   	ret    

00801966 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801966:	55                   	push   %ebp
  801967:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801969:	8b 55 0c             	mov    0xc(%ebp),%edx
  80196c:	8b 45 08             	mov    0x8(%ebp),%eax
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	52                   	push   %edx
  801976:	50                   	push   %eax
  801977:	6a 18                	push   $0x18
  801979:	e8 8c fd ff ff       	call   80170a <syscall>
  80197e:	83 c4 18             	add    $0x18,%esp
}
  801981:	c9                   	leave  
  801982:	c3                   	ret    

00801983 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801983:	55                   	push   %ebp
  801984:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801986:	8b 45 08             	mov    0x8(%ebp),%eax
  801989:	6a 00                	push   $0x0
  80198b:	ff 75 14             	pushl  0x14(%ebp)
  80198e:	ff 75 10             	pushl  0x10(%ebp)
  801991:	ff 75 0c             	pushl  0xc(%ebp)
  801994:	50                   	push   %eax
  801995:	6a 19                	push   $0x19
  801997:	e8 6e fd ff ff       	call   80170a <syscall>
  80199c:	83 c4 18             	add    $0x18,%esp
}
  80199f:	c9                   	leave  
  8019a0:	c3                   	ret    

008019a1 <sys_run_env>:

void sys_run_env(int32 envId)
{
  8019a1:	55                   	push   %ebp
  8019a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	50                   	push   %eax
  8019b0:	6a 1a                	push   $0x1a
  8019b2:	e8 53 fd ff ff       	call   80170a <syscall>
  8019b7:	83 c4 18             	add    $0x18,%esp
}
  8019ba:	90                   	nop
  8019bb:	c9                   	leave  
  8019bc:	c3                   	ret    

008019bd <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  8019bd:	55                   	push   %ebp
  8019be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  8019c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	50                   	push   %eax
  8019cc:	6a 1b                	push   $0x1b
  8019ce:	e8 37 fd ff ff       	call   80170a <syscall>
  8019d3:	83 c4 18             	add    $0x18,%esp
}
  8019d6:	c9                   	leave  
  8019d7:	c3                   	ret    

008019d8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8019d8:	55                   	push   %ebp
  8019d9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 05                	push   $0x5
  8019e7:	e8 1e fd ff ff       	call   80170a <syscall>
  8019ec:	83 c4 18             	add    $0x18,%esp
}
  8019ef:	c9                   	leave  
  8019f0:	c3                   	ret    

008019f1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019f1:	55                   	push   %ebp
  8019f2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 06                	push   $0x6
  801a00:	e8 05 fd ff ff       	call   80170a <syscall>
  801a05:	83 c4 18             	add    $0x18,%esp
}
  801a08:	c9                   	leave  
  801a09:	c3                   	ret    

00801a0a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801a0a:	55                   	push   %ebp
  801a0b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 07                	push   $0x7
  801a19:	e8 ec fc ff ff       	call   80170a <syscall>
  801a1e:	83 c4 18             	add    $0x18,%esp
}
  801a21:	c9                   	leave  
  801a22:	c3                   	ret    

00801a23 <sys_exit_env>:


void sys_exit_env(void)
{
  801a23:	55                   	push   %ebp
  801a24:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801a26:	6a 00                	push   $0x0
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 1c                	push   $0x1c
  801a32:	e8 d3 fc ff ff       	call   80170a <syscall>
  801a37:	83 c4 18             	add    $0x18,%esp
}
  801a3a:	90                   	nop
  801a3b:	c9                   	leave  
  801a3c:	c3                   	ret    

00801a3d <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a3d:	55                   	push   %ebp
  801a3e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	ff 75 10             	pushl  0x10(%ebp)
  801a47:	ff 75 0c             	pushl  0xc(%ebp)
  801a4a:	ff 75 08             	pushl  0x8(%ebp)
  801a4d:	6a 13                	push   $0x13
  801a4f:	e8 b6 fc ff ff       	call   80170a <syscall>
  801a54:	83 c4 18             	add    $0x18,%esp
	return ;
  801a57:	90                   	nop
}
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <sys_rcr2>:
uint32 sys_rcr2()
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 1e                	push   $0x1e
  801a69:	e8 9c fc ff ff       	call   80170a <syscall>
  801a6e:	83 c4 18             	add    $0x18,%esp
}
  801a71:	c9                   	leave  
  801a72:	c3                   	ret    

00801a73 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801a73:	55                   	push   %ebp
  801a74:	89 e5                	mov    %esp,%ebp
  801a76:	83 ec 04             	sub    $0x4,%esp
  801a79:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a7f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	50                   	push   %eax
  801a8c:	6a 1f                	push   $0x1f
  801a8e:	e8 77 fc ff ff       	call   80170a <syscall>
  801a93:	83 c4 18             	add    $0x18,%esp
	return ;
  801a96:	90                   	nop
}
  801a97:	c9                   	leave  
  801a98:	c3                   	ret    

00801a99 <rsttst>:
void rsttst()
{
  801a99:	55                   	push   %ebp
  801a9a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 21                	push   $0x21
  801aa8:	e8 5d fc ff ff       	call   80170a <syscall>
  801aad:	83 c4 18             	add    $0x18,%esp
	return ;
  801ab0:	90                   	nop
}
  801ab1:	c9                   	leave  
  801ab2:	c3                   	ret    

00801ab3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ab3:	55                   	push   %ebp
  801ab4:	89 e5                	mov    %esp,%ebp
  801ab6:	83 ec 04             	sub    $0x4,%esp
  801ab9:	8b 45 14             	mov    0x14(%ebp),%eax
  801abc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801abf:	8b 55 18             	mov    0x18(%ebp),%edx
  801ac2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ac6:	52                   	push   %edx
  801ac7:	50                   	push   %eax
  801ac8:	ff 75 10             	pushl  0x10(%ebp)
  801acb:	ff 75 0c             	pushl  0xc(%ebp)
  801ace:	ff 75 08             	pushl  0x8(%ebp)
  801ad1:	6a 20                	push   $0x20
  801ad3:	e8 32 fc ff ff       	call   80170a <syscall>
  801ad8:	83 c4 18             	add    $0x18,%esp
	return ;
  801adb:	90                   	nop
}
  801adc:	c9                   	leave  
  801add:	c3                   	ret    

00801ade <chktst>:
void chktst(uint32 n)
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	ff 75 08             	pushl  0x8(%ebp)
  801aec:	6a 22                	push   $0x22
  801aee:	e8 17 fc ff ff       	call   80170a <syscall>
  801af3:	83 c4 18             	add    $0x18,%esp
	return ;
  801af6:	90                   	nop
}
  801af7:	c9                   	leave  
  801af8:	c3                   	ret    

00801af9 <inctst>:

void inctst()
{
  801af9:	55                   	push   %ebp
  801afa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	6a 23                	push   $0x23
  801b08:	e8 fd fb ff ff       	call   80170a <syscall>
  801b0d:	83 c4 18             	add    $0x18,%esp
	return ;
  801b10:	90                   	nop
}
  801b11:	c9                   	leave  
  801b12:	c3                   	ret    

00801b13 <gettst>:
uint32 gettst()
{
  801b13:	55                   	push   %ebp
  801b14:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 24                	push   $0x24
  801b22:	e8 e3 fb ff ff       	call   80170a <syscall>
  801b27:	83 c4 18             	add    $0x18,%esp
}
  801b2a:	c9                   	leave  
  801b2b:	c3                   	ret    

00801b2c <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801b2c:	55                   	push   %ebp
  801b2d:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	6a 25                	push   $0x25
  801b3b:	e8 ca fb ff ff       	call   80170a <syscall>
  801b40:	83 c4 18             	add    $0x18,%esp
  801b43:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  801b48:	a1 48 40 80 00       	mov    0x804048,%eax
}
  801b4d:	c9                   	leave  
  801b4e:	c3                   	ret    

00801b4f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b4f:	55                   	push   %ebp
  801b50:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801b52:	8b 45 08             	mov    0x8(%ebp),%eax
  801b55:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	ff 75 08             	pushl  0x8(%ebp)
  801b65:	6a 26                	push   $0x26
  801b67:	e8 9e fb ff ff       	call   80170a <syscall>
  801b6c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b6f:	90                   	nop
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
  801b75:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b76:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b79:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b82:	6a 00                	push   $0x0
  801b84:	53                   	push   %ebx
  801b85:	51                   	push   %ecx
  801b86:	52                   	push   %edx
  801b87:	50                   	push   %eax
  801b88:	6a 27                	push   $0x27
  801b8a:	e8 7b fb ff ff       	call   80170a <syscall>
  801b8f:	83 c4 18             	add    $0x18,%esp
}
  801b92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b95:	c9                   	leave  
  801b96:	c3                   	ret    

00801b97 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b97:	55                   	push   %ebp
  801b98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	52                   	push   %edx
  801ba7:	50                   	push   %eax
  801ba8:	6a 28                	push   $0x28
  801baa:	e8 5b fb ff ff       	call   80170a <syscall>
  801baf:	83 c4 18             	add    $0x18,%esp
}
  801bb2:	c9                   	leave  
  801bb3:	c3                   	ret    

00801bb4 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801bb4:	55                   	push   %ebp
  801bb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801bb7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801bba:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc0:	6a 00                	push   $0x0
  801bc2:	51                   	push   %ecx
  801bc3:	ff 75 10             	pushl  0x10(%ebp)
  801bc6:	52                   	push   %edx
  801bc7:	50                   	push   %eax
  801bc8:	6a 29                	push   $0x29
  801bca:	e8 3b fb ff ff       	call   80170a <syscall>
  801bcf:	83 c4 18             	add    $0x18,%esp
}
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	ff 75 10             	pushl  0x10(%ebp)
  801bde:	ff 75 0c             	pushl  0xc(%ebp)
  801be1:	ff 75 08             	pushl  0x8(%ebp)
  801be4:	6a 12                	push   $0x12
  801be6:	e8 1f fb ff ff       	call   80170a <syscall>
  801beb:	83 c4 18             	add    $0x18,%esp
	return ;
  801bee:	90                   	nop
}
  801bef:	c9                   	leave  
  801bf0:	c3                   	ret    

00801bf1 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801bf1:	55                   	push   %ebp
  801bf2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801bf4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	52                   	push   %edx
  801c01:	50                   	push   %eax
  801c02:	6a 2a                	push   $0x2a
  801c04:	e8 01 fb ff ff       	call   80170a <syscall>
  801c09:	83 c4 18             	add    $0x18,%esp
	return;
  801c0c:	90                   	nop
}
  801c0d:	c9                   	leave  
  801c0e:	c3                   	ret    

00801c0f <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801c0f:	55                   	push   %ebp
  801c10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 2b                	push   $0x2b
  801c1e:	e8 e7 fa ff ff       	call   80170a <syscall>
  801c23:	83 c4 18             	add    $0x18,%esp
}
  801c26:	c9                   	leave  
  801c27:	c3                   	ret    

00801c28 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801c28:	55                   	push   %ebp
  801c29:	89 e5                	mov    %esp,%ebp
  801c2b:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801c2e:	83 ec 04             	sub    $0x4,%esp
  801c31:	68 ec 2f 80 00       	push   $0x802fec
  801c36:	68 0a 01 00 00       	push   $0x10a
  801c3b:	68 fc 2f 80 00       	push   $0x802ffc
  801c40:	e8 26 08 00 00       	call   80246b <_panic>

00801c45 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801c45:	55                   	push   %ebp
  801c46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	ff 75 0c             	pushl  0xc(%ebp)
  801c51:	ff 75 08             	pushl  0x8(%ebp)
  801c54:	6a 33                	push   $0x33
  801c56:	e8 af fa ff ff       	call   80170a <syscall>
  801c5b:	83 c4 18             	add    $0x18,%esp
	return;
  801c5e:	90                   	nop
}
  801c5f:	c9                   	leave  
  801c60:	c3                   	ret    

00801c61 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801c61:	55                   	push   %ebp
  801c62:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	ff 75 0c             	pushl  0xc(%ebp)
  801c6d:	ff 75 08             	pushl  0x8(%ebp)
  801c70:	6a 34                	push   $0x34
  801c72:	e8 93 fa ff ff       	call   80170a <syscall>
  801c77:	83 c4 18             	add    $0x18,%esp
	return ;
  801c7a:	90                   	nop
}
  801c7b:	c9                   	leave  
  801c7c:	c3                   	ret    

00801c7d <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  801c7d:	55                   	push   %ebp
  801c7e:	89 e5                	mov    %esp,%ebp
  801c80:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801c83:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801c8a:	eb 36                	jmp    801cc2 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801c8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c8f:	c1 e0 04             	shl    $0x4,%eax
  801c92:	05 60 40 80 00       	add    $0x804060,%eax
  801c97:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ca0:	c1 e0 04             	shl    $0x4,%eax
  801ca3:	05 64 40 80 00       	add    $0x804064,%eax
  801ca8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801cae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cb1:	c1 e0 04             	shl    $0x4,%eax
  801cb4:	05 6c 40 80 00       	add    $0x80406c,%eax
  801cb9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801cbf:	ff 45 fc             	incl   -0x4(%ebp)
  801cc2:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801cc6:	7e c4                	jle    801c8c <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801cc8:	90                   	nop
  801cc9:	c9                   	leave  
  801cca:	c3                   	ret    

00801ccb <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801ccb:	55                   	push   %ebp
  801ccc:	89 e5                	mov    %esp,%ebp
  801cce:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801cd1:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801cd8:	eb 24                	jmp    801cfe <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801cda:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cdd:	c1 e0 04             	shl    $0x4,%eax
  801ce0:	05 6c 40 80 00       	add    $0x80406c,%eax
  801ce5:	8b 00                	mov    (%eax),%eax
  801ce7:	83 ec 04             	sub    $0x4,%esp
  801cea:	50                   	push   %eax
  801ceb:	ff 75 f4             	pushl  -0xc(%ebp)
  801cee:	68 0c 30 80 00       	push   $0x80300c
  801cf3:	e8 fd e7 ff ff       	call   8004f5 <cprintf>
  801cf8:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801cfb:	ff 45 f4             	incl   -0xc(%ebp)
  801cfe:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801d02:	7e d6                	jle    801cda <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801d04:	90                   	nop
  801d05:	c9                   	leave  
  801d06:	c3                   	ret    

00801d07 <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801d07:	55                   	push   %ebp
  801d08:	89 e5                	mov    %esp,%ebp
  801d0a:	83 ec 10             	sub    $0x10,%esp
	uint32 meta = (uint32) va - META_DATA_SIZE;
  801d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d10:	83 e8 0a             	sub    $0xa,%eax
  801d13:	89 45 fc             	mov    %eax,-0x4(%ebp)
	struct BlockMetaData *cur = (struct BlockMetaData *)meta;
  801d16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d19:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 lvl = cur->level;
  801d1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d1f:	8a 00                	mov    (%eax),%al
  801d21:	0f b6 c0             	movzbl %al,%eax
  801d24:	89 45 f4             	mov    %eax,-0xc(%ebp)
	return BLOCK_SIZE(lvl);
  801d27:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d2a:	ba 01 00 00 00       	mov    $0x1,%edx
  801d2f:	88 c1                	mov    %al,%cl
  801d31:	d3 e2                	shl    %cl,%edx
  801d33:	89 d0                	mov    %edx,%eax

}
  801d35:	c9                   	leave  
  801d36:	c3                   	ret    

00801d37 <alloc_block>:
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801d37:	55                   	push   %ebp
  801d38:	89 e5                	mov    %esp,%ebp
  801d3a:	83 ec 48             	sub    $0x48,%esp
	if(requiredSize==0) return NULL;
  801d3d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801d41:	75 0a                	jne    801d4d <alloc_block+0x16>
  801d43:	b8 00 00 00 00       	mov    $0x0,%eax
  801d48:	e9 9e 04 00 00       	jmp    8021eb <alloc_block+0x4b4>
	uint32 realsize = requiredSize + META_DATA_SIZE;
  801d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d50:	83 c0 0a             	add    $0xa,%eax
  801d53:	89 45 e0             	mov    %eax,-0x20(%ebp)
	uint32 level;
	for(int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL;i++){
  801d56:	c7 45 f0 04 00 00 00 	movl   $0x4,-0x10(%ebp)
  801d5d:	eb 1e                	jmp    801d7d <alloc_block+0x46>
		if(BLOCK_SIZE(i)>=realsize){
  801d5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d62:	ba 01 00 00 00       	mov    $0x1,%edx
  801d67:	88 c1                	mov    %al,%cl
  801d69:	d3 e2                	shl    %cl,%edx
  801d6b:	89 d0                	mov    %edx,%eax
  801d6d:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801d70:	72 08                	jb     801d7a <alloc_block+0x43>
			level=i;
  801d72:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d75:	89 45 f4             	mov    %eax,-0xc(%ebp)
			break;
  801d78:	eb 09                	jmp    801d83 <alloc_block+0x4c>
void *alloc_block(uint32 requiredSize)
{
	if(requiredSize==0) return NULL;
	uint32 realsize = requiredSize + META_DATA_SIZE;
	uint32 level;
	for(int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL;i++){
  801d7a:	ff 45 f0             	incl   -0x10(%ebp)
  801d7d:	83 7d f0 0b          	cmpl   $0xb,-0x10(%ebp)
  801d81:	7e dc                	jle    801d5f <alloc_block+0x28>
			level=i;
			break;
		}
	}
	uint32 first_free_level;
	bool found = 0;
  801d83:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	for(int i =level;i<=BUDDY_UPPER_LEVEL;i++){
  801d8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d8d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801d90:	eb 23                	jmp    801db5 <alloc_block+0x7e>
		if(LIST_SIZE(&freeBlockLists[i])>0){
  801d92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d95:	c1 e0 04             	shl    $0x4,%eax
  801d98:	05 6c 40 80 00       	add    $0x80406c,%eax
  801d9d:	8b 00                	mov    (%eax),%eax
  801d9f:	85 c0                	test   %eax,%eax
  801da1:	74 0f                	je     801db2 <alloc_block+0x7b>
			found = 1;
  801da3:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			first_free_level=i;
  801daa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801dad:	89 45 ec             	mov    %eax,-0x14(%ebp)
			break;
  801db0:	eb 09                	jmp    801dbb <alloc_block+0x84>
			break;
		}
	}
	uint32 first_free_level;
	bool found = 0;
	for(int i =level;i<=BUDDY_UPPER_LEVEL;i++){
  801db2:	ff 45 e4             	incl   -0x1c(%ebp)
  801db5:	83 7d e4 0b          	cmpl   $0xb,-0x1c(%ebp)
  801db9:	7e d7                	jle    801d92 <alloc_block+0x5b>
			found = 1;
			first_free_level=i;
			break;
		}
	}
	if(found==0){
  801dbb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801dbf:	0f 85 4e 03 00 00    	jne    802113 <alloc_block+0x3dc>

		void *address = create_buddy_space();
  801dc5:	e8 57 f8 ff ff       	call   801621 <create_buddy_space>
  801dca:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if(address==NULL) return NULL;
  801dcd:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801dd1:	75 0a                	jne    801ddd <alloc_block+0xa6>
  801dd3:	b8 00 00 00 00       	mov    $0x0,%eax
  801dd8:	e9 0e 04 00 00       	jmp    8021eb <alloc_block+0x4b4>

		uint32 iaddress=(uint32) address;
  801ddd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801de0:	89 45 d8             	mov    %eax,-0x28(%ebp)
		struct BlockMetaData *cur= (struct BlockMetaData*) address;
  801de3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801de6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		uint32 bAddress = iaddress + BLOCK_SIZE(BUDDY_UPPER_LEVEL);
  801de9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801dec:	05 00 08 00 00       	add    $0x800,%eax
  801df1:	89 45 d0             	mov    %eax,-0x30(%ebp)
		struct BlockMetaData *buddy= (struct BlockMetaData*)bAddress;
  801df4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801df7:	89 45 cc             	mov    %eax,-0x34(%ebp)
		cur -> is_free=1;
  801dfa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801dfd:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		cur -> level = BUDDY_UPPER_LEVEL;
  801e01:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e04:	c6 00 0b             	movb   $0xb,(%eax)
		buddy -> is_free=1;
  801e07:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801e0a:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		buddy -> level= BUDDY_UPPER_LEVEL;
  801e0e:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801e11:	c6 00 0b             	movb   $0xb,(%eax)
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],buddy);
  801e14:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  801e18:	75 14                	jne    801e2e <alloc_block+0xf7>
  801e1a:	83 ec 04             	sub    $0x4,%esp
  801e1d:	68 1c 30 80 00       	push   $0x80301c
  801e22:	6a 5a                	push   $0x5a
  801e24:	68 3f 30 80 00       	push   $0x80303f
  801e29:	e8 3d 06 00 00       	call   80246b <_panic>
  801e2e:	8b 15 10 41 80 00    	mov    0x804110,%edx
  801e34:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801e37:	89 50 02             	mov    %edx,0x2(%eax)
  801e3a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801e3d:	8b 40 02             	mov    0x2(%eax),%eax
  801e40:	85 c0                	test   %eax,%eax
  801e42:	74 0d                	je     801e51 <alloc_block+0x11a>
  801e44:	a1 10 41 80 00       	mov    0x804110,%eax
  801e49:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801e4c:	89 50 06             	mov    %edx,0x6(%eax)
  801e4f:	eb 08                	jmp    801e59 <alloc_block+0x122>
  801e51:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801e54:	a3 14 41 80 00       	mov    %eax,0x804114
  801e59:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801e5c:	a3 10 41 80 00       	mov    %eax,0x804110
  801e61:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801e64:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  801e6b:	a1 1c 41 80 00       	mov    0x80411c,%eax
  801e70:	40                   	inc    %eax
  801e71:	a3 1c 41 80 00       	mov    %eax,0x80411c
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],cur);
  801e76:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  801e7a:	75 14                	jne    801e90 <alloc_block+0x159>
  801e7c:	83 ec 04             	sub    $0x4,%esp
  801e7f:	68 1c 30 80 00       	push   $0x80301c
  801e84:	6a 5b                	push   $0x5b
  801e86:	68 3f 30 80 00       	push   $0x80303f
  801e8b:	e8 db 05 00 00       	call   80246b <_panic>
  801e90:	8b 15 10 41 80 00    	mov    0x804110,%edx
  801e96:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e99:	89 50 02             	mov    %edx,0x2(%eax)
  801e9c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e9f:	8b 40 02             	mov    0x2(%eax),%eax
  801ea2:	85 c0                	test   %eax,%eax
  801ea4:	74 0d                	je     801eb3 <alloc_block+0x17c>
  801ea6:	a1 10 41 80 00       	mov    0x804110,%eax
  801eab:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801eae:	89 50 06             	mov    %edx,0x6(%eax)
  801eb1:	eb 08                	jmp    801ebb <alloc_block+0x184>
  801eb3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801eb6:	a3 14 41 80 00       	mov    %eax,0x804114
  801ebb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801ebe:	a3 10 41 80 00       	mov    %eax,0x804110
  801ec3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801ec6:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  801ecd:	a1 1c 41 80 00       	mov    0x80411c,%eax
  801ed2:	40                   	inc    %eax
  801ed3:	a3 1c 41 80 00       	mov    %eax,0x80411c
		first_free_level=BUDDY_UPPER_LEVEL;
  801ed8:	c7 45 ec 0b 00 00 00 	movl   $0xb,-0x14(%ebp)
	}


	while(first_free_level > level){
  801edf:	e9 2f 02 00 00       	jmp    802113 <alloc_block+0x3dc>
		struct BlockMetaData *cur = LIST_FIRST(&freeBlockLists[first_free_level]);
  801ee4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ee7:	c1 e0 04             	shl    $0x4,%eax
  801eea:	05 60 40 80 00       	add    $0x804060,%eax
  801eef:	8b 00                	mov    (%eax),%eax
  801ef1:	89 45 c8             	mov    %eax,-0x38(%ebp)
		LIST_REMOVE(&freeBlockLists[first_free_level],cur);
  801ef4:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
  801ef8:	75 14                	jne    801f0e <alloc_block+0x1d7>
  801efa:	83 ec 04             	sub    $0x4,%esp
  801efd:	68 57 30 80 00       	push   $0x803057
  801f02:	6a 62                	push   $0x62
  801f04:	68 3f 30 80 00       	push   $0x80303f
  801f09:	e8 5d 05 00 00       	call   80246b <_panic>
  801f0e:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f11:	8b 40 02             	mov    0x2(%eax),%eax
  801f14:	85 c0                	test   %eax,%eax
  801f16:	74 11                	je     801f29 <alloc_block+0x1f2>
  801f18:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f1b:	8b 40 02             	mov    0x2(%eax),%eax
  801f1e:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801f21:	8b 52 06             	mov    0x6(%edx),%edx
  801f24:	89 50 06             	mov    %edx,0x6(%eax)
  801f27:	eb 14                	jmp    801f3d <alloc_block+0x206>
  801f29:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f2c:	8b 40 06             	mov    0x6(%eax),%eax
  801f2f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801f32:	c1 e2 04             	shl    $0x4,%edx
  801f35:	81 c2 64 40 80 00    	add    $0x804064,%edx
  801f3b:	89 02                	mov    %eax,(%edx)
  801f3d:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f40:	8b 40 06             	mov    0x6(%eax),%eax
  801f43:	85 c0                	test   %eax,%eax
  801f45:	74 11                	je     801f58 <alloc_block+0x221>
  801f47:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f4a:	8b 40 06             	mov    0x6(%eax),%eax
  801f4d:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801f50:	8b 52 02             	mov    0x2(%edx),%edx
  801f53:	89 50 02             	mov    %edx,0x2(%eax)
  801f56:	eb 14                	jmp    801f6c <alloc_block+0x235>
  801f58:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f5b:	8b 40 02             	mov    0x2(%eax),%eax
  801f5e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801f61:	c1 e2 04             	shl    $0x4,%edx
  801f64:	81 c2 60 40 80 00    	add    $0x804060,%edx
  801f6a:	89 02                	mov    %eax,(%edx)
  801f6c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f6f:	c7 40 02 00 00 00 00 	movl   $0x0,0x2(%eax)
  801f76:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f79:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  801f80:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f83:	c1 e0 04             	shl    $0x4,%eax
  801f86:	05 6c 40 80 00       	add    $0x80406c,%eax
  801f8b:	8b 00                	mov    (%eax),%eax
  801f8d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801f90:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f93:	c1 e0 04             	shl    $0x4,%eax
  801f96:	05 6c 40 80 00       	add    $0x80406c,%eax
  801f9b:	89 10                	mov    %edx,(%eax)
		uint32 bAdress= (uint32)cur ^ BLOCK_SIZE((first_free_level-1));
  801f9d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fa0:	48                   	dec    %eax
  801fa1:	ba 01 00 00 00       	mov    $0x1,%edx
  801fa6:	88 c1                	mov    %al,%cl
  801fa8:	d3 e2                	shl    %cl,%edx
  801faa:	89 d0                	mov    %edx,%eax
  801fac:	89 c2                	mov    %eax,%edx
  801fae:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801fb1:	31 d0                	xor    %edx,%eax
  801fb3:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		struct BlockMetaData *buddy = (struct BlockMetaData*) bAdress;
  801fb6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  801fb9:	89 45 c0             	mov    %eax,-0x40(%ebp)
		buddy->level=first_free_level-1;
  801fbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fbf:	8d 50 ff             	lea    -0x1(%eax),%edx
  801fc2:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801fc5:	88 10                	mov    %dl,(%eax)
		buddy->is_free=1;
  801fc7:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801fca:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		cur->is_free=1;
  801fce:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801fd1:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		cur->level=first_free_level-1;
  801fd5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fd8:	8d 50 ff             	lea    -0x1(%eax),%edx
  801fdb:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801fde:	88 10                	mov    %dl,(%eax)
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],buddy);
  801fe0:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
  801fe4:	75 14                	jne    801ffa <alloc_block+0x2c3>
  801fe6:	83 ec 04             	sub    $0x4,%esp
  801fe9:	68 1c 30 80 00       	push   $0x80301c
  801fee:	6a 69                	push   $0x69
  801ff0:	68 3f 30 80 00       	push   $0x80303f
  801ff5:	e8 71 04 00 00       	call   80246b <_panic>
  801ffa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ffd:	48                   	dec    %eax
  801ffe:	c1 e0 04             	shl    $0x4,%eax
  802001:	05 60 40 80 00       	add    $0x804060,%eax
  802006:	8b 10                	mov    (%eax),%edx
  802008:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80200b:	89 50 02             	mov    %edx,0x2(%eax)
  80200e:	8b 45 c0             	mov    -0x40(%ebp),%eax
  802011:	8b 40 02             	mov    0x2(%eax),%eax
  802014:	85 c0                	test   %eax,%eax
  802016:	74 16                	je     80202e <alloc_block+0x2f7>
  802018:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80201b:	48                   	dec    %eax
  80201c:	c1 e0 04             	shl    $0x4,%eax
  80201f:	05 60 40 80 00       	add    $0x804060,%eax
  802024:	8b 00                	mov    (%eax),%eax
  802026:	8b 55 c0             	mov    -0x40(%ebp),%edx
  802029:	89 50 06             	mov    %edx,0x6(%eax)
  80202c:	eb 12                	jmp    802040 <alloc_block+0x309>
  80202e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802031:	48                   	dec    %eax
  802032:	c1 e0 04             	shl    $0x4,%eax
  802035:	8d 90 64 40 80 00    	lea    0x804064(%eax),%edx
  80203b:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80203e:	89 02                	mov    %eax,(%edx)
  802040:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802043:	48                   	dec    %eax
  802044:	c1 e0 04             	shl    $0x4,%eax
  802047:	8d 90 60 40 80 00    	lea    0x804060(%eax),%edx
  80204d:	8b 45 c0             	mov    -0x40(%ebp),%eax
  802050:	89 02                	mov    %eax,(%edx)
  802052:	8b 45 c0             	mov    -0x40(%ebp),%eax
  802055:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  80205c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80205f:	48                   	dec    %eax
  802060:	89 c2                	mov    %eax,%edx
  802062:	c1 e2 04             	shl    $0x4,%edx
  802065:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  80206b:	8b 12                	mov    (%edx),%edx
  80206d:	42                   	inc    %edx
  80206e:	c1 e0 04             	shl    $0x4,%eax
  802071:	05 6c 40 80 00       	add    $0x80406c,%eax
  802076:	89 10                	mov    %edx,(%eax)
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],cur);
  802078:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
  80207c:	75 14                	jne    802092 <alloc_block+0x35b>
  80207e:	83 ec 04             	sub    $0x4,%esp
  802081:	68 1c 30 80 00       	push   $0x80301c
  802086:	6a 6a                	push   $0x6a
  802088:	68 3f 30 80 00       	push   $0x80303f
  80208d:	e8 d9 03 00 00       	call   80246b <_panic>
  802092:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802095:	48                   	dec    %eax
  802096:	c1 e0 04             	shl    $0x4,%eax
  802099:	05 60 40 80 00       	add    $0x804060,%eax
  80209e:	8b 10                	mov    (%eax),%edx
  8020a0:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8020a3:	89 50 02             	mov    %edx,0x2(%eax)
  8020a6:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8020a9:	8b 40 02             	mov    0x2(%eax),%eax
  8020ac:	85 c0                	test   %eax,%eax
  8020ae:	74 16                	je     8020c6 <alloc_block+0x38f>
  8020b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8020b3:	48                   	dec    %eax
  8020b4:	c1 e0 04             	shl    $0x4,%eax
  8020b7:	05 60 40 80 00       	add    $0x804060,%eax
  8020bc:	8b 00                	mov    (%eax),%eax
  8020be:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8020c1:	89 50 06             	mov    %edx,0x6(%eax)
  8020c4:	eb 12                	jmp    8020d8 <alloc_block+0x3a1>
  8020c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8020c9:	48                   	dec    %eax
  8020ca:	c1 e0 04             	shl    $0x4,%eax
  8020cd:	8d 90 64 40 80 00    	lea    0x804064(%eax),%edx
  8020d3:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8020d6:	89 02                	mov    %eax,(%edx)
  8020d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8020db:	48                   	dec    %eax
  8020dc:	c1 e0 04             	shl    $0x4,%eax
  8020df:	8d 90 60 40 80 00    	lea    0x804060(%eax),%edx
  8020e5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8020e8:	89 02                	mov    %eax,(%edx)
  8020ea:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8020ed:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  8020f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8020f7:	48                   	dec    %eax
  8020f8:	89 c2                	mov    %eax,%edx
  8020fa:	c1 e2 04             	shl    $0x4,%edx
  8020fd:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  802103:	8b 12                	mov    (%edx),%edx
  802105:	42                   	inc    %edx
  802106:	c1 e0 04             	shl    $0x4,%eax
  802109:	05 6c 40 80 00       	add    $0x80406c,%eax
  80210e:	89 10                	mov    %edx,(%eax)
		first_free_level--;
  802110:	ff 4d ec             	decl   -0x14(%ebp)
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],cur);
		first_free_level=BUDDY_UPPER_LEVEL;
	}


	while(first_free_level > level){
  802113:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802116:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802119:	0f 87 c5 fd ff ff    	ja     801ee4 <alloc_block+0x1ad>
		cur->level=first_free_level-1;
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],buddy);
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],cur);
		first_free_level--;
	}
	struct BlockMetaData *ret = LIST_FIRST(&freeBlockLists[level]);
  80211f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802122:	c1 e0 04             	shl    $0x4,%eax
  802125:	05 60 40 80 00       	add    $0x804060,%eax
  80212a:	8b 00                	mov    (%eax),%eax
  80212c:	89 45 bc             	mov    %eax,-0x44(%ebp)
	LIST_REMOVE(&freeBlockLists[level],ret);
  80212f:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
  802133:	75 14                	jne    802149 <alloc_block+0x412>
  802135:	83 ec 04             	sub    $0x4,%esp
  802138:	68 57 30 80 00       	push   $0x803057
  80213d:	6a 6e                	push   $0x6e
  80213f:	68 3f 30 80 00       	push   $0x80303f
  802144:	e8 22 03 00 00       	call   80246b <_panic>
  802149:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80214c:	8b 40 02             	mov    0x2(%eax),%eax
  80214f:	85 c0                	test   %eax,%eax
  802151:	74 11                	je     802164 <alloc_block+0x42d>
  802153:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802156:	8b 40 02             	mov    0x2(%eax),%eax
  802159:	8b 55 bc             	mov    -0x44(%ebp),%edx
  80215c:	8b 52 06             	mov    0x6(%edx),%edx
  80215f:	89 50 06             	mov    %edx,0x6(%eax)
  802162:	eb 14                	jmp    802178 <alloc_block+0x441>
  802164:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802167:	8b 40 06             	mov    0x6(%eax),%eax
  80216a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80216d:	c1 e2 04             	shl    $0x4,%edx
  802170:	81 c2 64 40 80 00    	add    $0x804064,%edx
  802176:	89 02                	mov    %eax,(%edx)
  802178:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80217b:	8b 40 06             	mov    0x6(%eax),%eax
  80217e:	85 c0                	test   %eax,%eax
  802180:	74 11                	je     802193 <alloc_block+0x45c>
  802182:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802185:	8b 40 06             	mov    0x6(%eax),%eax
  802188:	8b 55 bc             	mov    -0x44(%ebp),%edx
  80218b:	8b 52 02             	mov    0x2(%edx),%edx
  80218e:	89 50 02             	mov    %edx,0x2(%eax)
  802191:	eb 14                	jmp    8021a7 <alloc_block+0x470>
  802193:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802196:	8b 40 02             	mov    0x2(%eax),%eax
  802199:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80219c:	c1 e2 04             	shl    $0x4,%edx
  80219f:	81 c2 60 40 80 00    	add    $0x804060,%edx
  8021a5:	89 02                	mov    %eax,(%edx)
  8021a7:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8021aa:	c7 40 02 00 00 00 00 	movl   $0x0,0x2(%eax)
  8021b1:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8021b4:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  8021bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8021be:	c1 e0 04             	shl    $0x4,%eax
  8021c1:	05 6c 40 80 00       	add    $0x80406c,%eax
  8021c6:	8b 00                	mov    (%eax),%eax
  8021c8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8021cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8021ce:	c1 e0 04             	shl    $0x4,%eax
  8021d1:	05 6c 40 80 00       	add    $0x80406c,%eax
  8021d6:	89 10                	mov    %edx,(%eax)
	ret -> is_free=0;
  8021d8:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8021db:	c6 40 01 00          	movb   $0x0,0x1(%eax)
	void *ret_adress= (void *)((uint32) ret+META_DATA_SIZE);
  8021df:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8021e2:	83 c0 0a             	add    $0xa,%eax
  8021e5:	89 45 b8             	mov    %eax,-0x48(%ebp)
	return ret_adress;
  8021e8:	8b 45 b8             	mov    -0x48(%ebp),%eax
}
  8021eb:	c9                   	leave  
  8021ec:	c3                   	ret    

008021ed <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  8021ed:	55                   	push   %ebp
  8021ee:	89 e5                	mov    %esp,%ebp
  8021f0:	83 ec 28             	sub    $0x28,%esp
	uint32 curAddress = (uint32) va - META_DATA_SIZE;
  8021f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f6:	83 e8 0a             	sub    $0xa,%eax
  8021f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct BlockMetaData *cur = (struct BlockMetaData *)curAddress;
  8021fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8021ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cur->is_free = 1;
  802202:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802205:	c6 40 01 01          	movb   $0x1,0x1(%eax)

	while(cur->level <= BUDDY_UPPER_LEVEL){
  802209:	e9 1a 01 00 00       	jmp    802328 <free_block+0x13b>
		void *tva = (void *)(curAddress + META_DATA_SIZE);
  80220e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802211:	83 c0 0a             	add    $0xa,%eax
  802214:	89 45 ec             	mov    %eax,-0x14(%ebp)
		uint32 buddyAddress = curAddress ^ get_block_size(tva);
  802217:	ff 75 ec             	pushl  -0x14(%ebp)
  80221a:	e8 e8 fa ff ff       	call   801d07 <get_block_size>
  80221f:	83 c4 04             	add    $0x4,%esp
  802222:	33 45 f4             	xor    -0xc(%ebp),%eax
  802225:	89 45 e8             	mov    %eax,-0x18(%ebp)
		struct BlockMetaData *buddy = (struct BlockMetaData *)buddyAddress;
  802228:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80222b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if(buddy->is_free == 1 && buddy->level == cur->level){
  80222e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802231:	8a 40 01             	mov    0x1(%eax),%al
  802234:	3c 01                	cmp    $0x1,%al
  802236:	0f 85 f9 00 00 00    	jne    802335 <free_block+0x148>
  80223c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80223f:	8a 10                	mov    (%eax),%dl
  802241:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802244:	8a 00                	mov    (%eax),%al
  802246:	38 c2                	cmp    %al,%dl
  802248:	0f 85 e7 00 00 00    	jne    802335 <free_block+0x148>
			if(buddyAddress<curAddress) curAddress = buddyAddress;
  80224e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802251:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802254:	73 06                	jae    80225c <free_block+0x6f>
  802256:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802259:	89 45 f4             	mov    %eax,-0xc(%ebp)
			LIST_REMOVE(&freeBlockLists[buddy->level], buddy);
  80225c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  802260:	75 17                	jne    802279 <free_block+0x8c>
  802262:	83 ec 04             	sub    $0x4,%esp
  802265:	68 57 30 80 00       	push   $0x803057
  80226a:	68 83 00 00 00       	push   $0x83
  80226f:	68 3f 30 80 00       	push   $0x80303f
  802274:	e8 f2 01 00 00       	call   80246b <_panic>
  802279:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80227c:	8b 40 02             	mov    0x2(%eax),%eax
  80227f:	85 c0                	test   %eax,%eax
  802281:	74 11                	je     802294 <free_block+0xa7>
  802283:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802286:	8b 40 02             	mov    0x2(%eax),%eax
  802289:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80228c:	8b 52 06             	mov    0x6(%edx),%edx
  80228f:	89 50 06             	mov    %edx,0x6(%eax)
  802292:	eb 19                	jmp    8022ad <free_block+0xc0>
  802294:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802297:	8a 00                	mov    (%eax),%al
  802299:	0f b6 d0             	movzbl %al,%edx
  80229c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80229f:	8b 40 06             	mov    0x6(%eax),%eax
  8022a2:	c1 e2 04             	shl    $0x4,%edx
  8022a5:	81 c2 64 40 80 00    	add    $0x804064,%edx
  8022ab:	89 02                	mov    %eax,(%edx)
  8022ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8022b0:	8b 40 06             	mov    0x6(%eax),%eax
  8022b3:	85 c0                	test   %eax,%eax
  8022b5:	74 11                	je     8022c8 <free_block+0xdb>
  8022b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8022ba:	8b 40 06             	mov    0x6(%eax),%eax
  8022bd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8022c0:	8b 52 02             	mov    0x2(%edx),%edx
  8022c3:	89 50 02             	mov    %edx,0x2(%eax)
  8022c6:	eb 19                	jmp    8022e1 <free_block+0xf4>
  8022c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8022cb:	8a 00                	mov    (%eax),%al
  8022cd:	0f b6 d0             	movzbl %al,%edx
  8022d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8022d3:	8b 40 02             	mov    0x2(%eax),%eax
  8022d6:	c1 e2 04             	shl    $0x4,%edx
  8022d9:	81 c2 60 40 80 00    	add    $0x804060,%edx
  8022df:	89 02                	mov    %eax,(%edx)
  8022e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8022e4:	c7 40 02 00 00 00 00 	movl   $0x0,0x2(%eax)
  8022eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8022ee:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  8022f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8022f8:	8a 00                	mov    (%eax),%al
  8022fa:	0f b6 c0             	movzbl %al,%eax
  8022fd:	89 c2                	mov    %eax,%edx
  8022ff:	c1 e2 04             	shl    $0x4,%edx
  802302:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  802308:	8b 12                	mov    (%edx),%edx
  80230a:	4a                   	dec    %edx
  80230b:	c1 e0 04             	shl    $0x4,%eax
  80230e:	05 6c 40 80 00       	add    $0x80406c,%eax
  802313:	89 10                	mov    %edx,(%eax)
			cur = (struct BlockMetaData *)curAddress;
  802315:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802318:	89 45 f0             	mov    %eax,-0x10(%ebp)
			cur->level = buddy->level+1;
  80231b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80231e:	8a 00                	mov    (%eax),%al
  802320:	8d 50 01             	lea    0x1(%eax),%edx
  802323:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802326:	88 10                	mov    %dl,(%eax)
{
	uint32 curAddress = (uint32) va - META_DATA_SIZE;
	struct BlockMetaData *cur = (struct BlockMetaData *)curAddress;
	cur->is_free = 1;

	while(cur->level <= BUDDY_UPPER_LEVEL){
  802328:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80232b:	8a 00                	mov    (%eax),%al
  80232d:	3c 0b                	cmp    $0xb,%al
  80232f:	0f 86 d9 fe ff ff    	jbe    80220e <free_block+0x21>
			cur = (struct BlockMetaData *)curAddress;
			cur->level = buddy->level+1;
		}
		else break;
	}
	if(cur->level > BUDDY_UPPER_LEVEL){
  802335:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802338:	8a 00                	mov    (%eax),%al
  80233a:	3c 0b                	cmp    $0xb,%al
  80233c:	76 1c                	jbe    80235a <free_block+0x16d>
		void *tva = (void *)(curAddress + META_DATA_SIZE);
  80233e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802341:	83 c0 0a             	add    $0xa,%eax
  802344:	89 45 e0             	mov    %eax,-0x20(%ebp)
		delete_buddy_space(tva);
  802347:	83 ec 0c             	sub    $0xc,%esp
  80234a:	ff 75 e0             	pushl  -0x20(%ebp)
  80234d:	e8 e9 f2 ff ff       	call   80163b <delete_buddy_space>
  802352:	83 c4 10             	add    $0x10,%esp
	}
	else LIST_INSERT_HEAD(&freeBlockLists[cur->level], cur);
}
  802355:	e9 af 00 00 00       	jmp    802409 <free_block+0x21c>
	}
	if(cur->level > BUDDY_UPPER_LEVEL){
		void *tva = (void *)(curAddress + META_DATA_SIZE);
		delete_buddy_space(tva);
	}
	else LIST_INSERT_HEAD(&freeBlockLists[cur->level], cur);
  80235a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80235e:	75 17                	jne    802377 <free_block+0x18a>
  802360:	83 ec 04             	sub    $0x4,%esp
  802363:	68 1c 30 80 00       	push   $0x80301c
  802368:	68 8d 00 00 00       	push   $0x8d
  80236d:	68 3f 30 80 00       	push   $0x80303f
  802372:	e8 f4 00 00 00       	call   80246b <_panic>
  802377:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80237a:	8a 00                	mov    (%eax),%al
  80237c:	0f b6 c0             	movzbl %al,%eax
  80237f:	c1 e0 04             	shl    $0x4,%eax
  802382:	05 60 40 80 00       	add    $0x804060,%eax
  802387:	8b 10                	mov    (%eax),%edx
  802389:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80238c:	89 50 02             	mov    %edx,0x2(%eax)
  80238f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802392:	8b 40 02             	mov    0x2(%eax),%eax
  802395:	85 c0                	test   %eax,%eax
  802397:	74 1a                	je     8023b3 <free_block+0x1c6>
  802399:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80239c:	8a 00                	mov    (%eax),%al
  80239e:	0f b6 c0             	movzbl %al,%eax
  8023a1:	c1 e0 04             	shl    $0x4,%eax
  8023a4:	05 60 40 80 00       	add    $0x804060,%eax
  8023a9:	8b 00                	mov    (%eax),%eax
  8023ab:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8023ae:	89 50 06             	mov    %edx,0x6(%eax)
  8023b1:	eb 16                	jmp    8023c9 <free_block+0x1dc>
  8023b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8023b6:	8a 00                	mov    (%eax),%al
  8023b8:	0f b6 c0             	movzbl %al,%eax
  8023bb:	c1 e0 04             	shl    $0x4,%eax
  8023be:	8d 90 64 40 80 00    	lea    0x804064(%eax),%edx
  8023c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8023c7:	89 02                	mov    %eax,(%edx)
  8023c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8023cc:	8a 00                	mov    (%eax),%al
  8023ce:	0f b6 c0             	movzbl %al,%eax
  8023d1:	c1 e0 04             	shl    $0x4,%eax
  8023d4:	8d 90 60 40 80 00    	lea    0x804060(%eax),%edx
  8023da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8023dd:	89 02                	mov    %eax,(%edx)
  8023df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8023e2:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  8023e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8023ec:	8a 00                	mov    (%eax),%al
  8023ee:	0f b6 c0             	movzbl %al,%eax
  8023f1:	89 c2                	mov    %eax,%edx
  8023f3:	c1 e2 04             	shl    $0x4,%edx
  8023f6:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  8023fc:	8b 12                	mov    (%edx),%edx
  8023fe:	42                   	inc    %edx
  8023ff:	c1 e0 04             	shl    $0x4,%eax
  802402:	05 6c 40 80 00       	add    $0x80406c,%eax
  802407:	89 10                	mov    %edx,(%eax)
}
  802409:	90                   	nop
  80240a:	c9                   	leave  
  80240b:	c3                   	ret    

0080240c <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  80240c:	55                   	push   %ebp
  80240d:	89 e5                	mov    %esp,%ebp
  80240f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  802412:	83 ec 04             	sub    $0x4,%esp
  802415:	68 78 30 80 00       	push   $0x803078
  80241a:	68 9c 00 00 00       	push   $0x9c
  80241f:	68 3f 30 80 00       	push   $0x80303f
  802424:	e8 42 00 00 00       	call   80246b <_panic>

00802429 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  802429:	55                   	push   %ebp
  80242a:	89 e5                	mov    %esp,%ebp
  80242c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80242f:	8b 45 08             	mov    0x8(%ebp),%eax
  802432:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  802435:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  802439:	83 ec 0c             	sub    $0xc,%esp
  80243c:	50                   	push   %eax
  80243d:	e8 7f f4 ff ff       	call   8018c1 <sys_cputc>
  802442:	83 c4 10             	add    $0x10,%esp
}
  802445:	90                   	nop
  802446:	c9                   	leave  
  802447:	c3                   	ret    

00802448 <getchar>:


int
getchar(void)
{
  802448:	55                   	push   %ebp
  802449:	89 e5                	mov    %esp,%ebp
  80244b:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  80244e:	e8 0d f3 ff ff       	call   801760 <sys_cgetc>
  802453:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802456:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80245a:	74 f2                	je     80244e <getchar+0x6>
	return c;
  80245c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80245f:	c9                   	leave  
  802460:	c3                   	ret    

00802461 <iscons>:

int iscons(int fdnum)
{
  802461:	55                   	push   %ebp
  802462:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  802464:	b8 01 00 00 00       	mov    $0x1,%eax
}
  802469:	5d                   	pop    %ebp
  80246a:	c3                   	ret    

0080246b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80246b:	55                   	push   %ebp
  80246c:	89 e5                	mov    %esp,%ebp
  80246e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  802471:	8d 45 10             	lea    0x10(%ebp),%eax
  802474:	83 c0 04             	add    $0x4,%eax
  802477:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80247a:	a1 2c 41 80 00       	mov    0x80412c,%eax
  80247f:	85 c0                	test   %eax,%eax
  802481:	74 16                	je     802499 <_panic+0x2e>
		cprintf("%s: ", argv0);
  802483:	a1 2c 41 80 00       	mov    0x80412c,%eax
  802488:	83 ec 08             	sub    $0x8,%esp
  80248b:	50                   	push   %eax
  80248c:	68 9c 30 80 00       	push   $0x80309c
  802491:	e8 5f e0 ff ff       	call   8004f5 <cprintf>
  802496:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  802499:	a1 04 40 80 00       	mov    0x804004,%eax
  80249e:	83 ec 0c             	sub    $0xc,%esp
  8024a1:	ff 75 0c             	pushl  0xc(%ebp)
  8024a4:	ff 75 08             	pushl  0x8(%ebp)
  8024a7:	50                   	push   %eax
  8024a8:	68 a4 30 80 00       	push   $0x8030a4
  8024ad:	6a 74                	push   $0x74
  8024af:	e8 6e e0 ff ff       	call   800522 <cprintf_colored>
  8024b4:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8024b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8024ba:	83 ec 08             	sub    $0x8,%esp
  8024bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8024c0:	50                   	push   %eax
  8024c1:	e8 c0 df ff ff       	call   800486 <vcprintf>
  8024c6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8024c9:	83 ec 08             	sub    $0x8,%esp
  8024cc:	6a 00                	push   $0x0
  8024ce:	68 cc 30 80 00       	push   $0x8030cc
  8024d3:	e8 ae df ff ff       	call   800486 <vcprintf>
  8024d8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8024db:	e8 27 df ff ff       	call   800407 <exit>

	// should not return here
	while (1) ;
  8024e0:	eb fe                	jmp    8024e0 <_panic+0x75>

008024e2 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8024e2:	55                   	push   %ebp
  8024e3:	89 e5                	mov    %esp,%ebp
  8024e5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8024e8:	a1 20 40 80 00       	mov    0x804020,%eax
  8024ed:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8024f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024f6:	39 c2                	cmp    %eax,%edx
  8024f8:	74 14                	je     80250e <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8024fa:	83 ec 04             	sub    $0x4,%esp
  8024fd:	68 d0 30 80 00       	push   $0x8030d0
  802502:	6a 26                	push   $0x26
  802504:	68 1c 31 80 00       	push   $0x80311c
  802509:	e8 5d ff ff ff       	call   80246b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80250e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  802515:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80251c:	e9 c5 00 00 00       	jmp    8025e6 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  802521:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802524:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80252b:	8b 45 08             	mov    0x8(%ebp),%eax
  80252e:	01 d0                	add    %edx,%eax
  802530:	8b 00                	mov    (%eax),%eax
  802532:	85 c0                	test   %eax,%eax
  802534:	75 08                	jne    80253e <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  802536:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  802539:	e9 a5 00 00 00       	jmp    8025e3 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  80253e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802545:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80254c:	eb 69                	jmp    8025b7 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80254e:	a1 20 40 80 00       	mov    0x804020,%eax
  802553:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  802559:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80255c:	89 d0                	mov    %edx,%eax
  80255e:	01 c0                	add    %eax,%eax
  802560:	01 d0                	add    %edx,%eax
  802562:	c1 e0 03             	shl    $0x3,%eax
  802565:	01 c8                	add    %ecx,%eax
  802567:	8a 40 04             	mov    0x4(%eax),%al
  80256a:	84 c0                	test   %al,%al
  80256c:	75 46                	jne    8025b4 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80256e:	a1 20 40 80 00       	mov    0x804020,%eax
  802573:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  802579:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80257c:	89 d0                	mov    %edx,%eax
  80257e:	01 c0                	add    %eax,%eax
  802580:	01 d0                	add    %edx,%eax
  802582:	c1 e0 03             	shl    $0x3,%eax
  802585:	01 c8                	add    %ecx,%eax
  802587:	8b 00                	mov    (%eax),%eax
  802589:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80258c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80258f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  802594:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  802596:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802599:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8025a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8025a3:	01 c8                	add    %ecx,%eax
  8025a5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8025a7:	39 c2                	cmp    %eax,%edx
  8025a9:	75 09                	jne    8025b4 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8025ab:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8025b2:	eb 15                	jmp    8025c9 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8025b4:	ff 45 e8             	incl   -0x18(%ebp)
  8025b7:	a1 20 40 80 00       	mov    0x804020,%eax
  8025bc:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8025c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8025c5:	39 c2                	cmp    %eax,%edx
  8025c7:	77 85                	ja     80254e <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8025c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8025cd:	75 14                	jne    8025e3 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8025cf:	83 ec 04             	sub    $0x4,%esp
  8025d2:	68 28 31 80 00       	push   $0x803128
  8025d7:	6a 3a                	push   $0x3a
  8025d9:	68 1c 31 80 00       	push   $0x80311c
  8025de:	e8 88 fe ff ff       	call   80246b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8025e3:	ff 45 f0             	incl   -0x10(%ebp)
  8025e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8025e9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8025ec:	0f 8c 2f ff ff ff    	jl     802521 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8025f2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8025f9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  802600:	eb 26                	jmp    802628 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  802602:	a1 20 40 80 00       	mov    0x804020,%eax
  802607:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80260d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802610:	89 d0                	mov    %edx,%eax
  802612:	01 c0                	add    %eax,%eax
  802614:	01 d0                	add    %edx,%eax
  802616:	c1 e0 03             	shl    $0x3,%eax
  802619:	01 c8                	add    %ecx,%eax
  80261b:	8a 40 04             	mov    0x4(%eax),%al
  80261e:	3c 01                	cmp    $0x1,%al
  802620:	75 03                	jne    802625 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  802622:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802625:	ff 45 e0             	incl   -0x20(%ebp)
  802628:	a1 20 40 80 00       	mov    0x804020,%eax
  80262d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802633:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802636:	39 c2                	cmp    %eax,%edx
  802638:	77 c8                	ja     802602 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80263a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80263d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802640:	74 14                	je     802656 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  802642:	83 ec 04             	sub    $0x4,%esp
  802645:	68 7c 31 80 00       	push   $0x80317c
  80264a:	6a 44                	push   $0x44
  80264c:	68 1c 31 80 00       	push   $0x80311c
  802651:	e8 15 fe ff ff       	call   80246b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  802656:	90                   	nop
  802657:	c9                   	leave  
  802658:	c3                   	ret    
  802659:	66 90                	xchg   %ax,%ax
  80265b:	90                   	nop

0080265c <__udivdi3>:
  80265c:	55                   	push   %ebp
  80265d:	57                   	push   %edi
  80265e:	56                   	push   %esi
  80265f:	53                   	push   %ebx
  802660:	83 ec 1c             	sub    $0x1c,%esp
  802663:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802667:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80266b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80266f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802673:	89 ca                	mov    %ecx,%edx
  802675:	89 f8                	mov    %edi,%eax
  802677:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80267b:	85 f6                	test   %esi,%esi
  80267d:	75 2d                	jne    8026ac <__udivdi3+0x50>
  80267f:	39 cf                	cmp    %ecx,%edi
  802681:	77 65                	ja     8026e8 <__udivdi3+0x8c>
  802683:	89 fd                	mov    %edi,%ebp
  802685:	85 ff                	test   %edi,%edi
  802687:	75 0b                	jne    802694 <__udivdi3+0x38>
  802689:	b8 01 00 00 00       	mov    $0x1,%eax
  80268e:	31 d2                	xor    %edx,%edx
  802690:	f7 f7                	div    %edi
  802692:	89 c5                	mov    %eax,%ebp
  802694:	31 d2                	xor    %edx,%edx
  802696:	89 c8                	mov    %ecx,%eax
  802698:	f7 f5                	div    %ebp
  80269a:	89 c1                	mov    %eax,%ecx
  80269c:	89 d8                	mov    %ebx,%eax
  80269e:	f7 f5                	div    %ebp
  8026a0:	89 cf                	mov    %ecx,%edi
  8026a2:	89 fa                	mov    %edi,%edx
  8026a4:	83 c4 1c             	add    $0x1c,%esp
  8026a7:	5b                   	pop    %ebx
  8026a8:	5e                   	pop    %esi
  8026a9:	5f                   	pop    %edi
  8026aa:	5d                   	pop    %ebp
  8026ab:	c3                   	ret    
  8026ac:	39 ce                	cmp    %ecx,%esi
  8026ae:	77 28                	ja     8026d8 <__udivdi3+0x7c>
  8026b0:	0f bd fe             	bsr    %esi,%edi
  8026b3:	83 f7 1f             	xor    $0x1f,%edi
  8026b6:	75 40                	jne    8026f8 <__udivdi3+0x9c>
  8026b8:	39 ce                	cmp    %ecx,%esi
  8026ba:	72 0a                	jb     8026c6 <__udivdi3+0x6a>
  8026bc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8026c0:	0f 87 9e 00 00 00    	ja     802764 <__udivdi3+0x108>
  8026c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8026cb:	89 fa                	mov    %edi,%edx
  8026cd:	83 c4 1c             	add    $0x1c,%esp
  8026d0:	5b                   	pop    %ebx
  8026d1:	5e                   	pop    %esi
  8026d2:	5f                   	pop    %edi
  8026d3:	5d                   	pop    %ebp
  8026d4:	c3                   	ret    
  8026d5:	8d 76 00             	lea    0x0(%esi),%esi
  8026d8:	31 ff                	xor    %edi,%edi
  8026da:	31 c0                	xor    %eax,%eax
  8026dc:	89 fa                	mov    %edi,%edx
  8026de:	83 c4 1c             	add    $0x1c,%esp
  8026e1:	5b                   	pop    %ebx
  8026e2:	5e                   	pop    %esi
  8026e3:	5f                   	pop    %edi
  8026e4:	5d                   	pop    %ebp
  8026e5:	c3                   	ret    
  8026e6:	66 90                	xchg   %ax,%ax
  8026e8:	89 d8                	mov    %ebx,%eax
  8026ea:	f7 f7                	div    %edi
  8026ec:	31 ff                	xor    %edi,%edi
  8026ee:	89 fa                	mov    %edi,%edx
  8026f0:	83 c4 1c             	add    $0x1c,%esp
  8026f3:	5b                   	pop    %ebx
  8026f4:	5e                   	pop    %esi
  8026f5:	5f                   	pop    %edi
  8026f6:	5d                   	pop    %ebp
  8026f7:	c3                   	ret    
  8026f8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8026fd:	89 eb                	mov    %ebp,%ebx
  8026ff:	29 fb                	sub    %edi,%ebx
  802701:	89 f9                	mov    %edi,%ecx
  802703:	d3 e6                	shl    %cl,%esi
  802705:	89 c5                	mov    %eax,%ebp
  802707:	88 d9                	mov    %bl,%cl
  802709:	d3 ed                	shr    %cl,%ebp
  80270b:	89 e9                	mov    %ebp,%ecx
  80270d:	09 f1                	or     %esi,%ecx
  80270f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802713:	89 f9                	mov    %edi,%ecx
  802715:	d3 e0                	shl    %cl,%eax
  802717:	89 c5                	mov    %eax,%ebp
  802719:	89 d6                	mov    %edx,%esi
  80271b:	88 d9                	mov    %bl,%cl
  80271d:	d3 ee                	shr    %cl,%esi
  80271f:	89 f9                	mov    %edi,%ecx
  802721:	d3 e2                	shl    %cl,%edx
  802723:	8b 44 24 08          	mov    0x8(%esp),%eax
  802727:	88 d9                	mov    %bl,%cl
  802729:	d3 e8                	shr    %cl,%eax
  80272b:	09 c2                	or     %eax,%edx
  80272d:	89 d0                	mov    %edx,%eax
  80272f:	89 f2                	mov    %esi,%edx
  802731:	f7 74 24 0c          	divl   0xc(%esp)
  802735:	89 d6                	mov    %edx,%esi
  802737:	89 c3                	mov    %eax,%ebx
  802739:	f7 e5                	mul    %ebp
  80273b:	39 d6                	cmp    %edx,%esi
  80273d:	72 19                	jb     802758 <__udivdi3+0xfc>
  80273f:	74 0b                	je     80274c <__udivdi3+0xf0>
  802741:	89 d8                	mov    %ebx,%eax
  802743:	31 ff                	xor    %edi,%edi
  802745:	e9 58 ff ff ff       	jmp    8026a2 <__udivdi3+0x46>
  80274a:	66 90                	xchg   %ax,%ax
  80274c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802750:	89 f9                	mov    %edi,%ecx
  802752:	d3 e2                	shl    %cl,%edx
  802754:	39 c2                	cmp    %eax,%edx
  802756:	73 e9                	jae    802741 <__udivdi3+0xe5>
  802758:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80275b:	31 ff                	xor    %edi,%edi
  80275d:	e9 40 ff ff ff       	jmp    8026a2 <__udivdi3+0x46>
  802762:	66 90                	xchg   %ax,%ax
  802764:	31 c0                	xor    %eax,%eax
  802766:	e9 37 ff ff ff       	jmp    8026a2 <__udivdi3+0x46>
  80276b:	90                   	nop

0080276c <__umoddi3>:
  80276c:	55                   	push   %ebp
  80276d:	57                   	push   %edi
  80276e:	56                   	push   %esi
  80276f:	53                   	push   %ebx
  802770:	83 ec 1c             	sub    $0x1c,%esp
  802773:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802777:	8b 74 24 34          	mov    0x34(%esp),%esi
  80277b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80277f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802783:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802787:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80278b:	89 f3                	mov    %esi,%ebx
  80278d:	89 fa                	mov    %edi,%edx
  80278f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802793:	89 34 24             	mov    %esi,(%esp)
  802796:	85 c0                	test   %eax,%eax
  802798:	75 1a                	jne    8027b4 <__umoddi3+0x48>
  80279a:	39 f7                	cmp    %esi,%edi
  80279c:	0f 86 a2 00 00 00    	jbe    802844 <__umoddi3+0xd8>
  8027a2:	89 c8                	mov    %ecx,%eax
  8027a4:	89 f2                	mov    %esi,%edx
  8027a6:	f7 f7                	div    %edi
  8027a8:	89 d0                	mov    %edx,%eax
  8027aa:	31 d2                	xor    %edx,%edx
  8027ac:	83 c4 1c             	add    $0x1c,%esp
  8027af:	5b                   	pop    %ebx
  8027b0:	5e                   	pop    %esi
  8027b1:	5f                   	pop    %edi
  8027b2:	5d                   	pop    %ebp
  8027b3:	c3                   	ret    
  8027b4:	39 f0                	cmp    %esi,%eax
  8027b6:	0f 87 ac 00 00 00    	ja     802868 <__umoddi3+0xfc>
  8027bc:	0f bd e8             	bsr    %eax,%ebp
  8027bf:	83 f5 1f             	xor    $0x1f,%ebp
  8027c2:	0f 84 ac 00 00 00    	je     802874 <__umoddi3+0x108>
  8027c8:	bf 20 00 00 00       	mov    $0x20,%edi
  8027cd:	29 ef                	sub    %ebp,%edi
  8027cf:	89 fe                	mov    %edi,%esi
  8027d1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8027d5:	89 e9                	mov    %ebp,%ecx
  8027d7:	d3 e0                	shl    %cl,%eax
  8027d9:	89 d7                	mov    %edx,%edi
  8027db:	89 f1                	mov    %esi,%ecx
  8027dd:	d3 ef                	shr    %cl,%edi
  8027df:	09 c7                	or     %eax,%edi
  8027e1:	89 e9                	mov    %ebp,%ecx
  8027e3:	d3 e2                	shl    %cl,%edx
  8027e5:	89 14 24             	mov    %edx,(%esp)
  8027e8:	89 d8                	mov    %ebx,%eax
  8027ea:	d3 e0                	shl    %cl,%eax
  8027ec:	89 c2                	mov    %eax,%edx
  8027ee:	8b 44 24 08          	mov    0x8(%esp),%eax
  8027f2:	d3 e0                	shl    %cl,%eax
  8027f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8027f8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8027fc:	89 f1                	mov    %esi,%ecx
  8027fe:	d3 e8                	shr    %cl,%eax
  802800:	09 d0                	or     %edx,%eax
  802802:	d3 eb                	shr    %cl,%ebx
  802804:	89 da                	mov    %ebx,%edx
  802806:	f7 f7                	div    %edi
  802808:	89 d3                	mov    %edx,%ebx
  80280a:	f7 24 24             	mull   (%esp)
  80280d:	89 c6                	mov    %eax,%esi
  80280f:	89 d1                	mov    %edx,%ecx
  802811:	39 d3                	cmp    %edx,%ebx
  802813:	0f 82 87 00 00 00    	jb     8028a0 <__umoddi3+0x134>
  802819:	0f 84 91 00 00 00    	je     8028b0 <__umoddi3+0x144>
  80281f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802823:	29 f2                	sub    %esi,%edx
  802825:	19 cb                	sbb    %ecx,%ebx
  802827:	89 d8                	mov    %ebx,%eax
  802829:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80282d:	d3 e0                	shl    %cl,%eax
  80282f:	89 e9                	mov    %ebp,%ecx
  802831:	d3 ea                	shr    %cl,%edx
  802833:	09 d0                	or     %edx,%eax
  802835:	89 e9                	mov    %ebp,%ecx
  802837:	d3 eb                	shr    %cl,%ebx
  802839:	89 da                	mov    %ebx,%edx
  80283b:	83 c4 1c             	add    $0x1c,%esp
  80283e:	5b                   	pop    %ebx
  80283f:	5e                   	pop    %esi
  802840:	5f                   	pop    %edi
  802841:	5d                   	pop    %ebp
  802842:	c3                   	ret    
  802843:	90                   	nop
  802844:	89 fd                	mov    %edi,%ebp
  802846:	85 ff                	test   %edi,%edi
  802848:	75 0b                	jne    802855 <__umoddi3+0xe9>
  80284a:	b8 01 00 00 00       	mov    $0x1,%eax
  80284f:	31 d2                	xor    %edx,%edx
  802851:	f7 f7                	div    %edi
  802853:	89 c5                	mov    %eax,%ebp
  802855:	89 f0                	mov    %esi,%eax
  802857:	31 d2                	xor    %edx,%edx
  802859:	f7 f5                	div    %ebp
  80285b:	89 c8                	mov    %ecx,%eax
  80285d:	f7 f5                	div    %ebp
  80285f:	89 d0                	mov    %edx,%eax
  802861:	e9 44 ff ff ff       	jmp    8027aa <__umoddi3+0x3e>
  802866:	66 90                	xchg   %ax,%ax
  802868:	89 c8                	mov    %ecx,%eax
  80286a:	89 f2                	mov    %esi,%edx
  80286c:	83 c4 1c             	add    $0x1c,%esp
  80286f:	5b                   	pop    %ebx
  802870:	5e                   	pop    %esi
  802871:	5f                   	pop    %edi
  802872:	5d                   	pop    %ebp
  802873:	c3                   	ret    
  802874:	3b 04 24             	cmp    (%esp),%eax
  802877:	72 06                	jb     80287f <__umoddi3+0x113>
  802879:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80287d:	77 0f                	ja     80288e <__umoddi3+0x122>
  80287f:	89 f2                	mov    %esi,%edx
  802881:	29 f9                	sub    %edi,%ecx
  802883:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802887:	89 14 24             	mov    %edx,(%esp)
  80288a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80288e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802892:	8b 14 24             	mov    (%esp),%edx
  802895:	83 c4 1c             	add    $0x1c,%esp
  802898:	5b                   	pop    %ebx
  802899:	5e                   	pop    %esi
  80289a:	5f                   	pop    %edi
  80289b:	5d                   	pop    %ebp
  80289c:	c3                   	ret    
  80289d:	8d 76 00             	lea    0x0(%esi),%esi
  8028a0:	2b 04 24             	sub    (%esp),%eax
  8028a3:	19 fa                	sbb    %edi,%edx
  8028a5:	89 d1                	mov    %edx,%ecx
  8028a7:	89 c6                	mov    %eax,%esi
  8028a9:	e9 71 ff ff ff       	jmp    80281f <__umoddi3+0xb3>
  8028ae:	66 90                	xchg   %ax,%ax
  8028b0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8028b4:	72 ea                	jb     8028a0 <__umoddi3+0x134>
  8028b6:	89 d9                	mov    %ebx,%ecx
  8028b8:	e9 62 ff ff ff       	jmp    80281f <__umoddi3+0xb3>
