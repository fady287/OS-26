
obj/user/matrix_operations:     file format elf32-i386


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
  800031:	e8 e4 09 00 00       	call   800a1a <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
int64** MatrixMultiply(int **M1, int **M2, int NumOfElements);
int64** MatrixAddition(int **M1, int **M2, int NumOfElements);
int64** MatrixSubtraction(int **M1, int **M2, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 24 01 00 00    	sub    $0x124,%esp
	char Line[255] ;
	char Chose ;
	int val =0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int NumOfElements = 3;
  800049:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
	do
	{
		val = 0;
  800050:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		NumOfElements = 3;
  800057:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
		//2012: lock the interrupt
		sys_lock_cons();
  80005e:	e8 7b 1f 00 00       	call   801fde <sys_lock_cons>
		cprintf("\n");
  800063:	83 ec 0c             	sub    $0xc,%esp
  800066:	68 e0 30 80 00       	push   $0x8030e0
  80006b:	e8 ea 0c 00 00       	call   800d5a <cprintf>
  800070:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
  800073:	83 ec 0c             	sub    $0xc,%esp
  800076:	68 e4 30 80 00       	push   $0x8030e4
  80007b:	e8 da 0c 00 00       	call   800d5a <cprintf>
  800080:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   MATRIX MULTIPLICATION    !!!\n");
  800083:	83 ec 0c             	sub    $0xc,%esp
  800086:	68 08 31 80 00       	push   $0x803108
  80008b:	e8 ca 0c 00 00       	call   800d5a <cprintf>
  800090:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	68 e4 30 80 00       	push   $0x8030e4
  80009b:	e8 ba 0c 00 00       	call   800d5a <cprintf>
  8000a0:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  8000a3:	83 ec 0c             	sub    $0xc,%esp
  8000a6:	68 e0 30 80 00       	push   $0x8030e0
  8000ab:	e8 aa 0c 00 00       	call   800d5a <cprintf>
  8000b0:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  8000b3:	83 ec 08             	sub    $0x8,%esp
  8000b6:	8d 85 d9 fe ff ff    	lea    -0x127(%ebp),%eax
  8000bc:	50                   	push   %eax
  8000bd:	68 2c 31 80 00       	push   $0x80312c
  8000c2:	e8 6c 13 00 00       	call   801433 <readline>
  8000c7:	83 c4 10             	add    $0x10,%esp
		NumOfElements = strtol(Line, NULL, 10) ;
  8000ca:	83 ec 04             	sub    $0x4,%esp
  8000cd:	6a 0a                	push   $0xa
  8000cf:	6a 00                	push   $0x0
  8000d1:	8d 85 d9 fe ff ff    	lea    -0x127(%ebp),%eax
  8000d7:	50                   	push   %eax
  8000d8:	e8 6d 19 00 00       	call   801a4a <strtol>
  8000dd:	83 c4 10             	add    $0x10,%esp
  8000e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		cprintf("Chose the initialization method:\n") ;
  8000e3:	83 ec 0c             	sub    $0xc,%esp
  8000e6:	68 4c 31 80 00       	push   $0x80314c
  8000eb:	e8 6a 0c 00 00       	call   800d5a <cprintf>
  8000f0:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000f3:	83 ec 0c             	sub    $0xc,%esp
  8000f6:	68 6e 31 80 00       	push   $0x80316e
  8000fb:	e8 5a 0c 00 00       	call   800d5a <cprintf>
  800100:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Identical\n") ;
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	68 7c 31 80 00       	push   $0x80317c
  80010b:	e8 4a 0c 00 00       	call   800d5a <cprintf>
  800110:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800113:	83 ec 0c             	sub    $0xc,%esp
  800116:	68 8a 31 80 00       	push   $0x80318a
  80011b:	e8 3a 0c 00 00       	call   800d5a <cprintf>
  800120:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800123:	83 ec 0c             	sub    $0xc,%esp
  800126:	68 9a 31 80 00       	push   $0x80319a
  80012b:	e8 2a 0c 00 00       	call   800d5a <cprintf>
  800130:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800133:	e8 bf 08 00 00       	call   8009f7 <getchar>
  800138:	88 45 e3             	mov    %al,-0x1d(%ebp)
			cputchar(Chose);
  80013b:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80013f:	83 ec 0c             	sub    $0xc,%esp
  800142:	50                   	push   %eax
  800143:	e8 90 08 00 00       	call   8009d8 <cputchar>
  800148:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80014b:	83 ec 0c             	sub    $0xc,%esp
  80014e:	6a 0a                	push   $0xa
  800150:	e8 83 08 00 00       	call   8009d8 <cputchar>
  800155:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800158:	80 7d e3 61          	cmpb   $0x61,-0x1d(%ebp)
  80015c:	74 0c                	je     80016a <_main+0x132>
  80015e:	80 7d e3 62          	cmpb   $0x62,-0x1d(%ebp)
  800162:	74 06                	je     80016a <_main+0x132>
  800164:	80 7d e3 63          	cmpb   $0x63,-0x1d(%ebp)
  800168:	75 b9                	jne    800123 <_main+0xeb>

		if (Chose == 'b')
  80016a:	80 7d e3 62          	cmpb   $0x62,-0x1d(%ebp)
  80016e:	75 30                	jne    8001a0 <_main+0x168>
		{
			readline("Enter the value to be initialized: ", Line);
  800170:	83 ec 08             	sub    $0x8,%esp
  800173:	8d 85 d9 fe ff ff    	lea    -0x127(%ebp),%eax
  800179:	50                   	push   %eax
  80017a:	68 a4 31 80 00       	push   $0x8031a4
  80017f:	e8 af 12 00 00       	call   801433 <readline>
  800184:	83 c4 10             	add    $0x10,%esp
			val = strtol(Line, NULL, 10) ;
  800187:	83 ec 04             	sub    $0x4,%esp
  80018a:	6a 0a                	push   $0xa
  80018c:	6a 00                	push   $0x0
  80018e:	8d 85 d9 fe ff ff    	lea    -0x127(%ebp),%eax
  800194:	50                   	push   %eax
  800195:	e8 b0 18 00 00       	call   801a4a <strtol>
  80019a:	83 c4 10             	add    $0x10,%esp
  80019d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		}
		//2012: lock the interrupt
		sys_unlock_cons();
  8001a0:	e8 53 1e 00 00       	call   801ff8 <sys_unlock_cons>

		int **M1 = malloc(sizeof(int) * NumOfElements) ;
  8001a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001a8:	c1 e0 02             	shl    $0x2,%eax
  8001ab:	83 ec 0c             	sub    $0xc,%esp
  8001ae:	50                   	push   %eax
  8001af:	e8 06 1d 00 00       	call   801eba <malloc>
  8001b4:	83 c4 10             	add    $0x10,%esp
  8001b7:	89 45 dc             	mov    %eax,-0x24(%ebp)
		int **M2 = malloc(sizeof(int) * NumOfElements) ;
  8001ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001bd:	c1 e0 02             	shl    $0x2,%eax
  8001c0:	83 ec 0c             	sub    $0xc,%esp
  8001c3:	50                   	push   %eax
  8001c4:	e8 f1 1c 00 00       	call   801eba <malloc>
  8001c9:	83 c4 10             	add    $0x10,%esp
  8001cc:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (int i = 0; i < NumOfElements; ++i)
  8001cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8001d6:	eb 4b                	jmp    800223 <_main+0x1eb>
		{
			M1[i] = malloc(sizeof(int) * NumOfElements) ;
  8001d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8001db:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001e2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001e5:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  8001e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001eb:	c1 e0 02             	shl    $0x2,%eax
  8001ee:	83 ec 0c             	sub    $0xc,%esp
  8001f1:	50                   	push   %eax
  8001f2:	e8 c3 1c 00 00       	call   801eba <malloc>
  8001f7:	83 c4 10             	add    $0x10,%esp
  8001fa:	89 03                	mov    %eax,(%ebx)
			M2[i] = malloc(sizeof(int) * NumOfElements) ;
  8001fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8001ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800206:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800209:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  80020c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80020f:	c1 e0 02             	shl    $0x2,%eax
  800212:	83 ec 0c             	sub    $0xc,%esp
  800215:	50                   	push   %eax
  800216:	e8 9f 1c 00 00       	call   801eba <malloc>
  80021b:	83 c4 10             	add    $0x10,%esp
  80021e:	89 03                	mov    %eax,(%ebx)
		sys_unlock_cons();

		int **M1 = malloc(sizeof(int) * NumOfElements) ;
		int **M2 = malloc(sizeof(int) * NumOfElements) ;

		for (int i = 0; i < NumOfElements; ++i)
  800220:	ff 45 f0             	incl   -0x10(%ebp)
  800223:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800226:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800229:	7c ad                	jl     8001d8 <_main+0x1a0>
			M1[i] = malloc(sizeof(int) * NumOfElements) ;
			M2[i] = malloc(sizeof(int) * NumOfElements) ;
		}

		int  i ;
		switch (Chose)
  80022b:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80022f:	83 f8 62             	cmp    $0x62,%eax
  800232:	74 2e                	je     800262 <_main+0x22a>
  800234:	83 f8 63             	cmp    $0x63,%eax
  800237:	74 53                	je     80028c <_main+0x254>
  800239:	83 f8 61             	cmp    $0x61,%eax
  80023c:	75 72                	jne    8002b0 <_main+0x278>
		{
		case 'a':
			InitializeAscending(M1, NumOfElements);
  80023e:	83 ec 08             	sub    $0x8,%esp
  800241:	ff 75 e4             	pushl  -0x1c(%ebp)
  800244:	ff 75 dc             	pushl  -0x24(%ebp)
  800247:	e8 9b 05 00 00       	call   8007e7 <InitializeAscending>
  80024c:	83 c4 10             	add    $0x10,%esp
			InitializeAscending(M2, NumOfElements);
  80024f:	83 ec 08             	sub    $0x8,%esp
  800252:	ff 75 e4             	pushl  -0x1c(%ebp)
  800255:	ff 75 d8             	pushl  -0x28(%ebp)
  800258:	e8 8a 05 00 00       	call   8007e7 <InitializeAscending>
  80025d:	83 c4 10             	add    $0x10,%esp
			break ;
  800260:	eb 70                	jmp    8002d2 <_main+0x29a>
		case 'b':
			InitializeIdentical(M1, NumOfElements, val);
  800262:	83 ec 04             	sub    $0x4,%esp
  800265:	ff 75 f4             	pushl  -0xc(%ebp)
  800268:	ff 75 e4             	pushl  -0x1c(%ebp)
  80026b:	ff 75 dc             	pushl  -0x24(%ebp)
  80026e:	e8 c3 05 00 00       	call   800836 <InitializeIdentical>
  800273:	83 c4 10             	add    $0x10,%esp
			InitializeIdentical(M2, NumOfElements, val);
  800276:	83 ec 04             	sub    $0x4,%esp
  800279:	ff 75 f4             	pushl  -0xc(%ebp)
  80027c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80027f:	ff 75 d8             	pushl  -0x28(%ebp)
  800282:	e8 af 05 00 00       	call   800836 <InitializeIdentical>
  800287:	83 c4 10             	add    $0x10,%esp
			break ;
  80028a:	eb 46                	jmp    8002d2 <_main+0x29a>
		case 'c':
			InitializeSemiRandom(M1, NumOfElements);
  80028c:	83 ec 08             	sub    $0x8,%esp
  80028f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800292:	ff 75 dc             	pushl  -0x24(%ebp)
  800295:	e8 eb 05 00 00       	call   800885 <InitializeSemiRandom>
  80029a:	83 c4 10             	add    $0x10,%esp
			InitializeSemiRandom(M2, NumOfElements);
  80029d:	83 ec 08             	sub    $0x8,%esp
  8002a0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002a3:	ff 75 d8             	pushl  -0x28(%ebp)
  8002a6:	e8 da 05 00 00       	call   800885 <InitializeSemiRandom>
  8002ab:	83 c4 10             	add    $0x10,%esp
			//PrintElements(M1, NumOfElements);
			break ;
  8002ae:	eb 22                	jmp    8002d2 <_main+0x29a>
		default:
			InitializeSemiRandom(M1, NumOfElements);
  8002b0:	83 ec 08             	sub    $0x8,%esp
  8002b3:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002b6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002b9:	e8 c7 05 00 00       	call   800885 <InitializeSemiRandom>
  8002be:	83 c4 10             	add    $0x10,%esp
			InitializeSemiRandom(M2, NumOfElements);
  8002c1:	83 ec 08             	sub    $0x8,%esp
  8002c4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002c7:	ff 75 d8             	pushl  -0x28(%ebp)
  8002ca:	e8 b6 05 00 00       	call   800885 <InitializeSemiRandom>
  8002cf:	83 c4 10             	add    $0x10,%esp
		}

		sys_lock_cons();
  8002d2:	e8 07 1d 00 00       	call   801fde <sys_lock_cons>
		cprintf("Chose the desired operation:\n") ;
  8002d7:	83 ec 0c             	sub    $0xc,%esp
  8002da:	68 c8 31 80 00       	push   $0x8031c8
  8002df:	e8 76 0a 00 00       	call   800d5a <cprintf>
  8002e4:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Addition       (+)\n") ;
  8002e7:	83 ec 0c             	sub    $0xc,%esp
  8002ea:	68 e6 31 80 00       	push   $0x8031e6
  8002ef:	e8 66 0a 00 00       	call   800d5a <cprintf>
  8002f4:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Subtraction    (-)\n") ;
  8002f7:	83 ec 0c             	sub    $0xc,%esp
  8002fa:	68 fd 31 80 00       	push   $0x8031fd
  8002ff:	e8 56 0a 00 00       	call   800d5a <cprintf>
  800304:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Multiplication (x)\n");
  800307:	83 ec 0c             	sub    $0xc,%esp
  80030a:	68 14 32 80 00       	push   $0x803214
  80030f:	e8 46 0a 00 00       	call   800d5a <cprintf>
  800314:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800317:	83 ec 0c             	sub    $0xc,%esp
  80031a:	68 9a 31 80 00       	push   $0x80319a
  80031f:	e8 36 0a 00 00       	call   800d5a <cprintf>
  800324:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800327:	e8 cb 06 00 00       	call   8009f7 <getchar>
  80032c:	88 45 e3             	mov    %al,-0x1d(%ebp)
			cputchar(Chose);
  80032f:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  800333:	83 ec 0c             	sub    $0xc,%esp
  800336:	50                   	push   %eax
  800337:	e8 9c 06 00 00       	call   8009d8 <cputchar>
  80033c:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80033f:	83 ec 0c             	sub    $0xc,%esp
  800342:	6a 0a                	push   $0xa
  800344:	e8 8f 06 00 00       	call   8009d8 <cputchar>
  800349:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80034c:	80 7d e3 61          	cmpb   $0x61,-0x1d(%ebp)
  800350:	74 0c                	je     80035e <_main+0x326>
  800352:	80 7d e3 62          	cmpb   $0x62,-0x1d(%ebp)
  800356:	74 06                	je     80035e <_main+0x326>
  800358:	80 7d e3 63          	cmpb   $0x63,-0x1d(%ebp)
  80035c:	75 b9                	jne    800317 <_main+0x2df>
		sys_unlock_cons();
  80035e:	e8 95 1c 00 00       	call   801ff8 <sys_unlock_cons>


		int64** Res = NULL ;
  800363:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		switch (Chose)
  80036a:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80036e:	83 f8 62             	cmp    $0x62,%eax
  800371:	74 23                	je     800396 <_main+0x35e>
  800373:	83 f8 63             	cmp    $0x63,%eax
  800376:	74 37                	je     8003af <_main+0x377>
  800378:	83 f8 61             	cmp    $0x61,%eax
  80037b:	75 4b                	jne    8003c8 <_main+0x390>
		{
		case 'a':
			Res = MatrixAddition(M1, M2, NumOfElements);
  80037d:	83 ec 04             	sub    $0x4,%esp
  800380:	ff 75 e4             	pushl  -0x1c(%ebp)
  800383:	ff 75 d8             	pushl  -0x28(%ebp)
  800386:	ff 75 dc             	pushl  -0x24(%ebp)
  800389:	e8 9f 02 00 00       	call   80062d <MatrixAddition>
  80038e:	83 c4 10             	add    $0x10,%esp
  800391:	89 45 ec             	mov    %eax,-0x14(%ebp)
			//PrintElements64(Res, NumOfElements);
			break ;
  800394:	eb 49                	jmp    8003df <_main+0x3a7>
		case 'b':
			Res = MatrixSubtraction(M1, M2, NumOfElements);
  800396:	83 ec 04             	sub    $0x4,%esp
  800399:	ff 75 e4             	pushl  -0x1c(%ebp)
  80039c:	ff 75 d8             	pushl  -0x28(%ebp)
  80039f:	ff 75 dc             	pushl  -0x24(%ebp)
  8003a2:	e8 62 03 00 00       	call   800709 <MatrixSubtraction>
  8003a7:	83 c4 10             	add    $0x10,%esp
  8003aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
			//PrintElements64(Res, NumOfElements);
			break ;
  8003ad:	eb 30                	jmp    8003df <_main+0x3a7>
		case 'c':
			Res = MatrixMultiply(M1, M2, NumOfElements);
  8003af:	83 ec 04             	sub    $0x4,%esp
  8003b2:	ff 75 e4             	pushl  -0x1c(%ebp)
  8003b5:	ff 75 d8             	pushl  -0x28(%ebp)
  8003b8:	ff 75 dc             	pushl  -0x24(%ebp)
  8003bb:	e8 1d 01 00 00       	call   8004dd <MatrixMultiply>
  8003c0:	83 c4 10             	add    $0x10,%esp
  8003c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
			//PrintElements64(Res, NumOfElements);
			break ;
  8003c6:	eb 17                	jmp    8003df <_main+0x3a7>
		default:
			Res = MatrixAddition(M1, M2, NumOfElements);
  8003c8:	83 ec 04             	sub    $0x4,%esp
  8003cb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8003ce:	ff 75 d8             	pushl  -0x28(%ebp)
  8003d1:	ff 75 dc             	pushl  -0x24(%ebp)
  8003d4:	e8 54 02 00 00       	call   80062d <MatrixAddition>
  8003d9:	83 c4 10             	add    $0x10,%esp
  8003dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
			//PrintElements64(Res, NumOfElements);
		}


		sys_lock_cons();
  8003df:	e8 fa 1b 00 00       	call   801fde <sys_lock_cons>
		cprintf("Operation is COMPLETED.\n");
  8003e4:	83 ec 0c             	sub    $0xc,%esp
  8003e7:	68 2b 32 80 00       	push   $0x80322b
  8003ec:	e8 69 09 00 00       	call   800d5a <cprintf>
  8003f1:	83 c4 10             	add    $0x10,%esp
		sys_unlock_cons();
  8003f4:	e8 ff 1b 00 00       	call   801ff8 <sys_unlock_cons>

		for (int i = 0; i < NumOfElements; ++i)
  8003f9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800400:	eb 5a                	jmp    80045c <_main+0x424>
		{
			free(M1[i]);
  800402:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800405:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80040f:	01 d0                	add    %edx,%eax
  800411:	8b 00                	mov    (%eax),%eax
  800413:	83 ec 0c             	sub    $0xc,%esp
  800416:	50                   	push   %eax
  800417:	e8 cc 1a 00 00       	call   801ee8 <free>
  80041c:	83 c4 10             	add    $0x10,%esp
			free(M2[i]);
  80041f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800422:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800429:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80042c:	01 d0                	add    %edx,%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	83 ec 0c             	sub    $0xc,%esp
  800433:	50                   	push   %eax
  800434:	e8 af 1a 00 00       	call   801ee8 <free>
  800439:	83 c4 10             	add    $0x10,%esp
			free(Res[i]);
  80043c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80043f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800446:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800449:	01 d0                	add    %edx,%eax
  80044b:	8b 00                	mov    (%eax),%eax
  80044d:	83 ec 0c             	sub    $0xc,%esp
  800450:	50                   	push   %eax
  800451:	e8 92 1a 00 00       	call   801ee8 <free>
  800456:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
		cprintf("Operation is COMPLETED.\n");
		sys_unlock_cons();

		for (int i = 0; i < NumOfElements; ++i)
  800459:	ff 45 e8             	incl   -0x18(%ebp)
  80045c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80045f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800462:	7c 9e                	jl     800402 <_main+0x3ca>
		{
			free(M1[i]);
			free(M2[i]);
			free(Res[i]);
		}
		free(M1) ;
  800464:	83 ec 0c             	sub    $0xc,%esp
  800467:	ff 75 dc             	pushl  -0x24(%ebp)
  80046a:	e8 79 1a 00 00       	call   801ee8 <free>
  80046f:	83 c4 10             	add    $0x10,%esp
		free(M2) ;
  800472:	83 ec 0c             	sub    $0xc,%esp
  800475:	ff 75 d8             	pushl  -0x28(%ebp)
  800478:	e8 6b 1a 00 00       	call   801ee8 <free>
  80047d:	83 c4 10             	add    $0x10,%esp
		free(Res) ;
  800480:	83 ec 0c             	sub    $0xc,%esp
  800483:	ff 75 ec             	pushl  -0x14(%ebp)
  800486:	e8 5d 1a 00 00       	call   801ee8 <free>
  80048b:	83 c4 10             	add    $0x10,%esp


		sys_lock_cons();
  80048e:	e8 4b 1b 00 00       	call   801fde <sys_lock_cons>
		cprintf("Do you want to repeat (y/n): ") ;
  800493:	83 ec 0c             	sub    $0xc,%esp
  800496:	68 44 32 80 00       	push   $0x803244
  80049b:	e8 ba 08 00 00       	call   800d5a <cprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  8004a3:	e8 4f 05 00 00       	call   8009f7 <getchar>
  8004a8:	88 45 e3             	mov    %al,-0x1d(%ebp)
		cputchar(Chose);
  8004ab:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  8004af:	83 ec 0c             	sub    $0xc,%esp
  8004b2:	50                   	push   %eax
  8004b3:	e8 20 05 00 00       	call   8009d8 <cputchar>
  8004b8:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8004bb:	83 ec 0c             	sub    $0xc,%esp
  8004be:	6a 0a                	push   $0xa
  8004c0:	e8 13 05 00 00       	call   8009d8 <cputchar>
  8004c5:	83 c4 10             	add    $0x10,%esp
		sys_unlock_cons();
  8004c8:	e8 2b 1b 00 00       	call   801ff8 <sys_unlock_cons>

	} while (Chose == 'y');
  8004cd:	80 7d e3 79          	cmpb   $0x79,-0x1d(%ebp)
  8004d1:	0f 84 79 fb ff ff    	je     800050 <_main+0x18>

}
  8004d7:	90                   	nop
  8004d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004db:	c9                   	leave  
  8004dc:	c3                   	ret    

008004dd <MatrixMultiply>:

///MATRIX MULTIPLICATION
int64** MatrixMultiply(int **M1, int **M2, int NumOfElements)
{
  8004dd:	55                   	push   %ebp
  8004de:	89 e5                	mov    %esp,%ebp
  8004e0:	57                   	push   %edi
  8004e1:	56                   	push   %esi
  8004e2:	53                   	push   %ebx
  8004e3:	83 ec 2c             	sub    $0x2c,%esp
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
  8004e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e9:	c1 e0 03             	shl    $0x3,%eax
  8004ec:	83 ec 0c             	sub    $0xc,%esp
  8004ef:	50                   	push   %eax
  8004f0:	e8 c5 19 00 00       	call   801eba <malloc>
  8004f5:	83 c4 10             	add    $0x10,%esp
  8004f8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	for (int i = 0; i < NumOfElements; ++i)
  8004fb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800502:	eb 27                	jmp    80052b <MatrixMultiply+0x4e>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
  800504:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800507:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800511:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  800514:	8b 45 10             	mov    0x10(%ebp),%eax
  800517:	c1 e0 03             	shl    $0x3,%eax
  80051a:	83 ec 0c             	sub    $0xc,%esp
  80051d:	50                   	push   %eax
  80051e:	e8 97 19 00 00       	call   801eba <malloc>
  800523:	83 c4 10             	add    $0x10,%esp
  800526:	89 03                	mov    %eax,(%ebx)

///MATRIX MULTIPLICATION
int64** MatrixMultiply(int **M1, int **M2, int NumOfElements)
{
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
	for (int i = 0; i < NumOfElements; ++i)
  800528:	ff 45 e4             	incl   -0x1c(%ebp)
  80052b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80052e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800531:	7c d1                	jl     800504 <MatrixMultiply+0x27>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  800533:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80053a:	e9 d7 00 00 00       	jmp    800616 <MatrixMultiply+0x139>
	{
		for (int j = 0; j < NumOfElements; ++j)
  80053f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  800546:	e9 bc 00 00 00       	jmp    800607 <MatrixMultiply+0x12a>
		{
			Res[i][j] = 0 ;
  80054b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80054e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800555:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800558:	01 d0                	add    %edx,%eax
  80055a:	8b 00                	mov    (%eax),%eax
  80055c:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80055f:	c1 e2 03             	shl    $0x3,%edx
  800562:	01 d0                	add    %edx,%eax
  800564:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  80056a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
			for (int k = 0; k < NumOfElements; ++k)
  800571:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  800578:	eb 7e                	jmp    8005f8 <MatrixMultiply+0x11b>
			{
				Res[i][j] += M1[i][k] * M2[k][j] ;
  80057a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80057d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800584:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800587:	01 d0                	add    %edx,%eax
  800589:	8b 00                	mov    (%eax),%eax
  80058b:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80058e:	c1 e2 03             	shl    $0x3,%edx
  800591:	8d 34 10             	lea    (%eax,%edx,1),%esi
  800594:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800597:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80059e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005a1:	01 d0                	add    %edx,%eax
  8005a3:	8b 00                	mov    (%eax),%eax
  8005a5:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8005a8:	c1 e2 03             	shl    $0x3,%edx
  8005ab:	01 d0                	add    %edx,%eax
  8005ad:	8b 08                	mov    (%eax),%ecx
  8005af:	8b 58 04             	mov    0x4(%eax),%ebx
  8005b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bf:	01 d0                	add    %edx,%eax
  8005c1:	8b 00                	mov    (%eax),%eax
  8005c3:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8005c6:	c1 e2 02             	shl    $0x2,%edx
  8005c9:	01 d0                	add    %edx,%eax
  8005cb:	8b 10                	mov    (%eax),%edx
  8005cd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005d0:	8d 3c 85 00 00 00 00 	lea    0x0(,%eax,4),%edi
  8005d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005da:	01 f8                	add    %edi,%eax
  8005dc:	8b 00                	mov    (%eax),%eax
  8005de:	8b 7d dc             	mov    -0x24(%ebp),%edi
  8005e1:	c1 e7 02             	shl    $0x2,%edi
  8005e4:	01 f8                	add    %edi,%eax
  8005e6:	8b 00                	mov    (%eax),%eax
  8005e8:	0f af c2             	imul   %edx,%eax
  8005eb:	99                   	cltd   
  8005ec:	01 c8                	add    %ecx,%eax
  8005ee:	11 da                	adc    %ebx,%edx
  8005f0:	89 06                	mov    %eax,(%esi)
  8005f2:	89 56 04             	mov    %edx,0x4(%esi)
	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
		{
			Res[i][j] = 0 ;
			for (int k = 0; k < NumOfElements; ++k)
  8005f5:	ff 45 d8             	incl   -0x28(%ebp)
  8005f8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005fb:	3b 45 10             	cmp    0x10(%ebp),%eax
  8005fe:	0f 8c 76 ff ff ff    	jl     80057a <MatrixMultiply+0x9d>
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
  800604:	ff 45 dc             	incl   -0x24(%ebp)
  800607:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80060a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80060d:	0f 8c 38 ff ff ff    	jl     80054b <MatrixMultiply+0x6e>
	for (int i = 0; i < NumOfElements; ++i)
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  800613:	ff 45 e0             	incl   -0x20(%ebp)
  800616:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800619:	3b 45 10             	cmp    0x10(%ebp),%eax
  80061c:	0f 8c 1d ff ff ff    	jl     80053f <MatrixMultiply+0x62>
			{
				Res[i][j] += M1[i][k] * M2[k][j] ;
			}
		}
	}
	return Res;
  800622:	8b 45 d4             	mov    -0x2c(%ebp),%eax
}
  800625:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800628:	5b                   	pop    %ebx
  800629:	5e                   	pop    %esi
  80062a:	5f                   	pop    %edi
  80062b:	5d                   	pop    %ebp
  80062c:	c3                   	ret    

0080062d <MatrixAddition>:

///MATRIX ADDITION
int64** MatrixAddition(int **M1, int **M2, int NumOfElements)
{
  80062d:	55                   	push   %ebp
  80062e:	89 e5                	mov    %esp,%ebp
  800630:	53                   	push   %ebx
  800631:	83 ec 14             	sub    $0x14,%esp
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
  800634:	8b 45 10             	mov    0x10(%ebp),%eax
  800637:	c1 e0 03             	shl    $0x3,%eax
  80063a:	83 ec 0c             	sub    $0xc,%esp
  80063d:	50                   	push   %eax
  80063e:	e8 77 18 00 00       	call   801eba <malloc>
  800643:	83 c4 10             	add    $0x10,%esp
  800646:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for (int i = 0; i < NumOfElements; ++i)
  800649:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800650:	eb 27                	jmp    800679 <MatrixAddition+0x4c>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
  800652:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800655:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80065c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80065f:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  800662:	8b 45 10             	mov    0x10(%ebp),%eax
  800665:	c1 e0 03             	shl    $0x3,%eax
  800668:	83 ec 0c             	sub    $0xc,%esp
  80066b:	50                   	push   %eax
  80066c:	e8 49 18 00 00       	call   801eba <malloc>
  800671:	83 c4 10             	add    $0x10,%esp
  800674:	89 03                	mov    %eax,(%ebx)

///MATRIX ADDITION
int64** MatrixAddition(int **M1, int **M2, int NumOfElements)
{
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
	for (int i = 0; i < NumOfElements; ++i)
  800676:	ff 45 f4             	incl   -0xc(%ebp)
  800679:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80067c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80067f:	7c d1                	jl     800652 <MatrixAddition+0x25>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  800681:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800688:	eb 6f                	jmp    8006f9 <MatrixAddition+0xcc>
	{
		for (int j = 0; j < NumOfElements; ++j)
  80068a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800691:	eb 5b                	jmp    8006ee <MatrixAddition+0xc1>
		{
			Res[i][j] = M1[i][j] + M2[i][j] ;
  800693:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800696:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80069d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006a0:	01 d0                	add    %edx,%eax
  8006a2:	8b 00                	mov    (%eax),%eax
  8006a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006a7:	c1 e2 03             	shl    $0x3,%edx
  8006aa:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
  8006ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ba:	01 d0                	add    %edx,%eax
  8006bc:	8b 00                	mov    (%eax),%eax
  8006be:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006c1:	c1 e2 02             	shl    $0x2,%edx
  8006c4:	01 d0                	add    %edx,%eax
  8006c6:	8b 10                	mov    (%eax),%edx
  8006c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006cb:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
  8006d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d5:	01 d8                	add    %ebx,%eax
  8006d7:	8b 00                	mov    (%eax),%eax
  8006d9:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8006dc:	c1 e3 02             	shl    $0x2,%ebx
  8006df:	01 d8                	add    %ebx,%eax
  8006e1:	8b 00                	mov    (%eax),%eax
  8006e3:	01 d0                	add    %edx,%eax
  8006e5:	99                   	cltd   
  8006e6:	89 01                	mov    %eax,(%ecx)
  8006e8:	89 51 04             	mov    %edx,0x4(%ecx)
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
  8006eb:	ff 45 ec             	incl   -0x14(%ebp)
  8006ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8006f1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8006f4:	7c 9d                	jl     800693 <MatrixAddition+0x66>
	for (int i = 0; i < NumOfElements; ++i)
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  8006f6:	ff 45 f0             	incl   -0x10(%ebp)
  8006f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006fc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8006ff:	7c 89                	jl     80068a <MatrixAddition+0x5d>
		for (int j = 0; j < NumOfElements; ++j)
		{
			Res[i][j] = M1[i][j] + M2[i][j] ;
		}
	}
	return Res;
  800701:	8b 45 e8             	mov    -0x18(%ebp),%eax
}
  800704:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800707:	c9                   	leave  
  800708:	c3                   	ret    

00800709 <MatrixSubtraction>:

///MATRIX SUBTRACTION
int64** MatrixSubtraction(int **M1, int **M2, int NumOfElements)
{
  800709:	55                   	push   %ebp
  80070a:	89 e5                	mov    %esp,%ebp
  80070c:	53                   	push   %ebx
  80070d:	83 ec 14             	sub    $0x14,%esp
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
  800710:	8b 45 10             	mov    0x10(%ebp),%eax
  800713:	c1 e0 03             	shl    $0x3,%eax
  800716:	83 ec 0c             	sub    $0xc,%esp
  800719:	50                   	push   %eax
  80071a:	e8 9b 17 00 00       	call   801eba <malloc>
  80071f:	83 c4 10             	add    $0x10,%esp
  800722:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for (int i = 0; i < NumOfElements; ++i)
  800725:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80072c:	eb 27                	jmp    800755 <MatrixSubtraction+0x4c>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
  80072e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800731:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800738:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80073b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  80073e:	8b 45 10             	mov    0x10(%ebp),%eax
  800741:	c1 e0 03             	shl    $0x3,%eax
  800744:	83 ec 0c             	sub    $0xc,%esp
  800747:	50                   	push   %eax
  800748:	e8 6d 17 00 00       	call   801eba <malloc>
  80074d:	83 c4 10             	add    $0x10,%esp
  800750:	89 03                	mov    %eax,(%ebx)

///MATRIX SUBTRACTION
int64** MatrixSubtraction(int **M1, int **M2, int NumOfElements)
{
	int64 **Res = malloc(sizeof(int64) * NumOfElements) ;
	for (int i = 0; i < NumOfElements; ++i)
  800752:	ff 45 f4             	incl   -0xc(%ebp)
  800755:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800758:	3b 45 10             	cmp    0x10(%ebp),%eax
  80075b:	7c d1                	jl     80072e <MatrixSubtraction+0x25>
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  80075d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800764:	eb 71                	jmp    8007d7 <MatrixSubtraction+0xce>
	{
		for (int j = 0; j < NumOfElements; ++j)
  800766:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80076d:	eb 5d                	jmp    8007cc <MatrixSubtraction+0xc3>
		{
			Res[i][j] = M1[i][j] - M2[i][j] ;
  80076f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800772:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800779:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80077c:	01 d0                	add    %edx,%eax
  80077e:	8b 00                	mov    (%eax),%eax
  800780:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800783:	c1 e2 03             	shl    $0x3,%edx
  800786:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
  800789:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80078c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800793:	8b 45 08             	mov    0x8(%ebp),%eax
  800796:	01 d0                	add    %edx,%eax
  800798:	8b 00                	mov    (%eax),%eax
  80079a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80079d:	c1 e2 02             	shl    $0x2,%edx
  8007a0:	01 d0                	add    %edx,%eax
  8007a2:	8b 10                	mov    (%eax),%edx
  8007a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007a7:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
  8007ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007b1:	01 d8                	add    %ebx,%eax
  8007b3:	8b 00                	mov    (%eax),%eax
  8007b5:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8007b8:	c1 e3 02             	shl    $0x2,%ebx
  8007bb:	01 d8                	add    %ebx,%eax
  8007bd:	8b 00                	mov    (%eax),%eax
  8007bf:	29 c2                	sub    %eax,%edx
  8007c1:	89 d0                	mov    %edx,%eax
  8007c3:	99                   	cltd   
  8007c4:	89 01                	mov    %eax,(%ecx)
  8007c6:	89 51 04             	mov    %edx,0x4(%ecx)
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
	{
		for (int j = 0; j < NumOfElements; ++j)
  8007c9:	ff 45 ec             	incl   -0x14(%ebp)
  8007cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007cf:	3b 45 10             	cmp    0x10(%ebp),%eax
  8007d2:	7c 9b                	jl     80076f <MatrixSubtraction+0x66>
	for (int i = 0; i < NumOfElements; ++i)
	{
		Res[i] = malloc(sizeof(int64) * NumOfElements) ;
	}

	for (int i = 0; i < NumOfElements; ++i)
  8007d4:	ff 45 f0             	incl   -0x10(%ebp)
  8007d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007da:	3b 45 10             	cmp    0x10(%ebp),%eax
  8007dd:	7c 87                	jl     800766 <MatrixSubtraction+0x5d>
		for (int j = 0; j < NumOfElements; ++j)
		{
			Res[i][j] = M1[i][j] - M2[i][j] ;
		}
	}
	return Res;
  8007df:	8b 45 e8             	mov    -0x18(%ebp),%eax
}
  8007e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007e5:	c9                   	leave  
  8007e6:	c3                   	ret    

008007e7 <InitializeAscending>:

///Private Functions

void InitializeAscending(int **Elements, int NumOfElements)
{
  8007e7:	55                   	push   %ebp
  8007e8:	89 e5                	mov    %esp,%ebp
  8007ea:	83 ec 10             	sub    $0x10,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  8007ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8007f4:	eb 35                	jmp    80082b <InitializeAscending+0x44>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  8007f6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8007fd:	eb 21                	jmp    800820 <InitializeAscending+0x39>
		{
			(Elements)[i][j] = j ;
  8007ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800802:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	01 d0                	add    %edx,%eax
  80080e:	8b 00                	mov    (%eax),%eax
  800810:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800813:	c1 e2 02             	shl    $0x2,%edx
  800816:	01 c2                	add    %eax,%edx
  800818:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80081b:	89 02                	mov    %eax,(%edx)
void InitializeAscending(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80081d:	ff 45 f8             	incl   -0x8(%ebp)
  800820:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800823:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800826:	7c d7                	jl     8007ff <InitializeAscending+0x18>
///Private Functions

void InitializeAscending(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800828:	ff 45 fc             	incl   -0x4(%ebp)
  80082b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80082e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800831:	7c c3                	jl     8007f6 <InitializeAscending+0xf>
		for (j = 0 ; j < NumOfElements ; j++)
		{
			(Elements)[i][j] = j ;
		}
	}
}
  800833:	90                   	nop
  800834:	c9                   	leave  
  800835:	c3                   	ret    

00800836 <InitializeIdentical>:

void InitializeIdentical(int **Elements, int NumOfElements, int value)
{
  800836:	55                   	push   %ebp
  800837:	89 e5                	mov    %esp,%ebp
  800839:	83 ec 10             	sub    $0x10,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  80083c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800843:	eb 35                	jmp    80087a <InitializeIdentical+0x44>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  800845:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80084c:	eb 21                	jmp    80086f <InitializeIdentical+0x39>
		{
			(Elements)[i][j] = value ;
  80084e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800851:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800858:	8b 45 08             	mov    0x8(%ebp),%eax
  80085b:	01 d0                	add    %edx,%eax
  80085d:	8b 00                	mov    (%eax),%eax
  80085f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800862:	c1 e2 02             	shl    $0x2,%edx
  800865:	01 c2                	add    %eax,%edx
  800867:	8b 45 10             	mov    0x10(%ebp),%eax
  80086a:	89 02                	mov    %eax,(%edx)
void InitializeIdentical(int **Elements, int NumOfElements, int value)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80086c:	ff 45 f8             	incl   -0x8(%ebp)
  80086f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800872:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800875:	7c d7                	jl     80084e <InitializeIdentical+0x18>
}

void InitializeIdentical(int **Elements, int NumOfElements, int value)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800877:	ff 45 fc             	incl   -0x4(%ebp)
  80087a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80087d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800880:	7c c3                	jl     800845 <InitializeIdentical+0xf>
		for (j = 0 ; j < NumOfElements ; j++)
		{
			(Elements)[i][j] = value ;
		}
	}
}
  800882:	90                   	nop
  800883:	c9                   	leave  
  800884:	c3                   	ret    

00800885 <InitializeSemiRandom>:

void InitializeSemiRandom(int **Elements, int NumOfElements)
{
  800885:	55                   	push   %ebp
  800886:	89 e5                	mov    %esp,%ebp
  800888:	53                   	push   %ebx
  800889:	83 ec 20             	sub    $0x20,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  80088c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800893:	eb 56                	jmp    8008eb <InitializeSemiRandom+0x66>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  800895:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80089c:	eb 42                	jmp    8008e0 <InitializeSemiRandom+0x5b>
		{
			(Elements)[i][j] =  RAND(0, NumOfElements) ;
  80089e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8008a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ab:	01 d0                	add    %edx,%eax
  8008ad:	8b 00                	mov    (%eax),%eax
  8008af:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008b2:	c1 e2 02             	shl    $0x2,%edx
  8008b5:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
	//	lcr4(0);


	struct uint64 result;

	__asm __volatile("rdtsc\n"
  8008b8:	0f 31                	rdtsc  
  8008ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008bd:	89 55 e8             	mov    %edx,-0x18(%ebp)
	//ptr[3]=0;
	//cprintf("as str = %s\n", ptr);
	cprintf("ax = %x, bx = %x, cx = %x, dx = %x\n", eaxp,ebxp,ecxp,edxp);
	*/

	return result;
  8008c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8008c3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008c9:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8008cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008cf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8008d2:	ba 00 00 00 00       	mov    $0x0,%edx
  8008d7:	f7 f3                	div    %ebx
  8008d9:	89 d0                	mov    %edx,%eax
  8008db:	89 01                	mov    %eax,(%ecx)
void InitializeSemiRandom(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  8008dd:	ff 45 f4             	incl   -0xc(%ebp)
  8008e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008e3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008e6:	7c b6                	jl     80089e <InitializeSemiRandom+0x19>
}

void InitializeSemiRandom(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  8008e8:	ff 45 f8             	incl   -0x8(%ebp)
  8008eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8008ee:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008f1:	7c a2                	jl     800895 <InitializeSemiRandom+0x10>
		{
			(Elements)[i][j] =  RAND(0, NumOfElements) ;
			//	cprintf("i=%d\n",i);
		}
	}
}
  8008f3:	90                   	nop
  8008f4:	83 c4 20             	add    $0x20,%esp
  8008f7:	5b                   	pop    %ebx
  8008f8:	5d                   	pop    %ebp
  8008f9:	c3                   	ret    

008008fa <PrintElements>:

void PrintElements(int **Elements, int NumOfElements)
{
  8008fa:	55                   	push   %ebp
  8008fb:	89 e5                	mov    %esp,%ebp
  8008fd:	83 ec 18             	sub    $0x18,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800900:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800907:	eb 53                	jmp    80095c <PrintElements+0x62>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  800909:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800910:	eb 2f                	jmp    800941 <PrintElements+0x47>
		{
			cprintf("%~%d, ",Elements[i][j]);
  800912:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800915:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80091c:	8b 45 08             	mov    0x8(%ebp),%eax
  80091f:	01 d0                	add    %edx,%eax
  800921:	8b 00                	mov    (%eax),%eax
  800923:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800926:	c1 e2 02             	shl    $0x2,%edx
  800929:	01 d0                	add    %edx,%eax
  80092b:	8b 00                	mov    (%eax),%eax
  80092d:	83 ec 08             	sub    $0x8,%esp
  800930:	50                   	push   %eax
  800931:	68 62 32 80 00       	push   $0x803262
  800936:	e8 1f 04 00 00       	call   800d5a <cprintf>
  80093b:	83 c4 10             	add    $0x10,%esp
void PrintElements(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  80093e:	ff 45 f0             	incl   -0x10(%ebp)
  800941:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800944:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800947:	7c c9                	jl     800912 <PrintElements+0x18>
		{
			cprintf("%~%d, ",Elements[i][j]);
		}
		cprintf("%~\n");
  800949:	83 ec 0c             	sub    $0xc,%esp
  80094c:	68 69 32 80 00       	push   $0x803269
  800951:	e8 04 04 00 00       	call   800d5a <cprintf>
  800956:	83 c4 10             	add    $0x10,%esp
}

void PrintElements(int **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  800959:	ff 45 f4             	incl   -0xc(%ebp)
  80095c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80095f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800962:	7c a5                	jl     800909 <PrintElements+0xf>
		{
			cprintf("%~%d, ",Elements[i][j]);
		}
		cprintf("%~\n");
	}
}
  800964:	90                   	nop
  800965:	c9                   	leave  
  800966:	c3                   	ret    

00800967 <PrintElements64>:

void PrintElements64(int64 **Elements, int NumOfElements)
{
  800967:	55                   	push   %ebp
  800968:	89 e5                	mov    %esp,%ebp
  80096a:	83 ec 18             	sub    $0x18,%esp
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  80096d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800974:	eb 57                	jmp    8009cd <PrintElements64+0x66>
	{
		for (j = 0 ; j < NumOfElements ; j++)
  800976:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80097d:	eb 33                	jmp    8009b2 <PrintElements64+0x4b>
		{
			cprintf("%~%lld, ",Elements[i][j]);
  80097f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800982:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800989:	8b 45 08             	mov    0x8(%ebp),%eax
  80098c:	01 d0                	add    %edx,%eax
  80098e:	8b 00                	mov    (%eax),%eax
  800990:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800993:	c1 e2 03             	shl    $0x3,%edx
  800996:	01 d0                	add    %edx,%eax
  800998:	8b 50 04             	mov    0x4(%eax),%edx
  80099b:	8b 00                	mov    (%eax),%eax
  80099d:	83 ec 04             	sub    $0x4,%esp
  8009a0:	52                   	push   %edx
  8009a1:	50                   	push   %eax
  8009a2:	68 6d 32 80 00       	push   $0x80326d
  8009a7:	e8 ae 03 00 00       	call   800d5a <cprintf>
  8009ac:	83 c4 10             	add    $0x10,%esp
void PrintElements64(int64 **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
	{
		for (j = 0 ; j < NumOfElements ; j++)
  8009af:	ff 45 f0             	incl   -0x10(%ebp)
  8009b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009b5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009b8:	7c c5                	jl     80097f <PrintElements64+0x18>
		{
			cprintf("%~%lld, ",Elements[i][j]);
		}
		cprintf("%~\n");
  8009ba:	83 ec 0c             	sub    $0xc,%esp
  8009bd:	68 69 32 80 00       	push   $0x803269
  8009c2:	e8 93 03 00 00       	call   800d5a <cprintf>
  8009c7:	83 c4 10             	add    $0x10,%esp
}

void PrintElements64(int64 **Elements, int NumOfElements)
{
	int i, j ;
	for (i = 0 ; i < NumOfElements ; i++)
  8009ca:	ff 45 f4             	incl   -0xc(%ebp)
  8009cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009d0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009d3:	7c a1                	jl     800976 <PrintElements64+0xf>
		{
			cprintf("%~%lld, ",Elements[i][j]);
		}
		cprintf("%~\n");
	}
}
  8009d5:	90                   	nop
  8009d6:	c9                   	leave  
  8009d7:	c3                   	ret    

008009d8 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8009d8:	55                   	push   %ebp
  8009d9:	89 e5                	mov    %esp,%ebp
  8009db:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8009de:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8009e4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8009e8:	83 ec 0c             	sub    $0xc,%esp
  8009eb:	50                   	push   %eax
  8009ec:	e8 35 17 00 00       	call   802126 <sys_cputc>
  8009f1:	83 c4 10             	add    $0x10,%esp
}
  8009f4:	90                   	nop
  8009f5:	c9                   	leave  
  8009f6:	c3                   	ret    

008009f7 <getchar>:


int
getchar(void)
{
  8009f7:	55                   	push   %ebp
  8009f8:	89 e5                	mov    %esp,%ebp
  8009fa:	83 ec 18             	sub    $0x18,%esp
	int c;
	while ((c = sys_cgetc()) == 0);
  8009fd:	e8 c3 15 00 00       	call   801fc5 <sys_cgetc>
  800a02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a05:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800a09:	74 f2                	je     8009fd <getchar+0x6>
	return c;
  800a0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a0e:	c9                   	leave  
  800a0f:	c3                   	ret    

00800a10 <iscons>:

int iscons(int fdnum)
{
  800a10:	55                   	push   %ebp
  800a11:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800a13:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800a18:	5d                   	pop    %ebp
  800a19:	c3                   	ret    

00800a1a <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800a1a:	55                   	push   %ebp
  800a1b:	89 e5                	mov    %esp,%ebp
  800a1d:	57                   	push   %edi
  800a1e:	56                   	push   %esi
  800a1f:	53                   	push   %ebx
  800a20:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800a26:	e8 2b 18 00 00       	call   802256 <sys_getenvindex>
  800a2b:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800a2e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a31:	89 d0                	mov    %edx,%eax
  800a33:	c1 e0 03             	shl    $0x3,%eax
  800a36:	01 d0                	add    %edx,%eax
  800a38:	c1 e0 06             	shl    $0x6,%eax
  800a3b:	01 d0                	add    %edx,%eax
  800a3d:	c1 e0 03             	shl    $0x3,%eax
  800a40:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800a45:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800a4a:	a1 20 40 80 00       	mov    0x804020,%eax
  800a4f:	8a 40 10             	mov    0x10(%eax),%al
  800a52:	84 c0                	test   %al,%al
  800a54:	74 0d                	je     800a63 <libmain+0x49>
		binaryname = myEnv->prog_name;
  800a56:	a1 20 40 80 00       	mov    0x804020,%eax
  800a5b:	83 c0 10             	add    $0x10,%eax
  800a5e:	a3 04 40 80 00       	mov    %eax,0x804004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800a63:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a67:	7e 0a                	jle    800a73 <libmain+0x59>
		binaryname = argv[0];
  800a69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6c:	8b 00                	mov    (%eax),%eax
  800a6e:	a3 04 40 80 00       	mov    %eax,0x804004

	// call user main routine
	_main(argc, argv);
  800a73:	83 ec 08             	sub    $0x8,%esp
  800a76:	ff 75 0c             	pushl  0xc(%ebp)
  800a79:	ff 75 08             	pushl  0x8(%ebp)
  800a7c:	e8 b7 f5 ff ff       	call   800038 <_main>
  800a81:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  800a84:	a1 00 40 80 00       	mov    0x804000,%eax
  800a89:	85 c0                	test   %eax,%eax
  800a8b:	0f 84 b7 01 00 00    	je     800c48 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  800a91:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800a97:	bb b4 33 80 00       	mov    $0x8033b4,%ebx
  800a9c:	ba 0e 00 00 00       	mov    $0xe,%edx
  800aa1:	89 c7                	mov    %eax,%edi
  800aa3:	89 de                	mov    %ebx,%esi
  800aa5:	89 d1                	mov    %edx,%ecx
  800aa7:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800aa9:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  800aaf:	b9 56 00 00 00       	mov    $0x56,%ecx
  800ab4:	b0 00                	mov    $0x0,%al
  800ab6:	89 d7                	mov    %edx,%edi
  800ab8:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  800aba:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  800ac1:	8d 45 d8             	lea    -0x28(%ebp),%eax
  800ac4:	83 ec 08             	sub    $0x8,%esp
  800ac7:	50                   	push   %eax
  800ac8:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800ace:	50                   	push   %eax
  800acf:	e8 82 19 00 00       	call   802456 <sys_utilities>
  800ad4:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  800ad7:	e8 02 15 00 00       	call   801fde <sys_lock_cons>
		{
			cprintf("**************************************\n");
  800adc:	83 ec 0c             	sub    $0xc,%esp
  800adf:	68 90 32 80 00       	push   $0x803290
  800ae4:	e8 71 02 00 00       	call   800d5a <cprintf>
  800ae9:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  800aec:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800aef:	85 c0                	test   %eax,%eax
  800af1:	74 58                	je     800b4b <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  800af3:	e8 7c 19 00 00       	call   802474 <sys_get_optimal_num_faults>
  800af8:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  800afb:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800b01:	bb 18 34 80 00       	mov    $0x803418,%ebx
  800b06:	ba 11 00 00 00       	mov    $0x11,%edx
  800b0b:	89 c7                	mov    %eax,%edi
  800b0d:	89 de                	mov    %ebx,%esi
  800b0f:	89 d1                	mov    %edx,%ecx
  800b11:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800b13:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800b16:	b9 53 00 00 00       	mov    $0x53,%ecx
  800b1b:	b0 00                	mov    $0x0,%al
  800b1d:	89 d7                	mov    %edx,%edi
  800b1f:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  800b21:	83 ec 08             	sub    $0x8,%esp
  800b24:	ff 75 dc             	pushl  -0x24(%ebp)
  800b27:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800b2d:	50                   	push   %eax
  800b2e:	e8 23 19 00 00       	call   802456 <sys_utilities>
  800b33:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800b36:	83 ec 08             	sub    $0x8,%esp
  800b39:	ff 75 dc             	pushl  -0x24(%ebp)
  800b3c:	68 b8 32 80 00       	push   $0x8032b8
  800b41:	e8 14 02 00 00       	call   800d5a <cprintf>
  800b46:	83 c4 10             	add    $0x10,%esp
  800b49:	eb 59                	jmp    800ba4 <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800b4b:	a1 20 40 80 00       	mov    0x804020,%eax
  800b50:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800b56:	a1 20 40 80 00       	mov    0x804020,%eax
  800b5b:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  800b61:	83 ec 04             	sub    $0x4,%esp
  800b64:	52                   	push   %edx
  800b65:	50                   	push   %eax
  800b66:	68 dc 32 80 00       	push   $0x8032dc
  800b6b:	e8 ea 01 00 00       	call   800d5a <cprintf>
  800b70:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  800b73:	a1 20 40 80 00       	mov    0x804020,%eax
  800b78:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800b7e:	a1 20 40 80 00       	mov    0x804020,%eax
  800b83:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800b89:	a1 20 40 80 00       	mov    0x804020,%eax
  800b8e:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  800b94:	51                   	push   %ecx
  800b95:	52                   	push   %edx
  800b96:	50                   	push   %eax
  800b97:	68 04 33 80 00       	push   $0x803304
  800b9c:	e8 b9 01 00 00       	call   800d5a <cprintf>
  800ba1:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800ba4:	a1 20 40 80 00       	mov    0x804020,%eax
  800ba9:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  800baf:	83 ec 08             	sub    $0x8,%esp
  800bb2:	50                   	push   %eax
  800bb3:	68 5c 33 80 00       	push   $0x80335c
  800bb8:	e8 9d 01 00 00       	call   800d5a <cprintf>
  800bbd:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  800bc0:	83 ec 0c             	sub    $0xc,%esp
  800bc3:	68 70 33 80 00       	push   $0x803370
  800bc8:	e8 8d 01 00 00       	call   800d5a <cprintf>
  800bcd:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  800bd0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800bd7:	eb 28                	jmp    800c01 <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  800bd9:	a1 20 40 80 00       	mov    0x804020,%eax
  800bde:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800be1:	81 c2 74 04 00 00    	add    $0x474,%edx
  800be7:	8b 04 90             	mov    (%eax,%edx,4),%eax
  800bea:	83 ec 04             	sub    $0x4,%esp
  800bed:	50                   	push   %eax
  800bee:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bf1:	68 87 33 80 00       	push   $0x803387
  800bf6:	e8 5f 01 00 00       	call   800d5a <cprintf>
  800bfb:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  800bfe:	ff 45 e4             	incl   -0x1c(%ebp)
  800c01:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800c05:	7e d2                	jle    800bd9 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800c07:	83 ec 0c             	sub    $0xc,%esp
  800c0a:	68 96 33 80 00       	push   $0x803396
  800c0f:	e8 46 01 00 00       	call   800d5a <cprintf>
  800c14:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800c17:	a1 20 40 80 00       	mov    0x804020,%eax
  800c1c:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  800c22:	83 ec 08             	sub    $0x8,%esp
  800c25:	50                   	push   %eax
  800c26:	68 9a 33 80 00       	push   $0x80339a
  800c2b:	e8 2a 01 00 00       	call   800d5a <cprintf>
  800c30:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  800c33:	83 ec 0c             	sub    $0xc,%esp
  800c36:	68 90 32 80 00       	push   $0x803290
  800c3b:	e8 1a 01 00 00       	call   800d5a <cprintf>
  800c40:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  800c43:	e8 b0 13 00 00       	call   801ff8 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800c48:	e8 1f 00 00 00       	call   800c6c <exit>
}
  800c4d:	90                   	nop
  800c4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800c51:	5b                   	pop    %ebx
  800c52:	5e                   	pop    %esi
  800c53:	5f                   	pop    %edi
  800c54:	5d                   	pop    %ebp
  800c55:	c3                   	ret    

00800c56 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800c56:	55                   	push   %ebp
  800c57:	89 e5                	mov    %esp,%ebp
  800c59:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800c5c:	83 ec 0c             	sub    $0xc,%esp
  800c5f:	6a 00                	push   $0x0
  800c61:	e8 bc 15 00 00       	call   802222 <sys_destroy_env>
  800c66:	83 c4 10             	add    $0x10,%esp
}
  800c69:	90                   	nop
  800c6a:	c9                   	leave  
  800c6b:	c3                   	ret    

00800c6c <exit>:

void
exit(void)
{
  800c6c:	55                   	push   %ebp
  800c6d:	89 e5                	mov    %esp,%ebp
  800c6f:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  800c72:	e8 11 16 00 00       	call   802288 <sys_exit_env>
}
  800c77:	90                   	nop
  800c78:	c9                   	leave  
  800c79:	c3                   	ret    

00800c7a <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800c7a:	55                   	push   %ebp
  800c7b:	89 e5                	mov    %esp,%ebp
  800c7d:	53                   	push   %ebx
  800c7e:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800c81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c84:	8b 00                	mov    (%eax),%eax
  800c86:	8d 48 01             	lea    0x1(%eax),%ecx
  800c89:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c8c:	89 0a                	mov    %ecx,(%edx)
  800c8e:	8b 55 08             	mov    0x8(%ebp),%edx
  800c91:	88 d1                	mov    %dl,%cl
  800c93:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c96:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800c9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9d:	8b 00                	mov    (%eax),%eax
  800c9f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ca4:	75 30                	jne    800cd6 <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800ca6:	8b 15 28 41 80 00    	mov    0x804128,%edx
  800cac:	a0 40 40 80 00       	mov    0x804040,%al
  800cb1:	0f b6 c0             	movzbl %al,%eax
  800cb4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800cb7:	8b 09                	mov    (%ecx),%ecx
  800cb9:	89 cb                	mov    %ecx,%ebx
  800cbb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800cbe:	83 c1 08             	add    $0x8,%ecx
  800cc1:	52                   	push   %edx
  800cc2:	50                   	push   %eax
  800cc3:	53                   	push   %ebx
  800cc4:	51                   	push   %ecx
  800cc5:	e8 d0 12 00 00       	call   801f9a <sys_cputs>
  800cca:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800ccd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800cd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd9:	8b 40 04             	mov    0x4(%eax),%eax
  800cdc:	8d 50 01             	lea    0x1(%eax),%edx
  800cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce2:	89 50 04             	mov    %edx,0x4(%eax)
}
  800ce5:	90                   	nop
  800ce6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ce9:	c9                   	leave  
  800cea:	c3                   	ret    

00800ceb <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ceb:	55                   	push   %ebp
  800cec:	89 e5                	mov    %esp,%ebp
  800cee:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800cf4:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800cfb:	00 00 00 
	b.cnt = 0;
  800cfe:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800d05:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800d08:	ff 75 0c             	pushl  0xc(%ebp)
  800d0b:	ff 75 08             	pushl  0x8(%ebp)
  800d0e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800d14:	50                   	push   %eax
  800d15:	68 7a 0c 80 00       	push   $0x800c7a
  800d1a:	e8 5a 02 00 00       	call   800f79 <vprintfmt>
  800d1f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800d22:	8b 15 28 41 80 00    	mov    0x804128,%edx
  800d28:	a0 40 40 80 00       	mov    0x804040,%al
  800d2d:	0f b6 c0             	movzbl %al,%eax
  800d30:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800d36:	52                   	push   %edx
  800d37:	50                   	push   %eax
  800d38:	51                   	push   %ecx
  800d39:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800d3f:	83 c0 08             	add    $0x8,%eax
  800d42:	50                   	push   %eax
  800d43:	e8 52 12 00 00       	call   801f9a <sys_cputs>
  800d48:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800d4b:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
	return b.cnt;
  800d52:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800d58:	c9                   	leave  
  800d59:	c3                   	ret    

00800d5a <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800d5a:	55                   	push   %ebp
  800d5b:	89 e5                	mov    %esp,%ebp
  800d5d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800d60:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	va_start(ap, fmt);
  800d67:	8d 45 0c             	lea    0xc(%ebp),%eax
  800d6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	83 ec 08             	sub    $0x8,%esp
  800d73:	ff 75 f4             	pushl  -0xc(%ebp)
  800d76:	50                   	push   %eax
  800d77:	e8 6f ff ff ff       	call   800ceb <vcprintf>
  800d7c:	83 c4 10             	add    $0x10,%esp
  800d7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800d82:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d85:	c9                   	leave  
  800d86:	c3                   	ret    

00800d87 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800d87:	55                   	push   %ebp
  800d88:	89 e5                	mov    %esp,%ebp
  800d8a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800d8d:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
	curTextClr = (textClr << 8) ; //set text color by the given value
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	c1 e0 08             	shl    $0x8,%eax
  800d9a:	a3 28 41 80 00       	mov    %eax,0x804128
	va_start(ap, fmt);
  800d9f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800da2:	83 c0 04             	add    $0x4,%eax
  800da5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800da8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dab:	83 ec 08             	sub    $0x8,%esp
  800dae:	ff 75 f4             	pushl  -0xc(%ebp)
  800db1:	50                   	push   %eax
  800db2:	e8 34 ff ff ff       	call   800ceb <vcprintf>
  800db7:	83 c4 10             	add    $0x10,%esp
  800dba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800dbd:	c7 05 28 41 80 00 00 	movl   $0x700,0x804128
  800dc4:	07 00 00 

	return cnt;
  800dc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dca:	c9                   	leave  
  800dcb:	c3                   	ret    

00800dcc <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800dcc:	55                   	push   %ebp
  800dcd:	89 e5                	mov    %esp,%ebp
  800dcf:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800dd2:	e8 07 12 00 00       	call   801fde <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800dd7:	8d 45 0c             	lea    0xc(%ebp),%eax
  800dda:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	83 ec 08             	sub    $0x8,%esp
  800de3:	ff 75 f4             	pushl  -0xc(%ebp)
  800de6:	50                   	push   %eax
  800de7:	e8 ff fe ff ff       	call   800ceb <vcprintf>
  800dec:	83 c4 10             	add    $0x10,%esp
  800def:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800df2:	e8 01 12 00 00       	call   801ff8 <sys_unlock_cons>
	return cnt;
  800df7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dfa:	c9                   	leave  
  800dfb:	c3                   	ret    

00800dfc <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800dfc:	55                   	push   %ebp
  800dfd:	89 e5                	mov    %esp,%ebp
  800dff:	53                   	push   %ebx
  800e00:	83 ec 14             	sub    $0x14,%esp
  800e03:	8b 45 10             	mov    0x10(%ebp),%eax
  800e06:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e09:	8b 45 14             	mov    0x14(%ebp),%eax
  800e0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800e0f:	8b 45 18             	mov    0x18(%ebp),%eax
  800e12:	ba 00 00 00 00       	mov    $0x0,%edx
  800e17:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800e1a:	77 55                	ja     800e71 <printnum+0x75>
  800e1c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800e1f:	72 05                	jb     800e26 <printnum+0x2a>
  800e21:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e24:	77 4b                	ja     800e71 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800e26:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800e29:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800e2c:	8b 45 18             	mov    0x18(%ebp),%eax
  800e2f:	ba 00 00 00 00       	mov    $0x0,%edx
  800e34:	52                   	push   %edx
  800e35:	50                   	push   %eax
  800e36:	ff 75 f4             	pushl  -0xc(%ebp)
  800e39:	ff 75 f0             	pushl  -0x10(%ebp)
  800e3c:	e8 3b 20 00 00       	call   802e7c <__udivdi3>
  800e41:	83 c4 10             	add    $0x10,%esp
  800e44:	83 ec 04             	sub    $0x4,%esp
  800e47:	ff 75 20             	pushl  0x20(%ebp)
  800e4a:	53                   	push   %ebx
  800e4b:	ff 75 18             	pushl  0x18(%ebp)
  800e4e:	52                   	push   %edx
  800e4f:	50                   	push   %eax
  800e50:	ff 75 0c             	pushl  0xc(%ebp)
  800e53:	ff 75 08             	pushl  0x8(%ebp)
  800e56:	e8 a1 ff ff ff       	call   800dfc <printnum>
  800e5b:	83 c4 20             	add    $0x20,%esp
  800e5e:	eb 1a                	jmp    800e7a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800e60:	83 ec 08             	sub    $0x8,%esp
  800e63:	ff 75 0c             	pushl  0xc(%ebp)
  800e66:	ff 75 20             	pushl  0x20(%ebp)
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	ff d0                	call   *%eax
  800e6e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800e71:	ff 4d 1c             	decl   0x1c(%ebp)
  800e74:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800e78:	7f e6                	jg     800e60 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800e7a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800e7d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800e82:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e85:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e88:	53                   	push   %ebx
  800e89:	51                   	push   %ecx
  800e8a:	52                   	push   %edx
  800e8b:	50                   	push   %eax
  800e8c:	e8 fb 20 00 00       	call   802f8c <__umoddi3>
  800e91:	83 c4 10             	add    $0x10,%esp
  800e94:	05 94 36 80 00       	add    $0x803694,%eax
  800e99:	8a 00                	mov    (%eax),%al
  800e9b:	0f be c0             	movsbl %al,%eax
  800e9e:	83 ec 08             	sub    $0x8,%esp
  800ea1:	ff 75 0c             	pushl  0xc(%ebp)
  800ea4:	50                   	push   %eax
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	ff d0                	call   *%eax
  800eaa:	83 c4 10             	add    $0x10,%esp
}
  800ead:	90                   	nop
  800eae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800eb1:	c9                   	leave  
  800eb2:	c3                   	ret    

00800eb3 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800eb3:	55                   	push   %ebp
  800eb4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800eb6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800eba:	7e 1c                	jle    800ed8 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebf:	8b 00                	mov    (%eax),%eax
  800ec1:	8d 50 08             	lea    0x8(%eax),%edx
  800ec4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec7:	89 10                	mov    %edx,(%eax)
  800ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecc:	8b 00                	mov    (%eax),%eax
  800ece:	83 e8 08             	sub    $0x8,%eax
  800ed1:	8b 50 04             	mov    0x4(%eax),%edx
  800ed4:	8b 00                	mov    (%eax),%eax
  800ed6:	eb 40                	jmp    800f18 <getuint+0x65>
	else if (lflag)
  800ed8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800edc:	74 1e                	je     800efc <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ede:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee1:	8b 00                	mov    (%eax),%eax
  800ee3:	8d 50 04             	lea    0x4(%eax),%edx
  800ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee9:	89 10                	mov    %edx,(%eax)
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	8b 00                	mov    (%eax),%eax
  800ef0:	83 e8 04             	sub    $0x4,%eax
  800ef3:	8b 00                	mov    (%eax),%eax
  800ef5:	ba 00 00 00 00       	mov    $0x0,%edx
  800efa:	eb 1c                	jmp    800f18 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800efc:	8b 45 08             	mov    0x8(%ebp),%eax
  800eff:	8b 00                	mov    (%eax),%eax
  800f01:	8d 50 04             	lea    0x4(%eax),%edx
  800f04:	8b 45 08             	mov    0x8(%ebp),%eax
  800f07:	89 10                	mov    %edx,(%eax)
  800f09:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0c:	8b 00                	mov    (%eax),%eax
  800f0e:	83 e8 04             	sub    $0x4,%eax
  800f11:	8b 00                	mov    (%eax),%eax
  800f13:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800f18:	5d                   	pop    %ebp
  800f19:	c3                   	ret    

00800f1a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800f1a:	55                   	push   %ebp
  800f1b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800f1d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800f21:	7e 1c                	jle    800f3f <getint+0x25>
		return va_arg(*ap, long long);
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	8b 00                	mov    (%eax),%eax
  800f28:	8d 50 08             	lea    0x8(%eax),%edx
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	89 10                	mov    %edx,(%eax)
  800f30:	8b 45 08             	mov    0x8(%ebp),%eax
  800f33:	8b 00                	mov    (%eax),%eax
  800f35:	83 e8 08             	sub    $0x8,%eax
  800f38:	8b 50 04             	mov    0x4(%eax),%edx
  800f3b:	8b 00                	mov    (%eax),%eax
  800f3d:	eb 38                	jmp    800f77 <getint+0x5d>
	else if (lflag)
  800f3f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f43:	74 1a                	je     800f5f <getint+0x45>
		return va_arg(*ap, long);
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	8b 00                	mov    (%eax),%eax
  800f4a:	8d 50 04             	lea    0x4(%eax),%edx
  800f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f50:	89 10                	mov    %edx,(%eax)
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	8b 00                	mov    (%eax),%eax
  800f57:	83 e8 04             	sub    $0x4,%eax
  800f5a:	8b 00                	mov    (%eax),%eax
  800f5c:	99                   	cltd   
  800f5d:	eb 18                	jmp    800f77 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	8b 00                	mov    (%eax),%eax
  800f64:	8d 50 04             	lea    0x4(%eax),%edx
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	89 10                	mov    %edx,(%eax)
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	8b 00                	mov    (%eax),%eax
  800f71:	83 e8 04             	sub    $0x4,%eax
  800f74:	8b 00                	mov    (%eax),%eax
  800f76:	99                   	cltd   
}
  800f77:	5d                   	pop    %ebp
  800f78:	c3                   	ret    

00800f79 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800f79:	55                   	push   %ebp
  800f7a:	89 e5                	mov    %esp,%ebp
  800f7c:	56                   	push   %esi
  800f7d:	53                   	push   %ebx
  800f7e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f81:	eb 17                	jmp    800f9a <vprintfmt+0x21>
			if (ch == '\0')
  800f83:	85 db                	test   %ebx,%ebx
  800f85:	0f 84 c1 03 00 00    	je     80134c <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800f8b:	83 ec 08             	sub    $0x8,%esp
  800f8e:	ff 75 0c             	pushl  0xc(%ebp)
  800f91:	53                   	push   %ebx
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	ff d0                	call   *%eax
  800f97:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9d:	8d 50 01             	lea    0x1(%eax),%edx
  800fa0:	89 55 10             	mov    %edx,0x10(%ebp)
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	0f b6 d8             	movzbl %al,%ebx
  800fa8:	83 fb 25             	cmp    $0x25,%ebx
  800fab:	75 d6                	jne    800f83 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800fad:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800fb1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800fb8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800fbf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800fc6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800fcd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd0:	8d 50 01             	lea    0x1(%eax),%edx
  800fd3:	89 55 10             	mov    %edx,0x10(%ebp)
  800fd6:	8a 00                	mov    (%eax),%al
  800fd8:	0f b6 d8             	movzbl %al,%ebx
  800fdb:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800fde:	83 f8 5b             	cmp    $0x5b,%eax
  800fe1:	0f 87 3d 03 00 00    	ja     801324 <vprintfmt+0x3ab>
  800fe7:	8b 04 85 b8 36 80 00 	mov    0x8036b8(,%eax,4),%eax
  800fee:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ff0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ff4:	eb d7                	jmp    800fcd <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ff6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ffa:	eb d1                	jmp    800fcd <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ffc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801003:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801006:	89 d0                	mov    %edx,%eax
  801008:	c1 e0 02             	shl    $0x2,%eax
  80100b:	01 d0                	add    %edx,%eax
  80100d:	01 c0                	add    %eax,%eax
  80100f:	01 d8                	add    %ebx,%eax
  801011:	83 e8 30             	sub    $0x30,%eax
  801014:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801017:	8b 45 10             	mov    0x10(%ebp),%eax
  80101a:	8a 00                	mov    (%eax),%al
  80101c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80101f:	83 fb 2f             	cmp    $0x2f,%ebx
  801022:	7e 3e                	jle    801062 <vprintfmt+0xe9>
  801024:	83 fb 39             	cmp    $0x39,%ebx
  801027:	7f 39                	jg     801062 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801029:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80102c:	eb d5                	jmp    801003 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80102e:	8b 45 14             	mov    0x14(%ebp),%eax
  801031:	83 c0 04             	add    $0x4,%eax
  801034:	89 45 14             	mov    %eax,0x14(%ebp)
  801037:	8b 45 14             	mov    0x14(%ebp),%eax
  80103a:	83 e8 04             	sub    $0x4,%eax
  80103d:	8b 00                	mov    (%eax),%eax
  80103f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801042:	eb 1f                	jmp    801063 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801044:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801048:	79 83                	jns    800fcd <vprintfmt+0x54>
				width = 0;
  80104a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801051:	e9 77 ff ff ff       	jmp    800fcd <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801056:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80105d:	e9 6b ff ff ff       	jmp    800fcd <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801062:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801063:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801067:	0f 89 60 ff ff ff    	jns    800fcd <vprintfmt+0x54>
				width = precision, precision = -1;
  80106d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801070:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801073:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80107a:	e9 4e ff ff ff       	jmp    800fcd <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80107f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801082:	e9 46 ff ff ff       	jmp    800fcd <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801087:	8b 45 14             	mov    0x14(%ebp),%eax
  80108a:	83 c0 04             	add    $0x4,%eax
  80108d:	89 45 14             	mov    %eax,0x14(%ebp)
  801090:	8b 45 14             	mov    0x14(%ebp),%eax
  801093:	83 e8 04             	sub    $0x4,%eax
  801096:	8b 00                	mov    (%eax),%eax
  801098:	83 ec 08             	sub    $0x8,%esp
  80109b:	ff 75 0c             	pushl  0xc(%ebp)
  80109e:	50                   	push   %eax
  80109f:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a2:	ff d0                	call   *%eax
  8010a4:	83 c4 10             	add    $0x10,%esp
			break;
  8010a7:	e9 9b 02 00 00       	jmp    801347 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8010ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8010af:	83 c0 04             	add    $0x4,%eax
  8010b2:	89 45 14             	mov    %eax,0x14(%ebp)
  8010b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8010b8:	83 e8 04             	sub    $0x4,%eax
  8010bb:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8010bd:	85 db                	test   %ebx,%ebx
  8010bf:	79 02                	jns    8010c3 <vprintfmt+0x14a>
				err = -err;
  8010c1:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8010c3:	83 fb 64             	cmp    $0x64,%ebx
  8010c6:	7f 0b                	jg     8010d3 <vprintfmt+0x15a>
  8010c8:	8b 34 9d 00 35 80 00 	mov    0x803500(,%ebx,4),%esi
  8010cf:	85 f6                	test   %esi,%esi
  8010d1:	75 19                	jne    8010ec <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8010d3:	53                   	push   %ebx
  8010d4:	68 a5 36 80 00       	push   $0x8036a5
  8010d9:	ff 75 0c             	pushl  0xc(%ebp)
  8010dc:	ff 75 08             	pushl  0x8(%ebp)
  8010df:	e8 70 02 00 00       	call   801354 <printfmt>
  8010e4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8010e7:	e9 5b 02 00 00       	jmp    801347 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8010ec:	56                   	push   %esi
  8010ed:	68 ae 36 80 00       	push   $0x8036ae
  8010f2:	ff 75 0c             	pushl  0xc(%ebp)
  8010f5:	ff 75 08             	pushl  0x8(%ebp)
  8010f8:	e8 57 02 00 00       	call   801354 <printfmt>
  8010fd:	83 c4 10             	add    $0x10,%esp
			break;
  801100:	e9 42 02 00 00       	jmp    801347 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801105:	8b 45 14             	mov    0x14(%ebp),%eax
  801108:	83 c0 04             	add    $0x4,%eax
  80110b:	89 45 14             	mov    %eax,0x14(%ebp)
  80110e:	8b 45 14             	mov    0x14(%ebp),%eax
  801111:	83 e8 04             	sub    $0x4,%eax
  801114:	8b 30                	mov    (%eax),%esi
  801116:	85 f6                	test   %esi,%esi
  801118:	75 05                	jne    80111f <vprintfmt+0x1a6>
				p = "(null)";
  80111a:	be b1 36 80 00       	mov    $0x8036b1,%esi
			if (width > 0 && padc != '-')
  80111f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801123:	7e 6d                	jle    801192 <vprintfmt+0x219>
  801125:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801129:	74 67                	je     801192 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80112b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80112e:	83 ec 08             	sub    $0x8,%esp
  801131:	50                   	push   %eax
  801132:	56                   	push   %esi
  801133:	e8 26 05 00 00       	call   80165e <strnlen>
  801138:	83 c4 10             	add    $0x10,%esp
  80113b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80113e:	eb 16                	jmp    801156 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801140:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801144:	83 ec 08             	sub    $0x8,%esp
  801147:	ff 75 0c             	pushl  0xc(%ebp)
  80114a:	50                   	push   %eax
  80114b:	8b 45 08             	mov    0x8(%ebp),%eax
  80114e:	ff d0                	call   *%eax
  801150:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801153:	ff 4d e4             	decl   -0x1c(%ebp)
  801156:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80115a:	7f e4                	jg     801140 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80115c:	eb 34                	jmp    801192 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80115e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801162:	74 1c                	je     801180 <vprintfmt+0x207>
  801164:	83 fb 1f             	cmp    $0x1f,%ebx
  801167:	7e 05                	jle    80116e <vprintfmt+0x1f5>
  801169:	83 fb 7e             	cmp    $0x7e,%ebx
  80116c:	7e 12                	jle    801180 <vprintfmt+0x207>
					putch('?', putdat);
  80116e:	83 ec 08             	sub    $0x8,%esp
  801171:	ff 75 0c             	pushl  0xc(%ebp)
  801174:	6a 3f                	push   $0x3f
  801176:	8b 45 08             	mov    0x8(%ebp),%eax
  801179:	ff d0                	call   *%eax
  80117b:	83 c4 10             	add    $0x10,%esp
  80117e:	eb 0f                	jmp    80118f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801180:	83 ec 08             	sub    $0x8,%esp
  801183:	ff 75 0c             	pushl  0xc(%ebp)
  801186:	53                   	push   %ebx
  801187:	8b 45 08             	mov    0x8(%ebp),%eax
  80118a:	ff d0                	call   *%eax
  80118c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80118f:	ff 4d e4             	decl   -0x1c(%ebp)
  801192:	89 f0                	mov    %esi,%eax
  801194:	8d 70 01             	lea    0x1(%eax),%esi
  801197:	8a 00                	mov    (%eax),%al
  801199:	0f be d8             	movsbl %al,%ebx
  80119c:	85 db                	test   %ebx,%ebx
  80119e:	74 24                	je     8011c4 <vprintfmt+0x24b>
  8011a0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8011a4:	78 b8                	js     80115e <vprintfmt+0x1e5>
  8011a6:	ff 4d e0             	decl   -0x20(%ebp)
  8011a9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8011ad:	79 af                	jns    80115e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8011af:	eb 13                	jmp    8011c4 <vprintfmt+0x24b>
				putch(' ', putdat);
  8011b1:	83 ec 08             	sub    $0x8,%esp
  8011b4:	ff 75 0c             	pushl  0xc(%ebp)
  8011b7:	6a 20                	push   $0x20
  8011b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bc:	ff d0                	call   *%eax
  8011be:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8011c1:	ff 4d e4             	decl   -0x1c(%ebp)
  8011c4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011c8:	7f e7                	jg     8011b1 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8011ca:	e9 78 01 00 00       	jmp    801347 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8011cf:	83 ec 08             	sub    $0x8,%esp
  8011d2:	ff 75 e8             	pushl  -0x18(%ebp)
  8011d5:	8d 45 14             	lea    0x14(%ebp),%eax
  8011d8:	50                   	push   %eax
  8011d9:	e8 3c fd ff ff       	call   800f1a <getint>
  8011de:	83 c4 10             	add    $0x10,%esp
  8011e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8011e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011ed:	85 d2                	test   %edx,%edx
  8011ef:	79 23                	jns    801214 <vprintfmt+0x29b>
				putch('-', putdat);
  8011f1:	83 ec 08             	sub    $0x8,%esp
  8011f4:	ff 75 0c             	pushl  0xc(%ebp)
  8011f7:	6a 2d                	push   $0x2d
  8011f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fc:	ff d0                	call   *%eax
  8011fe:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801201:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801204:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801207:	f7 d8                	neg    %eax
  801209:	83 d2 00             	adc    $0x0,%edx
  80120c:	f7 da                	neg    %edx
  80120e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801211:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801214:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80121b:	e9 bc 00 00 00       	jmp    8012dc <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801220:	83 ec 08             	sub    $0x8,%esp
  801223:	ff 75 e8             	pushl  -0x18(%ebp)
  801226:	8d 45 14             	lea    0x14(%ebp),%eax
  801229:	50                   	push   %eax
  80122a:	e8 84 fc ff ff       	call   800eb3 <getuint>
  80122f:	83 c4 10             	add    $0x10,%esp
  801232:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801235:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801238:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80123f:	e9 98 00 00 00       	jmp    8012dc <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801244:	83 ec 08             	sub    $0x8,%esp
  801247:	ff 75 0c             	pushl  0xc(%ebp)
  80124a:	6a 58                	push   $0x58
  80124c:	8b 45 08             	mov    0x8(%ebp),%eax
  80124f:	ff d0                	call   *%eax
  801251:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801254:	83 ec 08             	sub    $0x8,%esp
  801257:	ff 75 0c             	pushl  0xc(%ebp)
  80125a:	6a 58                	push   $0x58
  80125c:	8b 45 08             	mov    0x8(%ebp),%eax
  80125f:	ff d0                	call   *%eax
  801261:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801264:	83 ec 08             	sub    $0x8,%esp
  801267:	ff 75 0c             	pushl  0xc(%ebp)
  80126a:	6a 58                	push   $0x58
  80126c:	8b 45 08             	mov    0x8(%ebp),%eax
  80126f:	ff d0                	call   *%eax
  801271:	83 c4 10             	add    $0x10,%esp
			break;
  801274:	e9 ce 00 00 00       	jmp    801347 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  801279:	83 ec 08             	sub    $0x8,%esp
  80127c:	ff 75 0c             	pushl  0xc(%ebp)
  80127f:	6a 30                	push   $0x30
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	ff d0                	call   *%eax
  801286:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801289:	83 ec 08             	sub    $0x8,%esp
  80128c:	ff 75 0c             	pushl  0xc(%ebp)
  80128f:	6a 78                	push   $0x78
  801291:	8b 45 08             	mov    0x8(%ebp),%eax
  801294:	ff d0                	call   *%eax
  801296:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801299:	8b 45 14             	mov    0x14(%ebp),%eax
  80129c:	83 c0 04             	add    $0x4,%eax
  80129f:	89 45 14             	mov    %eax,0x14(%ebp)
  8012a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a5:	83 e8 04             	sub    $0x4,%eax
  8012a8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8012aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8012b4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8012bb:	eb 1f                	jmp    8012dc <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8012bd:	83 ec 08             	sub    $0x8,%esp
  8012c0:	ff 75 e8             	pushl  -0x18(%ebp)
  8012c3:	8d 45 14             	lea    0x14(%ebp),%eax
  8012c6:	50                   	push   %eax
  8012c7:	e8 e7 fb ff ff       	call   800eb3 <getuint>
  8012cc:	83 c4 10             	add    $0x10,%esp
  8012cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8012d5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8012dc:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8012e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012e3:	83 ec 04             	sub    $0x4,%esp
  8012e6:	52                   	push   %edx
  8012e7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8012ea:	50                   	push   %eax
  8012eb:	ff 75 f4             	pushl  -0xc(%ebp)
  8012ee:	ff 75 f0             	pushl  -0x10(%ebp)
  8012f1:	ff 75 0c             	pushl  0xc(%ebp)
  8012f4:	ff 75 08             	pushl  0x8(%ebp)
  8012f7:	e8 00 fb ff ff       	call   800dfc <printnum>
  8012fc:	83 c4 20             	add    $0x20,%esp
			break;
  8012ff:	eb 46                	jmp    801347 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801301:	83 ec 08             	sub    $0x8,%esp
  801304:	ff 75 0c             	pushl  0xc(%ebp)
  801307:	53                   	push   %ebx
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	ff d0                	call   *%eax
  80130d:	83 c4 10             	add    $0x10,%esp
			break;
  801310:	eb 35                	jmp    801347 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  801312:	c6 05 40 40 80 00 00 	movb   $0x0,0x804040
			break;
  801319:	eb 2c                	jmp    801347 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  80131b:	c6 05 40 40 80 00 01 	movb   $0x1,0x804040
			break;
  801322:	eb 23                	jmp    801347 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801324:	83 ec 08             	sub    $0x8,%esp
  801327:	ff 75 0c             	pushl  0xc(%ebp)
  80132a:	6a 25                	push   $0x25
  80132c:	8b 45 08             	mov    0x8(%ebp),%eax
  80132f:	ff d0                	call   *%eax
  801331:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801334:	ff 4d 10             	decl   0x10(%ebp)
  801337:	eb 03                	jmp    80133c <vprintfmt+0x3c3>
  801339:	ff 4d 10             	decl   0x10(%ebp)
  80133c:	8b 45 10             	mov    0x10(%ebp),%eax
  80133f:	48                   	dec    %eax
  801340:	8a 00                	mov    (%eax),%al
  801342:	3c 25                	cmp    $0x25,%al
  801344:	75 f3                	jne    801339 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  801346:	90                   	nop
		}
	}
  801347:	e9 35 fc ff ff       	jmp    800f81 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80134c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80134d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801350:	5b                   	pop    %ebx
  801351:	5e                   	pop    %esi
  801352:	5d                   	pop    %ebp
  801353:	c3                   	ret    

00801354 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801354:	55                   	push   %ebp
  801355:	89 e5                	mov    %esp,%ebp
  801357:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80135a:	8d 45 10             	lea    0x10(%ebp),%eax
  80135d:	83 c0 04             	add    $0x4,%eax
  801360:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801363:	8b 45 10             	mov    0x10(%ebp),%eax
  801366:	ff 75 f4             	pushl  -0xc(%ebp)
  801369:	50                   	push   %eax
  80136a:	ff 75 0c             	pushl  0xc(%ebp)
  80136d:	ff 75 08             	pushl  0x8(%ebp)
  801370:	e8 04 fc ff ff       	call   800f79 <vprintfmt>
  801375:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801378:	90                   	nop
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80137e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801381:	8b 40 08             	mov    0x8(%eax),%eax
  801384:	8d 50 01             	lea    0x1(%eax),%edx
  801387:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80138d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801390:	8b 10                	mov    (%eax),%edx
  801392:	8b 45 0c             	mov    0xc(%ebp),%eax
  801395:	8b 40 04             	mov    0x4(%eax),%eax
  801398:	39 c2                	cmp    %eax,%edx
  80139a:	73 12                	jae    8013ae <sprintputch+0x33>
		*b->buf++ = ch;
  80139c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139f:	8b 00                	mov    (%eax),%eax
  8013a1:	8d 48 01             	lea    0x1(%eax),%ecx
  8013a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a7:	89 0a                	mov    %ecx,(%edx)
  8013a9:	8b 55 08             	mov    0x8(%ebp),%edx
  8013ac:	88 10                	mov    %dl,(%eax)
}
  8013ae:	90                   	nop
  8013af:	5d                   	pop    %ebp
  8013b0:	c3                   	ret    

008013b1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8013b1:	55                   	push   %ebp
  8013b2:	89 e5                	mov    %esp,%ebp
  8013b4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8013bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	01 d0                	add    %edx,%eax
  8013c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8013d2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013d6:	74 06                	je     8013de <vsnprintf+0x2d>
  8013d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013dc:	7f 07                	jg     8013e5 <vsnprintf+0x34>
		return -E_INVAL;
  8013de:	b8 03 00 00 00       	mov    $0x3,%eax
  8013e3:	eb 20                	jmp    801405 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8013e5:	ff 75 14             	pushl  0x14(%ebp)
  8013e8:	ff 75 10             	pushl  0x10(%ebp)
  8013eb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8013ee:	50                   	push   %eax
  8013ef:	68 7b 13 80 00       	push   $0x80137b
  8013f4:	e8 80 fb ff ff       	call   800f79 <vprintfmt>
  8013f9:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8013fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013ff:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801402:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801405:	c9                   	leave  
  801406:	c3                   	ret    

00801407 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801407:	55                   	push   %ebp
  801408:	89 e5                	mov    %esp,%ebp
  80140a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80140d:	8d 45 10             	lea    0x10(%ebp),%eax
  801410:	83 c0 04             	add    $0x4,%eax
  801413:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801416:	8b 45 10             	mov    0x10(%ebp),%eax
  801419:	ff 75 f4             	pushl  -0xc(%ebp)
  80141c:	50                   	push   %eax
  80141d:	ff 75 0c             	pushl  0xc(%ebp)
  801420:	ff 75 08             	pushl  0x8(%ebp)
  801423:	e8 89 ff ff ff       	call   8013b1 <vsnprintf>
  801428:	83 c4 10             	add    $0x10,%esp
  80142b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80142e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801431:	c9                   	leave  
  801432:	c3                   	ret    

00801433 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801433:	55                   	push   %ebp
  801434:	89 e5                	mov    %esp,%ebp
  801436:	83 ec 18             	sub    $0x18,%esp
	int i, c, echoing;

	if (prompt != NULL)
  801439:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80143d:	74 13                	je     801452 <readline+0x1f>
		cprintf("%s", prompt);
  80143f:	83 ec 08             	sub    $0x8,%esp
  801442:	ff 75 08             	pushl  0x8(%ebp)
  801445:	68 28 38 80 00       	push   $0x803828
  80144a:	e8 0b f9 ff ff       	call   800d5a <cprintf>
  80144f:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801452:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801459:	83 ec 0c             	sub    $0xc,%esp
  80145c:	6a 00                	push   $0x0
  80145e:	e8 ad f5 ff ff       	call   800a10 <iscons>
  801463:	83 c4 10             	add    $0x10,%esp
  801466:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801469:	e8 89 f5 ff ff       	call   8009f7 <getchar>
  80146e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801471:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801475:	79 22                	jns    801499 <readline+0x66>
			if (c != -E_EOF)
  801477:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80147b:	0f 84 ad 00 00 00    	je     80152e <readline+0xfb>
				cprintf("read error: %e\n", c);
  801481:	83 ec 08             	sub    $0x8,%esp
  801484:	ff 75 ec             	pushl  -0x14(%ebp)
  801487:	68 2b 38 80 00       	push   $0x80382b
  80148c:	e8 c9 f8 ff ff       	call   800d5a <cprintf>
  801491:	83 c4 10             	add    $0x10,%esp
			break;
  801494:	e9 95 00 00 00       	jmp    80152e <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801499:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80149d:	7e 34                	jle    8014d3 <readline+0xa0>
  80149f:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8014a6:	7f 2b                	jg     8014d3 <readline+0xa0>
			if (echoing)
  8014a8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8014ac:	74 0e                	je     8014bc <readline+0x89>
				cputchar(c);
  8014ae:	83 ec 0c             	sub    $0xc,%esp
  8014b1:	ff 75 ec             	pushl  -0x14(%ebp)
  8014b4:	e8 1f f5 ff ff       	call   8009d8 <cputchar>
  8014b9:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8014bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014bf:	8d 50 01             	lea    0x1(%eax),%edx
  8014c2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8014c5:	89 c2                	mov    %eax,%edx
  8014c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ca:	01 d0                	add    %edx,%eax
  8014cc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014cf:	88 10                	mov    %dl,(%eax)
  8014d1:	eb 56                	jmp    801529 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8014d3:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8014d7:	75 1f                	jne    8014f8 <readline+0xc5>
  8014d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8014dd:	7e 19                	jle    8014f8 <readline+0xc5>
			if (echoing)
  8014df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8014e3:	74 0e                	je     8014f3 <readline+0xc0>
				cputchar(c);
  8014e5:	83 ec 0c             	sub    $0xc,%esp
  8014e8:	ff 75 ec             	pushl  -0x14(%ebp)
  8014eb:	e8 e8 f4 ff ff       	call   8009d8 <cputchar>
  8014f0:	83 c4 10             	add    $0x10,%esp

			i--;
  8014f3:	ff 4d f4             	decl   -0xc(%ebp)
  8014f6:	eb 31                	jmp    801529 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8014f8:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8014fc:	74 0a                	je     801508 <readline+0xd5>
  8014fe:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801502:	0f 85 61 ff ff ff    	jne    801469 <readline+0x36>
			if (echoing)
  801508:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80150c:	74 0e                	je     80151c <readline+0xe9>
				cputchar(c);
  80150e:	83 ec 0c             	sub    $0xc,%esp
  801511:	ff 75 ec             	pushl  -0x14(%ebp)
  801514:	e8 bf f4 ff ff       	call   8009d8 <cputchar>
  801519:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80151c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80151f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801522:	01 d0                	add    %edx,%eax
  801524:	c6 00 00             	movb   $0x0,(%eax)
			break;
  801527:	eb 06                	jmp    80152f <readline+0xfc>
		}
	}
  801529:	e9 3b ff ff ff       	jmp    801469 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			break;
  80152e:	90                   	nop

			buf[i] = 0;
			break;
		}
	}
}
  80152f:	90                   	nop
  801530:	c9                   	leave  
  801531:	c3                   	ret    

00801532 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801532:	55                   	push   %ebp
  801533:	89 e5                	mov    %esp,%ebp
  801535:	83 ec 18             	sub    $0x18,%esp
	sys_lock_cons();
  801538:	e8 a1 0a 00 00       	call   801fde <sys_lock_cons>
	{
		int i, c, echoing;

		if (prompt != NULL)
  80153d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801541:	74 13                	je     801556 <atomic_readline+0x24>
			cprintf("%s", prompt);
  801543:	83 ec 08             	sub    $0x8,%esp
  801546:	ff 75 08             	pushl  0x8(%ebp)
  801549:	68 28 38 80 00       	push   $0x803828
  80154e:	e8 07 f8 ff ff       	call   800d5a <cprintf>
  801553:	83 c4 10             	add    $0x10,%esp

		i = 0;
  801556:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		echoing = iscons(0);
  80155d:	83 ec 0c             	sub    $0xc,%esp
  801560:	6a 00                	push   $0x0
  801562:	e8 a9 f4 ff ff       	call   800a10 <iscons>
  801567:	83 c4 10             	add    $0x10,%esp
  80156a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (1) {
			c = getchar();
  80156d:	e8 85 f4 ff ff       	call   8009f7 <getchar>
  801572:	89 45 ec             	mov    %eax,-0x14(%ebp)
			if (c < 0) {
  801575:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801579:	79 22                	jns    80159d <atomic_readline+0x6b>
				if (c != -E_EOF)
  80157b:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80157f:	0f 84 ad 00 00 00    	je     801632 <atomic_readline+0x100>
					cprintf("read error: %e\n", c);
  801585:	83 ec 08             	sub    $0x8,%esp
  801588:	ff 75 ec             	pushl  -0x14(%ebp)
  80158b:	68 2b 38 80 00       	push   $0x80382b
  801590:	e8 c5 f7 ff ff       	call   800d5a <cprintf>
  801595:	83 c4 10             	add    $0x10,%esp
				break;
  801598:	e9 95 00 00 00       	jmp    801632 <atomic_readline+0x100>
			} else if (c >= ' ' && i < BUFLEN-1) {
  80159d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8015a1:	7e 34                	jle    8015d7 <atomic_readline+0xa5>
  8015a3:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8015aa:	7f 2b                	jg     8015d7 <atomic_readline+0xa5>
				if (echoing)
  8015ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8015b0:	74 0e                	je     8015c0 <atomic_readline+0x8e>
					cputchar(c);
  8015b2:	83 ec 0c             	sub    $0xc,%esp
  8015b5:	ff 75 ec             	pushl  -0x14(%ebp)
  8015b8:	e8 1b f4 ff ff       	call   8009d8 <cputchar>
  8015bd:	83 c4 10             	add    $0x10,%esp
				buf[i++] = c;
  8015c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015c3:	8d 50 01             	lea    0x1(%eax),%edx
  8015c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8015c9:	89 c2                	mov    %eax,%edx
  8015cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ce:	01 d0                	add    %edx,%eax
  8015d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8015d3:	88 10                	mov    %dl,(%eax)
  8015d5:	eb 56                	jmp    80162d <atomic_readline+0xfb>
			} else if (c == '\b' && i > 0) {
  8015d7:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8015db:	75 1f                	jne    8015fc <atomic_readline+0xca>
  8015dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8015e1:	7e 19                	jle    8015fc <atomic_readline+0xca>
				if (echoing)
  8015e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8015e7:	74 0e                	je     8015f7 <atomic_readline+0xc5>
					cputchar(c);
  8015e9:	83 ec 0c             	sub    $0xc,%esp
  8015ec:	ff 75 ec             	pushl  -0x14(%ebp)
  8015ef:	e8 e4 f3 ff ff       	call   8009d8 <cputchar>
  8015f4:	83 c4 10             	add    $0x10,%esp
				i--;
  8015f7:	ff 4d f4             	decl   -0xc(%ebp)
  8015fa:	eb 31                	jmp    80162d <atomic_readline+0xfb>
			} else if (c == '\n' || c == '\r') {
  8015fc:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801600:	74 0a                	je     80160c <atomic_readline+0xda>
  801602:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801606:	0f 85 61 ff ff ff    	jne    80156d <atomic_readline+0x3b>
				if (echoing)
  80160c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801610:	74 0e                	je     801620 <atomic_readline+0xee>
					cputchar(c);
  801612:	83 ec 0c             	sub    $0xc,%esp
  801615:	ff 75 ec             	pushl  -0x14(%ebp)
  801618:	e8 bb f3 ff ff       	call   8009d8 <cputchar>
  80161d:	83 c4 10             	add    $0x10,%esp
				buf[i] = 0;
  801620:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801623:	8b 45 0c             	mov    0xc(%ebp),%eax
  801626:	01 d0                	add    %edx,%eax
  801628:	c6 00 00             	movb   $0x0,(%eax)
				break;
  80162b:	eb 06                	jmp    801633 <atomic_readline+0x101>
			}
		}
  80162d:	e9 3b ff ff ff       	jmp    80156d <atomic_readline+0x3b>
		while (1) {
			c = getchar();
			if (c < 0) {
				if (c != -E_EOF)
					cprintf("read error: %e\n", c);
				break;
  801632:	90                   	nop
				buf[i] = 0;
				break;
			}
		}
	}
	sys_unlock_cons();
  801633:	e8 c0 09 00 00       	call   801ff8 <sys_unlock_cons>
}
  801638:	90                   	nop
  801639:	c9                   	leave  
  80163a:	c3                   	ret    

0080163b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
  80163e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801641:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801648:	eb 06                	jmp    801650 <strlen+0x15>
		n++;
  80164a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80164d:	ff 45 08             	incl   0x8(%ebp)
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	8a 00                	mov    (%eax),%al
  801655:	84 c0                	test   %al,%al
  801657:	75 f1                	jne    80164a <strlen+0xf>
		n++;
	return n;
  801659:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80165c:	c9                   	leave  
  80165d:	c3                   	ret    

0080165e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80165e:	55                   	push   %ebp
  80165f:	89 e5                	mov    %esp,%ebp
  801661:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801664:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80166b:	eb 09                	jmp    801676 <strnlen+0x18>
		n++;
  80166d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801670:	ff 45 08             	incl   0x8(%ebp)
  801673:	ff 4d 0c             	decl   0xc(%ebp)
  801676:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80167a:	74 09                	je     801685 <strnlen+0x27>
  80167c:	8b 45 08             	mov    0x8(%ebp),%eax
  80167f:	8a 00                	mov    (%eax),%al
  801681:	84 c0                	test   %al,%al
  801683:	75 e8                	jne    80166d <strnlen+0xf>
		n++;
	return n;
  801685:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801688:	c9                   	leave  
  801689:	c3                   	ret    

0080168a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80168a:	55                   	push   %ebp
  80168b:	89 e5                	mov    %esp,%ebp
  80168d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801696:	90                   	nop
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
  80169a:	8d 50 01             	lea    0x1(%eax),%edx
  80169d:	89 55 08             	mov    %edx,0x8(%ebp)
  8016a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016a6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8016a9:	8a 12                	mov    (%edx),%dl
  8016ab:	88 10                	mov    %dl,(%eax)
  8016ad:	8a 00                	mov    (%eax),%al
  8016af:	84 c0                	test   %al,%al
  8016b1:	75 e4                	jne    801697 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8016b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016b6:	c9                   	leave  
  8016b7:	c3                   	ret    

008016b8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8016b8:	55                   	push   %ebp
  8016b9:	89 e5                	mov    %esp,%ebp
  8016bb:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8016c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016cb:	eb 1f                	jmp    8016ec <strncpy+0x34>
		*dst++ = *src;
  8016cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d0:	8d 50 01             	lea    0x1(%eax),%edx
  8016d3:	89 55 08             	mov    %edx,0x8(%ebp)
  8016d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d9:	8a 12                	mov    (%edx),%dl
  8016db:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8016dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e0:	8a 00                	mov    (%eax),%al
  8016e2:	84 c0                	test   %al,%al
  8016e4:	74 03                	je     8016e9 <strncpy+0x31>
			src++;
  8016e6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8016e9:	ff 45 fc             	incl   -0x4(%ebp)
  8016ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016ef:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016f2:	72 d9                	jb     8016cd <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8016f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016f7:	c9                   	leave  
  8016f8:	c3                   	ret    

008016f9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8016f9:	55                   	push   %ebp
  8016fa:	89 e5                	mov    %esp,%ebp
  8016fc:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8016ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801702:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801705:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801709:	74 30                	je     80173b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80170b:	eb 16                	jmp    801723 <strlcpy+0x2a>
			*dst++ = *src++;
  80170d:	8b 45 08             	mov    0x8(%ebp),%eax
  801710:	8d 50 01             	lea    0x1(%eax),%edx
  801713:	89 55 08             	mov    %edx,0x8(%ebp)
  801716:	8b 55 0c             	mov    0xc(%ebp),%edx
  801719:	8d 4a 01             	lea    0x1(%edx),%ecx
  80171c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80171f:	8a 12                	mov    (%edx),%dl
  801721:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801723:	ff 4d 10             	decl   0x10(%ebp)
  801726:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80172a:	74 09                	je     801735 <strlcpy+0x3c>
  80172c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172f:	8a 00                	mov    (%eax),%al
  801731:	84 c0                	test   %al,%al
  801733:	75 d8                	jne    80170d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801735:	8b 45 08             	mov    0x8(%ebp),%eax
  801738:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80173b:	8b 55 08             	mov    0x8(%ebp),%edx
  80173e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801741:	29 c2                	sub    %eax,%edx
  801743:	89 d0                	mov    %edx,%eax
}
  801745:	c9                   	leave  
  801746:	c3                   	ret    

00801747 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801747:	55                   	push   %ebp
  801748:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80174a:	eb 06                	jmp    801752 <strcmp+0xb>
		p++, q++;
  80174c:	ff 45 08             	incl   0x8(%ebp)
  80174f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801752:	8b 45 08             	mov    0x8(%ebp),%eax
  801755:	8a 00                	mov    (%eax),%al
  801757:	84 c0                	test   %al,%al
  801759:	74 0e                	je     801769 <strcmp+0x22>
  80175b:	8b 45 08             	mov    0x8(%ebp),%eax
  80175e:	8a 10                	mov    (%eax),%dl
  801760:	8b 45 0c             	mov    0xc(%ebp),%eax
  801763:	8a 00                	mov    (%eax),%al
  801765:	38 c2                	cmp    %al,%dl
  801767:	74 e3                	je     80174c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801769:	8b 45 08             	mov    0x8(%ebp),%eax
  80176c:	8a 00                	mov    (%eax),%al
  80176e:	0f b6 d0             	movzbl %al,%edx
  801771:	8b 45 0c             	mov    0xc(%ebp),%eax
  801774:	8a 00                	mov    (%eax),%al
  801776:	0f b6 c0             	movzbl %al,%eax
  801779:	29 c2                	sub    %eax,%edx
  80177b:	89 d0                	mov    %edx,%eax
}
  80177d:	5d                   	pop    %ebp
  80177e:	c3                   	ret    

0080177f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80177f:	55                   	push   %ebp
  801780:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801782:	eb 09                	jmp    80178d <strncmp+0xe>
		n--, p++, q++;
  801784:	ff 4d 10             	decl   0x10(%ebp)
  801787:	ff 45 08             	incl   0x8(%ebp)
  80178a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80178d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801791:	74 17                	je     8017aa <strncmp+0x2b>
  801793:	8b 45 08             	mov    0x8(%ebp),%eax
  801796:	8a 00                	mov    (%eax),%al
  801798:	84 c0                	test   %al,%al
  80179a:	74 0e                	je     8017aa <strncmp+0x2b>
  80179c:	8b 45 08             	mov    0x8(%ebp),%eax
  80179f:	8a 10                	mov    (%eax),%dl
  8017a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a4:	8a 00                	mov    (%eax),%al
  8017a6:	38 c2                	cmp    %al,%dl
  8017a8:	74 da                	je     801784 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8017aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017ae:	75 07                	jne    8017b7 <strncmp+0x38>
		return 0;
  8017b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8017b5:	eb 14                	jmp    8017cb <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8017b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ba:	8a 00                	mov    (%eax),%al
  8017bc:	0f b6 d0             	movzbl %al,%edx
  8017bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c2:	8a 00                	mov    (%eax),%al
  8017c4:	0f b6 c0             	movzbl %al,%eax
  8017c7:	29 c2                	sub    %eax,%edx
  8017c9:	89 d0                	mov    %edx,%eax
}
  8017cb:	5d                   	pop    %ebp
  8017cc:	c3                   	ret    

008017cd <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8017cd:	55                   	push   %ebp
  8017ce:	89 e5                	mov    %esp,%ebp
  8017d0:	83 ec 04             	sub    $0x4,%esp
  8017d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017d9:	eb 12                	jmp    8017ed <strchr+0x20>
		if (*s == c)
  8017db:	8b 45 08             	mov    0x8(%ebp),%eax
  8017de:	8a 00                	mov    (%eax),%al
  8017e0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8017e3:	75 05                	jne    8017ea <strchr+0x1d>
			return (char *) s;
  8017e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e8:	eb 11                	jmp    8017fb <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8017ea:	ff 45 08             	incl   0x8(%ebp)
  8017ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f0:	8a 00                	mov    (%eax),%al
  8017f2:	84 c0                	test   %al,%al
  8017f4:	75 e5                	jne    8017db <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8017f6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017fb:	c9                   	leave  
  8017fc:	c3                   	ret    

008017fd <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
  801800:	83 ec 04             	sub    $0x4,%esp
  801803:	8b 45 0c             	mov    0xc(%ebp),%eax
  801806:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801809:	eb 0d                	jmp    801818 <strfind+0x1b>
		if (*s == c)
  80180b:	8b 45 08             	mov    0x8(%ebp),%eax
  80180e:	8a 00                	mov    (%eax),%al
  801810:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801813:	74 0e                	je     801823 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801815:	ff 45 08             	incl   0x8(%ebp)
  801818:	8b 45 08             	mov    0x8(%ebp),%eax
  80181b:	8a 00                	mov    (%eax),%al
  80181d:	84 c0                	test   %al,%al
  80181f:	75 ea                	jne    80180b <strfind+0xe>
  801821:	eb 01                	jmp    801824 <strfind+0x27>
		if (*s == c)
			break;
  801823:	90                   	nop
	return (char *) s;
  801824:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801827:	c9                   	leave  
  801828:	c3                   	ret    

00801829 <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
  80182c:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  80182f:	8b 45 08             	mov    0x8(%ebp),%eax
  801832:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  801835:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801839:	76 63                	jbe    80189e <memset+0x75>
		uint64 data_block = c;
  80183b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80183e:	99                   	cltd   
  80183f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801842:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  801845:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801848:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80184b:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  80184f:	c1 e0 08             	shl    $0x8,%eax
  801852:	09 45 f0             	or     %eax,-0x10(%ebp)
  801855:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  801858:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80185b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80185e:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801862:	c1 e0 10             	shl    $0x10,%eax
  801865:	09 45 f0             	or     %eax,-0x10(%ebp)
  801868:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  80186b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80186e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801871:	89 c2                	mov    %eax,%edx
  801873:	b8 00 00 00 00       	mov    $0x0,%eax
  801878:	09 45 f0             	or     %eax,-0x10(%ebp)
  80187b:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  80187e:	eb 18                	jmp    801898 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801880:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801883:	8d 41 08             	lea    0x8(%ecx),%eax
  801886:	89 45 fc             	mov    %eax,-0x4(%ebp)
  801889:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80188c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80188f:	89 01                	mov    %eax,(%ecx)
  801891:	89 51 04             	mov    %edx,0x4(%ecx)
  801894:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801898:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80189c:	77 e2                	ja     801880 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  80189e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018a2:	74 23                	je     8018c7 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  8018a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  8018aa:	eb 0e                	jmp    8018ba <memset+0x91>
			*p8++ = (uint8)c;
  8018ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018af:	8d 50 01             	lea    0x1(%eax),%edx
  8018b2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b8:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  8018ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8018bd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018c0:	89 55 10             	mov    %edx,0x10(%ebp)
  8018c3:	85 c0                	test   %eax,%eax
  8018c5:	75 e5                	jne    8018ac <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8018c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018ca:	c9                   	leave  
  8018cb:	c3                   	ret    

008018cc <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8018cc:	55                   	push   %ebp
  8018cd:	89 e5                	mov    %esp,%ebp
  8018cf:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8018d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8018d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018db:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8018de:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8018e2:	76 24                	jbe    801908 <memcpy+0x3c>
		while(n >= 8){
  8018e4:	eb 1c                	jmp    801902 <memcpy+0x36>
			*d64 = *s64;
  8018e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018e9:	8b 50 04             	mov    0x4(%eax),%edx
  8018ec:	8b 00                	mov    (%eax),%eax
  8018ee:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018f1:	89 01                	mov    %eax,(%ecx)
  8018f3:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8018f6:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8018fa:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8018fe:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  801902:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  801906:	77 de                	ja     8018e6 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  801908:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80190c:	74 31                	je     80193f <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  80190e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801911:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  801914:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801917:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  80191a:	eb 16                	jmp    801932 <memcpy+0x66>
			*d8++ = *s8++;
  80191c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80191f:	8d 50 01             	lea    0x1(%eax),%edx
  801922:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801925:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801928:	8d 4a 01             	lea    0x1(%edx),%ecx
  80192b:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80192e:	8a 12                	mov    (%edx),%dl
  801930:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801932:	8b 45 10             	mov    0x10(%ebp),%eax
  801935:	8d 50 ff             	lea    -0x1(%eax),%edx
  801938:	89 55 10             	mov    %edx,0x10(%ebp)
  80193b:	85 c0                	test   %eax,%eax
  80193d:	75 dd                	jne    80191c <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  80193f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801942:	c9                   	leave  
  801943:	c3                   	ret    

00801944 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
  801947:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80194a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801950:	8b 45 08             	mov    0x8(%ebp),%eax
  801953:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801956:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801959:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80195c:	73 50                	jae    8019ae <memmove+0x6a>
  80195e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801961:	8b 45 10             	mov    0x10(%ebp),%eax
  801964:	01 d0                	add    %edx,%eax
  801966:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801969:	76 43                	jbe    8019ae <memmove+0x6a>
		s += n;
  80196b:	8b 45 10             	mov    0x10(%ebp),%eax
  80196e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801971:	8b 45 10             	mov    0x10(%ebp),%eax
  801974:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801977:	eb 10                	jmp    801989 <memmove+0x45>
			*--d = *--s;
  801979:	ff 4d f8             	decl   -0x8(%ebp)
  80197c:	ff 4d fc             	decl   -0x4(%ebp)
  80197f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801982:	8a 10                	mov    (%eax),%dl
  801984:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801987:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801989:	8b 45 10             	mov    0x10(%ebp),%eax
  80198c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80198f:	89 55 10             	mov    %edx,0x10(%ebp)
  801992:	85 c0                	test   %eax,%eax
  801994:	75 e3                	jne    801979 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801996:	eb 23                	jmp    8019bb <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801998:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80199b:	8d 50 01             	lea    0x1(%eax),%edx
  80199e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8019a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019a4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8019a7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8019aa:	8a 12                	mov    (%edx),%dl
  8019ac:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8019ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8019b1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8019b4:	89 55 10             	mov    %edx,0x10(%ebp)
  8019b7:	85 c0                	test   %eax,%eax
  8019b9:	75 dd                	jne    801998 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8019be:	c9                   	leave  
  8019bf:	c3                   	ret    

008019c0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8019c0:	55                   	push   %ebp
  8019c1:	89 e5                	mov    %esp,%ebp
  8019c3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8019c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8019cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019cf:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8019d2:	eb 2a                	jmp    8019fe <memcmp+0x3e>
		if (*s1 != *s2)
  8019d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019d7:	8a 10                	mov    (%eax),%dl
  8019d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019dc:	8a 00                	mov    (%eax),%al
  8019de:	38 c2                	cmp    %al,%dl
  8019e0:	74 16                	je     8019f8 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8019e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019e5:	8a 00                	mov    (%eax),%al
  8019e7:	0f b6 d0             	movzbl %al,%edx
  8019ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019ed:	8a 00                	mov    (%eax),%al
  8019ef:	0f b6 c0             	movzbl %al,%eax
  8019f2:	29 c2                	sub    %eax,%edx
  8019f4:	89 d0                	mov    %edx,%eax
  8019f6:	eb 18                	jmp    801a10 <memcmp+0x50>
		s1++, s2++;
  8019f8:	ff 45 fc             	incl   -0x4(%ebp)
  8019fb:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8019fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801a01:	8d 50 ff             	lea    -0x1(%eax),%edx
  801a04:	89 55 10             	mov    %edx,0x10(%ebp)
  801a07:	85 c0                	test   %eax,%eax
  801a09:	75 c9                	jne    8019d4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801a0b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a10:	c9                   	leave  
  801a11:	c3                   	ret    

00801a12 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801a12:	55                   	push   %ebp
  801a13:	89 e5                	mov    %esp,%ebp
  801a15:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801a18:	8b 55 08             	mov    0x8(%ebp),%edx
  801a1b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a1e:	01 d0                	add    %edx,%eax
  801a20:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801a23:	eb 15                	jmp    801a3a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801a25:	8b 45 08             	mov    0x8(%ebp),%eax
  801a28:	8a 00                	mov    (%eax),%al
  801a2a:	0f b6 d0             	movzbl %al,%edx
  801a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a30:	0f b6 c0             	movzbl %al,%eax
  801a33:	39 c2                	cmp    %eax,%edx
  801a35:	74 0d                	je     801a44 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801a37:	ff 45 08             	incl   0x8(%ebp)
  801a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801a40:	72 e3                	jb     801a25 <memfind+0x13>
  801a42:	eb 01                	jmp    801a45 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801a44:	90                   	nop
	return (void *) s;
  801a45:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a48:	c9                   	leave  
  801a49:	c3                   	ret    

00801a4a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801a4a:	55                   	push   %ebp
  801a4b:	89 e5                	mov    %esp,%ebp
  801a4d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801a50:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801a57:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801a5e:	eb 03                	jmp    801a63 <strtol+0x19>
		s++;
  801a60:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	8a 00                	mov    (%eax),%al
  801a68:	3c 20                	cmp    $0x20,%al
  801a6a:	74 f4                	je     801a60 <strtol+0x16>
  801a6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6f:	8a 00                	mov    (%eax),%al
  801a71:	3c 09                	cmp    $0x9,%al
  801a73:	74 eb                	je     801a60 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801a75:	8b 45 08             	mov    0x8(%ebp),%eax
  801a78:	8a 00                	mov    (%eax),%al
  801a7a:	3c 2b                	cmp    $0x2b,%al
  801a7c:	75 05                	jne    801a83 <strtol+0x39>
		s++;
  801a7e:	ff 45 08             	incl   0x8(%ebp)
  801a81:	eb 13                	jmp    801a96 <strtol+0x4c>
	else if (*s == '-')
  801a83:	8b 45 08             	mov    0x8(%ebp),%eax
  801a86:	8a 00                	mov    (%eax),%al
  801a88:	3c 2d                	cmp    $0x2d,%al
  801a8a:	75 0a                	jne    801a96 <strtol+0x4c>
		s++, neg = 1;
  801a8c:	ff 45 08             	incl   0x8(%ebp)
  801a8f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801a96:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a9a:	74 06                	je     801aa2 <strtol+0x58>
  801a9c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801aa0:	75 20                	jne    801ac2 <strtol+0x78>
  801aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa5:	8a 00                	mov    (%eax),%al
  801aa7:	3c 30                	cmp    $0x30,%al
  801aa9:	75 17                	jne    801ac2 <strtol+0x78>
  801aab:	8b 45 08             	mov    0x8(%ebp),%eax
  801aae:	40                   	inc    %eax
  801aaf:	8a 00                	mov    (%eax),%al
  801ab1:	3c 78                	cmp    $0x78,%al
  801ab3:	75 0d                	jne    801ac2 <strtol+0x78>
		s += 2, base = 16;
  801ab5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801ab9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801ac0:	eb 28                	jmp    801aea <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801ac2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801ac6:	75 15                	jne    801add <strtol+0x93>
  801ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  801acb:	8a 00                	mov    (%eax),%al
  801acd:	3c 30                	cmp    $0x30,%al
  801acf:	75 0c                	jne    801add <strtol+0x93>
		s++, base = 8;
  801ad1:	ff 45 08             	incl   0x8(%ebp)
  801ad4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801adb:	eb 0d                	jmp    801aea <strtol+0xa0>
	else if (base == 0)
  801add:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801ae1:	75 07                	jne    801aea <strtol+0xa0>
		base = 10;
  801ae3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801aea:	8b 45 08             	mov    0x8(%ebp),%eax
  801aed:	8a 00                	mov    (%eax),%al
  801aef:	3c 2f                	cmp    $0x2f,%al
  801af1:	7e 19                	jle    801b0c <strtol+0xc2>
  801af3:	8b 45 08             	mov    0x8(%ebp),%eax
  801af6:	8a 00                	mov    (%eax),%al
  801af8:	3c 39                	cmp    $0x39,%al
  801afa:	7f 10                	jg     801b0c <strtol+0xc2>
			dig = *s - '0';
  801afc:	8b 45 08             	mov    0x8(%ebp),%eax
  801aff:	8a 00                	mov    (%eax),%al
  801b01:	0f be c0             	movsbl %al,%eax
  801b04:	83 e8 30             	sub    $0x30,%eax
  801b07:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801b0a:	eb 42                	jmp    801b4e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0f:	8a 00                	mov    (%eax),%al
  801b11:	3c 60                	cmp    $0x60,%al
  801b13:	7e 19                	jle    801b2e <strtol+0xe4>
  801b15:	8b 45 08             	mov    0x8(%ebp),%eax
  801b18:	8a 00                	mov    (%eax),%al
  801b1a:	3c 7a                	cmp    $0x7a,%al
  801b1c:	7f 10                	jg     801b2e <strtol+0xe4>
			dig = *s - 'a' + 10;
  801b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b21:	8a 00                	mov    (%eax),%al
  801b23:	0f be c0             	movsbl %al,%eax
  801b26:	83 e8 57             	sub    $0x57,%eax
  801b29:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801b2c:	eb 20                	jmp    801b4e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b31:	8a 00                	mov    (%eax),%al
  801b33:	3c 40                	cmp    $0x40,%al
  801b35:	7e 39                	jle    801b70 <strtol+0x126>
  801b37:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3a:	8a 00                	mov    (%eax),%al
  801b3c:	3c 5a                	cmp    $0x5a,%al
  801b3e:	7f 30                	jg     801b70 <strtol+0x126>
			dig = *s - 'A' + 10;
  801b40:	8b 45 08             	mov    0x8(%ebp),%eax
  801b43:	8a 00                	mov    (%eax),%al
  801b45:	0f be c0             	movsbl %al,%eax
  801b48:	83 e8 37             	sub    $0x37,%eax
  801b4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801b4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b51:	3b 45 10             	cmp    0x10(%ebp),%eax
  801b54:	7d 19                	jge    801b6f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801b56:	ff 45 08             	incl   0x8(%ebp)
  801b59:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b5c:	0f af 45 10          	imul   0x10(%ebp),%eax
  801b60:	89 c2                	mov    %eax,%edx
  801b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b65:	01 d0                	add    %edx,%eax
  801b67:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801b6a:	e9 7b ff ff ff       	jmp    801aea <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801b6f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801b70:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801b74:	74 08                	je     801b7e <strtol+0x134>
		*endptr = (char *) s;
  801b76:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b79:	8b 55 08             	mov    0x8(%ebp),%edx
  801b7c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801b7e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b82:	74 07                	je     801b8b <strtol+0x141>
  801b84:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b87:	f7 d8                	neg    %eax
  801b89:	eb 03                	jmp    801b8e <strtol+0x144>
  801b8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801b8e:	c9                   	leave  
  801b8f:	c3                   	ret    

00801b90 <ltostr>:

void
ltostr(long value, char *str)
{
  801b90:	55                   	push   %ebp
  801b91:	89 e5                	mov    %esp,%ebp
  801b93:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801b96:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801b9d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801ba4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801ba8:	79 13                	jns    801bbd <ltostr+0x2d>
	{
		neg = 1;
  801baa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801bb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bb4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801bb7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801bba:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801bc5:	99                   	cltd   
  801bc6:	f7 f9                	idiv   %ecx
  801bc8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801bcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bce:	8d 50 01             	lea    0x1(%eax),%edx
  801bd1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801bd4:	89 c2                	mov    %eax,%edx
  801bd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bd9:	01 d0                	add    %edx,%eax
  801bdb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bde:	83 c2 30             	add    $0x30,%edx
  801be1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801be3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801be6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801beb:	f7 e9                	imul   %ecx
  801bed:	c1 fa 02             	sar    $0x2,%edx
  801bf0:	89 c8                	mov    %ecx,%eax
  801bf2:	c1 f8 1f             	sar    $0x1f,%eax
  801bf5:	29 c2                	sub    %eax,%edx
  801bf7:	89 d0                	mov    %edx,%eax
  801bf9:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  801bfc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801c00:	75 bb                	jne    801bbd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801c02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801c09:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c0c:	48                   	dec    %eax
  801c0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801c10:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801c14:	74 3d                	je     801c53 <ltostr+0xc3>
		start = 1 ;
  801c16:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801c1d:	eb 34                	jmp    801c53 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801c1f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c22:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c25:	01 d0                	add    %edx,%eax
  801c27:	8a 00                	mov    (%eax),%al
  801c29:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801c2c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c32:	01 c2                	add    %eax,%edx
  801c34:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801c37:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c3a:	01 c8                	add    %ecx,%eax
  801c3c:	8a 00                	mov    (%eax),%al
  801c3e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801c40:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801c43:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c46:	01 c2                	add    %eax,%edx
  801c48:	8a 45 eb             	mov    -0x15(%ebp),%al
  801c4b:	88 02                	mov    %al,(%edx)
		start++ ;
  801c4d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801c50:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c56:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c59:	7c c4                	jl     801c1f <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801c5b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801c5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c61:	01 d0                	add    %edx,%eax
  801c63:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801c66:	90                   	nop
  801c67:	c9                   	leave  
  801c68:	c3                   	ret    

00801c69 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801c69:	55                   	push   %ebp
  801c6a:	89 e5                	mov    %esp,%ebp
  801c6c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801c6f:	ff 75 08             	pushl  0x8(%ebp)
  801c72:	e8 c4 f9 ff ff       	call   80163b <strlen>
  801c77:	83 c4 04             	add    $0x4,%esp
  801c7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801c7d:	ff 75 0c             	pushl  0xc(%ebp)
  801c80:	e8 b6 f9 ff ff       	call   80163b <strlen>
  801c85:	83 c4 04             	add    $0x4,%esp
  801c88:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801c8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801c92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801c99:	eb 17                	jmp    801cb2 <strcconcat+0x49>
		final[s] = str1[s] ;
  801c9b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c9e:	8b 45 10             	mov    0x10(%ebp),%eax
  801ca1:	01 c2                	add    %eax,%edx
  801ca3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca9:	01 c8                	add    %ecx,%eax
  801cab:	8a 00                	mov    (%eax),%al
  801cad:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801caf:	ff 45 fc             	incl   -0x4(%ebp)
  801cb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cb5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801cb8:	7c e1                	jl     801c9b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801cba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801cc1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801cc8:	eb 1f                	jmp    801ce9 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801cca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ccd:	8d 50 01             	lea    0x1(%eax),%edx
  801cd0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801cd3:	89 c2                	mov    %eax,%edx
  801cd5:	8b 45 10             	mov    0x10(%ebp),%eax
  801cd8:	01 c2                	add    %eax,%edx
  801cda:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801cdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ce0:	01 c8                	add    %ecx,%eax
  801ce2:	8a 00                	mov    (%eax),%al
  801ce4:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801ce6:	ff 45 f8             	incl   -0x8(%ebp)
  801ce9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cec:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801cef:	7c d9                	jl     801cca <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801cf1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801cf4:	8b 45 10             	mov    0x10(%ebp),%eax
  801cf7:	01 d0                	add    %edx,%eax
  801cf9:	c6 00 00             	movb   $0x0,(%eax)
}
  801cfc:	90                   	nop
  801cfd:	c9                   	leave  
  801cfe:	c3                   	ret    

00801cff <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801d02:	8b 45 14             	mov    0x14(%ebp),%eax
  801d05:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801d0b:	8b 45 14             	mov    0x14(%ebp),%eax
  801d0e:	8b 00                	mov    (%eax),%eax
  801d10:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d17:	8b 45 10             	mov    0x10(%ebp),%eax
  801d1a:	01 d0                	add    %edx,%eax
  801d1c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801d22:	eb 0c                	jmp    801d30 <strsplit+0x31>
			*string++ = 0;
  801d24:	8b 45 08             	mov    0x8(%ebp),%eax
  801d27:	8d 50 01             	lea    0x1(%eax),%edx
  801d2a:	89 55 08             	mov    %edx,0x8(%ebp)
  801d2d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801d30:	8b 45 08             	mov    0x8(%ebp),%eax
  801d33:	8a 00                	mov    (%eax),%al
  801d35:	84 c0                	test   %al,%al
  801d37:	74 18                	je     801d51 <strsplit+0x52>
  801d39:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3c:	8a 00                	mov    (%eax),%al
  801d3e:	0f be c0             	movsbl %al,%eax
  801d41:	50                   	push   %eax
  801d42:	ff 75 0c             	pushl  0xc(%ebp)
  801d45:	e8 83 fa ff ff       	call   8017cd <strchr>
  801d4a:	83 c4 08             	add    $0x8,%esp
  801d4d:	85 c0                	test   %eax,%eax
  801d4f:	75 d3                	jne    801d24 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801d51:	8b 45 08             	mov    0x8(%ebp),%eax
  801d54:	8a 00                	mov    (%eax),%al
  801d56:	84 c0                	test   %al,%al
  801d58:	74 5a                	je     801db4 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801d5a:	8b 45 14             	mov    0x14(%ebp),%eax
  801d5d:	8b 00                	mov    (%eax),%eax
  801d5f:	83 f8 0f             	cmp    $0xf,%eax
  801d62:	75 07                	jne    801d6b <strsplit+0x6c>
		{
			return 0;
  801d64:	b8 00 00 00 00       	mov    $0x0,%eax
  801d69:	eb 66                	jmp    801dd1 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801d6b:	8b 45 14             	mov    0x14(%ebp),%eax
  801d6e:	8b 00                	mov    (%eax),%eax
  801d70:	8d 48 01             	lea    0x1(%eax),%ecx
  801d73:	8b 55 14             	mov    0x14(%ebp),%edx
  801d76:	89 0a                	mov    %ecx,(%edx)
  801d78:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d7f:	8b 45 10             	mov    0x10(%ebp),%eax
  801d82:	01 c2                	add    %eax,%edx
  801d84:	8b 45 08             	mov    0x8(%ebp),%eax
  801d87:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d89:	eb 03                	jmp    801d8e <strsplit+0x8f>
			string++;
  801d8b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d91:	8a 00                	mov    (%eax),%al
  801d93:	84 c0                	test   %al,%al
  801d95:	74 8b                	je     801d22 <strsplit+0x23>
  801d97:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9a:	8a 00                	mov    (%eax),%al
  801d9c:	0f be c0             	movsbl %al,%eax
  801d9f:	50                   	push   %eax
  801da0:	ff 75 0c             	pushl  0xc(%ebp)
  801da3:	e8 25 fa ff ff       	call   8017cd <strchr>
  801da8:	83 c4 08             	add    $0x8,%esp
  801dab:	85 c0                	test   %eax,%eax
  801dad:	74 dc                	je     801d8b <strsplit+0x8c>
			string++;
	}
  801daf:	e9 6e ff ff ff       	jmp    801d22 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801db4:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801db5:	8b 45 14             	mov    0x14(%ebp),%eax
  801db8:	8b 00                	mov    (%eax),%eax
  801dba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801dc1:	8b 45 10             	mov    0x10(%ebp),%eax
  801dc4:	01 d0                	add    %edx,%eax
  801dc6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801dcc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801dd1:	c9                   	leave  
  801dd2:	c3                   	ret    

00801dd3 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  801dd3:	55                   	push   %ebp
  801dd4:	89 e5                	mov    %esp,%ebp
  801dd6:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  801dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  801ddf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801de6:	eb 4a                	jmp    801e32 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  801de8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801deb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dee:	01 c2                	add    %eax,%edx
  801df0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801df3:	8b 45 0c             	mov    0xc(%ebp),%eax
  801df6:	01 c8                	add    %ecx,%eax
  801df8:	8a 00                	mov    (%eax),%al
  801dfa:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  801dfc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801dff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e02:	01 d0                	add    %edx,%eax
  801e04:	8a 00                	mov    (%eax),%al
  801e06:	3c 40                	cmp    $0x40,%al
  801e08:	7e 25                	jle    801e2f <str2lower+0x5c>
  801e0a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e10:	01 d0                	add    %edx,%eax
  801e12:	8a 00                	mov    (%eax),%al
  801e14:	3c 5a                	cmp    $0x5a,%al
  801e16:	7f 17                	jg     801e2f <str2lower+0x5c>
		{
			dst[i] += 32 ;
  801e18:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1e:	01 d0                	add    %edx,%eax
  801e20:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801e23:	8b 55 08             	mov    0x8(%ebp),%edx
  801e26:	01 ca                	add    %ecx,%edx
  801e28:	8a 12                	mov    (%edx),%dl
  801e2a:	83 c2 20             	add    $0x20,%edx
  801e2d:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801e2f:	ff 45 fc             	incl   -0x4(%ebp)
  801e32:	ff 75 0c             	pushl  0xc(%ebp)
  801e35:	e8 01 f8 ff ff       	call   80163b <strlen>
  801e3a:	83 c4 04             	add    $0x4,%esp
  801e3d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801e40:	7f a6                	jg     801de8 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801e42:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801e45:	c9                   	leave  
  801e46:	c3                   	ret    

00801e47 <uheap_init>:
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.IM#2] USER HEAP - [0] GIVEN FUNCTION
int __firstTimeFlag = 1;
void uheap_init()
{
  801e47:	55                   	push   %ebp
  801e48:	89 e5                	mov    %esp,%ebp
  801e4a:	83 ec 08             	sub    $0x8,%esp
	if(__firstTimeFlag)
  801e4d:	a1 08 40 80 00       	mov    0x804008,%eax
  801e52:	85 c0                	test   %eax,%eax
  801e54:	74 2d                	je     801e83 <uheap_init+0x3c>
	{
		buddy_init();
  801e56:	e8 87 06 00 00       	call   8024e2 <buddy_init>
		uheapPlaceStrategy = sys_get_uheap_strategy();
  801e5b:	e8 31 05 00 00       	call   802391 <sys_get_uheap_strategy>
  801e60:	a3 48 40 80 00       	mov    %eax,0x804048
		uheapPageAllocStart = USER_HEAP_START;
  801e65:	c7 05 20 41 80 00 00 	movl   $0x80000000,0x804120
  801e6c:	00 00 80 
		uheapPageAllocBreak = USER_HEAP_START;
  801e6f:	c7 05 4c 40 80 00 00 	movl   $0x80000000,0x80404c
  801e76:	00 00 80 
		__firstTimeFlag = 0;
  801e79:	c7 05 08 40 80 00 00 	movl   $0x0,0x804008
  801e80:	00 00 00 
	}
}
  801e83:	90                   	nop
  801e84:	c9                   	leave  
  801e85:	c3                   	ret    

00801e86 <create_buddy_space>:
/**************************************************/
//=================================
// [1] CREATE NEW BUDDY SPACE:
//=================================
void* create_buddy_space()
{
  801e86:	55                   	push   %ebp
  801e87:	89 e5                	mov    %esp,%ebp
  801e89:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [1] create_buddy_space
	//Your code is here
	//Comment the following line
	panic("create_buddy_space() is not implemented yet...!!");
  801e8c:	83 ec 04             	sub    $0x4,%esp
  801e8f:	68 3c 38 80 00       	push   $0x80383c
  801e94:	6a 25                	push   $0x25
  801e96:	68 6d 38 80 00       	push   $0x80386d
  801e9b:	e8 ee 0d 00 00       	call   802c8e <_panic>

00801ea0 <delete_buddy_space>:
}
//=================================
// [2] DELETE EXISTING BUDDY SPACE:
//=================================
void  delete_buddy_space(void *va)
{
  801ea0:	55                   	push   %ebp
  801ea1:	89 e5                	mov    %esp,%ebp
  801ea3:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [2] delete_buddy_space
	//Your code is here
	//Comment the following line
	panic("delete_buddy_space() is not implemented yet...!!");
  801ea6:	83 ec 04             	sub    $0x4,%esp
  801ea9:	68 7c 38 80 00       	push   $0x80387c
  801eae:	6a 2f                	push   $0x2f
  801eb0:	68 6d 38 80 00       	push   $0x80386d
  801eb5:	e8 d4 0d 00 00       	call   802c8e <_panic>

00801eba <malloc>:
//=================================
// [3] ALLOCATE SPACE IN USER HEAP:
//=================================

void* malloc(uint32 size)
{
  801eba:	55                   	push   %ebp
  801ebb:	89 e5                	mov    %esp,%ebp
  801ebd:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801ec0:	e8 82 ff ff ff       	call   801e47 <uheap_init>
	if (size == 0) return NULL ;
  801ec5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801ec9:	75 07                	jne    801ed2 <malloc+0x18>
  801ecb:	b8 00 00 00 00       	mov    $0x0,%eax
  801ed0:	eb 14                	jmp    801ee6 <malloc+0x2c>
	//==============================================================
	//TODO: [PROJECT'26.IM#2] USER HEAP - [3] malloc
	//Your code is here
	//Comment the following line
	panic("malloc() is not implemented yet...!!");
  801ed2:	83 ec 04             	sub    $0x4,%esp
  801ed5:	68 b0 38 80 00       	push   $0x8038b0
  801eda:	6a 43                	push   $0x43
  801edc:	68 6d 38 80 00       	push   $0x80386d
  801ee1:	e8 a8 0d 00 00       	call   802c8e <_panic>
}
  801ee6:	c9                   	leave  
  801ee7:	c3                   	ret    

00801ee8 <free>:

//=================================
// [4] FREE SPACE FROM USER HEAP:
//=================================
void free(void* virtual_address)
{
  801ee8:	55                   	push   %ebp
  801ee9:	89 e5                	mov    %esp,%ebp
  801eeb:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.IM#2] USER HEAP - [5] free
	//Your code is here
	//Comment the following line
	panic("free() is not implemented yet...!!");
  801eee:	83 ec 04             	sub    $0x4,%esp
  801ef1:	68 d8 38 80 00       	push   $0x8038d8
  801ef6:	6a 4e                	push   $0x4e
  801ef8:	68 6d 38 80 00       	push   $0x80386d
  801efd:	e8 8c 0d 00 00       	call   802c8e <_panic>

00801f02 <smalloc>:

//=================================
// [5] ALLOCATE SHARED VARIABLE:
//=================================
void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801f02:	55                   	push   %ebp
  801f03:	89 e5                	mov    %esp,%ebp
  801f05:	83 ec 18             	sub    $0x18,%esp
  801f08:	8b 45 10             	mov    0x10(%ebp),%eax
  801f0b:	88 45 f4             	mov    %al,-0xc(%ebp)
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801f0e:	e8 34 ff ff ff       	call   801e47 <uheap_init>
	if (size == 0) return NULL ;
  801f13:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801f17:	75 07                	jne    801f20 <smalloc+0x1e>
  801f19:	b8 00 00 00 00       	mov    $0x0,%eax
  801f1e:	eb 14                	jmp    801f34 <smalloc+0x32>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [3] smalloc
	//Your code is here
	//Comment the following line
	panic("smalloc() is not implemented yet...!!");
  801f20:	83 ec 04             	sub    $0x4,%esp
  801f23:	68 fc 38 80 00       	push   $0x8038fc
  801f28:	6a 5f                	push   $0x5f
  801f2a:	68 6d 38 80 00       	push   $0x80386d
  801f2f:	e8 5a 0d 00 00       	call   802c8e <_panic>
}
  801f34:	c9                   	leave  
  801f35:	c3                   	ret    

00801f36 <sget>:

//========================================
// [6] SHARE ON ALLOCATED SHARED VARIABLE:
//========================================
void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801f36:	55                   	push   %ebp
  801f37:	89 e5                	mov    %esp,%ebp
  801f39:	83 ec 08             	sub    $0x8,%esp
	//==============================================================
	//DON'T CHANGE THIS CODE========================================
	uheap_init();
  801f3c:	e8 06 ff ff ff       	call   801e47 <uheap_init>
	//==============================================================

	//TODO: [PROJECT'26.IM#6] SHARED MEMORY - [5] sget
	//Your code is here
	//Comment the following line
	panic("sget() is not implemented yet...!!");
  801f41:	83 ec 04             	sub    $0x4,%esp
  801f44:	68 24 39 80 00       	push   $0x803924
  801f49:	6a 6f                	push   $0x6f
  801f4b:	68 6d 38 80 00       	push   $0x80386d
  801f50:	e8 39 0d 00 00       	call   802c8e <_panic>

00801f55 <sfree>:
//==================================================================================//
//=================================
// FREE SHARED VARIABLE:
//=================================
void sfree(void* virtual_address)
{
  801f55:	55                   	push   %ebp
  801f56:	89 e5                	mov    %esp,%ebp
  801f58:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#4] EXIT #2 - [3] Free Shared Variables (sfree)
	//Your code is here
	//Comment the following line
	panic("sfree() is not implemented yet...!!");
  801f5b:	83 ec 04             	sub    $0x4,%esp
  801f5e:	68 48 39 80 00       	push   $0x803948
  801f63:	6a 7e                	push   $0x7e
  801f65:	68 6d 38 80 00       	push   $0x80386d
  801f6a:	e8 1f 0d 00 00       	call   802c8e <_panic>

00801f6f <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801f6f:	55                   	push   %ebp
  801f70:	89 e5                	mov    %esp,%ebp
  801f72:	57                   	push   %edi
  801f73:	56                   	push   %esi
  801f74:	53                   	push   %ebx
  801f75:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801f78:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f7e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f81:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f84:	8b 7d 18             	mov    0x18(%ebp),%edi
  801f87:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801f8a:	cd 30                	int    $0x30
  801f8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801f8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801f92:	83 c4 10             	add    $0x10,%esp
  801f95:	5b                   	pop    %ebx
  801f96:	5e                   	pop    %esi
  801f97:	5f                   	pop    %edi
  801f98:	5d                   	pop    %ebp
  801f99:	c3                   	ret    

00801f9a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801f9a:	55                   	push   %ebp
  801f9b:	89 e5                	mov    %esp,%ebp
  801f9d:	83 ec 04             	sub    $0x4,%esp
  801fa0:	8b 45 10             	mov    0x10(%ebp),%eax
  801fa3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801fa6:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fa9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801fad:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb0:	6a 00                	push   $0x0
  801fb2:	51                   	push   %ecx
  801fb3:	52                   	push   %edx
  801fb4:	ff 75 0c             	pushl  0xc(%ebp)
  801fb7:	50                   	push   %eax
  801fb8:	6a 00                	push   $0x0
  801fba:	e8 b0 ff ff ff       	call   801f6f <syscall>
  801fbf:	83 c4 18             	add    $0x18,%esp
}
  801fc2:	90                   	nop
  801fc3:	c9                   	leave  
  801fc4:	c3                   	ret    

00801fc5 <sys_cgetc>:

int
sys_cgetc(void)
{
  801fc5:	55                   	push   %ebp
  801fc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 02                	push   $0x2
  801fd4:	e8 96 ff ff ff       	call   801f6f <syscall>
  801fd9:	83 c4 18             	add    $0x18,%esp
}
  801fdc:	c9                   	leave  
  801fdd:	c3                   	ret    

00801fde <sys_lock_cons>:

void sys_lock_cons(void)
{
  801fde:	55                   	push   %ebp
  801fdf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 03                	push   $0x3
  801fed:	e8 7d ff ff ff       	call   801f6f <syscall>
  801ff2:	83 c4 18             	add    $0x18,%esp
}
  801ff5:	90                   	nop
  801ff6:	c9                   	leave  
  801ff7:	c3                   	ret    

00801ff8 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801ff8:	55                   	push   %ebp
  801ff9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	6a 04                	push   $0x4
  802007:	e8 63 ff ff ff       	call   801f6f <syscall>
  80200c:	83 c4 18             	add    $0x18,%esp
}
  80200f:	90                   	nop
  802010:	c9                   	leave  
  802011:	c3                   	ret    

00802012 <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  802012:	55                   	push   %ebp
  802013:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802015:	8b 55 0c             	mov    0xc(%ebp),%edx
  802018:	8b 45 08             	mov    0x8(%ebp),%eax
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	52                   	push   %edx
  802022:	50                   	push   %eax
  802023:	6a 08                	push   $0x8
  802025:	e8 45 ff ff ff       	call   801f6f <syscall>
  80202a:	83 c4 18             	add    $0x18,%esp
}
  80202d:	c9                   	leave  
  80202e:	c3                   	ret    

0080202f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80202f:	55                   	push   %ebp
  802030:	89 e5                	mov    %esp,%ebp
  802032:	56                   	push   %esi
  802033:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802034:	8b 75 18             	mov    0x18(%ebp),%esi
  802037:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80203a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80203d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802040:	8b 45 08             	mov    0x8(%ebp),%eax
  802043:	56                   	push   %esi
  802044:	53                   	push   %ebx
  802045:	51                   	push   %ecx
  802046:	52                   	push   %edx
  802047:	50                   	push   %eax
  802048:	6a 09                	push   $0x9
  80204a:	e8 20 ff ff ff       	call   801f6f <syscall>
  80204f:	83 c4 18             	add    $0x18,%esp
}
  802052:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802055:	5b                   	pop    %ebx
  802056:	5e                   	pop    %esi
  802057:	5d                   	pop    %ebp
  802058:	c3                   	ret    

00802059 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  802059:	55                   	push   %ebp
  80205a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	ff 75 08             	pushl  0x8(%ebp)
  802067:	6a 0a                	push   $0xa
  802069:	e8 01 ff ff ff       	call   801f6f <syscall>
  80206e:	83 c4 18             	add    $0x18,%esp
}
  802071:	c9                   	leave  
  802072:	c3                   	ret    

00802073 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802073:	55                   	push   %ebp
  802074:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	ff 75 0c             	pushl  0xc(%ebp)
  80207f:	ff 75 08             	pushl  0x8(%ebp)
  802082:	6a 0b                	push   $0xb
  802084:	e8 e6 fe ff ff       	call   801f6f <syscall>
  802089:	83 c4 18             	add    $0x18,%esp
}
  80208c:	c9                   	leave  
  80208d:	c3                   	ret    

0080208e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80208e:	55                   	push   %ebp
  80208f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	6a 00                	push   $0x0
  802097:	6a 00                	push   $0x0
  802099:	6a 00                	push   $0x0
  80209b:	6a 0c                	push   $0xc
  80209d:	e8 cd fe ff ff       	call   801f6f <syscall>
  8020a2:	83 c4 18             	add    $0x18,%esp
}
  8020a5:	c9                   	leave  
  8020a6:	c3                   	ret    

008020a7 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8020a7:	55                   	push   %ebp
  8020a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 00                	push   $0x0
  8020b4:	6a 0d                	push   $0xd
  8020b6:	e8 b4 fe ff ff       	call   801f6f <syscall>
  8020bb:	83 c4 18             	add    $0x18,%esp
}
  8020be:	c9                   	leave  
  8020bf:	c3                   	ret    

008020c0 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8020c0:	55                   	push   %ebp
  8020c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 0e                	push   $0xe
  8020cf:	e8 9b fe ff ff       	call   801f6f <syscall>
  8020d4:	83 c4 18             	add    $0x18,%esp
}
  8020d7:	c9                   	leave  
  8020d8:	c3                   	ret    

008020d9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8020d9:	55                   	push   %ebp
  8020da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 00                	push   $0x0
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 0f                	push   $0xf
  8020e8:	e8 82 fe ff ff       	call   801f6f <syscall>
  8020ed:	83 c4 18             	add    $0x18,%esp
}
  8020f0:	c9                   	leave  
  8020f1:	c3                   	ret    

008020f2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8020f2:	55                   	push   %ebp
  8020f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8020f5:	6a 00                	push   $0x0
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	ff 75 08             	pushl  0x8(%ebp)
  802100:	6a 10                	push   $0x10
  802102:	e8 68 fe ff ff       	call   801f6f <syscall>
  802107:	83 c4 18             	add    $0x18,%esp
}
  80210a:	c9                   	leave  
  80210b:	c3                   	ret    

0080210c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80210c:	55                   	push   %ebp
  80210d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80210f:	6a 00                	push   $0x0
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	6a 11                	push   $0x11
  80211b:	e8 4f fe ff ff       	call   801f6f <syscall>
  802120:	83 c4 18             	add    $0x18,%esp
}
  802123:	90                   	nop
  802124:	c9                   	leave  
  802125:	c3                   	ret    

00802126 <sys_cputc>:

void
sys_cputc(const char c)
{
  802126:	55                   	push   %ebp
  802127:	89 e5                	mov    %esp,%ebp
  802129:	83 ec 04             	sub    $0x4,%esp
  80212c:	8b 45 08             	mov    0x8(%ebp),%eax
  80212f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802132:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802136:	6a 00                	push   $0x0
  802138:	6a 00                	push   $0x0
  80213a:	6a 00                	push   $0x0
  80213c:	6a 00                	push   $0x0
  80213e:	50                   	push   %eax
  80213f:	6a 01                	push   $0x1
  802141:	e8 29 fe ff ff       	call   801f6f <syscall>
  802146:	83 c4 18             	add    $0x18,%esp
}
  802149:	90                   	nop
  80214a:	c9                   	leave  
  80214b:	c3                   	ret    

0080214c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80214c:	55                   	push   %ebp
  80214d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	6a 00                	push   $0x0
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 14                	push   $0x14
  80215b:	e8 0f fe ff ff       	call   801f6f <syscall>
  802160:	83 c4 18             	add    $0x18,%esp
}
  802163:	90                   	nop
  802164:	c9                   	leave  
  802165:	c3                   	ret    

00802166 <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  802166:	55                   	push   %ebp
  802167:	89 e5                	mov    %esp,%ebp
  802169:	83 ec 04             	sub    $0x4,%esp
  80216c:	8b 45 10             	mov    0x10(%ebp),%eax
  80216f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  802172:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802175:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802179:	8b 45 08             	mov    0x8(%ebp),%eax
  80217c:	6a 00                	push   $0x0
  80217e:	51                   	push   %ecx
  80217f:	52                   	push   %edx
  802180:	ff 75 0c             	pushl  0xc(%ebp)
  802183:	50                   	push   %eax
  802184:	6a 15                	push   $0x15
  802186:	e8 e4 fd ff ff       	call   801f6f <syscall>
  80218b:	83 c4 18             	add    $0x18,%esp
}
  80218e:	c9                   	leave  
  80218f:	c3                   	ret    

00802190 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  802190:	55                   	push   %ebp
  802191:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  802193:	8b 55 10             	mov    0x10(%ebp),%edx
  802196:	8b 45 0c             	mov    0xc(%ebp),%eax
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	52                   	push   %edx
  80219e:	50                   	push   %eax
  80219f:	ff 75 08             	pushl  0x8(%ebp)
  8021a2:	6a 16                	push   $0x16
  8021a4:	e8 c6 fd ff ff       	call   801f6f <syscall>
  8021a9:	83 c4 18             	add    $0x18,%esp
}
  8021ac:	c9                   	leave  
  8021ad:	c3                   	ret    

008021ae <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  8021ae:	55                   	push   %ebp
  8021af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8021b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b7:	6a 00                	push   $0x0
  8021b9:	6a 00                	push   $0x0
  8021bb:	6a 00                	push   $0x0
  8021bd:	52                   	push   %edx
  8021be:	50                   	push   %eax
  8021bf:	6a 17                	push   $0x17
  8021c1:	e8 a9 fd ff ff       	call   801f6f <syscall>
  8021c6:	83 c4 18             	add    $0x18,%esp
}
  8021c9:	c9                   	leave  
  8021ca:	c3                   	ret    

008021cb <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  8021cb:	55                   	push   %ebp
  8021cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  8021ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 00                	push   $0x0
  8021da:	52                   	push   %edx
  8021db:	50                   	push   %eax
  8021dc:	6a 18                	push   $0x18
  8021de:	e8 8c fd ff ff       	call   801f6f <syscall>
  8021e3:	83 c4 18             	add    $0x18,%esp
}
  8021e6:	c9                   	leave  
  8021e7:	c3                   	ret    

008021e8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8021e8:	55                   	push   %ebp
  8021e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8021eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ee:	6a 00                	push   $0x0
  8021f0:	ff 75 14             	pushl  0x14(%ebp)
  8021f3:	ff 75 10             	pushl  0x10(%ebp)
  8021f6:	ff 75 0c             	pushl  0xc(%ebp)
  8021f9:	50                   	push   %eax
  8021fa:	6a 19                	push   $0x19
  8021fc:	e8 6e fd ff ff       	call   801f6f <syscall>
  802201:	83 c4 18             	add    $0x18,%esp
}
  802204:	c9                   	leave  
  802205:	c3                   	ret    

00802206 <sys_run_env>:

void sys_run_env(int32 envId)
{
  802206:	55                   	push   %ebp
  802207:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802209:	8b 45 08             	mov    0x8(%ebp),%eax
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	50                   	push   %eax
  802215:	6a 1a                	push   $0x1a
  802217:	e8 53 fd ff ff       	call   801f6f <syscall>
  80221c:	83 c4 18             	add    $0x18,%esp
}
  80221f:	90                   	nop
  802220:	c9                   	leave  
  802221:	c3                   	ret    

00802222 <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  802222:	55                   	push   %ebp
  802223:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  802225:	8b 45 08             	mov    0x8(%ebp),%eax
  802228:	6a 00                	push   $0x0
  80222a:	6a 00                	push   $0x0
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	50                   	push   %eax
  802231:	6a 1b                	push   $0x1b
  802233:	e8 37 fd ff ff       	call   801f6f <syscall>
  802238:	83 c4 18             	add    $0x18,%esp
}
  80223b:	c9                   	leave  
  80223c:	c3                   	ret    

0080223d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80223d:	55                   	push   %ebp
  80223e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802240:	6a 00                	push   $0x0
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 05                	push   $0x5
  80224c:	e8 1e fd ff ff       	call   801f6f <syscall>
  802251:	83 c4 18             	add    $0x18,%esp
}
  802254:	c9                   	leave  
  802255:	c3                   	ret    

00802256 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802256:	55                   	push   %ebp
  802257:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802259:	6a 00                	push   $0x0
  80225b:	6a 00                	push   $0x0
  80225d:	6a 00                	push   $0x0
  80225f:	6a 00                	push   $0x0
  802261:	6a 00                	push   $0x0
  802263:	6a 06                	push   $0x6
  802265:	e8 05 fd ff ff       	call   801f6f <syscall>
  80226a:	83 c4 18             	add    $0x18,%esp
}
  80226d:	c9                   	leave  
  80226e:	c3                   	ret    

0080226f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80226f:	55                   	push   %ebp
  802270:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802272:	6a 00                	push   $0x0
  802274:	6a 00                	push   $0x0
  802276:	6a 00                	push   $0x0
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 07                	push   $0x7
  80227e:	e8 ec fc ff ff       	call   801f6f <syscall>
  802283:	83 c4 18             	add    $0x18,%esp
}
  802286:	c9                   	leave  
  802287:	c3                   	ret    

00802288 <sys_exit_env>:


void sys_exit_env(void)
{
  802288:	55                   	push   %ebp
  802289:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  80228b:	6a 00                	push   $0x0
  80228d:	6a 00                	push   $0x0
  80228f:	6a 00                	push   $0x0
  802291:	6a 00                	push   $0x0
  802293:	6a 00                	push   $0x0
  802295:	6a 1c                	push   $0x1c
  802297:	e8 d3 fc ff ff       	call   801f6f <syscall>
  80229c:	83 c4 18             	add    $0x18,%esp
}
  80229f:	90                   	nop
  8022a0:	c9                   	leave  
  8022a1:	c3                   	ret    

008022a2 <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8022a2:	55                   	push   %ebp
  8022a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8022a5:	6a 00                	push   $0x0
  8022a7:	6a 00                	push   $0x0
  8022a9:	ff 75 10             	pushl  0x10(%ebp)
  8022ac:	ff 75 0c             	pushl  0xc(%ebp)
  8022af:	ff 75 08             	pushl  0x8(%ebp)
  8022b2:	6a 13                	push   $0x13
  8022b4:	e8 b6 fc ff ff       	call   801f6f <syscall>
  8022b9:	83 c4 18             	add    $0x18,%esp
	return ;
  8022bc:	90                   	nop
}
  8022bd:	c9                   	leave  
  8022be:	c3                   	ret    

008022bf <sys_rcr2>:
uint32 sys_rcr2()
{
  8022bf:	55                   	push   %ebp
  8022c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8022c2:	6a 00                	push   $0x0
  8022c4:	6a 00                	push   $0x0
  8022c6:	6a 00                	push   $0x0
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 00                	push   $0x0
  8022cc:	6a 1e                	push   $0x1e
  8022ce:	e8 9c fc ff ff       	call   801f6f <syscall>
  8022d3:	83 c4 18             	add    $0x18,%esp
}
  8022d6:	c9                   	leave  
  8022d7:	c3                   	ret    

008022d8 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  8022d8:	55                   	push   %ebp
  8022d9:	89 e5                	mov    %esp,%ebp
  8022db:	83 ec 04             	sub    $0x4,%esp
  8022de:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8022e4:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8022e8:	6a 00                	push   $0x0
  8022ea:	6a 00                	push   $0x0
  8022ec:	6a 00                	push   $0x0
  8022ee:	6a 00                	push   $0x0
  8022f0:	50                   	push   %eax
  8022f1:	6a 1f                	push   $0x1f
  8022f3:	e8 77 fc ff ff       	call   801f6f <syscall>
  8022f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8022fb:	90                   	nop
}
  8022fc:	c9                   	leave  
  8022fd:	c3                   	ret    

008022fe <rsttst>:
void rsttst()
{
  8022fe:	55                   	push   %ebp
  8022ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802301:	6a 00                	push   $0x0
  802303:	6a 00                	push   $0x0
  802305:	6a 00                	push   $0x0
  802307:	6a 00                	push   $0x0
  802309:	6a 00                	push   $0x0
  80230b:	6a 21                	push   $0x21
  80230d:	e8 5d fc ff ff       	call   801f6f <syscall>
  802312:	83 c4 18             	add    $0x18,%esp
	return ;
  802315:	90                   	nop
}
  802316:	c9                   	leave  
  802317:	c3                   	ret    

00802318 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802318:	55                   	push   %ebp
  802319:	89 e5                	mov    %esp,%ebp
  80231b:	83 ec 04             	sub    $0x4,%esp
  80231e:	8b 45 14             	mov    0x14(%ebp),%eax
  802321:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802324:	8b 55 18             	mov    0x18(%ebp),%edx
  802327:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80232b:	52                   	push   %edx
  80232c:	50                   	push   %eax
  80232d:	ff 75 10             	pushl  0x10(%ebp)
  802330:	ff 75 0c             	pushl  0xc(%ebp)
  802333:	ff 75 08             	pushl  0x8(%ebp)
  802336:	6a 20                	push   $0x20
  802338:	e8 32 fc ff ff       	call   801f6f <syscall>
  80233d:	83 c4 18             	add    $0x18,%esp
	return ;
  802340:	90                   	nop
}
  802341:	c9                   	leave  
  802342:	c3                   	ret    

00802343 <chktst>:
void chktst(uint32 n)
{
  802343:	55                   	push   %ebp
  802344:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802346:	6a 00                	push   $0x0
  802348:	6a 00                	push   $0x0
  80234a:	6a 00                	push   $0x0
  80234c:	6a 00                	push   $0x0
  80234e:	ff 75 08             	pushl  0x8(%ebp)
  802351:	6a 22                	push   $0x22
  802353:	e8 17 fc ff ff       	call   801f6f <syscall>
  802358:	83 c4 18             	add    $0x18,%esp
	return ;
  80235b:	90                   	nop
}
  80235c:	c9                   	leave  
  80235d:	c3                   	ret    

0080235e <inctst>:

void inctst()
{
  80235e:	55                   	push   %ebp
  80235f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802361:	6a 00                	push   $0x0
  802363:	6a 00                	push   $0x0
  802365:	6a 00                	push   $0x0
  802367:	6a 00                	push   $0x0
  802369:	6a 00                	push   $0x0
  80236b:	6a 23                	push   $0x23
  80236d:	e8 fd fb ff ff       	call   801f6f <syscall>
  802372:	83 c4 18             	add    $0x18,%esp
	return ;
  802375:	90                   	nop
}
  802376:	c9                   	leave  
  802377:	c3                   	ret    

00802378 <gettst>:
uint32 gettst()
{
  802378:	55                   	push   %ebp
  802379:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80237b:	6a 00                	push   $0x0
  80237d:	6a 00                	push   $0x0
  80237f:	6a 00                	push   $0x0
  802381:	6a 00                	push   $0x0
  802383:	6a 00                	push   $0x0
  802385:	6a 24                	push   $0x24
  802387:	e8 e3 fb ff ff       	call   801f6f <syscall>
  80238c:	83 c4 18             	add    $0x18,%esp
}
  80238f:	c9                   	leave  
  802390:	c3                   	ret    

00802391 <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  802391:	55                   	push   %ebp
  802392:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802394:	6a 00                	push   $0x0
  802396:	6a 00                	push   $0x0
  802398:	6a 00                	push   $0x0
  80239a:	6a 00                	push   $0x0
  80239c:	6a 00                	push   $0x0
  80239e:	6a 25                	push   $0x25
  8023a0:	e8 ca fb ff ff       	call   801f6f <syscall>
  8023a5:	83 c4 18             	add    $0x18,%esp
  8023a8:	a3 48 40 80 00       	mov    %eax,0x804048
	return uheapPlaceStrategy ;
  8023ad:	a1 48 40 80 00       	mov    0x804048,%eax
}
  8023b2:	c9                   	leave  
  8023b3:	c3                   	ret    

008023b4 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8023b4:	55                   	push   %ebp
  8023b5:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  8023b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ba:	a3 48 40 80 00       	mov    %eax,0x804048
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 00                	push   $0x0
  8023c3:	6a 00                	push   $0x0
  8023c5:	6a 00                	push   $0x0
  8023c7:	ff 75 08             	pushl  0x8(%ebp)
  8023ca:	6a 26                	push   $0x26
  8023cc:	e8 9e fb ff ff       	call   801f6f <syscall>
  8023d1:	83 c4 18             	add    $0x18,%esp
	return ;
  8023d4:	90                   	nop
}
  8023d5:	c9                   	leave  
  8023d6:	c3                   	ret    

008023d7 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8023d7:	55                   	push   %ebp
  8023d8:	89 e5                	mov    %esp,%ebp
  8023da:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8023db:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8023de:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e7:	6a 00                	push   $0x0
  8023e9:	53                   	push   %ebx
  8023ea:	51                   	push   %ecx
  8023eb:	52                   	push   %edx
  8023ec:	50                   	push   %eax
  8023ed:	6a 27                	push   $0x27
  8023ef:	e8 7b fb ff ff       	call   801f6f <syscall>
  8023f4:	83 c4 18             	add    $0x18,%esp
}
  8023f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8023fa:	c9                   	leave  
  8023fb:	c3                   	ret    

008023fc <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8023fc:	55                   	push   %ebp
  8023fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8023ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  802402:	8b 45 08             	mov    0x8(%ebp),%eax
  802405:	6a 00                	push   $0x0
  802407:	6a 00                	push   $0x0
  802409:	6a 00                	push   $0x0
  80240b:	52                   	push   %edx
  80240c:	50                   	push   %eax
  80240d:	6a 28                	push   $0x28
  80240f:	e8 5b fb ff ff       	call   801f6f <syscall>
  802414:	83 c4 18             	add    $0x18,%esp
}
  802417:	c9                   	leave  
  802418:	c3                   	ret    

00802419 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  802419:	55                   	push   %ebp
  80241a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  80241c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80241f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802422:	8b 45 08             	mov    0x8(%ebp),%eax
  802425:	6a 00                	push   $0x0
  802427:	51                   	push   %ecx
  802428:	ff 75 10             	pushl  0x10(%ebp)
  80242b:	52                   	push   %edx
  80242c:	50                   	push   %eax
  80242d:	6a 29                	push   $0x29
  80242f:	e8 3b fb ff ff       	call   801f6f <syscall>
  802434:	83 c4 18             	add    $0x18,%esp
}
  802437:	c9                   	leave  
  802438:	c3                   	ret    

00802439 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  802439:	55                   	push   %ebp
  80243a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  80243c:	6a 00                	push   $0x0
  80243e:	6a 00                	push   $0x0
  802440:	ff 75 10             	pushl  0x10(%ebp)
  802443:	ff 75 0c             	pushl  0xc(%ebp)
  802446:	ff 75 08             	pushl  0x8(%ebp)
  802449:	6a 12                	push   $0x12
  80244b:	e8 1f fb ff ff       	call   801f6f <syscall>
  802450:	83 c4 18             	add    $0x18,%esp
	return ;
  802453:	90                   	nop
}
  802454:	c9                   	leave  
  802455:	c3                   	ret    

00802456 <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  802456:	55                   	push   %ebp
  802457:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  802459:	8b 55 0c             	mov    0xc(%ebp),%edx
  80245c:	8b 45 08             	mov    0x8(%ebp),%eax
  80245f:	6a 00                	push   $0x0
  802461:	6a 00                	push   $0x0
  802463:	6a 00                	push   $0x0
  802465:	52                   	push   %edx
  802466:	50                   	push   %eax
  802467:	6a 2a                	push   $0x2a
  802469:	e8 01 fb ff ff       	call   801f6f <syscall>
  80246e:	83 c4 18             	add    $0x18,%esp
	return;
  802471:	90                   	nop
}
  802472:	c9                   	leave  
  802473:	c3                   	ret    

00802474 <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  802474:	55                   	push   %ebp
  802475:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  802477:	6a 00                	push   $0x0
  802479:	6a 00                	push   $0x0
  80247b:	6a 00                	push   $0x0
  80247d:	6a 00                	push   $0x0
  80247f:	6a 00                	push   $0x0
  802481:	6a 2b                	push   $0x2b
  802483:	e8 e7 fa ff ff       	call   801f6f <syscall>
  802488:	83 c4 18             	add    $0x18,%esp
}
  80248b:	c9                   	leave  
  80248c:	c3                   	ret    

0080248d <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  80248d:	55                   	push   %ebp
  80248e:	89 e5                	mov    %esp,%ebp
  802490:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  802493:	83 ec 04             	sub    $0x4,%esp
  802496:	68 6c 39 80 00       	push   $0x80396c
  80249b:	68 0a 01 00 00       	push   $0x10a
  8024a0:	68 7c 39 80 00       	push   $0x80397c
  8024a5:	e8 e4 07 00 00       	call   802c8e <_panic>

008024aa <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  8024aa:	55                   	push   %ebp
  8024ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  8024ad:	6a 00                	push   $0x0
  8024af:	6a 00                	push   $0x0
  8024b1:	6a 00                	push   $0x0
  8024b3:	ff 75 0c             	pushl  0xc(%ebp)
  8024b6:	ff 75 08             	pushl  0x8(%ebp)
  8024b9:	6a 33                	push   $0x33
  8024bb:	e8 af fa ff ff       	call   801f6f <syscall>
  8024c0:	83 c4 18             	add    $0x18,%esp
	return;
  8024c3:	90                   	nop
}
  8024c4:	c9                   	leave  
  8024c5:	c3                   	ret    

008024c6 <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  8024c6:	55                   	push   %ebp
  8024c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  8024c9:	6a 00                	push   $0x0
  8024cb:	6a 00                	push   $0x0
  8024cd:	6a 00                	push   $0x0
  8024cf:	ff 75 0c             	pushl  0xc(%ebp)
  8024d2:	ff 75 08             	pushl  0x8(%ebp)
  8024d5:	6a 34                	push   $0x34
  8024d7:	e8 93 fa ff ff       	call   801f6f <syscall>
  8024dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8024df:	90                   	nop
}
  8024e0:	c9                   	leave  
  8024e1:	c3                   	ret    

008024e2 <buddy_init>:
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
  8024e2:	55                   	push   %ebp
  8024e3:	89 e5                	mov    %esp,%ebp
  8024e5:	83 ec 10             	sub    $0x10,%esp
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  8024e8:	c7 45 fc 04 00 00 00 	movl   $0x4,-0x4(%ebp)
  8024ef:	eb 36                	jmp    802527 <buddy_init+0x45>
	{
		LIST_INIT(&(freeBlockLists[l]));
  8024f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024f4:	c1 e0 04             	shl    $0x4,%eax
  8024f7:	05 60 40 80 00       	add    $0x804060,%eax
  8024fc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802502:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802505:	c1 e0 04             	shl    $0x4,%eax
  802508:	05 64 40 80 00       	add    $0x804064,%eax
  80250d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  802513:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802516:	c1 e0 04             	shl    $0x4,%eax
  802519:	05 6c 40 80 00       	add    $0x80406c,%eax
  80251e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
  802524:	ff 45 fc             	incl   -0x4(%ebp)
  802527:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  80252b:	7e c4                	jle    8024f1 <buddy_init+0xf>
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
  80252d:	90                   	nop
  80252e:	c9                   	leave  
  80252f:	c3                   	ret    

00802530 <PrintFreeBlockLists>:
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
  802530:	55                   	push   %ebp
  802531:	89 e5                	mov    %esp,%ebp
  802533:	83 ec 18             	sub    $0x18,%esp
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802536:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
  80253d:	eb 24                	jmp    802563 <PrintFreeBlockLists+0x33>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
  80253f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802542:	c1 e0 04             	shl    $0x4,%eax
  802545:	05 6c 40 80 00       	add    $0x80406c,%eax
  80254a:	8b 00                	mov    (%eax),%eax
  80254c:	83 ec 04             	sub    $0x4,%esp
  80254f:	50                   	push   %eax
  802550:	ff 75 f4             	pushl  -0xc(%ebp)
  802553:	68 8c 39 80 00       	push   $0x80398c
  802558:	e8 fd e7 ff ff       	call   800d5a <cprintf>
  80255d:	83 c4 10             	add    $0x10,%esp
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
  802560:	ff 45 f4             	incl   -0xc(%ebp)
  802563:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  802567:	7e d6                	jle    80253f <PrintFreeBlockLists+0xf>
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
  802569:	90                   	nop
  80256a:	c9                   	leave  
  80256b:	c3                   	ret    

0080256c <get_block_size>:
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
  80256c:	55                   	push   %ebp
  80256d:	89 e5                	mov    %esp,%ebp
  80256f:	83 ec 10             	sub    $0x10,%esp
	uint32 meta = (uint32) va - META_DATA_SIZE;
  802572:	8b 45 08             	mov    0x8(%ebp),%eax
  802575:	83 e8 0a             	sub    $0xa,%eax
  802578:	89 45 fc             	mov    %eax,-0x4(%ebp)
	struct BlockMetaData *cur = (struct BlockMetaData *)meta;
  80257b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80257e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	uint32 lvl = cur->level;
  802581:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802584:	8a 00                	mov    (%eax),%al
  802586:	0f b6 c0             	movzbl %al,%eax
  802589:	89 45 f4             	mov    %eax,-0xc(%ebp)
	return BLOCK_SIZE(lvl);
  80258c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80258f:	ba 01 00 00 00       	mov    $0x1,%edx
  802594:	88 c1                	mov    %al,%cl
  802596:	d3 e2                	shl    %cl,%edx
  802598:	89 d0                	mov    %edx,%eax

}
  80259a:	c9                   	leave  
  80259b:	c3                   	ret    

0080259c <alloc_block>:
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
  80259c:	55                   	push   %ebp
  80259d:	89 e5                	mov    %esp,%ebp
  80259f:	83 ec 48             	sub    $0x48,%esp
	//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [2] alloc_block
	//Your code is here
	//Comment the following line
	//panic("alloc_block() not implemented");
	//do not forget if memory is full
	if(requiredSize==0) return NULL;
  8025a2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8025a6:	75 0a                	jne    8025b2 <alloc_block+0x16>
  8025a8:	b8 00 00 00 00       	mov    $0x0,%eax
  8025ad:	e9 9e 04 00 00       	jmp    802a50 <alloc_block+0x4b4>
	uint32 realsize = requiredSize + META_DATA_SIZE;
  8025b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8025b5:	83 c0 0a             	add    $0xa,%eax
  8025b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
	uint32 level;
	for(int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL;i++){
  8025bb:	c7 45 f0 04 00 00 00 	movl   $0x4,-0x10(%ebp)
  8025c2:	eb 1e                	jmp    8025e2 <alloc_block+0x46>
		if(BLOCK_SIZE(i)>=realsize){
  8025c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8025c7:	ba 01 00 00 00       	mov    $0x1,%edx
  8025cc:	88 c1                	mov    %al,%cl
  8025ce:	d3 e2                	shl    %cl,%edx
  8025d0:	89 d0                	mov    %edx,%eax
  8025d2:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8025d5:	72 08                	jb     8025df <alloc_block+0x43>
			level=i;
  8025d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8025da:	89 45 f4             	mov    %eax,-0xc(%ebp)
			break;
  8025dd:	eb 09                	jmp    8025e8 <alloc_block+0x4c>
	//panic("alloc_block() not implemented");
	//do not forget if memory is full
	if(requiredSize==0) return NULL;
	uint32 realsize = requiredSize + META_DATA_SIZE;
	uint32 level;
	for(int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL;i++){
  8025df:	ff 45 f0             	incl   -0x10(%ebp)
  8025e2:	83 7d f0 0b          	cmpl   $0xb,-0x10(%ebp)
  8025e6:	7e dc                	jle    8025c4 <alloc_block+0x28>
			level=i;
			break;
		}
	}
	uint32 first_free_level;
	bool found = 0;
  8025e8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	for(int i =level;i<=BUDDY_UPPER_LEVEL;i++){
  8025ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8025f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8025f5:	eb 23                	jmp    80261a <alloc_block+0x7e>
		if(LIST_SIZE(&freeBlockLists[i])>0){
  8025f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8025fa:	c1 e0 04             	shl    $0x4,%eax
  8025fd:	05 6c 40 80 00       	add    $0x80406c,%eax
  802602:	8b 00                	mov    (%eax),%eax
  802604:	85 c0                	test   %eax,%eax
  802606:	74 0f                	je     802617 <alloc_block+0x7b>
			found = 1;
  802608:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
			first_free_level=i;
  80260f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802612:	89 45 ec             	mov    %eax,-0x14(%ebp)
			break;
  802615:	eb 09                	jmp    802620 <alloc_block+0x84>
			break;
		}
	}
	uint32 first_free_level;
	bool found = 0;
	for(int i =level;i<=BUDDY_UPPER_LEVEL;i++){
  802617:	ff 45 e4             	incl   -0x1c(%ebp)
  80261a:	83 7d e4 0b          	cmpl   $0xb,-0x1c(%ebp)
  80261e:	7e d7                	jle    8025f7 <alloc_block+0x5b>
			found = 1;
			first_free_level=i;
			break;
		}
	}
	if(found==0){
  802620:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  802624:	0f 85 4e 03 00 00    	jne    802978 <alloc_block+0x3dc>

		void *address = create_buddy_space();
  80262a:	e8 57 f8 ff ff       	call   801e86 <create_buddy_space>
  80262f:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if(address==NULL) return NULL;
  802632:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  802636:	75 0a                	jne    802642 <alloc_block+0xa6>
  802638:	b8 00 00 00 00       	mov    $0x0,%eax
  80263d:	e9 0e 04 00 00       	jmp    802a50 <alloc_block+0x4b4>

		uint32 iaddress=(uint32) address;
  802642:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802645:	89 45 d8             	mov    %eax,-0x28(%ebp)
		struct BlockMetaData *cur= (struct BlockMetaData*) address;
  802648:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80264b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		uint32 bAddress = iaddress + BLOCK_SIZE(BUDDY_UPPER_LEVEL);
  80264e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802651:	05 00 08 00 00       	add    $0x800,%eax
  802656:	89 45 d0             	mov    %eax,-0x30(%ebp)
		struct BlockMetaData *buddy= (struct BlockMetaData*)bAddress;
  802659:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80265c:	89 45 cc             	mov    %eax,-0x34(%ebp)
		cur -> is_free=1;
  80265f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  802662:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		cur -> level = BUDDY_UPPER_LEVEL;
  802666:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  802669:	c6 00 0b             	movb   $0xb,(%eax)
		buddy -> is_free=1;
  80266c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80266f:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		buddy -> level= BUDDY_UPPER_LEVEL;
  802673:	8b 45 cc             	mov    -0x34(%ebp),%eax
  802676:	c6 00 0b             	movb   $0xb,(%eax)
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],buddy);
  802679:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  80267d:	75 14                	jne    802693 <alloc_block+0xf7>
  80267f:	83 ec 04             	sub    $0x4,%esp
  802682:	68 9c 39 80 00       	push   $0x80399c
  802687:	6a 5f                	push   $0x5f
  802689:	68 bf 39 80 00       	push   $0x8039bf
  80268e:	e8 fb 05 00 00       	call   802c8e <_panic>
  802693:	8b 15 10 41 80 00    	mov    0x804110,%edx
  802699:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80269c:	89 50 02             	mov    %edx,0x2(%eax)
  80269f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8026a2:	8b 40 02             	mov    0x2(%eax),%eax
  8026a5:	85 c0                	test   %eax,%eax
  8026a7:	74 0d                	je     8026b6 <alloc_block+0x11a>
  8026a9:	a1 10 41 80 00       	mov    0x804110,%eax
  8026ae:	8b 55 cc             	mov    -0x34(%ebp),%edx
  8026b1:	89 50 06             	mov    %edx,0x6(%eax)
  8026b4:	eb 08                	jmp    8026be <alloc_block+0x122>
  8026b6:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8026b9:	a3 14 41 80 00       	mov    %eax,0x804114
  8026be:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8026c1:	a3 10 41 80 00       	mov    %eax,0x804110
  8026c6:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8026c9:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  8026d0:	a1 1c 41 80 00       	mov    0x80411c,%eax
  8026d5:	40                   	inc    %eax
  8026d6:	a3 1c 41 80 00       	mov    %eax,0x80411c
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],cur);
  8026db:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  8026df:	75 14                	jne    8026f5 <alloc_block+0x159>
  8026e1:	83 ec 04             	sub    $0x4,%esp
  8026e4:	68 9c 39 80 00       	push   $0x80399c
  8026e9:	6a 60                	push   $0x60
  8026eb:	68 bf 39 80 00       	push   $0x8039bf
  8026f0:	e8 99 05 00 00       	call   802c8e <_panic>
  8026f5:	8b 15 10 41 80 00    	mov    0x804110,%edx
  8026fb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8026fe:	89 50 02             	mov    %edx,0x2(%eax)
  802701:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  802704:	8b 40 02             	mov    0x2(%eax),%eax
  802707:	85 c0                	test   %eax,%eax
  802709:	74 0d                	je     802718 <alloc_block+0x17c>
  80270b:	a1 10 41 80 00       	mov    0x804110,%eax
  802710:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  802713:	89 50 06             	mov    %edx,0x6(%eax)
  802716:	eb 08                	jmp    802720 <alloc_block+0x184>
  802718:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80271b:	a3 14 41 80 00       	mov    %eax,0x804114
  802720:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  802723:	a3 10 41 80 00       	mov    %eax,0x804110
  802728:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80272b:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  802732:	a1 1c 41 80 00       	mov    0x80411c,%eax
  802737:	40                   	inc    %eax
  802738:	a3 1c 41 80 00       	mov    %eax,0x80411c
		first_free_level=BUDDY_UPPER_LEVEL;
  80273d:	c7 45 ec 0b 00 00 00 	movl   $0xb,-0x14(%ebp)
	}


	while(first_free_level > level){
  802744:	e9 2f 02 00 00       	jmp    802978 <alloc_block+0x3dc>
		struct BlockMetaData *cur = LIST_FIRST(&freeBlockLists[first_free_level]);
  802749:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80274c:	c1 e0 04             	shl    $0x4,%eax
  80274f:	05 60 40 80 00       	add    $0x804060,%eax
  802754:	8b 00                	mov    (%eax),%eax
  802756:	89 45 c8             	mov    %eax,-0x38(%ebp)
		LIST_REMOVE(&freeBlockLists[first_free_level],cur);
  802759:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
  80275d:	75 14                	jne    802773 <alloc_block+0x1d7>
  80275f:	83 ec 04             	sub    $0x4,%esp
  802762:	68 d7 39 80 00       	push   $0x8039d7
  802767:	6a 67                	push   $0x67
  802769:	68 bf 39 80 00       	push   $0x8039bf
  80276e:	e8 1b 05 00 00       	call   802c8e <_panic>
  802773:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802776:	8b 40 02             	mov    0x2(%eax),%eax
  802779:	85 c0                	test   %eax,%eax
  80277b:	74 11                	je     80278e <alloc_block+0x1f2>
  80277d:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802780:	8b 40 02             	mov    0x2(%eax),%eax
  802783:	8b 55 c8             	mov    -0x38(%ebp),%edx
  802786:	8b 52 06             	mov    0x6(%edx),%edx
  802789:	89 50 06             	mov    %edx,0x6(%eax)
  80278c:	eb 14                	jmp    8027a2 <alloc_block+0x206>
  80278e:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802791:	8b 40 06             	mov    0x6(%eax),%eax
  802794:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802797:	c1 e2 04             	shl    $0x4,%edx
  80279a:	81 c2 64 40 80 00    	add    $0x804064,%edx
  8027a0:	89 02                	mov    %eax,(%edx)
  8027a2:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8027a5:	8b 40 06             	mov    0x6(%eax),%eax
  8027a8:	85 c0                	test   %eax,%eax
  8027aa:	74 11                	je     8027bd <alloc_block+0x221>
  8027ac:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8027af:	8b 40 06             	mov    0x6(%eax),%eax
  8027b2:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8027b5:	8b 52 02             	mov    0x2(%edx),%edx
  8027b8:	89 50 02             	mov    %edx,0x2(%eax)
  8027bb:	eb 14                	jmp    8027d1 <alloc_block+0x235>
  8027bd:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8027c0:	8b 40 02             	mov    0x2(%eax),%eax
  8027c3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8027c6:	c1 e2 04             	shl    $0x4,%edx
  8027c9:	81 c2 60 40 80 00    	add    $0x804060,%edx
  8027cf:	89 02                	mov    %eax,(%edx)
  8027d1:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8027d4:	c7 40 02 00 00 00 00 	movl   $0x0,0x2(%eax)
  8027db:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8027de:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  8027e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8027e8:	c1 e0 04             	shl    $0x4,%eax
  8027eb:	05 6c 40 80 00       	add    $0x80406c,%eax
  8027f0:	8b 00                	mov    (%eax),%eax
  8027f2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8027f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8027f8:	c1 e0 04             	shl    $0x4,%eax
  8027fb:	05 6c 40 80 00       	add    $0x80406c,%eax
  802800:	89 10                	mov    %edx,(%eax)
		uint32 bAdress= (uint32)cur ^ BLOCK_SIZE((first_free_level-1));
  802802:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802805:	48                   	dec    %eax
  802806:	ba 01 00 00 00       	mov    $0x1,%edx
  80280b:	88 c1                	mov    %al,%cl
  80280d:	d3 e2                	shl    %cl,%edx
  80280f:	89 d0                	mov    %edx,%eax
  802811:	89 c2                	mov    %eax,%edx
  802813:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802816:	31 d0                	xor    %edx,%eax
  802818:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		struct BlockMetaData *buddy = (struct BlockMetaData*) bAdress;
  80281b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80281e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		buddy->level=first_free_level-1;
  802821:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802824:	8d 50 ff             	lea    -0x1(%eax),%edx
  802827:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80282a:	88 10                	mov    %dl,(%eax)
		buddy->is_free=1;
  80282c:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80282f:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		cur->is_free=1;
  802833:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802836:	c6 40 01 01          	movb   $0x1,0x1(%eax)
		cur->level=first_free_level-1;
  80283a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80283d:	8d 50 ff             	lea    -0x1(%eax),%edx
  802840:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802843:	88 10                	mov    %dl,(%eax)
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],buddy);
  802845:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
  802849:	75 14                	jne    80285f <alloc_block+0x2c3>
  80284b:	83 ec 04             	sub    $0x4,%esp
  80284e:	68 9c 39 80 00       	push   $0x80399c
  802853:	6a 6e                	push   $0x6e
  802855:	68 bf 39 80 00       	push   $0x8039bf
  80285a:	e8 2f 04 00 00       	call   802c8e <_panic>
  80285f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802862:	48                   	dec    %eax
  802863:	c1 e0 04             	shl    $0x4,%eax
  802866:	05 60 40 80 00       	add    $0x804060,%eax
  80286b:	8b 10                	mov    (%eax),%edx
  80286d:	8b 45 c0             	mov    -0x40(%ebp),%eax
  802870:	89 50 02             	mov    %edx,0x2(%eax)
  802873:	8b 45 c0             	mov    -0x40(%ebp),%eax
  802876:	8b 40 02             	mov    0x2(%eax),%eax
  802879:	85 c0                	test   %eax,%eax
  80287b:	74 16                	je     802893 <alloc_block+0x2f7>
  80287d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802880:	48                   	dec    %eax
  802881:	c1 e0 04             	shl    $0x4,%eax
  802884:	05 60 40 80 00       	add    $0x804060,%eax
  802889:	8b 00                	mov    (%eax),%eax
  80288b:	8b 55 c0             	mov    -0x40(%ebp),%edx
  80288e:	89 50 06             	mov    %edx,0x6(%eax)
  802891:	eb 12                	jmp    8028a5 <alloc_block+0x309>
  802893:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802896:	48                   	dec    %eax
  802897:	c1 e0 04             	shl    $0x4,%eax
  80289a:	8d 90 64 40 80 00    	lea    0x804064(%eax),%edx
  8028a0:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8028a3:	89 02                	mov    %eax,(%edx)
  8028a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8028a8:	48                   	dec    %eax
  8028a9:	c1 e0 04             	shl    $0x4,%eax
  8028ac:	8d 90 60 40 80 00    	lea    0x804060(%eax),%edx
  8028b2:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8028b5:	89 02                	mov    %eax,(%edx)
  8028b7:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8028ba:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  8028c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8028c4:	48                   	dec    %eax
  8028c5:	89 c2                	mov    %eax,%edx
  8028c7:	c1 e2 04             	shl    $0x4,%edx
  8028ca:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  8028d0:	8b 12                	mov    (%edx),%edx
  8028d2:	42                   	inc    %edx
  8028d3:	c1 e0 04             	shl    $0x4,%eax
  8028d6:	05 6c 40 80 00       	add    $0x80406c,%eax
  8028db:	89 10                	mov    %edx,(%eax)
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],cur);
  8028dd:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
  8028e1:	75 14                	jne    8028f7 <alloc_block+0x35b>
  8028e3:	83 ec 04             	sub    $0x4,%esp
  8028e6:	68 9c 39 80 00       	push   $0x80399c
  8028eb:	6a 6f                	push   $0x6f
  8028ed:	68 bf 39 80 00       	push   $0x8039bf
  8028f2:	e8 97 03 00 00       	call   802c8e <_panic>
  8028f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8028fa:	48                   	dec    %eax
  8028fb:	c1 e0 04             	shl    $0x4,%eax
  8028fe:	05 60 40 80 00       	add    $0x804060,%eax
  802903:	8b 10                	mov    (%eax),%edx
  802905:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802908:	89 50 02             	mov    %edx,0x2(%eax)
  80290b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80290e:	8b 40 02             	mov    0x2(%eax),%eax
  802911:	85 c0                	test   %eax,%eax
  802913:	74 16                	je     80292b <alloc_block+0x38f>
  802915:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802918:	48                   	dec    %eax
  802919:	c1 e0 04             	shl    $0x4,%eax
  80291c:	05 60 40 80 00       	add    $0x804060,%eax
  802921:	8b 00                	mov    (%eax),%eax
  802923:	8b 55 c8             	mov    -0x38(%ebp),%edx
  802926:	89 50 06             	mov    %edx,0x6(%eax)
  802929:	eb 12                	jmp    80293d <alloc_block+0x3a1>
  80292b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80292e:	48                   	dec    %eax
  80292f:	c1 e0 04             	shl    $0x4,%eax
  802932:	8d 90 64 40 80 00    	lea    0x804064(%eax),%edx
  802938:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80293b:	89 02                	mov    %eax,(%edx)
  80293d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802940:	48                   	dec    %eax
  802941:	c1 e0 04             	shl    $0x4,%eax
  802944:	8d 90 60 40 80 00    	lea    0x804060(%eax),%edx
  80294a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80294d:	89 02                	mov    %eax,(%edx)
  80294f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  802952:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  802959:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80295c:	48                   	dec    %eax
  80295d:	89 c2                	mov    %eax,%edx
  80295f:	c1 e2 04             	shl    $0x4,%edx
  802962:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  802968:	8b 12                	mov    (%edx),%edx
  80296a:	42                   	inc    %edx
  80296b:	c1 e0 04             	shl    $0x4,%eax
  80296e:	05 6c 40 80 00       	add    $0x80406c,%eax
  802973:	89 10                	mov    %edx,(%eax)
		first_free_level--;
  802975:	ff 4d ec             	decl   -0x14(%ebp)
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],cur);
		first_free_level=BUDDY_UPPER_LEVEL;
	}


	while(first_free_level > level){
  802978:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80297b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80297e:	0f 87 c5 fd ff ff    	ja     802749 <alloc_block+0x1ad>
		cur->level=first_free_level-1;
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],buddy);
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],cur);
		first_free_level--;
	}
	struct BlockMetaData *ret = LIST_FIRST(&freeBlockLists[level]);
  802984:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802987:	c1 e0 04             	shl    $0x4,%eax
  80298a:	05 60 40 80 00       	add    $0x804060,%eax
  80298f:	8b 00                	mov    (%eax),%eax
  802991:	89 45 bc             	mov    %eax,-0x44(%ebp)
	LIST_REMOVE(&freeBlockLists[level],ret);
  802994:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
  802998:	75 14                	jne    8029ae <alloc_block+0x412>
  80299a:	83 ec 04             	sub    $0x4,%esp
  80299d:	68 d7 39 80 00       	push   $0x8039d7
  8029a2:	6a 73                	push   $0x73
  8029a4:	68 bf 39 80 00       	push   $0x8039bf
  8029a9:	e8 e0 02 00 00       	call   802c8e <_panic>
  8029ae:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8029b1:	8b 40 02             	mov    0x2(%eax),%eax
  8029b4:	85 c0                	test   %eax,%eax
  8029b6:	74 11                	je     8029c9 <alloc_block+0x42d>
  8029b8:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8029bb:	8b 40 02             	mov    0x2(%eax),%eax
  8029be:	8b 55 bc             	mov    -0x44(%ebp),%edx
  8029c1:	8b 52 06             	mov    0x6(%edx),%edx
  8029c4:	89 50 06             	mov    %edx,0x6(%eax)
  8029c7:	eb 14                	jmp    8029dd <alloc_block+0x441>
  8029c9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8029cc:	8b 40 06             	mov    0x6(%eax),%eax
  8029cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8029d2:	c1 e2 04             	shl    $0x4,%edx
  8029d5:	81 c2 64 40 80 00    	add    $0x804064,%edx
  8029db:	89 02                	mov    %eax,(%edx)
  8029dd:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8029e0:	8b 40 06             	mov    0x6(%eax),%eax
  8029e3:	85 c0                	test   %eax,%eax
  8029e5:	74 11                	je     8029f8 <alloc_block+0x45c>
  8029e7:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8029ea:	8b 40 06             	mov    0x6(%eax),%eax
  8029ed:	8b 55 bc             	mov    -0x44(%ebp),%edx
  8029f0:	8b 52 02             	mov    0x2(%edx),%edx
  8029f3:	89 50 02             	mov    %edx,0x2(%eax)
  8029f6:	eb 14                	jmp    802a0c <alloc_block+0x470>
  8029f8:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8029fb:	8b 40 02             	mov    0x2(%eax),%eax
  8029fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802a01:	c1 e2 04             	shl    $0x4,%edx
  802a04:	81 c2 60 40 80 00    	add    $0x804060,%edx
  802a0a:	89 02                	mov    %eax,(%edx)
  802a0c:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802a0f:	c7 40 02 00 00 00 00 	movl   $0x0,0x2(%eax)
  802a16:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802a19:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  802a20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a23:	c1 e0 04             	shl    $0x4,%eax
  802a26:	05 6c 40 80 00       	add    $0x80406c,%eax
  802a2b:	8b 00                	mov    (%eax),%eax
  802a2d:	8d 50 ff             	lea    -0x1(%eax),%edx
  802a30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a33:	c1 e0 04             	shl    $0x4,%eax
  802a36:	05 6c 40 80 00       	add    $0x80406c,%eax
  802a3b:	89 10                	mov    %edx,(%eax)
	ret -> is_free=0;
  802a3d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802a40:	c6 40 01 00          	movb   $0x0,0x1(%eax)
	void *ret_adress= (void *)((uint32) ret+META_DATA_SIZE);
  802a44:	8b 45 bc             	mov    -0x44(%ebp),%eax
  802a47:	83 c0 0a             	add    $0xa,%eax
  802a4a:	89 45 b8             	mov    %eax,-0x48(%ebp)
	return ret_adress;
  802a4d:	8b 45 b8             	mov    -0x48(%ebp),%eax
}
  802a50:	c9                   	leave  
  802a51:	c3                   	ret    

00802a52 <free_block>:

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
  802a52:	55                   	push   %ebp
  802a53:	89 e5                	mov    %esp,%ebp
  802a55:	83 ec 28             	sub    $0x28,%esp
	uint32 curAddress = (uint32) va - META_DATA_SIZE;
  802a58:	8b 45 08             	mov    0x8(%ebp),%eax
  802a5b:	83 e8 0a             	sub    $0xa,%eax
  802a5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct BlockMetaData *cur = (struct BlockMetaData *)curAddress;
  802a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a64:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cur->is_free = 1;
  802a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a6a:	c6 40 01 01          	movb   $0x1,0x1(%eax)

	while(cur->level <= BUDDY_UPPER_LEVEL){
  802a6e:	e9 1a 01 00 00       	jmp    802b8d <free_block+0x13b>
		void *tva = (void *)(curAddress + META_DATA_SIZE);
  802a73:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802a76:	83 c0 0a             	add    $0xa,%eax
  802a79:	89 45 ec             	mov    %eax,-0x14(%ebp)
		uint32 buddyAddress = curAddress ^ get_block_size(tva);
  802a7c:	ff 75 ec             	pushl  -0x14(%ebp)
  802a7f:	e8 e8 fa ff ff       	call   80256c <get_block_size>
  802a84:	83 c4 04             	add    $0x4,%esp
  802a87:	33 45 f4             	xor    -0xc(%ebp),%eax
  802a8a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		struct BlockMetaData *buddy = (struct BlockMetaData *)buddyAddress;
  802a8d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802a90:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if(buddy->is_free == 1 && buddy->level == cur->level){
  802a93:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802a96:	8a 40 01             	mov    0x1(%eax),%al
  802a99:	3c 01                	cmp    $0x1,%al
  802a9b:	0f 85 f9 00 00 00    	jne    802b9a <free_block+0x148>
  802aa1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802aa4:	8a 10                	mov    (%eax),%dl
  802aa6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802aa9:	8a 00                	mov    (%eax),%al
  802aab:	38 c2                	cmp    %al,%dl
  802aad:	0f 85 e7 00 00 00    	jne    802b9a <free_block+0x148>
			if(buddyAddress<curAddress) curAddress = buddyAddress;
  802ab3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802ab6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802ab9:	73 06                	jae    802ac1 <free_block+0x6f>
  802abb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802abe:	89 45 f4             	mov    %eax,-0xc(%ebp)
			LIST_REMOVE(&freeBlockLists[buddy->level], buddy);
  802ac1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  802ac5:	75 17                	jne    802ade <free_block+0x8c>
  802ac7:	83 ec 04             	sub    $0x4,%esp
  802aca:	68 d7 39 80 00       	push   $0x8039d7
  802acf:	68 88 00 00 00       	push   $0x88
  802ad4:	68 bf 39 80 00       	push   $0x8039bf
  802ad9:	e8 b0 01 00 00       	call   802c8e <_panic>
  802ade:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802ae1:	8b 40 02             	mov    0x2(%eax),%eax
  802ae4:	85 c0                	test   %eax,%eax
  802ae6:	74 11                	je     802af9 <free_block+0xa7>
  802ae8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802aeb:	8b 40 02             	mov    0x2(%eax),%eax
  802aee:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802af1:	8b 52 06             	mov    0x6(%edx),%edx
  802af4:	89 50 06             	mov    %edx,0x6(%eax)
  802af7:	eb 19                	jmp    802b12 <free_block+0xc0>
  802af9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802afc:	8a 00                	mov    (%eax),%al
  802afe:	0f b6 d0             	movzbl %al,%edx
  802b01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802b04:	8b 40 06             	mov    0x6(%eax),%eax
  802b07:	c1 e2 04             	shl    $0x4,%edx
  802b0a:	81 c2 64 40 80 00    	add    $0x804064,%edx
  802b10:	89 02                	mov    %eax,(%edx)
  802b12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802b15:	8b 40 06             	mov    0x6(%eax),%eax
  802b18:	85 c0                	test   %eax,%eax
  802b1a:	74 11                	je     802b2d <free_block+0xdb>
  802b1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802b1f:	8b 40 06             	mov    0x6(%eax),%eax
  802b22:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802b25:	8b 52 02             	mov    0x2(%edx),%edx
  802b28:	89 50 02             	mov    %edx,0x2(%eax)
  802b2b:	eb 19                	jmp    802b46 <free_block+0xf4>
  802b2d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802b30:	8a 00                	mov    (%eax),%al
  802b32:	0f b6 d0             	movzbl %al,%edx
  802b35:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802b38:	8b 40 02             	mov    0x2(%eax),%eax
  802b3b:	c1 e2 04             	shl    $0x4,%edx
  802b3e:	81 c2 60 40 80 00    	add    $0x804060,%edx
  802b44:	89 02                	mov    %eax,(%edx)
  802b46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802b49:	c7 40 02 00 00 00 00 	movl   $0x0,0x2(%eax)
  802b50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802b53:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  802b5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802b5d:	8a 00                	mov    (%eax),%al
  802b5f:	0f b6 c0             	movzbl %al,%eax
  802b62:	89 c2                	mov    %eax,%edx
  802b64:	c1 e2 04             	shl    $0x4,%edx
  802b67:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  802b6d:	8b 12                	mov    (%edx),%edx
  802b6f:	4a                   	dec    %edx
  802b70:	c1 e0 04             	shl    $0x4,%eax
  802b73:	05 6c 40 80 00       	add    $0x80406c,%eax
  802b78:	89 10                	mov    %edx,(%eax)
			cur = (struct BlockMetaData *)curAddress;
  802b7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802b7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
			cur->level = buddy->level+1;
  802b80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802b83:	8a 00                	mov    (%eax),%al
  802b85:	8d 50 01             	lea    0x1(%eax),%edx
  802b88:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802b8b:	88 10                	mov    %dl,(%eax)
{
	uint32 curAddress = (uint32) va - META_DATA_SIZE;
	struct BlockMetaData *cur = (struct BlockMetaData *)curAddress;
	cur->is_free = 1;

	while(cur->level <= BUDDY_UPPER_LEVEL){
  802b8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802b90:	8a 00                	mov    (%eax),%al
  802b92:	3c 0b                	cmp    $0xb,%al
  802b94:	0f 86 d9 fe ff ff    	jbe    802a73 <free_block+0x21>
			cur = (struct BlockMetaData *)curAddress;
			cur->level = buddy->level+1;
		}
		else break;
	}
	if(cur->level > BUDDY_UPPER_LEVEL){
  802b9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802b9d:	8a 00                	mov    (%eax),%al
  802b9f:	3c 0b                	cmp    $0xb,%al
  802ba1:	76 1c                	jbe    802bbf <free_block+0x16d>
		void *tva = (void *)(curAddress + META_DATA_SIZE);
  802ba3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802ba6:	83 c0 0a             	add    $0xa,%eax
  802ba9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		delete_buddy_space(tva);
  802bac:	83 ec 0c             	sub    $0xc,%esp
  802baf:	ff 75 e0             	pushl  -0x20(%ebp)
  802bb2:	e8 e9 f2 ff ff       	call   801ea0 <delete_buddy_space>
  802bb7:	83 c4 10             	add    $0x10,%esp
	}
	else LIST_INSERT_HEAD(&freeBlockLists[cur->level], cur);
}
  802bba:	e9 af 00 00 00       	jmp    802c6e <free_block+0x21c>
	}
	if(cur->level > BUDDY_UPPER_LEVEL){
		void *tva = (void *)(curAddress + META_DATA_SIZE);
		delete_buddy_space(tva);
	}
	else LIST_INSERT_HEAD(&freeBlockLists[cur->level], cur);
  802bbf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  802bc3:	75 17                	jne    802bdc <free_block+0x18a>
  802bc5:	83 ec 04             	sub    $0x4,%esp
  802bc8:	68 9c 39 80 00       	push   $0x80399c
  802bcd:	68 92 00 00 00       	push   $0x92
  802bd2:	68 bf 39 80 00       	push   $0x8039bf
  802bd7:	e8 b2 00 00 00       	call   802c8e <_panic>
  802bdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802bdf:	8a 00                	mov    (%eax),%al
  802be1:	0f b6 c0             	movzbl %al,%eax
  802be4:	c1 e0 04             	shl    $0x4,%eax
  802be7:	05 60 40 80 00       	add    $0x804060,%eax
  802bec:	8b 10                	mov    (%eax),%edx
  802bee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802bf1:	89 50 02             	mov    %edx,0x2(%eax)
  802bf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802bf7:	8b 40 02             	mov    0x2(%eax),%eax
  802bfa:	85 c0                	test   %eax,%eax
  802bfc:	74 1a                	je     802c18 <free_block+0x1c6>
  802bfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802c01:	8a 00                	mov    (%eax),%al
  802c03:	0f b6 c0             	movzbl %al,%eax
  802c06:	c1 e0 04             	shl    $0x4,%eax
  802c09:	05 60 40 80 00       	add    $0x804060,%eax
  802c0e:	8b 00                	mov    (%eax),%eax
  802c10:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802c13:	89 50 06             	mov    %edx,0x6(%eax)
  802c16:	eb 16                	jmp    802c2e <free_block+0x1dc>
  802c18:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802c1b:	8a 00                	mov    (%eax),%al
  802c1d:	0f b6 c0             	movzbl %al,%eax
  802c20:	c1 e0 04             	shl    $0x4,%eax
  802c23:	8d 90 64 40 80 00    	lea    0x804064(%eax),%edx
  802c29:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802c2c:	89 02                	mov    %eax,(%edx)
  802c2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802c31:	8a 00                	mov    (%eax),%al
  802c33:	0f b6 c0             	movzbl %al,%eax
  802c36:	c1 e0 04             	shl    $0x4,%eax
  802c39:	8d 90 60 40 80 00    	lea    0x804060(%eax),%edx
  802c3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802c42:	89 02                	mov    %eax,(%edx)
  802c44:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802c47:	c7 40 06 00 00 00 00 	movl   $0x0,0x6(%eax)
  802c4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802c51:	8a 00                	mov    (%eax),%al
  802c53:	0f b6 c0             	movzbl %al,%eax
  802c56:	89 c2                	mov    %eax,%edx
  802c58:	c1 e2 04             	shl    $0x4,%edx
  802c5b:	81 c2 6c 40 80 00    	add    $0x80406c,%edx
  802c61:	8b 12                	mov    (%edx),%edx
  802c63:	42                   	inc    %edx
  802c64:	c1 e0 04             	shl    $0x4,%eax
  802c67:	05 6c 40 80 00       	add    $0x80406c,%eax
  802c6c:	89 10                	mov    %edx,(%eax)
}
  802c6e:	90                   	nop
  802c6f:	c9                   	leave  
  802c70:	c3                   	ret    

00802c71 <realloc_block>:

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
  802c71:	55                   	push   %ebp
  802c72:	89 e5                	mov    %esp,%ebp
  802c74:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
  802c77:	83 ec 04             	sub    $0x4,%esp
  802c7a:	68 f8 39 80 00       	push   $0x8039f8
  802c7f:	68 a1 00 00 00       	push   $0xa1
  802c84:	68 bf 39 80 00       	push   $0x8039bf
  802c89:	e8 00 00 00 00       	call   802c8e <_panic>

00802c8e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  802c8e:	55                   	push   %ebp
  802c8f:	89 e5                	mov    %esp,%ebp
  802c91:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  802c94:	8d 45 10             	lea    0x10(%ebp),%eax
  802c97:	83 c0 04             	add    $0x4,%eax
  802c9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  802c9d:	a1 2c 41 80 00       	mov    0x80412c,%eax
  802ca2:	85 c0                	test   %eax,%eax
  802ca4:	74 16                	je     802cbc <_panic+0x2e>
		cprintf("%s: ", argv0);
  802ca6:	a1 2c 41 80 00       	mov    0x80412c,%eax
  802cab:	83 ec 08             	sub    $0x8,%esp
  802cae:	50                   	push   %eax
  802caf:	68 1c 3a 80 00       	push   $0x803a1c
  802cb4:	e8 a1 e0 ff ff       	call   800d5a <cprintf>
  802cb9:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  802cbc:	a1 04 40 80 00       	mov    0x804004,%eax
  802cc1:	83 ec 0c             	sub    $0xc,%esp
  802cc4:	ff 75 0c             	pushl  0xc(%ebp)
  802cc7:	ff 75 08             	pushl  0x8(%ebp)
  802cca:	50                   	push   %eax
  802ccb:	68 24 3a 80 00       	push   $0x803a24
  802cd0:	6a 74                	push   $0x74
  802cd2:	e8 b0 e0 ff ff       	call   800d87 <cprintf_colored>
  802cd7:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  802cda:	8b 45 10             	mov    0x10(%ebp),%eax
  802cdd:	83 ec 08             	sub    $0x8,%esp
  802ce0:	ff 75 f4             	pushl  -0xc(%ebp)
  802ce3:	50                   	push   %eax
  802ce4:	e8 02 e0 ff ff       	call   800ceb <vcprintf>
  802ce9:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  802cec:	83 ec 08             	sub    $0x8,%esp
  802cef:	6a 00                	push   $0x0
  802cf1:	68 4c 3a 80 00       	push   $0x803a4c
  802cf6:	e8 f0 df ff ff       	call   800ceb <vcprintf>
  802cfb:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  802cfe:	e8 69 df ff ff       	call   800c6c <exit>

	// should not return here
	while (1) ;
  802d03:	eb fe                	jmp    802d03 <_panic+0x75>

00802d05 <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  802d05:	55                   	push   %ebp
  802d06:	89 e5                	mov    %esp,%ebp
  802d08:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  802d0b:	a1 20 40 80 00       	mov    0x804020,%eax
  802d10:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802d16:	8b 45 0c             	mov    0xc(%ebp),%eax
  802d19:	39 c2                	cmp    %eax,%edx
  802d1b:	74 14                	je     802d31 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  802d1d:	83 ec 04             	sub    $0x4,%esp
  802d20:	68 50 3a 80 00       	push   $0x803a50
  802d25:	6a 26                	push   $0x26
  802d27:	68 9c 3a 80 00       	push   $0x803a9c
  802d2c:	e8 5d ff ff ff       	call   802c8e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  802d31:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  802d38:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802d3f:	e9 c5 00 00 00       	jmp    802e09 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  802d44:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802d47:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  802d51:	01 d0                	add    %edx,%eax
  802d53:	8b 00                	mov    (%eax),%eax
  802d55:	85 c0                	test   %eax,%eax
  802d57:	75 08                	jne    802d61 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  802d59:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  802d5c:	e9 a5 00 00 00       	jmp    802e06 <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  802d61:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802d68:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  802d6f:	eb 69                	jmp    802dda <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  802d71:	a1 20 40 80 00       	mov    0x804020,%eax
  802d76:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  802d7c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  802d7f:	89 d0                	mov    %edx,%eax
  802d81:	01 c0                	add    %eax,%eax
  802d83:	01 d0                	add    %edx,%eax
  802d85:	c1 e0 03             	shl    $0x3,%eax
  802d88:	01 c8                	add    %ecx,%eax
  802d8a:	8a 40 04             	mov    0x4(%eax),%al
  802d8d:	84 c0                	test   %al,%al
  802d8f:	75 46                	jne    802dd7 <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  802d91:	a1 20 40 80 00       	mov    0x804020,%eax
  802d96:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  802d9c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  802d9f:	89 d0                	mov    %edx,%eax
  802da1:	01 c0                	add    %eax,%eax
  802da3:	01 d0                	add    %edx,%eax
  802da5:	c1 e0 03             	shl    $0x3,%eax
  802da8:	01 c8                	add    %ecx,%eax
  802daa:	8b 00                	mov    (%eax),%eax
  802dac:	89 45 dc             	mov    %eax,-0x24(%ebp)
  802daf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802db2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  802db7:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  802db9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802dbc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  802dc3:	8b 45 08             	mov    0x8(%ebp),%eax
  802dc6:	01 c8                	add    %ecx,%eax
  802dc8:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  802dca:	39 c2                	cmp    %eax,%edx
  802dcc:	75 09                	jne    802dd7 <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  802dce:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  802dd5:	eb 15                	jmp    802dec <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802dd7:	ff 45 e8             	incl   -0x18(%ebp)
  802dda:	a1 20 40 80 00       	mov    0x804020,%eax
  802ddf:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802de5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802de8:	39 c2                	cmp    %eax,%edx
  802dea:	77 85                	ja     802d71 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  802dec:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  802df0:	75 14                	jne    802e06 <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  802df2:	83 ec 04             	sub    $0x4,%esp
  802df5:	68 a8 3a 80 00       	push   $0x803aa8
  802dfa:	6a 3a                	push   $0x3a
  802dfc:	68 9c 3a 80 00       	push   $0x803a9c
  802e01:	e8 88 fe ff ff       	call   802c8e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  802e06:	ff 45 f0             	incl   -0x10(%ebp)
  802e09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802e0c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  802e0f:	0f 8c 2f ff ff ff    	jl     802d44 <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  802e15:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802e1c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  802e23:	eb 26                	jmp    802e4b <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  802e25:	a1 20 40 80 00       	mov    0x804020,%eax
  802e2a:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  802e30:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802e33:	89 d0                	mov    %edx,%eax
  802e35:	01 c0                	add    %eax,%eax
  802e37:	01 d0                	add    %edx,%eax
  802e39:	c1 e0 03             	shl    $0x3,%eax
  802e3c:	01 c8                	add    %ecx,%eax
  802e3e:	8a 40 04             	mov    0x4(%eax),%al
  802e41:	3c 01                	cmp    $0x1,%al
  802e43:	75 03                	jne    802e48 <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  802e45:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802e48:	ff 45 e0             	incl   -0x20(%ebp)
  802e4b:	a1 20 40 80 00       	mov    0x804020,%eax
  802e50:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  802e56:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802e59:	39 c2                	cmp    %eax,%edx
  802e5b:	77 c8                	ja     802e25 <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  802e5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802e60:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802e63:	74 14                	je     802e79 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  802e65:	83 ec 04             	sub    $0x4,%esp
  802e68:	68 fc 3a 80 00       	push   $0x803afc
  802e6d:	6a 44                	push   $0x44
  802e6f:	68 9c 3a 80 00       	push   $0x803a9c
  802e74:	e8 15 fe ff ff       	call   802c8e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  802e79:	90                   	nop
  802e7a:	c9                   	leave  
  802e7b:	c3                   	ret    

00802e7c <__udivdi3>:
  802e7c:	55                   	push   %ebp
  802e7d:	57                   	push   %edi
  802e7e:	56                   	push   %esi
  802e7f:	53                   	push   %ebx
  802e80:	83 ec 1c             	sub    $0x1c,%esp
  802e83:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802e87:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802e8b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802e8f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802e93:	89 ca                	mov    %ecx,%edx
  802e95:	89 f8                	mov    %edi,%eax
  802e97:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802e9b:	85 f6                	test   %esi,%esi
  802e9d:	75 2d                	jne    802ecc <__udivdi3+0x50>
  802e9f:	39 cf                	cmp    %ecx,%edi
  802ea1:	77 65                	ja     802f08 <__udivdi3+0x8c>
  802ea3:	89 fd                	mov    %edi,%ebp
  802ea5:	85 ff                	test   %edi,%edi
  802ea7:	75 0b                	jne    802eb4 <__udivdi3+0x38>
  802ea9:	b8 01 00 00 00       	mov    $0x1,%eax
  802eae:	31 d2                	xor    %edx,%edx
  802eb0:	f7 f7                	div    %edi
  802eb2:	89 c5                	mov    %eax,%ebp
  802eb4:	31 d2                	xor    %edx,%edx
  802eb6:	89 c8                	mov    %ecx,%eax
  802eb8:	f7 f5                	div    %ebp
  802eba:	89 c1                	mov    %eax,%ecx
  802ebc:	89 d8                	mov    %ebx,%eax
  802ebe:	f7 f5                	div    %ebp
  802ec0:	89 cf                	mov    %ecx,%edi
  802ec2:	89 fa                	mov    %edi,%edx
  802ec4:	83 c4 1c             	add    $0x1c,%esp
  802ec7:	5b                   	pop    %ebx
  802ec8:	5e                   	pop    %esi
  802ec9:	5f                   	pop    %edi
  802eca:	5d                   	pop    %ebp
  802ecb:	c3                   	ret    
  802ecc:	39 ce                	cmp    %ecx,%esi
  802ece:	77 28                	ja     802ef8 <__udivdi3+0x7c>
  802ed0:	0f bd fe             	bsr    %esi,%edi
  802ed3:	83 f7 1f             	xor    $0x1f,%edi
  802ed6:	75 40                	jne    802f18 <__udivdi3+0x9c>
  802ed8:	39 ce                	cmp    %ecx,%esi
  802eda:	72 0a                	jb     802ee6 <__udivdi3+0x6a>
  802edc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802ee0:	0f 87 9e 00 00 00    	ja     802f84 <__udivdi3+0x108>
  802ee6:	b8 01 00 00 00       	mov    $0x1,%eax
  802eeb:	89 fa                	mov    %edi,%edx
  802eed:	83 c4 1c             	add    $0x1c,%esp
  802ef0:	5b                   	pop    %ebx
  802ef1:	5e                   	pop    %esi
  802ef2:	5f                   	pop    %edi
  802ef3:	5d                   	pop    %ebp
  802ef4:	c3                   	ret    
  802ef5:	8d 76 00             	lea    0x0(%esi),%esi
  802ef8:	31 ff                	xor    %edi,%edi
  802efa:	31 c0                	xor    %eax,%eax
  802efc:	89 fa                	mov    %edi,%edx
  802efe:	83 c4 1c             	add    $0x1c,%esp
  802f01:	5b                   	pop    %ebx
  802f02:	5e                   	pop    %esi
  802f03:	5f                   	pop    %edi
  802f04:	5d                   	pop    %ebp
  802f05:	c3                   	ret    
  802f06:	66 90                	xchg   %ax,%ax
  802f08:	89 d8                	mov    %ebx,%eax
  802f0a:	f7 f7                	div    %edi
  802f0c:	31 ff                	xor    %edi,%edi
  802f0e:	89 fa                	mov    %edi,%edx
  802f10:	83 c4 1c             	add    $0x1c,%esp
  802f13:	5b                   	pop    %ebx
  802f14:	5e                   	pop    %esi
  802f15:	5f                   	pop    %edi
  802f16:	5d                   	pop    %ebp
  802f17:	c3                   	ret    
  802f18:	bd 20 00 00 00       	mov    $0x20,%ebp
  802f1d:	89 eb                	mov    %ebp,%ebx
  802f1f:	29 fb                	sub    %edi,%ebx
  802f21:	89 f9                	mov    %edi,%ecx
  802f23:	d3 e6                	shl    %cl,%esi
  802f25:	89 c5                	mov    %eax,%ebp
  802f27:	88 d9                	mov    %bl,%cl
  802f29:	d3 ed                	shr    %cl,%ebp
  802f2b:	89 e9                	mov    %ebp,%ecx
  802f2d:	09 f1                	or     %esi,%ecx
  802f2f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802f33:	89 f9                	mov    %edi,%ecx
  802f35:	d3 e0                	shl    %cl,%eax
  802f37:	89 c5                	mov    %eax,%ebp
  802f39:	89 d6                	mov    %edx,%esi
  802f3b:	88 d9                	mov    %bl,%cl
  802f3d:	d3 ee                	shr    %cl,%esi
  802f3f:	89 f9                	mov    %edi,%ecx
  802f41:	d3 e2                	shl    %cl,%edx
  802f43:	8b 44 24 08          	mov    0x8(%esp),%eax
  802f47:	88 d9                	mov    %bl,%cl
  802f49:	d3 e8                	shr    %cl,%eax
  802f4b:	09 c2                	or     %eax,%edx
  802f4d:	89 d0                	mov    %edx,%eax
  802f4f:	89 f2                	mov    %esi,%edx
  802f51:	f7 74 24 0c          	divl   0xc(%esp)
  802f55:	89 d6                	mov    %edx,%esi
  802f57:	89 c3                	mov    %eax,%ebx
  802f59:	f7 e5                	mul    %ebp
  802f5b:	39 d6                	cmp    %edx,%esi
  802f5d:	72 19                	jb     802f78 <__udivdi3+0xfc>
  802f5f:	74 0b                	je     802f6c <__udivdi3+0xf0>
  802f61:	89 d8                	mov    %ebx,%eax
  802f63:	31 ff                	xor    %edi,%edi
  802f65:	e9 58 ff ff ff       	jmp    802ec2 <__udivdi3+0x46>
  802f6a:	66 90                	xchg   %ax,%ax
  802f6c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802f70:	89 f9                	mov    %edi,%ecx
  802f72:	d3 e2                	shl    %cl,%edx
  802f74:	39 c2                	cmp    %eax,%edx
  802f76:	73 e9                	jae    802f61 <__udivdi3+0xe5>
  802f78:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802f7b:	31 ff                	xor    %edi,%edi
  802f7d:	e9 40 ff ff ff       	jmp    802ec2 <__udivdi3+0x46>
  802f82:	66 90                	xchg   %ax,%ax
  802f84:	31 c0                	xor    %eax,%eax
  802f86:	e9 37 ff ff ff       	jmp    802ec2 <__udivdi3+0x46>
  802f8b:	90                   	nop

00802f8c <__umoddi3>:
  802f8c:	55                   	push   %ebp
  802f8d:	57                   	push   %edi
  802f8e:	56                   	push   %esi
  802f8f:	53                   	push   %ebx
  802f90:	83 ec 1c             	sub    $0x1c,%esp
  802f93:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802f97:	8b 74 24 34          	mov    0x34(%esp),%esi
  802f9b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802f9f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802fa3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802fa7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802fab:	89 f3                	mov    %esi,%ebx
  802fad:	89 fa                	mov    %edi,%edx
  802faf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802fb3:	89 34 24             	mov    %esi,(%esp)
  802fb6:	85 c0                	test   %eax,%eax
  802fb8:	75 1a                	jne    802fd4 <__umoddi3+0x48>
  802fba:	39 f7                	cmp    %esi,%edi
  802fbc:	0f 86 a2 00 00 00    	jbe    803064 <__umoddi3+0xd8>
  802fc2:	89 c8                	mov    %ecx,%eax
  802fc4:	89 f2                	mov    %esi,%edx
  802fc6:	f7 f7                	div    %edi
  802fc8:	89 d0                	mov    %edx,%eax
  802fca:	31 d2                	xor    %edx,%edx
  802fcc:	83 c4 1c             	add    $0x1c,%esp
  802fcf:	5b                   	pop    %ebx
  802fd0:	5e                   	pop    %esi
  802fd1:	5f                   	pop    %edi
  802fd2:	5d                   	pop    %ebp
  802fd3:	c3                   	ret    
  802fd4:	39 f0                	cmp    %esi,%eax
  802fd6:	0f 87 ac 00 00 00    	ja     803088 <__umoddi3+0xfc>
  802fdc:	0f bd e8             	bsr    %eax,%ebp
  802fdf:	83 f5 1f             	xor    $0x1f,%ebp
  802fe2:	0f 84 ac 00 00 00    	je     803094 <__umoddi3+0x108>
  802fe8:	bf 20 00 00 00       	mov    $0x20,%edi
  802fed:	29 ef                	sub    %ebp,%edi
  802fef:	89 fe                	mov    %edi,%esi
  802ff1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802ff5:	89 e9                	mov    %ebp,%ecx
  802ff7:	d3 e0                	shl    %cl,%eax
  802ff9:	89 d7                	mov    %edx,%edi
  802ffb:	89 f1                	mov    %esi,%ecx
  802ffd:	d3 ef                	shr    %cl,%edi
  802fff:	09 c7                	or     %eax,%edi
  803001:	89 e9                	mov    %ebp,%ecx
  803003:	d3 e2                	shl    %cl,%edx
  803005:	89 14 24             	mov    %edx,(%esp)
  803008:	89 d8                	mov    %ebx,%eax
  80300a:	d3 e0                	shl    %cl,%eax
  80300c:	89 c2                	mov    %eax,%edx
  80300e:	8b 44 24 08          	mov    0x8(%esp),%eax
  803012:	d3 e0                	shl    %cl,%eax
  803014:	89 44 24 04          	mov    %eax,0x4(%esp)
  803018:	8b 44 24 08          	mov    0x8(%esp),%eax
  80301c:	89 f1                	mov    %esi,%ecx
  80301e:	d3 e8                	shr    %cl,%eax
  803020:	09 d0                	or     %edx,%eax
  803022:	d3 eb                	shr    %cl,%ebx
  803024:	89 da                	mov    %ebx,%edx
  803026:	f7 f7                	div    %edi
  803028:	89 d3                	mov    %edx,%ebx
  80302a:	f7 24 24             	mull   (%esp)
  80302d:	89 c6                	mov    %eax,%esi
  80302f:	89 d1                	mov    %edx,%ecx
  803031:	39 d3                	cmp    %edx,%ebx
  803033:	0f 82 87 00 00 00    	jb     8030c0 <__umoddi3+0x134>
  803039:	0f 84 91 00 00 00    	je     8030d0 <__umoddi3+0x144>
  80303f:	8b 54 24 04          	mov    0x4(%esp),%edx
  803043:	29 f2                	sub    %esi,%edx
  803045:	19 cb                	sbb    %ecx,%ebx
  803047:	89 d8                	mov    %ebx,%eax
  803049:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80304d:	d3 e0                	shl    %cl,%eax
  80304f:	89 e9                	mov    %ebp,%ecx
  803051:	d3 ea                	shr    %cl,%edx
  803053:	09 d0                	or     %edx,%eax
  803055:	89 e9                	mov    %ebp,%ecx
  803057:	d3 eb                	shr    %cl,%ebx
  803059:	89 da                	mov    %ebx,%edx
  80305b:	83 c4 1c             	add    $0x1c,%esp
  80305e:	5b                   	pop    %ebx
  80305f:	5e                   	pop    %esi
  803060:	5f                   	pop    %edi
  803061:	5d                   	pop    %ebp
  803062:	c3                   	ret    
  803063:	90                   	nop
  803064:	89 fd                	mov    %edi,%ebp
  803066:	85 ff                	test   %edi,%edi
  803068:	75 0b                	jne    803075 <__umoddi3+0xe9>
  80306a:	b8 01 00 00 00       	mov    $0x1,%eax
  80306f:	31 d2                	xor    %edx,%edx
  803071:	f7 f7                	div    %edi
  803073:	89 c5                	mov    %eax,%ebp
  803075:	89 f0                	mov    %esi,%eax
  803077:	31 d2                	xor    %edx,%edx
  803079:	f7 f5                	div    %ebp
  80307b:	89 c8                	mov    %ecx,%eax
  80307d:	f7 f5                	div    %ebp
  80307f:	89 d0                	mov    %edx,%eax
  803081:	e9 44 ff ff ff       	jmp    802fca <__umoddi3+0x3e>
  803086:	66 90                	xchg   %ax,%ax
  803088:	89 c8                	mov    %ecx,%eax
  80308a:	89 f2                	mov    %esi,%edx
  80308c:	83 c4 1c             	add    $0x1c,%esp
  80308f:	5b                   	pop    %ebx
  803090:	5e                   	pop    %esi
  803091:	5f                   	pop    %edi
  803092:	5d                   	pop    %ebp
  803093:	c3                   	ret    
  803094:	3b 04 24             	cmp    (%esp),%eax
  803097:	72 06                	jb     80309f <__umoddi3+0x113>
  803099:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80309d:	77 0f                	ja     8030ae <__umoddi3+0x122>
  80309f:	89 f2                	mov    %esi,%edx
  8030a1:	29 f9                	sub    %edi,%ecx
  8030a3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8030a7:	89 14 24             	mov    %edx,(%esp)
  8030aa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8030ae:	8b 44 24 04          	mov    0x4(%esp),%eax
  8030b2:	8b 14 24             	mov    (%esp),%edx
  8030b5:	83 c4 1c             	add    $0x1c,%esp
  8030b8:	5b                   	pop    %ebx
  8030b9:	5e                   	pop    %esi
  8030ba:	5f                   	pop    %edi
  8030bb:	5d                   	pop    %ebp
  8030bc:	c3                   	ret    
  8030bd:	8d 76 00             	lea    0x0(%esi),%esi
  8030c0:	2b 04 24             	sub    (%esp),%eax
  8030c3:	19 fa                	sbb    %edi,%edx
  8030c5:	89 d1                	mov    %edx,%ecx
  8030c7:	89 c6                	mov    %eax,%esi
  8030c9:	e9 71 ff ff ff       	jmp    80303f <__umoddi3+0xb3>
  8030ce:	66 90                	xchg   %ax,%ax
  8030d0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8030d4:	72 ea                	jb     8030c0 <__umoddi3+0x134>
  8030d6:	89 d9                	mov    %ebx,%ecx
  8030d8:	e9 62 ff ff ff       	jmp    80303f <__umoddi3+0xb3>
