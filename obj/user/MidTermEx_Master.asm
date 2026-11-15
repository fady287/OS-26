
obj/user/MidTermEx_Master:     file format elf32-i386


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
  800031:	e8 de 02 00 00       	call   800314 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests the usage of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 38             	sub    $0x38,%esp
	/*[1] CREATE SHARED VARIABLE & INITIALIZE IT*/
	int *X = smalloc("X", sizeof(int) , 1) ;
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	6a 01                	push   $0x1
  800043:	6a 04                	push   $0x4
  800045:	68 20 29 80 00       	push   $0x802920
  80004a:	e8 a5 15 00 00       	call   8015f4 <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*X = 5 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 05 00 00 00    	movl   $0x5,(%eax)

	/*[2] SPECIFY WHETHER TO USE SEMAPHORE OR NOT*/
	char select;
	sys_lock_cons();
  80005e:	e8 6d 16 00 00       	call   8016d0 <sys_lock_cons>
	{
		cprintf("%~Which type of concurrency protection do you want to use? \n") ;
  800063:	83 ec 0c             	sub    $0xc,%esp
  800066:	68 24 29 80 00       	push   $0x802924
  80006b:	e8 e4 05 00 00       	call   800654 <cprintf>
  800070:	83 c4 10             	add    $0x10,%esp
		cprintf("%~0) Nothing\n") ;
  800073:	83 ec 0c             	sub    $0xc,%esp
  800076:	68 61 29 80 00       	push   $0x802961
  80007b:	e8 d4 05 00 00       	call   800654 <cprintf>
  800080:	83 c4 10             	add    $0x10,%esp
		cprintf("%~1) Semaphores\n") ;
  800083:	83 ec 0c             	sub    $0xc,%esp
  800086:	68 6f 29 80 00       	push   $0x80296f
  80008b:	e8 c4 05 00 00       	call   800654 <cprintf>
  800090:	83 c4 10             	add    $0x10,%esp
		cprintf("%~2) SpinLock\n") ;
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	68 80 29 80 00       	push   $0x802980
  80009b:	e8 b4 05 00 00       	call   800654 <cprintf>
  8000a0:	83 c4 10             	add    $0x10,%esp
		cprintf("%~your choice (0, 1, 2): ") ;
  8000a3:	83 ec 0c             	sub    $0xc,%esp
  8000a6:	68 8f 29 80 00       	push   $0x80298f
  8000ab:	e8 a4 05 00 00       	call   800654 <cprintf>
  8000b0:	83 c4 10             	add    $0x10,%esp
		select = getchar() ;
  8000b3:	e8 39 02 00 00       	call   8002f1 <getchar>
  8000b8:	88 45 f3             	mov    %al,-0xd(%ebp)
		cputchar(select);
  8000bb:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  8000bf:	83 ec 0c             	sub    $0xc,%esp
  8000c2:	50                   	push   %eax
  8000c3:	e8 0a 02 00 00       	call   8002d2 <cputchar>
  8000c8:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8000cb:	83 ec 0c             	sub    $0xc,%esp
  8000ce:	6a 0a                	push   $0xa
  8000d0:	e8 fd 01 00 00       	call   8002d2 <cputchar>
  8000d5:	83 c4 10             	add    $0x10,%esp
	}
	sys_unlock_cons();
  8000d8:	e8 0d 16 00 00       	call   8016ea <sys_unlock_cons>

	/*[3] SHARE THIS SELECTION WITH OTHER PROCESSES*/
	int *protType = smalloc("protType", sizeof(int) , 0) ;
  8000dd:	83 ec 04             	sub    $0x4,%esp
  8000e0:	6a 00                	push   $0x0
  8000e2:	6a 04                	push   $0x4
  8000e4:	68 a9 29 80 00       	push   $0x8029a9
  8000e9:	e8 06 15 00 00       	call   8015f4 <smalloc>
  8000ee:	83 c4 10             	add    $0x10,%esp
  8000f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
	*protType = 0 ;
  8000f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000f7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	if (select == '1') 		*protType = 1 ;
  8000fd:	80 7d f3 31          	cmpb   $0x31,-0xd(%ebp)
  800101:	75 0b                	jne    80010e <_main+0xd6>
  800103:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800106:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  80010c:	eb 0f                	jmp    80011d <_main+0xe5>
	else if (select == '2') *protType = 2 ;
  80010e:	80 7d f3 32          	cmpb   $0x32,-0xd(%ebp)
  800112:	75 09                	jne    80011d <_main+0xe5>
  800114:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800117:	c7 00 02 00 00 00    	movl   $0x2,(%eax)

	struct semaphore T, finished, finishedCountMutex;
	struct uspinlock *sT, *sfinishedCountMutex;
	int *numOfFinished ;
	if (*protType == 1)
  80011d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800120:	8b 00                	mov    (%eax),%eax
  800122:	83 f8 01             	cmp    $0x1,%eax
  800125:	75 44                	jne    80016b <_main+0x133>
	{
		T = create_semaphore("T", 0);
  800127:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  80012a:	83 ec 04             	sub    $0x4,%esp
  80012d:	6a 00                	push   $0x0
  80012f:	68 b2 29 80 00       	push   $0x8029b2
  800134:	50                   	push   %eax
  800135:	e8 46 22 00 00       	call   802380 <create_semaphore>
  80013a:	83 c4 0c             	add    $0xc,%esp
		finished = create_semaphore("finished", 0);
  80013d:	8d 45 d0             	lea    -0x30(%ebp),%eax
  800140:	83 ec 04             	sub    $0x4,%esp
  800143:	6a 00                	push   $0x0
  800145:	68 b4 29 80 00       	push   $0x8029b4
  80014a:	50                   	push   %eax
  80014b:	e8 30 22 00 00       	call   802380 <create_semaphore>
  800150:	83 c4 0c             	add    $0xc,%esp
		finishedCountMutex = create_semaphore("finishedCountMutex", 1);
  800153:	8d 45 cc             	lea    -0x34(%ebp),%eax
  800156:	83 ec 04             	sub    $0x4,%esp
  800159:	6a 01                	push   $0x1
  80015b:	68 bd 29 80 00       	push   $0x8029bd
  800160:	50                   	push   %eax
  800161:	e8 1a 22 00 00       	call   802380 <create_semaphore>
  800166:	83 c4 0c             	add    $0xc,%esp
  800169:	eb 62                	jmp    8001cd <_main+0x195>
	}
	else if (*protType == 2)
  80016b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80016e:	8b 00                	mov    (%eax),%eax
  800170:	83 f8 02             	cmp    $0x2,%eax
  800173:	75 58                	jne    8001cd <_main+0x195>
	{
		sT = smalloc("T", sizeof(struct uspinlock), 1);
  800175:	83 ec 04             	sub    $0x4,%esp
  800178:	6a 01                	push   $0x1
  80017a:	6a 44                	push   $0x44
  80017c:	68 b2 29 80 00       	push   $0x8029b2
  800181:	e8 6e 14 00 00       	call   8015f4 <smalloc>
  800186:	83 c4 10             	add    $0x10,%esp
  800189:	89 45 e8             	mov    %eax,-0x18(%ebp)
		init_uspinlock(sT, "T", 0);
  80018c:	83 ec 04             	sub    $0x4,%esp
  80018f:	6a 00                	push   $0x0
  800191:	68 b2 29 80 00       	push   $0x8029b2
  800196:	ff 75 e8             	pushl  -0x18(%ebp)
  800199:	e8 55 22 00 00       	call   8023f3 <init_uspinlock>
  80019e:	83 c4 10             	add    $0x10,%esp
		sfinishedCountMutex = smalloc("finishedCountMutex", sizeof(struct uspinlock), 1);
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	6a 01                	push   $0x1
  8001a6:	6a 44                	push   $0x44
  8001a8:	68 bd 29 80 00       	push   $0x8029bd
  8001ad:	e8 42 14 00 00       	call   8015f4 <smalloc>
  8001b2:	83 c4 10             	add    $0x10,%esp
  8001b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		init_uspinlock(sfinishedCountMutex, "finishedCountMutex", 1);
  8001b8:	83 ec 04             	sub    $0x4,%esp
  8001bb:	6a 01                	push   $0x1
  8001bd:	68 bd 29 80 00       	push   $0x8029bd
  8001c2:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001c5:	e8 29 22 00 00       	call   8023f3 <init_uspinlock>
  8001ca:	83 c4 10             	add    $0x10,%esp
	}
	//Create the check-finishing counter
	numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  8001cd:	83 ec 04             	sub    $0x4,%esp
  8001d0:	6a 01                	push   $0x1
  8001d2:	6a 04                	push   $0x4
  8001d4:	68 d0 29 80 00       	push   $0x8029d0
  8001d9:	e8 16 14 00 00       	call   8015f4 <smalloc>
  8001de:	83 c4 10             	add    $0x10,%esp
  8001e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
	*numOfFinished = 0 ;
  8001e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001e7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	/*[4] CREATE AND RUN ProcessA & ProcessB*/

	//Create the 2 processes
	int32 envIdProcessA = sys_create_env("midterm_a", (myEnv->page_WS_max_size),(myEnv->page_2nd_WS_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8001ed:	a1 20 40 80 00       	mov    0x804020,%eax
  8001f2:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  8001f8:	a1 20 40 80 00       	mov    0x804020,%eax
  8001fd:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  800203:	a1 20 40 80 00       	mov    0x804020,%eax
  800208:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  80020e:	51                   	push   %ecx
  80020f:	52                   	push   %edx
  800210:	50                   	push   %eax
  800211:	68 de 29 80 00       	push   $0x8029de
  800216:	e8 bf 16 00 00       	call   8018da <sys_create_env>
  80021b:	83 c4 10             	add    $0x10,%esp
  80021e:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int32 envIdProcessB = sys_create_env("midterm_b", (myEnv->page_WS_max_size), (myEnv->page_2nd_WS_size),(myEnv->percentage_of_WS_pages_to_be_removed));
  800221:	a1 20 40 80 00       	mov    0x804020,%eax
  800226:	8b 88 80 05 00 00    	mov    0x580(%eax),%ecx
  80022c:	a1 20 40 80 00       	mov    0x804020,%eax
  800231:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
  800237:	a1 20 40 80 00       	mov    0x804020,%eax
  80023c:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  800242:	51                   	push   %ecx
  800243:	52                   	push   %edx
  800244:	50                   	push   %eax
  800245:	68 e8 29 80 00       	push   $0x8029e8
  80024a:	e8 8b 16 00 00       	call   8018da <sys_create_env>
  80024f:	83 c4 10             	add    $0x10,%esp
  800252:	89 45 d8             	mov    %eax,-0x28(%ebp)

	//Run the 2 processes
	sys_run_env(envIdProcessA);
  800255:	83 ec 0c             	sub    $0xc,%esp
  800258:	ff 75 dc             	pushl  -0x24(%ebp)
  80025b:	e8 98 16 00 00       	call   8018f8 <sys_run_env>
  800260:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  800263:	83 ec 0c             	sub    $0xc,%esp
  800266:	ff 75 d8             	pushl  -0x28(%ebp)
  800269:	e8 8a 16 00 00       	call   8018f8 <sys_run_env>
  80026e:	83 c4 10             	add    $0x10,%esp

	/*[5] WAIT TILL FINISHING BOTH PROCESSES*/
	if (*protType == 1)
  800271:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800274:	8b 00                	mov    (%eax),%eax
  800276:	83 f8 01             	cmp    $0x1,%eax
  800279:	75 1c                	jne    800297 <_main+0x25f>
	{
		wait_semaphore(finished);
  80027b:	83 ec 0c             	sub    $0xc,%esp
  80027e:	ff 75 d0             	pushl  -0x30(%ebp)
  800281:	e8 2e 21 00 00       	call   8023b4 <wait_semaphore>
  800286:	83 c4 10             	add    $0x10,%esp
		wait_semaphore(finished);
  800289:	83 ec 0c             	sub    $0xc,%esp
  80028c:	ff 75 d0             	pushl  -0x30(%ebp)
  80028f:	e8 20 21 00 00       	call   8023b4 <wait_semaphore>
  800294:	83 c4 10             	add    $0x10,%esp
	}
	if (*protType == 2)
  800297:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80029a:	8b 00                	mov    (%eax),%eax
  80029c:	83 f8 02             	cmp    $0x2,%eax
  80029f:	75 0d                	jne    8002ae <_main+0x276>
	{
		while (*numOfFinished != 2) ;
  8002a1:	90                   	nop
  8002a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002a5:	8b 00                	mov    (%eax),%eax
  8002a7:	83 f8 02             	cmp    $0x2,%eax
  8002aa:	75 f6                	jne    8002a2 <_main+0x26a>
  8002ac:	eb 0b                	jmp    8002b9 <_main+0x281>
	}
	else
	{
		while (*numOfFinished != 2) ;
  8002ae:	90                   	nop
  8002af:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002b2:	8b 00                	mov    (%eax),%eax
  8002b4:	83 f8 02             	cmp    $0x2,%eax
  8002b7:	75 f6                	jne    8002af <_main+0x277>
	}

	/*[6] PRINT X*/
	atomic_cprintf("%~Final value of X = %d\n", *X);
  8002b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002bc:	8b 00                	mov    (%eax),%eax
  8002be:	83 ec 08             	sub    $0x8,%esp
  8002c1:	50                   	push   %eax
  8002c2:	68 f2 29 80 00       	push   $0x8029f2
  8002c7:	e8 fa 03 00 00       	call   8006c6 <atomic_cprintf>
  8002cc:	83 c4 10             	add    $0x10,%esp

	return;
  8002cf:	90                   	nop
}
  8002d0:	c9                   	leave  
  8002d1:	c3                   	ret    

008002d2 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8002d2:	55                   	push   %ebp
  8002d3:	89 e5                	mov    %esp,%ebp
  8002d5:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8002d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8002db:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8002de:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8002e2:	83 ec 0c             	sub    $0xc,%esp
  8002e5:	50                   	push   %eax
  8002e6:	e8 2d 15 00 00       	call   801818 <sys_cputc>
  8002eb:	83 c4 10             	add    $0x10,%esp
}
  8002ee:	90                   	nop
  8002ef:	c9                   	leave  
  8002f0:	c3                   	ret    

008002f1 <getchar>:


int
getchar(void)
{
  8002f1:	55                   	push   %ebp
  8002f2:	89 e5                	mov    %esp,%ebp
  8002f4:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  8002f7:	e8 bb 13 00 00       	call   8016b7 <sys_cgetc>
  8002fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800303:	74 f2                	je     8002f7 <getchar+0x6>
	return c;
  800305:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800308:	c9                   	leave  
  800309:	c3                   	ret    

0080030a <iscons>:

int iscons(int fdnum)
{
  80030a:	55                   	push   %ebp
  80030b:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80030d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800312:	5d                   	pop    %ebp
  800313:	c3                   	ret    

00800314 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800314:	55                   	push   %ebp
  800315:	89 e5                	mov    %esp,%ebp
  800317:	57                   	push   %edi
  800318:	56                   	push   %esi
  800319:	53                   	push   %ebx
  80031a:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800320:	e8 23 16 00 00       	call   801948 <sys_getenvindex>
  800325:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800328:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80032b:	89 d0                	mov    %edx,%eax
  80032d:	c1 e0 03             	shl    $0x3,%eax
  800330:	01 d0                	add    %edx,%eax
  800332:	c1 e0 06             	shl    $0x6,%eax
  800335:	01 d0                	add    %edx,%eax
  800337:	c1 e0 03             	shl    $0x3,%eax
  80033a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80033f:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800344:	a1 20 40 80 00       	mov    0x804020,%eax
  800349:	8a 40 10             	mov    0x10(%eax),%al
  80034c:	84 c0                	test   %al,%al
  80034e:	74 0d                	je     80035d <libmain+0x49>
		binaryname = myEnv->prog_name;
  800350:	a1 20 40 80 00       	mov    0x804020,%eax
  800355:	83 c0 10             	add    $0x10,%eax
  800358:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80035d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800361:	7e 0a                	jle    80036d <libmain+0x59>
		binaryname = argv[0];
  800363:	8b 45 0c             	mov    0xc(%ebp),%eax
  800366:	8b 00                	mov    (%eax),%eax
  800368:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  80036d:	83 ec 08             	sub    $0x8,%esp
  800370:	ff 75 0c             	pushl  0xc(%ebp)
  800373:	ff 75 08             	pushl  0x8(%ebp)
  800376:	e8 bd fc ff ff       	call   800038 <_main>
  80037b:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80037e:	a1 00 40 80 00       	mov    0x804000,%eax
  800383:	85 c0                	test   %eax,%eax
  800385:	0f 84 b7 01 00 00    	je     800542 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80038b:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800391:	bb 48 2b 80 00       	mov    $0x802b48,%ebx
  800396:	ba 0e 00 00 00       	mov    $0xe,%edx
  80039b:	89 c7                	mov    %eax,%edi
  80039d:	89 de                	mov    %ebx,%esi
  80039f:	89 d1                	mov    %edx,%ecx
  8003a1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8003a3:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8003a9:	b9 56 00 00 00       	mov    $0x56,%ecx
  8003ae:	b0 00                	mov    $0x0,%al
  8003b0:	89 d7                	mov    %edx,%edi
  8003b2:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8003b4:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8003bb:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8003be:	83 ec 08             	sub    $0x8,%esp
  8003c1:	50                   	push   %eax
  8003c2:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8003c8:	50                   	push   %eax
  8003c9:	e8 7a 17 00 00       	call   801b48 <sys_utilities>
  8003ce:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8003d1:	e8 fa 12 00 00       	call   8016d0 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8003d6:	83 ec 0c             	sub    $0xc,%esp
  8003d9:	68 24 2a 80 00       	push   $0x802a24
  8003de:	e8 71 02 00 00       	call   800654 <cprintf>
  8003e3:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8003e6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8003e9:	85 c0                	test   %eax,%eax
  8003eb:	74 58                	je     800445 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8003ed:	e8 74 17 00 00       	call   801b66 <sys_get_optimal_num_faults>
  8003f2:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8003f5:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8003fb:	bb ac 2b 80 00       	mov    $0x802bac,%ebx
  800400:	ba 11 00 00 00       	mov    $0x11,%edx
  800405:	89 c7                	mov    %eax,%edi
  800407:	89 de                	mov    %ebx,%esi
  800409:	89 d1                	mov    %edx,%ecx
  80040b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80040d:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800410:	b9 53 00 00 00       	mov    $0x53,%ecx
  800415:	b0 00                	mov    $0x0,%al
  800417:	89 d7                	mov    %edx,%edi
  800419:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80041b:	83 ec 08             	sub    $0x8,%esp
  80041e:	ff 75 dc             	pushl  -0x24(%ebp)
  800421:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800427:	50                   	push   %eax
  800428:	e8 1b 17 00 00       	call   801b48 <sys_utilities>
  80042d:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800430:	83 ec 08             	sub    $0x8,%esp
  800433:	ff 75 dc             	pushl  -0x24(%ebp)
  800436:	68 4c 2a 80 00       	push   $0x802a4c
  80043b:	e8 14 02 00 00       	call   800654 <cprintf>
  800440:	83 c4 10             	add    $0x10,%esp
  800443:	eb 59                	jmp    80049e <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800445:	a1 20 40 80 00       	mov    0x804020,%eax
  80044a:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800450:	a1 20 40 80 00       	mov    0x804020,%eax
  800455:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80045b:	83 ec 04             	sub    $0x4,%esp
  80045e:	52                   	push   %edx
  80045f:	50                   	push   %eax
  800460:	68 70 2a 80 00       	push   $0x802a70
  800465:	e8 ea 01 00 00       	call   800654 <cprintf>
  80046a:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80046d:	a1 20 40 80 00       	mov    0x804020,%eax
  800472:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800478:	a1 20 40 80 00       	mov    0x804020,%eax
  80047d:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800483:	a1 20 40 80 00       	mov    0x804020,%eax
  800488:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80048e:	51                   	push   %ecx
  80048f:	52                   	push   %edx
  800490:	50                   	push   %eax
  800491:	68 98 2a 80 00       	push   $0x802a98
  800496:	e8 b9 01 00 00       	call   800654 <cprintf>
  80049b:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80049e:	a1 20 40 80 00       	mov    0x804020,%eax
  8004a3:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8004a9:	83 ec 08             	sub    $0x8,%esp
  8004ac:	50                   	push   %eax
  8004ad:	68 f0 2a 80 00       	push   $0x802af0
  8004b2:	e8 9d 01 00 00       	call   800654 <cprintf>
  8004b7:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8004ba:	83 ec 0c             	sub    $0xc,%esp
  8004bd:	68 04 2b 80 00       	push   $0x802b04
  8004c2:	e8 8d 01 00 00       	call   800654 <cprintf>
  8004c7:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8004ca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8004d1:	eb 28                	jmp    8004fb <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8004d3:	a1 20 40 80 00       	mov    0x804020,%eax
  8004d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8004db:	81 c2 74 04 00 00    	add    $0x474,%edx
  8004e1:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8004e4:	83 ec 04             	sub    $0x4,%esp
  8004e7:	50                   	push   %eax
  8004e8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8004eb:	68 1b 2b 80 00       	push   $0x802b1b
  8004f0:	e8 5f 01 00 00       	call   800654 <cprintf>
  8004f5:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8004f8:	ff 45 e4             	incl   -0x1c(%ebp)
  8004fb:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8004ff:	7e d2                	jle    8004d3 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800501:	83 ec 0c             	sub    $0xc,%esp
  800504:	68 2a 2b 80 00       	push   $0x802b2a
  800509:	e8 46 01 00 00       	call   800654 <cprintf>
  80050e:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800511:	a1 20 40 80 00       	mov    0x804020,%eax
  800516:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80051c:	83 ec 08             	sub    $0x8,%esp
  80051f:	50                   	push   %eax
  800520:	68 2e 2b 80 00       	push   $0x802b2e
  800525:	e8 2a 01 00 00       	call   800654 <cprintf>
  80052a:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80052d:	83 ec 0c             	sub    $0xc,%esp
  800530:	68 24 2a 80 00       	push   $0x802a24
  800535:	e8 1a 01 00 00       	call   800654 <cprintf>
  80053a:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80053d:	e8 a8 11 00 00       	call   8016ea <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800542:	e8 1f 00 00 00       	call   800566 <exit>
}
  800547:	90                   	nop
  800548:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80054b:	5b                   	pop    %ebx
  80054c:	5e                   	pop    %esi
  80054d:	5f                   	pop    %edi
  80054e:	5d                   	pop    %ebp
  80054f:	c3                   	ret    

00800550 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800550:	55                   	push   %ebp
  800551:	89 e5                	mov    %esp,%ebp
  800553:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800556:	83 ec 0c             	sub    $0xc,%esp
  800559:	6a 00                	push   $0x0
  80055b:	e8 b4 13 00 00       	call   801914 <sys_destroy_env>
  800560:	83 c4 10             	add    $0x10,%esp
}
  800563:	90                   	nop
  800564:	c9                   	leave  
  800565:	c3                   	ret    

00800566 <exit>:

void
exit(void)
{
  800566:	55                   	push   %ebp
  800567:	89 e5                	mov    %esp,%ebp
  800569:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80056c:	e8 09 14 00 00       	call   80197a <sys_exit_env>
}
  800571:	90                   	nop
  800572:	c9                   	leave  
  800573:	c3                   	ret    

00800574 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800574:	55                   	push   %ebp
  800575:	89 e5                	mov    %esp,%ebp
  800577:	53                   	push   %ebx
  800578:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  80057b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80057e:	8b 00                	mov    (%eax),%eax
  800580:	8d 48 01             	lea    0x1(%eax),%ecx
  800583:	8b 55 0c             	mov    0xc(%ebp),%edx
  800586:	89 0a                	mov    %ecx,(%edx)
  800588:	8b 55 08             	mov    0x8(%ebp),%edx
  80058b:	88 d1                	mov    %dl,%cl
  80058d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800590:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800594:	8b 45 0c             	mov    0xc(%ebp),%eax
  800597:	8b 00                	mov    (%eax),%eax
  800599:	3d ff 00 00 00       	cmp    $0xff,%eax
  80059e:	75 30                	jne    8005d0 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  8005a0:	8b 15 28 41 80 00    	mov    0x804128,%edx
  8005a6:	a0 40 40 80 00       	mov    0x804040,%al
  8005ab:	0f b6 c0             	movzbl %al,%eax
  8005ae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005b1:	8b 09                	mov    (%ecx),%ecx
  8005b3:	89 cb                	mov    %ecx,%ebx
  8005b5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005b8:	83 c1 08             	add    $0x8,%ecx
  8005bb:	52                   	push   %edx
  8005bc:	50                   	push   %eax
  8005bd:	53                   	push   %ebx
  8005be:	51                   	push   %ecx
  8005bf:	e8 c8 10 00 00       	call   80168c <sys_cputs>
  8005c4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ca:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005d3:	8b 40 04             	mov    0x4(%eax),%eax
  8005d6:	8d 50 01             	lea    0x1(%eax),%edx
  8005d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005dc:	89 50 04             	mov    %edx,0x4(%eax)
}
  8005df:	90                   	nop
  8005e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005e3:	c9                   	leave  
  8005e4:	c3                   	ret    

008005e5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8005e5:	55                   	push   %ebp
  8005e6:	89 e5                	mov    %esp,%ebp
  8005e8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005ee:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8005f5:	00 00 00 
	b.cnt = 0;
  8005f8:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005ff:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800602:	ff 75 0c             	pushl  0xc(%ebp)
  800605:	ff 75 08             	pushl  0x8(%ebp)
  800608:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80060e:	50                   	push   %eax
  80060f:	68 74 05 80 00       	push   $0x800574
  800614:	e8 5a 02 00 00       	call   800873 <vprintfmt>
  800619:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  80061c:	8b 15 28 41 80 00    	mov    0x804128,%edx
  800622:	a0 40 40 80 00       	mov    0x804040,%al
  800627:	0f b6 c0             	movzbl %al,%eax
  80062a:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800630:	52                   	push   %edx
  800631:	50                   	push   %eax
  800632:	51                   	push   %ecx
  800633:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800639:	83 c0 08             	add    $0x8,%eax
  80063c:	50                   	push   %eax
  80063d:	e8 4a 10 00 00       	call   80168c <sys_cputs>
  800642:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800645:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  80064c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800652:	c9                   	leave  
  800653:	c3                   	ret    

00800654 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800654:	55                   	push   %ebp
  800655:	89 e5                	mov    %esp,%ebp
  800657:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80065a:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800661:	8d 45 0c             	lea    0xc(%ebp),%eax
  800664:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800667:	8b 45 08             	mov    0x8(%ebp),%eax
  80066a:	83 ec 08             	sub    $0x8,%esp
  80066d:	ff 75 f4             	pushl  -0xc(%ebp)
  800670:	50                   	push   %eax
  800671:	e8 6f ff ff ff       	call   8005e5 <vcprintf>
  800676:	83 c4 10             	add    $0x10,%esp
  800679:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80067c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80067f:	c9                   	leave  
  800680:	c3                   	ret    

00800681 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800681:	55                   	push   %ebp
  800682:	89 e5                	mov    %esp,%ebp
  800684:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800687:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  80068e:	8b 45 08             	mov    0x8(%ebp),%eax
  800691:	c1 e0 08             	shl    $0x8,%eax
  800694:	a3 28 41 80 00       	mov    %eax,0x804128
	va_start(ap, fmt);
  800699:	8d 45 0c             	lea    0xc(%ebp),%eax
  80069c:	83 c0 04             	add    $0x4,%eax
  80069f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a5:	83 ec 08             	sub    $0x8,%esp
  8006a8:	ff 75 f4             	pushl  -0xc(%ebp)
  8006ab:	50                   	push   %eax
  8006ac:	e8 34 ff ff ff       	call   8005e5 <vcprintf>
  8006b1:	83 c4 10             	add    $0x10,%esp
  8006b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  8006b7:	c7 05 28 41 80 00 00 	movl   $0x700,0x804128
  8006be:	07 00 00 

	return cnt;
  8006c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006c4:	c9                   	leave  
  8006c5:	c3                   	ret    

008006c6 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  8006c6:	55                   	push   %ebp
  8006c7:	89 e5                	mov    %esp,%ebp
  8006c9:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  8006cc:	e8 ff 0f 00 00       	call   8016d0 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  8006d1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  8006d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006da:	83 ec 08             	sub    $0x8,%esp
  8006dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8006e0:	50                   	push   %eax
  8006e1:	e8 ff fe ff ff       	call   8005e5 <vcprintf>
  8006e6:	83 c4 10             	add    $0x10,%esp
  8006e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  8006ec:	e8 f9 0f 00 00       	call   8016ea <sys_unlock_cons>
	return cnt;
  8006f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006f4:	c9                   	leave  
  8006f5:	c3                   	ret    

008006f6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006f6:	55                   	push   %ebp
  8006f7:	89 e5                	mov    %esp,%ebp
  8006f9:	53                   	push   %ebx
  8006fa:	83 ec 14             	sub    $0x14,%esp
  8006fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800700:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800703:	8b 45 14             	mov    0x14(%ebp),%eax
  800706:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800709:	8b 45 18             	mov    0x18(%ebp),%eax
  80070c:	ba 00 00 00 00       	mov    $0x0,%edx
  800711:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800714:	77 55                	ja     80076b <printnum+0x75>
  800716:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800719:	72 05                	jb     800720 <printnum+0x2a>
  80071b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80071e:	77 4b                	ja     80076b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800720:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800723:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800726:	8b 45 18             	mov    0x18(%ebp),%eax
  800729:	ba 00 00 00 00       	mov    $0x0,%edx
  80072e:	52                   	push   %edx
  80072f:	50                   	push   %eax
  800730:	ff 75 f4             	pushl  -0xc(%ebp)
  800733:	ff 75 f0             	pushl  -0x10(%ebp)
  800736:	e8 65 1f 00 00       	call   8026a0 <__udivdi3>
  80073b:	83 c4 10             	add    $0x10,%esp
  80073e:	83 ec 04             	sub    $0x4,%esp
  800741:	ff 75 20             	pushl  0x20(%ebp)
  800744:	53                   	push   %ebx
  800745:	ff 75 18             	pushl  0x18(%ebp)
  800748:	52                   	push   %edx
  800749:	50                   	push   %eax
  80074a:	ff 75 0c             	pushl  0xc(%ebp)
  80074d:	ff 75 08             	pushl  0x8(%ebp)
  800750:	e8 a1 ff ff ff       	call   8006f6 <printnum>
  800755:	83 c4 20             	add    $0x20,%esp
  800758:	eb 1a                	jmp    800774 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80075a:	83 ec 08             	sub    $0x8,%esp
  80075d:	ff 75 0c             	pushl  0xc(%ebp)
  800760:	ff 75 20             	pushl  0x20(%ebp)
  800763:	8b 45 08             	mov    0x8(%ebp),%eax
  800766:	ff d0                	call   *%eax
  800768:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80076b:	ff 4d 1c             	decl   0x1c(%ebp)
  80076e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800772:	7f e6                	jg     80075a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800774:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800777:	bb 00 00 00 00       	mov    $0x0,%ebx
  80077c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80077f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800782:	53                   	push   %ebx
  800783:	51                   	push   %ecx
  800784:	52                   	push   %edx
  800785:	50                   	push   %eax
  800786:	e8 25 20 00 00       	call   8027b0 <__umoddi3>
  80078b:	83 c4 10             	add    $0x10,%esp
  80078e:	05 34 2e 80 00       	add    $0x802e34,%eax
  800793:	8a 00                	mov    (%eax),%al
  800795:	0f be c0             	movsbl %al,%eax
  800798:	83 ec 08             	sub    $0x8,%esp
  80079b:	ff 75 0c             	pushl  0xc(%ebp)
  80079e:	50                   	push   %eax
  80079f:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a2:	ff d0                	call   *%eax
  8007a4:	83 c4 10             	add    $0x10,%esp
}
  8007a7:	90                   	nop
  8007a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007ab:	c9                   	leave  
  8007ac:	c3                   	ret    

008007ad <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007ad:	55                   	push   %ebp
  8007ae:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007b0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007b4:	7e 1c                	jle    8007d2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	8b 00                	mov    (%eax),%eax
  8007bb:	8d 50 08             	lea    0x8(%eax),%edx
  8007be:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c1:	89 10                	mov    %edx,(%eax)
  8007c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c6:	8b 00                	mov    (%eax),%eax
  8007c8:	83 e8 08             	sub    $0x8,%eax
  8007cb:	8b 50 04             	mov    0x4(%eax),%edx
  8007ce:	8b 00                	mov    (%eax),%eax
  8007d0:	eb 40                	jmp    800812 <getuint+0x65>
	else if (lflag)
  8007d2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007d6:	74 1e                	je     8007f6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007db:	8b 00                	mov    (%eax),%eax
  8007dd:	8d 50 04             	lea    0x4(%eax),%edx
  8007e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e3:	89 10                	mov    %edx,(%eax)
  8007e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e8:	8b 00                	mov    (%eax),%eax
  8007ea:	83 e8 04             	sub    $0x4,%eax
  8007ed:	8b 00                	mov    (%eax),%eax
  8007ef:	ba 00 00 00 00       	mov    $0x0,%edx
  8007f4:	eb 1c                	jmp    800812 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f9:	8b 00                	mov    (%eax),%eax
  8007fb:	8d 50 04             	lea    0x4(%eax),%edx
  8007fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800801:	89 10                	mov    %edx,(%eax)
  800803:	8b 45 08             	mov    0x8(%ebp),%eax
  800806:	8b 00                	mov    (%eax),%eax
  800808:	83 e8 04             	sub    $0x4,%eax
  80080b:	8b 00                	mov    (%eax),%eax
  80080d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800812:	5d                   	pop    %ebp
  800813:	c3                   	ret    

00800814 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800814:	55                   	push   %ebp
  800815:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800817:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80081b:	7e 1c                	jle    800839 <getint+0x25>
		return va_arg(*ap, long long);
  80081d:	8b 45 08             	mov    0x8(%ebp),%eax
  800820:	8b 00                	mov    (%eax),%eax
  800822:	8d 50 08             	lea    0x8(%eax),%edx
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	89 10                	mov    %edx,(%eax)
  80082a:	8b 45 08             	mov    0x8(%ebp),%eax
  80082d:	8b 00                	mov    (%eax),%eax
  80082f:	83 e8 08             	sub    $0x8,%eax
  800832:	8b 50 04             	mov    0x4(%eax),%edx
  800835:	8b 00                	mov    (%eax),%eax
  800837:	eb 38                	jmp    800871 <getint+0x5d>
	else if (lflag)
  800839:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80083d:	74 1a                	je     800859 <getint+0x45>
		return va_arg(*ap, long);
  80083f:	8b 45 08             	mov    0x8(%ebp),%eax
  800842:	8b 00                	mov    (%eax),%eax
  800844:	8d 50 04             	lea    0x4(%eax),%edx
  800847:	8b 45 08             	mov    0x8(%ebp),%eax
  80084a:	89 10                	mov    %edx,(%eax)
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	8b 00                	mov    (%eax),%eax
  800851:	83 e8 04             	sub    $0x4,%eax
  800854:	8b 00                	mov    (%eax),%eax
  800856:	99                   	cltd   
  800857:	eb 18                	jmp    800871 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800859:	8b 45 08             	mov    0x8(%ebp),%eax
  80085c:	8b 00                	mov    (%eax),%eax
  80085e:	8d 50 04             	lea    0x4(%eax),%edx
  800861:	8b 45 08             	mov    0x8(%ebp),%eax
  800864:	89 10                	mov    %edx,(%eax)
  800866:	8b 45 08             	mov    0x8(%ebp),%eax
  800869:	8b 00                	mov    (%eax),%eax
  80086b:	83 e8 04             	sub    $0x4,%eax
  80086e:	8b 00                	mov    (%eax),%eax
  800870:	99                   	cltd   
}
  800871:	5d                   	pop    %ebp
  800872:	c3                   	ret    

00800873 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800873:	55                   	push   %ebp
  800874:	89 e5                	mov    %esp,%ebp
  800876:	56                   	push   %esi
  800877:	53                   	push   %ebx
  800878:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80087b:	eb 17                	jmp    800894 <vprintfmt+0x21>
			if (ch == '\0')
  80087d:	85 db                	test   %ebx,%ebx
  80087f:	0f 84 c1 03 00 00    	je     800c46 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800885:	83 ec 08             	sub    $0x8,%esp
  800888:	ff 75 0c             	pushl  0xc(%ebp)
  80088b:	53                   	push   %ebx
  80088c:	8b 45 08             	mov    0x8(%ebp),%eax
  80088f:	ff d0                	call   *%eax
  800891:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800894:	8b 45 10             	mov    0x10(%ebp),%eax
  800897:	8d 50 01             	lea    0x1(%eax),%edx
  80089a:	89 55 10             	mov    %edx,0x10(%ebp)
  80089d:	8a 00                	mov    (%eax),%al
  80089f:	0f b6 d8             	movzbl %al,%ebx
  8008a2:	83 fb 25             	cmp    $0x25,%ebx
  8008a5:	75 d6                	jne    80087d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008a7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008ab:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008b2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008b9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008c0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ca:	8d 50 01             	lea    0x1(%eax),%edx
  8008cd:	89 55 10             	mov    %edx,0x10(%ebp)
  8008d0:	8a 00                	mov    (%eax),%al
  8008d2:	0f b6 d8             	movzbl %al,%ebx
  8008d5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008d8:	83 f8 5b             	cmp    $0x5b,%eax
  8008db:	0f 87 3d 03 00 00    	ja     800c1e <vprintfmt+0x3ab>
  8008e1:	8b 04 85 58 2e 80 00 	mov    0x802e58(,%eax,4),%eax
  8008e8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008ea:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008ee:	eb d7                	jmp    8008c7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008f0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008f4:	eb d1                	jmp    8008c7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008f6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008fd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800900:	89 d0                	mov    %edx,%eax
  800902:	c1 e0 02             	shl    $0x2,%eax
  800905:	01 d0                	add    %edx,%eax
  800907:	01 c0                	add    %eax,%eax
  800909:	01 d8                	add    %ebx,%eax
  80090b:	83 e8 30             	sub    $0x30,%eax
  80090e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800911:	8b 45 10             	mov    0x10(%ebp),%eax
  800914:	8a 00                	mov    (%eax),%al
  800916:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800919:	83 fb 2f             	cmp    $0x2f,%ebx
  80091c:	7e 3e                	jle    80095c <vprintfmt+0xe9>
  80091e:	83 fb 39             	cmp    $0x39,%ebx
  800921:	7f 39                	jg     80095c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800923:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800926:	eb d5                	jmp    8008fd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800928:	8b 45 14             	mov    0x14(%ebp),%eax
  80092b:	83 c0 04             	add    $0x4,%eax
  80092e:	89 45 14             	mov    %eax,0x14(%ebp)
  800931:	8b 45 14             	mov    0x14(%ebp),%eax
  800934:	83 e8 04             	sub    $0x4,%eax
  800937:	8b 00                	mov    (%eax),%eax
  800939:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80093c:	eb 1f                	jmp    80095d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80093e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800942:	79 83                	jns    8008c7 <vprintfmt+0x54>
				width = 0;
  800944:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80094b:	e9 77 ff ff ff       	jmp    8008c7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800950:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800957:	e9 6b ff ff ff       	jmp    8008c7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80095c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80095d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800961:	0f 89 60 ff ff ff    	jns    8008c7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800967:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80096a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80096d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800974:	e9 4e ff ff ff       	jmp    8008c7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800979:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80097c:	e9 46 ff ff ff       	jmp    8008c7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800981:	8b 45 14             	mov    0x14(%ebp),%eax
  800984:	83 c0 04             	add    $0x4,%eax
  800987:	89 45 14             	mov    %eax,0x14(%ebp)
  80098a:	8b 45 14             	mov    0x14(%ebp),%eax
  80098d:	83 e8 04             	sub    $0x4,%eax
  800990:	8b 00                	mov    (%eax),%eax
  800992:	83 ec 08             	sub    $0x8,%esp
  800995:	ff 75 0c             	pushl  0xc(%ebp)
  800998:	50                   	push   %eax
  800999:	8b 45 08             	mov    0x8(%ebp),%eax
  80099c:	ff d0                	call   *%eax
  80099e:	83 c4 10             	add    $0x10,%esp
			break;
  8009a1:	e9 9b 02 00 00       	jmp    800c41 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a9:	83 c0 04             	add    $0x4,%eax
  8009ac:	89 45 14             	mov    %eax,0x14(%ebp)
  8009af:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b2:	83 e8 04             	sub    $0x4,%eax
  8009b5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009b7:	85 db                	test   %ebx,%ebx
  8009b9:	79 02                	jns    8009bd <vprintfmt+0x14a>
				err = -err;
  8009bb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009bd:	83 fb 64             	cmp    $0x64,%ebx
  8009c0:	7f 0b                	jg     8009cd <vprintfmt+0x15a>
  8009c2:	8b 34 9d a0 2c 80 00 	mov    0x802ca0(,%ebx,4),%esi
  8009c9:	85 f6                	test   %esi,%esi
  8009cb:	75 19                	jne    8009e6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009cd:	53                   	push   %ebx
  8009ce:	68 45 2e 80 00       	push   $0x802e45
  8009d3:	ff 75 0c             	pushl  0xc(%ebp)
  8009d6:	ff 75 08             	pushl  0x8(%ebp)
  8009d9:	e8 70 02 00 00       	call   800c4e <printfmt>
  8009de:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009e1:	e9 5b 02 00 00       	jmp    800c41 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009e6:	56                   	push   %esi
  8009e7:	68 4e 2e 80 00       	push   $0x802e4e
  8009ec:	ff 75 0c             	pushl  0xc(%ebp)
  8009ef:	ff 75 08             	pushl  0x8(%ebp)
  8009f2:	e8 57 02 00 00       	call   800c4e <printfmt>
  8009f7:	83 c4 10             	add    $0x10,%esp
			break;
  8009fa:	e9 42 02 00 00       	jmp    800c41 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009ff:	8b 45 14             	mov    0x14(%ebp),%eax
  800a02:	83 c0 04             	add    $0x4,%eax
  800a05:	89 45 14             	mov    %eax,0x14(%ebp)
  800a08:	8b 45 14             	mov    0x14(%ebp),%eax
  800a0b:	83 e8 04             	sub    $0x4,%eax
  800a0e:	8b 30                	mov    (%eax),%esi
  800a10:	85 f6                	test   %esi,%esi
  800a12:	75 05                	jne    800a19 <vprintfmt+0x1a6>
				p = "(null)";
  800a14:	be 51 2e 80 00       	mov    $0x802e51,%esi
			if (width > 0 && padc != '-')
  800a19:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a1d:	7e 6d                	jle    800a8c <vprintfmt+0x219>
  800a1f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a23:	74 67                	je     800a8c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a25:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a28:	83 ec 08             	sub    $0x8,%esp
  800a2b:	50                   	push   %eax
  800a2c:	56                   	push   %esi
  800a2d:	e8 1e 03 00 00       	call   800d50 <strnlen>
  800a32:	83 c4 10             	add    $0x10,%esp
  800a35:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a38:	eb 16                	jmp    800a50 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a3a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a3e:	83 ec 08             	sub    $0x8,%esp
  800a41:	ff 75 0c             	pushl  0xc(%ebp)
  800a44:	50                   	push   %eax
  800a45:	8b 45 08             	mov    0x8(%ebp),%eax
  800a48:	ff d0                	call   *%eax
  800a4a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a4d:	ff 4d e4             	decl   -0x1c(%ebp)
  800a50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a54:	7f e4                	jg     800a3a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a56:	eb 34                	jmp    800a8c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a58:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a5c:	74 1c                	je     800a7a <vprintfmt+0x207>
  800a5e:	83 fb 1f             	cmp    $0x1f,%ebx
  800a61:	7e 05                	jle    800a68 <vprintfmt+0x1f5>
  800a63:	83 fb 7e             	cmp    $0x7e,%ebx
  800a66:	7e 12                	jle    800a7a <vprintfmt+0x207>
					putch('?', putdat);
  800a68:	83 ec 08             	sub    $0x8,%esp
  800a6b:	ff 75 0c             	pushl  0xc(%ebp)
  800a6e:	6a 3f                	push   $0x3f
  800a70:	8b 45 08             	mov    0x8(%ebp),%eax
  800a73:	ff d0                	call   *%eax
  800a75:	83 c4 10             	add    $0x10,%esp
  800a78:	eb 0f                	jmp    800a89 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a7a:	83 ec 08             	sub    $0x8,%esp
  800a7d:	ff 75 0c             	pushl  0xc(%ebp)
  800a80:	53                   	push   %ebx
  800a81:	8b 45 08             	mov    0x8(%ebp),%eax
  800a84:	ff d0                	call   *%eax
  800a86:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a89:	ff 4d e4             	decl   -0x1c(%ebp)
  800a8c:	89 f0                	mov    %esi,%eax
  800a8e:	8d 70 01             	lea    0x1(%eax),%esi
  800a91:	8a 00                	mov    (%eax),%al
  800a93:	0f be d8             	movsbl %al,%ebx
  800a96:	85 db                	test   %ebx,%ebx
  800a98:	74 24                	je     800abe <vprintfmt+0x24b>
  800a9a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a9e:	78 b8                	js     800a58 <vprintfmt+0x1e5>
  800aa0:	ff 4d e0             	decl   -0x20(%ebp)
  800aa3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800aa7:	79 af                	jns    800a58 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800aa9:	eb 13                	jmp    800abe <vprintfmt+0x24b>
				putch(' ', putdat);
  800aab:	83 ec 08             	sub    $0x8,%esp
  800aae:	ff 75 0c             	pushl  0xc(%ebp)
  800ab1:	6a 20                	push   $0x20
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	ff d0                	call   *%eax
  800ab8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800abb:	ff 4d e4             	decl   -0x1c(%ebp)
  800abe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ac2:	7f e7                	jg     800aab <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ac4:	e9 78 01 00 00       	jmp    800c41 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ac9:	83 ec 08             	sub    $0x8,%esp
  800acc:	ff 75 e8             	pushl  -0x18(%ebp)
  800acf:	8d 45 14             	lea    0x14(%ebp),%eax
  800ad2:	50                   	push   %eax
  800ad3:	e8 3c fd ff ff       	call   800814 <getint>
  800ad8:	83 c4 10             	add    $0x10,%esp
  800adb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ade:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ae1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ae4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ae7:	85 d2                	test   %edx,%edx
  800ae9:	79 23                	jns    800b0e <vprintfmt+0x29b>
				putch('-', putdat);
  800aeb:	83 ec 08             	sub    $0x8,%esp
  800aee:	ff 75 0c             	pushl  0xc(%ebp)
  800af1:	6a 2d                	push   $0x2d
  800af3:	8b 45 08             	mov    0x8(%ebp),%eax
  800af6:	ff d0                	call   *%eax
  800af8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800afb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800afe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b01:	f7 d8                	neg    %eax
  800b03:	83 d2 00             	adc    $0x0,%edx
  800b06:	f7 da                	neg    %edx
  800b08:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b0b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b0e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b15:	e9 bc 00 00 00       	jmp    800bd6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b1a:	83 ec 08             	sub    $0x8,%esp
  800b1d:	ff 75 e8             	pushl  -0x18(%ebp)
  800b20:	8d 45 14             	lea    0x14(%ebp),%eax
  800b23:	50                   	push   %eax
  800b24:	e8 84 fc ff ff       	call   8007ad <getuint>
  800b29:	83 c4 10             	add    $0x10,%esp
  800b2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b2f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b32:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b39:	e9 98 00 00 00       	jmp    800bd6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b3e:	83 ec 08             	sub    $0x8,%esp
  800b41:	ff 75 0c             	pushl  0xc(%ebp)
  800b44:	6a 58                	push   $0x58
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	ff d0                	call   *%eax
  800b4b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b4e:	83 ec 08             	sub    $0x8,%esp
  800b51:	ff 75 0c             	pushl  0xc(%ebp)
  800b54:	6a 58                	push   $0x58
  800b56:	8b 45 08             	mov    0x8(%ebp),%eax
  800b59:	ff d0                	call   *%eax
  800b5b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b5e:	83 ec 08             	sub    $0x8,%esp
  800b61:	ff 75 0c             	pushl  0xc(%ebp)
  800b64:	6a 58                	push   $0x58
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	ff d0                	call   *%eax
  800b6b:	83 c4 10             	add    $0x10,%esp
			break;
  800b6e:	e9 ce 00 00 00       	jmp    800c41 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  800b73:	83 ec 08             	sub    $0x8,%esp
  800b76:	ff 75 0c             	pushl  0xc(%ebp)
  800b79:	6a 30                	push   $0x30
  800b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7e:	ff d0                	call   *%eax
  800b80:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b83:	83 ec 08             	sub    $0x8,%esp
  800b86:	ff 75 0c             	pushl  0xc(%ebp)
  800b89:	6a 78                	push   $0x78
  800b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8e:	ff d0                	call   *%eax
  800b90:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b93:	8b 45 14             	mov    0x14(%ebp),%eax
  800b96:	83 c0 04             	add    $0x4,%eax
  800b99:	89 45 14             	mov    %eax,0x14(%ebp)
  800b9c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b9f:	83 e8 04             	sub    $0x4,%eax
  800ba2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ba4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bae:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800bb5:	eb 1f                	jmp    800bd6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800bb7:	83 ec 08             	sub    $0x8,%esp
  800bba:	ff 75 e8             	pushl  -0x18(%ebp)
  800bbd:	8d 45 14             	lea    0x14(%ebp),%eax
  800bc0:	50                   	push   %eax
  800bc1:	e8 e7 fb ff ff       	call   8007ad <getuint>
  800bc6:	83 c4 10             	add    $0x10,%esp
  800bc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bcc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800bcf:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bd6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bda:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bdd:	83 ec 04             	sub    $0x4,%esp
  800be0:	52                   	push   %edx
  800be1:	ff 75 e4             	pushl  -0x1c(%ebp)
  800be4:	50                   	push   %eax
  800be5:	ff 75 f4             	pushl  -0xc(%ebp)
  800be8:	ff 75 f0             	pushl  -0x10(%ebp)
  800beb:	ff 75 0c             	pushl  0xc(%ebp)
  800bee:	ff 75 08             	pushl  0x8(%ebp)
  800bf1:	e8 00 fb ff ff       	call   8006f6 <printnum>
  800bf6:	83 c4 20             	add    $0x20,%esp
			break;
  800bf9:	eb 46                	jmp    800c41 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bfb:	83 ec 08             	sub    $0x8,%esp
  800bfe:	ff 75 0c             	pushl  0xc(%ebp)
  800c01:	53                   	push   %ebx
  800c02:	8b 45 08             	mov    0x8(%ebp),%eax
  800c05:	ff d0                	call   *%eax
  800c07:	83 c4 10             	add    $0x10,%esp
			break;
  800c0a:	eb 35                	jmp    800c41 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  800c0c:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  800c13:	eb 2c                	jmp    800c41 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  800c15:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  800c1c:	eb 23                	jmp    800c41 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c1e:	83 ec 08             	sub    $0x8,%esp
  800c21:	ff 75 0c             	pushl  0xc(%ebp)
  800c24:	6a 25                	push   $0x25
  800c26:	8b 45 08             	mov    0x8(%ebp),%eax
  800c29:	ff d0                	call   *%eax
  800c2b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c2e:	ff 4d 10             	decl   0x10(%ebp)
  800c31:	eb 03                	jmp    800c36 <vprintfmt+0x3c3>
  800c33:	ff 4d 10             	decl   0x10(%ebp)
  800c36:	8b 45 10             	mov    0x10(%ebp),%eax
  800c39:	48                   	dec    %eax
  800c3a:	8a 00                	mov    (%eax),%al
  800c3c:	3c 25                	cmp    $0x25,%al
  800c3e:	75 f3                	jne    800c33 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  800c40:	90                   	nop
		}
	}
  800c41:	e9 35 fc ff ff       	jmp    80087b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c46:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c47:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c4a:	5b                   	pop    %ebx
  800c4b:	5e                   	pop    %esi
  800c4c:	5d                   	pop    %ebp
  800c4d:	c3                   	ret    

00800c4e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c4e:	55                   	push   %ebp
  800c4f:	89 e5                	mov    %esp,%ebp
  800c51:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c54:	8d 45 10             	lea    0x10(%ebp),%eax
  800c57:	83 c0 04             	add    $0x4,%eax
  800c5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c5d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c60:	ff 75 f4             	pushl  -0xc(%ebp)
  800c63:	50                   	push   %eax
  800c64:	ff 75 0c             	pushl  0xc(%ebp)
  800c67:	ff 75 08             	pushl  0x8(%ebp)
  800c6a:	e8 04 fc ff ff       	call   800873 <vprintfmt>
  800c6f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c72:	90                   	nop
  800c73:	c9                   	leave  
  800c74:	c3                   	ret    

00800c75 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c75:	55                   	push   %ebp
  800c76:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7b:	8b 40 08             	mov    0x8(%eax),%eax
  800c7e:	8d 50 01             	lea    0x1(%eax),%edx
  800c81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c84:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8a:	8b 10                	mov    (%eax),%edx
  800c8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8f:	8b 40 04             	mov    0x4(%eax),%eax
  800c92:	39 c2                	cmp    %eax,%edx
  800c94:	73 12                	jae    800ca8 <sprintputch+0x33>
		*b->buf++ = ch;
  800c96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c99:	8b 00                	mov    (%eax),%eax
  800c9b:	8d 48 01             	lea    0x1(%eax),%ecx
  800c9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ca1:	89 0a                	mov    %ecx,(%edx)
  800ca3:	8b 55 08             	mov    0x8(%ebp),%edx
  800ca6:	88 10                	mov    %dl,(%eax)
}
  800ca8:	90                   	nop
  800ca9:	5d                   	pop    %ebp
  800caa:	c3                   	ret    

00800cab <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800cab:	55                   	push   %ebp
  800cac:	89 e5                	mov    %esp,%ebp
  800cae:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cba:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	01 d0                	add    %edx,%eax
  800cc2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ccc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800cd0:	74 06                	je     800cd8 <vsnprintf+0x2d>
  800cd2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cd6:	7f 07                	jg     800cdf <vsnprintf+0x34>
		return -E_INVAL;
  800cd8:	b8 03 00 00 00       	mov    $0x3,%eax
  800cdd:	eb 20                	jmp    800cff <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cdf:	ff 75 14             	pushl  0x14(%ebp)
  800ce2:	ff 75 10             	pushl  0x10(%ebp)
  800ce5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ce8:	50                   	push   %eax
  800ce9:	68 75 0c 80 00       	push   $0x800c75
  800cee:	e8 80 fb ff ff       	call   800873 <vprintfmt>
  800cf3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cf6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cf9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800cff:	c9                   	leave  
  800d00:	c3                   	ret    

00800d01 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d01:	55                   	push   %ebp
  800d02:	89 e5                	mov    %esp,%ebp
  800d04:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d07:	8d 45 10             	lea    0x10(%ebp),%eax
  800d0a:	83 c0 04             	add    $0x4,%eax
  800d0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d10:	8b 45 10             	mov    0x10(%ebp),%eax
  800d13:	ff 75 f4             	pushl  -0xc(%ebp)
  800d16:	50                   	push   %eax
  800d17:	ff 75 0c             	pushl  0xc(%ebp)
  800d1a:	ff 75 08             	pushl  0x8(%ebp)
  800d1d:	e8 89 ff ff ff       	call   800cab <vsnprintf>
  800d22:	83 c4 10             	add    $0x10,%esp
  800d25:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d28:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d2b:	c9                   	leave  
  800d2c:	c3                   	ret    

00800d2d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d2d:	55                   	push   %ebp
  800d2e:	89 e5                	mov    %esp,%ebp
  800d30:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d33:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d3a:	eb 06                	jmp    800d42 <strlen+0x15>
		n++;
  800d3c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d3f:	ff 45 08             	incl   0x8(%ebp)
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	8a 00                	mov    (%eax),%al
  800d47:	84 c0                	test   %al,%al
  800d49:	75 f1                	jne    800d3c <strlen+0xf>
		n++;
	return n;
  800d4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d4e:	c9                   	leave  
  800d4f:	c3                   	ret    

00800d50 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d50:	55                   	push   %ebp
  800d51:	89 e5                	mov    %esp,%ebp
  800d53:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d56:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d5d:	eb 09                	jmp    800d68 <strnlen+0x18>
		n++;
  800d5f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d62:	ff 45 08             	incl   0x8(%ebp)
  800d65:	ff 4d 0c             	decl   0xc(%ebp)
  800d68:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d6c:	74 09                	je     800d77 <strnlen+0x27>
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	8a 00                	mov    (%eax),%al
  800d73:	84 c0                	test   %al,%al
  800d75:	75 e8                	jne    800d5f <strnlen+0xf>
		n++;
	return n;
  800d77:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d7a:	c9                   	leave  
  800d7b:	c3                   	ret    

00800d7c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d7c:	55                   	push   %ebp
  800d7d:	89 e5                	mov    %esp,%ebp
  800d7f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d82:	8b 45 08             	mov    0x8(%ebp),%eax
  800d85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d88:	90                   	nop
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	8d 50 01             	lea    0x1(%eax),%edx
  800d8f:	89 55 08             	mov    %edx,0x8(%ebp)
  800d92:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d95:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d98:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d9b:	8a 12                	mov    (%edx),%dl
  800d9d:	88 10                	mov    %dl,(%eax)
  800d9f:	8a 00                	mov    (%eax),%al
  800da1:	84 c0                	test   %al,%al
  800da3:	75 e4                	jne    800d89 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800da5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800da8:	c9                   	leave  
  800da9:	c3                   	ret    

00800daa <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800daa:	55                   	push   %ebp
  800dab:	89 e5                	mov    %esp,%ebp
  800dad:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800db0:	8b 45 08             	mov    0x8(%ebp),%eax
  800db3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800db6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dbd:	eb 1f                	jmp    800dde <strncpy+0x34>
		*dst++ = *src;
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	8d 50 01             	lea    0x1(%eax),%edx
  800dc5:	89 55 08             	mov    %edx,0x8(%ebp)
  800dc8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dcb:	8a 12                	mov    (%edx),%dl
  800dcd:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd2:	8a 00                	mov    (%eax),%al
  800dd4:	84 c0                	test   %al,%al
  800dd6:	74 03                	je     800ddb <strncpy+0x31>
			src++;
  800dd8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ddb:	ff 45 fc             	incl   -0x4(%ebp)
  800dde:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de1:	3b 45 10             	cmp    0x10(%ebp),%eax
  800de4:	72 d9                	jb     800dbf <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800de6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800de9:	c9                   	leave  
  800dea:	c3                   	ret    

00800deb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800deb:	55                   	push   %ebp
  800dec:	89 e5                	mov    %esp,%ebp
  800dee:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800df1:	8b 45 08             	mov    0x8(%ebp),%eax
  800df4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800df7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dfb:	74 30                	je     800e2d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dfd:	eb 16                	jmp    800e15 <strlcpy+0x2a>
			*dst++ = *src++;
  800dff:	8b 45 08             	mov    0x8(%ebp),%eax
  800e02:	8d 50 01             	lea    0x1(%eax),%edx
  800e05:	89 55 08             	mov    %edx,0x8(%ebp)
  800e08:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e0b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e0e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e11:	8a 12                	mov    (%edx),%dl
  800e13:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e15:	ff 4d 10             	decl   0x10(%ebp)
  800e18:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e1c:	74 09                	je     800e27 <strlcpy+0x3c>
  800e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e21:	8a 00                	mov    (%eax),%al
  800e23:	84 c0                	test   %al,%al
  800e25:	75 d8                	jne    800dff <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e27:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e2d:	8b 55 08             	mov    0x8(%ebp),%edx
  800e30:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e33:	29 c2                	sub    %eax,%edx
  800e35:	89 d0                	mov    %edx,%eax
}
  800e37:	c9                   	leave  
  800e38:	c3                   	ret    

00800e39 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e39:	55                   	push   %ebp
  800e3a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e3c:	eb 06                	jmp    800e44 <strcmp+0xb>
		p++, q++;
  800e3e:	ff 45 08             	incl   0x8(%ebp)
  800e41:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	8a 00                	mov    (%eax),%al
  800e49:	84 c0                	test   %al,%al
  800e4b:	74 0e                	je     800e5b <strcmp+0x22>
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e50:	8a 10                	mov    (%eax),%dl
  800e52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e55:	8a 00                	mov    (%eax),%al
  800e57:	38 c2                	cmp    %al,%dl
  800e59:	74 e3                	je     800e3e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5e:	8a 00                	mov    (%eax),%al
  800e60:	0f b6 d0             	movzbl %al,%edx
  800e63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e66:	8a 00                	mov    (%eax),%al
  800e68:	0f b6 c0             	movzbl %al,%eax
  800e6b:	29 c2                	sub    %eax,%edx
  800e6d:	89 d0                	mov    %edx,%eax
}
  800e6f:	5d                   	pop    %ebp
  800e70:	c3                   	ret    

00800e71 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e71:	55                   	push   %ebp
  800e72:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e74:	eb 09                	jmp    800e7f <strncmp+0xe>
		n--, p++, q++;
  800e76:	ff 4d 10             	decl   0x10(%ebp)
  800e79:	ff 45 08             	incl   0x8(%ebp)
  800e7c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e7f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e83:	74 17                	je     800e9c <strncmp+0x2b>
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	8a 00                	mov    (%eax),%al
  800e8a:	84 c0                	test   %al,%al
  800e8c:	74 0e                	je     800e9c <strncmp+0x2b>
  800e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e91:	8a 10                	mov    (%eax),%dl
  800e93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e96:	8a 00                	mov    (%eax),%al
  800e98:	38 c2                	cmp    %al,%dl
  800e9a:	74 da                	je     800e76 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e9c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ea0:	75 07                	jne    800ea9 <strncmp+0x38>
		return 0;
  800ea2:	b8 00 00 00 00       	mov    $0x0,%eax
  800ea7:	eb 14                	jmp    800ebd <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eac:	8a 00                	mov    (%eax),%al
  800eae:	0f b6 d0             	movzbl %al,%edx
  800eb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb4:	8a 00                	mov    (%eax),%al
  800eb6:	0f b6 c0             	movzbl %al,%eax
  800eb9:	29 c2                	sub    %eax,%edx
  800ebb:	89 d0                	mov    %edx,%eax
}
  800ebd:	5d                   	pop    %ebp
  800ebe:	c3                   	ret    

00800ebf <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ebf:	55                   	push   %ebp
  800ec0:	89 e5                	mov    %esp,%ebp
  800ec2:	83 ec 04             	sub    $0x4,%esp
  800ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ecb:	eb 12                	jmp    800edf <strchr+0x20>
		if (*s == c)
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	8a 00                	mov    (%eax),%al
  800ed2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ed5:	75 05                	jne    800edc <strchr+0x1d>
			return (char *) s;
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	eb 11                	jmp    800eed <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800edc:	ff 45 08             	incl   0x8(%ebp)
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	8a 00                	mov    (%eax),%al
  800ee4:	84 c0                	test   %al,%al
  800ee6:	75 e5                	jne    800ecd <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ee8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800eed:	c9                   	leave  
  800eee:	c3                   	ret    

00800eef <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800eef:	55                   	push   %ebp
  800ef0:	89 e5                	mov    %esp,%ebp
  800ef2:	83 ec 04             	sub    $0x4,%esp
  800ef5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800efb:	eb 0d                	jmp    800f0a <strfind+0x1b>
		if (*s == c)
  800efd:	8b 45 08             	mov    0x8(%ebp),%eax
  800f00:	8a 00                	mov    (%eax),%al
  800f02:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f05:	74 0e                	je     800f15 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f07:	ff 45 08             	incl   0x8(%ebp)
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	84 c0                	test   %al,%al
  800f11:	75 ea                	jne    800efd <strfind+0xe>
  800f13:	eb 01                	jmp    800f16 <strfind+0x27>
		if (*s == c)
			break;
  800f15:	90                   	nop
	return (char *) s;
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f19:	c9                   	leave  
  800f1a:	c3                   	ret    

00800f1b <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  800f1b:	55                   	push   %ebp
  800f1c:	89 e5                	mov    %esp,%ebp
  800f1e:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  800f21:	8b 45 08             	mov    0x8(%ebp),%eax
  800f24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  800f27:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f2b:	76 63                	jbe    800f90 <memset+0x75>
		uint64 data_block = c;
  800f2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f30:	99                   	cltd   
  800f31:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f34:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  800f37:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f3d:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  800f41:	c1 e0 08             	shl    $0x8,%eax
  800f44:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f47:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  800f4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f50:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  800f54:	c1 e0 10             	shl    $0x10,%eax
  800f57:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f5a:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  800f5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f60:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f63:	89 c2                	mov    %eax,%edx
  800f65:	b8 00 00 00 00       	mov    $0x0,%eax
  800f6a:	09 45 f0             	or     %eax,-0x10(%ebp)
  800f6d:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  800f70:	eb 18                	jmp    800f8a <memset+0x6f>
			*p64++ = data_block, n -= 8;
  800f72:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f75:	8d 41 08             	lea    0x8(%ecx),%eax
  800f78:	89 45 fc             	mov    %eax,-0x4(%ebp)
  800f7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f81:	89 01                	mov    %eax,(%ecx)
  800f83:	89 51 04             	mov    %edx,0x4(%ecx)
  800f86:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  800f8a:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800f8e:	77 e2                	ja     800f72 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  800f90:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f94:	74 23                	je     800fb9 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  800f96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f99:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f9c:	eb 0e                	jmp    800fac <memset+0x91>
			*p8++ = (uint8)c;
  800f9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa1:	8d 50 01             	lea    0x1(%eax),%edx
  800fa4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fa7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800faa:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  800fac:	8b 45 10             	mov    0x10(%ebp),%eax
  800faf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb2:	89 55 10             	mov    %edx,0x10(%ebp)
  800fb5:	85 c0                	test   %eax,%eax
  800fb7:	75 e5                	jne    800f9e <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  800fb9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fbc:	c9                   	leave  
  800fbd:	c3                   	ret    

00800fbe <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fbe:	55                   	push   %ebp
  800fbf:	89 e5                	mov    %esp,%ebp
  800fc1:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  800fc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  800fd0:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800fd4:	76 24                	jbe    800ffa <memcpy+0x3c>
		while(n >= 8){
  800fd6:	eb 1c                	jmp    800ff4 <memcpy+0x36>
			*d64 = *s64;
  800fd8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fdb:	8b 50 04             	mov    0x4(%eax),%edx
  800fde:	8b 00                	mov    (%eax),%eax
  800fe0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fe3:	89 01                	mov    %eax,(%ecx)
  800fe5:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  800fe8:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  800fec:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  800ff0:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  800ff4:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  800ff8:	77 de                	ja     800fd8 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  800ffa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ffe:	74 31                	je     801031 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  801000:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801003:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801006:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801009:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  80100c:	eb 16                	jmp    801024 <memcpy+0x66>
			*d8++ = *s8++;
  80100e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801011:	8d 50 01             	lea    0x1(%eax),%edx
  801014:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801017:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80101a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80101d:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  801020:	8a 12                	mov    (%edx),%dl
  801022:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801024:	8b 45 10             	mov    0x10(%ebp),%eax
  801027:	8d 50 ff             	lea    -0x1(%eax),%edx
  80102a:	89 55 10             	mov    %edx,0x10(%ebp)
  80102d:	85 c0                	test   %eax,%eax
  80102f:	75 dd                	jne    80100e <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801034:	c9                   	leave  
  801035:	c3                   	ret    

00801036 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801036:	55                   	push   %ebp
  801037:	89 e5                	mov    %esp,%ebp
  801039:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80103c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801048:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80104b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80104e:	73 50                	jae    8010a0 <memmove+0x6a>
  801050:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801053:	8b 45 10             	mov    0x10(%ebp),%eax
  801056:	01 d0                	add    %edx,%eax
  801058:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80105b:	76 43                	jbe    8010a0 <memmove+0x6a>
		s += n;
  80105d:	8b 45 10             	mov    0x10(%ebp),%eax
  801060:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801063:	8b 45 10             	mov    0x10(%ebp),%eax
  801066:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801069:	eb 10                	jmp    80107b <memmove+0x45>
			*--d = *--s;
  80106b:	ff 4d f8             	decl   -0x8(%ebp)
  80106e:	ff 4d fc             	decl   -0x4(%ebp)
  801071:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801074:	8a 10                	mov    (%eax),%dl
  801076:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801079:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80107b:	8b 45 10             	mov    0x10(%ebp),%eax
  80107e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801081:	89 55 10             	mov    %edx,0x10(%ebp)
  801084:	85 c0                	test   %eax,%eax
  801086:	75 e3                	jne    80106b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801088:	eb 23                	jmp    8010ad <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80108a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80108d:	8d 50 01             	lea    0x1(%eax),%edx
  801090:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801093:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801096:	8d 4a 01             	lea    0x1(%edx),%ecx
  801099:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80109c:	8a 12                	mov    (%edx),%dl
  80109e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010a6:	89 55 10             	mov    %edx,0x10(%ebp)
  8010a9:	85 c0                	test   %eax,%eax
  8010ab:	75 dd                	jne    80108a <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010b0:	c9                   	leave  
  8010b1:	c3                   	ret    

008010b2 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010b2:	55                   	push   %ebp
  8010b3:	89 e5                	mov    %esp,%ebp
  8010b5:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c1:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010c4:	eb 2a                	jmp    8010f0 <memcmp+0x3e>
		if (*s1 != *s2)
  8010c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c9:	8a 10                	mov    (%eax),%dl
  8010cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ce:	8a 00                	mov    (%eax),%al
  8010d0:	38 c2                	cmp    %al,%dl
  8010d2:	74 16                	je     8010ea <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d7:	8a 00                	mov    (%eax),%al
  8010d9:	0f b6 d0             	movzbl %al,%edx
  8010dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010df:	8a 00                	mov    (%eax),%al
  8010e1:	0f b6 c0             	movzbl %al,%eax
  8010e4:	29 c2                	sub    %eax,%edx
  8010e6:	89 d0                	mov    %edx,%eax
  8010e8:	eb 18                	jmp    801102 <memcmp+0x50>
		s1++, s2++;
  8010ea:	ff 45 fc             	incl   -0x4(%ebp)
  8010ed:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010f6:	89 55 10             	mov    %edx,0x10(%ebp)
  8010f9:	85 c0                	test   %eax,%eax
  8010fb:	75 c9                	jne    8010c6 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801102:	c9                   	leave  
  801103:	c3                   	ret    

00801104 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801104:	55                   	push   %ebp
  801105:	89 e5                	mov    %esp,%ebp
  801107:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80110a:	8b 55 08             	mov    0x8(%ebp),%edx
  80110d:	8b 45 10             	mov    0x10(%ebp),%eax
  801110:	01 d0                	add    %edx,%eax
  801112:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801115:	eb 15                	jmp    80112c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	8a 00                	mov    (%eax),%al
  80111c:	0f b6 d0             	movzbl %al,%edx
  80111f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801122:	0f b6 c0             	movzbl %al,%eax
  801125:	39 c2                	cmp    %eax,%edx
  801127:	74 0d                	je     801136 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801129:	ff 45 08             	incl   0x8(%ebp)
  80112c:	8b 45 08             	mov    0x8(%ebp),%eax
  80112f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801132:	72 e3                	jb     801117 <memfind+0x13>
  801134:	eb 01                	jmp    801137 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801136:	90                   	nop
	return (void *) s;
  801137:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80113a:	c9                   	leave  
  80113b:	c3                   	ret    

0080113c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80113c:	55                   	push   %ebp
  80113d:	89 e5                	mov    %esp,%ebp
  80113f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801142:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801149:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801150:	eb 03                	jmp    801155 <strtol+0x19>
		s++;
  801152:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801155:	8b 45 08             	mov    0x8(%ebp),%eax
  801158:	8a 00                	mov    (%eax),%al
  80115a:	3c 20                	cmp    $0x20,%al
  80115c:	74 f4                	je     801152 <strtol+0x16>
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	8a 00                	mov    (%eax),%al
  801163:	3c 09                	cmp    $0x9,%al
  801165:	74 eb                	je     801152 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801167:	8b 45 08             	mov    0x8(%ebp),%eax
  80116a:	8a 00                	mov    (%eax),%al
  80116c:	3c 2b                	cmp    $0x2b,%al
  80116e:	75 05                	jne    801175 <strtol+0x39>
		s++;
  801170:	ff 45 08             	incl   0x8(%ebp)
  801173:	eb 13                	jmp    801188 <strtol+0x4c>
	else if (*s == '-')
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	8a 00                	mov    (%eax),%al
  80117a:	3c 2d                	cmp    $0x2d,%al
  80117c:	75 0a                	jne    801188 <strtol+0x4c>
		s++, neg = 1;
  80117e:	ff 45 08             	incl   0x8(%ebp)
  801181:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801188:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80118c:	74 06                	je     801194 <strtol+0x58>
  80118e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801192:	75 20                	jne    8011b4 <strtol+0x78>
  801194:	8b 45 08             	mov    0x8(%ebp),%eax
  801197:	8a 00                	mov    (%eax),%al
  801199:	3c 30                	cmp    $0x30,%al
  80119b:	75 17                	jne    8011b4 <strtol+0x78>
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	40                   	inc    %eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	3c 78                	cmp    $0x78,%al
  8011a5:	75 0d                	jne    8011b4 <strtol+0x78>
		s += 2, base = 16;
  8011a7:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011ab:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011b2:	eb 28                	jmp    8011dc <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b8:	75 15                	jne    8011cf <strtol+0x93>
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	8a 00                	mov    (%eax),%al
  8011bf:	3c 30                	cmp    $0x30,%al
  8011c1:	75 0c                	jne    8011cf <strtol+0x93>
		s++, base = 8;
  8011c3:	ff 45 08             	incl   0x8(%ebp)
  8011c6:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011cd:	eb 0d                	jmp    8011dc <strtol+0xa0>
	else if (base == 0)
  8011cf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d3:	75 07                	jne    8011dc <strtol+0xa0>
		base = 10;
  8011d5:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011df:	8a 00                	mov    (%eax),%al
  8011e1:	3c 2f                	cmp    $0x2f,%al
  8011e3:	7e 19                	jle    8011fe <strtol+0xc2>
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	8a 00                	mov    (%eax),%al
  8011ea:	3c 39                	cmp    $0x39,%al
  8011ec:	7f 10                	jg     8011fe <strtol+0xc2>
			dig = *s - '0';
  8011ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f1:	8a 00                	mov    (%eax),%al
  8011f3:	0f be c0             	movsbl %al,%eax
  8011f6:	83 e8 30             	sub    $0x30,%eax
  8011f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011fc:	eb 42                	jmp    801240 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801201:	8a 00                	mov    (%eax),%al
  801203:	3c 60                	cmp    $0x60,%al
  801205:	7e 19                	jle    801220 <strtol+0xe4>
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8a 00                	mov    (%eax),%al
  80120c:	3c 7a                	cmp    $0x7a,%al
  80120e:	7f 10                	jg     801220 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	8a 00                	mov    (%eax),%al
  801215:	0f be c0             	movsbl %al,%eax
  801218:	83 e8 57             	sub    $0x57,%eax
  80121b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80121e:	eb 20                	jmp    801240 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	8a 00                	mov    (%eax),%al
  801225:	3c 40                	cmp    $0x40,%al
  801227:	7e 39                	jle    801262 <strtol+0x126>
  801229:	8b 45 08             	mov    0x8(%ebp),%eax
  80122c:	8a 00                	mov    (%eax),%al
  80122e:	3c 5a                	cmp    $0x5a,%al
  801230:	7f 30                	jg     801262 <strtol+0x126>
			dig = *s - 'A' + 10;
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	0f be c0             	movsbl %al,%eax
  80123a:	83 e8 37             	sub    $0x37,%eax
  80123d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801240:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801243:	3b 45 10             	cmp    0x10(%ebp),%eax
  801246:	7d 19                	jge    801261 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801248:	ff 45 08             	incl   0x8(%ebp)
  80124b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124e:	0f af 45 10          	imul   0x10(%ebp),%eax
  801252:	89 c2                	mov    %eax,%edx
  801254:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801257:	01 d0                	add    %edx,%eax
  801259:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80125c:	e9 7b ff ff ff       	jmp    8011dc <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801261:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801262:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801266:	74 08                	je     801270 <strtol+0x134>
		*endptr = (char *) s;
  801268:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126b:	8b 55 08             	mov    0x8(%ebp),%edx
  80126e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801270:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801274:	74 07                	je     80127d <strtol+0x141>
  801276:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801279:	f7 d8                	neg    %eax
  80127b:	eb 03                	jmp    801280 <strtol+0x144>
  80127d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801280:	c9                   	leave  
  801281:	c3                   	ret    

00801282 <ltostr>:

void
ltostr(long value, char *str)
{
  801282:	55                   	push   %ebp
  801283:	89 e5                	mov    %esp,%ebp
  801285:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801288:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80128f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801296:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80129a:	79 13                	jns    8012af <ltostr+0x2d>
	{
		neg = 1;
  80129c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a6:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012a9:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012ac:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012af:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b2:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012b7:	99                   	cltd   
  8012b8:	f7 f9                	idiv   %ecx
  8012ba:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c0:	8d 50 01             	lea    0x1(%eax),%edx
  8012c3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012c6:	89 c2                	mov    %eax,%edx
  8012c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cb:	01 d0                	add    %edx,%eax
  8012cd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012d0:	83 c2 30             	add    $0x30,%edx
  8012d3:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012d8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012dd:	f7 e9                	imul   %ecx
  8012df:	c1 fa 02             	sar    $0x2,%edx
  8012e2:	89 c8                	mov    %ecx,%eax
  8012e4:	c1 f8 1f             	sar    $0x1f,%eax
  8012e7:	29 c2                	sub    %eax,%edx
  8012e9:	89 d0                	mov    %edx,%eax
  8012eb:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8012ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012f2:	75 bb                	jne    8012af <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012fe:	48                   	dec    %eax
  8012ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801302:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801306:	74 3d                	je     801345 <ltostr+0xc3>
		start = 1 ;
  801308:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80130f:	eb 34                	jmp    801345 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801311:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801314:	8b 45 0c             	mov    0xc(%ebp),%eax
  801317:	01 d0                	add    %edx,%eax
  801319:	8a 00                	mov    (%eax),%al
  80131b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80131e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801321:	8b 45 0c             	mov    0xc(%ebp),%eax
  801324:	01 c2                	add    %eax,%edx
  801326:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801329:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132c:	01 c8                	add    %ecx,%eax
  80132e:	8a 00                	mov    (%eax),%al
  801330:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801332:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801335:	8b 45 0c             	mov    0xc(%ebp),%eax
  801338:	01 c2                	add    %eax,%edx
  80133a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80133d:	88 02                	mov    %al,(%edx)
		start++ ;
  80133f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801342:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801345:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801348:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80134b:	7c c4                	jl     801311 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80134d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801350:	8b 45 0c             	mov    0xc(%ebp),%eax
  801353:	01 d0                	add    %edx,%eax
  801355:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801358:	90                   	nop
  801359:	c9                   	leave  
  80135a:	c3                   	ret    

0080135b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80135b:	55                   	push   %ebp
  80135c:	89 e5                	mov    %esp,%ebp
  80135e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801361:	ff 75 08             	pushl  0x8(%ebp)
  801364:	e8 c4 f9 ff ff       	call   800d2d <strlen>
  801369:	83 c4 04             	add    $0x4,%esp
  80136c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80136f:	ff 75 0c             	pushl  0xc(%ebp)
  801372:	e8 b6 f9 ff ff       	call   800d2d <strlen>
  801377:	83 c4 04             	add    $0x4,%esp
  80137a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80137d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801384:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80138b:	eb 17                	jmp    8013a4 <strcconcat+0x49>
		final[s] = str1[s] ;
  80138d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801390:	8b 45 10             	mov    0x10(%ebp),%eax
  801393:	01 c2                	add    %eax,%edx
  801395:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801398:	8b 45 08             	mov    0x8(%ebp),%eax
  80139b:	01 c8                	add    %ecx,%eax
  80139d:	8a 00                	mov    (%eax),%al
  80139f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013a1:	ff 45 fc             	incl   -0x4(%ebp)
  8013a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013aa:	7c e1                	jl     80138d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013ac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013b3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013ba:	eb 1f                	jmp    8013db <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013bf:	8d 50 01             	lea    0x1(%eax),%edx
  8013c2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013c5:	89 c2                	mov    %eax,%edx
  8013c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ca:	01 c2                	add    %eax,%edx
  8013cc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d2:	01 c8                	add    %ecx,%eax
  8013d4:	8a 00                	mov    (%eax),%al
  8013d6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013d8:	ff 45 f8             	incl   -0x8(%ebp)
  8013db:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013e1:	7c d9                	jl     8013bc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e9:	01 d0                	add    %edx,%eax
  8013eb:	c6 00 00             	movb   $0x0,(%eax)
}
  8013ee:	90                   	nop
  8013ef:	c9                   	leave  
  8013f0:	c3                   	ret    

008013f1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8013f7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013fd:	8b 45 14             	mov    0x14(%ebp),%eax
  801400:	8b 00                	mov    (%eax),%eax
  801402:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801409:	8b 45 10             	mov    0x10(%ebp),%eax
  80140c:	01 d0                	add    %edx,%eax
  80140e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801414:	eb 0c                	jmp    801422 <strsplit+0x31>
			*string++ = 0;
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	8d 50 01             	lea    0x1(%eax),%edx
  80141c:	89 55 08             	mov    %edx,0x8(%ebp)
  80141f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
  801425:	8a 00                	mov    (%eax),%al
  801427:	84 c0                	test   %al,%al
  801429:	74 18                	je     801443 <strsplit+0x52>
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
  80142e:	8a 00                	mov    (%eax),%al
  801430:	0f be c0             	movsbl %al,%eax
  801433:	50                   	push   %eax
  801434:	ff 75 0c             	pushl  0xc(%ebp)
  801437:	e8 83 fa ff ff       	call   800ebf <strchr>
  80143c:	83 c4 08             	add    $0x8,%esp
  80143f:	85 c0                	test   %eax,%eax
  801441:	75 d3                	jne    801416 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	84 c0                	test   %al,%al
  80144a:	74 5a                	je     8014a6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80144c:	8b 45 14             	mov    0x14(%ebp),%eax
  80144f:	8b 00                	mov    (%eax),%eax
  801451:	83 f8 0f             	cmp    $0xf,%eax
  801454:	75 07                	jne    80145d <strsplit+0x6c>
		{
			return 0;
  801456:	b8 00 00 00 00       	mov    $0x0,%eax
  80145b:	eb 66                	jmp    8014c3 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80145d:	8b 45 14             	mov    0x14(%ebp),%eax
  801460:	8b 00                	mov    (%eax),%eax
  801462:	8d 48 01             	lea    0x1(%eax),%ecx
  801465:	8b 55 14             	mov    0x14(%ebp),%edx
  801468:	89 0a                	mov    %ecx,(%edx)
  80146a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801471:	8b 45 10             	mov    0x10(%ebp),%eax
  801474:	01 c2                	add    %eax,%edx
  801476:	8b 45 08             	mov    0x8(%ebp),%eax
  801479:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80147b:	eb 03                	jmp    801480 <strsplit+0x8f>
			string++;
  80147d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801480:	8b 45 08             	mov    0x8(%ebp),%eax
  801483:	8a 00                	mov    (%eax),%al
  801485:	84 c0                	test   %al,%al
  801487:	74 8b                	je     801414 <strsplit+0x23>
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	0f be c0             	movsbl %al,%eax
  801491:	50                   	push   %eax
  801492:	ff 75 0c             	pushl  0xc(%ebp)
  801495:	e8 25 fa ff ff       	call   800ebf <strchr>
  80149a:	83 c4 08             	add    $0x8,%esp
  80149d:	85 c0                	test   %eax,%eax
  80149f:	74 dc                	je     80147d <strsplit+0x8c>
			string++;
	}
  8014a1:	e9 6e ff ff ff       	jmp    801414 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014a6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8014aa:	8b 00                	mov    (%eax),%eax
  8014ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b6:	01 d0                	add    %edx,%eax
  8014b8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014be:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
  8014c8:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8014cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8014d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014d8:	eb 4a                	jmp    801524 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8014da:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e0:	01 c2                	add    %eax,%edx
  8014e2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e8:	01 c8                	add    %ecx,%eax
  8014ea:	8a 00                	mov    (%eax),%al
  8014ec:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8014ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f4:	01 d0                	add    %edx,%eax
  8014f6:	8a 00                	mov    (%eax),%al
  8014f8:	3c 40                	cmp    $0x40,%al
  8014fa:	7e 25                	jle    801521 <str2lower+0x5c>
  8014fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801502:	01 d0                	add    %edx,%eax
  801504:	8a 00                	mov    (%eax),%al
  801506:	3c 5a                	cmp    $0x5a,%al
  801508:	7f 17                	jg     801521 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  80150a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
  801510:	01 d0                	add    %edx,%eax
  801512:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801515:	8b 55 08             	mov    0x8(%ebp),%edx
  801518:	01 ca                	add    %ecx,%edx
  80151a:	8a 12                	mov    (%edx),%dl
  80151c:	83 c2 20             	add    $0x20,%edx
  80151f:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801521:	ff 45 fc             	incl   -0x4(%ebp)
  801524:	ff 75 0c             	pushl  0xc(%ebp)
  801527:	e8 01 f8 ff ff       	call   800d2d <strlen>
  80152c:	83 c4 04             	add    $0x4,%esp
  80152f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801532:	7f a6                	jg     8014da <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801534:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
  80153c:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  80153f:	a1 08 40 80 00       	mov    0x804008,%eax
  801544:	85 c0                	test   %eax,%eax
  801546:	74 2d                	je     801575 <uheap_init+0x3c>
	{
		buddy_init();
  801548:	e8 87 06 00 00       	call   801bd4 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  80154d:	e8 31 05 00 00       	call   801a83 <sys_get_uheap_strategy>
  801552:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801557:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  80155e:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801561:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801568:	00 00 80 
		__firstTimeFlag = 0;
  80156b:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801572:	00 00 00 
	}
}
  801575:	90                   	nop
  801576:	c9                   	leave  
  801577:	c3                   	ret    

00801578 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
  80157b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  80157e:	83 ec 04             	sub    $0x4,%esp
  801581:	68 c8 2f 80 00       	push   $0x802fc8
  801586:	6a 25                	push   $0x25
  801588:	68 f9 2f 80 00       	push   $0x802ff9
  80158d:	e8 1d 0f 00 00       	call   8024af <_panic>

00801592 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801592:	55                   	push   %ebp
  801593:	89 e5                	mov    %esp,%ebp
  801595:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801598:	83 ec 04             	sub    $0x4,%esp
  80159b:	68 08 30 80 00       	push   $0x803008
  8015a0:	6a 2f                	push   $0x2f
  8015a2:	68 f9 2f 80 00       	push   $0x802ff9
  8015a7:	e8 03 0f 00 00       	call   8024af <_panic>

008015ac <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  8015ac:	55                   	push   %ebp
  8015ad:	89 e5                	mov    %esp,%ebp
  8015af:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  8015b2:	e8 82 ff ff ff       	call   801539 <uheap_init>
	if (size == 0) return NULL ;
  8015b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015bb:	75 07                	jne    8015c4 <malloc+0x18>
  8015bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8015c2:	eb 14                	jmp    8015d8 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  8015c4:	83 ec 04             	sub    $0x4,%esp
  8015c7:	68 3c 30 80 00       	push   $0x80303c
  8015cc:	6a 43                	push   $0x43
  8015ce:	68 f9 2f 80 00       	push   $0x802ff9
  8015d3:	e8 d7 0e 00 00       	call   8024af <_panic>
}
  8015d8:	c9                   	leave  
  8015d9:	c3                   	ret    

008015da <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
  8015dd:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  8015e0:	83 ec 04             	sub    $0x4,%esp
  8015e3:	68 64 30 80 00       	push   $0x803064
  8015e8:	6a 4e                	push   $0x4e
  8015ea:	68 f9 2f 80 00       	push   $0x802ff9
  8015ef:	e8 bb 0e 00 00       	call   8024af <_panic>

008015f4 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8015f4:	55                   	push   %ebp
  8015f5:	89 e5                	mov    %esp,%ebp
  8015f7:	83 ec 18             	sub    $0x18,%esp
  8015fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8015fd:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801600:	e8 34 ff ff ff       	call   801539 <uheap_init>
	if (size == 0) return NULL ;
  801605:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801609:	75 07                	jne    801612 <smalloc+0x1e>
  80160b:	b8 00 00 00 00       	mov    $0x0,%eax
  801610:	eb 14                	jmp    801626 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801612:	83 ec 04             	sub    $0x4,%esp
  801615:	68 88 30 80 00       	push   $0x803088
  80161a:	6a 5f                	push   $0x5f
  80161c:	68 f9 2f 80 00       	push   $0x802ff9
  801621:	e8 89 0e 00 00       	call   8024af <_panic>
}
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
  80162b:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  80162e:	e8 06 ff ff ff       	call   801539 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801633:	83 ec 04             	sub    $0x4,%esp
  801636:	68 b0 30 80 00       	push   $0x8030b0
  80163b:	6a 6f                	push   $0x6f
  80163d:	68 f9 2f 80 00       	push   $0x802ff9
  801642:	e8 68 0e 00 00       	call   8024af <_panic>

00801647 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801647:	55                   	push   %ebp
  801648:	89 e5                	mov    %esp,%ebp
  80164a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  80164d:	83 ec 04             	sub    $0x4,%esp
  801650:	68 d4 30 80 00       	push   $0x8030d4
  801655:	6a 7e                	push   $0x7e
  801657:	68 f9 2f 80 00       	push   $0x802ff9
  80165c:	e8 4e 0e 00 00       	call   8024af <_panic>

00801661 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801661:	55                   	push   %ebp
  801662:	89 e5                	mov    %esp,%ebp
  801664:	57                   	push   %edi
  801665:	56                   	push   %esi
  801666:	53                   	push   %ebx
  801667:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80166a:	8b 45 08             	mov    0x8(%ebp),%eax
  80166d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801670:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801673:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801676:	8b 7d 18             	mov    0x18(%ebp),%edi
  801679:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80167c:	cd 30                	int    $0x30
  80167e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801681:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801684:	83 c4 10             	add    $0x10,%esp
  801687:	5b                   	pop    %ebx
  801688:	5e                   	pop    %esi
  801689:	5f                   	pop    %edi
  80168a:	5d                   	pop    %ebp
  80168b:	c3                   	ret    

0080168c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  80168c:	55                   	push   %ebp
  80168d:	89 e5                	mov    %esp,%ebp
  80168f:	83 ec 04             	sub    $0x4,%esp
  801692:	8b 45 10             	mov    0x10(%ebp),%eax
  801695:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801698:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80169b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80169f:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a2:	6a 00                	push   $0x0
  8016a4:	51                   	push   %ecx
  8016a5:	52                   	push   %edx
  8016a6:	ff 75 0c             	pushl  0xc(%ebp)
  8016a9:	50                   	push   %eax
  8016aa:	6a 00                	push   $0x0
  8016ac:	e8 b0 ff ff ff       	call   801661 <syscall>
  8016b1:	83 c4 18             	add    $0x18,%esp
}
  8016b4:	90                   	nop
  8016b5:	c9                   	leave  
  8016b6:	c3                   	ret    

008016b7 <sys_cgetc>:

int
sys_cgetc(void)
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 02                	push   $0x2
  8016c6:	e8 96 ff ff ff       	call   801661 <syscall>
  8016cb:	83 c4 18             	add    $0x18,%esp
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <sys_lock_cons>:

void sys_lock_cons(void)
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 03                	push   $0x3
  8016df:	e8 7d ff ff ff       	call   801661 <syscall>
  8016e4:	83 c4 18             	add    $0x18,%esp
}
  8016e7:	90                   	nop
  8016e8:	c9                   	leave  
  8016e9:	c3                   	ret    

008016ea <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  8016ea:	55                   	push   %ebp
  8016eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 04                	push   $0x4
  8016f9:	e8 63 ff ff ff       	call   801661 <syscall>
  8016fe:	83 c4 18             	add    $0x18,%esp
}
  801701:	90                   	nop
  801702:	c9                   	leave  
  801703:	c3                   	ret    

00801704 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801707:	8b 55 0c             	mov    0xc(%ebp),%edx
  80170a:	8b 45 08             	mov    0x8(%ebp),%eax
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	52                   	push   %edx
  801714:	50                   	push   %eax
  801715:	6a 08                	push   $0x8
  801717:	e8 45 ff ff ff       	call   801661 <syscall>
  80171c:	83 c4 18             	add    $0x18,%esp
}
  80171f:	c9                   	leave  
  801720:	c3                   	ret    

00801721 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801721:	55                   	push   %ebp
  801722:	89 e5                	mov    %esp,%ebp
  801724:	56                   	push   %esi
  801725:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801726:	8b 75 18             	mov    0x18(%ebp),%esi
  801729:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80172c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80172f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801732:	8b 45 08             	mov    0x8(%ebp),%eax
  801735:	56                   	push   %esi
  801736:	53                   	push   %ebx
  801737:	51                   	push   %ecx
  801738:	52                   	push   %edx
  801739:	50                   	push   %eax
  80173a:	6a 09                	push   $0x9
  80173c:	e8 20 ff ff ff       	call   801661 <syscall>
  801741:	83 c4 18             	add    $0x18,%esp
}
  801744:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801747:	5b                   	pop    %ebx
  801748:	5e                   	pop    %esi
  801749:	5d                   	pop    %ebp
  80174a:	c3                   	ret    

0080174b <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  80174b:	55                   	push   %ebp
  80174c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	ff 75 08             	pushl  0x8(%ebp)
  801759:	6a 0a                	push   $0xa
  80175b:	e8 01 ff ff ff       	call   801661 <syscall>
  801760:	83 c4 18             	add    $0x18,%esp
}
  801763:	c9                   	leave  
  801764:	c3                   	ret    

00801765 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801765:	55                   	push   %ebp
  801766:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	ff 75 0c             	pushl  0xc(%ebp)
  801771:	ff 75 08             	pushl  0x8(%ebp)
  801774:	6a 0b                	push   $0xb
  801776:	e8 e6 fe ff ff       	call   801661 <syscall>
  80177b:	83 c4 18             	add    $0x18,%esp
}
  80177e:	c9                   	leave  
  80177f:	c3                   	ret    

00801780 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801780:	55                   	push   %ebp
  801781:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 0c                	push   $0xc
  80178f:	e8 cd fe ff ff       	call   801661 <syscall>
  801794:	83 c4 18             	add    $0x18,%esp
}
  801797:	c9                   	leave  
  801798:	c3                   	ret    

00801799 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801799:	55                   	push   %ebp
  80179a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 0d                	push   $0xd
  8017a8:	e8 b4 fe ff ff       	call   801661 <syscall>
  8017ad:	83 c4 18             	add    $0x18,%esp
}
  8017b0:	c9                   	leave  
  8017b1:	c3                   	ret    

008017b2 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017b2:	55                   	push   %ebp
  8017b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 00                	push   $0x0
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 0e                	push   $0xe
  8017c1:	e8 9b fe ff ff       	call   801661 <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
}
  8017c9:	c9                   	leave  
  8017ca:	c3                   	ret    

008017cb <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017cb:	55                   	push   %ebp
  8017cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 0f                	push   $0xf
  8017da:	e8 82 fe ff ff       	call   801661 <syscall>
  8017df:	83 c4 18             	add    $0x18,%esp
}
  8017e2:	c9                   	leave  
  8017e3:	c3                   	ret    

008017e4 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	ff 75 08             	pushl  0x8(%ebp)
  8017f2:	6a 10                	push   $0x10
  8017f4:	e8 68 fe ff ff       	call   801661 <syscall>
  8017f9:	83 c4 18             	add    $0x18,%esp
}
  8017fc:	c9                   	leave  
  8017fd:	c3                   	ret    

008017fe <sys_scarce_memory>:

void sys_scarce_memory()
{
  8017fe:	55                   	push   %ebp
  8017ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 11                	push   $0x11
  80180d:	e8 4f fe ff ff       	call   801661 <syscall>
  801812:	83 c4 18             	add    $0x18,%esp
}
  801815:	90                   	nop
  801816:	c9                   	leave  
  801817:	c3                   	ret    

00801818 <sys_cputc>:

void
sys_cputc(const char c)
{
  801818:	55                   	push   %ebp
  801819:	89 e5                	mov    %esp,%ebp
  80181b:	83 ec 04             	sub    $0x4,%esp
  80181e:	8b 45 08             	mov    0x8(%ebp),%eax
  801821:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801824:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	50                   	push   %eax
  801831:	6a 01                	push   $0x1
  801833:	e8 29 fe ff ff       	call   801661 <syscall>
  801838:	83 c4 18             	add    $0x18,%esp
}
  80183b:	90                   	nop
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 14                	push   $0x14
  80184d:	e8 0f fe ff ff       	call   801661 <syscall>
  801852:	83 c4 18             	add    $0x18,%esp
}
  801855:	90                   	nop
  801856:	c9                   	leave  
  801857:	c3                   	ret    

00801858 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801858:	55                   	push   %ebp
  801859:	89 e5                	mov    %esp,%ebp
  80185b:	83 ec 04             	sub    $0x4,%esp
  80185e:	8b 45 10             	mov    0x10(%ebp),%eax
  801861:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801864:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801867:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80186b:	8b 45 08             	mov    0x8(%ebp),%eax
  80186e:	6a 00                	push   $0x0
  801870:	51                   	push   %ecx
  801871:	52                   	push   %edx
  801872:	ff 75 0c             	pushl  0xc(%ebp)
  801875:	50                   	push   %eax
  801876:	6a 15                	push   $0x15
  801878:	e8 e4 fd ff ff       	call   801661 <syscall>
  80187d:	83 c4 18             	add    $0x18,%esp
}
  801880:	c9                   	leave  
  801881:	c3                   	ret    

00801882 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801885:	8b 55 10             	mov    0x10(%ebp),%edx
  801888:	8b 45 0c             	mov    0xc(%ebp),%eax
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	52                   	push   %edx
  801890:	50                   	push   %eax
  801891:	ff 75 08             	pushl  0x8(%ebp)
  801894:	6a 16                	push   $0x16
  801896:	e8 c6 fd ff ff       	call   801661 <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
}
  80189e:	c9                   	leave  
  80189f:	c3                   	ret    

008018a0 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8018a0:	55                   	push   %ebp
  8018a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	52                   	push   %edx
  8018b0:	50                   	push   %eax
  8018b1:	6a 17                	push   $0x17
  8018b3:	e8 a9 fd ff ff       	call   801661 <syscall>
  8018b8:	83 c4 18             	add    $0x18,%esp
}
  8018bb:	c9                   	leave  
  8018bc:	c3                   	ret    

008018bd <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8018bd:	55                   	push   %ebp
  8018be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8018c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	52                   	push   %edx
  8018cd:	50                   	push   %eax
  8018ce:	6a 18                	push   $0x18
  8018d0:	e8 8c fd ff ff       	call   801661 <syscall>
  8018d5:	83 c4 18             	add    $0x18,%esp
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	6a 00                	push   $0x0
  8018e2:	ff 75 14             	pushl  0x14(%ebp)
  8018e5:	ff 75 10             	pushl  0x10(%ebp)
  8018e8:	ff 75 0c             	pushl  0xc(%ebp)
  8018eb:	50                   	push   %eax
  8018ec:	6a 19                	push   $0x19
  8018ee:	e8 6e fd ff ff       	call   801661 <syscall>
  8018f3:	83 c4 18             	add    $0x18,%esp
}
  8018f6:	c9                   	leave  
  8018f7:	c3                   	ret    

008018f8 <sys_run_env>:

void sys_run_env(int32 envId)
{
  8018f8:	55                   	push   %ebp
  8018f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	50                   	push   %eax
  801907:	6a 1a                	push   $0x1a
  801909:	e8 53 fd ff ff       	call   801661 <syscall>
  80190e:	83 c4 18             	add    $0x18,%esp
}
  801911:	90                   	nop
  801912:	c9                   	leave  
  801913:	c3                   	ret    

00801914 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801914:	55                   	push   %ebp
  801915:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801917:	8b 45 08             	mov    0x8(%ebp),%eax
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	50                   	push   %eax
  801923:	6a 1b                	push   $0x1b
  801925:	e8 37 fd ff ff       	call   801661 <syscall>
  80192a:	83 c4 18             	add    $0x18,%esp
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 05                	push   $0x5
  80193e:	e8 1e fd ff ff       	call   801661 <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
}
  801946:	c9                   	leave  
  801947:	c3                   	ret    

00801948 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801948:	55                   	push   %ebp
  801949:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 06                	push   $0x6
  801957:	e8 05 fd ff ff       	call   801661 <syscall>
  80195c:	83 c4 18             	add    $0x18,%esp
}
  80195f:	c9                   	leave  
  801960:	c3                   	ret    

00801961 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801961:	55                   	push   %ebp
  801962:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 07                	push   $0x7
  801970:	e8 ec fc ff ff       	call   801661 <syscall>
  801975:	83 c4 18             	add    $0x18,%esp
}
  801978:	c9                   	leave  
  801979:	c3                   	ret    

0080197a <sys_exit_env>:


void sys_exit_env(void)
{
  80197a:	55                   	push   %ebp
  80197b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 1c                	push   $0x1c
  801989:	e8 d3 fc ff ff       	call   801661 <syscall>
  80198e:	83 c4 18             	add    $0x18,%esp
}
  801991:	90                   	nop
  801992:	c9                   	leave  
  801993:	c3                   	ret    

00801994 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801994:	55                   	push   %ebp
  801995:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	ff 75 10             	pushl  0x10(%ebp)
  80199e:	ff 75 0c             	pushl  0xc(%ebp)
  8019a1:	ff 75 08             	pushl  0x8(%ebp)
  8019a4:	6a 13                	push   $0x13
  8019a6:	e8 b6 fc ff ff       	call   801661 <syscall>
  8019ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ae:	90                   	nop
}
  8019af:	c9                   	leave  
  8019b0:	c3                   	ret    

008019b1 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019b1:	55                   	push   %ebp
  8019b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 1e                	push   $0x1e
  8019c0:	e8 9c fc ff ff       	call   801661 <syscall>
  8019c5:	83 c4 18             	add    $0x18,%esp
}
  8019c8:	c9                   	leave  
  8019c9:	c3                   	ret    

008019ca <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8019ca:	55                   	push   %ebp
  8019cb:	89 e5                	mov    %esp,%ebp
  8019cd:	83 ec 04             	sub    $0x4,%esp
  8019d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019d6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	50                   	push   %eax
  8019e3:	6a 1f                	push   $0x1f
  8019e5:	e8 77 fc ff ff       	call   801661 <syscall>
  8019ea:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ed:	90                   	nop
}
  8019ee:	c9                   	leave  
  8019ef:	c3                   	ret    

008019f0 <rsttst>:
void rsttst()
{
  8019f0:	55                   	push   %ebp
  8019f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 21                	push   $0x21
  8019ff:	e8 5d fc ff ff       	call   801661 <syscall>
  801a04:	83 c4 18             	add    $0x18,%esp
	return ;
  801a07:	90                   	nop
}
  801a08:	c9                   	leave  
  801a09:	c3                   	ret    

00801a0a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a0a:	55                   	push   %ebp
  801a0b:	89 e5                	mov    %esp,%ebp
  801a0d:	83 ec 04             	sub    $0x4,%esp
  801a10:	8b 45 14             	mov    0x14(%ebp),%eax
  801a13:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a16:	8b 55 18             	mov    0x18(%ebp),%edx
  801a19:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a1d:	52                   	push   %edx
  801a1e:	50                   	push   %eax
  801a1f:	ff 75 10             	pushl  0x10(%ebp)
  801a22:	ff 75 0c             	pushl  0xc(%ebp)
  801a25:	ff 75 08             	pushl  0x8(%ebp)
  801a28:	6a 20                	push   $0x20
  801a2a:	e8 32 fc ff ff       	call   801661 <syscall>
  801a2f:	83 c4 18             	add    $0x18,%esp
	return ;
  801a32:	90                   	nop
}
  801a33:	c9                   	leave  
  801a34:	c3                   	ret    

00801a35 <chktst>:
void chktst(uint32 n)
{
  801a35:	55                   	push   %ebp
  801a36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	ff 75 08             	pushl  0x8(%ebp)
  801a43:	6a 22                	push   $0x22
  801a45:	e8 17 fc ff ff       	call   801661 <syscall>
  801a4a:	83 c4 18             	add    $0x18,%esp
	return ;
  801a4d:	90                   	nop
}
  801a4e:	c9                   	leave  
  801a4f:	c3                   	ret    

00801a50 <inctst>:

void inctst()
{
  801a50:	55                   	push   %ebp
  801a51:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 23                	push   $0x23
  801a5f:	e8 fd fb ff ff       	call   801661 <syscall>
  801a64:	83 c4 18             	add    $0x18,%esp
	return ;
  801a67:	90                   	nop
}
  801a68:	c9                   	leave  
  801a69:	c3                   	ret    

00801a6a <gettst>:
uint32 gettst()
{
  801a6a:	55                   	push   %ebp
  801a6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 24                	push   $0x24
  801a79:	e8 e3 fb ff ff       	call   801661 <syscall>
  801a7e:	83 c4 18             	add    $0x18,%esp
}
  801a81:	c9                   	leave  
  801a82:	c3                   	ret    

00801a83 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801a83:	55                   	push   %ebp
  801a84:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 25                	push   $0x25
  801a92:	e8 ca fb ff ff       	call   801661 <syscall>
  801a97:	83 c4 18             	add    $0x18,%esp
  801a9a:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  801a9f:	a1 48 40 80 00       	mov    0x804048,%eax
}
  801aa4:	c9                   	leave  
  801aa5:	c3                   	ret    

00801aa6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801aa6:	55                   	push   %ebp
  801aa7:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  801aac:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	ff 75 08             	pushl  0x8(%ebp)
  801abc:	6a 26                	push   $0x26
  801abe:	e8 9e fb ff ff       	call   801661 <syscall>
  801ac3:	83 c4 18             	add    $0x18,%esp
	return ;
  801ac6:	90                   	nop
}
  801ac7:	c9                   	leave  
  801ac8:	c3                   	ret    

00801ac9 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801ac9:	55                   	push   %ebp
  801aca:	89 e5                	mov    %esp,%ebp
  801acc:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801acd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ad0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ad3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad9:	6a 00                	push   $0x0
  801adb:	53                   	push   %ebx
  801adc:	51                   	push   %ecx
  801add:	52                   	push   %edx
  801ade:	50                   	push   %eax
  801adf:	6a 27                	push   $0x27
  801ae1:	e8 7b fb ff ff       	call   801661 <syscall>
  801ae6:	83 c4 18             	add    $0x18,%esp
}
  801ae9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801aec:	c9                   	leave  
  801aed:	c3                   	ret    

00801aee <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801af1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af4:	8b 45 08             	mov    0x8(%ebp),%eax
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	52                   	push   %edx
  801afe:	50                   	push   %eax
  801aff:	6a 28                	push   $0x28
  801b01:	e8 5b fb ff ff       	call   801661 <syscall>
  801b06:	83 c4 18             	add    $0x18,%esp
}
  801b09:	c9                   	leave  
  801b0a:	c3                   	ret    

00801b0b <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801b0e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b11:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b14:	8b 45 08             	mov    0x8(%ebp),%eax
  801b17:	6a 00                	push   $0x0
  801b19:	51                   	push   %ecx
  801b1a:	ff 75 10             	pushl  0x10(%ebp)
  801b1d:	52                   	push   %edx
  801b1e:	50                   	push   %eax
  801b1f:	6a 29                	push   $0x29
  801b21:	e8 3b fb ff ff       	call   801661 <syscall>
  801b26:	83 c4 18             	add    $0x18,%esp
}
  801b29:	c9                   	leave  
  801b2a:	c3                   	ret    

00801b2b <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	ff 75 10             	pushl  0x10(%ebp)
  801b35:	ff 75 0c             	pushl  0xc(%ebp)
  801b38:	ff 75 08             	pushl  0x8(%ebp)
  801b3b:	6a 12                	push   $0x12
  801b3d:	e8 1f fb ff ff       	call   801661 <syscall>
  801b42:	83 c4 18             	add    $0x18,%esp
	return ;
  801b45:	90                   	nop
}
  801b46:	c9                   	leave  
  801b47:	c3                   	ret    

00801b48 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801b48:	55                   	push   %ebp
  801b49:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801b4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	52                   	push   %edx
  801b58:	50                   	push   %eax
  801b59:	6a 2a                	push   $0x2a
  801b5b:	e8 01 fb ff ff       	call   801661 <syscall>
  801b60:	83 c4 18             	add    $0x18,%esp
	return;
  801b63:	90                   	nop
}
  801b64:	c9                   	leave  
  801b65:	c3                   	ret    

00801b66 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801b66:	55                   	push   %ebp
  801b67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 2b                	push   $0x2b
  801b75:	e8 e7 fa ff ff       	call   801661 <syscall>
  801b7a:	83 c4 18             	add    $0x18,%esp
}
  801b7d:	c9                   	leave  
  801b7e:	c3                   	ret    

00801b7f <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801b7f:	55                   	push   %ebp
  801b80:	89 e5                	mov    %esp,%ebp
  801b82:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801b85:	83 ec 04             	sub    $0x4,%esp
  801b88:	68 f8 30 80 00       	push   $0x8030f8
  801b8d:	68 0a 01 00 00       	push   $0x10a
  801b92:	68 08 31 80 00       	push   $0x803108
  801b97:	e8 13 09 00 00       	call   8024af <_panic>

00801b9c <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801b9c:	55                   	push   %ebp
  801b9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	ff 75 0c             	pushl  0xc(%ebp)
  801ba8:	ff 75 08             	pushl  0x8(%ebp)
  801bab:	6a 33                	push   $0x33
  801bad:	e8 af fa ff ff       	call   801661 <syscall>
  801bb2:	83 c4 18             	add    $0x18,%esp
	return;
  801bb5:	90                   	nop
}
  801bb6:	c9                   	leave  
  801bb7:	c3                   	ret    

00801bb8 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801bb8:	55                   	push   %ebp
  801bb9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	ff 75 0c             	pushl  0xc(%ebp)
  801bc4:	ff 75 08             	pushl  0x8(%ebp)
  801bc7:	6a 34                	push   $0x34
  801bc9:	e8 93 fa ff ff       	call   801661 <syscall>
  801bce:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd1:	90                   	nop
}
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
  801bd7:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801bda:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  801be1:	eb 36                	jmp    801c19 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  801be3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801be6:	c1 e0 04             	shl    $0x4,%eax
  801be9:	05 60 40 80 00       	add    $0x804060,%eax
  801bee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801bf4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bf7:	c1 e0 04             	shl    $0x4,%eax
  801bfa:	05 64 40 80 00       	add    $0x804064,%eax
  801bff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c05:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c08:	c1 e0 04             	shl    $0x4,%eax
  801c0b:	05 6c 40 80 00       	add    $0x80406c,%eax
  801c10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  801c16:	ff 45 fc             	incl   -0x4(%ebp)
  801c19:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  801c1d:	7e c4                	jle    801be3 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  801c1f:	90                   	nop
  801c20:	c9                   	leave  
  801c21:	c3                   	ret    

00801c22 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  801c22:	55                   	push   %ebp
  801c23:	89 e5                	mov    %esp,%ebp
  801c25:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801c28:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  801c2f:	eb 24                	jmp    801c55 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  801c31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c34:	c1 e0 04             	shl    $0x4,%eax
  801c37:	05 6c 40 80 00       	add    $0x80406c,%eax
  801c3c:	8b 00                	mov    (%eax),%eax
  801c3e:	83 ec 04             	sub    $0x4,%esp
  801c41:	50                   	push   %eax
  801c42:	ff 75 f4             	pushl  -0xc(%ebp)
  801c45:	68 18 31 80 00       	push   $0x803118
  801c4a:	e8 05 ea ff ff       	call   800654 <cprintf>
  801c4f:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  801c52:	ff 45 f4             	incl   -0xc(%ebp)
  801c55:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  801c59:	7e d6                	jle    801c31 <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  801c5b:	90                   	nop
  801c5c:	c9                   	leave  
  801c5d:	c3                   	ret    

00801c5e <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  801c5e:	55                   	push   %ebp
  801c5f:	89 e5                	mov    %esp,%ebp
  801c61:	83 ec 10             	sub    $0x10,%esp
	uint32 meta = (uint32) va - META_DATA_SIZE;
  801c64:	8b 45 08             	mov    0x8(%ebp),%eax
  801c67:	83 e8 0a             	sub    $0xa,%eax
  801c6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	struct BlockMetaData *cur = (struct BlockMetaData *)meta;
  801c6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 lvl = cur->level;
  801c73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c76:	8a 00                	mov    (%eax),%al
  801c78:	0f b6 c0             	movzbl %al,%eax
  801c7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	return BLOCK_SIZE(lvl);
  801c7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c81:	ba 01 00 00 00       	mov    $0x1,%edx
  801c86:	88 c1                	mov    %al,%cl
  801c88:	d3 e2                	shl    %cl,%edx
  801c8a:	89 d0                	mov    %edx,%eax

}
  801c8c:	c9                   	leave  
  801c8d:	c3                   	ret    

00801c8e <alloc_block>:
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  801c8e:	55                   	push   %ebp
  801c8f:	89 e5                	mov    %esp,%ebp
  801c91:	83 ec 48             	sub    $0x48,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	//panic("alloc_block() not implemented");
	//do not forget if memory is full
	if(requiredSize==0) return NULL;
  801c94:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801c98:	75 0a                	jne    801ca4 <alloc_block+0x16>
  801c9a:	b8 00 00 00 00       	mov    $0x0,%eax
  801c9f:	e9 9e 04 00 00       	jmp    802142 <alloc_block+0x4b4>
	uint32 realsize = requiredSize + META_DATA_SIZE;
  801ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca7:	83 c0 0a             	add    $0xa,%eax
  801caa:	89 45 e0             	mov    %eax,-0x20(%ebp)
	uint32 level;
	for(int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL;i++){
  801cad:	c7 45 f0 04 00 00 00 	movl   $0x4,-0x10(%ebp)
  801cb4:	eb 1e                	jmp    801cd4 <alloc_block+0x46>
		if(BLOCK_SIZE(i)>=realsize){
  801cb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cb9:	ba 01 00 00 00       	mov    $0x1,%edx
  801cbe:	88 c1                	mov    %al,%cl
  801cc0:	d3 e2                	shl    %cl,%edx
  801cc2:	89 d0                	mov    %edx,%eax
  801cc4:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801cc7:	72 08                	jb     801cd1 <alloc_block+0x43>
			level=i;
  801cc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ccc:	89 45 f4             	mov    %eax,-0xc(%ebp)
			break;
  801ccf:	eb 09                	jmp    801cda <alloc_block+0x4c>
	//panic("alloc_block() not implemented");
	//do not forget if memory is full
	if(requiredSize==0) return NULL;
	uint32 realsize = requiredSize + META_DATA_SIZE;
	uint32 level;
	for(int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL;i++){
  801cd1:	ff 45 f0             	incl   -0x10(%ebp)
  801cd4:	83 7d f0 0b          	cmpl   $0xb,-0x10(%ebp)
  801cd8:	7e dc                	jle    801cb6 <alloc_block+0x28>
			level=i;
			break;
		}
	}
	uint32 first_free_level;
	bool found = 0;
  801cda:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	for(int i =level;i<=BUDDY_UPPER_LEVEL;i++){
  801ce1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ce4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801ce7:	eb 23                	jmp    801d0c <alloc_block+0x7e>
		if(LIST_SIZE(&freeBlockLists[i])>0){
  801ce9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801cec:	c1 e0 04             	shl    $0x4,%eax
  801cef:	05 6c 40 80 00       	add    $0x80406c,%eax
  801cf4:	8b 00                	mov    (%eax),%eax
  801cf6:	85 c0                	test   %eax,%eax
  801cf8:	74 0f                	je     801d09 <alloc_block+0x7b>
			found = 1;
  801cfa:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			first_free_level=i;
  801d01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d04:	89 45 ec             	mov    %eax,-0x14(%ebp)
			break;
  801d07:	eb 09                	jmp    801d12 <alloc_block+0x84>
			break;
		}
	}
	uint32 first_free_level;
	bool found = 0;
	for(int i =level;i<=BUDDY_UPPER_LEVEL;i++){
  801d09:	ff 45 e4             	incl   -0x1c(%ebp)
  801d0c:	83 7d e4 0b          	cmpl   $0xb,-0x1c(%ebp)
  801d10:	7e d7                	jle    801ce9 <alloc_block+0x5b>
			found = 1;
			first_free_level=i;
			break;
		}
	}
	if(found==0){
  801d12:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801d16:	0f 85 4e 03 00 00    	jne    80206a <alloc_block+0x3dc>

		void *address = create_buddy_space();
  801d1c:	e8 57 f8 ff ff       	call   801578 <create_buddy_space>
  801d21:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if(address==NULL) return NULL;
  801d24:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801d28:	75 0a                	jne    801d34 <alloc_block+0xa6>
  801d2a:	b8 00 00 00 00       	mov    $0x0,%eax
  801d2f:	e9 0e 04 00 00       	jmp    802142 <alloc_block+0x4b4>

		uint32 iaddress=(uint32) address;
  801d34:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d37:	89 45 d8             	mov    %eax,-0x28(%ebp)
		struct BlockMetaData *cur= (struct BlockMetaData*) address;
  801d3a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d3d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		uint32 bAddress = iaddress + BLOCK_SIZE(BUDDY_UPPER_LEVEL);
  801d40:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801d43:	05 00 08 00 00       	add    $0x800,%eax
  801d48:	89 45 d0             	mov    %eax,-0x30(%ebp)
		struct BlockMetaData *buddy= (struct BlockMetaData*)bAddress;
  801d4b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801d4e:	89 45 cc             	mov    %eax,-0x34(%ebp)
		cur -> is_free=1;
  801d51:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801d54:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		cur -> level = BUDDY_UPPER_LEVEL;
  801d58:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801d5b:	c6 00 0b             	movb   $0xb,(%eax)
		buddy -> is_free=1;
  801d5e:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801d61:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		buddy -> level= BUDDY_UPPER_LEVEL;
  801d65:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801d68:	c6 00 0b             	movb   $0xb,(%eax)
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],buddy);
  801d6b:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  801d6f:	75 14                	jne    801d85 <alloc_block+0xf7>
  801d71:	83 ec 04             	sub    $0x4,%esp
  801d74:	68 28 31 80 00       	push   $0x803128
  801d79:	6a 5f                	push   $0x5f
  801d7b:	68 4b 31 80 00       	push   $0x80314b
  801d80:	e8 2a 07 00 00       	call   8024af <_panic>
  801d85:	8b 15 10 41 80 00    	mov    0x804110,%edx
  801d8b:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801d8e:	89 50 02             	mov    %edx,0x2(%eax)
  801d91:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801d94:	8b 40 02             	mov    0x2(%eax),%eax
  801d97:	85 c0                	test   %eax,%eax
  801d99:	74 0d                	je     801da8 <alloc_block+0x11a>
  801d9b:	a1 10 41 80 00       	mov    0x804110,%eax
  801da0:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801da3:	89 50 06             	mov    %edx,0x6(%eax)
  801da6:	eb 08                	jmp    801db0 <alloc_block+0x122>
  801da8:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801dab:	a3 14 41 80 00       	mov    %eax,0x804114
  801db0:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801db3:	a3 10 41 80 00       	mov    %eax,0x804110
  801db8:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801dbb:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  801dc2:	a1 1c 41 80 00       	mov    0x80411c,%eax
  801dc7:	40                   	inc    %eax
  801dc8:	a3 1c 41 80 00       	mov    %eax,0x80411c
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],cur);
  801dcd:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  801dd1:	75 14                	jne    801de7 <alloc_block+0x159>
  801dd3:	83 ec 04             	sub    $0x4,%esp
  801dd6:	68 28 31 80 00       	push   $0x803128
  801ddb:	6a 60                	push   $0x60
  801ddd:	68 4b 31 80 00       	push   $0x80314b
  801de2:	e8 c8 06 00 00       	call   8024af <_panic>
  801de7:	8b 15 10 41 80 00    	mov    0x804110,%edx
  801ded:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801df0:	89 50 02             	mov    %edx,0x2(%eax)
  801df3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801df6:	8b 40 02             	mov    0x2(%eax),%eax
  801df9:	85 c0                	test   %eax,%eax
  801dfb:	74 0d                	je     801e0a <alloc_block+0x17c>
  801dfd:	a1 10 41 80 00       	mov    0x804110,%eax
  801e02:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801e05:	89 50 06             	mov    %edx,0x6(%eax)
  801e08:	eb 08                	jmp    801e12 <alloc_block+0x184>
  801e0a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e0d:	a3 14 41 80 00       	mov    %eax,0x804114
  801e12:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e15:	a3 10 41 80 00       	mov    %eax,0x804110
  801e1a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e1d:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  801e24:	a1 1c 41 80 00       	mov    0x80411c,%eax
  801e29:	40                   	inc    %eax
  801e2a:	a3 1c 41 80 00       	mov    %eax,0x80411c
		first_free_level=BUDDY_UPPER_LEVEL;
  801e2f:	c7 45 ec 0b 00 00 00 	movl   $0xb,-0x14(%ebp)
	}


	while(first_free_level > level){
  801e36:	e9 2f 02 00 00       	jmp    80206a <alloc_block+0x3dc>
		struct BlockMetaData *cur = LIST_FIRST(&freeBlockLists[first_free_level]);
  801e3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e3e:	c1 e0 04             	shl    $0x4,%eax
  801e41:	05 60 40 80 00       	add    $0x804060,%eax
  801e46:	8b 00                	mov    (%eax),%eax
  801e48:	89 45 c8             	mov    %eax,-0x38(%ebp)
		LIST_REMOVE(&freeBlockLists[first_free_level],cur);
  801e4b:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
  801e4f:	75 14                	jne    801e65 <alloc_block+0x1d7>
  801e51:	83 ec 04             	sub    $0x4,%esp
  801e54:	68 63 31 80 00       	push   $0x803163
  801e59:	6a 67                	push   $0x67
  801e5b:	68 4b 31 80 00       	push   $0x80314b
  801e60:	e8 4a 06 00 00       	call   8024af <_panic>
  801e65:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801e68:	8b 40 02             	mov    0x2(%eax),%eax
  801e6b:	85 c0                	test   %eax,%eax
  801e6d:	74 11                	je     801e80 <alloc_block+0x1f2>
  801e6f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801e72:	8b 40 02             	mov    0x2(%eax),%eax
  801e75:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801e78:	8b 52 06             	mov    0x6(%edx),%edx
  801e7b:	89 50 06             	mov    %edx,0x6(%eax)
  801e7e:	eb 14                	jmp    801e94 <alloc_block+0x206>
  801e80:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801e83:	8b 40 06             	mov    0x6(%eax),%eax
  801e86:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e89:	c1 e2 04             	shl    $0x4,%edx
  801e8c:	81 c2 64 40 80 00    	add    $0x804064,%edx
  801e92:	89 02                	mov    %eax,(%edx)
  801e94:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801e97:	8b 40 06             	mov    0x6(%eax),%eax
  801e9a:	85 c0                	test   %eax,%eax
  801e9c:	74 11                	je     801eaf <alloc_block+0x221>
  801e9e:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801ea1:	8b 40 06             	mov    0x6(%eax),%eax
  801ea4:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801ea7:	8b 52 02             	mov    0x2(%edx),%edx
  801eaa:	89 50 02             	mov    %edx,0x2(%eax)
  801ead:	eb 14                	jmp    801ec3 <alloc_block+0x235>
  801eaf:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801eb2:	8b 40 02             	mov    0x2(%eax),%eax
  801eb5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801eb8:	c1 e2 04             	shl    $0x4,%edx
  801ebb:	81 c2 60 40 80 00    	add    $0x804060,%edx
  801ec1:	89 02                	mov    %eax,(%edx)
  801ec3:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801ec6:	c7 40 02 00 00 00 00 	movl   $0x0,0x2(%eax)
  801ecd:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801ed0:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  801ed7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801eda:	c1 e0 04             	shl    $0x4,%eax
  801edd:	05 6c 40 80 00       	add    $0x80406c,%eax
  801ee2:	8b 00                	mov    (%eax),%eax
  801ee4:	8d 50 ff             	lea    -0x1(%eax),%edx
  801ee7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801eea:	c1 e0 04             	shl    $0x4,%eax
  801eed:	05 6c 40 80 00       	add    $0x80406c,%eax
  801ef2:	89 10                	mov    %edx,(%eax)
		uint32 bAdress= (uint32)cur ^ BLOCK_SIZE((first_free_level-1));
  801ef4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ef7:	48                   	dec    %eax
  801ef8:	ba 01 00 00 00       	mov    $0x1,%edx
  801efd:	88 c1                	mov    %al,%cl
  801eff:	d3 e2                	shl    %cl,%edx
  801f01:	89 d0                	mov    %edx,%eax
  801f03:	89 c2                	mov    %eax,%edx
  801f05:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f08:	31 d0                	xor    %edx,%eax
  801f0a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		struct BlockMetaData *buddy = (struct BlockMetaData*) bAdress;
  801f0d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  801f10:	89 45 c0             	mov    %eax,-0x40(%ebp)
		buddy->level=first_free_level-1;
  801f13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f16:	8d 50 ff             	lea    -0x1(%eax),%edx
  801f19:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801f1c:	88 10                	mov    %dl,(%eax)
		buddy->is_free=1;
  801f1e:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801f21:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		cur->is_free=1;
  801f25:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f28:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		cur->level=first_free_level-1;
  801f2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f2f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801f32:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801f35:	88 10                	mov    %dl,(%eax)
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],buddy);
  801f37:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
  801f3b:	75 14                	jne    801f51 <alloc_block+0x2c3>
  801f3d:	83 ec 04             	sub    $0x4,%esp
  801f40:	68 28 31 80 00       	push   $0x803128
  801f45:	6a 6e                	push   $0x6e
  801f47:	68 4b 31 80 00       	push   $0x80314b
  801f4c:	e8 5e 05 00 00       	call   8024af <_panic>
  801f51:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f54:	48                   	dec    %eax
  801f55:	c1 e0 04             	shl    $0x4,%eax
  801f58:	05 60 40 80 00       	add    $0x804060,%eax
  801f5d:	8b 10                	mov    (%eax),%edx
  801f5f:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801f62:	89 50 02             	mov    %edx,0x2(%eax)
  801f65:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801f68:	8b 40 02             	mov    0x2(%eax),%eax
  801f6b:	85 c0                	test   %eax,%eax
  801f6d:	74 16                	je     801f85 <alloc_block+0x2f7>
  801f6f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f72:	48                   	dec    %eax
  801f73:	c1 e0 04             	shl    $0x4,%eax
  801f76:	05 60 40 80 00       	add    $0x804060,%eax
  801f7b:	8b 00                	mov    (%eax),%eax
  801f7d:	8b 55 c0             	mov    -0x40(%ebp),%edx
  801f80:	89 50 06             	mov    %edx,0x6(%eax)
  801f83:	eb 12                	jmp    801f97 <alloc_block+0x309>
  801f85:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f88:	48                   	dec    %eax
  801f89:	c1 e0 04             	shl    $0x4,%eax
  801f8c:	8d 90 64 40 80 00    	lea    0x804064(%eax),%edx
  801f92:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801f95:	89 02                	mov    %eax,(%edx)
  801f97:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f9a:	48                   	dec    %eax
  801f9b:	c1 e0 04             	shl    $0x4,%eax
  801f9e:	8d 90 60 40 80 00    	lea    0x804060(%eax),%edx
  801fa4:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801fa7:	89 02                	mov    %eax,(%edx)
  801fa9:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801fac:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  801fb3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fb6:	48                   	dec    %eax
  801fb7:	89 c2                	mov    %eax,%edx
  801fb9:	c1 e2 04             	shl    $0x4,%edx
  801fbc:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  801fc2:	8b 12                	mov    (%edx),%edx
  801fc4:	42                   	inc    %edx
  801fc5:	c1 e0 04             	shl    $0x4,%eax
  801fc8:	05 6c 40 80 00       	add    $0x80406c,%eax
  801fcd:	89 10                	mov    %edx,(%eax)
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],cur);
  801fcf:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
  801fd3:	75 14                	jne    801fe9 <alloc_block+0x35b>
  801fd5:	83 ec 04             	sub    $0x4,%esp
  801fd8:	68 28 31 80 00       	push   $0x803128
  801fdd:	6a 6f                	push   $0x6f
  801fdf:	68 4b 31 80 00       	push   $0x80314b
  801fe4:	e8 c6 04 00 00       	call   8024af <_panic>
  801fe9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fec:	48                   	dec    %eax
  801fed:	c1 e0 04             	shl    $0x4,%eax
  801ff0:	05 60 40 80 00       	add    $0x804060,%eax
  801ff5:	8b 10                	mov    (%eax),%edx
  801ff7:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801ffa:	89 50 02             	mov    %edx,0x2(%eax)
  801ffd:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802000:	8b 40 02             	mov    0x2(%eax),%eax
  802003:	85 c0                	test   %eax,%eax
  802005:	74 16                	je     80201d <alloc_block+0x38f>
  802007:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80200a:	48                   	dec    %eax
  80200b:	c1 e0 04             	shl    $0x4,%eax
  80200e:	05 60 40 80 00       	add    $0x804060,%eax
  802013:	8b 00                	mov    (%eax),%eax
  802015:	8b 55 c8             	mov    -0x38(%ebp),%edx
  802018:	89 50 06             	mov    %edx,0x6(%eax)
  80201b:	eb 12                	jmp    80202f <alloc_block+0x3a1>
  80201d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802020:	48                   	dec    %eax
  802021:	c1 e0 04             	shl    $0x4,%eax
  802024:	8d 90 64 40 80 00    	lea    0x804064(%eax),%edx
  80202a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80202d:	89 02                	mov    %eax,(%edx)
  80202f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802032:	48                   	dec    %eax
  802033:	c1 e0 04             	shl    $0x4,%eax
  802036:	8d 90 60 40 80 00    	lea    0x804060(%eax),%edx
  80203c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80203f:	89 02                	mov    %eax,(%edx)
  802041:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802044:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  80204b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80204e:	48                   	dec    %eax
  80204f:	89 c2                	mov    %eax,%edx
  802051:	c1 e2 04             	shl    $0x4,%edx
  802054:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  80205a:	8b 12                	mov    (%edx),%edx
  80205c:	42                   	inc    %edx
  80205d:	c1 e0 04             	shl    $0x4,%eax
  802060:	05 6c 40 80 00       	add    $0x80406c,%eax
  802065:	89 10                	mov    %edx,(%eax)
		first_free_level--;
  802067:	ff 4d ec             	decl   -0x14(%ebp)
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],cur);
		first_free_level=BUDDY_UPPER_LEVEL;
	}


	while(first_free_level > level){
  80206a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80206d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802070:	0f 87 c5 fd ff ff    	ja     801e3b <alloc_block+0x1ad>
		cur->level=first_free_level-1;
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],buddy);
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],cur);
		first_free_level--;
	}
	struct BlockMetaData *ret = LIST_FIRST(&freeBlockLists[level]);
  802076:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802079:	c1 e0 04             	shl    $0x4,%eax
  80207c:	05 60 40 80 00       	add    $0x804060,%eax
  802081:	8b 00                	mov    (%eax),%eax
  802083:	89 45 bc             	mov    %eax,-0x44(%ebp)
	LIST_REMOVE(&freeBlockLists[level],ret);
  802086:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
  80208a:	75 14                	jne    8020a0 <alloc_block+0x412>
  80208c:	83 ec 04             	sub    $0x4,%esp
  80208f:	68 63 31 80 00       	push   $0x803163
  802094:	6a 73                	push   $0x73
  802096:	68 4b 31 80 00       	push   $0x80314b
  80209b:	e8 0f 04 00 00       	call   8024af <_panic>
  8020a0:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8020a3:	8b 40 02             	mov    0x2(%eax),%eax
  8020a6:	85 c0                	test   %eax,%eax
  8020a8:	74 11                	je     8020bb <alloc_block+0x42d>
  8020aa:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8020ad:	8b 40 02             	mov    0x2(%eax),%eax
  8020b0:	8b 55 bc             	mov    -0x44(%ebp),%edx
  8020b3:	8b 52 06             	mov    0x6(%edx),%edx
  8020b6:	89 50 06             	mov    %edx,0x6(%eax)
  8020b9:	eb 14                	jmp    8020cf <alloc_block+0x441>
  8020bb:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8020be:	8b 40 06             	mov    0x6(%eax),%eax
  8020c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8020c4:	c1 e2 04             	shl    $0x4,%edx
  8020c7:	81 c2 64 40 80 00    	add    $0x804064,%edx
  8020cd:	89 02                	mov    %eax,(%edx)
  8020cf:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8020d2:	8b 40 06             	mov    0x6(%eax),%eax
  8020d5:	85 c0                	test   %eax,%eax
  8020d7:	74 11                	je     8020ea <alloc_block+0x45c>
  8020d9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8020dc:	8b 40 06             	mov    0x6(%eax),%eax
  8020df:	8b 55 bc             	mov    -0x44(%ebp),%edx
  8020e2:	8b 52 02             	mov    0x2(%edx),%edx
  8020e5:	89 50 02             	mov    %edx,0x2(%eax)
  8020e8:	eb 14                	jmp    8020fe <alloc_block+0x470>
  8020ea:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8020ed:	8b 40 02             	mov    0x2(%eax),%eax
  8020f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8020f3:	c1 e2 04             	shl    $0x4,%edx
  8020f6:	81 c2 60 40 80 00    	add    $0x804060,%edx
  8020fc:	89 02                	mov    %eax,(%edx)
  8020fe:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802101:	c7 40 02 00 00 00 00 	movl   $0x0,0x2(%eax)
  802108:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80210b:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  802112:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802115:	c1 e0 04             	shl    $0x4,%eax
  802118:	05 6c 40 80 00       	add    $0x80406c,%eax
  80211d:	8b 00                	mov    (%eax),%eax
  80211f:	8d 50 ff             	lea    -0x1(%eax),%edx
  802122:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802125:	c1 e0 04             	shl    $0x4,%eax
  802128:	05 6c 40 80 00       	add    $0x80406c,%eax
  80212d:	89 10                	mov    %edx,(%eax)
	ret -> is_free=0;
  80212f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802132:	c6 40 01 00          	movb   $0x0,0x1(%eax)
	void *ret_adress= (void *)((uint32) ret+META_DATA_SIZE);
  802136:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802139:	83 c0 0a             	add    $0xa,%eax
  80213c:	89 45 b8             	mov    %eax,-0x48(%ebp)
	return ret_adress;
  80213f:	8b 45 b8             	mov    -0x48(%ebp),%eax
}
  802142:	c9                   	leave  
  802143:	c3                   	ret    

00802144 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  802144:	55                   	push   %ebp
  802145:	89 e5                	mov    %esp,%ebp
  802147:	83 ec 28             	sub    $0x28,%esp
	uint32 curAddress = (uint32) va - META_DATA_SIZE;
  80214a:	8b 45 08             	mov    0x8(%ebp),%eax
  80214d:	83 e8 0a             	sub    $0xa,%eax
  802150:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct BlockMetaData *cur = (struct BlockMetaData *)curAddress;
  802153:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802156:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cur->is_free = 1;
  802159:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80215c:	c6 40 01 01          	movb   $0x1,0x1(%eax)

	while(cur->level <= BUDDY_UPPER_LEVEL){
  802160:	e9 1a 01 00 00       	jmp    80227f <free_block+0x13b>
		void *tva = (void *)(curAddress + META_DATA_SIZE);
  802165:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802168:	83 c0 0a             	add    $0xa,%eax
  80216b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		uint32 buddyAddress = curAddress ^ get_block_size(tva);
  80216e:	ff 75 ec             	pushl  -0x14(%ebp)
  802171:	e8 e8 fa ff ff       	call   801c5e <get_block_size>
  802176:	83 c4 04             	add    $0x4,%esp
  802179:	33 45 f4             	xor    -0xc(%ebp),%eax
  80217c:	89 45 e8             	mov    %eax,-0x18(%ebp)
		struct BlockMetaData *buddy = (struct BlockMetaData *)buddyAddress;
  80217f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802182:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if(buddy->is_free == 1 && buddy->level == cur->level){
  802185:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802188:	8a 40 01             	mov    0x1(%eax),%al
  80218b:	3c 01                	cmp    $0x1,%al
  80218d:	0f 85 f9 00 00 00    	jne    80228c <free_block+0x148>
  802193:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802196:	8a 10                	mov    (%eax),%dl
  802198:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80219b:	8a 00                	mov    (%eax),%al
  80219d:	38 c2                	cmp    %al,%dl
  80219f:	0f 85 e7 00 00 00    	jne    80228c <free_block+0x148>
			if(buddyAddress<curAddress) curAddress = buddyAddress;
  8021a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8021a8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8021ab:	73 06                	jae    8021b3 <free_block+0x6f>
  8021ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8021b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
			LIST_REMOVE(&freeBlockLists[buddy->level], buddy);
  8021b3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8021b7:	75 17                	jne    8021d0 <free_block+0x8c>
  8021b9:	83 ec 04             	sub    $0x4,%esp
  8021bc:	68 63 31 80 00       	push   $0x803163
  8021c1:	68 88 00 00 00       	push   $0x88
  8021c6:	68 4b 31 80 00       	push   $0x80314b
  8021cb:	e8 df 02 00 00       	call   8024af <_panic>
  8021d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8021d3:	8b 40 02             	mov    0x2(%eax),%eax
  8021d6:	85 c0                	test   %eax,%eax
  8021d8:	74 11                	je     8021eb <free_block+0xa7>
  8021da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8021dd:	8b 40 02             	mov    0x2(%eax),%eax
  8021e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8021e3:	8b 52 06             	mov    0x6(%edx),%edx
  8021e6:	89 50 06             	mov    %edx,0x6(%eax)
  8021e9:	eb 19                	jmp    802204 <free_block+0xc0>
  8021eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8021ee:	8a 00                	mov    (%eax),%al
  8021f0:	0f b6 d0             	movzbl %al,%edx
  8021f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8021f6:	8b 40 06             	mov    0x6(%eax),%eax
  8021f9:	c1 e2 04             	shl    $0x4,%edx
  8021fc:	81 c2 64 40 80 00    	add    $0x804064,%edx
  802202:	89 02                	mov    %eax,(%edx)
  802204:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802207:	8b 40 06             	mov    0x6(%eax),%eax
  80220a:	85 c0                	test   %eax,%eax
  80220c:	74 11                	je     80221f <free_block+0xdb>
  80220e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802211:	8b 40 06             	mov    0x6(%eax),%eax
  802214:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802217:	8b 52 02             	mov    0x2(%edx),%edx
  80221a:	89 50 02             	mov    %edx,0x2(%eax)
  80221d:	eb 19                	jmp    802238 <free_block+0xf4>
  80221f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802222:	8a 00                	mov    (%eax),%al
  802224:	0f b6 d0             	movzbl %al,%edx
  802227:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80222a:	8b 40 02             	mov    0x2(%eax),%eax
  80222d:	c1 e2 04             	shl    $0x4,%edx
  802230:	81 c2 60 40 80 00    	add    $0x804060,%edx
  802236:	89 02                	mov    %eax,(%edx)
  802238:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80223b:	c7 40 02 00 00 00 00 	movl   $0x0,0x2(%eax)
  802242:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802245:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  80224c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80224f:	8a 00                	mov    (%eax),%al
  802251:	0f b6 c0             	movzbl %al,%eax
  802254:	89 c2                	mov    %eax,%edx
  802256:	c1 e2 04             	shl    $0x4,%edx
  802259:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  80225f:	8b 12                	mov    (%edx),%edx
  802261:	4a                   	dec    %edx
  802262:	c1 e0 04             	shl    $0x4,%eax
  802265:	05 6c 40 80 00       	add    $0x80406c,%eax
  80226a:	89 10                	mov    %edx,(%eax)
			cur = (struct BlockMetaData *)curAddress;
  80226c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80226f:	89 45 f0             	mov    %eax,-0x10(%ebp)
			cur->level = buddy->level+1;
  802272:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802275:	8a 00                	mov    (%eax),%al
  802277:	8d 50 01             	lea    0x1(%eax),%edx
  80227a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80227d:	88 10                	mov    %dl,(%eax)
{
	uint32 curAddress = (uint32) va - META_DATA_SIZE;
	struct BlockMetaData *cur = (struct BlockMetaData *)curAddress;
	cur->is_free = 1;

	while(cur->level <= BUDDY_UPPER_LEVEL){
  80227f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802282:	8a 00                	mov    (%eax),%al
  802284:	3c 0b                	cmp    $0xb,%al
  802286:	0f 86 d9 fe ff ff    	jbe    802165 <free_block+0x21>
			cur = (struct BlockMetaData *)curAddress;
			cur->level = buddy->level+1;
		}
		else break;
	}
	if(cur->level > BUDDY_UPPER_LEVEL){
  80228c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80228f:	8a 00                	mov    (%eax),%al
  802291:	3c 0b                	cmp    $0xb,%al
  802293:	76 1c                	jbe    8022b1 <free_block+0x16d>
		void *tva = (void *)(curAddress + META_DATA_SIZE);
  802295:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802298:	83 c0 0a             	add    $0xa,%eax
  80229b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		delete_buddy_space(tva);
  80229e:	83 ec 0c             	sub    $0xc,%esp
  8022a1:	ff 75 e0             	pushl  -0x20(%ebp)
  8022a4:	e8 e9 f2 ff ff       	call   801592 <delete_buddy_space>
  8022a9:	83 c4 10             	add    $0x10,%esp
	}
	else LIST_INSERT_HEAD(&freeBlockLists[cur->level], cur);
}
  8022ac:	e9 af 00 00 00       	jmp    802360 <free_block+0x21c>
	}
	if(cur->level > BUDDY_UPPER_LEVEL){
		void *tva = (void *)(curAddress + META_DATA_SIZE);
		delete_buddy_space(tva);
	}
	else LIST_INSERT_HEAD(&freeBlockLists[cur->level], cur);
  8022b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8022b5:	75 17                	jne    8022ce <free_block+0x18a>
  8022b7:	83 ec 04             	sub    $0x4,%esp
  8022ba:	68 28 31 80 00       	push   $0x803128
  8022bf:	68 92 00 00 00       	push   $0x92
  8022c4:	68 4b 31 80 00       	push   $0x80314b
  8022c9:	e8 e1 01 00 00       	call   8024af <_panic>
  8022ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8022d1:	8a 00                	mov    (%eax),%al
  8022d3:	0f b6 c0             	movzbl %al,%eax
  8022d6:	c1 e0 04             	shl    $0x4,%eax
  8022d9:	05 60 40 80 00       	add    $0x804060,%eax
  8022de:	8b 10                	mov    (%eax),%edx
  8022e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8022e3:	89 50 02             	mov    %edx,0x2(%eax)
  8022e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8022e9:	8b 40 02             	mov    0x2(%eax),%eax
  8022ec:	85 c0                	test   %eax,%eax
  8022ee:	74 1a                	je     80230a <free_block+0x1c6>
  8022f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8022f3:	8a 00                	mov    (%eax),%al
  8022f5:	0f b6 c0             	movzbl %al,%eax
  8022f8:	c1 e0 04             	shl    $0x4,%eax
  8022fb:	05 60 40 80 00       	add    $0x804060,%eax
  802300:	8b 00                	mov    (%eax),%eax
  802302:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802305:	89 50 06             	mov    %edx,0x6(%eax)
  802308:	eb 16                	jmp    802320 <free_block+0x1dc>
  80230a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80230d:	8a 00                	mov    (%eax),%al
  80230f:	0f b6 c0             	movzbl %al,%eax
  802312:	c1 e0 04             	shl    $0x4,%eax
  802315:	8d 90 64 40 80 00    	lea    0x804064(%eax),%edx
  80231b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80231e:	89 02                	mov    %eax,(%edx)
  802320:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802323:	8a 00                	mov    (%eax),%al
  802325:	0f b6 c0             	movzbl %al,%eax
  802328:	c1 e0 04             	shl    $0x4,%eax
  80232b:	8d 90 60 40 80 00    	lea    0x804060(%eax),%edx
  802331:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802334:	89 02                	mov    %eax,(%edx)
  802336:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802339:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  802340:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802343:	8a 00                	mov    (%eax),%al
  802345:	0f b6 c0             	movzbl %al,%eax
  802348:	89 c2                	mov    %eax,%edx
  80234a:	c1 e2 04             	shl    $0x4,%edx
  80234d:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  802353:	8b 12                	mov    (%edx),%edx
  802355:	42                   	inc    %edx
  802356:	c1 e0 04             	shl    $0x4,%eax
  802359:	05 6c 40 80 00       	add    $0x80406c,%eax
  80235e:	89 10                	mov    %edx,(%eax)
}
  802360:	90                   	nop
  802361:	c9                   	leave  
  802362:	c3                   	ret    

00802363 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  802363:	55                   	push   %ebp
  802364:	89 e5                	mov    %esp,%ebp
  802366:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  802369:	83 ec 04             	sub    $0x4,%esp
  80236c:	68 84 31 80 00       	push   $0x803184
  802371:	68 a1 00 00 00       	push   $0xa1
  802376:	68 4b 31 80 00       	push   $0x80314b
  80237b:	e8 2f 01 00 00       	call   8024af <_panic>

00802380 <create_semaphore>:
// User-level Semaphore

#include "inc/lib.h"

struct semaphore create_semaphore(char *semaphoreName, uint32 value)
{
  802380:	55                   	push   %ebp
  802381:	89 e5                	mov    %esp,%ebp
  802383:	83 ec 08             	sub    $0x8,%esp
	panic("create_semaphore() is not implemented yet...!!");
  802386:	83 ec 04             	sub    $0x4,%esp
  802389:	68 a8 31 80 00       	push   $0x8031a8
  80238e:	6a 07                	push   $0x7
  802390:	68 d7 31 80 00       	push   $0x8031d7
  802395:	e8 15 01 00 00       	call   8024af <_panic>

0080239a <get_semaphore>:
}
struct semaphore get_semaphore(int32 ownerEnvID, char* semaphoreName)
{
  80239a:	55                   	push   %ebp
  80239b:	89 e5                	mov    %esp,%ebp
  80239d:	83 ec 08             	sub    $0x8,%esp
	panic("get_semaphore() is not implemented yet...!!");
  8023a0:	83 ec 04             	sub    $0x4,%esp
  8023a3:	68 e8 31 80 00       	push   $0x8031e8
  8023a8:	6a 0b                	push   $0xb
  8023aa:	68 d7 31 80 00       	push   $0x8031d7
  8023af:	e8 fb 00 00 00       	call   8024af <_panic>

008023b4 <wait_semaphore>:
}

void wait_semaphore(struct semaphore sem)
{
  8023b4:	55                   	push   %ebp
  8023b5:	89 e5                	mov    %esp,%ebp
  8023b7:	83 ec 08             	sub    $0x8,%esp
	panic("wait_semaphore() is not implemented yet...!!");
  8023ba:	83 ec 04             	sub    $0x4,%esp
  8023bd:	68 14 32 80 00       	push   $0x803214
  8023c2:	6a 10                	push   $0x10
  8023c4:	68 d7 31 80 00       	push   $0x8031d7
  8023c9:	e8 e1 00 00 00       	call   8024af <_panic>

008023ce <signal_semaphore>:
}

void signal_semaphore(struct semaphore sem)
{
  8023ce:	55                   	push   %ebp
  8023cf:	89 e5                	mov    %esp,%ebp
  8023d1:	83 ec 08             	sub    $0x8,%esp
	panic("signal_semaphore() is not implemented yet...!!");
  8023d4:	83 ec 04             	sub    $0x4,%esp
  8023d7:	68 44 32 80 00       	push   $0x803244
  8023dc:	6a 15                	push   $0x15
  8023de:	68 d7 31 80 00       	push   $0x8031d7
  8023e3:	e8 c7 00 00 00       	call   8024af <_panic>

008023e8 <semaphore_count>:
}

int semaphore_count(struct semaphore sem)
{
  8023e8:	55                   	push   %ebp
  8023e9:	89 e5                	mov    %esp,%ebp
	return sem.semdata->count;
  8023eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ee:	8b 40 10             	mov    0x10(%eax),%eax
}
  8023f1:	5d                   	pop    %ebp
  8023f2:	c3                   	ret    

008023f3 <init_uspinlock>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.ALL] PROTECTION - [0] GIVEN USER SPIN LOCK

void init_uspinlock(struct uspinlock *lk, char *name, bool isOpened)
{
  8023f3:	55                   	push   %ebp
  8023f4:	89 e5                	mov    %esp,%ebp
  8023f6:	83 ec 08             	sub    $0x8,%esp
	assert(isOpened == 0 || isOpened == 1);
  8023f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8023fd:	74 1c                	je     80241b <init_uspinlock+0x28>
  8023ff:	83 7d 10 01          	cmpl   $0x1,0x10(%ebp)
  802403:	74 16                	je     80241b <init_uspinlock+0x28>
  802405:	68 74 32 80 00       	push   $0x803274
  80240a:	68 93 32 80 00       	push   $0x803293
  80240f:	6a 15                	push   $0x15
  802411:	68 a8 32 80 00       	push   $0x8032a8
  802416:	e8 94 00 00 00       	call   8024af <_panic>
	strcpy(lk->name, name);
  80241b:	8b 45 08             	mov    0x8(%ebp),%eax
  80241e:	83 c0 04             	add    $0x4,%eax
  802421:	83 ec 08             	sub    $0x8,%esp
  802424:	ff 75 0c             	pushl  0xc(%ebp)
  802427:	50                   	push   %eax
  802428:	e8 4f e9 ff ff       	call   800d7c <strcpy>
  80242d:	83 c4 10             	add    $0x10,%esp
	lk->locked = (1 - isOpened);
  802430:	b8 01 00 00 00       	mov    $0x1,%eax
  802435:	2b 45 10             	sub    0x10(%ebp),%eax
  802438:	89 c2                	mov    %eax,%edx
  80243a:	8b 45 08             	mov    0x8(%ebp),%eax
  80243d:	89 10                	mov    %edx,(%eax)
}
  80243f:	90                   	nop
  802440:	c9                   	leave  
  802441:	c3                   	ret    

00802442 <acquire_uspinlock>:
// Acquire the lock.
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void acquire_uspinlock(struct uspinlock *lk)
{
  802442:	55                   	push   %ebp
  802443:	89 e5                	mov    %esp,%ebp
  802445:	83 ec 10             	sub    $0x10,%esp
	// The xchg is atomic.
	while(xchg(&lk->locked, 1) != 0) ;
  802448:	90                   	nop
  802449:	8b 45 08             	mov    0x8(%ebp),%eax
  80244c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  80244f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%ebp)
xchg(volatile uint32 *addr, uint32 newval)
{
  uint32 result;

  // The + in "+m" denotes a read-modify-write operand.
  __asm __volatile("lock; xchgl %0, %1" :
  802456:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802459:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80245c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80245f:	f0 87 02             	lock xchg %eax,(%edx)
  802462:	89 45 f4             	mov    %eax,-0xc(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
  802465:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802468:	85 c0                	test   %eax,%eax
  80246a:	75 dd                	jne    802449 <acquire_uspinlock+0x7>
	//cprintf("[%d: %s] ACQUIRED spinlock [%s]\n", myEnv->env_id, myEnv->prog_name, lk->name);

	// Tell the C compiler and the processor to not move loads or stores
	// past this point, to ensure that the critical section's memory
	// references happen after the lock is acquired.
	__sync_synchronize();
  80246c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
}
  802471:	90                   	nop
  802472:	c9                   	leave  
  802473:	c3                   	ret    

00802474 <release_uspinlock>:

// Release the lock.
void release_uspinlock(struct uspinlock *lk)
{
  802474:	55                   	push   %ebp
  802475:	89 e5                	mov    %esp,%ebp
  802477:	83 ec 08             	sub    $0x8,%esp
	if(!(lk->locked))
  80247a:	8b 45 08             	mov    0x8(%ebp),%eax
  80247d:	8b 00                	mov    (%eax),%eax
  80247f:	85 c0                	test   %eax,%eax
  802481:	75 18                	jne    80249b <release_uspinlock+0x27>
	{
		panic("release: lock \"%s\" is not held!", lk->name);
  802483:	8b 45 08             	mov    0x8(%ebp),%eax
  802486:	83 c0 04             	add    $0x4,%eax
  802489:	50                   	push   %eax
  80248a:	68 b8 32 80 00       	push   $0x8032b8
  80248f:	6a 30                	push   $0x30
  802491:	68 a8 32 80 00       	push   $0x8032a8
  802496:	e8 14 00 00 00       	call   8024af <_panic>
	// Tell the C compiler and the processor to not move loads or stores
	// past this point, to ensure that all the stores in the critical
	// section are visible to other cores before the lock is released.
	// Both the C compiler and the hardware may re-order loads and
	// stores; __sync_synchronize() tells them both not to.
	__sync_synchronize();
  80249b:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

	// Release the lock, equivalent to lk->locked = 0.
	// This code can't use a C assignment, since it might
	// not be atomic. A real OS would use C atomics here.
	asm volatile("movl $0, %0" : "+m" (lk->locked) : );
  8024a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8024a3:	8b 55 08             	mov    0x8(%ebp),%edx
  8024a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	//cprintf("[%d: %s] RELEASED spinlock [%s]\n", myEnv->env_id, myEnv->prog_name, lk->name);
}
  8024ac:	90                   	nop
  8024ad:	c9                   	leave  
  8024ae:	c3                   	ret    

008024af <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8024af:	55                   	push   %ebp
  8024b0:	89 e5                	mov    %esp,%ebp
  8024b2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8024b5:	8d 45 10             	lea    0x10(%ebp),%eax
  8024b8:	83 c0 04             	add    $0x4,%eax
  8024bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8024be:	a1 2c 41 80 00       	mov    0x80412c,%eax
  8024c3:	85 c0                	test   %eax,%eax
  8024c5:	74 16                	je     8024dd <_panic+0x2e>
		cprintf("%s: ", argv0);
  8024c7:	a1 2c 41 80 00       	mov    0x80412c,%eax
  8024cc:	83 ec 08             	sub    $0x8,%esp
  8024cf:	50                   	push   %eax
  8024d0:	68 d8 32 80 00       	push   $0x8032d8
  8024d5:	e8 7a e1 ff ff       	call   800654 <cprintf>
  8024da:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8024dd:	a1 04 40 80 00       	mov    0x804004,%eax
  8024e2:	83 ec 0c             	sub    $0xc,%esp
  8024e5:	ff 75 0c             	pushl  0xc(%ebp)
  8024e8:	ff 75 08             	pushl  0x8(%ebp)
  8024eb:	50                   	push   %eax
  8024ec:	68 e0 32 80 00       	push   $0x8032e0
  8024f1:	6a 74                	push   $0x74
  8024f3:	e8 89 e1 ff ff       	call   800681 <cprintf_colored>
  8024f8:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8024fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8024fe:	83 ec 08             	sub    $0x8,%esp
  802501:	ff 75 f4             	pushl  -0xc(%ebp)
  802504:	50                   	push   %eax
  802505:	e8 db e0 ff ff       	call   8005e5 <vcprintf>
  80250a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80250d:	83 ec 08             	sub    $0x8,%esp
  802510:	6a 00                	push   $0x0
  802512:	68 08 33 80 00       	push   $0x803308
  802517:	e8 c9 e0 ff ff       	call   8005e5 <vcprintf>
  80251c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80251f:	e8 42 e0 ff ff       	call   800566 <exit>

	// should not return here
	while (1) ;
  802524:	eb fe                	jmp    802524 <_panic+0x75>

00802526 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  802526:	55                   	push   %ebp
  802527:	89 e5                	mov    %esp,%ebp
  802529:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80252c:	a1 20 40 80 00       	mov    0x804020,%eax
  802531:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802537:	8b 45 0c             	mov    0xc(%ebp),%eax
  80253a:	39 c2                	cmp    %eax,%edx
  80253c:	74 14                	je     802552 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80253e:	83 ec 04             	sub    $0x4,%esp
  802541:	68 0c 33 80 00       	push   $0x80330c
  802546:	6a 26                	push   $0x26
  802548:	68 58 33 80 00       	push   $0x803358
  80254d:	e8 5d ff ff ff       	call   8024af <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  802552:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  802559:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802560:	e9 c5 00 00 00       	jmp    80262a <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  802565:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802568:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80256f:	8b 45 08             	mov    0x8(%ebp),%eax
  802572:	01 d0                	add    %edx,%eax
  802574:	8b 00                	mov    (%eax),%eax
  802576:	85 c0                	test   %eax,%eax
  802578:	75 08                	jne    802582 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  80257a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80257d:	e9 a5 00 00 00       	jmp    802627 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  802582:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802589:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  802590:	eb 69                	jmp    8025fb <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  802592:	a1 20 40 80 00       	mov    0x804020,%eax
  802597:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  80259d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8025a0:	89 d0                	mov    %edx,%eax
  8025a2:	01 c0                	add    %eax,%eax
  8025a4:	01 d0                	add    %edx,%eax
  8025a6:	c1 e0 03             	shl    $0x3,%eax
  8025a9:	01 c8                	add    %ecx,%eax
  8025ab:	8a 40 04             	mov    0x4(%eax),%al
  8025ae:	84 c0                	test   %al,%al
  8025b0:	75 46                	jne    8025f8 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8025b2:	a1 20 40 80 00       	mov    0x804020,%eax
  8025b7:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  8025bd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8025c0:	89 d0                	mov    %edx,%eax
  8025c2:	01 c0                	add    %eax,%eax
  8025c4:	01 d0                	add    %edx,%eax
  8025c6:	c1 e0 03             	shl    $0x3,%eax
  8025c9:	01 c8                	add    %ecx,%eax
  8025cb:	8b 00                	mov    (%eax),%eax
  8025cd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8025d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8025d3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8025d8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8025da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8025dd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8025e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8025e7:	01 c8                	add    %ecx,%eax
  8025e9:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8025eb:	39 c2                	cmp    %eax,%edx
  8025ed:	75 09                	jne    8025f8 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8025ef:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8025f6:	eb 15                	jmp    80260d <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8025f8:	ff 45 e8             	incl   -0x18(%ebp)
  8025fb:	a1 20 40 80 00       	mov    0x804020,%eax
  802600:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802606:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802609:	39 c2                	cmp    %eax,%edx
  80260b:	77 85                	ja     802592 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80260d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  802611:	75 14                	jne    802627 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  802613:	83 ec 04             	sub    $0x4,%esp
  802616:	68 64 33 80 00       	push   $0x803364
  80261b:	6a 3a                	push   $0x3a
  80261d:	68 58 33 80 00       	push   $0x803358
  802622:	e8 88 fe ff ff       	call   8024af <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  802627:	ff 45 f0             	incl   -0x10(%ebp)
  80262a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80262d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  802630:	0f 8c 2f ff ff ff    	jl     802565 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  802636:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80263d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  802644:	eb 26                	jmp    80266c <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  802646:	a1 20 40 80 00       	mov    0x804020,%eax
  80264b:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  802651:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802654:	89 d0                	mov    %edx,%eax
  802656:	01 c0                	add    %eax,%eax
  802658:	01 d0                	add    %edx,%eax
  80265a:	c1 e0 03             	shl    $0x3,%eax
  80265d:	01 c8                	add    %ecx,%eax
  80265f:	8a 40 04             	mov    0x4(%eax),%al
  802662:	3c 01                	cmp    $0x1,%al
  802664:	75 03                	jne    802669 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  802666:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802669:	ff 45 e0             	incl   -0x20(%ebp)
  80266c:	a1 20 40 80 00       	mov    0x804020,%eax
  802671:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802677:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80267a:	39 c2                	cmp    %eax,%edx
  80267c:	77 c8                	ja     802646 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80267e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802681:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802684:	74 14                	je     80269a <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  802686:	83 ec 04             	sub    $0x4,%esp
  802689:	68 b8 33 80 00       	push   $0x8033b8
  80268e:	6a 44                	push   $0x44
  802690:	68 58 33 80 00       	push   $0x803358
  802695:	e8 15 fe ff ff       	call   8024af <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80269a:	90                   	nop
  80269b:	c9                   	leave  
  80269c:	c3                   	ret    
  80269d:	66 90                	xchg   %ax,%ax
  80269f:	90                   	nop

008026a0 <__udivdi3>:
  8026a0:	55                   	push   %ebp
  8026a1:	57                   	push   %edi
  8026a2:	56                   	push   %esi
  8026a3:	53                   	push   %ebx
  8026a4:	83 ec 1c             	sub    $0x1c,%esp
  8026a7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8026ab:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8026af:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026b3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8026b7:	89 ca                	mov    %ecx,%edx
  8026b9:	89 f8                	mov    %edi,%eax
  8026bb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8026bf:	85 f6                	test   %esi,%esi
  8026c1:	75 2d                	jne    8026f0 <__udivdi3+0x50>
  8026c3:	39 cf                	cmp    %ecx,%edi
  8026c5:	77 65                	ja     80272c <__udivdi3+0x8c>
  8026c7:	89 fd                	mov    %edi,%ebp
  8026c9:	85 ff                	test   %edi,%edi
  8026cb:	75 0b                	jne    8026d8 <__udivdi3+0x38>
  8026cd:	b8 01 00 00 00       	mov    $0x1,%eax
  8026d2:	31 d2                	xor    %edx,%edx
  8026d4:	f7 f7                	div    %edi
  8026d6:	89 c5                	mov    %eax,%ebp
  8026d8:	31 d2                	xor    %edx,%edx
  8026da:	89 c8                	mov    %ecx,%eax
  8026dc:	f7 f5                	div    %ebp
  8026de:	89 c1                	mov    %eax,%ecx
  8026e0:	89 d8                	mov    %ebx,%eax
  8026e2:	f7 f5                	div    %ebp
  8026e4:	89 cf                	mov    %ecx,%edi
  8026e6:	89 fa                	mov    %edi,%edx
  8026e8:	83 c4 1c             	add    $0x1c,%esp
  8026eb:	5b                   	pop    %ebx
  8026ec:	5e                   	pop    %esi
  8026ed:	5f                   	pop    %edi
  8026ee:	5d                   	pop    %ebp
  8026ef:	c3                   	ret    
  8026f0:	39 ce                	cmp    %ecx,%esi
  8026f2:	77 28                	ja     80271c <__udivdi3+0x7c>
  8026f4:	0f bd fe             	bsr    %esi,%edi
  8026f7:	83 f7 1f             	xor    $0x1f,%edi
  8026fa:	75 40                	jne    80273c <__udivdi3+0x9c>
  8026fc:	39 ce                	cmp    %ecx,%esi
  8026fe:	72 0a                	jb     80270a <__udivdi3+0x6a>
  802700:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802704:	0f 87 9e 00 00 00    	ja     8027a8 <__udivdi3+0x108>
  80270a:	b8 01 00 00 00       	mov    $0x1,%eax
  80270f:	89 fa                	mov    %edi,%edx
  802711:	83 c4 1c             	add    $0x1c,%esp
  802714:	5b                   	pop    %ebx
  802715:	5e                   	pop    %esi
  802716:	5f                   	pop    %edi
  802717:	5d                   	pop    %ebp
  802718:	c3                   	ret    
  802719:	8d 76 00             	lea    0x0(%esi),%esi
  80271c:	31 ff                	xor    %edi,%edi
  80271e:	31 c0                	xor    %eax,%eax
  802720:	89 fa                	mov    %edi,%edx
  802722:	83 c4 1c             	add    $0x1c,%esp
  802725:	5b                   	pop    %ebx
  802726:	5e                   	pop    %esi
  802727:	5f                   	pop    %edi
  802728:	5d                   	pop    %ebp
  802729:	c3                   	ret    
  80272a:	66 90                	xchg   %ax,%ax
  80272c:	89 d8                	mov    %ebx,%eax
  80272e:	f7 f7                	div    %edi
  802730:	31 ff                	xor    %edi,%edi
  802732:	89 fa                	mov    %edi,%edx
  802734:	83 c4 1c             	add    $0x1c,%esp
  802737:	5b                   	pop    %ebx
  802738:	5e                   	pop    %esi
  802739:	5f                   	pop    %edi
  80273a:	5d                   	pop    %ebp
  80273b:	c3                   	ret    
  80273c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802741:	89 eb                	mov    %ebp,%ebx
  802743:	29 fb                	sub    %edi,%ebx
  802745:	89 f9                	mov    %edi,%ecx
  802747:	d3 e6                	shl    %cl,%esi
  802749:	89 c5                	mov    %eax,%ebp
  80274b:	88 d9                	mov    %bl,%cl
  80274d:	d3 ed                	shr    %cl,%ebp
  80274f:	89 e9                	mov    %ebp,%ecx
  802751:	09 f1                	or     %esi,%ecx
  802753:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802757:	89 f9                	mov    %edi,%ecx
  802759:	d3 e0                	shl    %cl,%eax
  80275b:	89 c5                	mov    %eax,%ebp
  80275d:	89 d6                	mov    %edx,%esi
  80275f:	88 d9                	mov    %bl,%cl
  802761:	d3 ee                	shr    %cl,%esi
  802763:	89 f9                	mov    %edi,%ecx
  802765:	d3 e2                	shl    %cl,%edx
  802767:	8b 44 24 08          	mov    0x8(%esp),%eax
  80276b:	88 d9                	mov    %bl,%cl
  80276d:	d3 e8                	shr    %cl,%eax
  80276f:	09 c2                	or     %eax,%edx
  802771:	89 d0                	mov    %edx,%eax
  802773:	89 f2                	mov    %esi,%edx
  802775:	f7 74 24 0c          	divl   0xc(%esp)
  802779:	89 d6                	mov    %edx,%esi
  80277b:	89 c3                	mov    %eax,%ebx
  80277d:	f7 e5                	mul    %ebp
  80277f:	39 d6                	cmp    %edx,%esi
  802781:	72 19                	jb     80279c <__udivdi3+0xfc>
  802783:	74 0b                	je     802790 <__udivdi3+0xf0>
  802785:	89 d8                	mov    %ebx,%eax
  802787:	31 ff                	xor    %edi,%edi
  802789:	e9 58 ff ff ff       	jmp    8026e6 <__udivdi3+0x46>
  80278e:	66 90                	xchg   %ax,%ax
  802790:	8b 54 24 08          	mov    0x8(%esp),%edx
  802794:	89 f9                	mov    %edi,%ecx
  802796:	d3 e2                	shl    %cl,%edx
  802798:	39 c2                	cmp    %eax,%edx
  80279a:	73 e9                	jae    802785 <__udivdi3+0xe5>
  80279c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80279f:	31 ff                	xor    %edi,%edi
  8027a1:	e9 40 ff ff ff       	jmp    8026e6 <__udivdi3+0x46>
  8027a6:	66 90                	xchg   %ax,%ax
  8027a8:	31 c0                	xor    %eax,%eax
  8027aa:	e9 37 ff ff ff       	jmp    8026e6 <__udivdi3+0x46>
  8027af:	90                   	nop

008027b0 <__umoddi3>:
  8027b0:	55                   	push   %ebp
  8027b1:	57                   	push   %edi
  8027b2:	56                   	push   %esi
  8027b3:	53                   	push   %ebx
  8027b4:	83 ec 1c             	sub    $0x1c,%esp
  8027b7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8027bb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8027bf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8027c3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8027c7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8027cb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8027cf:	89 f3                	mov    %esi,%ebx
  8027d1:	89 fa                	mov    %edi,%edx
  8027d3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027d7:	89 34 24             	mov    %esi,(%esp)
  8027da:	85 c0                	test   %eax,%eax
  8027dc:	75 1a                	jne    8027f8 <__umoddi3+0x48>
  8027de:	39 f7                	cmp    %esi,%edi
  8027e0:	0f 86 a2 00 00 00    	jbe    802888 <__umoddi3+0xd8>
  8027e6:	89 c8                	mov    %ecx,%eax
  8027e8:	89 f2                	mov    %esi,%edx
  8027ea:	f7 f7                	div    %edi
  8027ec:	89 d0                	mov    %edx,%eax
  8027ee:	31 d2                	xor    %edx,%edx
  8027f0:	83 c4 1c             	add    $0x1c,%esp
  8027f3:	5b                   	pop    %ebx
  8027f4:	5e                   	pop    %esi
  8027f5:	5f                   	pop    %edi
  8027f6:	5d                   	pop    %ebp
  8027f7:	c3                   	ret    
  8027f8:	39 f0                	cmp    %esi,%eax
  8027fa:	0f 87 ac 00 00 00    	ja     8028ac <__umoddi3+0xfc>
  802800:	0f bd e8             	bsr    %eax,%ebp
  802803:	83 f5 1f             	xor    $0x1f,%ebp
  802806:	0f 84 ac 00 00 00    	je     8028b8 <__umoddi3+0x108>
  80280c:	bf 20 00 00 00       	mov    $0x20,%edi
  802811:	29 ef                	sub    %ebp,%edi
  802813:	89 fe                	mov    %edi,%esi
  802815:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802819:	89 e9                	mov    %ebp,%ecx
  80281b:	d3 e0                	shl    %cl,%eax
  80281d:	89 d7                	mov    %edx,%edi
  80281f:	89 f1                	mov    %esi,%ecx
  802821:	d3 ef                	shr    %cl,%edi
  802823:	09 c7                	or     %eax,%edi
  802825:	89 e9                	mov    %ebp,%ecx
  802827:	d3 e2                	shl    %cl,%edx
  802829:	89 14 24             	mov    %edx,(%esp)
  80282c:	89 d8                	mov    %ebx,%eax
  80282e:	d3 e0                	shl    %cl,%eax
  802830:	89 c2                	mov    %eax,%edx
  802832:	8b 44 24 08          	mov    0x8(%esp),%eax
  802836:	d3 e0                	shl    %cl,%eax
  802838:	89 44 24 04          	mov    %eax,0x4(%esp)
  80283c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802840:	89 f1                	mov    %esi,%ecx
  802842:	d3 e8                	shr    %cl,%eax
  802844:	09 d0                	or     %edx,%eax
  802846:	d3 eb                	shr    %cl,%ebx
  802848:	89 da                	mov    %ebx,%edx
  80284a:	f7 f7                	div    %edi
  80284c:	89 d3                	mov    %edx,%ebx
  80284e:	f7 24 24             	mull   (%esp)
  802851:	89 c6                	mov    %eax,%esi
  802853:	89 d1                	mov    %edx,%ecx
  802855:	39 d3                	cmp    %edx,%ebx
  802857:	0f 82 87 00 00 00    	jb     8028e4 <__umoddi3+0x134>
  80285d:	0f 84 91 00 00 00    	je     8028f4 <__umoddi3+0x144>
  802863:	8b 54 24 04          	mov    0x4(%esp),%edx
  802867:	29 f2                	sub    %esi,%edx
  802869:	19 cb                	sbb    %ecx,%ebx
  80286b:	89 d8                	mov    %ebx,%eax
  80286d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802871:	d3 e0                	shl    %cl,%eax
  802873:	89 e9                	mov    %ebp,%ecx
  802875:	d3 ea                	shr    %cl,%edx
  802877:	09 d0                	or     %edx,%eax
  802879:	89 e9                	mov    %ebp,%ecx
  80287b:	d3 eb                	shr    %cl,%ebx
  80287d:	89 da                	mov    %ebx,%edx
  80287f:	83 c4 1c             	add    $0x1c,%esp
  802882:	5b                   	pop    %ebx
  802883:	5e                   	pop    %esi
  802884:	5f                   	pop    %edi
  802885:	5d                   	pop    %ebp
  802886:	c3                   	ret    
  802887:	90                   	nop
  802888:	89 fd                	mov    %edi,%ebp
  80288a:	85 ff                	test   %edi,%edi
  80288c:	75 0b                	jne    802899 <__umoddi3+0xe9>
  80288e:	b8 01 00 00 00       	mov    $0x1,%eax
  802893:	31 d2                	xor    %edx,%edx
  802895:	f7 f7                	div    %edi
  802897:	89 c5                	mov    %eax,%ebp
  802899:	89 f0                	mov    %esi,%eax
  80289b:	31 d2                	xor    %edx,%edx
  80289d:	f7 f5                	div    %ebp
  80289f:	89 c8                	mov    %ecx,%eax
  8028a1:	f7 f5                	div    %ebp
  8028a3:	89 d0                	mov    %edx,%eax
  8028a5:	e9 44 ff ff ff       	jmp    8027ee <__umoddi3+0x3e>
  8028aa:	66 90                	xchg   %ax,%ax
  8028ac:	89 c8                	mov    %ecx,%eax
  8028ae:	89 f2                	mov    %esi,%edx
  8028b0:	83 c4 1c             	add    $0x1c,%esp
  8028b3:	5b                   	pop    %ebx
  8028b4:	5e                   	pop    %esi
  8028b5:	5f                   	pop    %edi
  8028b6:	5d                   	pop    %ebp
  8028b7:	c3                   	ret    
  8028b8:	3b 04 24             	cmp    (%esp),%eax
  8028bb:	72 06                	jb     8028c3 <__umoddi3+0x113>
  8028bd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8028c1:	77 0f                	ja     8028d2 <__umoddi3+0x122>
  8028c3:	89 f2                	mov    %esi,%edx
  8028c5:	29 f9                	sub    %edi,%ecx
  8028c7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8028cb:	89 14 24             	mov    %edx,(%esp)
  8028ce:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8028d2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8028d6:	8b 14 24             	mov    (%esp),%edx
  8028d9:	83 c4 1c             	add    $0x1c,%esp
  8028dc:	5b                   	pop    %ebx
  8028dd:	5e                   	pop    %esi
  8028de:	5f                   	pop    %edi
  8028df:	5d                   	pop    %ebp
  8028e0:	c3                   	ret    
  8028e1:	8d 76 00             	lea    0x0(%esi),%esi
  8028e4:	2b 04 24             	sub    (%esp),%eax
  8028e7:	19 fa                	sbb    %edi,%edx
  8028e9:	89 d1                	mov    %edx,%ecx
  8028eb:	89 c6                	mov    %eax,%esi
  8028ed:	e9 71 ff ff ff       	jmp    802863 <__umoddi3+0xb3>
  8028f2:	66 90                	xchg   %ax,%ax
  8028f4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8028f8:	72 ea                	jb     8028e4 <__umoddi3+0x134>
  8028fa:	89 d9                	mov    %ebx,%ecx
  8028fc:	e9 62 ff ff ff       	jmp    802863 <__umoddi3+0xb3>
