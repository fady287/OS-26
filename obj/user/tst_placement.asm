
obj/user/tst_placement:     file format elf32-i386


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
  800031:	e8 df 05 00 00       	call   800615 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
		} ;

extern volatile bool printStats;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 84 00 00 01    	sub    $0x1000084,%esp
#if USE_KHEAP
	//	cprintf_colored(TEXT_cyan,"envID = %d\n",envID);
	printStats = 0;
  800042:	c7 05 3c 30 80 00 00 	movl   $0x0,0x80303c
  800049:	00 00 00 

	char arr[PAGE_SIZE*1024*4];
	bool found ;
	cprintf_colored(TEXT_cyan,"STEP 0: checking Initial WS entries ...\n");
  80004c:	83 ec 08             	sub    $0x8,%esp
  80004f:	68 00 22 80 00       	push   $0x802200
  800054:	6a 03                	push   $0x3
  800056:	e8 15 0b 00 00       	call   800b70 <cprintf_colored>
  80005b:	83 c4 10             	add    $0x10,%esp
	{
		found = sys_check_WS_list(expectedInitialVAs, 15, 0, 1);
  80005e:	6a 01                	push   $0x1
  800060:	6a 00                	push   $0x0
  800062:	6a 0f                	push   $0xf
  800064:	68 00 30 80 00       	push   $0x803000
  800069:	e8 64 1e 00 00       	call   801ed2 <sys_check_WS_list>
  80006e:	83 c4 10             	add    $0x10,%esp
  800071:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if (found != 1) panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800074:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
  800078:	74 14                	je     80008e <_main+0x56>
  80007a:	83 ec 04             	sub    $0x4,%esp
  80007d:	68 2c 22 80 00       	push   $0x80222c
  800082:	6a 19                	push   $0x19
  800084:	68 7e 22 80 00       	push   $0x80227e
  800089:	e8 e7 07 00 00       	call   800875 <_panic>

		/*NO NEED FOR THIS IF REPL IS "LRU"*/
		if( myEnv->page_last_WS_element !=  NULL)
  80008e:	a1 60 b0 81 00       	mov    0x81b060,%eax
  800093:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
  800099:	85 c0                	test   %eax,%eax
  80009b:	74 14                	je     8000b1 <_main+0x79>
			panic("INITIAL PAGE last WS checking failed! Review size of the WS..!!");
  80009d:	83 ec 04             	sub    $0x4,%esp
  8000a0:	68 94 22 80 00       	push   $0x802294
  8000a5:	6a 1d                	push   $0x1d
  8000a7:	68 7e 22 80 00       	push   $0x80227e
  8000ac:	e8 c4 07 00 00       	call   800875 <_panic>
		/*====================================*/
	}
	int eval = 0;
  8000b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	bool is_correct = 1;
  8000b8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)

	cprintf_colored(TEXT_cyan,"\nSTEP 1: checking USER KERNEL STACK... [20%]\n");
  8000bf:	83 ec 08             	sub    $0x8,%esp
  8000c2:	68 d4 22 80 00       	push   $0x8022d4
  8000c7:	6a 03                	push   $0x3
  8000c9:	e8 a2 0a 00 00       	call   800b70 <cprintf_colored>
  8000ce:	83 c4 10             	add    $0x10,%esp
	{
		uint32 stackIsCorrect;
		sys_utilities("__CheckUserKernStack__", (uint32)(&stackIsCorrect));
  8000d1:	8d 85 d8 ff ff fe    	lea    -0x1000028(%ebp),%eax
  8000d7:	83 ec 08             	sub    $0x8,%esp
  8000da:	50                   	push   %eax
  8000db:	68 02 23 80 00       	push   $0x802302
  8000e0:	e8 2a 1e 00 00       	call   801f0f <sys_utilities>
  8000e5:	83 c4 10             	add    $0x10,%esp
		if (!stackIsCorrect)
  8000e8:	8b 85 d8 ff ff fe    	mov    -0x1000028(%ebp),%eax
  8000ee:	85 c0                	test   %eax,%eax
  8000f0:	75 19                	jne    80010b <_main+0xd3>
		{
			is_correct = 0;
  8000f2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			cprintf_colored(TEXT_TESTERR_CLR,"User Kernel Stack is not set correctly\n");
  8000f9:	83 ec 08             	sub    $0x8,%esp
  8000fc:	68 1c 23 80 00       	push   $0x80231c
  800101:	6a 0c                	push   $0xc
  800103:	e8 68 0a 00 00       	call   800b70 <cprintf_colored>
  800108:	83 c4 10             	add    $0x10,%esp
		}
	}
	if (is_correct) eval += 20;
  80010b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80010f:	74 04                	je     800115 <_main+0xdd>
  800111:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)

	cprintf_colored(TEXT_cyan,"\nSTEP 2: checking PLACEMENT...\n");
  800115:	83 ec 08             	sub    $0x8,%esp
  800118:	68 44 23 80 00       	push   $0x802344
  80011d:	6a 03                	push   $0x3
  80011f:	e8 4c 0a 00 00       	call   800b70 <cprintf_colored>
  800124:	83 c4 10             	add    $0x10,%esp
	{
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800127:	e8 66 1a 00 00       	call   801b92 <sys_pf_calculate_allocated_pages>
  80012c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int freePages = sys_calculate_free_frames();
  80012f:	e8 13 1a 00 00       	call   801b47 <sys_calculate_free_frames>
  800134:	89 45 e0             	mov    %eax,-0x20(%ebp)
		//2 stack pages & page table
		int i=PAGE_SIZE*1024;
  800137:	c7 45 ec 00 00 40 00 	movl   $0x400000,-0x14(%ebp)
		for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  80013e:	eb 11                	jmp    800151 <_main+0x119>
		{
			arr[i] = 1;
  800140:	8d 95 dc ff ff fe    	lea    -0x1000024(%ebp),%edx
  800146:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800149:	01 d0                	add    %edx,%eax
  80014b:	c6 00 01             	movb   $0x1,(%eax)
	{
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
		int freePages = sys_calculate_free_frames();
		//2 stack pages & page table
		int i=PAGE_SIZE*1024;
		for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  80014e:	ff 45 ec             	incl   -0x14(%ebp)
  800151:	81 7d ec 00 10 40 00 	cmpl   $0x401000,-0x14(%ebp)
  800158:	7e e6                	jle    800140 <_main+0x108>
		{
			arr[i] = 1;
		}

		//2 stack pages & page table
		i=PAGE_SIZE*1024*2;
  80015a:	c7 45 ec 00 00 80 00 	movl   $0x800000,-0x14(%ebp)
		for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  800161:	eb 11                	jmp    800174 <_main+0x13c>
		{
			arr[i] = 2;
  800163:	8d 95 dc ff ff fe    	lea    -0x1000024(%ebp),%edx
  800169:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80016c:	01 d0                	add    %edx,%eax
  80016e:	c6 00 02             	movb   $0x2,(%eax)
			arr[i] = 1;
		}

		//2 stack pages & page table
		i=PAGE_SIZE*1024*2;
		for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  800171:	ff 45 ec             	incl   -0x14(%ebp)
  800174:	81 7d ec 00 10 80 00 	cmpl   $0x801000,-0x14(%ebp)
  80017b:	7e e6                	jle    800163 <_main+0x12b>
		{
			arr[i] = 2;
		}

		//2 stack pages & page table
		i=PAGE_SIZE*1024*3;
  80017d:	c7 45 ec 00 00 c0 00 	movl   $0xc00000,-0x14(%ebp)
		for(;i<=(PAGE_SIZE*1024*3 + PAGE_SIZE);i++)
  800184:	eb 11                	jmp    800197 <_main+0x15f>
		{
			arr[i] = 3;
  800186:	8d 95 dc ff ff fe    	lea    -0x1000024(%ebp),%edx
  80018c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018f:	01 d0                	add    %edx,%eax
  800191:	c6 00 03             	movb   $0x3,(%eax)
			arr[i] = 2;
		}

		//2 stack pages & page table
		i=PAGE_SIZE*1024*3;
		for(;i<=(PAGE_SIZE*1024*3 + PAGE_SIZE);i++)
  800194:	ff 45 ec             	incl   -0x14(%ebp)
  800197:	81 7d ec 00 10 c0 00 	cmpl   $0xc01000,-0x14(%ebp)
  80019e:	7e e6                	jle    800186 <_main+0x14e>
		{
			arr[i] = 3;
		}

		is_correct = 1;
  8001a0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
		cprintf_colored(TEXT_cyan,"	STEP A: checking PLACEMENT fault handling... [30%] \n");
  8001a7:	83 ec 08             	sub    $0x8,%esp
  8001aa:	68 64 23 80 00       	push   $0x802364
  8001af:	6a 03                	push   $0x3
  8001b1:	e8 ba 09 00 00       	call   800b70 <cprintf_colored>
  8001b6:	83 c4 10             	add    $0x10,%esp
		{
			if( arr[PAGE_SIZE*1024] !=  1)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  8001b9:	8a 85 dc ff 3f ff    	mov    -0xc00024(%ebp),%al
  8001bf:	3c 01                	cmp    $0x1,%al
  8001c1:	74 19                	je     8001dc <_main+0x1a4>
  8001c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8001ca:	83 ec 08             	sub    $0x8,%esp
  8001cd:	68 9c 23 80 00       	push   $0x80239c
  8001d2:	6a 0c                	push   $0xc
  8001d4:	e8 97 09 00 00       	call   800b70 <cprintf_colored>
  8001d9:	83 c4 10             	add    $0x10,%esp
			if( arr[PAGE_SIZE*1025] !=  1)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  8001dc:	8a 85 dc 0f 40 ff    	mov    -0xbff024(%ebp),%al
  8001e2:	3c 01                	cmp    $0x1,%al
  8001e4:	74 19                	je     8001ff <_main+0x1c7>
  8001e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8001ed:	83 ec 08             	sub    $0x8,%esp
  8001f0:	68 9c 23 80 00       	push   $0x80239c
  8001f5:	6a 0c                	push   $0xc
  8001f7:	e8 74 09 00 00       	call   800b70 <cprintf_colored>
  8001fc:	83 c4 10             	add    $0x10,%esp

			if( arr[PAGE_SIZE*1024*2] !=  2)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  8001ff:	8a 85 dc ff 7f ff    	mov    -0x800024(%ebp),%al
  800205:	3c 02                	cmp    $0x2,%al
  800207:	74 19                	je     800222 <_main+0x1ea>
  800209:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800210:	83 ec 08             	sub    $0x8,%esp
  800213:	68 9c 23 80 00       	push   $0x80239c
  800218:	6a 0c                	push   $0xc
  80021a:	e8 51 09 00 00       	call   800b70 <cprintf_colored>
  80021f:	83 c4 10             	add    $0x10,%esp
			if( arr[PAGE_SIZE*1024*2 + PAGE_SIZE] !=  2)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  800222:	8a 85 dc 0f 80 ff    	mov    -0x7ff024(%ebp),%al
  800228:	3c 02                	cmp    $0x2,%al
  80022a:	74 19                	je     800245 <_main+0x20d>
  80022c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800233:	83 ec 08             	sub    $0x8,%esp
  800236:	68 9c 23 80 00       	push   $0x80239c
  80023b:	6a 0c                	push   $0xc
  80023d:	e8 2e 09 00 00       	call   800b70 <cprintf_colored>
  800242:	83 c4 10             	add    $0x10,%esp

			if( arr[PAGE_SIZE*1024*3] !=  3)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  800245:	8a 85 dc ff bf ff    	mov    -0x400024(%ebp),%al
  80024b:	3c 03                	cmp    $0x3,%al
  80024d:	74 19                	je     800268 <_main+0x230>
  80024f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800256:	83 ec 08             	sub    $0x8,%esp
  800259:	68 9c 23 80 00       	push   $0x80239c
  80025e:	6a 0c                	push   $0xc
  800260:	e8 0b 09 00 00       	call   800b70 <cprintf_colored>
  800265:	83 c4 10             	add    $0x10,%esp
			if( arr[PAGE_SIZE*1024*3 + PAGE_SIZE] !=  3)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  800268:	8a 85 dc 0f c0 ff    	mov    -0x3ff024(%ebp),%al
  80026e:	3c 03                	cmp    $0x3,%al
  800270:	74 19                	je     80028b <_main+0x253>
  800272:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800279:	83 ec 08             	sub    $0x8,%esp
  80027c:	68 9c 23 80 00       	push   $0x80239c
  800281:	6a 0c                	push   $0xc
  800283:	e8 e8 08 00 00       	call   800b70 <cprintf_colored>
  800288:	83 c4 10             	add    $0x10,%esp

			if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) { is_correct = 0; cprintf_colored(TEXT_cyan,"new stack pages should NOT be written to Page File until evicted as victim\n");}
  80028b:	e8 02 19 00 00       	call   801b92 <sys_pf_calculate_allocated_pages>
  800290:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800293:	74 19                	je     8002ae <_main+0x276>
  800295:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80029c:	83 ec 08             	sub    $0x8,%esp
  80029f:	68 bc 23 80 00       	push   $0x8023bc
  8002a4:	6a 03                	push   $0x3
  8002a6:	e8 c5 08 00 00       	call   800b70 <cprintf_colored>
  8002ab:	83 c4 10             	add    $0x10,%esp

			int expected = 6 /*pages*/ + 3 /*tables*/;
  8002ae:	c7 45 dc 09 00 00 00 	movl   $0x9,-0x24(%ebp)
			if( (freePages - sys_calculate_free_frames() ) != expected )
  8002b5:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8002b8:	e8 8a 18 00 00       	call   801b47 <sys_calculate_free_frames>
  8002bd:	29 c3                	sub    %eax,%ebx
  8002bf:	89 da                	mov    %ebx,%edx
  8002c1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002c4:	39 c2                	cmp    %eax,%edx
  8002c6:	74 26                	je     8002ee <_main+0x2b6>
			{ is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"allocated memory size incorrect. Expected Difference = %d, Actual = %d\n", expected, (freePages - sys_calculate_free_frames() ));}
  8002c8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002cf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8002d2:	e8 70 18 00 00       	call   801b47 <sys_calculate_free_frames>
  8002d7:	29 c3                	sub    %eax,%ebx
  8002d9:	89 d8                	mov    %ebx,%eax
  8002db:	50                   	push   %eax
  8002dc:	ff 75 dc             	pushl  -0x24(%ebp)
  8002df:	68 08 24 80 00       	push   $0x802408
  8002e4:	6a 0c                	push   $0xc
  8002e6:	e8 85 08 00 00       	call   800b70 <cprintf_colored>
  8002eb:	83 c4 10             	add    $0x10,%esp
		}
		cprintf_colored(TEXT_cyan,"	STEP A finished: PLACEMENT fault handling !\n\n\n");
  8002ee:	83 ec 08             	sub    $0x8,%esp
  8002f1:	68 50 24 80 00       	push   $0x802450
  8002f6:	6a 03                	push   $0x3
  8002f8:	e8 73 08 00 00       	call   800b70 <cprintf_colored>
  8002fd:	83 c4 10             	add    $0x10,%esp

		if (is_correct)
  800300:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800304:	74 04                	je     80030a <_main+0x2d2>
		{
			eval += 30;
  800306:	83 45 f4 1e          	addl   $0x1e,-0xc(%ebp)
		}
		is_correct = 1;
  80030a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)

		cprintf_colored(TEXT_cyan,"	STEP B: checking WS entries... [30%]\n");
  800311:	83 ec 08             	sub    $0x8,%esp
  800314:	68 80 24 80 00       	push   $0x802480
  800319:	6a 03                	push   $0x3
  80031b:	e8 50 08 00 00       	call   800b70 <cprintf_colored>
  800320:	83 c4 10             	add    $0x10,%esp
		{
			uint32 expectedPages[21] ;
			{
				expectedPages[0] = 0x800000 ;
  800323:	c7 85 80 ff ff fe 00 	movl   $0x800000,-0x1000080(%ebp)
  80032a:	00 80 00 
				expectedPages[1] = 0x801000 ;
  80032d:	c7 85 84 ff ff fe 00 	movl   $0x801000,-0x100007c(%ebp)
  800334:	10 80 00 
				expectedPages[2] = 0x802000 ;
  800337:	c7 85 88 ff ff fe 00 	movl   $0x802000,-0x1000078(%ebp)
  80033e:	20 80 00 
				expectedPages[3] = 0x803000 ;
  800341:	c7 85 8c ff ff fe 00 	movl   $0x803000,-0x1000074(%ebp)
  800348:	30 80 00 
				expectedPages[4] = 0x804000 ;
  80034b:	c7 85 90 ff ff fe 00 	movl   $0x804000,-0x1000070(%ebp)
  800352:	40 80 00 
				expectedPages[5] = 0x805000 ;
  800355:	c7 85 94 ff ff fe 00 	movl   $0x805000,-0x100006c(%ebp)
  80035c:	50 80 00 
				expectedPages[6] = 0x806000 ;
  80035f:	c7 85 98 ff ff fe 00 	movl   $0x806000,-0x1000068(%ebp)
  800366:	60 80 00 
				expectedPages[7] = 0x807000 ;
  800369:	c7 85 9c ff ff fe 00 	movl   $0x807000,-0x1000064(%ebp)
  800370:	70 80 00 
				expectedPages[8] = 0x808000 ;
  800373:	c7 85 a0 ff ff fe 00 	movl   $0x808000,-0x1000060(%ebp)
  80037a:	80 80 00 
				expectedPages[9] = 0x809000 ;
  80037d:	c7 85 a4 ff ff fe 00 	movl   $0x809000,-0x100005c(%ebp)
  800384:	90 80 00 
				expectedPages[10] = 0x80a000 ;
  800387:	c7 85 a8 ff ff fe 00 	movl   $0x80a000,-0x1000058(%ebp)
  80038e:	a0 80 00 
				expectedPages[11] = 0x80b000 ;
  800391:	c7 85 ac ff ff fe 00 	movl   $0x80b000,-0x1000054(%ebp)
  800398:	b0 80 00 
				expectedPages[12] = 0xeebfd000 ;
  80039b:	c7 85 b0 ff ff fe 00 	movl   $0xeebfd000,-0x1000050(%ebp)
  8003a2:	d0 bf ee 
				expectedPages[13] = 0x81b000;
  8003a5:	c7 85 b4 ff ff fe 00 	movl   $0x81b000,-0x100004c(%ebp)
  8003ac:	b0 81 00 
				expectedPages[14] = 0xedbfd000 ;
  8003af:	c7 85 b8 ff ff fe 00 	movl   $0xedbfd000,-0x1000048(%ebp)
  8003b6:	d0 bf ed 
				expectedPages[15] = 0xedffd000 ;
  8003b9:	c7 85 bc ff ff fe 00 	movl   $0xedffd000,-0x1000044(%ebp)
  8003c0:	d0 ff ed 
				expectedPages[16] = 0xedffe000 ;
  8003c3:	c7 85 c0 ff ff fe 00 	movl   $0xedffe000,-0x1000040(%ebp)
  8003ca:	e0 ff ed 
				expectedPages[17] = 0xee3fd000 ;
  8003cd:	c7 85 c4 ff ff fe 00 	movl   $0xee3fd000,-0x100003c(%ebp)
  8003d4:	d0 3f ee 
				expectedPages[18] = 0xee3fe000 ;
  8003d7:	c7 85 c8 ff ff fe 00 	movl   $0xee3fe000,-0x1000038(%ebp)
  8003de:	e0 3f ee 
				expectedPages[19] = 0xee7fd000 ;
  8003e1:	c7 85 cc ff ff fe 00 	movl   $0xee7fd000,-0x1000034(%ebp)
  8003e8:	d0 7f ee 
				expectedPages[20] = 0xee7fe000 ;
  8003eb:	c7 85 d0 ff ff fe 00 	movl   $0xee7fe000,-0x1000030(%ebp)
  8003f2:	e0 7f ee 
			}
			found = sys_check_WS_list(expectedPages, 21, 0, 1);
  8003f5:	6a 01                	push   $0x1
  8003f7:	6a 00                	push   $0x0
  8003f9:	6a 15                	push   $0x15
  8003fb:	8d 85 80 ff ff fe    	lea    -0x1000080(%ebp),%eax
  800401:	50                   	push   %eax
  800402:	e8 cb 1a 00 00       	call   801ed2 <sys_check_WS_list>
  800407:	83 c4 10             	add    $0x10,%esp
  80040a:	89 45 e8             	mov    %eax,-0x18(%ebp)
			if (found != 1)
  80040d:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
  800411:	74 19                	je     80042c <_main+0x3f4>
			{ is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PAGE WS entry checking failed... trace it by printing page WS before & after fault\n");}
  800413:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80041a:	83 ec 08             	sub    $0x8,%esp
  80041d:	68 a8 24 80 00       	push   $0x8024a8
  800422:	6a 0c                	push   $0xc
  800424:	e8 47 07 00 00       	call   800b70 <cprintf_colored>
  800429:	83 c4 10             	add    $0x10,%esp
		}
		cprintf_colored(TEXT_cyan,"	STEP B finished: WS entries test \n\n\n");
  80042c:	83 ec 08             	sub    $0x8,%esp
  80042f:	68 fc 24 80 00       	push   $0x8024fc
  800434:	6a 03                	push   $0x3
  800436:	e8 35 07 00 00       	call   800b70 <cprintf_colored>
  80043b:	83 c4 10             	add    $0x10,%esp
		if (is_correct)
  80043e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800442:	74 04                	je     800448 <_main+0x410>
		{
			eval += 30;
  800444:	83 45 f4 1e          	addl   $0x1e,-0xc(%ebp)
		}
		is_correct = 1;
  800448:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
		cprintf_colored(TEXT_cyan,"	STEP C: checking working sets WHEN BECOMES FULL... [20%]\n");
  80044f:	83 ec 08             	sub    $0x8,%esp
  800452:	68 24 25 80 00       	push   $0x802524
  800457:	6a 03                	push   $0x3
  800459:	e8 12 07 00 00       	call   800b70 <cprintf_colored>
  80045e:	83 c4 10             	add    $0x10,%esp
		{
			/*NO NEED FOR THIS IF REPL IS "LRU"*/
			if(myEnv->page_last_WS_element != NULL)
  800461:	a1 60 b0 81 00       	mov    0x81b060,%eax
  800466:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
  80046c:	85 c0                	test   %eax,%eax
  80046e:	74 19                	je     800489 <_main+0x451>
			{ is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"wrong PAGE WS pointer location... trace it by printing page WS before & after fault\n");}
  800470:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800477:	83 ec 08             	sub    $0x8,%esp
  80047a:	68 60 25 80 00       	push   $0x802560
  80047f:	6a 0c                	push   $0xc
  800481:	e8 ea 06 00 00       	call   800b70 <cprintf_colored>
  800486:	83 c4 10             	add    $0x10,%esp

			//1 stack page
			i=PAGE_SIZE*1024*3 + 2*PAGE_SIZE;
  800489:	c7 45 ec 00 20 c0 00 	movl   $0xc02000,-0x14(%ebp)
			arr[i] = 4;
  800490:	8d 95 dc ff ff fe    	lea    -0x1000024(%ebp),%edx
  800496:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800499:	01 d0                	add    %edx,%eax
  80049b:	c6 00 04             	movb   $0x4,(%eax)

			if( arr[i] != 4)  { is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PLACEMENT of stack page failed\n");}
  80049e:	8d 95 dc ff ff fe    	lea    -0x1000024(%ebp),%edx
  8004a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004a7:	01 d0                	add    %edx,%eax
  8004a9:	8a 00                	mov    (%eax),%al
  8004ab:	3c 04                	cmp    $0x4,%al
  8004ad:	74 19                	je     8004c8 <_main+0x490>
  8004af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004b6:	83 ec 08             	sub    $0x8,%esp
  8004b9:	68 9c 23 80 00       	push   $0x80239c
  8004be:	6a 0c                	push   $0xc
  8004c0:	e8 ab 06 00 00       	call   800b70 <cprintf_colored>
  8004c5:	83 c4 10             	add    $0x10,%esp
			//				0x200000,0x201000,0x202000,0x203000,0x204000,0x205000,0x206000,0x207000,
			//				0x800000,0x801000,0x802000,0x803000,
			//				0xeebfd000,0xedbfd000,0xedbfe000,0xedffd000,0xedffe000,0xee3fd000,0xee3fe000,0xee7fd000};
			uint32 expectedPages[22] ;
			{
				expectedPages[0] = 0x800000 ;
  8004c8:	c7 85 80 ff ff fe 00 	movl   $0x800000,-0x1000080(%ebp)
  8004cf:	00 80 00 
				expectedPages[1] = 0x801000 ;
  8004d2:	c7 85 84 ff ff fe 00 	movl   $0x801000,-0x100007c(%ebp)
  8004d9:	10 80 00 
				expectedPages[2] = 0x802000 ;
  8004dc:	c7 85 88 ff ff fe 00 	movl   $0x802000,-0x1000078(%ebp)
  8004e3:	20 80 00 
				expectedPages[3] = 0x803000 ;
  8004e6:	c7 85 8c ff ff fe 00 	movl   $0x803000,-0x1000074(%ebp)
  8004ed:	30 80 00 
				expectedPages[4] = 0x804000 ;
  8004f0:	c7 85 90 ff ff fe 00 	movl   $0x804000,-0x1000070(%ebp)
  8004f7:	40 80 00 
				expectedPages[5] = 0x805000 ;
  8004fa:	c7 85 94 ff ff fe 00 	movl   $0x805000,-0x100006c(%ebp)
  800501:	50 80 00 
				expectedPages[6] = 0x806000 ;
  800504:	c7 85 98 ff ff fe 00 	movl   $0x806000,-0x1000068(%ebp)
  80050b:	60 80 00 
				expectedPages[7] = 0x807000 ;
  80050e:	c7 85 9c ff ff fe 00 	movl   $0x807000,-0x1000064(%ebp)
  800515:	70 80 00 
				expectedPages[8] = 0x808000 ;
  800518:	c7 85 a0 ff ff fe 00 	movl   $0x808000,-0x1000060(%ebp)
  80051f:	80 80 00 
				expectedPages[9] = 0x809000 ;
  800522:	c7 85 a4 ff ff fe 00 	movl   $0x809000,-0x100005c(%ebp)
  800529:	90 80 00 
				expectedPages[10] = 0x80a000 ;
  80052c:	c7 85 a8 ff ff fe 00 	movl   $0x80a000,-0x1000058(%ebp)
  800533:	a0 80 00 
				expectedPages[11] = 0x80b000 ;
  800536:	c7 85 ac ff ff fe 00 	movl   $0x80b000,-0x1000054(%ebp)
  80053d:	b0 80 00 
				expectedPages[12] = 0xeebfd000 ;
  800540:	c7 85 b0 ff ff fe 00 	movl   $0xeebfd000,-0x1000050(%ebp)
  800547:	d0 bf ee 
				expectedPages[13] = 0x81b000;
  80054a:	c7 85 b4 ff ff fe 00 	movl   $0x81b000,-0x100004c(%ebp)
  800551:	b0 81 00 
				expectedPages[14] = 0xedbfd000 ;
  800554:	c7 85 b8 ff ff fe 00 	movl   $0xedbfd000,-0x1000048(%ebp)
  80055b:	d0 bf ed 
				expectedPages[15] = 0xedffd000 ;
  80055e:	c7 85 bc ff ff fe 00 	movl   $0xedffd000,-0x1000044(%ebp)
  800565:	d0 ff ed 
				expectedPages[16] = 0xedffe000 ;
  800568:	c7 85 c0 ff ff fe 00 	movl   $0xedffe000,-0x1000040(%ebp)
  80056f:	e0 ff ed 
				expectedPages[17] = 0xee3fd000 ;
  800572:	c7 85 c4 ff ff fe 00 	movl   $0xee3fd000,-0x100003c(%ebp)
  800579:	d0 3f ee 
				expectedPages[18] = 0xee3fe000 ;
  80057c:	c7 85 c8 ff ff fe 00 	movl   $0xee3fe000,-0x1000038(%ebp)
  800583:	e0 3f ee 
				expectedPages[19] = 0xee7fd000 ;
  800586:	c7 85 cc ff ff fe 00 	movl   $0xee7fd000,-0x1000034(%ebp)
  80058d:	d0 7f ee 
				expectedPages[20] = 0xee7fe000 ;
  800590:	c7 85 d0 ff ff fe 00 	movl   $0xee7fe000,-0x1000030(%ebp)
  800597:	e0 7f ee 
				expectedPages[21] = 0xee7ff000 ;
  80059a:	c7 85 d4 ff ff fe 00 	movl   $0xee7ff000,-0x100002c(%ebp)
  8005a1:	f0 7f ee 
			}
			found = sys_check_WS_list(expectedPages, 22, 0x800000, 1);
  8005a4:	6a 01                	push   $0x1
  8005a6:	68 00 00 80 00       	push   $0x800000
  8005ab:	6a 16                	push   $0x16
  8005ad:	8d 85 80 ff ff fe    	lea    -0x1000080(%ebp),%eax
  8005b3:	50                   	push   %eax
  8005b4:	e8 19 19 00 00       	call   801ed2 <sys_check_WS_list>
  8005b9:	83 c4 10             	add    $0x10,%esp
  8005bc:	89 45 e8             	mov    %eax,-0x18(%ebp)
			if (found != 1)
  8005bf:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
  8005c3:	74 19                	je     8005de <_main+0x5a6>
			{ is_correct = 0; cprintf_colored(TEXT_TESTERR_CLR,"PAGE WS entry checking failed... trace it by printing page WS before & after fault\n");}
  8005c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005cc:	83 ec 08             	sub    $0x8,%esp
  8005cf:	68 a8 24 80 00       	push   $0x8024a8
  8005d4:	6a 0c                	push   $0xc
  8005d6:	e8 95 05 00 00       	call   800b70 <cprintf_colored>
  8005db:	83 c4 10             	add    $0x10,%esp
		}
		cprintf_colored(TEXT_cyan, "	STEP C finished: WS is FULL now\n\n\n");
  8005de:	83 ec 08             	sub    $0x8,%esp
  8005e1:	68 b8 25 80 00       	push   $0x8025b8
  8005e6:	6a 03                	push   $0x3
  8005e8:	e8 83 05 00 00       	call   800b70 <cprintf_colored>
  8005ed:	83 c4 10             	add    $0x10,%esp
		if (is_correct)
  8005f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8005f4:	74 04                	je     8005fa <_main+0x5c2>
		{
			eval += 20;
  8005f6:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
		}
	}
	cprintf_colored(TEXT_light_green, "%~\nTest of KERNEL STACK & PAGE PLACEMENT completed. Eval = %d%\n\n", eval);
  8005fa:	83 ec 04             	sub    $0x4,%esp
  8005fd:	ff 75 f4             	pushl  -0xc(%ebp)
  800600:	68 dc 25 80 00       	push   $0x8025dc
  800605:	6a 0a                	push   $0xa
  800607:	e8 64 05 00 00       	call   800b70 <cprintf_colored>
  80060c:	83 c4 10             	add    $0x10,%esp

	return;
  80060f:	90                   	nop
#endif
}
  800610:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800613:	c9                   	leave  
  800614:	c3                   	ret    

00800615 <libmain>:
volatile bool printStats = 1;

volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";
void
libmain(int argc, char **argv)
{
  800615:	55                   	push   %ebp
  800616:	89 e5                	mov    %esp,%ebp
  800618:	57                   	push   %edi
  800619:	56                   	push   %esi
  80061a:	53                   	push   %ebx
  80061b:	81 ec ec 00 00 00    	sub    $0xec,%esp
	//printStats = 1;
	int envIndex = sys_getenvindex();
  800621:	e8 e9 16 00 00       	call   801d0f <sys_getenvindex>
  800626:	89 45 e0             	mov    %eax,-0x20(%ebp)

	myEnv = &(envs[envIndex]);
  800629:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80062c:	89 d0                	mov    %edx,%eax
  80062e:	c1 e0 03             	shl    $0x3,%eax
  800631:	01 d0                	add    %edx,%eax
  800633:	c1 e0 06             	shl    $0x6,%eax
  800636:	01 d0                	add    %edx,%eax
  800638:	c1 e0 03             	shl    $0x3,%eax
  80063b:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800640:	a3 60 b0 81 00       	mov    %eax,0x81b060

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800645:	a1 60 b0 81 00       	mov    0x81b060,%eax
  80064a:	8a 40 10             	mov    0x10(%eax),%al
  80064d:	84 c0                	test   %al,%al
  80064f:	74 0d                	je     80065e <libmain+0x49>
		binaryname = myEnv->prog_name;
  800651:	a1 60 b0 81 00       	mov    0x81b060,%eax
  800656:	83 c0 10             	add    $0x10,%eax
  800659:	a3 40 30 80 00       	mov    %eax,0x803040

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80065e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800662:	7e 0a                	jle    80066e <libmain+0x59>
		binaryname = argv[0];
  800664:	8b 45 0c             	mov    0xc(%ebp),%eax
  800667:	8b 00                	mov    (%eax),%eax
  800669:	a3 40 30 80 00       	mov    %eax,0x803040

	// call user main routine
	_main(argc, argv);
  80066e:	83 ec 08             	sub    $0x8,%esp
  800671:	ff 75 0c             	pushl  0xc(%ebp)
  800674:	ff 75 08             	pushl  0x8(%ebp)
  800677:	e8 bc f9 ff ff       	call   800038 <_main>
  80067c:	83 c4 10             	add    $0x10,%esp

	if (printStats)
  80067f:	a1 3c 30 80 00       	mov    0x80303c,%eax
  800684:	85 c0                	test   %eax,%eax
  800686:	0f 84 b7 01 00 00    	je     800843 <libmain+0x22e>
	{
		char isOPTReplCmd[100] = "__IsOPTRepl__" ;
  80068c:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  800692:	bb 5c 27 80 00       	mov    $0x80275c,%ebx
  800697:	ba 0e 00 00 00       	mov    $0xe,%edx
  80069c:	89 c7                	mov    %eax,%edi
  80069e:	89 de                	mov    %ebx,%esi
  8006a0:	89 d1                	mov    %edx,%ecx
  8006a2:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8006a4:	8d 95 1e ff ff ff    	lea    -0xe2(%ebp),%edx
  8006aa:	b9 56 00 00 00       	mov    $0x56,%ecx
  8006af:	b0 00                	mov    $0x0,%al
  8006b1:	89 d7                	mov    %edx,%edi
  8006b3:	f3 aa                	rep stos %al,%es:(%edi)
		int isOPTRepl = 0;
  8006b5:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		sys_utilities(isOPTReplCmd, (uint32)(&isOPTRepl));
  8006bc:	8d 45 d8             	lea    -0x28(%ebp),%eax
  8006bf:	83 ec 08             	sub    $0x8,%esp
  8006c2:	50                   	push   %eax
  8006c3:	8d 85 10 ff ff ff    	lea    -0xf0(%ebp),%eax
  8006c9:	50                   	push   %eax
  8006ca:	e8 40 18 00 00       	call   801f0f <sys_utilities>
  8006cf:	83 c4 10             	add    $0x10,%esp

		sys_lock_cons();
  8006d2:	e8 c0 13 00 00       	call   801a97 <sys_lock_cons>
		{
			cprintf("**************************************\n");
  8006d7:	83 ec 0c             	sub    $0xc,%esp
  8006da:	68 38 26 80 00       	push   $0x802638
  8006df:	e8 5f 04 00 00       	call   800b43 <cprintf>
  8006e4:	83 c4 10             	add    $0x10,%esp
			if (isOPTRepl)
  8006e7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006ea:	85 c0                	test   %eax,%eax
  8006ec:	74 58                	je     800746 <libmain+0x131>
			{
				int optNumOfFaults = sys_get_optimal_num_faults();
  8006ee:	e8 3a 18 00 00       	call   801f2d <sys_get_optimal_num_faults>
  8006f3:	89 45 dc             	mov    %eax,-0x24(%ebp)
				char setOPTFaultsCmd[100] = "__SetOptFaults__" ;
  8006f6:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  8006fc:	bb c0 27 80 00       	mov    $0x8027c0,%ebx
  800701:	ba 11 00 00 00       	mov    $0x11,%edx
  800706:	89 c7                	mov    %eax,%edi
  800708:	89 de                	mov    %ebx,%esi
  80070a:	89 d1                	mov    %edx,%ecx
  80070c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80070e:	8d 55 85             	lea    -0x7b(%ebp),%edx
  800711:	b9 53 00 00 00       	mov    $0x53,%ecx
  800716:	b0 00                	mov    $0x0,%al
  800718:	89 d7                	mov    %edx,%edi
  80071a:	f3 aa                	rep stos %al,%es:(%edi)
				sys_utilities(setOPTFaultsCmd, optNumOfFaults);
  80071c:	83 ec 08             	sub    $0x8,%esp
  80071f:	ff 75 dc             	pushl  -0x24(%ebp)
  800722:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
  800728:	50                   	push   %eax
  800729:	e8 e1 17 00 00       	call   801f0f <sys_utilities>
  80072e:	83 c4 10             	add    $0x10,%esp

				cprintf("OPTIMAL number of page faults = %d\n", optNumOfFaults);
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	ff 75 dc             	pushl  -0x24(%ebp)
  800737:	68 60 26 80 00       	push   $0x802660
  80073c:	e8 02 04 00 00       	call   800b43 <cprintf>
  800741:	83 c4 10             	add    $0x10,%esp
  800744:	eb 59                	jmp    80079f <libmain+0x18a>
			}
			else
			{
				cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800746:	a1 60 b0 81 00       	mov    0x81b060,%eax
  80074b:	8b 90 00 12 00 00    	mov    0x1200(%eax),%edx
  800751:	a1 60 b0 81 00       	mov    0x81b060,%eax
  800756:	8b 80 e4 11 00 00    	mov    0x11e4(%eax),%eax
  80075c:	83 ec 04             	sub    $0x4,%esp
  80075f:	52                   	push   %edx
  800760:	50                   	push   %eax
  800761:	68 84 26 80 00       	push   $0x802684
  800766:	e8 d8 03 00 00       	call   800b43 <cprintf>
  80076b:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
  80076e:	a1 60 b0 81 00       	mov    0x81b060,%eax
  800773:	8b 88 f0 11 00 00    	mov    0x11f0(%eax),%ecx
  800779:	a1 60 b0 81 00       	mov    0x81b060,%eax
  80077e:	8b 90 ec 11 00 00    	mov    0x11ec(%eax),%edx
  800784:	a1 60 b0 81 00       	mov    0x81b060,%eax
  800789:	8b 80 e8 11 00 00    	mov    0x11e8(%eax),%eax
  80078f:	51                   	push   %ecx
  800790:	52                   	push   %edx
  800791:	50                   	push   %eax
  800792:	68 ac 26 80 00       	push   $0x8026ac
  800797:	e8 a7 03 00 00       	call   800b43 <cprintf>
  80079c:	83 c4 10             	add    $0x10,%esp
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80079f:	a1 60 b0 81 00       	mov    0x81b060,%eax
  8007a4:	8b 80 cc 11 00 00    	mov    0x11cc(%eax),%eax
  8007aa:	83 ec 08             	sub    $0x8,%esp
  8007ad:	50                   	push   %eax
  8007ae:	68 04 27 80 00       	push   $0x802704
  8007b3:	e8 8b 03 00 00       	call   800b43 <cprintf>
  8007b8:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of schedules/CPU: ");
  8007bb:	83 ec 0c             	sub    $0xc,%esp
  8007be:	68 18 27 80 00       	push   $0x802718
  8007c3:	e8 7b 03 00 00       	call   800b43 <cprintf>
  8007c8:	83 c4 10             	add    $0x10,%esp
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007cb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8007d2:	eb 28                	jmp    8007fc <libmain+0x1e7>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
  8007d4:	a1 60 b0 81 00       	mov    0x81b060,%eax
  8007d9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8007dc:	81 c2 74 04 00 00    	add    $0x474,%edx
  8007e2:	8b 04 90             	mov    (%eax,%edx,4),%eax
  8007e5:	83 ec 04             	sub    $0x4,%esp
  8007e8:	50                   	push   %eax
  8007e9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007ec:	68 2f 27 80 00       	push   $0x80272f
  8007f1:	e8 4d 03 00 00       	call   800b43 <cprintf>
  8007f6:	83 c4 10             	add    $0x10,%esp
				cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut,myEnv->nNewPageAdded);
			}
			//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
			cprintf("Num of clocks = %d\n", myEnv->nClocks);
			cprintf("Num of schedules/CPU: ");
			for (int cp = 0; cp < NCPUS; ++cp) {
  8007f9:	ff 45 e4             	incl   -0x1c(%ebp)
  8007fc:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800800:	7e d2                	jle    8007d4 <libmain+0x1bf>
				cprintf("%~CPU[%d]: %d ", cp, myEnv->nSchedPerCPU[cp]);
			}
			cprintf("%~\n");
  800802:	83 ec 0c             	sub    $0xc,%esp
  800805:	68 3e 27 80 00       	push   $0x80273e
  80080a:	e8 34 03 00 00       	call   800b43 <cprintf>
  80080f:	83 c4 10             	add    $0x10,%esp
			cprintf("Num of system calls = %d\n", myEnv->nSysCalls);
  800812:	a1 60 b0 81 00       	mov    0x81b060,%eax
  800817:	8b 80 e0 11 00 00    	mov    0x11e0(%eax),%eax
  80081d:	83 ec 08             	sub    $0x8,%esp
  800820:	50                   	push   %eax
  800821:	68 42 27 80 00       	push   $0x802742
  800826:	e8 18 03 00 00       	call   800b43 <cprintf>
  80082b:	83 c4 10             	add    $0x10,%esp
			cprintf("**************************************\n");
  80082e:	83 ec 0c             	sub    $0xc,%esp
  800831:	68 38 26 80 00       	push   $0x802638
  800836:	e8 08 03 00 00       	call   800b43 <cprintf>
  80083b:	83 c4 10             	add    $0x10,%esp
		}
		sys_unlock_cons();
  80083e:	e8 6e 12 00 00       	call   801ab1 <sys_unlock_cons>
	}

	// exit gracefully
	exit();
  800843:	e8 1f 00 00 00       	call   800867 <exit>
}
  800848:	90                   	nop
  800849:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80084c:	5b                   	pop    %ebx
  80084d:	5e                   	pop    %esi
  80084e:	5f                   	pop    %edi
  80084f:	5d                   	pop    %ebp
  800850:	c3                   	ret    

00800851 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800851:	55                   	push   %ebp
  800852:	89 e5                	mov    %esp,%ebp
  800854:	83 ec 08             	sub    $0x8,%esp
	sys_destroy_env(0);
  800857:	83 ec 0c             	sub    $0xc,%esp
  80085a:	6a 00                	push   $0x0
  80085c:	e8 7a 14 00 00       	call   801cdb <sys_destroy_env>
  800861:	83 c4 10             	add    $0x10,%esp
}
  800864:	90                   	nop
  800865:	c9                   	leave  
  800866:	c3                   	ret    

00800867 <exit>:

void
exit(void)
{
  800867:	55                   	push   %ebp
  800868:	89 e5                	mov    %esp,%ebp
  80086a:	83 ec 08             	sub    $0x8,%esp
	sys_exit_env();
  80086d:	e8 cf 14 00 00       	call   801d41 <sys_exit_env>
}
  800872:	90                   	nop
  800873:	c9                   	leave  
  800874:	c3                   	ret    

00800875 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800875:	55                   	push   %ebp
  800876:	89 e5                	mov    %esp,%ebp
  800878:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80087b:	8d 45 10             	lea    0x10(%ebp),%eax
  80087e:	83 c0 04             	add    $0x4,%eax
  800881:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800884:	a1 68 b1 81 00       	mov    0x81b168,%eax
  800889:	85 c0                	test   %eax,%eax
  80088b:	74 16                	je     8008a3 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80088d:	a1 68 b1 81 00       	mov    0x81b168,%eax
  800892:	83 ec 08             	sub    $0x8,%esp
  800895:	50                   	push   %eax
  800896:	68 24 28 80 00       	push   $0x802824
  80089b:	e8 a3 02 00 00       	call   800b43 <cprintf>
  8008a0:	83 c4 10             	add    $0x10,%esp
	cprintf_colored(TEXT_PANIC_CLR, "user [EVAL_FINAL]panic in %s at %s:%d: ", binaryname, file, line);
  8008a3:	a1 40 30 80 00       	mov    0x803040,%eax
  8008a8:	83 ec 0c             	sub    $0xc,%esp
  8008ab:	ff 75 0c             	pushl  0xc(%ebp)
  8008ae:	ff 75 08             	pushl  0x8(%ebp)
  8008b1:	50                   	push   %eax
  8008b2:	68 2c 28 80 00       	push   $0x80282c
  8008b7:	6a 74                	push   $0x74
  8008b9:	e8 b2 02 00 00       	call   800b70 <cprintf_colored>
  8008be:	83 c4 20             	add    $0x20,%esp
	vcprintf(fmt, ap);
  8008c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c4:	83 ec 08             	sub    $0x8,%esp
  8008c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ca:	50                   	push   %eax
  8008cb:	e8 04 02 00 00       	call   800ad4 <vcprintf>
  8008d0:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8008d3:	83 ec 08             	sub    $0x8,%esp
  8008d6:	6a 00                	push   $0x0
  8008d8:	68 54 28 80 00       	push   $0x802854
  8008dd:	e8 f2 01 00 00       	call   800ad4 <vcprintf>
  8008e2:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8008e5:	e8 7d ff ff ff       	call   800867 <exit>

	// should not return here
	while (1) ;
  8008ea:	eb fe                	jmp    8008ea <_panic+0x75>

008008ec <CheckWSArrayWithoutLastIndex>:
}

void CheckWSArrayWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008ec:	55                   	push   %ebp
  8008ed:	89 e5                	mov    %esp,%ebp
  8008ef:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008f2:	a1 60 b0 81 00       	mov    0x81b060,%eax
  8008f7:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8008fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800900:	39 c2                	cmp    %eax,%edx
  800902:	74 14                	je     800918 <CheckWSArrayWithoutLastIndex+0x2c>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800904:	83 ec 04             	sub    $0x4,%esp
  800907:	68 58 28 80 00       	push   $0x802858
  80090c:	6a 26                	push   $0x26
  80090e:	68 a4 28 80 00       	push   $0x8028a4
  800913:	e8 5d ff ff ff       	call   800875 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800918:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80091f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800926:	e9 c5 00 00 00       	jmp    8009f0 <CheckWSArrayWithoutLastIndex+0x104>
		if (expectedPages[e] == 0) {
  80092b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80092e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800935:	8b 45 08             	mov    0x8(%ebp),%eax
  800938:	01 d0                	add    %edx,%eax
  80093a:	8b 00                	mov    (%eax),%eax
  80093c:	85 c0                	test   %eax,%eax
  80093e:	75 08                	jne    800948 <CheckWSArrayWithoutLastIndex+0x5c>
			expectedNumOfEmptyLocs++;
  800940:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800943:	e9 a5 00 00 00       	jmp    8009ed <CheckWSArrayWithoutLastIndex+0x101>
		}
		int found = 0;
  800948:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80094f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800956:	eb 69                	jmp    8009c1 <CheckWSArrayWithoutLastIndex+0xd5>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800958:	a1 60 b0 81 00       	mov    0x81b060,%eax
  80095d:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800963:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800966:	89 d0                	mov    %edx,%eax
  800968:	01 c0                	add    %eax,%eax
  80096a:	01 d0                	add    %edx,%eax
  80096c:	c1 e0 03             	shl    $0x3,%eax
  80096f:	01 c8                	add    %ecx,%eax
  800971:	8a 40 04             	mov    0x4(%eax),%al
  800974:	84 c0                	test   %al,%al
  800976:	75 46                	jne    8009be <CheckWSArrayWithoutLastIndex+0xd2>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800978:	a1 60 b0 81 00       	mov    0x81b060,%eax
  80097d:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800983:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800986:	89 d0                	mov    %edx,%eax
  800988:	01 c0                	add    %eax,%eax
  80098a:	01 d0                	add    %edx,%eax
  80098c:	c1 e0 03             	shl    $0x3,%eax
  80098f:	01 c8                	add    %ecx,%eax
  800991:	8b 00                	mov    (%eax),%eax
  800993:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800996:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800999:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80099e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009a3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ad:	01 c8                	add    %ecx,%eax
  8009af:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009b1:	39 c2                	cmp    %eax,%edx
  8009b3:	75 09                	jne    8009be <CheckWSArrayWithoutLastIndex+0xd2>
						== expectedPages[e]) {
					found = 1;
  8009b5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8009bc:	eb 15                	jmp    8009d3 <CheckWSArrayWithoutLastIndex+0xe7>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009be:	ff 45 e8             	incl   -0x18(%ebp)
  8009c1:	a1 60 b0 81 00       	mov    0x81b060,%eax
  8009c6:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  8009cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8009cf:	39 c2                	cmp    %eax,%edx
  8009d1:	77 85                	ja     800958 <CheckWSArrayWithoutLastIndex+0x6c>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8009d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8009d7:	75 14                	jne    8009ed <CheckWSArrayWithoutLastIndex+0x101>
			panic(
  8009d9:	83 ec 04             	sub    $0x4,%esp
  8009dc:	68 b0 28 80 00       	push   $0x8028b0
  8009e1:	6a 3a                	push   $0x3a
  8009e3:	68 a4 28 80 00       	push   $0x8028a4
  8009e8:	e8 88 fe ff ff       	call   800875 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009ed:	ff 45 f0             	incl   -0x10(%ebp)
  8009f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009f6:	0f 8c 2f ff ff ff    	jl     80092b <CheckWSArrayWithoutLastIndex+0x3f>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009fc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a03:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a0a:	eb 26                	jmp    800a32 <CheckWSArrayWithoutLastIndex+0x146>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a0c:	a1 60 b0 81 00       	mov    0x81b060,%eax
  800a11:	8b 88 7c 05 00 00    	mov    0x57c(%eax),%ecx
  800a17:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a1a:	89 d0                	mov    %edx,%eax
  800a1c:	01 c0                	add    %eax,%eax
  800a1e:	01 d0                	add    %edx,%eax
  800a20:	c1 e0 03             	shl    $0x3,%eax
  800a23:	01 c8                	add    %ecx,%eax
  800a25:	8a 40 04             	mov    0x4(%eax),%al
  800a28:	3c 01                	cmp    $0x1,%al
  800a2a:	75 03                	jne    800a2f <CheckWSArrayWithoutLastIndex+0x143>
			actualNumOfEmptyLocs++;
  800a2c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a2f:	ff 45 e0             	incl   -0x20(%ebp)
  800a32:	a1 60 b0 81 00       	mov    0x81b060,%eax
  800a37:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
  800a3d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a40:	39 c2                	cmp    %eax,%edx
  800a42:	77 c8                	ja     800a0c <CheckWSArrayWithoutLastIndex+0x120>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a47:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a4a:	74 14                	je     800a60 <CheckWSArrayWithoutLastIndex+0x174>
		panic(
  800a4c:	83 ec 04             	sub    $0x4,%esp
  800a4f:	68 04 29 80 00       	push   $0x802904
  800a54:	6a 44                	push   $0x44
  800a56:	68 a4 28 80 00       	push   $0x8028a4
  800a5b:	e8 15 fe ff ff       	call   800875 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a60:	90                   	nop
  800a61:	c9                   	leave  
  800a62:	c3                   	ret    

00800a63 <putch>:
	int idx; // current buffer index
	int cnt; // total bytes printed so far
	char buf[256];
};

static void putch(int ch, struct printbuf *b) {
  800a63:	55                   	push   %ebp
  800a64:	89 e5                	mov    %esp,%ebp
  800a66:	53                   	push   %ebx
  800a67:	83 ec 04             	sub    $0x4,%esp
	b->buf[b->idx++] = ch;
  800a6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6d:	8b 00                	mov    (%eax),%eax
  800a6f:	8d 48 01             	lea    0x1(%eax),%ecx
  800a72:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a75:	89 0a                	mov    %ecx,(%edx)
  800a77:	8b 55 08             	mov    0x8(%ebp),%edx
  800a7a:	88 d1                	mov    %dl,%cl
  800a7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a7f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a86:	8b 00                	mov    (%eax),%eax
  800a88:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a8d:	75 30                	jne    800abf <putch+0x5c>
		sys_cputs(b->buf, b->idx, printProgName, curTextClr);
  800a8f:	8b 15 6c b1 81 00    	mov    0x81b16c,%edx
  800a95:	a0 80 b0 81 00       	mov    0x81b080,%al
  800a9a:	0f b6 c0             	movzbl %al,%eax
  800a9d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800aa0:	8b 09                	mov    (%ecx),%ecx
  800aa2:	89 cb                	mov    %ecx,%ebx
  800aa4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800aa7:	83 c1 08             	add    $0x8,%ecx
  800aaa:	52                   	push   %edx
  800aab:	50                   	push   %eax
  800aac:	53                   	push   %ebx
  800aad:	51                   	push   %ecx
  800aae:	e8 a0 0f 00 00       	call   801a53 <sys_cputs>
  800ab3:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800ab6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800abf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac2:	8b 40 04             	mov    0x4(%eax),%eax
  800ac5:	8d 50 01             	lea    0x1(%eax),%edx
  800ac8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acb:	89 50 04             	mov    %edx,0x4(%eax)
}
  800ace:	90                   	nop
  800acf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ad2:	c9                   	leave  
  800ad3:	c3                   	ret    

00800ad4 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ad4:	55                   	push   %ebp
  800ad5:	89 e5                	mov    %esp,%ebp
  800ad7:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800add:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ae4:	00 00 00 
	b.cnt = 0;
  800ae7:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800aee:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800af1:	ff 75 0c             	pushl  0xc(%ebp)
  800af4:	ff 75 08             	pushl  0x8(%ebp)
  800af7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800afd:	50                   	push   %eax
  800afe:	68 63 0a 80 00       	push   $0x800a63
  800b03:	e8 5a 02 00 00       	call   800d62 <vprintfmt>
  800b08:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName, curTextClr);
  800b0b:	8b 15 6c b1 81 00    	mov    0x81b16c,%edx
  800b11:	a0 80 b0 81 00       	mov    0x81b080,%al
  800b16:	0f b6 c0             	movzbl %al,%eax
  800b19:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  800b1f:	52                   	push   %edx
  800b20:	50                   	push   %eax
  800b21:	51                   	push   %ecx
  800b22:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b28:	83 c0 08             	add    $0x8,%eax
  800b2b:	50                   	push   %eax
  800b2c:	e8 22 0f 00 00       	call   801a53 <sys_cputs>
  800b31:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b34:	c6 05 80 b0 81 00 00 	movb   $0x0,0x81b080
	return b.cnt;
  800b3b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b41:	c9                   	leave  
  800b42:	c3                   	ret    

00800b43 <cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf(const char *fmt, ...) {
  800b43:	55                   	push   %ebp
  800b44:	89 e5                	mov    %esp,%ebp
  800b46:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b49:	c6 05 80 b0 81 00 01 	movb   $0x1,0x81b080
	va_start(ap, fmt);
  800b50:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b53:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b56:	8b 45 08             	mov    0x8(%ebp),%eax
  800b59:	83 ec 08             	sub    $0x8,%esp
  800b5c:	ff 75 f4             	pushl  -0xc(%ebp)
  800b5f:	50                   	push   %eax
  800b60:	e8 6f ff ff ff       	call   800ad4 <vcprintf>
  800b65:	83 c4 10             	add    $0x10,%esp
  800b68:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b6e:	c9                   	leave  
  800b6f:	c3                   	ret    

00800b70 <cprintf_colored>:

// *************** This text coloring feature is implemented by *************
// ********** Abd-Alrahman Zedan From Team Frozen-Bytes - FCIS'24-25 ********
//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int cprintf_colored(int textClr, const char *fmt, ...) {
  800b70:	55                   	push   %ebp
  800b71:	89 e5                	mov    %esp,%ebp
  800b73:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b76:	c6 05 80 b0 81 00 01 	movb   $0x1,0x81b080
	curTextClr = (textClr << 8) ; //set text color by the given value
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	c1 e0 08             	shl    $0x8,%eax
  800b83:	a3 6c b1 81 00       	mov    %eax,0x81b16c
	va_start(ap, fmt);
  800b88:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b8b:	83 c0 04             	add    $0x4,%eax
  800b8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b94:	83 ec 08             	sub    $0x8,%esp
  800b97:	ff 75 f4             	pushl  -0xc(%ebp)
  800b9a:	50                   	push   %eax
  800b9b:	e8 34 ff ff ff       	call   800ad4 <vcprintf>
  800ba0:	83 c4 10             	add    $0x10,%esp
  800ba3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);
	curTextClr = TEXT_DEFAULT_CLR; //restore default color
  800ba6:	c7 05 6c b1 81 00 00 	movl   $0x700,0x81b16c
  800bad:	07 00 00 

	return cnt;
  800bb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bb3:	c9                   	leave  
  800bb4:	c3                   	ret    

00800bb5 <atomic_cprintf>:

//%@: to print the program name, ID & current CPU before the message
//%~: to print the message directly
int atomic_cprintf(const char *fmt, ...)
{
  800bb5:	55                   	push   %ebp
  800bb6:	89 e5                	mov    %esp,%ebp
  800bb8:	83 ec 18             	sub    $0x18,%esp
	int cnt;
	sys_lock_cons();
  800bbb:	e8 d7 0e 00 00       	call   801a97 <sys_lock_cons>
	{
		va_list ap;
		va_start(ap, fmt);
  800bc0:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		cnt = vcprintf(fmt, ap);
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	83 ec 08             	sub    $0x8,%esp
  800bcc:	ff 75 f4             	pushl  -0xc(%ebp)
  800bcf:	50                   	push   %eax
  800bd0:	e8 ff fe ff ff       	call   800ad4 <vcprintf>
  800bd5:	83 c4 10             	add    $0x10,%esp
  800bd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		va_end(ap);
	}
	sys_unlock_cons();
  800bdb:	e8 d1 0e 00 00       	call   801ab1 <sys_unlock_cons>
	return cnt;
  800be0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800be3:	c9                   	leave  
  800be4:	c3                   	ret    

00800be5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800be5:	55                   	push   %ebp
  800be6:	89 e5                	mov    %esp,%ebp
  800be8:	53                   	push   %ebx
  800be9:	83 ec 14             	sub    $0x14,%esp
  800bec:	8b 45 10             	mov    0x10(%ebp),%eax
  800bef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf2:	8b 45 14             	mov    0x14(%ebp),%eax
  800bf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bf8:	8b 45 18             	mov    0x18(%ebp),%eax
  800bfb:	ba 00 00 00 00       	mov    $0x0,%edx
  800c00:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c03:	77 55                	ja     800c5a <printnum+0x75>
  800c05:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c08:	72 05                	jb     800c0f <printnum+0x2a>
  800c0a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c0d:	77 4b                	ja     800c5a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c0f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c12:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c15:	8b 45 18             	mov    0x18(%ebp),%eax
  800c18:	ba 00 00 00 00       	mov    $0x0,%edx
  800c1d:	52                   	push   %edx
  800c1e:	50                   	push   %eax
  800c1f:	ff 75 f4             	pushl  -0xc(%ebp)
  800c22:	ff 75 f0             	pushl  -0x10(%ebp)
  800c25:	e8 72 13 00 00       	call   801f9c <__udivdi3>
  800c2a:	83 c4 10             	add    $0x10,%esp
  800c2d:	83 ec 04             	sub    $0x4,%esp
  800c30:	ff 75 20             	pushl  0x20(%ebp)
  800c33:	53                   	push   %ebx
  800c34:	ff 75 18             	pushl  0x18(%ebp)
  800c37:	52                   	push   %edx
  800c38:	50                   	push   %eax
  800c39:	ff 75 0c             	pushl  0xc(%ebp)
  800c3c:	ff 75 08             	pushl  0x8(%ebp)
  800c3f:	e8 a1 ff ff ff       	call   800be5 <printnum>
  800c44:	83 c4 20             	add    $0x20,%esp
  800c47:	eb 1a                	jmp    800c63 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c49:	83 ec 08             	sub    $0x8,%esp
  800c4c:	ff 75 0c             	pushl  0xc(%ebp)
  800c4f:	ff 75 20             	pushl  0x20(%ebp)
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	ff d0                	call   *%eax
  800c57:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c5a:	ff 4d 1c             	decl   0x1c(%ebp)
  800c5d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c61:	7f e6                	jg     800c49 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c63:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c66:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c71:	53                   	push   %ebx
  800c72:	51                   	push   %ecx
  800c73:	52                   	push   %edx
  800c74:	50                   	push   %eax
  800c75:	e8 32 14 00 00       	call   8020ac <__umoddi3>
  800c7a:	83 c4 10             	add    $0x10,%esp
  800c7d:	05 74 2b 80 00       	add    $0x802b74,%eax
  800c82:	8a 00                	mov    (%eax),%al
  800c84:	0f be c0             	movsbl %al,%eax
  800c87:	83 ec 08             	sub    $0x8,%esp
  800c8a:	ff 75 0c             	pushl  0xc(%ebp)
  800c8d:	50                   	push   %eax
  800c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c91:	ff d0                	call   *%eax
  800c93:	83 c4 10             	add    $0x10,%esp
}
  800c96:	90                   	nop
  800c97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c9a:	c9                   	leave  
  800c9b:	c3                   	ret    

00800c9c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c9c:	55                   	push   %ebp
  800c9d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c9f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ca3:	7e 1c                	jle    800cc1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca8:	8b 00                	mov    (%eax),%eax
  800caa:	8d 50 08             	lea    0x8(%eax),%edx
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	89 10                	mov    %edx,(%eax)
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	8b 00                	mov    (%eax),%eax
  800cb7:	83 e8 08             	sub    $0x8,%eax
  800cba:	8b 50 04             	mov    0x4(%eax),%edx
  800cbd:	8b 00                	mov    (%eax),%eax
  800cbf:	eb 40                	jmp    800d01 <getuint+0x65>
	else if (lflag)
  800cc1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cc5:	74 1e                	je     800ce5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cca:	8b 00                	mov    (%eax),%eax
  800ccc:	8d 50 04             	lea    0x4(%eax),%edx
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	89 10                	mov    %edx,(%eax)
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8b 00                	mov    (%eax),%eax
  800cd9:	83 e8 04             	sub    $0x4,%eax
  800cdc:	8b 00                	mov    (%eax),%eax
  800cde:	ba 00 00 00 00       	mov    $0x0,%edx
  800ce3:	eb 1c                	jmp    800d01 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8b 00                	mov    (%eax),%eax
  800cea:	8d 50 04             	lea    0x4(%eax),%edx
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	89 10                	mov    %edx,(%eax)
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	8b 00                	mov    (%eax),%eax
  800cf7:	83 e8 04             	sub    $0x4,%eax
  800cfa:	8b 00                	mov    (%eax),%eax
  800cfc:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d01:	5d                   	pop    %ebp
  800d02:	c3                   	ret    

00800d03 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d03:	55                   	push   %ebp
  800d04:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d06:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d0a:	7e 1c                	jle    800d28 <getint+0x25>
		return va_arg(*ap, long long);
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	8b 00                	mov    (%eax),%eax
  800d11:	8d 50 08             	lea    0x8(%eax),%edx
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	89 10                	mov    %edx,(%eax)
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8b 00                	mov    (%eax),%eax
  800d1e:	83 e8 08             	sub    $0x8,%eax
  800d21:	8b 50 04             	mov    0x4(%eax),%edx
  800d24:	8b 00                	mov    (%eax),%eax
  800d26:	eb 38                	jmp    800d60 <getint+0x5d>
	else if (lflag)
  800d28:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d2c:	74 1a                	je     800d48 <getint+0x45>
		return va_arg(*ap, long);
  800d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d31:	8b 00                	mov    (%eax),%eax
  800d33:	8d 50 04             	lea    0x4(%eax),%edx
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	89 10                	mov    %edx,(%eax)
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8b 00                	mov    (%eax),%eax
  800d40:	83 e8 04             	sub    $0x4,%eax
  800d43:	8b 00                	mov    (%eax),%eax
  800d45:	99                   	cltd   
  800d46:	eb 18                	jmp    800d60 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8b 00                	mov    (%eax),%eax
  800d4d:	8d 50 04             	lea    0x4(%eax),%edx
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	89 10                	mov    %edx,(%eax)
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8b 00                	mov    (%eax),%eax
  800d5a:	83 e8 04             	sub    $0x4,%eax
  800d5d:	8b 00                	mov    (%eax),%eax
  800d5f:	99                   	cltd   
}
  800d60:	5d                   	pop    %ebp
  800d61:	c3                   	ret    

00800d62 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d62:	55                   	push   %ebp
  800d63:	89 e5                	mov    %esp,%ebp
  800d65:	56                   	push   %esi
  800d66:	53                   	push   %ebx
  800d67:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d6a:	eb 17                	jmp    800d83 <vprintfmt+0x21>
			if (ch == '\0')
  800d6c:	85 db                	test   %ebx,%ebx
  800d6e:	0f 84 c1 03 00 00    	je     801135 <vprintfmt+0x3d3>
				return;
			putch(ch, putdat);
  800d74:	83 ec 08             	sub    $0x8,%esp
  800d77:	ff 75 0c             	pushl  0xc(%ebp)
  800d7a:	53                   	push   %ebx
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7e:	ff d0                	call   *%eax
  800d80:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d83:	8b 45 10             	mov    0x10(%ebp),%eax
  800d86:	8d 50 01             	lea    0x1(%eax),%edx
  800d89:	89 55 10             	mov    %edx,0x10(%ebp)
  800d8c:	8a 00                	mov    (%eax),%al
  800d8e:	0f b6 d8             	movzbl %al,%ebx
  800d91:	83 fb 25             	cmp    $0x25,%ebx
  800d94:	75 d6                	jne    800d6c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d96:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d9a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800da1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800da8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800daf:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800db6:	8b 45 10             	mov    0x10(%ebp),%eax
  800db9:	8d 50 01             	lea    0x1(%eax),%edx
  800dbc:	89 55 10             	mov    %edx,0x10(%ebp)
  800dbf:	8a 00                	mov    (%eax),%al
  800dc1:	0f b6 d8             	movzbl %al,%ebx
  800dc4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dc7:	83 f8 5b             	cmp    $0x5b,%eax
  800dca:	0f 87 3d 03 00 00    	ja     80110d <vprintfmt+0x3ab>
  800dd0:	8b 04 85 98 2b 80 00 	mov    0x802b98(,%eax,4),%eax
  800dd7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dd9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ddd:	eb d7                	jmp    800db6 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ddf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800de3:	eb d1                	jmp    800db6 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800de5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800dec:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800def:	89 d0                	mov    %edx,%eax
  800df1:	c1 e0 02             	shl    $0x2,%eax
  800df4:	01 d0                	add    %edx,%eax
  800df6:	01 c0                	add    %eax,%eax
  800df8:	01 d8                	add    %ebx,%eax
  800dfa:	83 e8 30             	sub    $0x30,%eax
  800dfd:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e00:	8b 45 10             	mov    0x10(%ebp),%eax
  800e03:	8a 00                	mov    (%eax),%al
  800e05:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e08:	83 fb 2f             	cmp    $0x2f,%ebx
  800e0b:	7e 3e                	jle    800e4b <vprintfmt+0xe9>
  800e0d:	83 fb 39             	cmp    $0x39,%ebx
  800e10:	7f 39                	jg     800e4b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e12:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e15:	eb d5                	jmp    800dec <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e17:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1a:	83 c0 04             	add    $0x4,%eax
  800e1d:	89 45 14             	mov    %eax,0x14(%ebp)
  800e20:	8b 45 14             	mov    0x14(%ebp),%eax
  800e23:	83 e8 04             	sub    $0x4,%eax
  800e26:	8b 00                	mov    (%eax),%eax
  800e28:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e2b:	eb 1f                	jmp    800e4c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e2d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e31:	79 83                	jns    800db6 <vprintfmt+0x54>
				width = 0;
  800e33:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e3a:	e9 77 ff ff ff       	jmp    800db6 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e3f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e46:	e9 6b ff ff ff       	jmp    800db6 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e4b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e4c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e50:	0f 89 60 ff ff ff    	jns    800db6 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e56:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e59:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e5c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e63:	e9 4e ff ff ff       	jmp    800db6 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e68:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e6b:	e9 46 ff ff ff       	jmp    800db6 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e70:	8b 45 14             	mov    0x14(%ebp),%eax
  800e73:	83 c0 04             	add    $0x4,%eax
  800e76:	89 45 14             	mov    %eax,0x14(%ebp)
  800e79:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7c:	83 e8 04             	sub    $0x4,%eax
  800e7f:	8b 00                	mov    (%eax),%eax
  800e81:	83 ec 08             	sub    $0x8,%esp
  800e84:	ff 75 0c             	pushl  0xc(%ebp)
  800e87:	50                   	push   %eax
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	ff d0                	call   *%eax
  800e8d:	83 c4 10             	add    $0x10,%esp
			break;
  800e90:	e9 9b 02 00 00       	jmp    801130 <vprintfmt+0x3ce>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e95:	8b 45 14             	mov    0x14(%ebp),%eax
  800e98:	83 c0 04             	add    $0x4,%eax
  800e9b:	89 45 14             	mov    %eax,0x14(%ebp)
  800e9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea1:	83 e8 04             	sub    $0x4,%eax
  800ea4:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ea6:	85 db                	test   %ebx,%ebx
  800ea8:	79 02                	jns    800eac <vprintfmt+0x14a>
				err = -err;
  800eaa:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800eac:	83 fb 64             	cmp    $0x64,%ebx
  800eaf:	7f 0b                	jg     800ebc <vprintfmt+0x15a>
  800eb1:	8b 34 9d e0 29 80 00 	mov    0x8029e0(,%ebx,4),%esi
  800eb8:	85 f6                	test   %esi,%esi
  800eba:	75 19                	jne    800ed5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ebc:	53                   	push   %ebx
  800ebd:	68 85 2b 80 00       	push   $0x802b85
  800ec2:	ff 75 0c             	pushl  0xc(%ebp)
  800ec5:	ff 75 08             	pushl  0x8(%ebp)
  800ec8:	e8 70 02 00 00       	call   80113d <printfmt>
  800ecd:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ed0:	e9 5b 02 00 00       	jmp    801130 <vprintfmt+0x3ce>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ed5:	56                   	push   %esi
  800ed6:	68 8e 2b 80 00       	push   $0x802b8e
  800edb:	ff 75 0c             	pushl  0xc(%ebp)
  800ede:	ff 75 08             	pushl  0x8(%ebp)
  800ee1:	e8 57 02 00 00       	call   80113d <printfmt>
  800ee6:	83 c4 10             	add    $0x10,%esp
			break;
  800ee9:	e9 42 02 00 00       	jmp    801130 <vprintfmt+0x3ce>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800eee:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef1:	83 c0 04             	add    $0x4,%eax
  800ef4:	89 45 14             	mov    %eax,0x14(%ebp)
  800ef7:	8b 45 14             	mov    0x14(%ebp),%eax
  800efa:	83 e8 04             	sub    $0x4,%eax
  800efd:	8b 30                	mov    (%eax),%esi
  800eff:	85 f6                	test   %esi,%esi
  800f01:	75 05                	jne    800f08 <vprintfmt+0x1a6>
				p = "(null)";
  800f03:	be 91 2b 80 00       	mov    $0x802b91,%esi
			if (width > 0 && padc != '-')
  800f08:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f0c:	7e 6d                	jle    800f7b <vprintfmt+0x219>
  800f0e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f12:	74 67                	je     800f7b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f14:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f17:	83 ec 08             	sub    $0x8,%esp
  800f1a:	50                   	push   %eax
  800f1b:	56                   	push   %esi
  800f1c:	e8 1e 03 00 00       	call   80123f <strnlen>
  800f21:	83 c4 10             	add    $0x10,%esp
  800f24:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f27:	eb 16                	jmp    800f3f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f29:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f2d:	83 ec 08             	sub    $0x8,%esp
  800f30:	ff 75 0c             	pushl  0xc(%ebp)
  800f33:	50                   	push   %eax
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	ff d0                	call   *%eax
  800f39:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f3c:	ff 4d e4             	decl   -0x1c(%ebp)
  800f3f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f43:	7f e4                	jg     800f29 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f45:	eb 34                	jmp    800f7b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f47:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f4b:	74 1c                	je     800f69 <vprintfmt+0x207>
  800f4d:	83 fb 1f             	cmp    $0x1f,%ebx
  800f50:	7e 05                	jle    800f57 <vprintfmt+0x1f5>
  800f52:	83 fb 7e             	cmp    $0x7e,%ebx
  800f55:	7e 12                	jle    800f69 <vprintfmt+0x207>
					putch('?', putdat);
  800f57:	83 ec 08             	sub    $0x8,%esp
  800f5a:	ff 75 0c             	pushl  0xc(%ebp)
  800f5d:	6a 3f                	push   $0x3f
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	ff d0                	call   *%eax
  800f64:	83 c4 10             	add    $0x10,%esp
  800f67:	eb 0f                	jmp    800f78 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f69:	83 ec 08             	sub    $0x8,%esp
  800f6c:	ff 75 0c             	pushl  0xc(%ebp)
  800f6f:	53                   	push   %ebx
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	ff d0                	call   *%eax
  800f75:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f78:	ff 4d e4             	decl   -0x1c(%ebp)
  800f7b:	89 f0                	mov    %esi,%eax
  800f7d:	8d 70 01             	lea    0x1(%eax),%esi
  800f80:	8a 00                	mov    (%eax),%al
  800f82:	0f be d8             	movsbl %al,%ebx
  800f85:	85 db                	test   %ebx,%ebx
  800f87:	74 24                	je     800fad <vprintfmt+0x24b>
  800f89:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f8d:	78 b8                	js     800f47 <vprintfmt+0x1e5>
  800f8f:	ff 4d e0             	decl   -0x20(%ebp)
  800f92:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f96:	79 af                	jns    800f47 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f98:	eb 13                	jmp    800fad <vprintfmt+0x24b>
				putch(' ', putdat);
  800f9a:	83 ec 08             	sub    $0x8,%esp
  800f9d:	ff 75 0c             	pushl  0xc(%ebp)
  800fa0:	6a 20                	push   $0x20
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	ff d0                	call   *%eax
  800fa7:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800faa:	ff 4d e4             	decl   -0x1c(%ebp)
  800fad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fb1:	7f e7                	jg     800f9a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fb3:	e9 78 01 00 00       	jmp    801130 <vprintfmt+0x3ce>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fb8:	83 ec 08             	sub    $0x8,%esp
  800fbb:	ff 75 e8             	pushl  -0x18(%ebp)
  800fbe:	8d 45 14             	lea    0x14(%ebp),%eax
  800fc1:	50                   	push   %eax
  800fc2:	e8 3c fd ff ff       	call   800d03 <getint>
  800fc7:	83 c4 10             	add    $0x10,%esp
  800fca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fcd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fd3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fd6:	85 d2                	test   %edx,%edx
  800fd8:	79 23                	jns    800ffd <vprintfmt+0x29b>
				putch('-', putdat);
  800fda:	83 ec 08             	sub    $0x8,%esp
  800fdd:	ff 75 0c             	pushl  0xc(%ebp)
  800fe0:	6a 2d                	push   $0x2d
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	ff d0                	call   *%eax
  800fe7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ff0:	f7 d8                	neg    %eax
  800ff2:	83 d2 00             	adc    $0x0,%edx
  800ff5:	f7 da                	neg    %edx
  800ff7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ffa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ffd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801004:	e9 bc 00 00 00       	jmp    8010c5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801009:	83 ec 08             	sub    $0x8,%esp
  80100c:	ff 75 e8             	pushl  -0x18(%ebp)
  80100f:	8d 45 14             	lea    0x14(%ebp),%eax
  801012:	50                   	push   %eax
  801013:	e8 84 fc ff ff       	call   800c9c <getuint>
  801018:	83 c4 10             	add    $0x10,%esp
  80101b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80101e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801021:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801028:	e9 98 00 00 00       	jmp    8010c5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80102d:	83 ec 08             	sub    $0x8,%esp
  801030:	ff 75 0c             	pushl  0xc(%ebp)
  801033:	6a 58                	push   $0x58
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	ff d0                	call   *%eax
  80103a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80103d:	83 ec 08             	sub    $0x8,%esp
  801040:	ff 75 0c             	pushl  0xc(%ebp)
  801043:	6a 58                	push   $0x58
  801045:	8b 45 08             	mov    0x8(%ebp),%eax
  801048:	ff d0                	call   *%eax
  80104a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80104d:	83 ec 08             	sub    $0x8,%esp
  801050:	ff 75 0c             	pushl  0xc(%ebp)
  801053:	6a 58                	push   $0x58
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	ff d0                	call   *%eax
  80105a:	83 c4 10             	add    $0x10,%esp
			break;
  80105d:	e9 ce 00 00 00       	jmp    801130 <vprintfmt+0x3ce>

		// pointer
		case 'p':
			putch('0', putdat);
  801062:	83 ec 08             	sub    $0x8,%esp
  801065:	ff 75 0c             	pushl  0xc(%ebp)
  801068:	6a 30                	push   $0x30
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	ff d0                	call   *%eax
  80106f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801072:	83 ec 08             	sub    $0x8,%esp
  801075:	ff 75 0c             	pushl  0xc(%ebp)
  801078:	6a 78                	push   $0x78
  80107a:	8b 45 08             	mov    0x8(%ebp),%eax
  80107d:	ff d0                	call   *%eax
  80107f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801082:	8b 45 14             	mov    0x14(%ebp),%eax
  801085:	83 c0 04             	add    $0x4,%eax
  801088:	89 45 14             	mov    %eax,0x14(%ebp)
  80108b:	8b 45 14             	mov    0x14(%ebp),%eax
  80108e:	83 e8 04             	sub    $0x4,%eax
  801091:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801093:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801096:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80109d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010a4:	eb 1f                	jmp    8010c5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010a6:	83 ec 08             	sub    $0x8,%esp
  8010a9:	ff 75 e8             	pushl  -0x18(%ebp)
  8010ac:	8d 45 14             	lea    0x14(%ebp),%eax
  8010af:	50                   	push   %eax
  8010b0:	e8 e7 fb ff ff       	call   800c9c <getuint>
  8010b5:	83 c4 10             	add    $0x10,%esp
  8010b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010be:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010c5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010cc:	83 ec 04             	sub    $0x4,%esp
  8010cf:	52                   	push   %edx
  8010d0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010d3:	50                   	push   %eax
  8010d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d7:	ff 75 f0             	pushl  -0x10(%ebp)
  8010da:	ff 75 0c             	pushl  0xc(%ebp)
  8010dd:	ff 75 08             	pushl  0x8(%ebp)
  8010e0:	e8 00 fb ff ff       	call   800be5 <printnum>
  8010e5:	83 c4 20             	add    $0x20,%esp
			break;
  8010e8:	eb 46                	jmp    801130 <vprintfmt+0x3ce>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010ea:	83 ec 08             	sub    $0x8,%esp
  8010ed:	ff 75 0c             	pushl  0xc(%ebp)
  8010f0:	53                   	push   %ebx
  8010f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f4:	ff d0                	call   *%eax
  8010f6:	83 c4 10             	add    $0x10,%esp
			break;
  8010f9:	eb 35                	jmp    801130 <vprintfmt+0x3ce>

		/**********************************/
		/*2023*/
		// DON'T Print Program Name & UD
		case '~':
			printProgName = 0;
  8010fb:	c6 05 80 b0 81 00 00 	movb   $0x0,0x81b080
			break;
  801102:	eb 2c                	jmp    801130 <vprintfmt+0x3ce>
		// Print Program Name & UD
		case '@':
			printProgName = 1;
  801104:	c6 05 80 b0 81 00 01 	movb   $0x1,0x81b080
			break;
  80110b:	eb 23                	jmp    801130 <vprintfmt+0x3ce>
		/**********************************/

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80110d:	83 ec 08             	sub    $0x8,%esp
  801110:	ff 75 0c             	pushl  0xc(%ebp)
  801113:	6a 25                	push   $0x25
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	ff d0                	call   *%eax
  80111a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80111d:	ff 4d 10             	decl   0x10(%ebp)
  801120:	eb 03                	jmp    801125 <vprintfmt+0x3c3>
  801122:	ff 4d 10             	decl   0x10(%ebp)
  801125:	8b 45 10             	mov    0x10(%ebp),%eax
  801128:	48                   	dec    %eax
  801129:	8a 00                	mov    (%eax),%al
  80112b:	3c 25                	cmp    $0x25,%al
  80112d:	75 f3                	jne    801122 <vprintfmt+0x3c0>
				/* do nothing */;
			break;
  80112f:	90                   	nop
		}
	}
  801130:	e9 35 fc ff ff       	jmp    800d6a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801135:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801136:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801139:	5b                   	pop    %ebx
  80113a:	5e                   	pop    %esi
  80113b:	5d                   	pop    %ebp
  80113c:	c3                   	ret    

0080113d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80113d:	55                   	push   %ebp
  80113e:	89 e5                	mov    %esp,%ebp
  801140:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801143:	8d 45 10             	lea    0x10(%ebp),%eax
  801146:	83 c0 04             	add    $0x4,%eax
  801149:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80114c:	8b 45 10             	mov    0x10(%ebp),%eax
  80114f:	ff 75 f4             	pushl  -0xc(%ebp)
  801152:	50                   	push   %eax
  801153:	ff 75 0c             	pushl  0xc(%ebp)
  801156:	ff 75 08             	pushl  0x8(%ebp)
  801159:	e8 04 fc ff ff       	call   800d62 <vprintfmt>
  80115e:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801161:	90                   	nop
  801162:	c9                   	leave  
  801163:	c3                   	ret    

00801164 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801164:	55                   	push   %ebp
  801165:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801167:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116a:	8b 40 08             	mov    0x8(%eax),%eax
  80116d:	8d 50 01             	lea    0x1(%eax),%edx
  801170:	8b 45 0c             	mov    0xc(%ebp),%eax
  801173:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801176:	8b 45 0c             	mov    0xc(%ebp),%eax
  801179:	8b 10                	mov    (%eax),%edx
  80117b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117e:	8b 40 04             	mov    0x4(%eax),%eax
  801181:	39 c2                	cmp    %eax,%edx
  801183:	73 12                	jae    801197 <sprintputch+0x33>
		*b->buf++ = ch;
  801185:	8b 45 0c             	mov    0xc(%ebp),%eax
  801188:	8b 00                	mov    (%eax),%eax
  80118a:	8d 48 01             	lea    0x1(%eax),%ecx
  80118d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801190:	89 0a                	mov    %ecx,(%edx)
  801192:	8b 55 08             	mov    0x8(%ebp),%edx
  801195:	88 10                	mov    %dl,(%eax)
}
  801197:	90                   	nop
  801198:	5d                   	pop    %ebp
  801199:	c3                   	ret    

0080119a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80119a:	55                   	push   %ebp
  80119b:	89 e5                	mov    %esp,%ebp
  80119d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	01 d0                	add    %edx,%eax
  8011b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011bb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011bf:	74 06                	je     8011c7 <vsnprintf+0x2d>
  8011c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011c5:	7f 07                	jg     8011ce <vsnprintf+0x34>
		return -E_INVAL;
  8011c7:	b8 03 00 00 00       	mov    $0x3,%eax
  8011cc:	eb 20                	jmp    8011ee <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011ce:	ff 75 14             	pushl  0x14(%ebp)
  8011d1:	ff 75 10             	pushl  0x10(%ebp)
  8011d4:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011d7:	50                   	push   %eax
  8011d8:	68 64 11 80 00       	push   $0x801164
  8011dd:	e8 80 fb ff ff       	call   800d62 <vprintfmt>
  8011e2:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011e8:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011ee:	c9                   	leave  
  8011ef:	c3                   	ret    

008011f0 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011f0:	55                   	push   %ebp
  8011f1:	89 e5                	mov    %esp,%ebp
  8011f3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011f6:	8d 45 10             	lea    0x10(%ebp),%eax
  8011f9:	83 c0 04             	add    $0x4,%eax
  8011fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801202:	ff 75 f4             	pushl  -0xc(%ebp)
  801205:	50                   	push   %eax
  801206:	ff 75 0c             	pushl  0xc(%ebp)
  801209:	ff 75 08             	pushl  0x8(%ebp)
  80120c:	e8 89 ff ff ff       	call   80119a <vsnprintf>
  801211:	83 c4 10             	add    $0x10,%esp
  801214:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801217:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80121a:	c9                   	leave  
  80121b:	c3                   	ret    

0080121c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80121c:	55                   	push   %ebp
  80121d:	89 e5                	mov    %esp,%ebp
  80121f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801222:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801229:	eb 06                	jmp    801231 <strlen+0x15>
		n++;
  80122b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80122e:	ff 45 08             	incl   0x8(%ebp)
  801231:	8b 45 08             	mov    0x8(%ebp),%eax
  801234:	8a 00                	mov    (%eax),%al
  801236:	84 c0                	test   %al,%al
  801238:	75 f1                	jne    80122b <strlen+0xf>
		n++;
	return n;
  80123a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80123d:	c9                   	leave  
  80123e:	c3                   	ret    

0080123f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80123f:	55                   	push   %ebp
  801240:	89 e5                	mov    %esp,%ebp
  801242:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801245:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80124c:	eb 09                	jmp    801257 <strnlen+0x18>
		n++;
  80124e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801251:	ff 45 08             	incl   0x8(%ebp)
  801254:	ff 4d 0c             	decl   0xc(%ebp)
  801257:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80125b:	74 09                	je     801266 <strnlen+0x27>
  80125d:	8b 45 08             	mov    0x8(%ebp),%eax
  801260:	8a 00                	mov    (%eax),%al
  801262:	84 c0                	test   %al,%al
  801264:	75 e8                	jne    80124e <strnlen+0xf>
		n++;
	return n;
  801266:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801269:	c9                   	leave  
  80126a:	c3                   	ret    

0080126b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80126b:	55                   	push   %ebp
  80126c:	89 e5                	mov    %esp,%ebp
  80126e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801271:	8b 45 08             	mov    0x8(%ebp),%eax
  801274:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801277:	90                   	nop
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	8d 50 01             	lea    0x1(%eax),%edx
  80127e:	89 55 08             	mov    %edx,0x8(%ebp)
  801281:	8b 55 0c             	mov    0xc(%ebp),%edx
  801284:	8d 4a 01             	lea    0x1(%edx),%ecx
  801287:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80128a:	8a 12                	mov    (%edx),%dl
  80128c:	88 10                	mov    %dl,(%eax)
  80128e:	8a 00                	mov    (%eax),%al
  801290:	84 c0                	test   %al,%al
  801292:	75 e4                	jne    801278 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801294:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801297:	c9                   	leave  
  801298:	c3                   	ret    

00801299 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801299:	55                   	push   %ebp
  80129a:	89 e5                	mov    %esp,%ebp
  80129c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80129f:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012ac:	eb 1f                	jmp    8012cd <strncpy+0x34>
		*dst++ = *src;
  8012ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b1:	8d 50 01             	lea    0x1(%eax),%edx
  8012b4:	89 55 08             	mov    %edx,0x8(%ebp)
  8012b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ba:	8a 12                	mov    (%edx),%dl
  8012bc:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c1:	8a 00                	mov    (%eax),%al
  8012c3:	84 c0                	test   %al,%al
  8012c5:	74 03                	je     8012ca <strncpy+0x31>
			src++;
  8012c7:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012ca:	ff 45 fc             	incl   -0x4(%ebp)
  8012cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012d3:	72 d9                	jb     8012ae <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012d8:	c9                   	leave  
  8012d9:	c3                   	ret    

008012da <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012da:	55                   	push   %ebp
  8012db:	89 e5                	mov    %esp,%ebp
  8012dd:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8012e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012ea:	74 30                	je     80131c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8012ec:	eb 16                	jmp    801304 <strlcpy+0x2a>
			*dst++ = *src++;
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	8d 50 01             	lea    0x1(%eax),%edx
  8012f4:	89 55 08             	mov    %edx,0x8(%ebp)
  8012f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fa:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012fd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801300:	8a 12                	mov    (%edx),%dl
  801302:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801304:	ff 4d 10             	decl   0x10(%ebp)
  801307:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80130b:	74 09                	je     801316 <strlcpy+0x3c>
  80130d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801310:	8a 00                	mov    (%eax),%al
  801312:	84 c0                	test   %al,%al
  801314:	75 d8                	jne    8012ee <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801316:	8b 45 08             	mov    0x8(%ebp),%eax
  801319:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80131c:	8b 55 08             	mov    0x8(%ebp),%edx
  80131f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801322:	29 c2                	sub    %eax,%edx
  801324:	89 d0                	mov    %edx,%eax
}
  801326:	c9                   	leave  
  801327:	c3                   	ret    

00801328 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801328:	55                   	push   %ebp
  801329:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80132b:	eb 06                	jmp    801333 <strcmp+0xb>
		p++, q++;
  80132d:	ff 45 08             	incl   0x8(%ebp)
  801330:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
  801336:	8a 00                	mov    (%eax),%al
  801338:	84 c0                	test   %al,%al
  80133a:	74 0e                	je     80134a <strcmp+0x22>
  80133c:	8b 45 08             	mov    0x8(%ebp),%eax
  80133f:	8a 10                	mov    (%eax),%dl
  801341:	8b 45 0c             	mov    0xc(%ebp),%eax
  801344:	8a 00                	mov    (%eax),%al
  801346:	38 c2                	cmp    %al,%dl
  801348:	74 e3                	je     80132d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	8a 00                	mov    (%eax),%al
  80134f:	0f b6 d0             	movzbl %al,%edx
  801352:	8b 45 0c             	mov    0xc(%ebp),%eax
  801355:	8a 00                	mov    (%eax),%al
  801357:	0f b6 c0             	movzbl %al,%eax
  80135a:	29 c2                	sub    %eax,%edx
  80135c:	89 d0                	mov    %edx,%eax
}
  80135e:	5d                   	pop    %ebp
  80135f:	c3                   	ret    

00801360 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801360:	55                   	push   %ebp
  801361:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801363:	eb 09                	jmp    80136e <strncmp+0xe>
		n--, p++, q++;
  801365:	ff 4d 10             	decl   0x10(%ebp)
  801368:	ff 45 08             	incl   0x8(%ebp)
  80136b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80136e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801372:	74 17                	je     80138b <strncmp+0x2b>
  801374:	8b 45 08             	mov    0x8(%ebp),%eax
  801377:	8a 00                	mov    (%eax),%al
  801379:	84 c0                	test   %al,%al
  80137b:	74 0e                	je     80138b <strncmp+0x2b>
  80137d:	8b 45 08             	mov    0x8(%ebp),%eax
  801380:	8a 10                	mov    (%eax),%dl
  801382:	8b 45 0c             	mov    0xc(%ebp),%eax
  801385:	8a 00                	mov    (%eax),%al
  801387:	38 c2                	cmp    %al,%dl
  801389:	74 da                	je     801365 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80138b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80138f:	75 07                	jne    801398 <strncmp+0x38>
		return 0;
  801391:	b8 00 00 00 00       	mov    $0x0,%eax
  801396:	eb 14                	jmp    8013ac <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801398:	8b 45 08             	mov    0x8(%ebp),%eax
  80139b:	8a 00                	mov    (%eax),%al
  80139d:	0f b6 d0             	movzbl %al,%edx
  8013a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a3:	8a 00                	mov    (%eax),%al
  8013a5:	0f b6 c0             	movzbl %al,%eax
  8013a8:	29 c2                	sub    %eax,%edx
  8013aa:	89 d0                	mov    %edx,%eax
}
  8013ac:	5d                   	pop    %ebp
  8013ad:	c3                   	ret    

008013ae <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
  8013b1:	83 ec 04             	sub    $0x4,%esp
  8013b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013ba:	eb 12                	jmp    8013ce <strchr+0x20>
		if (*s == c)
  8013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bf:	8a 00                	mov    (%eax),%al
  8013c1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013c4:	75 05                	jne    8013cb <strchr+0x1d>
			return (char *) s;
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	eb 11                	jmp    8013dc <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013cb:	ff 45 08             	incl   0x8(%ebp)
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	8a 00                	mov    (%eax),%al
  8013d3:	84 c0                	test   %al,%al
  8013d5:	75 e5                	jne    8013bc <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013dc:	c9                   	leave  
  8013dd:	c3                   	ret    

008013de <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013de:	55                   	push   %ebp
  8013df:	89 e5                	mov    %esp,%ebp
  8013e1:	83 ec 04             	sub    $0x4,%esp
  8013e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013ea:	eb 0d                	jmp    8013f9 <strfind+0x1b>
		if (*s == c)
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	8a 00                	mov    (%eax),%al
  8013f1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013f4:	74 0e                	je     801404 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8013f6:	ff 45 08             	incl   0x8(%ebp)
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	8a 00                	mov    (%eax),%al
  8013fe:	84 c0                	test   %al,%al
  801400:	75 ea                	jne    8013ec <strfind+0xe>
  801402:	eb 01                	jmp    801405 <strfind+0x27>
		if (*s == c)
			break;
  801404:	90                   	nop
	return (char *) s;
  801405:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801408:	c9                   	leave  
  801409:	c3                   	ret    

0080140a <memset>:

// *************** The faster implementation of memset & memcpy is implemented by *************
// ****************** Team80 (Yahia Khaled, Malek Ahmed et al) - FCIS'24-25 *******************
void *
memset(void *v, int c, uint32 n)
{
  80140a:	55                   	push   %ebp
  80140b:	89 e5                	mov    %esp,%ebp
  80140d:	83 ec 10             	sub    $0x10,%esp
//	m = n;
//	while (--m >= 0)
//		*p++ = c;

	/*Faster Implementation*/
	uint64* p64 = (uint64*)v;
  801410:	8b 45 08             	mov    0x8(%ebp),%eax
  801413:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if(n >= 8){
  801416:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80141a:	76 63                	jbe    80147f <memset+0x75>
		uint64 data_block = c;
  80141c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141f:	99                   	cltd   
  801420:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801423:	89 55 f4             	mov    %edx,-0xc(%ebp)
		data_block |= data_block << 8;
  801426:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801429:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80142c:	0f a4 c2 08          	shld   $0x8,%eax,%edx
  801430:	c1 e0 08             	shl    $0x8,%eax
  801433:	09 45 f0             	or     %eax,-0x10(%ebp)
  801436:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 16;
  801439:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80143c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80143f:	0f a4 c2 10          	shld   $0x10,%eax,%edx
  801443:	c1 e0 10             	shl    $0x10,%eax
  801446:	09 45 f0             	or     %eax,-0x10(%ebp)
  801449:	09 55 f4             	or     %edx,-0xc(%ebp)
		data_block |= data_block << 32;
  80144c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80144f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801452:	89 c2                	mov    %eax,%edx
  801454:	b8 00 00 00 00       	mov    $0x0,%eax
  801459:	09 45 f0             	or     %eax,-0x10(%ebp)
  80145c:	09 55 f4             	or     %edx,-0xc(%ebp)

		while(n >= 8)
  80145f:	eb 18                	jmp    801479 <memset+0x6f>
			*p64++ = data_block, n -= 8;
  801461:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801464:	8d 41 08             	lea    0x8(%ecx),%eax
  801467:	89 45 fc             	mov    %eax,-0x4(%ebp)
  80146a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80146d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801470:	89 01                	mov    %eax,(%ecx)
  801472:	89 51 04             	mov    %edx,0x4(%ecx)
  801475:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
		uint64 data_block = c;
		data_block |= data_block << 8;
		data_block |= data_block << 16;
		data_block |= data_block << 32;

		while(n >= 8)
  801479:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  80147d:	77 e2                	ja     801461 <memset+0x57>
			*p64++ = data_block, n -= 8;
	}

	if(n){
  80147f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801483:	74 23                	je     8014a8 <memset+0x9e>
		uint8* p8 = (uint8*)p64;
  801485:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801488:	89 45 f8             	mov    %eax,-0x8(%ebp)
		while (n-- > 0)
  80148b:	eb 0e                	jmp    80149b <memset+0x91>
			*p8++ = (uint8)c;
  80148d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801490:	8d 50 01             	lea    0x1(%eax),%edx
  801493:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801496:	8b 55 0c             	mov    0xc(%ebp),%edx
  801499:	88 10                	mov    %dl,(%eax)
			*p64++ = data_block, n -= 8;
	}

	if(n){
		uint8* p8 = (uint8*)p64;
		while (n-- > 0)
  80149b:	8b 45 10             	mov    0x10(%ebp),%eax
  80149e:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014a1:	89 55 10             	mov    %edx,0x10(%ebp)
  8014a4:	85 c0                	test   %eax,%eax
  8014a6:	75 e5                	jne    80148d <memset+0x83>
			*p8++ = (uint8)c;
	}

	return v;
  8014a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014ab:	c9                   	leave  
  8014ac:	c3                   	ret    

008014ad <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014ad:	55                   	push   %ebp
  8014ae:	89 e5                	mov    %esp,%ebp
  8014b0:	83 ec 10             	sub    $0x10,%esp
	//	s = src;
	//	d = dst;
	//	while (n-- > 0)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
  8014b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	uint64* d64 = (uint64*)dst;
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if(n >= 8){
  8014bf:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8014c3:	76 24                	jbe    8014e9 <memcpy+0x3c>
		while(n >= 8){
  8014c5:	eb 1c                	jmp    8014e3 <memcpy+0x36>
			*d64 = *s64;
  8014c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ca:	8b 50 04             	mov    0x4(%eax),%edx
  8014cd:	8b 00                	mov    (%eax),%eax
  8014cf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8014d2:	89 01                	mov    %eax,(%ecx)
  8014d4:	89 51 04             	mov    %edx,0x4(%ecx)
			n -= 8;
  8014d7:	83 6d 10 08          	subl   $0x8,0x10(%ebp)
			++s64;
  8014db:	83 45 fc 08          	addl   $0x8,-0x4(%ebp)
			++d64;
  8014df:	83 45 f8 08          	addl   $0x8,-0x8(%ebp)
	//		*d++ = *s++;
	/*Faster Implementation*/
	uint64* s64 = (uint64*)src;
	uint64* d64 = (uint64*)dst;
	if(n >= 8){
		while(n >= 8){
  8014e3:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
  8014e7:	77 de                	ja     8014c7 <memcpy+0x1a>
			++s64;
			++d64;
		}
	}

	if(n){
  8014e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ed:	74 31                	je     801520 <memcpy+0x73>
		uint8* s8 = (uint8*)s64;
  8014ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint8* d8 = (uint8*)d64;
  8014f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		while (n-- > 0)
  8014fb:	eb 16                	jmp    801513 <memcpy+0x66>
			*d8++ = *s8++;
  8014fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801500:	8d 50 01             	lea    0x1(%eax),%edx
  801503:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801506:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801509:	8d 4a 01             	lea    0x1(%edx),%ecx
  80150c:	89 4d f4             	mov    %ecx,-0xc(%ebp)
  80150f:	8a 12                	mov    (%edx),%dl
  801511:	88 10                	mov    %dl,(%eax)
	}

	if(n){
		uint8* s8 = (uint8*)s64;
		uint8* d8 = (uint8*)d64;
		while (n-- > 0)
  801513:	8b 45 10             	mov    0x10(%ebp),%eax
  801516:	8d 50 ff             	lea    -0x1(%eax),%edx
  801519:	89 55 10             	mov    %edx,0x10(%ebp)
  80151c:	85 c0                	test   %eax,%eax
  80151e:	75 dd                	jne    8014fd <memcpy+0x50>
			*d8++ = *s8++;
	}
	return dst;
  801520:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
  801528:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80152b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801531:	8b 45 08             	mov    0x8(%ebp),%eax
  801534:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801537:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80153d:	73 50                	jae    80158f <memmove+0x6a>
  80153f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801542:	8b 45 10             	mov    0x10(%ebp),%eax
  801545:	01 d0                	add    %edx,%eax
  801547:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80154a:	76 43                	jbe    80158f <memmove+0x6a>
		s += n;
  80154c:	8b 45 10             	mov    0x10(%ebp),%eax
  80154f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801552:	8b 45 10             	mov    0x10(%ebp),%eax
  801555:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801558:	eb 10                	jmp    80156a <memmove+0x45>
			*--d = *--s;
  80155a:	ff 4d f8             	decl   -0x8(%ebp)
  80155d:	ff 4d fc             	decl   -0x4(%ebp)
  801560:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801563:	8a 10                	mov    (%eax),%dl
  801565:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801568:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80156a:	8b 45 10             	mov    0x10(%ebp),%eax
  80156d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801570:	89 55 10             	mov    %edx,0x10(%ebp)
  801573:	85 c0                	test   %eax,%eax
  801575:	75 e3                	jne    80155a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801577:	eb 23                	jmp    80159c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801579:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157c:	8d 50 01             	lea    0x1(%eax),%edx
  80157f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801582:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801585:	8d 4a 01             	lea    0x1(%edx),%ecx
  801588:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80158b:	8a 12                	mov    (%edx),%dl
  80158d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80158f:	8b 45 10             	mov    0x10(%ebp),%eax
  801592:	8d 50 ff             	lea    -0x1(%eax),%edx
  801595:	89 55 10             	mov    %edx,0x10(%ebp)
  801598:	85 c0                	test   %eax,%eax
  80159a:	75 dd                	jne    801579 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80159c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80159f:	c9                   	leave  
  8015a0:	c3                   	ret    

008015a1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015a1:	55                   	push   %ebp
  8015a2:	89 e5                	mov    %esp,%ebp
  8015a4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015b3:	eb 2a                	jmp    8015df <memcmp+0x3e>
		if (*s1 != *s2)
  8015b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015b8:	8a 10                	mov    (%eax),%dl
  8015ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015bd:	8a 00                	mov    (%eax),%al
  8015bf:	38 c2                	cmp    %al,%dl
  8015c1:	74 16                	je     8015d9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015c6:	8a 00                	mov    (%eax),%al
  8015c8:	0f b6 d0             	movzbl %al,%edx
  8015cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ce:	8a 00                	mov    (%eax),%al
  8015d0:	0f b6 c0             	movzbl %al,%eax
  8015d3:	29 c2                	sub    %eax,%edx
  8015d5:	89 d0                	mov    %edx,%eax
  8015d7:	eb 18                	jmp    8015f1 <memcmp+0x50>
		s1++, s2++;
  8015d9:	ff 45 fc             	incl   -0x4(%ebp)
  8015dc:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015df:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015e5:	89 55 10             	mov    %edx,0x10(%ebp)
  8015e8:	85 c0                	test   %eax,%eax
  8015ea:	75 c9                	jne    8015b5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
  8015f6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015f9:	8b 55 08             	mov    0x8(%ebp),%edx
  8015fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ff:	01 d0                	add    %edx,%eax
  801601:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801604:	eb 15                	jmp    80161b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
  801609:	8a 00                	mov    (%eax),%al
  80160b:	0f b6 d0             	movzbl %al,%edx
  80160e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801611:	0f b6 c0             	movzbl %al,%eax
  801614:	39 c2                	cmp    %eax,%edx
  801616:	74 0d                	je     801625 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801618:	ff 45 08             	incl   0x8(%ebp)
  80161b:	8b 45 08             	mov    0x8(%ebp),%eax
  80161e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801621:	72 e3                	jb     801606 <memfind+0x13>
  801623:	eb 01                	jmp    801626 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801625:	90                   	nop
	return (void *) s;
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
  80162e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801631:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801638:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80163f:	eb 03                	jmp    801644 <strtol+0x19>
		s++;
  801641:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801644:	8b 45 08             	mov    0x8(%ebp),%eax
  801647:	8a 00                	mov    (%eax),%al
  801649:	3c 20                	cmp    $0x20,%al
  80164b:	74 f4                	je     801641 <strtol+0x16>
  80164d:	8b 45 08             	mov    0x8(%ebp),%eax
  801650:	8a 00                	mov    (%eax),%al
  801652:	3c 09                	cmp    $0x9,%al
  801654:	74 eb                	je     801641 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	8a 00                	mov    (%eax),%al
  80165b:	3c 2b                	cmp    $0x2b,%al
  80165d:	75 05                	jne    801664 <strtol+0x39>
		s++;
  80165f:	ff 45 08             	incl   0x8(%ebp)
  801662:	eb 13                	jmp    801677 <strtol+0x4c>
	else if (*s == '-')
  801664:	8b 45 08             	mov    0x8(%ebp),%eax
  801667:	8a 00                	mov    (%eax),%al
  801669:	3c 2d                	cmp    $0x2d,%al
  80166b:	75 0a                	jne    801677 <strtol+0x4c>
		s++, neg = 1;
  80166d:	ff 45 08             	incl   0x8(%ebp)
  801670:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801677:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80167b:	74 06                	je     801683 <strtol+0x58>
  80167d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801681:	75 20                	jne    8016a3 <strtol+0x78>
  801683:	8b 45 08             	mov    0x8(%ebp),%eax
  801686:	8a 00                	mov    (%eax),%al
  801688:	3c 30                	cmp    $0x30,%al
  80168a:	75 17                	jne    8016a3 <strtol+0x78>
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	40                   	inc    %eax
  801690:	8a 00                	mov    (%eax),%al
  801692:	3c 78                	cmp    $0x78,%al
  801694:	75 0d                	jne    8016a3 <strtol+0x78>
		s += 2, base = 16;
  801696:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80169a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016a1:	eb 28                	jmp    8016cb <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016a3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016a7:	75 15                	jne    8016be <strtol+0x93>
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	8a 00                	mov    (%eax),%al
  8016ae:	3c 30                	cmp    $0x30,%al
  8016b0:	75 0c                	jne    8016be <strtol+0x93>
		s++, base = 8;
  8016b2:	ff 45 08             	incl   0x8(%ebp)
  8016b5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016bc:	eb 0d                	jmp    8016cb <strtol+0xa0>
	else if (base == 0)
  8016be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016c2:	75 07                	jne    8016cb <strtol+0xa0>
		base = 10;
  8016c4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ce:	8a 00                	mov    (%eax),%al
  8016d0:	3c 2f                	cmp    $0x2f,%al
  8016d2:	7e 19                	jle    8016ed <strtol+0xc2>
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	8a 00                	mov    (%eax),%al
  8016d9:	3c 39                	cmp    $0x39,%al
  8016db:	7f 10                	jg     8016ed <strtol+0xc2>
			dig = *s - '0';
  8016dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e0:	8a 00                	mov    (%eax),%al
  8016e2:	0f be c0             	movsbl %al,%eax
  8016e5:	83 e8 30             	sub    $0x30,%eax
  8016e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016eb:	eb 42                	jmp    80172f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f0:	8a 00                	mov    (%eax),%al
  8016f2:	3c 60                	cmp    $0x60,%al
  8016f4:	7e 19                	jle    80170f <strtol+0xe4>
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	8a 00                	mov    (%eax),%al
  8016fb:	3c 7a                	cmp    $0x7a,%al
  8016fd:	7f 10                	jg     80170f <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801702:	8a 00                	mov    (%eax),%al
  801704:	0f be c0             	movsbl %al,%eax
  801707:	83 e8 57             	sub    $0x57,%eax
  80170a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80170d:	eb 20                	jmp    80172f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80170f:	8b 45 08             	mov    0x8(%ebp),%eax
  801712:	8a 00                	mov    (%eax),%al
  801714:	3c 40                	cmp    $0x40,%al
  801716:	7e 39                	jle    801751 <strtol+0x126>
  801718:	8b 45 08             	mov    0x8(%ebp),%eax
  80171b:	8a 00                	mov    (%eax),%al
  80171d:	3c 5a                	cmp    $0x5a,%al
  80171f:	7f 30                	jg     801751 <strtol+0x126>
			dig = *s - 'A' + 10;
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	8a 00                	mov    (%eax),%al
  801726:	0f be c0             	movsbl %al,%eax
  801729:	83 e8 37             	sub    $0x37,%eax
  80172c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80172f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801732:	3b 45 10             	cmp    0x10(%ebp),%eax
  801735:	7d 19                	jge    801750 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801737:	ff 45 08             	incl   0x8(%ebp)
  80173a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80173d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801741:	89 c2                	mov    %eax,%edx
  801743:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801746:	01 d0                	add    %edx,%eax
  801748:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80174b:	e9 7b ff ff ff       	jmp    8016cb <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801750:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801751:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801755:	74 08                	je     80175f <strtol+0x134>
		*endptr = (char *) s;
  801757:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175a:	8b 55 08             	mov    0x8(%ebp),%edx
  80175d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80175f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801763:	74 07                	je     80176c <strtol+0x141>
  801765:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801768:	f7 d8                	neg    %eax
  80176a:	eb 03                	jmp    80176f <strtol+0x144>
  80176c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <ltostr>:

void
ltostr(long value, char *str)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
  801774:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801777:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80177e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801785:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801789:	79 13                	jns    80179e <ltostr+0x2d>
	{
		neg = 1;
  80178b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801792:	8b 45 0c             	mov    0xc(%ebp),%eax
  801795:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801798:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80179b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80179e:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017a6:	99                   	cltd   
  8017a7:	f7 f9                	idiv   %ecx
  8017a9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017af:	8d 50 01             	lea    0x1(%eax),%edx
  8017b2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017b5:	89 c2                	mov    %eax,%edx
  8017b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ba:	01 d0                	add    %edx,%eax
  8017bc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017bf:	83 c2 30             	add    $0x30,%edx
  8017c2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017c7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017cc:	f7 e9                	imul   %ecx
  8017ce:	c1 fa 02             	sar    $0x2,%edx
  8017d1:	89 c8                	mov    %ecx,%eax
  8017d3:	c1 f8 1f             	sar    $0x1f,%eax
  8017d6:	29 c2                	sub    %eax,%edx
  8017d8:	89 d0                	mov    %edx,%eax
  8017da:	89 45 08             	mov    %eax,0x8(%ebp)
		/*2023 FIX el7 :)*/
		//} while (value % 10 != 0);
	} while (value != 0);
  8017dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017e1:	75 bb                	jne    80179e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ed:	48                   	dec    %eax
  8017ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017f1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017f5:	74 3d                	je     801834 <ltostr+0xc3>
		start = 1 ;
  8017f7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017fe:	eb 34                	jmp    801834 <ltostr+0xc3>
	{
		char tmp = str[start] ;
  801800:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801803:	8b 45 0c             	mov    0xc(%ebp),%eax
  801806:	01 d0                	add    %edx,%eax
  801808:	8a 00                	mov    (%eax),%al
  80180a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80180d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801810:	8b 45 0c             	mov    0xc(%ebp),%eax
  801813:	01 c2                	add    %eax,%edx
  801815:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801818:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181b:	01 c8                	add    %ecx,%eax
  80181d:	8a 00                	mov    (%eax),%al
  80181f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801821:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801824:	8b 45 0c             	mov    0xc(%ebp),%eax
  801827:	01 c2                	add    %eax,%edx
  801829:	8a 45 eb             	mov    -0x15(%ebp),%al
  80182c:	88 02                	mov    %al,(%edx)
		start++ ;
  80182e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801831:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801834:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801837:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80183a:	7c c4                	jl     801800 <ltostr+0x8f>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80183c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80183f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801842:	01 d0                	add    %edx,%eax
  801844:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801847:	90                   	nop
  801848:	c9                   	leave  
  801849:	c3                   	ret    

0080184a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80184a:	55                   	push   %ebp
  80184b:	89 e5                	mov    %esp,%ebp
  80184d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801850:	ff 75 08             	pushl  0x8(%ebp)
  801853:	e8 c4 f9 ff ff       	call   80121c <strlen>
  801858:	83 c4 04             	add    $0x4,%esp
  80185b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80185e:	ff 75 0c             	pushl  0xc(%ebp)
  801861:	e8 b6 f9 ff ff       	call   80121c <strlen>
  801866:	83 c4 04             	add    $0x4,%esp
  801869:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80186c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801873:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80187a:	eb 17                	jmp    801893 <strcconcat+0x49>
		final[s] = str1[s] ;
  80187c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80187f:	8b 45 10             	mov    0x10(%ebp),%eax
  801882:	01 c2                	add    %eax,%edx
  801884:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801887:	8b 45 08             	mov    0x8(%ebp),%eax
  80188a:	01 c8                	add    %ecx,%eax
  80188c:	8a 00                	mov    (%eax),%al
  80188e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801890:	ff 45 fc             	incl   -0x4(%ebp)
  801893:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801896:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801899:	7c e1                	jl     80187c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80189b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018a2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018a9:	eb 1f                	jmp    8018ca <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018ae:	8d 50 01             	lea    0x1(%eax),%edx
  8018b1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018b4:	89 c2                	mov    %eax,%edx
  8018b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b9:	01 c2                	add    %eax,%edx
  8018bb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c1:	01 c8                	add    %ecx,%eax
  8018c3:	8a 00                	mov    (%eax),%al
  8018c5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018c7:	ff 45 f8             	incl   -0x8(%ebp)
  8018ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018cd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018d0:	7c d9                	jl     8018ab <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018d2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d8:	01 d0                	add    %edx,%eax
  8018da:	c6 00 00             	movb   $0x0,(%eax)
}
  8018dd:	90                   	nop
  8018de:	c9                   	leave  
  8018df:	c3                   	ret    

008018e0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018e0:	55                   	push   %ebp
  8018e1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ef:	8b 00                	mov    (%eax),%eax
  8018f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018fb:	01 d0                	add    %edx,%eax
  8018fd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801903:	eb 0c                	jmp    801911 <strsplit+0x31>
			*string++ = 0;
  801905:	8b 45 08             	mov    0x8(%ebp),%eax
  801908:	8d 50 01             	lea    0x1(%eax),%edx
  80190b:	89 55 08             	mov    %edx,0x8(%ebp)
  80190e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	8a 00                	mov    (%eax),%al
  801916:	84 c0                	test   %al,%al
  801918:	74 18                	je     801932 <strsplit+0x52>
  80191a:	8b 45 08             	mov    0x8(%ebp),%eax
  80191d:	8a 00                	mov    (%eax),%al
  80191f:	0f be c0             	movsbl %al,%eax
  801922:	50                   	push   %eax
  801923:	ff 75 0c             	pushl  0xc(%ebp)
  801926:	e8 83 fa ff ff       	call   8013ae <strchr>
  80192b:	83 c4 08             	add    $0x8,%esp
  80192e:	85 c0                	test   %eax,%eax
  801930:	75 d3                	jne    801905 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801932:	8b 45 08             	mov    0x8(%ebp),%eax
  801935:	8a 00                	mov    (%eax),%al
  801937:	84 c0                	test   %al,%al
  801939:	74 5a                	je     801995 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80193b:	8b 45 14             	mov    0x14(%ebp),%eax
  80193e:	8b 00                	mov    (%eax),%eax
  801940:	83 f8 0f             	cmp    $0xf,%eax
  801943:	75 07                	jne    80194c <strsplit+0x6c>
		{
			return 0;
  801945:	b8 00 00 00 00       	mov    $0x0,%eax
  80194a:	eb 66                	jmp    8019b2 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80194c:	8b 45 14             	mov    0x14(%ebp),%eax
  80194f:	8b 00                	mov    (%eax),%eax
  801951:	8d 48 01             	lea    0x1(%eax),%ecx
  801954:	8b 55 14             	mov    0x14(%ebp),%edx
  801957:	89 0a                	mov    %ecx,(%edx)
  801959:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801960:	8b 45 10             	mov    0x10(%ebp),%eax
  801963:	01 c2                	add    %eax,%edx
  801965:	8b 45 08             	mov    0x8(%ebp),%eax
  801968:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80196a:	eb 03                	jmp    80196f <strsplit+0x8f>
			string++;
  80196c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80196f:	8b 45 08             	mov    0x8(%ebp),%eax
  801972:	8a 00                	mov    (%eax),%al
  801974:	84 c0                	test   %al,%al
  801976:	74 8b                	je     801903 <strsplit+0x23>
  801978:	8b 45 08             	mov    0x8(%ebp),%eax
  80197b:	8a 00                	mov    (%eax),%al
  80197d:	0f be c0             	movsbl %al,%eax
  801980:	50                   	push   %eax
  801981:	ff 75 0c             	pushl  0xc(%ebp)
  801984:	e8 25 fa ff ff       	call   8013ae <strchr>
  801989:	83 c4 08             	add    $0x8,%esp
  80198c:	85 c0                	test   %eax,%eax
  80198e:	74 dc                	je     80196c <strsplit+0x8c>
			string++;
	}
  801990:	e9 6e ff ff ff       	jmp    801903 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801995:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801996:	8b 45 14             	mov    0x14(%ebp),%eax
  801999:	8b 00                	mov    (%eax),%eax
  80199b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a5:	01 d0                	add    %edx,%eax
  8019a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019ad:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019b2:	c9                   	leave  
  8019b3:	c3                   	ret    

008019b4 <str2lower>:


/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
  8019b4:	55                   	push   %ebp
  8019b5:	89 e5                	mov    %esp,%ebp
  8019b7:	83 ec 10             	sub    $0x10,%esp
	char* ret = dst;
  8019ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (int i = 0; i < strlen(src); ++i)
  8019c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019c7:	eb 4a                	jmp    801a13 <str2lower+0x5f>
	{
		dst[i] = src[i] ;
  8019c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cf:	01 c2                	add    %eax,%edx
  8019d1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019d7:	01 c8                	add    %ecx,%eax
  8019d9:	8a 00                	mov    (%eax),%al
  8019db:	88 02                	mov    %al,(%edx)
		if (src[i] >= 'A' && src[i] <= 'Z')
  8019dd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019e3:	01 d0                	add    %edx,%eax
  8019e5:	8a 00                	mov    (%eax),%al
  8019e7:	3c 40                	cmp    $0x40,%al
  8019e9:	7e 25                	jle    801a10 <str2lower+0x5c>
  8019eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019f1:	01 d0                	add    %edx,%eax
  8019f3:	8a 00                	mov    (%eax),%al
  8019f5:	3c 5a                	cmp    $0x5a,%al
  8019f7:	7f 17                	jg     801a10 <str2lower+0x5c>
		{
			dst[i] += 32 ;
  8019f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ff:	01 d0                	add    %edx,%eax
  801a01:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a04:	8b 55 08             	mov    0x8(%ebp),%edx
  801a07:	01 ca                	add    %ecx,%edx
  801a09:	8a 12                	mov    (%edx),%dl
  801a0b:	83 c2 20             	add    $0x20,%edx
  801a0e:	88 10                	mov    %dl,(%eax)
/*2024*/
//to_lower(...) Convert all alphabet chars of a given string to lower case
char* str2lower(char *dst, const char *src)
{
	char* ret = dst;
	for (int i = 0; i < strlen(src); ++i)
  801a10:	ff 45 fc             	incl   -0x4(%ebp)
  801a13:	ff 75 0c             	pushl  0xc(%ebp)
  801a16:	e8 01 f8 ff ff       	call   80121c <strlen>
  801a1b:	83 c4 04             	add    $0x4,%esp
  801a1e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801a21:	7f a6                	jg     8019c9 <str2lower+0x15>
		if (src[i] >= 'A' && src[i] <= 'Z')
		{
			dst[i] += 32 ;
		}
	}
	return ret;
  801a23:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801a26:	c9                   	leave  
  801a27:	c3                   	ret    

00801a28 <syscall>:

#include <inc/syscall.h>
#include <inc/lib.h>

inline uint32 syscall(uint32 num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a28:	55                   	push   %ebp
  801a29:	89 e5                	mov    %esp,%ebp
  801a2b:	57                   	push   %edi
  801a2c:	56                   	push   %esi
  801a2d:	53                   	push   %ebx
  801a2e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a31:	8b 45 08             	mov    0x8(%ebp),%eax
  801a34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a37:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a3a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a3d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a40:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a43:	cd 30                	int    $0x30
  801a45:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a4b:	83 c4 10             	add    $0x10,%esp
  801a4e:	5b                   	pop    %ebx
  801a4f:	5e                   	pop    %esi
  801a50:	5f                   	pop    %edi
  801a51:	5d                   	pop    %ebp
  801a52:	c3                   	ret    

00801a53 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName, int color)
{
  801a53:	55                   	push   %ebp
  801a54:	89 e5                	mov    %esp,%ebp
  801a56:	83 ec 04             	sub    $0x4,%esp
  801a59:	8b 45 10             	mov    0x10(%ebp),%eax
  801a5c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, color, 0);
  801a5f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a62:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a66:	8b 45 08             	mov    0x8(%ebp),%eax
  801a69:	6a 00                	push   $0x0
  801a6b:	51                   	push   %ecx
  801a6c:	52                   	push   %edx
  801a6d:	ff 75 0c             	pushl  0xc(%ebp)
  801a70:	50                   	push   %eax
  801a71:	6a 00                	push   $0x0
  801a73:	e8 b0 ff ff ff       	call   801a28 <syscall>
  801a78:	83 c4 18             	add    $0x18,%esp
}
  801a7b:	90                   	nop
  801a7c:	c9                   	leave  
  801a7d:	c3                   	ret    

00801a7e <sys_cgetc>:

int
sys_cgetc(void)
{
  801a7e:	55                   	push   %ebp
  801a7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a81:	6a 00                	push   $0x0
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 02                	push   $0x2
  801a8d:	e8 96 ff ff ff       	call   801a28 <syscall>
  801a92:	83 c4 18             	add    $0x18,%esp
}
  801a95:	c9                   	leave  
  801a96:	c3                   	ret    

00801a97 <sys_lock_cons>:

void sys_lock_cons(void)
{
  801a97:	55                   	push   %ebp
  801a98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_lock_cons, 0, 0, 0, 0, 0);
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 03                	push   $0x3
  801aa6:	e8 7d ff ff ff       	call   801a28 <syscall>
  801aab:	83 c4 18             	add    $0x18,%esp
}
  801aae:	90                   	nop
  801aaf:	c9                   	leave  
  801ab0:	c3                   	ret    

00801ab1 <sys_unlock_cons>:
void sys_unlock_cons(void)
{
  801ab1:	55                   	push   %ebp
  801ab2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_unlock_cons, 0, 0, 0, 0, 0);
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 04                	push   $0x4
  801ac0:	e8 63 ff ff ff       	call   801a28 <syscall>
  801ac5:	83 c4 18             	add    $0x18,%esp
}
  801ac8:	90                   	nop
  801ac9:	c9                   	leave  
  801aca:	c3                   	ret    

00801acb <__sys_allocate_page>:

int __sys_allocate_page(void *va, int perm)
{
  801acb:	55                   	push   %ebp
  801acc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ace:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 00                	push   $0x0
  801ada:	52                   	push   %edx
  801adb:	50                   	push   %eax
  801adc:	6a 08                	push   $0x8
  801ade:	e8 45 ff ff ff       	call   801a28 <syscall>
  801ae3:	83 c4 18             	add    $0x18,%esp
}
  801ae6:	c9                   	leave  
  801ae7:	c3                   	ret    

00801ae8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ae8:	55                   	push   %ebp
  801ae9:	89 e5                	mov    %esp,%ebp
  801aeb:	56                   	push   %esi
  801aec:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801aed:	8b 75 18             	mov    0x18(%ebp),%esi
  801af0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801af3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801af6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af9:	8b 45 08             	mov    0x8(%ebp),%eax
  801afc:	56                   	push   %esi
  801afd:	53                   	push   %ebx
  801afe:	51                   	push   %ecx
  801aff:	52                   	push   %edx
  801b00:	50                   	push   %eax
  801b01:	6a 09                	push   $0x9
  801b03:	e8 20 ff ff ff       	call   801a28 <syscall>
  801b08:	83 c4 18             	add    $0x18,%esp
}
  801b0b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b0e:	5b                   	pop    %ebx
  801b0f:	5e                   	pop    %esi
  801b10:	5d                   	pop    %ebp
  801b11:	c3                   	ret    

00801b12 <__sys_unmap_frame>:

int __sys_unmap_frame(uint32 va)
{
  801b12:	55                   	push   %ebp
  801b13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, va, 0, 0, 0, 0);
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	ff 75 08             	pushl  0x8(%ebp)
  801b20:	6a 0a                	push   $0xa
  801b22:	e8 01 ff ff ff       	call   801a28 <syscall>
  801b27:	83 c4 18             	add    $0x18,%esp
}
  801b2a:	c9                   	leave  
  801b2b:	c3                   	ret    

00801b2c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b2c:	55                   	push   %ebp
  801b2d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	ff 75 0c             	pushl  0xc(%ebp)
  801b38:	ff 75 08             	pushl  0x8(%ebp)
  801b3b:	6a 0b                	push   $0xb
  801b3d:	e8 e6 fe ff ff       	call   801a28 <syscall>
  801b42:	83 c4 18             	add    $0x18,%esp
}
  801b45:	c9                   	leave  
  801b46:	c3                   	ret    

00801b47 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b47:	55                   	push   %ebp
  801b48:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 00                	push   $0x0
  801b54:	6a 0c                	push   $0xc
  801b56:	e8 cd fe ff ff       	call   801a28 <syscall>
  801b5b:	83 c4 18             	add    $0x18,%esp
}
  801b5e:	c9                   	leave  
  801b5f:	c3                   	ret    

00801b60 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b60:	55                   	push   %ebp
  801b61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 0d                	push   $0xd
  801b6f:	e8 b4 fe ff ff       	call   801a28 <syscall>
  801b74:	83 c4 18             	add    $0x18,%esp
}
  801b77:	c9                   	leave  
  801b78:	c3                   	ret    

00801b79 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b79:	55                   	push   %ebp
  801b7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 0e                	push   $0xe
  801b88:	e8 9b fe ff ff       	call   801a28 <syscall>
  801b8d:	83 c4 18             	add    $0x18,%esp
}
  801b90:	c9                   	leave  
  801b91:	c3                   	ret    

00801b92 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b92:	55                   	push   %ebp
  801b93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 0f                	push   $0xf
  801ba1:	e8 82 fe ff ff       	call   801a28 <syscall>
  801ba6:	83 c4 18             	add    $0x18,%esp
}
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	ff 75 08             	pushl  0x8(%ebp)
  801bb9:	6a 10                	push   $0x10
  801bbb:	e8 68 fe ff ff       	call   801a28 <syscall>
  801bc0:	83 c4 18             	add    $0x18,%esp
}
  801bc3:	c9                   	leave  
  801bc4:	c3                   	ret    

00801bc5 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 11                	push   $0x11
  801bd4:	e8 4f fe ff ff       	call   801a28 <syscall>
  801bd9:	83 c4 18             	add    $0x18,%esp
}
  801bdc:	90                   	nop
  801bdd:	c9                   	leave  
  801bde:	c3                   	ret    

00801bdf <sys_cputc>:

void
sys_cputc(const char c)
{
  801bdf:	55                   	push   %ebp
  801be0:	89 e5                	mov    %esp,%ebp
  801be2:	83 ec 04             	sub    $0x4,%esp
  801be5:	8b 45 08             	mov    0x8(%ebp),%eax
  801be8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801beb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	50                   	push   %eax
  801bf8:	6a 01                	push   $0x1
  801bfa:	e8 29 fe ff ff       	call   801a28 <syscall>
  801bff:	83 c4 18             	add    $0x18,%esp
}
  801c02:	90                   	nop
  801c03:	c9                   	leave  
  801c04:	c3                   	ret    

00801c05 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 14                	push   $0x14
  801c14:	e8 0f fe ff ff       	call   801a28 <syscall>
  801c19:	83 c4 18             	add    $0x18,%esp
}
  801c1c:	90                   	nop
  801c1d:	c9                   	leave  
  801c1e:	c3                   	ret    

00801c1f <sys_create_shared_object>:

int sys_create_shared_object(char* shareName, uint32 size, uint8 isWritable, void* startVA)
{
  801c1f:	55                   	push   %ebp
  801c20:	89 e5                	mov    %esp,%ebp
  801c22:	83 ec 04             	sub    $0x4,%esp
  801c25:	8b 45 10             	mov    0x10(%ebp),%eax
  801c28:	88 45 fc             	mov    %al,-0x4(%ebp)
	return  syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)startVA,  0);
  801c2b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801c2e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c32:	8b 45 08             	mov    0x8(%ebp),%eax
  801c35:	6a 00                	push   $0x0
  801c37:	51                   	push   %ecx
  801c38:	52                   	push   %edx
  801c39:	ff 75 0c             	pushl  0xc(%ebp)
  801c3c:	50                   	push   %eax
  801c3d:	6a 15                	push   $0x15
  801c3f:	e8 e4 fd ff ff       	call   801a28 <syscall>
  801c44:	83 c4 18             	add    $0x18,%esp
}
  801c47:	c9                   	leave  
  801c48:	c3                   	ret    

00801c49 <sys_get_share_info>:

int sys_get_share_info(uint32 ownerID, char* shareName, int *size)
{
  801c49:	55                   	push   %ebp
  801c4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_share_info, ownerID, (uint32)shareName,(uint32)size, 0, 0);
  801c4c:	8b 55 10             	mov    0x10(%ebp),%edx
  801c4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	52                   	push   %edx
  801c57:	50                   	push   %eax
  801c58:	ff 75 08             	pushl  0x8(%ebp)
  801c5b:	6a 16                	push   $0x16
  801c5d:	e8 c6 fd ff ff       	call   801a28 <syscall>
  801c62:	83 c4 18             	add    $0x18,%esp
}
  801c65:	c9                   	leave  
  801c66:	c3                   	ret    

00801c67 <sys_get_shared_object>:

int sys_get_shared_object(int shareID, void* startVA)
{
  801c67:	55                   	push   %ebp
  801c68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801c6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	52                   	push   %edx
  801c77:	50                   	push   %eax
  801c78:	6a 17                	push   $0x17
  801c7a:	e8 a9 fd ff ff       	call   801a28 <syscall>
  801c7f:	83 c4 18             	add    $0x18,%esp
}
  801c82:	c9                   	leave  
  801c83:	c3                   	ret    

00801c84 <sys_delete_shared_object>:

int sys_delete_shared_object(int shareID, void *startVA)
{
  801c84:	55                   	push   %ebp
  801c85:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) shareID, (uint32)startVA, 0, 0, 0);
  801c87:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	52                   	push   %edx
  801c94:	50                   	push   %eax
  801c95:	6a 18                	push   $0x18
  801c97:	e8 8c fd ff ff       	call   801a28 <syscall>
  801c9c:	83 c4 18             	add    $0x18,%esp
}
  801c9f:	c9                   	leave  
  801ca0:	c3                   	ret    

00801ca1 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ca1:	55                   	push   %ebp
  801ca2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca7:	6a 00                	push   $0x0
  801ca9:	ff 75 14             	pushl  0x14(%ebp)
  801cac:	ff 75 10             	pushl  0x10(%ebp)
  801caf:	ff 75 0c             	pushl  0xc(%ebp)
  801cb2:	50                   	push   %eax
  801cb3:	6a 19                	push   $0x19
  801cb5:	e8 6e fd ff ff       	call   801a28 <syscall>
  801cba:	83 c4 18             	add    $0x18,%esp
}
  801cbd:	c9                   	leave  
  801cbe:	c3                   	ret    

00801cbf <sys_run_env>:

void sys_run_env(int32 envId)
{
  801cbf:	55                   	push   %ebp
  801cc0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	50                   	push   %eax
  801cce:	6a 1a                	push   $0x1a
  801cd0:	e8 53 fd ff ff       	call   801a28 <syscall>
  801cd5:	83 c4 18             	add    $0x18,%esp
}
  801cd8:	90                   	nop
  801cd9:	c9                   	leave  
  801cda:	c3                   	ret    

00801cdb <sys_destroy_env>:

int sys_destroy_env(int32  envid)
{
  801cdb:	55                   	push   %ebp
  801cdc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_destroy_env, envid, 0, 0, 0, 0);
  801cde:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	50                   	push   %eax
  801cea:	6a 1b                	push   $0x1b
  801cec:	e8 37 fd ff ff       	call   801a28 <syscall>
  801cf1:	83 c4 18             	add    $0x18,%esp
}
  801cf4:	c9                   	leave  
  801cf5:	c3                   	ret    

00801cf6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801cf6:	55                   	push   %ebp
  801cf7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 05                	push   $0x5
  801d05:	e8 1e fd ff ff       	call   801a28 <syscall>
  801d0a:	83 c4 18             	add    $0x18,%esp
}
  801d0d:	c9                   	leave  
  801d0e:	c3                   	ret    

00801d0f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d0f:	55                   	push   %ebp
  801d10:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 06                	push   $0x6
  801d1e:	e8 05 fd ff ff       	call   801a28 <syscall>
  801d23:	83 c4 18             	add    $0x18,%esp
}
  801d26:	c9                   	leave  
  801d27:	c3                   	ret    

00801d28 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d28:	55                   	push   %ebp
  801d29:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	6a 00                	push   $0x0
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 07                	push   $0x7
  801d37:	e8 ec fc ff ff       	call   801a28 <syscall>
  801d3c:	83 c4 18             	add    $0x18,%esp
}
  801d3f:	c9                   	leave  
  801d40:	c3                   	ret    

00801d41 <sys_exit_env>:


void sys_exit_env(void)
{
  801d41:	55                   	push   %ebp
  801d42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_exit_env, 0, 0, 0, 0, 0);
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 1c                	push   $0x1c
  801d50:	e8 d3 fc ff ff       	call   801a28 <syscall>
  801d55:	83 c4 18             	add    $0x18,%esp
}
  801d58:	90                   	nop
  801d59:	c9                   	leave  
  801d5a:	c3                   	ret    

00801d5b <sys_move_user_mem>:

// 2014
void sys_move_user_mem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d5b:	55                   	push   %ebp
  801d5c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_move_user_mem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	ff 75 10             	pushl  0x10(%ebp)
  801d65:	ff 75 0c             	pushl  0xc(%ebp)
  801d68:	ff 75 08             	pushl  0x8(%ebp)
  801d6b:	6a 13                	push   $0x13
  801d6d:	e8 b6 fc ff ff       	call   801a28 <syscall>
  801d72:	83 c4 18             	add    $0x18,%esp
	return ;
  801d75:	90                   	nop
}
  801d76:	c9                   	leave  
  801d77:	c3                   	ret    

00801d78 <sys_rcr2>:
uint32 sys_rcr2()
{
  801d78:	55                   	push   %ebp
  801d79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 1e                	push   $0x1e
  801d87:	e8 9c fc ff ff       	call   801a28 <syscall>
  801d8c:	83 c4 18             	add    $0x18,%esp
}
  801d8f:	c9                   	leave  
  801d90:	c3                   	ret    

00801d91 <sys_bypassPageFault>:

void sys_bypassPageFault(uint8 instrLength)
{
  801d91:	55                   	push   %ebp
  801d92:	89 e5                	mov    %esp,%ebp
  801d94:	83 ec 04             	sub    $0x4,%esp
  801d97:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d9d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	50                   	push   %eax
  801daa:	6a 1f                	push   $0x1f
  801dac:	e8 77 fc ff ff       	call   801a28 <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
	return ;
  801db4:	90                   	nop
}
  801db5:	c9                   	leave  
  801db6:	c3                   	ret    

00801db7 <rsttst>:
void rsttst()
{
  801db7:	55                   	push   %ebp
  801db8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 21                	push   $0x21
  801dc6:	e8 5d fc ff ff       	call   801a28 <syscall>
  801dcb:	83 c4 18             	add    $0x18,%esp
	return ;
  801dce:	90                   	nop
}
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
  801dd4:	83 ec 04             	sub    $0x4,%esp
  801dd7:	8b 45 14             	mov    0x14(%ebp),%eax
  801dda:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ddd:	8b 55 18             	mov    0x18(%ebp),%edx
  801de0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801de4:	52                   	push   %edx
  801de5:	50                   	push   %eax
  801de6:	ff 75 10             	pushl  0x10(%ebp)
  801de9:	ff 75 0c             	pushl  0xc(%ebp)
  801dec:	ff 75 08             	pushl  0x8(%ebp)
  801def:	6a 20                	push   $0x20
  801df1:	e8 32 fc ff ff       	call   801a28 <syscall>
  801df6:	83 c4 18             	add    $0x18,%esp
	return ;
  801df9:	90                   	nop
}
  801dfa:	c9                   	leave  
  801dfb:	c3                   	ret    

00801dfc <chktst>:
void chktst(uint32 n)
{
  801dfc:	55                   	push   %ebp
  801dfd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	ff 75 08             	pushl  0x8(%ebp)
  801e0a:	6a 22                	push   $0x22
  801e0c:	e8 17 fc ff ff       	call   801a28 <syscall>
  801e11:	83 c4 18             	add    $0x18,%esp
	return ;
  801e14:	90                   	nop
}
  801e15:	c9                   	leave  
  801e16:	c3                   	ret    

00801e17 <inctst>:

void inctst()
{
  801e17:	55                   	push   %ebp
  801e18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 23                	push   $0x23
  801e26:	e8 fd fb ff ff       	call   801a28 <syscall>
  801e2b:	83 c4 18             	add    $0x18,%esp
	return ;
  801e2e:	90                   	nop
}
  801e2f:	c9                   	leave  
  801e30:	c3                   	ret    

00801e31 <gettst>:
uint32 gettst()
{
  801e31:	55                   	push   %ebp
  801e32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 24                	push   $0x24
  801e40:	e8 e3 fb ff ff       	call   801a28 <syscall>
  801e45:	83 c4 18             	add    $0x18,%esp
}
  801e48:	c9                   	leave  
  801e49:	c3                   	ret    

00801e4a <sys_get_uheap_strategy>:

/*2025*/
uint32 sys_get_uheap_strategy()
{
  801e4a:	55                   	push   %ebp
  801e4b:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 25                	push   $0x25
  801e59:	e8 ca fb ff ff       	call   801a28 <syscall>
  801e5e:	83 c4 18             	add    $0x18,%esp
  801e61:	a3 88 b0 81 00       	mov    %eax,0x81b088
	return uheapPlaceStrategy ;
  801e66:	a1 88 b0 81 00       	mov    0x81b088,%eax
}
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
	uheapPlaceStrategy = heapStrategy;
  801e70:	8b 45 08             	mov    0x8(%ebp),%eax
  801e73:	a3 88 b0 81 00       	mov    %eax,0x81b088
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	ff 75 08             	pushl  0x8(%ebp)
  801e83:	6a 26                	push   $0x26
  801e85:	e8 9e fb ff ff       	call   801a28 <syscall>
  801e8a:	83 c4 18             	add    $0x18,%esp
	return ;
  801e8d:	90                   	nop
}
  801e8e:	c9                   	leave  
  801e8f:	c3                   	ret    

00801e90 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e90:	55                   	push   %ebp
  801e91:	89 e5                	mov    %esp,%ebp
  801e93:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e94:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e97:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea0:	6a 00                	push   $0x0
  801ea2:	53                   	push   %ebx
  801ea3:	51                   	push   %ecx
  801ea4:	52                   	push   %edx
  801ea5:	50                   	push   %eax
  801ea6:	6a 27                	push   $0x27
  801ea8:	e8 7b fb ff ff       	call   801a28 <syscall>
  801ead:	83 c4 18             	add    $0x18,%esp
}
  801eb0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801eb3:	c9                   	leave  
  801eb4:	c3                   	ret    

00801eb5 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801eb5:	55                   	push   %ebp
  801eb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801eb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	52                   	push   %edx
  801ec5:	50                   	push   %eax
  801ec6:	6a 28                	push   $0x28
  801ec8:	e8 5b fb ff ff       	call   801a28 <syscall>
  801ecd:	83 c4 18             	add    $0x18,%esp
}
  801ed0:	c9                   	leave  
  801ed1:	c3                   	ret    

00801ed2 <sys_check_WS_list>:

int sys_check_WS_list(uint32* WS_list_content, int actual_WS_list_size, uint32 last_WS_element_content, bool chk_in_order)
{
  801ed2:	55                   	push   %ebp
  801ed3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_WS_list, (uint32)WS_list_content, (uint32)actual_WS_list_size , last_WS_element_content, (uint32)chk_in_order, 0);
  801ed5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ed8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801edb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ede:	6a 00                	push   $0x0
  801ee0:	51                   	push   %ecx
  801ee1:	ff 75 10             	pushl  0x10(%ebp)
  801ee4:	52                   	push   %edx
  801ee5:	50                   	push   %eax
  801ee6:	6a 29                	push   $0x29
  801ee8:	e8 3b fb ff ff       	call   801a28 <syscall>
  801eed:	83 c4 18             	add    $0x18,%esp
}
  801ef0:	c9                   	leave  
  801ef1:	c3                   	ret    

00801ef2 <sys_allocate_chunk>:
void sys_allocate_chunk(uint32 virtual_address, uint32 size, uint32 perms)
{
  801ef2:	55                   	push   %ebp
  801ef3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_chunk_in_mem, virtual_address, size, perms, 0, 0);
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	ff 75 10             	pushl  0x10(%ebp)
  801efc:	ff 75 0c             	pushl  0xc(%ebp)
  801eff:	ff 75 08             	pushl  0x8(%ebp)
  801f02:	6a 12                	push   $0x12
  801f04:	e8 1f fb ff ff       	call   801a28 <syscall>
  801f09:	83 c4 18             	add    $0x18,%esp
	return ;
  801f0c:	90                   	nop
}
  801f0d:	c9                   	leave  
  801f0e:	c3                   	ret    

00801f0f <sys_utilities>:
void sys_utilities(char* utilityName, int value)
{
  801f0f:	55                   	push   %ebp
  801f10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_utilities, (uint32)utilityName, value, 0, 0, 0);
  801f12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f15:	8b 45 08             	mov    0x8(%ebp),%eax
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	52                   	push   %edx
  801f1f:	50                   	push   %eax
  801f20:	6a 2a                	push   $0x2a
  801f22:	e8 01 fb ff ff       	call   801a28 <syscall>
  801f27:	83 c4 18             	add    $0x18,%esp
	return;
  801f2a:	90                   	nop
}
  801f2b:	c9                   	leave  
  801f2c:	c3                   	ret    

00801f2d <sys_get_optimal_num_faults>:
/*2025*/
int sys_get_optimal_num_faults()
{
  801f2d:	55                   	push   %ebp
  801f2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_optimal_num_faults, 0, 0, 0, 0, 0);
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 2b                	push   $0x2b
  801f3c:	e8 e7 fa ff ff       	call   801a28 <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
}
  801f44:	c9                   	leave  
  801f45:	c3                   	ret    

00801f46 <sys_sbrk>:

void* sys_sbrk(int numOfPages)
{
  801f46:	55                   	push   %ebp
  801f47:	89 e5                	mov    %esp,%ebp
  801f49:	83 ec 08             	sub    $0x8,%esp
	panic("not implemented");
  801f4c:	83 ec 04             	sub    $0x4,%esp
  801f4f:	68 08 2d 80 00       	push   $0x802d08
  801f54:	68 0a 01 00 00       	push   $0x10a
  801f59:	68 18 2d 80 00       	push   $0x802d18
  801f5e:	e8 12 e9 ff ff       	call   800875 <_panic>

00801f63 <sys_free_user_mem>:
}

void sys_free_user_mem(uint32 virtual_address, uint32 size)
{
  801f63:	55                   	push   %ebp
  801f64:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_user_mem, virtual_address, size, 0, 0, 0);
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 00                	push   $0x0
  801f6c:	ff 75 0c             	pushl  0xc(%ebp)
  801f6f:	ff 75 08             	pushl  0x8(%ebp)
  801f72:	6a 33                	push   $0x33
  801f74:	e8 af fa ff ff       	call   801a28 <syscall>
  801f79:	83 c4 18             	add    $0x18,%esp
	return;
  801f7c:	90                   	nop
}
  801f7d:	c9                   	leave  
  801f7e:	c3                   	ret    

00801f7f <sys_allocate_user_mem>:

void sys_allocate_user_mem(uint32 virtual_address, uint32 size)
{
  801f7f:	55                   	push   %ebp
  801f80:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocate_user_mem, virtual_address, size, 0, 0, 0);
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	ff 75 0c             	pushl  0xc(%ebp)
  801f8b:	ff 75 08             	pushl  0x8(%ebp)
  801f8e:	6a 34                	push   $0x34
  801f90:	e8 93 fa ff ff       	call   801a28 <syscall>
  801f95:	83 c4 18             	add    $0x18,%esp
	return ;
  801f98:	90                   	nop
}
  801f99:	c9                   	leave  
  801f9a:	c3                   	ret    
  801f9b:	90                   	nop

00801f9c <__udivdi3>:
  801f9c:	55                   	push   %ebp
  801f9d:	57                   	push   %edi
  801f9e:	56                   	push   %esi
  801f9f:	53                   	push   %ebx
  801fa0:	83 ec 1c             	sub    $0x1c,%esp
  801fa3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801fa7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801fab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801faf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801fb3:	89 ca                	mov    %ecx,%edx
  801fb5:	89 f8                	mov    %edi,%eax
  801fb7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801fbb:	85 f6                	test   %esi,%esi
  801fbd:	75 2d                	jne    801fec <__udivdi3+0x50>
  801fbf:	39 cf                	cmp    %ecx,%edi
  801fc1:	77 65                	ja     802028 <__udivdi3+0x8c>
  801fc3:	89 fd                	mov    %edi,%ebp
  801fc5:	85 ff                	test   %edi,%edi
  801fc7:	75 0b                	jne    801fd4 <__udivdi3+0x38>
  801fc9:	b8 01 00 00 00       	mov    $0x1,%eax
  801fce:	31 d2                	xor    %edx,%edx
  801fd0:	f7 f7                	div    %edi
  801fd2:	89 c5                	mov    %eax,%ebp
  801fd4:	31 d2                	xor    %edx,%edx
  801fd6:	89 c8                	mov    %ecx,%eax
  801fd8:	f7 f5                	div    %ebp
  801fda:	89 c1                	mov    %eax,%ecx
  801fdc:	89 d8                	mov    %ebx,%eax
  801fde:	f7 f5                	div    %ebp
  801fe0:	89 cf                	mov    %ecx,%edi
  801fe2:	89 fa                	mov    %edi,%edx
  801fe4:	83 c4 1c             	add    $0x1c,%esp
  801fe7:	5b                   	pop    %ebx
  801fe8:	5e                   	pop    %esi
  801fe9:	5f                   	pop    %edi
  801fea:	5d                   	pop    %ebp
  801feb:	c3                   	ret    
  801fec:	39 ce                	cmp    %ecx,%esi
  801fee:	77 28                	ja     802018 <__udivdi3+0x7c>
  801ff0:	0f bd fe             	bsr    %esi,%edi
  801ff3:	83 f7 1f             	xor    $0x1f,%edi
  801ff6:	75 40                	jne    802038 <__udivdi3+0x9c>
  801ff8:	39 ce                	cmp    %ecx,%esi
  801ffa:	72 0a                	jb     802006 <__udivdi3+0x6a>
  801ffc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802000:	0f 87 9e 00 00 00    	ja     8020a4 <__udivdi3+0x108>
  802006:	b8 01 00 00 00       	mov    $0x1,%eax
  80200b:	89 fa                	mov    %edi,%edx
  80200d:	83 c4 1c             	add    $0x1c,%esp
  802010:	5b                   	pop    %ebx
  802011:	5e                   	pop    %esi
  802012:	5f                   	pop    %edi
  802013:	5d                   	pop    %ebp
  802014:	c3                   	ret    
  802015:	8d 76 00             	lea    0x0(%esi),%esi
  802018:	31 ff                	xor    %edi,%edi
  80201a:	31 c0                	xor    %eax,%eax
  80201c:	89 fa                	mov    %edi,%edx
  80201e:	83 c4 1c             	add    $0x1c,%esp
  802021:	5b                   	pop    %ebx
  802022:	5e                   	pop    %esi
  802023:	5f                   	pop    %edi
  802024:	5d                   	pop    %ebp
  802025:	c3                   	ret    
  802026:	66 90                	xchg   %ax,%ax
  802028:	89 d8                	mov    %ebx,%eax
  80202a:	f7 f7                	div    %edi
  80202c:	31 ff                	xor    %edi,%edi
  80202e:	89 fa                	mov    %edi,%edx
  802030:	83 c4 1c             	add    $0x1c,%esp
  802033:	5b                   	pop    %ebx
  802034:	5e                   	pop    %esi
  802035:	5f                   	pop    %edi
  802036:	5d                   	pop    %ebp
  802037:	c3                   	ret    
  802038:	bd 20 00 00 00       	mov    $0x20,%ebp
  80203d:	89 eb                	mov    %ebp,%ebx
  80203f:	29 fb                	sub    %edi,%ebx
  802041:	89 f9                	mov    %edi,%ecx
  802043:	d3 e6                	shl    %cl,%esi
  802045:	89 c5                	mov    %eax,%ebp
  802047:	88 d9                	mov    %bl,%cl
  802049:	d3 ed                	shr    %cl,%ebp
  80204b:	89 e9                	mov    %ebp,%ecx
  80204d:	09 f1                	or     %esi,%ecx
  80204f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802053:	89 f9                	mov    %edi,%ecx
  802055:	d3 e0                	shl    %cl,%eax
  802057:	89 c5                	mov    %eax,%ebp
  802059:	89 d6                	mov    %edx,%esi
  80205b:	88 d9                	mov    %bl,%cl
  80205d:	d3 ee                	shr    %cl,%esi
  80205f:	89 f9                	mov    %edi,%ecx
  802061:	d3 e2                	shl    %cl,%edx
  802063:	8b 44 24 08          	mov    0x8(%esp),%eax
  802067:	88 d9                	mov    %bl,%cl
  802069:	d3 e8                	shr    %cl,%eax
  80206b:	09 c2                	or     %eax,%edx
  80206d:	89 d0                	mov    %edx,%eax
  80206f:	89 f2                	mov    %esi,%edx
  802071:	f7 74 24 0c          	divl   0xc(%esp)
  802075:	89 d6                	mov    %edx,%esi
  802077:	89 c3                	mov    %eax,%ebx
  802079:	f7 e5                	mul    %ebp
  80207b:	39 d6                	cmp    %edx,%esi
  80207d:	72 19                	jb     802098 <__udivdi3+0xfc>
  80207f:	74 0b                	je     80208c <__udivdi3+0xf0>
  802081:	89 d8                	mov    %ebx,%eax
  802083:	31 ff                	xor    %edi,%edi
  802085:	e9 58 ff ff ff       	jmp    801fe2 <__udivdi3+0x46>
  80208a:	66 90                	xchg   %ax,%ax
  80208c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802090:	89 f9                	mov    %edi,%ecx
  802092:	d3 e2                	shl    %cl,%edx
  802094:	39 c2                	cmp    %eax,%edx
  802096:	73 e9                	jae    802081 <__udivdi3+0xe5>
  802098:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80209b:	31 ff                	xor    %edi,%edi
  80209d:	e9 40 ff ff ff       	jmp    801fe2 <__udivdi3+0x46>
  8020a2:	66 90                	xchg   %ax,%ax
  8020a4:	31 c0                	xor    %eax,%eax
  8020a6:	e9 37 ff ff ff       	jmp    801fe2 <__udivdi3+0x46>
  8020ab:	90                   	nop

008020ac <__umoddi3>:
  8020ac:	55                   	push   %ebp
  8020ad:	57                   	push   %edi
  8020ae:	56                   	push   %esi
  8020af:	53                   	push   %ebx
  8020b0:	83 ec 1c             	sub    $0x1c,%esp
  8020b3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8020b7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8020bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020bf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8020c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8020c7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8020cb:	89 f3                	mov    %esi,%ebx
  8020cd:	89 fa                	mov    %edi,%edx
  8020cf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020d3:	89 34 24             	mov    %esi,(%esp)
  8020d6:	85 c0                	test   %eax,%eax
  8020d8:	75 1a                	jne    8020f4 <__umoddi3+0x48>
  8020da:	39 f7                	cmp    %esi,%edi
  8020dc:	0f 86 a2 00 00 00    	jbe    802184 <__umoddi3+0xd8>
  8020e2:	89 c8                	mov    %ecx,%eax
  8020e4:	89 f2                	mov    %esi,%edx
  8020e6:	f7 f7                	div    %edi
  8020e8:	89 d0                	mov    %edx,%eax
  8020ea:	31 d2                	xor    %edx,%edx
  8020ec:	83 c4 1c             	add    $0x1c,%esp
  8020ef:	5b                   	pop    %ebx
  8020f0:	5e                   	pop    %esi
  8020f1:	5f                   	pop    %edi
  8020f2:	5d                   	pop    %ebp
  8020f3:	c3                   	ret    
  8020f4:	39 f0                	cmp    %esi,%eax
  8020f6:	0f 87 ac 00 00 00    	ja     8021a8 <__umoddi3+0xfc>
  8020fc:	0f bd e8             	bsr    %eax,%ebp
  8020ff:	83 f5 1f             	xor    $0x1f,%ebp
  802102:	0f 84 ac 00 00 00    	je     8021b4 <__umoddi3+0x108>
  802108:	bf 20 00 00 00       	mov    $0x20,%edi
  80210d:	29 ef                	sub    %ebp,%edi
  80210f:	89 fe                	mov    %edi,%esi
  802111:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802115:	89 e9                	mov    %ebp,%ecx
  802117:	d3 e0                	shl    %cl,%eax
  802119:	89 d7                	mov    %edx,%edi
  80211b:	89 f1                	mov    %esi,%ecx
  80211d:	d3 ef                	shr    %cl,%edi
  80211f:	09 c7                	or     %eax,%edi
  802121:	89 e9                	mov    %ebp,%ecx
  802123:	d3 e2                	shl    %cl,%edx
  802125:	89 14 24             	mov    %edx,(%esp)
  802128:	89 d8                	mov    %ebx,%eax
  80212a:	d3 e0                	shl    %cl,%eax
  80212c:	89 c2                	mov    %eax,%edx
  80212e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802132:	d3 e0                	shl    %cl,%eax
  802134:	89 44 24 04          	mov    %eax,0x4(%esp)
  802138:	8b 44 24 08          	mov    0x8(%esp),%eax
  80213c:	89 f1                	mov    %esi,%ecx
  80213e:	d3 e8                	shr    %cl,%eax
  802140:	09 d0                	or     %edx,%eax
  802142:	d3 eb                	shr    %cl,%ebx
  802144:	89 da                	mov    %ebx,%edx
  802146:	f7 f7                	div    %edi
  802148:	89 d3                	mov    %edx,%ebx
  80214a:	f7 24 24             	mull   (%esp)
  80214d:	89 c6                	mov    %eax,%esi
  80214f:	89 d1                	mov    %edx,%ecx
  802151:	39 d3                	cmp    %edx,%ebx
  802153:	0f 82 87 00 00 00    	jb     8021e0 <__umoddi3+0x134>
  802159:	0f 84 91 00 00 00    	je     8021f0 <__umoddi3+0x144>
  80215f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802163:	29 f2                	sub    %esi,%edx
  802165:	19 cb                	sbb    %ecx,%ebx
  802167:	89 d8                	mov    %ebx,%eax
  802169:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80216d:	d3 e0                	shl    %cl,%eax
  80216f:	89 e9                	mov    %ebp,%ecx
  802171:	d3 ea                	shr    %cl,%edx
  802173:	09 d0                	or     %edx,%eax
  802175:	89 e9                	mov    %ebp,%ecx
  802177:	d3 eb                	shr    %cl,%ebx
  802179:	89 da                	mov    %ebx,%edx
  80217b:	83 c4 1c             	add    $0x1c,%esp
  80217e:	5b                   	pop    %ebx
  80217f:	5e                   	pop    %esi
  802180:	5f                   	pop    %edi
  802181:	5d                   	pop    %ebp
  802182:	c3                   	ret    
  802183:	90                   	nop
  802184:	89 fd                	mov    %edi,%ebp
  802186:	85 ff                	test   %edi,%edi
  802188:	75 0b                	jne    802195 <__umoddi3+0xe9>
  80218a:	b8 01 00 00 00       	mov    $0x1,%eax
  80218f:	31 d2                	xor    %edx,%edx
  802191:	f7 f7                	div    %edi
  802193:	89 c5                	mov    %eax,%ebp
  802195:	89 f0                	mov    %esi,%eax
  802197:	31 d2                	xor    %edx,%edx
  802199:	f7 f5                	div    %ebp
  80219b:	89 c8                	mov    %ecx,%eax
  80219d:	f7 f5                	div    %ebp
  80219f:	89 d0                	mov    %edx,%eax
  8021a1:	e9 44 ff ff ff       	jmp    8020ea <__umoddi3+0x3e>
  8021a6:	66 90                	xchg   %ax,%ax
  8021a8:	89 c8                	mov    %ecx,%eax
  8021aa:	89 f2                	mov    %esi,%edx
  8021ac:	83 c4 1c             	add    $0x1c,%esp
  8021af:	5b                   	pop    %ebx
  8021b0:	5e                   	pop    %esi
  8021b1:	5f                   	pop    %edi
  8021b2:	5d                   	pop    %ebp
  8021b3:	c3                   	ret    
  8021b4:	3b 04 24             	cmp    (%esp),%eax
  8021b7:	72 06                	jb     8021bf <__umoddi3+0x113>
  8021b9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8021bd:	77 0f                	ja     8021ce <__umoddi3+0x122>
  8021bf:	89 f2                	mov    %esi,%edx
  8021c1:	29 f9                	sub    %edi,%ecx
  8021c3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8021c7:	89 14 24             	mov    %edx,(%esp)
  8021ca:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021ce:	8b 44 24 04          	mov    0x4(%esp),%eax
  8021d2:	8b 14 24             	mov    (%esp),%edx
  8021d5:	83 c4 1c             	add    $0x1c,%esp
  8021d8:	5b                   	pop    %ebx
  8021d9:	5e                   	pop    %esi
  8021da:	5f                   	pop    %edi
  8021db:	5d                   	pop    %ebp
  8021dc:	c3                   	ret    
  8021dd:	8d 76 00             	lea    0x0(%esi),%esi
  8021e0:	2b 04 24             	sub    (%esp),%eax
  8021e3:	19 fa                	sbb    %edi,%edx
  8021e5:	89 d1                	mov    %edx,%ecx
  8021e7:	89 c6                	mov    %eax,%esi
  8021e9:	e9 71 ff ff ff       	jmp    80215f <__umoddi3+0xb3>
  8021ee:	66 90                	xchg   %ax,%ax
  8021f0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8021f4:	72 ea                	jb     8021e0 <__umoddi3+0x134>
  8021f6:	89 d9                	mov    %ebx,%ecx
  8021f8:	e9 62 ff ff ff       	jmp    80215f <__umoddi3+0xb3>
