
obj/user/tst_page_replacement_FIFO_2_oldBuggyOne:     file format elf32-i386


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
  800031:	e8 97 08 00 00       	call   8008cd <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
uint8* ptr = (uint8* )0x0801000 ;
uint8* ptr2 = (uint8* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec b8 00 00 00    	sub    $0xb8,%esp
	
//	cprintf("envID = %d\n",envID);

	
	
	char* tempArr = (char*)0x80000000;
  800041:	c7 45 ec 00 00 00 80 	movl   $0x80000000,-0x14(%ebp)
	//sys_allocateMem(0x80000000, 15*1024);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800048:	a1 20 30 80 00       	mov    0x803020,%eax
  80004d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800053:	8b 00                	mov    (%eax),%eax
  800055:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800058:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80005b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800060:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800065:	74 14                	je     80007b <_main+0x43>
  800067:	83 ec 04             	sub    $0x4,%esp
  80006a:	68 00 23 80 00       	push   $0x802300
  80006f:	6a 17                	push   $0x17
  800071:	68 44 23 80 00       	push   $0x802344
  800076:	e8 97 09 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80007b:	a1 20 30 80 00       	mov    0x803020,%eax
  800080:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800086:	83 c0 10             	add    $0x10,%eax
  800089:	8b 00                	mov    (%eax),%eax
  80008b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80008e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800091:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800096:	3d 00 10 20 00       	cmp    $0x201000,%eax
  80009b:	74 14                	je     8000b1 <_main+0x79>
  80009d:	83 ec 04             	sub    $0x4,%esp
  8000a0:	68 00 23 80 00       	push   $0x802300
  8000a5:	6a 18                	push   $0x18
  8000a7:	68 44 23 80 00       	push   $0x802344
  8000ac:	e8 61 09 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000bc:	83 c0 20             	add    $0x20,%eax
  8000bf:	8b 00                	mov    (%eax),%eax
  8000c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  8000c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000c7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000cc:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000d1:	74 14                	je     8000e7 <_main+0xaf>
  8000d3:	83 ec 04             	sub    $0x4,%esp
  8000d6:	68 00 23 80 00       	push   $0x802300
  8000db:	6a 19                	push   $0x19
  8000dd:	68 44 23 80 00       	push   $0x802344
  8000e2:	e8 2b 09 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ec:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000f2:	83 c0 30             	add    $0x30,%eax
  8000f5:	8b 00                	mov    (%eax),%eax
  8000f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8000fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800102:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800107:	74 14                	je     80011d <_main+0xe5>
  800109:	83 ec 04             	sub    $0x4,%esp
  80010c:	68 00 23 80 00       	push   $0x802300
  800111:	6a 1a                	push   $0x1a
  800113:	68 44 23 80 00       	push   $0x802344
  800118:	e8 f5 08 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80011d:	a1 20 30 80 00       	mov    0x803020,%eax
  800122:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800128:	83 c0 40             	add    $0x40,%eax
  80012b:	8b 00                	mov    (%eax),%eax
  80012d:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800130:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800133:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800138:	3d 00 40 20 00       	cmp    $0x204000,%eax
  80013d:	74 14                	je     800153 <_main+0x11b>
  80013f:	83 ec 04             	sub    $0x4,%esp
  800142:	68 00 23 80 00       	push   $0x802300
  800147:	6a 1b                	push   $0x1b
  800149:	68 44 23 80 00       	push   $0x802344
  80014e:	e8 bf 08 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800153:	a1 20 30 80 00       	mov    0x803020,%eax
  800158:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80015e:	83 c0 50             	add    $0x50,%eax
  800161:	8b 00                	mov    (%eax),%eax
  800163:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800166:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800169:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80016e:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800173:	74 14                	je     800189 <_main+0x151>
  800175:	83 ec 04             	sub    $0x4,%esp
  800178:	68 00 23 80 00       	push   $0x802300
  80017d:	6a 1c                	push   $0x1c
  80017f:	68 44 23 80 00       	push   $0x802344
  800184:	e8 89 08 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800189:	a1 20 30 80 00       	mov    0x803020,%eax
  80018e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800194:	83 c0 60             	add    $0x60,%eax
  800197:	8b 00                	mov    (%eax),%eax
  800199:	89 45 d0             	mov    %eax,-0x30(%ebp)
  80019c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80019f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a4:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a9:	74 14                	je     8001bf <_main+0x187>
  8001ab:	83 ec 04             	sub    $0x4,%esp
  8001ae:	68 00 23 80 00       	push   $0x802300
  8001b3:	6a 1d                	push   $0x1d
  8001b5:	68 44 23 80 00       	push   $0x802344
  8001ba:	e8 53 08 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001ca:	83 c0 70             	add    $0x70,%eax
  8001cd:	8b 00                	mov    (%eax),%eax
  8001cf:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001d2:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001da:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001df:	74 14                	je     8001f5 <_main+0x1bd>
  8001e1:	83 ec 04             	sub    $0x4,%esp
  8001e4:	68 00 23 80 00       	push   $0x802300
  8001e9:	6a 1e                	push   $0x1e
  8001eb:	68 44 23 80 00       	push   $0x802344
  8001f0:	e8 1d 08 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fa:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800200:	83 e8 80             	sub    $0xffffff80,%eax
  800203:	8b 00                	mov    (%eax),%eax
  800205:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800208:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80020b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800210:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800215:	74 14                	je     80022b <_main+0x1f3>
  800217:	83 ec 04             	sub    $0x4,%esp
  80021a:	68 00 23 80 00       	push   $0x802300
  80021f:	6a 1f                	push   $0x1f
  800221:	68 44 23 80 00       	push   $0x802344
  800226:	e8 e7 07 00 00       	call   800a12 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80022b:	a1 20 30 80 00       	mov    0x803020,%eax
  800230:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  800236:	85 c0                	test   %eax,%eax
  800238:	74 14                	je     80024e <_main+0x216>
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	68 74 23 80 00       	push   $0x802374
  800242:	6a 20                	push   $0x20
  800244:	68 44 23 80 00       	push   $0x802344
  800249:	e8 c4 07 00 00       	call   800a12 <_panic>
	}

	int freePages = sys_calculate_free_frames();
  80024e:	e8 57 19 00 00       	call   801baa <sys_calculate_free_frames>
  800253:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  800256:	e8 d2 19 00 00       	call   801c2d <sys_pf_calculate_allocated_pages>
  80025b:	89 45 c0             	mov    %eax,-0x40(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1];
  80025e:	a0 3f e0 80 00       	mov    0x80e03f,%al
  800263:	88 45 bf             	mov    %al,-0x41(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1];
  800266:	a0 3f f0 80 00       	mov    0x80f03f,%al
  80026b:	88 45 be             	mov    %al,-0x42(%ebp)

	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*5 ; i+=PAGE_SIZE/2)
  80026e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800275:	eb 37                	jmp    8002ae <_main+0x276>
	{
		arr[i] = -1 ;
  800277:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80027a:	05 40 30 80 00       	add    $0x803040,%eax
  80027f:	c6 00 ff             	movb   $0xff,(%eax)
		*ptr = *ptr2 ;
  800282:	a1 00 30 80 00       	mov    0x803000,%eax
  800287:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80028d:	8a 12                	mov    (%edx),%dl
  80028f:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  800291:	a1 00 30 80 00       	mov    0x803000,%eax
  800296:	40                   	inc    %eax
  800297:	a3 00 30 80 00       	mov    %eax,0x803000
  80029c:	a1 04 30 80 00       	mov    0x803004,%eax
  8002a1:	40                   	inc    %eax
  8002a2:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1];
	char garbage2 = arr[PAGE_SIZE*12-1];

	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*5 ; i+=PAGE_SIZE/2)
  8002a7:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8002ae:	81 7d f4 ff 4f 00 00 	cmpl   $0x4fff,-0xc(%ebp)
  8002b5:	7e c0                	jle    800277 <_main+0x23f>
		ptr++ ; ptr2++ ;
	}

	//Check FIFO 1
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8002b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002bc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002c2:	8b 00                	mov    (%eax),%eax
  8002c4:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8002c7:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8002ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002cf:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8002d4:	74 14                	je     8002ea <_main+0x2b2>
  8002d6:	83 ec 04             	sub    $0x4,%esp
  8002d9:	68 bc 23 80 00       	push   $0x8023bc
  8002de:	6a 35                	push   $0x35
  8002e0:	68 44 23 80 00       	push   $0x802344
  8002e5:	e8 28 07 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80f000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8002ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ef:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002f5:	83 c0 10             	add    $0x10,%eax
  8002f8:	8b 00                	mov    (%eax),%eax
  8002fa:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8002fd:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800300:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800305:	3d 00 f0 80 00       	cmp    $0x80f000,%eax
  80030a:	74 14                	je     800320 <_main+0x2e8>
  80030c:	83 ec 04             	sub    $0x4,%esp
  80030f:	68 bc 23 80 00       	push   $0x8023bc
  800314:	6a 36                	push   $0x36
  800316:	68 44 23 80 00       	push   $0x802344
  80031b:	e8 f2 06 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800320:	a1 20 30 80 00       	mov    0x803020,%eax
  800325:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80032b:	83 c0 20             	add    $0x20,%eax
  80032e:	8b 00                	mov    (%eax),%eax
  800330:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800333:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800336:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80033b:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800340:	74 14                	je     800356 <_main+0x31e>
  800342:	83 ec 04             	sub    $0x4,%esp
  800345:	68 bc 23 80 00       	push   $0x8023bc
  80034a:	6a 37                	push   $0x37
  80034c:	68 44 23 80 00       	push   $0x802344
  800351:	e8 bc 06 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800356:	a1 20 30 80 00       	mov    0x803020,%eax
  80035b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800361:	83 c0 30             	add    $0x30,%eax
  800364:	8b 00                	mov    (%eax),%eax
  800366:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800369:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80036c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800371:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800376:	74 14                	je     80038c <_main+0x354>
  800378:	83 ec 04             	sub    $0x4,%esp
  80037b:	68 bc 23 80 00       	push   $0x8023bc
  800380:	6a 38                	push   $0x38
  800382:	68 44 23 80 00       	push   $0x802344
  800387:	e8 86 06 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x805000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80038c:	a1 20 30 80 00       	mov    0x803020,%eax
  800391:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800397:	83 c0 40             	add    $0x40,%eax
  80039a:	8b 00                	mov    (%eax),%eax
  80039c:	89 45 a8             	mov    %eax,-0x58(%ebp)
  80039f:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003a7:	3d 00 50 80 00       	cmp    $0x805000,%eax
  8003ac:	74 14                	je     8003c2 <_main+0x38a>
  8003ae:	83 ec 04             	sub    $0x4,%esp
  8003b1:	68 bc 23 80 00       	push   $0x8023bc
  8003b6:	6a 39                	push   $0x39
  8003b8:	68 44 23 80 00       	push   $0x802344
  8003bd:	e8 50 06 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x806000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003cd:	83 c0 50             	add    $0x50,%eax
  8003d0:	8b 00                	mov    (%eax),%eax
  8003d2:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8003d5:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003dd:	3d 00 60 80 00       	cmp    $0x806000,%eax
  8003e2:	74 14                	je     8003f8 <_main+0x3c0>
  8003e4:	83 ec 04             	sub    $0x4,%esp
  8003e7:	68 bc 23 80 00       	push   $0x8023bc
  8003ec:	6a 3a                	push   $0x3a
  8003ee:	68 44 23 80 00       	push   $0x802344
  8003f3:	e8 1a 06 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x807000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800403:	83 c0 60             	add    $0x60,%eax
  800406:	8b 00                	mov    (%eax),%eax
  800408:	89 45 a0             	mov    %eax,-0x60(%ebp)
  80040b:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80040e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800413:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800418:	74 14                	je     80042e <_main+0x3f6>
  80041a:	83 ec 04             	sub    $0x4,%esp
  80041d:	68 bc 23 80 00       	push   $0x8023bc
  800422:	6a 3b                	push   $0x3b
  800424:	68 44 23 80 00       	push   $0x802344
  800429:	e8 e4 05 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80042e:	a1 20 30 80 00       	mov    0x803020,%eax
  800433:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800439:	83 c0 70             	add    $0x70,%eax
  80043c:	8b 00                	mov    (%eax),%eax
  80043e:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800441:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800444:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800449:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80044e:	74 14                	je     800464 <_main+0x42c>
  800450:	83 ec 04             	sub    $0x4,%esp
  800453:	68 bc 23 80 00       	push   $0x8023bc
  800458:	6a 3c                	push   $0x3c
  80045a:	68 44 23 80 00       	push   $0x802344
  80045f:	e8 ae 05 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800464:	a1 20 30 80 00       	mov    0x803020,%eax
  800469:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80046f:	83 e8 80             	sub    $0xffffff80,%eax
  800472:	8b 00                	mov    (%eax),%eax
  800474:	89 45 98             	mov    %eax,-0x68(%ebp)
  800477:	8b 45 98             	mov    -0x68(%ebp),%eax
  80047a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80047f:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800484:	74 14                	je     80049a <_main+0x462>
  800486:	83 ec 04             	sub    $0x4,%esp
  800489:	68 bc 23 80 00       	push   $0x8023bc
  80048e:	6a 3d                	push   $0x3d
  800490:	68 44 23 80 00       	push   $0x802344
  800495:	e8 78 05 00 00       	call   800a12 <_panic>

		if(myEnv->page_last_WS_index != 1) panic("wrong PAGE WS pointer location");
  80049a:	a1 20 30 80 00       	mov    0x803020,%eax
  80049f:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  8004a5:	83 f8 01             	cmp    $0x1,%eax
  8004a8:	74 14                	je     8004be <_main+0x486>
  8004aa:	83 ec 04             	sub    $0x4,%esp
  8004ad:	68 08 24 80 00       	push   $0x802408
  8004b2:	6a 3f                	push   $0x3f
  8004b4:	68 44 23 80 00       	push   $0x802344
  8004b9:	e8 54 05 00 00       	call   800a12 <_panic>
	}

	sys_allocateMem(0x80000000, 4*PAGE_SIZE);
  8004be:	83 ec 08             	sub    $0x8,%esp
  8004c1:	68 00 40 00 00       	push   $0x4000
  8004c6:	68 00 00 00 80       	push   $0x80000000
  8004cb:	e8 41 17 00 00       	call   801c11 <sys_allocateMem>
  8004d0:	83 c4 10             	add    $0x10,%esp
	//cprintf("1\n");

	int c;
	for(c = 0;c< 15*1024;c++)
  8004d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004da:	eb 0e                	jmp    8004ea <_main+0x4b2>
	{
		tempArr[c] = 'a';
  8004dc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8004df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004e2:	01 d0                	add    %edx,%eax
  8004e4:	c6 00 61             	movb   $0x61,(%eax)

	sys_allocateMem(0x80000000, 4*PAGE_SIZE);
	//cprintf("1\n");

	int c;
	for(c = 0;c< 15*1024;c++)
  8004e7:	ff 45 f0             	incl   -0x10(%ebp)
  8004ea:	81 7d f0 ff 3b 00 00 	cmpl   $0x3bff,-0x10(%ebp)
  8004f1:	7e e9                	jle    8004dc <_main+0x4a4>
		tempArr[c] = 'a';
	}

	//cprintf("2\n");

	sys_freeMem(0x80000000, 4*PAGE_SIZE);
  8004f3:	83 ec 08             	sub    $0x8,%esp
  8004f6:	68 00 40 00 00       	push   $0x4000
  8004fb:	68 00 00 00 80       	push   $0x80000000
  800500:	e8 f0 16 00 00       	call   801bf5 <sys_freeMem>
  800505:	83 c4 10             	add    $0x10,%esp
	//cprintf("3\n");

	//Check after free either push records up or leave them empty
	for (i = PAGE_SIZE*5 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800508:	c7 45 f4 00 50 00 00 	movl   $0x5000,-0xc(%ebp)
  80050f:	eb 37                	jmp    800548 <_main+0x510>
	{
		arr[i] = -1 ;
  800511:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800514:	05 40 30 80 00       	add    $0x803040,%eax
  800519:	c6 00 ff             	movb   $0xff,(%eax)
		*ptr = *ptr2 ;
  80051c:	a1 00 30 80 00       	mov    0x803000,%eax
  800521:	8b 15 04 30 80 00    	mov    0x803004,%edx
  800527:	8a 12                	mov    (%edx),%dl
  800529:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  80052b:	a1 00 30 80 00       	mov    0x803000,%eax
  800530:	40                   	inc    %eax
  800531:	a3 00 30 80 00       	mov    %eax,0x803000
  800536:	a1 04 30 80 00       	mov    0x803004,%eax
  80053b:	40                   	inc    %eax
  80053c:	a3 04 30 80 00       	mov    %eax,0x803004

	sys_freeMem(0x80000000, 4*PAGE_SIZE);
	//cprintf("3\n");

	//Check after free either push records up or leave them empty
	for (i = PAGE_SIZE*5 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800541:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800548:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80054f:	7e c0                	jle    800511 <_main+0x4d9>
	//cprintf("4\n");

	//===================
	//cprintf("Checking PAGE FIFO algorithm after Free and replacement... \n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800551:	a1 20 30 80 00       	mov    0x803020,%eax
  800556:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80055c:	8b 00                	mov    (%eax),%eax
  80055e:	89 45 94             	mov    %eax,-0x6c(%ebp)
  800561:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800564:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800569:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  80056e:	74 14                	je     800584 <_main+0x54c>
  800570:	83 ec 04             	sub    $0x4,%esp
  800573:	68 bc 23 80 00       	push   $0x8023bc
  800578:	6a 5c                	push   $0x5c
  80057a:	68 44 23 80 00       	push   $0x802344
  80057f:	e8 8e 04 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0xeebfd000 && ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x801000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800584:	a1 20 30 80 00       	mov    0x803020,%eax
  800589:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80058f:	83 c0 10             	add    $0x10,%eax
  800592:	8b 00                	mov    (%eax),%eax
  800594:	89 45 90             	mov    %eax,-0x70(%ebp)
  800597:	8b 45 90             	mov    -0x70(%ebp),%eax
  80059a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80059f:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8005a4:	74 36                	je     8005dc <_main+0x5a4>
  8005a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ab:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005b1:	83 c0 10             	add    $0x10,%eax
  8005b4:	8b 00                	mov    (%eax),%eax
  8005b6:	89 45 8c             	mov    %eax,-0x74(%ebp)
  8005b9:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8005bc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005c1:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8005c6:	74 14                	je     8005dc <_main+0x5a4>
  8005c8:	83 ec 04             	sub    $0x4,%esp
  8005cb:	68 bc 23 80 00       	push   $0x8023bc
  8005d0:	6a 5d                	push   $0x5d
  8005d2:	68 44 23 80 00       	push   $0x802344
  8005d7:	e8 36 04 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x80b000 && ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x803000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8005dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005e7:	83 c0 20             	add    $0x20,%eax
  8005ea:	8b 00                	mov    (%eax),%eax
  8005ec:	89 45 88             	mov    %eax,-0x78(%ebp)
  8005ef:	8b 45 88             	mov    -0x78(%ebp),%eax
  8005f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005f7:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  8005fc:	74 36                	je     800634 <_main+0x5fc>
  8005fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800603:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800609:	83 c0 20             	add    $0x20,%eax
  80060c:	8b 00                	mov    (%eax),%eax
  80060e:	89 45 84             	mov    %eax,-0x7c(%ebp)
  800611:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800614:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800619:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80061e:	74 14                	je     800634 <_main+0x5fc>
  800620:	83 ec 04             	sub    $0x4,%esp
  800623:	68 bc 23 80 00       	push   $0x8023bc
  800628:	6a 5e                	push   $0x5e
  80062a:	68 44 23 80 00       	push   $0x802344
  80062f:	e8 de 03 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x80c000 && ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x804000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800634:	a1 20 30 80 00       	mov    0x803020,%eax
  800639:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80063f:	83 c0 30             	add    $0x30,%eax
  800642:	8b 00                	mov    (%eax),%eax
  800644:	89 45 80             	mov    %eax,-0x80(%ebp)
  800647:	8b 45 80             	mov    -0x80(%ebp),%eax
  80064a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80064f:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800654:	74 3c                	je     800692 <_main+0x65a>
  800656:	a1 20 30 80 00       	mov    0x803020,%eax
  80065b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800661:	83 c0 30             	add    $0x30,%eax
  800664:	8b 00                	mov    (%eax),%eax
  800666:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80066c:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800672:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800677:	3d 00 40 80 00       	cmp    $0x804000,%eax
  80067c:	74 14                	je     800692 <_main+0x65a>
  80067e:	83 ec 04             	sub    $0x4,%esp
  800681:	68 bc 23 80 00       	push   $0x8023bc
  800686:	6a 5f                	push   $0x5f
  800688:	68 44 23 80 00       	push   $0x802344
  80068d:	e8 80 03 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x800000 && ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x809000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800692:	a1 20 30 80 00       	mov    0x803020,%eax
  800697:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80069d:	83 c0 40             	add    $0x40,%eax
  8006a0:	8b 00                	mov    (%eax),%eax
  8006a2:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  8006a8:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8006ae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006b3:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8006b8:	74 3c                	je     8006f6 <_main+0x6be>
  8006ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8006bf:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8006c5:	83 c0 40             	add    $0x40,%eax
  8006c8:	8b 00                	mov    (%eax),%eax
  8006ca:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  8006d0:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8006d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006db:	3d 00 90 80 00       	cmp    $0x809000,%eax
  8006e0:	74 14                	je     8006f6 <_main+0x6be>
  8006e2:	83 ec 04             	sub    $0x4,%esp
  8006e5:	68 bc 23 80 00       	push   $0x8023bc
  8006ea:	6a 60                	push   $0x60
  8006ec:	68 44 23 80 00       	push   $0x802344
  8006f1:	e8 1c 03 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x801000 && ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0xeebfd000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8006f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8006fb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800701:	83 c0 50             	add    $0x50,%eax
  800704:	8b 00                	mov    (%eax),%eax
  800706:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  80070c:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800712:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800717:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80071c:	74 3c                	je     80075a <_main+0x722>
  80071e:	a1 20 30 80 00       	mov    0x803020,%eax
  800723:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800729:	83 c0 50             	add    $0x50,%eax
  80072c:	8b 00                	mov    (%eax),%eax
  80072e:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800734:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80073a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80073f:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800744:	74 14                	je     80075a <_main+0x722>
  800746:	83 ec 04             	sub    $0x4,%esp
  800749:	68 bc 23 80 00       	push   $0x8023bc
  80074e:	6a 61                	push   $0x61
  800750:	68 44 23 80 00       	push   $0x802344
  800755:	e8 b8 02 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x803000 && ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x80b000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80075a:	a1 20 30 80 00       	mov    0x803020,%eax
  80075f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800765:	83 c0 60             	add    $0x60,%eax
  800768:	8b 00                	mov    (%eax),%eax
  80076a:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800770:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800776:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80077b:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800780:	74 3c                	je     8007be <_main+0x786>
  800782:	a1 20 30 80 00       	mov    0x803020,%eax
  800787:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80078d:	83 c0 60             	add    $0x60,%eax
  800790:	8b 00                	mov    (%eax),%eax
  800792:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800798:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  80079e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007a3:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  8007a8:	74 14                	je     8007be <_main+0x786>
  8007aa:	83 ec 04             	sub    $0x4,%esp
  8007ad:	68 bc 23 80 00       	push   $0x8023bc
  8007b2:	6a 62                	push   $0x62
  8007b4:	68 44 23 80 00       	push   $0x802344
  8007b9:	e8 54 02 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x804000 && ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x80c000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8007be:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007c9:	83 c0 70             	add    $0x70,%eax
  8007cc:	8b 00                	mov    (%eax),%eax
  8007ce:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  8007d4:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  8007da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007df:	3d 00 40 80 00       	cmp    $0x804000,%eax
  8007e4:	74 3c                	je     800822 <_main+0x7ea>
  8007e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8007eb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007f1:	83 c0 70             	add    $0x70,%eax
  8007f4:	8b 00                	mov    (%eax),%eax
  8007f6:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  8007fc:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800802:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800807:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  80080c:	74 14                	je     800822 <_main+0x7ea>
  80080e:	83 ec 04             	sub    $0x4,%esp
  800811:	68 bc 23 80 00       	push   $0x8023bc
  800816:	6a 63                	push   $0x63
  800818:	68 44 23 80 00       	push   $0x802344
  80081d:	e8 f0 01 00 00       	call   800a12 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x809000 && ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x800000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800822:	a1 20 30 80 00       	mov    0x803020,%eax
  800827:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80082d:	83 e8 80             	sub    $0xffffff80,%eax
  800830:	8b 00                	mov    (%eax),%eax
  800832:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  800838:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  80083e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800843:	3d 00 90 80 00       	cmp    $0x809000,%eax
  800848:	74 3c                	je     800886 <_main+0x84e>
  80084a:	a1 20 30 80 00       	mov    0x803020,%eax
  80084f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800855:	83 e8 80             	sub    $0xffffff80,%eax
  800858:	8b 00                	mov    (%eax),%eax
  80085a:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800860:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800866:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80086b:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800870:	74 14                	je     800886 <_main+0x84e>
  800872:	83 ec 04             	sub    $0x4,%esp
  800875:	68 bc 23 80 00       	push   $0x8023bc
  80087a:	6a 64                	push   $0x64
  80087c:	68 44 23 80 00       	push   $0x802344
  800881:	e8 8c 01 00 00       	call   800a12 <_panic>

		if(myEnv->page_last_WS_index != 6 && myEnv->page_last_WS_index != 2) panic("wrong PAGE WS pointer location");
  800886:	a1 20 30 80 00       	mov    0x803020,%eax
  80088b:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  800891:	83 f8 06             	cmp    $0x6,%eax
  800894:	74 24                	je     8008ba <_main+0x882>
  800896:	a1 20 30 80 00       	mov    0x803020,%eax
  80089b:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  8008a1:	83 f8 02             	cmp    $0x2,%eax
  8008a4:	74 14                	je     8008ba <_main+0x882>
  8008a6:	83 ec 04             	sub    $0x4,%esp
  8008a9:	68 08 24 80 00       	push   $0x802408
  8008ae:	6a 66                	push   $0x66
  8008b0:	68 44 23 80 00       	push   $0x802344
  8008b5:	e8 58 01 00 00       	call   800a12 <_panic>
	}

	cprintf("Congratulations!! test PAGE replacement [FIFO Alg.] is completed successfully.\n");
  8008ba:	83 ec 0c             	sub    $0xc,%esp
  8008bd:	68 28 24 80 00       	push   $0x802428
  8008c2:	e8 ed 03 00 00       	call   800cb4 <cprintf>
  8008c7:	83 c4 10             	add    $0x10,%esp
	return;
  8008ca:	90                   	nop
}
  8008cb:	c9                   	leave  
  8008cc:	c3                   	ret    

008008cd <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8008cd:	55                   	push   %ebp
  8008ce:	89 e5                	mov    %esp,%ebp
  8008d0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8008d3:	e8 07 12 00 00       	call   801adf <sys_getenvindex>
  8008d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8008db:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008de:	89 d0                	mov    %edx,%eax
  8008e0:	c1 e0 03             	shl    $0x3,%eax
  8008e3:	01 d0                	add    %edx,%eax
  8008e5:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8008ec:	01 c8                	add    %ecx,%eax
  8008ee:	01 c0                	add    %eax,%eax
  8008f0:	01 d0                	add    %edx,%eax
  8008f2:	01 c0                	add    %eax,%eax
  8008f4:	01 d0                	add    %edx,%eax
  8008f6:	89 c2                	mov    %eax,%edx
  8008f8:	c1 e2 05             	shl    $0x5,%edx
  8008fb:	29 c2                	sub    %eax,%edx
  8008fd:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800904:	89 c2                	mov    %eax,%edx
  800906:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80090c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800911:	a1 20 30 80 00       	mov    0x803020,%eax
  800916:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80091c:	84 c0                	test   %al,%al
  80091e:	74 0f                	je     80092f <libmain+0x62>
		binaryname = myEnv->prog_name;
  800920:	a1 20 30 80 00       	mov    0x803020,%eax
  800925:	05 40 3c 01 00       	add    $0x13c40,%eax
  80092a:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80092f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800933:	7e 0a                	jle    80093f <libmain+0x72>
		binaryname = argv[0];
  800935:	8b 45 0c             	mov    0xc(%ebp),%eax
  800938:	8b 00                	mov    (%eax),%eax
  80093a:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  80093f:	83 ec 08             	sub    $0x8,%esp
  800942:	ff 75 0c             	pushl  0xc(%ebp)
  800945:	ff 75 08             	pushl  0x8(%ebp)
  800948:	e8 eb f6 ff ff       	call   800038 <_main>
  80094d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800950:	e8 25 13 00 00       	call   801c7a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800955:	83 ec 0c             	sub    $0xc,%esp
  800958:	68 90 24 80 00       	push   $0x802490
  80095d:	e8 52 03 00 00       	call   800cb4 <cprintf>
  800962:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800965:	a1 20 30 80 00       	mov    0x803020,%eax
  80096a:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800970:	a1 20 30 80 00       	mov    0x803020,%eax
  800975:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80097b:	83 ec 04             	sub    $0x4,%esp
  80097e:	52                   	push   %edx
  80097f:	50                   	push   %eax
  800980:	68 b8 24 80 00       	push   $0x8024b8
  800985:	e8 2a 03 00 00       	call   800cb4 <cprintf>
  80098a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80098d:	a1 20 30 80 00       	mov    0x803020,%eax
  800992:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800998:	a1 20 30 80 00       	mov    0x803020,%eax
  80099d:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8009a3:	83 ec 04             	sub    $0x4,%esp
  8009a6:	52                   	push   %edx
  8009a7:	50                   	push   %eax
  8009a8:	68 e0 24 80 00       	push   $0x8024e0
  8009ad:	e8 02 03 00 00       	call   800cb4 <cprintf>
  8009b2:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8009b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8009ba:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8009c0:	83 ec 08             	sub    $0x8,%esp
  8009c3:	50                   	push   %eax
  8009c4:	68 21 25 80 00       	push   $0x802521
  8009c9:	e8 e6 02 00 00       	call   800cb4 <cprintf>
  8009ce:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8009d1:	83 ec 0c             	sub    $0xc,%esp
  8009d4:	68 90 24 80 00       	push   $0x802490
  8009d9:	e8 d6 02 00 00       	call   800cb4 <cprintf>
  8009de:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8009e1:	e8 ae 12 00 00       	call   801c94 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8009e6:	e8 19 00 00 00       	call   800a04 <exit>
}
  8009eb:	90                   	nop
  8009ec:	c9                   	leave  
  8009ed:	c3                   	ret    

008009ee <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009ee:	55                   	push   %ebp
  8009ef:	89 e5                	mov    %esp,%ebp
  8009f1:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8009f4:	83 ec 0c             	sub    $0xc,%esp
  8009f7:	6a 00                	push   $0x0
  8009f9:	e8 ad 10 00 00       	call   801aab <sys_env_destroy>
  8009fe:	83 c4 10             	add    $0x10,%esp
}
  800a01:	90                   	nop
  800a02:	c9                   	leave  
  800a03:	c3                   	ret    

00800a04 <exit>:

void
exit(void)
{
  800a04:	55                   	push   %ebp
  800a05:	89 e5                	mov    %esp,%ebp
  800a07:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800a0a:	e8 02 11 00 00       	call   801b11 <sys_env_exit>
}
  800a0f:	90                   	nop
  800a10:	c9                   	leave  
  800a11:	c3                   	ret    

00800a12 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800a12:	55                   	push   %ebp
  800a13:	89 e5                	mov    %esp,%ebp
  800a15:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800a18:	8d 45 10             	lea    0x10(%ebp),%eax
  800a1b:	83 c0 04             	add    $0x4,%eax
  800a1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800a21:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800a26:	85 c0                	test   %eax,%eax
  800a28:	74 16                	je     800a40 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800a2a:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800a2f:	83 ec 08             	sub    $0x8,%esp
  800a32:	50                   	push   %eax
  800a33:	68 38 25 80 00       	push   $0x802538
  800a38:	e8 77 02 00 00       	call   800cb4 <cprintf>
  800a3d:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800a40:	a1 08 30 80 00       	mov    0x803008,%eax
  800a45:	ff 75 0c             	pushl  0xc(%ebp)
  800a48:	ff 75 08             	pushl  0x8(%ebp)
  800a4b:	50                   	push   %eax
  800a4c:	68 3d 25 80 00       	push   $0x80253d
  800a51:	e8 5e 02 00 00       	call   800cb4 <cprintf>
  800a56:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800a59:	8b 45 10             	mov    0x10(%ebp),%eax
  800a5c:	83 ec 08             	sub    $0x8,%esp
  800a5f:	ff 75 f4             	pushl  -0xc(%ebp)
  800a62:	50                   	push   %eax
  800a63:	e8 e1 01 00 00       	call   800c49 <vcprintf>
  800a68:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a6b:	83 ec 08             	sub    $0x8,%esp
  800a6e:	6a 00                	push   $0x0
  800a70:	68 59 25 80 00       	push   $0x802559
  800a75:	e8 cf 01 00 00       	call   800c49 <vcprintf>
  800a7a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a7d:	e8 82 ff ff ff       	call   800a04 <exit>

	// should not return here
	while (1) ;
  800a82:	eb fe                	jmp    800a82 <_panic+0x70>

00800a84 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a84:	55                   	push   %ebp
  800a85:	89 e5                	mov    %esp,%ebp
  800a87:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a8a:	a1 20 30 80 00       	mov    0x803020,%eax
  800a8f:	8b 50 74             	mov    0x74(%eax),%edx
  800a92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a95:	39 c2                	cmp    %eax,%edx
  800a97:	74 14                	je     800aad <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a99:	83 ec 04             	sub    $0x4,%esp
  800a9c:	68 5c 25 80 00       	push   $0x80255c
  800aa1:	6a 26                	push   $0x26
  800aa3:	68 a8 25 80 00       	push   $0x8025a8
  800aa8:	e8 65 ff ff ff       	call   800a12 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800aad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800ab4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800abb:	e9 b6 00 00 00       	jmp    800b76 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800ac0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ac3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	01 d0                	add    %edx,%eax
  800acf:	8b 00                	mov    (%eax),%eax
  800ad1:	85 c0                	test   %eax,%eax
  800ad3:	75 08                	jne    800add <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800ad5:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800ad8:	e9 96 00 00 00       	jmp    800b73 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800add:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ae4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800aeb:	eb 5d                	jmp    800b4a <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800aed:	a1 20 30 80 00       	mov    0x803020,%eax
  800af2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800af8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800afb:	c1 e2 04             	shl    $0x4,%edx
  800afe:	01 d0                	add    %edx,%eax
  800b00:	8a 40 04             	mov    0x4(%eax),%al
  800b03:	84 c0                	test   %al,%al
  800b05:	75 40                	jne    800b47 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b07:	a1 20 30 80 00       	mov    0x803020,%eax
  800b0c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b12:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b15:	c1 e2 04             	shl    $0x4,%edx
  800b18:	01 d0                	add    %edx,%eax
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800b1f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b22:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b27:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800b29:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b2c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	01 c8                	add    %ecx,%eax
  800b38:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b3a:	39 c2                	cmp    %eax,%edx
  800b3c:	75 09                	jne    800b47 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800b3e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b45:	eb 12                	jmp    800b59 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b47:	ff 45 e8             	incl   -0x18(%ebp)
  800b4a:	a1 20 30 80 00       	mov    0x803020,%eax
  800b4f:	8b 50 74             	mov    0x74(%eax),%edx
  800b52:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b55:	39 c2                	cmp    %eax,%edx
  800b57:	77 94                	ja     800aed <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b59:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b5d:	75 14                	jne    800b73 <CheckWSWithoutLastIndex+0xef>
			panic(
  800b5f:	83 ec 04             	sub    $0x4,%esp
  800b62:	68 b4 25 80 00       	push   $0x8025b4
  800b67:	6a 3a                	push   $0x3a
  800b69:	68 a8 25 80 00       	push   $0x8025a8
  800b6e:	e8 9f fe ff ff       	call   800a12 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b73:	ff 45 f0             	incl   -0x10(%ebp)
  800b76:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b79:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b7c:	0f 8c 3e ff ff ff    	jl     800ac0 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b82:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b89:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b90:	eb 20                	jmp    800bb2 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b92:	a1 20 30 80 00       	mov    0x803020,%eax
  800b97:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b9d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ba0:	c1 e2 04             	shl    $0x4,%edx
  800ba3:	01 d0                	add    %edx,%eax
  800ba5:	8a 40 04             	mov    0x4(%eax),%al
  800ba8:	3c 01                	cmp    $0x1,%al
  800baa:	75 03                	jne    800baf <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800bac:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800baf:	ff 45 e0             	incl   -0x20(%ebp)
  800bb2:	a1 20 30 80 00       	mov    0x803020,%eax
  800bb7:	8b 50 74             	mov    0x74(%eax),%edx
  800bba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bbd:	39 c2                	cmp    %eax,%edx
  800bbf:	77 d1                	ja     800b92 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800bc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bc4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800bc7:	74 14                	je     800bdd <CheckWSWithoutLastIndex+0x159>
		panic(
  800bc9:	83 ec 04             	sub    $0x4,%esp
  800bcc:	68 08 26 80 00       	push   $0x802608
  800bd1:	6a 44                	push   $0x44
  800bd3:	68 a8 25 80 00       	push   $0x8025a8
  800bd8:	e8 35 fe ff ff       	call   800a12 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800bdd:	90                   	nop
  800bde:	c9                   	leave  
  800bdf:	c3                   	ret    

00800be0 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800be0:	55                   	push   %ebp
  800be1:	89 e5                	mov    %esp,%ebp
  800be3:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800be6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be9:	8b 00                	mov    (%eax),%eax
  800beb:	8d 48 01             	lea    0x1(%eax),%ecx
  800bee:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf1:	89 0a                	mov    %ecx,(%edx)
  800bf3:	8b 55 08             	mov    0x8(%ebp),%edx
  800bf6:	88 d1                	mov    %dl,%cl
  800bf8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bfb:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800bff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c02:	8b 00                	mov    (%eax),%eax
  800c04:	3d ff 00 00 00       	cmp    $0xff,%eax
  800c09:	75 2c                	jne    800c37 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800c0b:	a0 24 30 80 00       	mov    0x803024,%al
  800c10:	0f b6 c0             	movzbl %al,%eax
  800c13:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c16:	8b 12                	mov    (%edx),%edx
  800c18:	89 d1                	mov    %edx,%ecx
  800c1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c1d:	83 c2 08             	add    $0x8,%edx
  800c20:	83 ec 04             	sub    $0x4,%esp
  800c23:	50                   	push   %eax
  800c24:	51                   	push   %ecx
  800c25:	52                   	push   %edx
  800c26:	e8 3e 0e 00 00       	call   801a69 <sys_cputs>
  800c2b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c31:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3a:	8b 40 04             	mov    0x4(%eax),%eax
  800c3d:	8d 50 01             	lea    0x1(%eax),%edx
  800c40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c43:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c46:	90                   	nop
  800c47:	c9                   	leave  
  800c48:	c3                   	ret    

00800c49 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c49:	55                   	push   %ebp
  800c4a:	89 e5                	mov    %esp,%ebp
  800c4c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c52:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c59:	00 00 00 
	b.cnt = 0;
  800c5c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c63:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c66:	ff 75 0c             	pushl  0xc(%ebp)
  800c69:	ff 75 08             	pushl  0x8(%ebp)
  800c6c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c72:	50                   	push   %eax
  800c73:	68 e0 0b 80 00       	push   $0x800be0
  800c78:	e8 11 02 00 00       	call   800e8e <vprintfmt>
  800c7d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c80:	a0 24 30 80 00       	mov    0x803024,%al
  800c85:	0f b6 c0             	movzbl %al,%eax
  800c88:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c8e:	83 ec 04             	sub    $0x4,%esp
  800c91:	50                   	push   %eax
  800c92:	52                   	push   %edx
  800c93:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c99:	83 c0 08             	add    $0x8,%eax
  800c9c:	50                   	push   %eax
  800c9d:	e8 c7 0d 00 00       	call   801a69 <sys_cputs>
  800ca2:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800ca5:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800cac:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800cb2:	c9                   	leave  
  800cb3:	c3                   	ret    

00800cb4 <cprintf>:

int cprintf(const char *fmt, ...) {
  800cb4:	55                   	push   %ebp
  800cb5:	89 e5                	mov    %esp,%ebp
  800cb7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800cba:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800cc1:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cca:	83 ec 08             	sub    $0x8,%esp
  800ccd:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd0:	50                   	push   %eax
  800cd1:	e8 73 ff ff ff       	call   800c49 <vcprintf>
  800cd6:	83 c4 10             	add    $0x10,%esp
  800cd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800cdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cdf:	c9                   	leave  
  800ce0:	c3                   	ret    

00800ce1 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ce1:	55                   	push   %ebp
  800ce2:	89 e5                	mov    %esp,%ebp
  800ce4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ce7:	e8 8e 0f 00 00       	call   801c7a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800cec:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	83 ec 08             	sub    $0x8,%esp
  800cf8:	ff 75 f4             	pushl  -0xc(%ebp)
  800cfb:	50                   	push   %eax
  800cfc:	e8 48 ff ff ff       	call   800c49 <vcprintf>
  800d01:	83 c4 10             	add    $0x10,%esp
  800d04:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800d07:	e8 88 0f 00 00       	call   801c94 <sys_enable_interrupt>
	return cnt;
  800d0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d0f:	c9                   	leave  
  800d10:	c3                   	ret    

00800d11 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d11:	55                   	push   %ebp
  800d12:	89 e5                	mov    %esp,%ebp
  800d14:	53                   	push   %ebx
  800d15:	83 ec 14             	sub    $0x14,%esp
  800d18:	8b 45 10             	mov    0x10(%ebp),%eax
  800d1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d1e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d21:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d24:	8b 45 18             	mov    0x18(%ebp),%eax
  800d27:	ba 00 00 00 00       	mov    $0x0,%edx
  800d2c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d2f:	77 55                	ja     800d86 <printnum+0x75>
  800d31:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d34:	72 05                	jb     800d3b <printnum+0x2a>
  800d36:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d39:	77 4b                	ja     800d86 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d3b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d3e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d41:	8b 45 18             	mov    0x18(%ebp),%eax
  800d44:	ba 00 00 00 00       	mov    $0x0,%edx
  800d49:	52                   	push   %edx
  800d4a:	50                   	push   %eax
  800d4b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d4e:	ff 75 f0             	pushl  -0x10(%ebp)
  800d51:	e8 46 13 00 00       	call   80209c <__udivdi3>
  800d56:	83 c4 10             	add    $0x10,%esp
  800d59:	83 ec 04             	sub    $0x4,%esp
  800d5c:	ff 75 20             	pushl  0x20(%ebp)
  800d5f:	53                   	push   %ebx
  800d60:	ff 75 18             	pushl  0x18(%ebp)
  800d63:	52                   	push   %edx
  800d64:	50                   	push   %eax
  800d65:	ff 75 0c             	pushl  0xc(%ebp)
  800d68:	ff 75 08             	pushl  0x8(%ebp)
  800d6b:	e8 a1 ff ff ff       	call   800d11 <printnum>
  800d70:	83 c4 20             	add    $0x20,%esp
  800d73:	eb 1a                	jmp    800d8f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d75:	83 ec 08             	sub    $0x8,%esp
  800d78:	ff 75 0c             	pushl  0xc(%ebp)
  800d7b:	ff 75 20             	pushl  0x20(%ebp)
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	ff d0                	call   *%eax
  800d83:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d86:	ff 4d 1c             	decl   0x1c(%ebp)
  800d89:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d8d:	7f e6                	jg     800d75 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d8f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d92:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d97:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d9d:	53                   	push   %ebx
  800d9e:	51                   	push   %ecx
  800d9f:	52                   	push   %edx
  800da0:	50                   	push   %eax
  800da1:	e8 06 14 00 00       	call   8021ac <__umoddi3>
  800da6:	83 c4 10             	add    $0x10,%esp
  800da9:	05 74 28 80 00       	add    $0x802874,%eax
  800dae:	8a 00                	mov    (%eax),%al
  800db0:	0f be c0             	movsbl %al,%eax
  800db3:	83 ec 08             	sub    $0x8,%esp
  800db6:	ff 75 0c             	pushl  0xc(%ebp)
  800db9:	50                   	push   %eax
  800dba:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbd:	ff d0                	call   *%eax
  800dbf:	83 c4 10             	add    $0x10,%esp
}
  800dc2:	90                   	nop
  800dc3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800dc6:	c9                   	leave  
  800dc7:	c3                   	ret    

00800dc8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800dc8:	55                   	push   %ebp
  800dc9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800dcb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800dcf:	7e 1c                	jle    800ded <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd4:	8b 00                	mov    (%eax),%eax
  800dd6:	8d 50 08             	lea    0x8(%eax),%edx
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	89 10                	mov    %edx,(%eax)
  800dde:	8b 45 08             	mov    0x8(%ebp),%eax
  800de1:	8b 00                	mov    (%eax),%eax
  800de3:	83 e8 08             	sub    $0x8,%eax
  800de6:	8b 50 04             	mov    0x4(%eax),%edx
  800de9:	8b 00                	mov    (%eax),%eax
  800deb:	eb 40                	jmp    800e2d <getuint+0x65>
	else if (lflag)
  800ded:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800df1:	74 1e                	je     800e11 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	8b 00                	mov    (%eax),%eax
  800df8:	8d 50 04             	lea    0x4(%eax),%edx
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfe:	89 10                	mov    %edx,(%eax)
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
  800e03:	8b 00                	mov    (%eax),%eax
  800e05:	83 e8 04             	sub    $0x4,%eax
  800e08:	8b 00                	mov    (%eax),%eax
  800e0a:	ba 00 00 00 00       	mov    $0x0,%edx
  800e0f:	eb 1c                	jmp    800e2d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e11:	8b 45 08             	mov    0x8(%ebp),%eax
  800e14:	8b 00                	mov    (%eax),%eax
  800e16:	8d 50 04             	lea    0x4(%eax),%edx
  800e19:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1c:	89 10                	mov    %edx,(%eax)
  800e1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e21:	8b 00                	mov    (%eax),%eax
  800e23:	83 e8 04             	sub    $0x4,%eax
  800e26:	8b 00                	mov    (%eax),%eax
  800e28:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e2d:	5d                   	pop    %ebp
  800e2e:	c3                   	ret    

00800e2f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e2f:	55                   	push   %ebp
  800e30:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e32:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e36:	7e 1c                	jle    800e54 <getint+0x25>
		return va_arg(*ap, long long);
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3b:	8b 00                	mov    (%eax),%eax
  800e3d:	8d 50 08             	lea    0x8(%eax),%edx
  800e40:	8b 45 08             	mov    0x8(%ebp),%eax
  800e43:	89 10                	mov    %edx,(%eax)
  800e45:	8b 45 08             	mov    0x8(%ebp),%eax
  800e48:	8b 00                	mov    (%eax),%eax
  800e4a:	83 e8 08             	sub    $0x8,%eax
  800e4d:	8b 50 04             	mov    0x4(%eax),%edx
  800e50:	8b 00                	mov    (%eax),%eax
  800e52:	eb 38                	jmp    800e8c <getint+0x5d>
	else if (lflag)
  800e54:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e58:	74 1a                	je     800e74 <getint+0x45>
		return va_arg(*ap, long);
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	8b 00                	mov    (%eax),%eax
  800e5f:	8d 50 04             	lea    0x4(%eax),%edx
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
  800e65:	89 10                	mov    %edx,(%eax)
  800e67:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6a:	8b 00                	mov    (%eax),%eax
  800e6c:	83 e8 04             	sub    $0x4,%eax
  800e6f:	8b 00                	mov    (%eax),%eax
  800e71:	99                   	cltd   
  800e72:	eb 18                	jmp    800e8c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
  800e77:	8b 00                	mov    (%eax),%eax
  800e79:	8d 50 04             	lea    0x4(%eax),%edx
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7f:	89 10                	mov    %edx,(%eax)
  800e81:	8b 45 08             	mov    0x8(%ebp),%eax
  800e84:	8b 00                	mov    (%eax),%eax
  800e86:	83 e8 04             	sub    $0x4,%eax
  800e89:	8b 00                	mov    (%eax),%eax
  800e8b:	99                   	cltd   
}
  800e8c:	5d                   	pop    %ebp
  800e8d:	c3                   	ret    

00800e8e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e8e:	55                   	push   %ebp
  800e8f:	89 e5                	mov    %esp,%ebp
  800e91:	56                   	push   %esi
  800e92:	53                   	push   %ebx
  800e93:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e96:	eb 17                	jmp    800eaf <vprintfmt+0x21>
			if (ch == '\0')
  800e98:	85 db                	test   %ebx,%ebx
  800e9a:	0f 84 af 03 00 00    	je     80124f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ea0:	83 ec 08             	sub    $0x8,%esp
  800ea3:	ff 75 0c             	pushl  0xc(%ebp)
  800ea6:	53                   	push   %ebx
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaa:	ff d0                	call   *%eax
  800eac:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800eaf:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb2:	8d 50 01             	lea    0x1(%eax),%edx
  800eb5:	89 55 10             	mov    %edx,0x10(%ebp)
  800eb8:	8a 00                	mov    (%eax),%al
  800eba:	0f b6 d8             	movzbl %al,%ebx
  800ebd:	83 fb 25             	cmp    $0x25,%ebx
  800ec0:	75 d6                	jne    800e98 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800ec2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ec6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ecd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ed4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800edb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ee2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee5:	8d 50 01             	lea    0x1(%eax),%edx
  800ee8:	89 55 10             	mov    %edx,0x10(%ebp)
  800eeb:	8a 00                	mov    (%eax),%al
  800eed:	0f b6 d8             	movzbl %al,%ebx
  800ef0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ef3:	83 f8 55             	cmp    $0x55,%eax
  800ef6:	0f 87 2b 03 00 00    	ja     801227 <vprintfmt+0x399>
  800efc:	8b 04 85 98 28 80 00 	mov    0x802898(,%eax,4),%eax
  800f03:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f05:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f09:	eb d7                	jmp    800ee2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f0b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f0f:	eb d1                	jmp    800ee2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f11:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f18:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f1b:	89 d0                	mov    %edx,%eax
  800f1d:	c1 e0 02             	shl    $0x2,%eax
  800f20:	01 d0                	add    %edx,%eax
  800f22:	01 c0                	add    %eax,%eax
  800f24:	01 d8                	add    %ebx,%eax
  800f26:	83 e8 30             	sub    $0x30,%eax
  800f29:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f34:	83 fb 2f             	cmp    $0x2f,%ebx
  800f37:	7e 3e                	jle    800f77 <vprintfmt+0xe9>
  800f39:	83 fb 39             	cmp    $0x39,%ebx
  800f3c:	7f 39                	jg     800f77 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f3e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f41:	eb d5                	jmp    800f18 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f43:	8b 45 14             	mov    0x14(%ebp),%eax
  800f46:	83 c0 04             	add    $0x4,%eax
  800f49:	89 45 14             	mov    %eax,0x14(%ebp)
  800f4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4f:	83 e8 04             	sub    $0x4,%eax
  800f52:	8b 00                	mov    (%eax),%eax
  800f54:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f57:	eb 1f                	jmp    800f78 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f59:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f5d:	79 83                	jns    800ee2 <vprintfmt+0x54>
				width = 0;
  800f5f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f66:	e9 77 ff ff ff       	jmp    800ee2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f6b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f72:	e9 6b ff ff ff       	jmp    800ee2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f77:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f7c:	0f 89 60 ff ff ff    	jns    800ee2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f82:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f88:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f8f:	e9 4e ff ff ff       	jmp    800ee2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f94:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f97:	e9 46 ff ff ff       	jmp    800ee2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f9c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f9f:	83 c0 04             	add    $0x4,%eax
  800fa2:	89 45 14             	mov    %eax,0x14(%ebp)
  800fa5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa8:	83 e8 04             	sub    $0x4,%eax
  800fab:	8b 00                	mov    (%eax),%eax
  800fad:	83 ec 08             	sub    $0x8,%esp
  800fb0:	ff 75 0c             	pushl  0xc(%ebp)
  800fb3:	50                   	push   %eax
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	ff d0                	call   *%eax
  800fb9:	83 c4 10             	add    $0x10,%esp
			break;
  800fbc:	e9 89 02 00 00       	jmp    80124a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800fc1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc4:	83 c0 04             	add    $0x4,%eax
  800fc7:	89 45 14             	mov    %eax,0x14(%ebp)
  800fca:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcd:	83 e8 04             	sub    $0x4,%eax
  800fd0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fd2:	85 db                	test   %ebx,%ebx
  800fd4:	79 02                	jns    800fd8 <vprintfmt+0x14a>
				err = -err;
  800fd6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fd8:	83 fb 64             	cmp    $0x64,%ebx
  800fdb:	7f 0b                	jg     800fe8 <vprintfmt+0x15a>
  800fdd:	8b 34 9d e0 26 80 00 	mov    0x8026e0(,%ebx,4),%esi
  800fe4:	85 f6                	test   %esi,%esi
  800fe6:	75 19                	jne    801001 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fe8:	53                   	push   %ebx
  800fe9:	68 85 28 80 00       	push   $0x802885
  800fee:	ff 75 0c             	pushl  0xc(%ebp)
  800ff1:	ff 75 08             	pushl  0x8(%ebp)
  800ff4:	e8 5e 02 00 00       	call   801257 <printfmt>
  800ff9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ffc:	e9 49 02 00 00       	jmp    80124a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801001:	56                   	push   %esi
  801002:	68 8e 28 80 00       	push   $0x80288e
  801007:	ff 75 0c             	pushl  0xc(%ebp)
  80100a:	ff 75 08             	pushl  0x8(%ebp)
  80100d:	e8 45 02 00 00       	call   801257 <printfmt>
  801012:	83 c4 10             	add    $0x10,%esp
			break;
  801015:	e9 30 02 00 00       	jmp    80124a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80101a:	8b 45 14             	mov    0x14(%ebp),%eax
  80101d:	83 c0 04             	add    $0x4,%eax
  801020:	89 45 14             	mov    %eax,0x14(%ebp)
  801023:	8b 45 14             	mov    0x14(%ebp),%eax
  801026:	83 e8 04             	sub    $0x4,%eax
  801029:	8b 30                	mov    (%eax),%esi
  80102b:	85 f6                	test   %esi,%esi
  80102d:	75 05                	jne    801034 <vprintfmt+0x1a6>
				p = "(null)";
  80102f:	be 91 28 80 00       	mov    $0x802891,%esi
			if (width > 0 && padc != '-')
  801034:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801038:	7e 6d                	jle    8010a7 <vprintfmt+0x219>
  80103a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80103e:	74 67                	je     8010a7 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801040:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801043:	83 ec 08             	sub    $0x8,%esp
  801046:	50                   	push   %eax
  801047:	56                   	push   %esi
  801048:	e8 0c 03 00 00       	call   801359 <strnlen>
  80104d:	83 c4 10             	add    $0x10,%esp
  801050:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801053:	eb 16                	jmp    80106b <vprintfmt+0x1dd>
					putch(padc, putdat);
  801055:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801059:	83 ec 08             	sub    $0x8,%esp
  80105c:	ff 75 0c             	pushl  0xc(%ebp)
  80105f:	50                   	push   %eax
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	ff d0                	call   *%eax
  801065:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801068:	ff 4d e4             	decl   -0x1c(%ebp)
  80106b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80106f:	7f e4                	jg     801055 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801071:	eb 34                	jmp    8010a7 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801073:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801077:	74 1c                	je     801095 <vprintfmt+0x207>
  801079:	83 fb 1f             	cmp    $0x1f,%ebx
  80107c:	7e 05                	jle    801083 <vprintfmt+0x1f5>
  80107e:	83 fb 7e             	cmp    $0x7e,%ebx
  801081:	7e 12                	jle    801095 <vprintfmt+0x207>
					putch('?', putdat);
  801083:	83 ec 08             	sub    $0x8,%esp
  801086:	ff 75 0c             	pushl  0xc(%ebp)
  801089:	6a 3f                	push   $0x3f
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	ff d0                	call   *%eax
  801090:	83 c4 10             	add    $0x10,%esp
  801093:	eb 0f                	jmp    8010a4 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801095:	83 ec 08             	sub    $0x8,%esp
  801098:	ff 75 0c             	pushl  0xc(%ebp)
  80109b:	53                   	push   %ebx
  80109c:	8b 45 08             	mov    0x8(%ebp),%eax
  80109f:	ff d0                	call   *%eax
  8010a1:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010a4:	ff 4d e4             	decl   -0x1c(%ebp)
  8010a7:	89 f0                	mov    %esi,%eax
  8010a9:	8d 70 01             	lea    0x1(%eax),%esi
  8010ac:	8a 00                	mov    (%eax),%al
  8010ae:	0f be d8             	movsbl %al,%ebx
  8010b1:	85 db                	test   %ebx,%ebx
  8010b3:	74 24                	je     8010d9 <vprintfmt+0x24b>
  8010b5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010b9:	78 b8                	js     801073 <vprintfmt+0x1e5>
  8010bb:	ff 4d e0             	decl   -0x20(%ebp)
  8010be:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010c2:	79 af                	jns    801073 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010c4:	eb 13                	jmp    8010d9 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010c6:	83 ec 08             	sub    $0x8,%esp
  8010c9:	ff 75 0c             	pushl  0xc(%ebp)
  8010cc:	6a 20                	push   $0x20
  8010ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d1:	ff d0                	call   *%eax
  8010d3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010d6:	ff 4d e4             	decl   -0x1c(%ebp)
  8010d9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010dd:	7f e7                	jg     8010c6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010df:	e9 66 01 00 00       	jmp    80124a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010e4:	83 ec 08             	sub    $0x8,%esp
  8010e7:	ff 75 e8             	pushl  -0x18(%ebp)
  8010ea:	8d 45 14             	lea    0x14(%ebp),%eax
  8010ed:	50                   	push   %eax
  8010ee:	e8 3c fd ff ff       	call   800e2f <getint>
  8010f3:	83 c4 10             	add    $0x10,%esp
  8010f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010f9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8010fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801102:	85 d2                	test   %edx,%edx
  801104:	79 23                	jns    801129 <vprintfmt+0x29b>
				putch('-', putdat);
  801106:	83 ec 08             	sub    $0x8,%esp
  801109:	ff 75 0c             	pushl  0xc(%ebp)
  80110c:	6a 2d                	push   $0x2d
  80110e:	8b 45 08             	mov    0x8(%ebp),%eax
  801111:	ff d0                	call   *%eax
  801113:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801116:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801119:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80111c:	f7 d8                	neg    %eax
  80111e:	83 d2 00             	adc    $0x0,%edx
  801121:	f7 da                	neg    %edx
  801123:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801126:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801129:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801130:	e9 bc 00 00 00       	jmp    8011f1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801135:	83 ec 08             	sub    $0x8,%esp
  801138:	ff 75 e8             	pushl  -0x18(%ebp)
  80113b:	8d 45 14             	lea    0x14(%ebp),%eax
  80113e:	50                   	push   %eax
  80113f:	e8 84 fc ff ff       	call   800dc8 <getuint>
  801144:	83 c4 10             	add    $0x10,%esp
  801147:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80114a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80114d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801154:	e9 98 00 00 00       	jmp    8011f1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801159:	83 ec 08             	sub    $0x8,%esp
  80115c:	ff 75 0c             	pushl  0xc(%ebp)
  80115f:	6a 58                	push   $0x58
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	ff d0                	call   *%eax
  801166:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801169:	83 ec 08             	sub    $0x8,%esp
  80116c:	ff 75 0c             	pushl  0xc(%ebp)
  80116f:	6a 58                	push   $0x58
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	ff d0                	call   *%eax
  801176:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801179:	83 ec 08             	sub    $0x8,%esp
  80117c:	ff 75 0c             	pushl  0xc(%ebp)
  80117f:	6a 58                	push   $0x58
  801181:	8b 45 08             	mov    0x8(%ebp),%eax
  801184:	ff d0                	call   *%eax
  801186:	83 c4 10             	add    $0x10,%esp
			break;
  801189:	e9 bc 00 00 00       	jmp    80124a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80118e:	83 ec 08             	sub    $0x8,%esp
  801191:	ff 75 0c             	pushl  0xc(%ebp)
  801194:	6a 30                	push   $0x30
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	ff d0                	call   *%eax
  80119b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80119e:	83 ec 08             	sub    $0x8,%esp
  8011a1:	ff 75 0c             	pushl  0xc(%ebp)
  8011a4:	6a 78                	push   $0x78
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a9:	ff d0                	call   *%eax
  8011ab:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b1:	83 c0 04             	add    $0x4,%eax
  8011b4:	89 45 14             	mov    %eax,0x14(%ebp)
  8011b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ba:	83 e8 04             	sub    $0x4,%eax
  8011bd:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011c9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011d0:	eb 1f                	jmp    8011f1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011d2:	83 ec 08             	sub    $0x8,%esp
  8011d5:	ff 75 e8             	pushl  -0x18(%ebp)
  8011d8:	8d 45 14             	lea    0x14(%ebp),%eax
  8011db:	50                   	push   %eax
  8011dc:	e8 e7 fb ff ff       	call   800dc8 <getuint>
  8011e1:	83 c4 10             	add    $0x10,%esp
  8011e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011e7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011ea:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011f1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011f8:	83 ec 04             	sub    $0x4,%esp
  8011fb:	52                   	push   %edx
  8011fc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011ff:	50                   	push   %eax
  801200:	ff 75 f4             	pushl  -0xc(%ebp)
  801203:	ff 75 f0             	pushl  -0x10(%ebp)
  801206:	ff 75 0c             	pushl  0xc(%ebp)
  801209:	ff 75 08             	pushl  0x8(%ebp)
  80120c:	e8 00 fb ff ff       	call   800d11 <printnum>
  801211:	83 c4 20             	add    $0x20,%esp
			break;
  801214:	eb 34                	jmp    80124a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801216:	83 ec 08             	sub    $0x8,%esp
  801219:	ff 75 0c             	pushl  0xc(%ebp)
  80121c:	53                   	push   %ebx
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
  801220:	ff d0                	call   *%eax
  801222:	83 c4 10             	add    $0x10,%esp
			break;
  801225:	eb 23                	jmp    80124a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801227:	83 ec 08             	sub    $0x8,%esp
  80122a:	ff 75 0c             	pushl  0xc(%ebp)
  80122d:	6a 25                	push   $0x25
  80122f:	8b 45 08             	mov    0x8(%ebp),%eax
  801232:	ff d0                	call   *%eax
  801234:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801237:	ff 4d 10             	decl   0x10(%ebp)
  80123a:	eb 03                	jmp    80123f <vprintfmt+0x3b1>
  80123c:	ff 4d 10             	decl   0x10(%ebp)
  80123f:	8b 45 10             	mov    0x10(%ebp),%eax
  801242:	48                   	dec    %eax
  801243:	8a 00                	mov    (%eax),%al
  801245:	3c 25                	cmp    $0x25,%al
  801247:	75 f3                	jne    80123c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801249:	90                   	nop
		}
	}
  80124a:	e9 47 fc ff ff       	jmp    800e96 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80124f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801250:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801253:	5b                   	pop    %ebx
  801254:	5e                   	pop    %esi
  801255:	5d                   	pop    %ebp
  801256:	c3                   	ret    

00801257 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801257:	55                   	push   %ebp
  801258:	89 e5                	mov    %esp,%ebp
  80125a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80125d:	8d 45 10             	lea    0x10(%ebp),%eax
  801260:	83 c0 04             	add    $0x4,%eax
  801263:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801266:	8b 45 10             	mov    0x10(%ebp),%eax
  801269:	ff 75 f4             	pushl  -0xc(%ebp)
  80126c:	50                   	push   %eax
  80126d:	ff 75 0c             	pushl  0xc(%ebp)
  801270:	ff 75 08             	pushl  0x8(%ebp)
  801273:	e8 16 fc ff ff       	call   800e8e <vprintfmt>
  801278:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80127b:	90                   	nop
  80127c:	c9                   	leave  
  80127d:	c3                   	ret    

0080127e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80127e:	55                   	push   %ebp
  80127f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801281:	8b 45 0c             	mov    0xc(%ebp),%eax
  801284:	8b 40 08             	mov    0x8(%eax),%eax
  801287:	8d 50 01             	lea    0x1(%eax),%edx
  80128a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801290:	8b 45 0c             	mov    0xc(%ebp),%eax
  801293:	8b 10                	mov    (%eax),%edx
  801295:	8b 45 0c             	mov    0xc(%ebp),%eax
  801298:	8b 40 04             	mov    0x4(%eax),%eax
  80129b:	39 c2                	cmp    %eax,%edx
  80129d:	73 12                	jae    8012b1 <sprintputch+0x33>
		*b->buf++ = ch;
  80129f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a2:	8b 00                	mov    (%eax),%eax
  8012a4:	8d 48 01             	lea    0x1(%eax),%ecx
  8012a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012aa:	89 0a                	mov    %ecx,(%edx)
  8012ac:	8b 55 08             	mov    0x8(%ebp),%edx
  8012af:	88 10                	mov    %dl,(%eax)
}
  8012b1:	90                   	nop
  8012b2:	5d                   	pop    %ebp
  8012b3:	c3                   	ret    

008012b4 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012b4:	55                   	push   %ebp
  8012b5:	89 e5                	mov    %esp,%ebp
  8012b7:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c9:	01 d0                	add    %edx,%eax
  8012cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012d5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012d9:	74 06                	je     8012e1 <vsnprintf+0x2d>
  8012db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012df:	7f 07                	jg     8012e8 <vsnprintf+0x34>
		return -E_INVAL;
  8012e1:	b8 03 00 00 00       	mov    $0x3,%eax
  8012e6:	eb 20                	jmp    801308 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012e8:	ff 75 14             	pushl  0x14(%ebp)
  8012eb:	ff 75 10             	pushl  0x10(%ebp)
  8012ee:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012f1:	50                   	push   %eax
  8012f2:	68 7e 12 80 00       	push   $0x80127e
  8012f7:	e8 92 fb ff ff       	call   800e8e <vprintfmt>
  8012fc:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8012ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801302:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801305:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801308:	c9                   	leave  
  801309:	c3                   	ret    

0080130a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80130a:	55                   	push   %ebp
  80130b:	89 e5                	mov    %esp,%ebp
  80130d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801310:	8d 45 10             	lea    0x10(%ebp),%eax
  801313:	83 c0 04             	add    $0x4,%eax
  801316:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801319:	8b 45 10             	mov    0x10(%ebp),%eax
  80131c:	ff 75 f4             	pushl  -0xc(%ebp)
  80131f:	50                   	push   %eax
  801320:	ff 75 0c             	pushl  0xc(%ebp)
  801323:	ff 75 08             	pushl  0x8(%ebp)
  801326:	e8 89 ff ff ff       	call   8012b4 <vsnprintf>
  80132b:	83 c4 10             	add    $0x10,%esp
  80132e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801331:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801334:	c9                   	leave  
  801335:	c3                   	ret    

00801336 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801336:	55                   	push   %ebp
  801337:	89 e5                	mov    %esp,%ebp
  801339:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80133c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801343:	eb 06                	jmp    80134b <strlen+0x15>
		n++;
  801345:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801348:	ff 45 08             	incl   0x8(%ebp)
  80134b:	8b 45 08             	mov    0x8(%ebp),%eax
  80134e:	8a 00                	mov    (%eax),%al
  801350:	84 c0                	test   %al,%al
  801352:	75 f1                	jne    801345 <strlen+0xf>
		n++;
	return n;
  801354:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801357:	c9                   	leave  
  801358:	c3                   	ret    

00801359 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
  80135c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80135f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801366:	eb 09                	jmp    801371 <strnlen+0x18>
		n++;
  801368:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80136b:	ff 45 08             	incl   0x8(%ebp)
  80136e:	ff 4d 0c             	decl   0xc(%ebp)
  801371:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801375:	74 09                	je     801380 <strnlen+0x27>
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	8a 00                	mov    (%eax),%al
  80137c:	84 c0                	test   %al,%al
  80137e:	75 e8                	jne    801368 <strnlen+0xf>
		n++;
	return n;
  801380:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801383:	c9                   	leave  
  801384:	c3                   	ret    

00801385 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801385:	55                   	push   %ebp
  801386:	89 e5                	mov    %esp,%ebp
  801388:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801391:	90                   	nop
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	8d 50 01             	lea    0x1(%eax),%edx
  801398:	89 55 08             	mov    %edx,0x8(%ebp)
  80139b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139e:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013a1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013a4:	8a 12                	mov    (%edx),%dl
  8013a6:	88 10                	mov    %dl,(%eax)
  8013a8:	8a 00                	mov    (%eax),%al
  8013aa:	84 c0                	test   %al,%al
  8013ac:	75 e4                	jne    801392 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013b1:	c9                   	leave  
  8013b2:	c3                   	ret    

008013b3 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013b3:	55                   	push   %ebp
  8013b4:	89 e5                	mov    %esp,%ebp
  8013b6:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013c6:	eb 1f                	jmp    8013e7 <strncpy+0x34>
		*dst++ = *src;
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	8d 50 01             	lea    0x1(%eax),%edx
  8013ce:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d4:	8a 12                	mov    (%edx),%dl
  8013d6:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013db:	8a 00                	mov    (%eax),%al
  8013dd:	84 c0                	test   %al,%al
  8013df:	74 03                	je     8013e4 <strncpy+0x31>
			src++;
  8013e1:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013e4:	ff 45 fc             	incl   -0x4(%ebp)
  8013e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ea:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013ed:	72 d9                	jb     8013c8 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
  8013f7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801400:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801404:	74 30                	je     801436 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801406:	eb 16                	jmp    80141e <strlcpy+0x2a>
			*dst++ = *src++;
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	8d 50 01             	lea    0x1(%eax),%edx
  80140e:	89 55 08             	mov    %edx,0x8(%ebp)
  801411:	8b 55 0c             	mov    0xc(%ebp),%edx
  801414:	8d 4a 01             	lea    0x1(%edx),%ecx
  801417:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80141a:	8a 12                	mov    (%edx),%dl
  80141c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80141e:	ff 4d 10             	decl   0x10(%ebp)
  801421:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801425:	74 09                	je     801430 <strlcpy+0x3c>
  801427:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142a:	8a 00                	mov    (%eax),%al
  80142c:	84 c0                	test   %al,%al
  80142e:	75 d8                	jne    801408 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
  801433:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801436:	8b 55 08             	mov    0x8(%ebp),%edx
  801439:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80143c:	29 c2                	sub    %eax,%edx
  80143e:	89 d0                	mov    %edx,%eax
}
  801440:	c9                   	leave  
  801441:	c3                   	ret    

00801442 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801442:	55                   	push   %ebp
  801443:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801445:	eb 06                	jmp    80144d <strcmp+0xb>
		p++, q++;
  801447:	ff 45 08             	incl   0x8(%ebp)
  80144a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	84 c0                	test   %al,%al
  801454:	74 0e                	je     801464 <strcmp+0x22>
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	8a 10                	mov    (%eax),%dl
  80145b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145e:	8a 00                	mov    (%eax),%al
  801460:	38 c2                	cmp    %al,%dl
  801462:	74 e3                	je     801447 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801464:	8b 45 08             	mov    0x8(%ebp),%eax
  801467:	8a 00                	mov    (%eax),%al
  801469:	0f b6 d0             	movzbl %al,%edx
  80146c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146f:	8a 00                	mov    (%eax),%al
  801471:	0f b6 c0             	movzbl %al,%eax
  801474:	29 c2                	sub    %eax,%edx
  801476:	89 d0                	mov    %edx,%eax
}
  801478:	5d                   	pop    %ebp
  801479:	c3                   	ret    

0080147a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80147d:	eb 09                	jmp    801488 <strncmp+0xe>
		n--, p++, q++;
  80147f:	ff 4d 10             	decl   0x10(%ebp)
  801482:	ff 45 08             	incl   0x8(%ebp)
  801485:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801488:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80148c:	74 17                	je     8014a5 <strncmp+0x2b>
  80148e:	8b 45 08             	mov    0x8(%ebp),%eax
  801491:	8a 00                	mov    (%eax),%al
  801493:	84 c0                	test   %al,%al
  801495:	74 0e                	je     8014a5 <strncmp+0x2b>
  801497:	8b 45 08             	mov    0x8(%ebp),%eax
  80149a:	8a 10                	mov    (%eax),%dl
  80149c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149f:	8a 00                	mov    (%eax),%al
  8014a1:	38 c2                	cmp    %al,%dl
  8014a3:	74 da                	je     80147f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014a9:	75 07                	jne    8014b2 <strncmp+0x38>
		return 0;
  8014ab:	b8 00 00 00 00       	mov    $0x0,%eax
  8014b0:	eb 14                	jmp    8014c6 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b5:	8a 00                	mov    (%eax),%al
  8014b7:	0f b6 d0             	movzbl %al,%edx
  8014ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bd:	8a 00                	mov    (%eax),%al
  8014bf:	0f b6 c0             	movzbl %al,%eax
  8014c2:	29 c2                	sub    %eax,%edx
  8014c4:	89 d0                	mov    %edx,%eax
}
  8014c6:	5d                   	pop    %ebp
  8014c7:	c3                   	ret    

008014c8 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	83 ec 04             	sub    $0x4,%esp
  8014ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014d4:	eb 12                	jmp    8014e8 <strchr+0x20>
		if (*s == c)
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d9:	8a 00                	mov    (%eax),%al
  8014db:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014de:	75 05                	jne    8014e5 <strchr+0x1d>
			return (char *) s;
  8014e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e3:	eb 11                	jmp    8014f6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014e5:	ff 45 08             	incl   0x8(%ebp)
  8014e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014eb:	8a 00                	mov    (%eax),%al
  8014ed:	84 c0                	test   %al,%al
  8014ef:	75 e5                	jne    8014d6 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014f6:	c9                   	leave  
  8014f7:	c3                   	ret    

008014f8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014f8:	55                   	push   %ebp
  8014f9:	89 e5                	mov    %esp,%ebp
  8014fb:	83 ec 04             	sub    $0x4,%esp
  8014fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801501:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801504:	eb 0d                	jmp    801513 <strfind+0x1b>
		if (*s == c)
  801506:	8b 45 08             	mov    0x8(%ebp),%eax
  801509:	8a 00                	mov    (%eax),%al
  80150b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80150e:	74 0e                	je     80151e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801510:	ff 45 08             	incl   0x8(%ebp)
  801513:	8b 45 08             	mov    0x8(%ebp),%eax
  801516:	8a 00                	mov    (%eax),%al
  801518:	84 c0                	test   %al,%al
  80151a:	75 ea                	jne    801506 <strfind+0xe>
  80151c:	eb 01                	jmp    80151f <strfind+0x27>
		if (*s == c)
			break;
  80151e:	90                   	nop
	return (char *) s;
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801522:	c9                   	leave  
  801523:	c3                   	ret    

00801524 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801524:	55                   	push   %ebp
  801525:	89 e5                	mov    %esp,%ebp
  801527:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801530:	8b 45 10             	mov    0x10(%ebp),%eax
  801533:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801536:	eb 0e                	jmp    801546 <memset+0x22>
		*p++ = c;
  801538:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153b:	8d 50 01             	lea    0x1(%eax),%edx
  80153e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801541:	8b 55 0c             	mov    0xc(%ebp),%edx
  801544:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801546:	ff 4d f8             	decl   -0x8(%ebp)
  801549:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80154d:	79 e9                	jns    801538 <memset+0x14>
		*p++ = c;

	return v;
  80154f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801552:	c9                   	leave  
  801553:	c3                   	ret    

00801554 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801554:	55                   	push   %ebp
  801555:	89 e5                	mov    %esp,%ebp
  801557:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80155a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801560:	8b 45 08             	mov    0x8(%ebp),%eax
  801563:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801566:	eb 16                	jmp    80157e <memcpy+0x2a>
		*d++ = *s++;
  801568:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80156b:	8d 50 01             	lea    0x1(%eax),%edx
  80156e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801571:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801574:	8d 4a 01             	lea    0x1(%edx),%ecx
  801577:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80157a:	8a 12                	mov    (%edx),%dl
  80157c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80157e:	8b 45 10             	mov    0x10(%ebp),%eax
  801581:	8d 50 ff             	lea    -0x1(%eax),%edx
  801584:	89 55 10             	mov    %edx,0x10(%ebp)
  801587:	85 c0                	test   %eax,%eax
  801589:	75 dd                	jne    801568 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80158b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80158e:	c9                   	leave  
  80158f:	c3                   	ret    

00801590 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801590:	55                   	push   %ebp
  801591:	89 e5                	mov    %esp,%ebp
  801593:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801596:	8b 45 0c             	mov    0xc(%ebp),%eax
  801599:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80159c:	8b 45 08             	mov    0x8(%ebp),%eax
  80159f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8015a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015a8:	73 50                	jae    8015fa <memmove+0x6a>
  8015aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b0:	01 d0                	add    %edx,%eax
  8015b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015b5:	76 43                	jbe    8015fa <memmove+0x6a>
		s += n;
  8015b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ba:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c0:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015c3:	eb 10                	jmp    8015d5 <memmove+0x45>
			*--d = *--s;
  8015c5:	ff 4d f8             	decl   -0x8(%ebp)
  8015c8:	ff 4d fc             	decl   -0x4(%ebp)
  8015cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ce:	8a 10                	mov    (%eax),%dl
  8015d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d3:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015db:	89 55 10             	mov    %edx,0x10(%ebp)
  8015de:	85 c0                	test   %eax,%eax
  8015e0:	75 e3                	jne    8015c5 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015e2:	eb 23                	jmp    801607 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e7:	8d 50 01             	lea    0x1(%eax),%edx
  8015ea:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015ed:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015f3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015f6:	8a 12                	mov    (%edx),%dl
  8015f8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8015fd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801600:	89 55 10             	mov    %edx,0x10(%ebp)
  801603:	85 c0                	test   %eax,%eax
  801605:	75 dd                	jne    8015e4 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801607:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
  80160f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801612:	8b 45 08             	mov    0x8(%ebp),%eax
  801615:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801618:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80161e:	eb 2a                	jmp    80164a <memcmp+0x3e>
		if (*s1 != *s2)
  801620:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801623:	8a 10                	mov    (%eax),%dl
  801625:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801628:	8a 00                	mov    (%eax),%al
  80162a:	38 c2                	cmp    %al,%dl
  80162c:	74 16                	je     801644 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80162e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801631:	8a 00                	mov    (%eax),%al
  801633:	0f b6 d0             	movzbl %al,%edx
  801636:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801639:	8a 00                	mov    (%eax),%al
  80163b:	0f b6 c0             	movzbl %al,%eax
  80163e:	29 c2                	sub    %eax,%edx
  801640:	89 d0                	mov    %edx,%eax
  801642:	eb 18                	jmp    80165c <memcmp+0x50>
		s1++, s2++;
  801644:	ff 45 fc             	incl   -0x4(%ebp)
  801647:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80164a:	8b 45 10             	mov    0x10(%ebp),%eax
  80164d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801650:	89 55 10             	mov    %edx,0x10(%ebp)
  801653:	85 c0                	test   %eax,%eax
  801655:	75 c9                	jne    801620 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801657:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80165c:	c9                   	leave  
  80165d:	c3                   	ret    

0080165e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80165e:	55                   	push   %ebp
  80165f:	89 e5                	mov    %esp,%ebp
  801661:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801664:	8b 55 08             	mov    0x8(%ebp),%edx
  801667:	8b 45 10             	mov    0x10(%ebp),%eax
  80166a:	01 d0                	add    %edx,%eax
  80166c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80166f:	eb 15                	jmp    801686 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	0f b6 d0             	movzbl %al,%edx
  801679:	8b 45 0c             	mov    0xc(%ebp),%eax
  80167c:	0f b6 c0             	movzbl %al,%eax
  80167f:	39 c2                	cmp    %eax,%edx
  801681:	74 0d                	je     801690 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801683:	ff 45 08             	incl   0x8(%ebp)
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80168c:	72 e3                	jb     801671 <memfind+0x13>
  80168e:	eb 01                	jmp    801691 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801690:	90                   	nop
	return (void *) s;
  801691:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801694:	c9                   	leave  
  801695:	c3                   	ret    

00801696 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801696:	55                   	push   %ebp
  801697:	89 e5                	mov    %esp,%ebp
  801699:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80169c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016a3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016aa:	eb 03                	jmp    8016af <strtol+0x19>
		s++;
  8016ac:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	8a 00                	mov    (%eax),%al
  8016b4:	3c 20                	cmp    $0x20,%al
  8016b6:	74 f4                	je     8016ac <strtol+0x16>
  8016b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bb:	8a 00                	mov    (%eax),%al
  8016bd:	3c 09                	cmp    $0x9,%al
  8016bf:	74 eb                	je     8016ac <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c4:	8a 00                	mov    (%eax),%al
  8016c6:	3c 2b                	cmp    $0x2b,%al
  8016c8:	75 05                	jne    8016cf <strtol+0x39>
		s++;
  8016ca:	ff 45 08             	incl   0x8(%ebp)
  8016cd:	eb 13                	jmp    8016e2 <strtol+0x4c>
	else if (*s == '-')
  8016cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d2:	8a 00                	mov    (%eax),%al
  8016d4:	3c 2d                	cmp    $0x2d,%al
  8016d6:	75 0a                	jne    8016e2 <strtol+0x4c>
		s++, neg = 1;
  8016d8:	ff 45 08             	incl   0x8(%ebp)
  8016db:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016e6:	74 06                	je     8016ee <strtol+0x58>
  8016e8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016ec:	75 20                	jne    80170e <strtol+0x78>
  8016ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f1:	8a 00                	mov    (%eax),%al
  8016f3:	3c 30                	cmp    $0x30,%al
  8016f5:	75 17                	jne    80170e <strtol+0x78>
  8016f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fa:	40                   	inc    %eax
  8016fb:	8a 00                	mov    (%eax),%al
  8016fd:	3c 78                	cmp    $0x78,%al
  8016ff:	75 0d                	jne    80170e <strtol+0x78>
		s += 2, base = 16;
  801701:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801705:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80170c:	eb 28                	jmp    801736 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80170e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801712:	75 15                	jne    801729 <strtol+0x93>
  801714:	8b 45 08             	mov    0x8(%ebp),%eax
  801717:	8a 00                	mov    (%eax),%al
  801719:	3c 30                	cmp    $0x30,%al
  80171b:	75 0c                	jne    801729 <strtol+0x93>
		s++, base = 8;
  80171d:	ff 45 08             	incl   0x8(%ebp)
  801720:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801727:	eb 0d                	jmp    801736 <strtol+0xa0>
	else if (base == 0)
  801729:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80172d:	75 07                	jne    801736 <strtol+0xa0>
		base = 10;
  80172f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	8a 00                	mov    (%eax),%al
  80173b:	3c 2f                	cmp    $0x2f,%al
  80173d:	7e 19                	jle    801758 <strtol+0xc2>
  80173f:	8b 45 08             	mov    0x8(%ebp),%eax
  801742:	8a 00                	mov    (%eax),%al
  801744:	3c 39                	cmp    $0x39,%al
  801746:	7f 10                	jg     801758 <strtol+0xc2>
			dig = *s - '0';
  801748:	8b 45 08             	mov    0x8(%ebp),%eax
  80174b:	8a 00                	mov    (%eax),%al
  80174d:	0f be c0             	movsbl %al,%eax
  801750:	83 e8 30             	sub    $0x30,%eax
  801753:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801756:	eb 42                	jmp    80179a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801758:	8b 45 08             	mov    0x8(%ebp),%eax
  80175b:	8a 00                	mov    (%eax),%al
  80175d:	3c 60                	cmp    $0x60,%al
  80175f:	7e 19                	jle    80177a <strtol+0xe4>
  801761:	8b 45 08             	mov    0x8(%ebp),%eax
  801764:	8a 00                	mov    (%eax),%al
  801766:	3c 7a                	cmp    $0x7a,%al
  801768:	7f 10                	jg     80177a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80176a:	8b 45 08             	mov    0x8(%ebp),%eax
  80176d:	8a 00                	mov    (%eax),%al
  80176f:	0f be c0             	movsbl %al,%eax
  801772:	83 e8 57             	sub    $0x57,%eax
  801775:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801778:	eb 20                	jmp    80179a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80177a:	8b 45 08             	mov    0x8(%ebp),%eax
  80177d:	8a 00                	mov    (%eax),%al
  80177f:	3c 40                	cmp    $0x40,%al
  801781:	7e 39                	jle    8017bc <strtol+0x126>
  801783:	8b 45 08             	mov    0x8(%ebp),%eax
  801786:	8a 00                	mov    (%eax),%al
  801788:	3c 5a                	cmp    $0x5a,%al
  80178a:	7f 30                	jg     8017bc <strtol+0x126>
			dig = *s - 'A' + 10;
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	8a 00                	mov    (%eax),%al
  801791:	0f be c0             	movsbl %al,%eax
  801794:	83 e8 37             	sub    $0x37,%eax
  801797:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80179a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80179d:	3b 45 10             	cmp    0x10(%ebp),%eax
  8017a0:	7d 19                	jge    8017bb <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8017a2:	ff 45 08             	incl   0x8(%ebp)
  8017a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a8:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017ac:	89 c2                	mov    %eax,%edx
  8017ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017b1:	01 d0                	add    %edx,%eax
  8017b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017b6:	e9 7b ff ff ff       	jmp    801736 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017bb:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017bc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017c0:	74 08                	je     8017ca <strtol+0x134>
		*endptr = (char *) s;
  8017c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8017c8:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017ca:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017ce:	74 07                	je     8017d7 <strtol+0x141>
  8017d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d3:	f7 d8                	neg    %eax
  8017d5:	eb 03                	jmp    8017da <strtol+0x144>
  8017d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017da:	c9                   	leave  
  8017db:	c3                   	ret    

008017dc <ltostr>:

void
ltostr(long value, char *str)
{
  8017dc:	55                   	push   %ebp
  8017dd:	89 e5                	mov    %esp,%ebp
  8017df:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017e9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017f0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017f4:	79 13                	jns    801809 <ltostr+0x2d>
	{
		neg = 1;
  8017f6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801800:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801803:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801806:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801809:	8b 45 08             	mov    0x8(%ebp),%eax
  80180c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801811:	99                   	cltd   
  801812:	f7 f9                	idiv   %ecx
  801814:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801817:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80181a:	8d 50 01             	lea    0x1(%eax),%edx
  80181d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801820:	89 c2                	mov    %eax,%edx
  801822:	8b 45 0c             	mov    0xc(%ebp),%eax
  801825:	01 d0                	add    %edx,%eax
  801827:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80182a:	83 c2 30             	add    $0x30,%edx
  80182d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80182f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801832:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801837:	f7 e9                	imul   %ecx
  801839:	c1 fa 02             	sar    $0x2,%edx
  80183c:	89 c8                	mov    %ecx,%eax
  80183e:	c1 f8 1f             	sar    $0x1f,%eax
  801841:	29 c2                	sub    %eax,%edx
  801843:	89 d0                	mov    %edx,%eax
  801845:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801848:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80184b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801850:	f7 e9                	imul   %ecx
  801852:	c1 fa 02             	sar    $0x2,%edx
  801855:	89 c8                	mov    %ecx,%eax
  801857:	c1 f8 1f             	sar    $0x1f,%eax
  80185a:	29 c2                	sub    %eax,%edx
  80185c:	89 d0                	mov    %edx,%eax
  80185e:	c1 e0 02             	shl    $0x2,%eax
  801861:	01 d0                	add    %edx,%eax
  801863:	01 c0                	add    %eax,%eax
  801865:	29 c1                	sub    %eax,%ecx
  801867:	89 ca                	mov    %ecx,%edx
  801869:	85 d2                	test   %edx,%edx
  80186b:	75 9c                	jne    801809 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80186d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801874:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801877:	48                   	dec    %eax
  801878:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80187b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80187f:	74 3d                	je     8018be <ltostr+0xe2>
		start = 1 ;
  801881:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801888:	eb 34                	jmp    8018be <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80188a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80188d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801890:	01 d0                	add    %edx,%eax
  801892:	8a 00                	mov    (%eax),%al
  801894:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801897:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80189a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80189d:	01 c2                	add    %eax,%edx
  80189f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8018a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a5:	01 c8                	add    %ecx,%eax
  8018a7:	8a 00                	mov    (%eax),%al
  8018a9:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018ab:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b1:	01 c2                	add    %eax,%edx
  8018b3:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018b6:	88 02                	mov    %al,(%edx)
		start++ ;
  8018b8:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018bb:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018c4:	7c c4                	jl     80188a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018cc:	01 d0                	add    %edx,%eax
  8018ce:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018d1:	90                   	nop
  8018d2:	c9                   	leave  
  8018d3:	c3                   	ret    

008018d4 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018d4:	55                   	push   %ebp
  8018d5:	89 e5                	mov    %esp,%ebp
  8018d7:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018da:	ff 75 08             	pushl  0x8(%ebp)
  8018dd:	e8 54 fa ff ff       	call   801336 <strlen>
  8018e2:	83 c4 04             	add    $0x4,%esp
  8018e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018e8:	ff 75 0c             	pushl  0xc(%ebp)
  8018eb:	e8 46 fa ff ff       	call   801336 <strlen>
  8018f0:	83 c4 04             	add    $0x4,%esp
  8018f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801904:	eb 17                	jmp    80191d <strcconcat+0x49>
		final[s] = str1[s] ;
  801906:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801909:	8b 45 10             	mov    0x10(%ebp),%eax
  80190c:	01 c2                	add    %eax,%edx
  80190e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	01 c8                	add    %ecx,%eax
  801916:	8a 00                	mov    (%eax),%al
  801918:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80191a:	ff 45 fc             	incl   -0x4(%ebp)
  80191d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801920:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801923:	7c e1                	jl     801906 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801925:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80192c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801933:	eb 1f                	jmp    801954 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801935:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801938:	8d 50 01             	lea    0x1(%eax),%edx
  80193b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80193e:	89 c2                	mov    %eax,%edx
  801940:	8b 45 10             	mov    0x10(%ebp),%eax
  801943:	01 c2                	add    %eax,%edx
  801945:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801948:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194b:	01 c8                	add    %ecx,%eax
  80194d:	8a 00                	mov    (%eax),%al
  80194f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801951:	ff 45 f8             	incl   -0x8(%ebp)
  801954:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801957:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80195a:	7c d9                	jl     801935 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80195c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80195f:	8b 45 10             	mov    0x10(%ebp),%eax
  801962:	01 d0                	add    %edx,%eax
  801964:	c6 00 00             	movb   $0x0,(%eax)
}
  801967:	90                   	nop
  801968:	c9                   	leave  
  801969:	c3                   	ret    

0080196a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80196a:	55                   	push   %ebp
  80196b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80196d:	8b 45 14             	mov    0x14(%ebp),%eax
  801970:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801976:	8b 45 14             	mov    0x14(%ebp),%eax
  801979:	8b 00                	mov    (%eax),%eax
  80197b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801982:	8b 45 10             	mov    0x10(%ebp),%eax
  801985:	01 d0                	add    %edx,%eax
  801987:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80198d:	eb 0c                	jmp    80199b <strsplit+0x31>
			*string++ = 0;
  80198f:	8b 45 08             	mov    0x8(%ebp),%eax
  801992:	8d 50 01             	lea    0x1(%eax),%edx
  801995:	89 55 08             	mov    %edx,0x8(%ebp)
  801998:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80199b:	8b 45 08             	mov    0x8(%ebp),%eax
  80199e:	8a 00                	mov    (%eax),%al
  8019a0:	84 c0                	test   %al,%al
  8019a2:	74 18                	je     8019bc <strsplit+0x52>
  8019a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a7:	8a 00                	mov    (%eax),%al
  8019a9:	0f be c0             	movsbl %al,%eax
  8019ac:	50                   	push   %eax
  8019ad:	ff 75 0c             	pushl  0xc(%ebp)
  8019b0:	e8 13 fb ff ff       	call   8014c8 <strchr>
  8019b5:	83 c4 08             	add    $0x8,%esp
  8019b8:	85 c0                	test   %eax,%eax
  8019ba:	75 d3                	jne    80198f <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8019bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bf:	8a 00                	mov    (%eax),%al
  8019c1:	84 c0                	test   %al,%al
  8019c3:	74 5a                	je     801a1f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8019c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8019c8:	8b 00                	mov    (%eax),%eax
  8019ca:	83 f8 0f             	cmp    $0xf,%eax
  8019cd:	75 07                	jne    8019d6 <strsplit+0x6c>
		{
			return 0;
  8019cf:	b8 00 00 00 00       	mov    $0x0,%eax
  8019d4:	eb 66                	jmp    801a3c <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8019d9:	8b 00                	mov    (%eax),%eax
  8019db:	8d 48 01             	lea    0x1(%eax),%ecx
  8019de:	8b 55 14             	mov    0x14(%ebp),%edx
  8019e1:	89 0a                	mov    %ecx,(%edx)
  8019e3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ed:	01 c2                	add    %eax,%edx
  8019ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019f4:	eb 03                	jmp    8019f9 <strsplit+0x8f>
			string++;
  8019f6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fc:	8a 00                	mov    (%eax),%al
  8019fe:	84 c0                	test   %al,%al
  801a00:	74 8b                	je     80198d <strsplit+0x23>
  801a02:	8b 45 08             	mov    0x8(%ebp),%eax
  801a05:	8a 00                	mov    (%eax),%al
  801a07:	0f be c0             	movsbl %al,%eax
  801a0a:	50                   	push   %eax
  801a0b:	ff 75 0c             	pushl  0xc(%ebp)
  801a0e:	e8 b5 fa ff ff       	call   8014c8 <strchr>
  801a13:	83 c4 08             	add    $0x8,%esp
  801a16:	85 c0                	test   %eax,%eax
  801a18:	74 dc                	je     8019f6 <strsplit+0x8c>
			string++;
	}
  801a1a:	e9 6e ff ff ff       	jmp    80198d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a1f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a20:	8b 45 14             	mov    0x14(%ebp),%eax
  801a23:	8b 00                	mov    (%eax),%eax
  801a25:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a2c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a2f:	01 d0                	add    %edx,%eax
  801a31:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a37:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a3c:	c9                   	leave  
  801a3d:	c3                   	ret    

00801a3e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a3e:	55                   	push   %ebp
  801a3f:	89 e5                	mov    %esp,%ebp
  801a41:	57                   	push   %edi
  801a42:	56                   	push   %esi
  801a43:	53                   	push   %ebx
  801a44:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a47:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a4d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a50:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a53:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a56:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a59:	cd 30                	int    $0x30
  801a5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a61:	83 c4 10             	add    $0x10,%esp
  801a64:	5b                   	pop    %ebx
  801a65:	5e                   	pop    %esi
  801a66:	5f                   	pop    %edi
  801a67:	5d                   	pop    %ebp
  801a68:	c3                   	ret    

00801a69 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a69:	55                   	push   %ebp
  801a6a:	89 e5                	mov    %esp,%ebp
  801a6c:	83 ec 04             	sub    $0x4,%esp
  801a6f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a72:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a75:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a79:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	52                   	push   %edx
  801a81:	ff 75 0c             	pushl  0xc(%ebp)
  801a84:	50                   	push   %eax
  801a85:	6a 00                	push   $0x0
  801a87:	e8 b2 ff ff ff       	call   801a3e <syscall>
  801a8c:	83 c4 18             	add    $0x18,%esp
}
  801a8f:	90                   	nop
  801a90:	c9                   	leave  
  801a91:	c3                   	ret    

00801a92 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a92:	55                   	push   %ebp
  801a93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 01                	push   $0x1
  801aa1:	e8 98 ff ff ff       	call   801a3e <syscall>
  801aa6:	83 c4 18             	add    $0x18,%esp
}
  801aa9:	c9                   	leave  
  801aaa:	c3                   	ret    

00801aab <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801aab:	55                   	push   %ebp
  801aac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801aae:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	50                   	push   %eax
  801aba:	6a 05                	push   $0x5
  801abc:	e8 7d ff ff ff       	call   801a3e <syscall>
  801ac1:	83 c4 18             	add    $0x18,%esp
}
  801ac4:	c9                   	leave  
  801ac5:	c3                   	ret    

00801ac6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ac6:	55                   	push   %ebp
  801ac7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 02                	push   $0x2
  801ad5:	e8 64 ff ff ff       	call   801a3e <syscall>
  801ada:	83 c4 18             	add    $0x18,%esp
}
  801add:	c9                   	leave  
  801ade:	c3                   	ret    

00801adf <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801adf:	55                   	push   %ebp
  801ae0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 03                	push   $0x3
  801aee:	e8 4b ff ff ff       	call   801a3e <syscall>
  801af3:	83 c4 18             	add    $0x18,%esp
}
  801af6:	c9                   	leave  
  801af7:	c3                   	ret    

00801af8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801af8:	55                   	push   %ebp
  801af9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801afb:	6a 00                	push   $0x0
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 04                	push   $0x4
  801b07:	e8 32 ff ff ff       	call   801a3e <syscall>
  801b0c:	83 c4 18             	add    $0x18,%esp
}
  801b0f:	c9                   	leave  
  801b10:	c3                   	ret    

00801b11 <sys_env_exit>:


void sys_env_exit(void)
{
  801b11:	55                   	push   %ebp
  801b12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 06                	push   $0x6
  801b20:	e8 19 ff ff ff       	call   801a3e <syscall>
  801b25:	83 c4 18             	add    $0x18,%esp
}
  801b28:	90                   	nop
  801b29:	c9                   	leave  
  801b2a:	c3                   	ret    

00801b2b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b31:	8b 45 08             	mov    0x8(%ebp),%eax
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	52                   	push   %edx
  801b3b:	50                   	push   %eax
  801b3c:	6a 07                	push   $0x7
  801b3e:	e8 fb fe ff ff       	call   801a3e <syscall>
  801b43:	83 c4 18             	add    $0x18,%esp
}
  801b46:	c9                   	leave  
  801b47:	c3                   	ret    

00801b48 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b48:	55                   	push   %ebp
  801b49:	89 e5                	mov    %esp,%ebp
  801b4b:	56                   	push   %esi
  801b4c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b4d:	8b 75 18             	mov    0x18(%ebp),%esi
  801b50:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b53:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b59:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5c:	56                   	push   %esi
  801b5d:	53                   	push   %ebx
  801b5e:	51                   	push   %ecx
  801b5f:	52                   	push   %edx
  801b60:	50                   	push   %eax
  801b61:	6a 08                	push   $0x8
  801b63:	e8 d6 fe ff ff       	call   801a3e <syscall>
  801b68:	83 c4 18             	add    $0x18,%esp
}
  801b6b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b6e:	5b                   	pop    %ebx
  801b6f:	5e                   	pop    %esi
  801b70:	5d                   	pop    %ebp
  801b71:	c3                   	ret    

00801b72 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b75:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b78:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	52                   	push   %edx
  801b82:	50                   	push   %eax
  801b83:	6a 09                	push   $0x9
  801b85:	e8 b4 fe ff ff       	call   801a3e <syscall>
  801b8a:	83 c4 18             	add    $0x18,%esp
}
  801b8d:	c9                   	leave  
  801b8e:	c3                   	ret    

00801b8f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b8f:	55                   	push   %ebp
  801b90:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	ff 75 0c             	pushl  0xc(%ebp)
  801b9b:	ff 75 08             	pushl  0x8(%ebp)
  801b9e:	6a 0a                	push   $0xa
  801ba0:	e8 99 fe ff ff       	call   801a3e <syscall>
  801ba5:	83 c4 18             	add    $0x18,%esp
}
  801ba8:	c9                   	leave  
  801ba9:	c3                   	ret    

00801baa <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801baa:	55                   	push   %ebp
  801bab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 0b                	push   $0xb
  801bb9:	e8 80 fe ff ff       	call   801a3e <syscall>
  801bbe:	83 c4 18             	add    $0x18,%esp
}
  801bc1:	c9                   	leave  
  801bc2:	c3                   	ret    

00801bc3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801bc3:	55                   	push   %ebp
  801bc4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 0c                	push   $0xc
  801bd2:	e8 67 fe ff ff       	call   801a3e <syscall>
  801bd7:	83 c4 18             	add    $0x18,%esp
}
  801bda:	c9                   	leave  
  801bdb:	c3                   	ret    

00801bdc <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801bdc:	55                   	push   %ebp
  801bdd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 0d                	push   $0xd
  801beb:	e8 4e fe ff ff       	call   801a3e <syscall>
  801bf0:	83 c4 18             	add    $0x18,%esp
}
  801bf3:	c9                   	leave  
  801bf4:	c3                   	ret    

00801bf5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801bf5:	55                   	push   %ebp
  801bf6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	ff 75 0c             	pushl  0xc(%ebp)
  801c01:	ff 75 08             	pushl  0x8(%ebp)
  801c04:	6a 11                	push   $0x11
  801c06:	e8 33 fe ff ff       	call   801a3e <syscall>
  801c0b:	83 c4 18             	add    $0x18,%esp
	return;
  801c0e:	90                   	nop
}
  801c0f:	c9                   	leave  
  801c10:	c3                   	ret    

00801c11 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c11:	55                   	push   %ebp
  801c12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	ff 75 0c             	pushl  0xc(%ebp)
  801c1d:	ff 75 08             	pushl  0x8(%ebp)
  801c20:	6a 12                	push   $0x12
  801c22:	e8 17 fe ff ff       	call   801a3e <syscall>
  801c27:	83 c4 18             	add    $0x18,%esp
	return ;
  801c2a:	90                   	nop
}
  801c2b:	c9                   	leave  
  801c2c:	c3                   	ret    

00801c2d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c2d:	55                   	push   %ebp
  801c2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 0e                	push   $0xe
  801c3c:	e8 fd fd ff ff       	call   801a3e <syscall>
  801c41:	83 c4 18             	add    $0x18,%esp
}
  801c44:	c9                   	leave  
  801c45:	c3                   	ret    

00801c46 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c46:	55                   	push   %ebp
  801c47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	ff 75 08             	pushl  0x8(%ebp)
  801c54:	6a 0f                	push   $0xf
  801c56:	e8 e3 fd ff ff       	call   801a3e <syscall>
  801c5b:	83 c4 18             	add    $0x18,%esp
}
  801c5e:	c9                   	leave  
  801c5f:	c3                   	ret    

00801c60 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c60:	55                   	push   %ebp
  801c61:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 10                	push   $0x10
  801c6f:	e8 ca fd ff ff       	call   801a3e <syscall>
  801c74:	83 c4 18             	add    $0x18,%esp
}
  801c77:	90                   	nop
  801c78:	c9                   	leave  
  801c79:	c3                   	ret    

00801c7a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c7a:	55                   	push   %ebp
  801c7b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	6a 14                	push   $0x14
  801c89:	e8 b0 fd ff ff       	call   801a3e <syscall>
  801c8e:	83 c4 18             	add    $0x18,%esp
}
  801c91:	90                   	nop
  801c92:	c9                   	leave  
  801c93:	c3                   	ret    

00801c94 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c94:	55                   	push   %ebp
  801c95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 00                	push   $0x0
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 15                	push   $0x15
  801ca3:	e8 96 fd ff ff       	call   801a3e <syscall>
  801ca8:	83 c4 18             	add    $0x18,%esp
}
  801cab:	90                   	nop
  801cac:	c9                   	leave  
  801cad:	c3                   	ret    

00801cae <sys_cputc>:


void
sys_cputc(const char c)
{
  801cae:	55                   	push   %ebp
  801caf:	89 e5                	mov    %esp,%ebp
  801cb1:	83 ec 04             	sub    $0x4,%esp
  801cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801cba:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	50                   	push   %eax
  801cc7:	6a 16                	push   $0x16
  801cc9:	e8 70 fd ff ff       	call   801a3e <syscall>
  801cce:	83 c4 18             	add    $0x18,%esp
}
  801cd1:	90                   	nop
  801cd2:	c9                   	leave  
  801cd3:	c3                   	ret    

00801cd4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801cd4:	55                   	push   %ebp
  801cd5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 17                	push   $0x17
  801ce3:	e8 56 fd ff ff       	call   801a3e <syscall>
  801ce8:	83 c4 18             	add    $0x18,%esp
}
  801ceb:	90                   	nop
  801cec:	c9                   	leave  
  801ced:	c3                   	ret    

00801cee <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801cee:	55                   	push   %ebp
  801cef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	ff 75 0c             	pushl  0xc(%ebp)
  801cfd:	50                   	push   %eax
  801cfe:	6a 18                	push   $0x18
  801d00:	e8 39 fd ff ff       	call   801a3e <syscall>
  801d05:	83 c4 18             	add    $0x18,%esp
}
  801d08:	c9                   	leave  
  801d09:	c3                   	ret    

00801d0a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d0a:	55                   	push   %ebp
  801d0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d10:	8b 45 08             	mov    0x8(%ebp),%eax
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	6a 00                	push   $0x0
  801d19:	52                   	push   %edx
  801d1a:	50                   	push   %eax
  801d1b:	6a 1b                	push   $0x1b
  801d1d:	e8 1c fd ff ff       	call   801a3e <syscall>
  801d22:	83 c4 18             	add    $0x18,%esp
}
  801d25:	c9                   	leave  
  801d26:	c3                   	ret    

00801d27 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d27:	55                   	push   %ebp
  801d28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	52                   	push   %edx
  801d37:	50                   	push   %eax
  801d38:	6a 19                	push   $0x19
  801d3a:	e8 ff fc ff ff       	call   801a3e <syscall>
  801d3f:	83 c4 18             	add    $0x18,%esp
}
  801d42:	90                   	nop
  801d43:	c9                   	leave  
  801d44:	c3                   	ret    

00801d45 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d45:	55                   	push   %ebp
  801d46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d48:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	6a 00                	push   $0x0
  801d54:	52                   	push   %edx
  801d55:	50                   	push   %eax
  801d56:	6a 1a                	push   $0x1a
  801d58:	e8 e1 fc ff ff       	call   801a3e <syscall>
  801d5d:	83 c4 18             	add    $0x18,%esp
}
  801d60:	90                   	nop
  801d61:	c9                   	leave  
  801d62:	c3                   	ret    

00801d63 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d63:	55                   	push   %ebp
  801d64:	89 e5                	mov    %esp,%ebp
  801d66:	83 ec 04             	sub    $0x4,%esp
  801d69:	8b 45 10             	mov    0x10(%ebp),%eax
  801d6c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d6f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d72:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d76:	8b 45 08             	mov    0x8(%ebp),%eax
  801d79:	6a 00                	push   $0x0
  801d7b:	51                   	push   %ecx
  801d7c:	52                   	push   %edx
  801d7d:	ff 75 0c             	pushl  0xc(%ebp)
  801d80:	50                   	push   %eax
  801d81:	6a 1c                	push   $0x1c
  801d83:	e8 b6 fc ff ff       	call   801a3e <syscall>
  801d88:	83 c4 18             	add    $0x18,%esp
}
  801d8b:	c9                   	leave  
  801d8c:	c3                   	ret    

00801d8d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d8d:	55                   	push   %ebp
  801d8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d90:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d93:	8b 45 08             	mov    0x8(%ebp),%eax
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	52                   	push   %edx
  801d9d:	50                   	push   %eax
  801d9e:	6a 1d                	push   $0x1d
  801da0:	e8 99 fc ff ff       	call   801a3e <syscall>
  801da5:	83 c4 18             	add    $0x18,%esp
}
  801da8:	c9                   	leave  
  801da9:	c3                   	ret    

00801daa <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801daa:	55                   	push   %ebp
  801dab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801dad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801db0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db3:	8b 45 08             	mov    0x8(%ebp),%eax
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	51                   	push   %ecx
  801dbb:	52                   	push   %edx
  801dbc:	50                   	push   %eax
  801dbd:	6a 1e                	push   $0x1e
  801dbf:	e8 7a fc ff ff       	call   801a3e <syscall>
  801dc4:	83 c4 18             	add    $0x18,%esp
}
  801dc7:	c9                   	leave  
  801dc8:	c3                   	ret    

00801dc9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801dc9:	55                   	push   %ebp
  801dca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801dcc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	52                   	push   %edx
  801dd9:	50                   	push   %eax
  801dda:	6a 1f                	push   $0x1f
  801ddc:	e8 5d fc ff ff       	call   801a3e <syscall>
  801de1:	83 c4 18             	add    $0x18,%esp
}
  801de4:	c9                   	leave  
  801de5:	c3                   	ret    

00801de6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801de6:	55                   	push   %ebp
  801de7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 20                	push   $0x20
  801df5:	e8 44 fc ff ff       	call   801a3e <syscall>
  801dfa:	83 c4 18             	add    $0x18,%esp
}
  801dfd:	c9                   	leave  
  801dfe:	c3                   	ret    

00801dff <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801dff:	55                   	push   %ebp
  801e00:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e02:	8b 45 08             	mov    0x8(%ebp),%eax
  801e05:	6a 00                	push   $0x0
  801e07:	ff 75 14             	pushl  0x14(%ebp)
  801e0a:	ff 75 10             	pushl  0x10(%ebp)
  801e0d:	ff 75 0c             	pushl  0xc(%ebp)
  801e10:	50                   	push   %eax
  801e11:	6a 21                	push   $0x21
  801e13:	e8 26 fc ff ff       	call   801a3e <syscall>
  801e18:	83 c4 18             	add    $0x18,%esp
}
  801e1b:	c9                   	leave  
  801e1c:	c3                   	ret    

00801e1d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801e1d:	55                   	push   %ebp
  801e1e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e20:	8b 45 08             	mov    0x8(%ebp),%eax
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	50                   	push   %eax
  801e2c:	6a 22                	push   $0x22
  801e2e:	e8 0b fc ff ff       	call   801a3e <syscall>
  801e33:	83 c4 18             	add    $0x18,%esp
}
  801e36:	90                   	nop
  801e37:	c9                   	leave  
  801e38:	c3                   	ret    

00801e39 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e39:	55                   	push   %ebp
  801e3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	50                   	push   %eax
  801e48:	6a 23                	push   $0x23
  801e4a:	e8 ef fb ff ff       	call   801a3e <syscall>
  801e4f:	83 c4 18             	add    $0x18,%esp
}
  801e52:	90                   	nop
  801e53:	c9                   	leave  
  801e54:	c3                   	ret    

00801e55 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e55:	55                   	push   %ebp
  801e56:	89 e5                	mov    %esp,%ebp
  801e58:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e5b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e5e:	8d 50 04             	lea    0x4(%eax),%edx
  801e61:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	52                   	push   %edx
  801e6b:	50                   	push   %eax
  801e6c:	6a 24                	push   $0x24
  801e6e:	e8 cb fb ff ff       	call   801a3e <syscall>
  801e73:	83 c4 18             	add    $0x18,%esp
	return result;
  801e76:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e7c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e7f:	89 01                	mov    %eax,(%ecx)
  801e81:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e84:	8b 45 08             	mov    0x8(%ebp),%eax
  801e87:	c9                   	leave  
  801e88:	c2 04 00             	ret    $0x4

00801e8b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e8b:	55                   	push   %ebp
  801e8c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	ff 75 10             	pushl  0x10(%ebp)
  801e95:	ff 75 0c             	pushl  0xc(%ebp)
  801e98:	ff 75 08             	pushl  0x8(%ebp)
  801e9b:	6a 13                	push   $0x13
  801e9d:	e8 9c fb ff ff       	call   801a3e <syscall>
  801ea2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ea5:	90                   	nop
}
  801ea6:	c9                   	leave  
  801ea7:	c3                   	ret    

00801ea8 <sys_rcr2>:
uint32 sys_rcr2()
{
  801ea8:	55                   	push   %ebp
  801ea9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 25                	push   $0x25
  801eb7:	e8 82 fb ff ff       	call   801a3e <syscall>
  801ebc:	83 c4 18             	add    $0x18,%esp
}
  801ebf:	c9                   	leave  
  801ec0:	c3                   	ret    

00801ec1 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ec1:	55                   	push   %ebp
  801ec2:	89 e5                	mov    %esp,%ebp
  801ec4:	83 ec 04             	sub    $0x4,%esp
  801ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eca:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ecd:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 00                	push   $0x0
  801ed9:	50                   	push   %eax
  801eda:	6a 26                	push   $0x26
  801edc:	e8 5d fb ff ff       	call   801a3e <syscall>
  801ee1:	83 c4 18             	add    $0x18,%esp
	return ;
  801ee4:	90                   	nop
}
  801ee5:	c9                   	leave  
  801ee6:	c3                   	ret    

00801ee7 <rsttst>:
void rsttst()
{
  801ee7:	55                   	push   %ebp
  801ee8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 28                	push   $0x28
  801ef6:	e8 43 fb ff ff       	call   801a3e <syscall>
  801efb:	83 c4 18             	add    $0x18,%esp
	return ;
  801efe:	90                   	nop
}
  801eff:	c9                   	leave  
  801f00:	c3                   	ret    

00801f01 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f01:	55                   	push   %ebp
  801f02:	89 e5                	mov    %esp,%ebp
  801f04:	83 ec 04             	sub    $0x4,%esp
  801f07:	8b 45 14             	mov    0x14(%ebp),%eax
  801f0a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f0d:	8b 55 18             	mov    0x18(%ebp),%edx
  801f10:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f14:	52                   	push   %edx
  801f15:	50                   	push   %eax
  801f16:	ff 75 10             	pushl  0x10(%ebp)
  801f19:	ff 75 0c             	pushl  0xc(%ebp)
  801f1c:	ff 75 08             	pushl  0x8(%ebp)
  801f1f:	6a 27                	push   $0x27
  801f21:	e8 18 fb ff ff       	call   801a3e <syscall>
  801f26:	83 c4 18             	add    $0x18,%esp
	return ;
  801f29:	90                   	nop
}
  801f2a:	c9                   	leave  
  801f2b:	c3                   	ret    

00801f2c <chktst>:
void chktst(uint32 n)
{
  801f2c:	55                   	push   %ebp
  801f2d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	ff 75 08             	pushl  0x8(%ebp)
  801f3a:	6a 29                	push   $0x29
  801f3c:	e8 fd fa ff ff       	call   801a3e <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
	return ;
  801f44:	90                   	nop
}
  801f45:	c9                   	leave  
  801f46:	c3                   	ret    

00801f47 <inctst>:

void inctst()
{
  801f47:	55                   	push   %ebp
  801f48:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f4a:	6a 00                	push   $0x0
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 2a                	push   $0x2a
  801f56:	e8 e3 fa ff ff       	call   801a3e <syscall>
  801f5b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f5e:	90                   	nop
}
  801f5f:	c9                   	leave  
  801f60:	c3                   	ret    

00801f61 <gettst>:
uint32 gettst()
{
  801f61:	55                   	push   %ebp
  801f62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 00                	push   $0x0
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 2b                	push   $0x2b
  801f70:	e8 c9 fa ff ff       	call   801a3e <syscall>
  801f75:	83 c4 18             	add    $0x18,%esp
}
  801f78:	c9                   	leave  
  801f79:	c3                   	ret    

00801f7a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f7a:	55                   	push   %ebp
  801f7b:	89 e5                	mov    %esp,%ebp
  801f7d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 2c                	push   $0x2c
  801f8c:	e8 ad fa ff ff       	call   801a3e <syscall>
  801f91:	83 c4 18             	add    $0x18,%esp
  801f94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f97:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f9b:	75 07                	jne    801fa4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f9d:	b8 01 00 00 00       	mov    $0x1,%eax
  801fa2:	eb 05                	jmp    801fa9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801fa4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fa9:	c9                   	leave  
  801faa:	c3                   	ret    

00801fab <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801fab:	55                   	push   %ebp
  801fac:	89 e5                	mov    %esp,%ebp
  801fae:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 2c                	push   $0x2c
  801fbd:	e8 7c fa ff ff       	call   801a3e <syscall>
  801fc2:	83 c4 18             	add    $0x18,%esp
  801fc5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801fc8:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801fcc:	75 07                	jne    801fd5 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801fce:	b8 01 00 00 00       	mov    $0x1,%eax
  801fd3:	eb 05                	jmp    801fda <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801fd5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fda:	c9                   	leave  
  801fdb:	c3                   	ret    

00801fdc <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801fdc:	55                   	push   %ebp
  801fdd:	89 e5                	mov    %esp,%ebp
  801fdf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 2c                	push   $0x2c
  801fee:	e8 4b fa ff ff       	call   801a3e <syscall>
  801ff3:	83 c4 18             	add    $0x18,%esp
  801ff6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ff9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ffd:	75 07                	jne    802006 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801fff:	b8 01 00 00 00       	mov    $0x1,%eax
  802004:	eb 05                	jmp    80200b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802006:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80200b:	c9                   	leave  
  80200c:	c3                   	ret    

0080200d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80200d:	55                   	push   %ebp
  80200e:	89 e5                	mov    %esp,%ebp
  802010:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	6a 2c                	push   $0x2c
  80201f:	e8 1a fa ff ff       	call   801a3e <syscall>
  802024:	83 c4 18             	add    $0x18,%esp
  802027:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80202a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80202e:	75 07                	jne    802037 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802030:	b8 01 00 00 00       	mov    $0x1,%eax
  802035:	eb 05                	jmp    80203c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802037:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80203c:	c9                   	leave  
  80203d:	c3                   	ret    

0080203e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80203e:	55                   	push   %ebp
  80203f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	ff 75 08             	pushl  0x8(%ebp)
  80204c:	6a 2d                	push   $0x2d
  80204e:	e8 eb f9 ff ff       	call   801a3e <syscall>
  802053:	83 c4 18             	add    $0x18,%esp
	return ;
  802056:	90                   	nop
}
  802057:	c9                   	leave  
  802058:	c3                   	ret    

00802059 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802059:	55                   	push   %ebp
  80205a:	89 e5                	mov    %esp,%ebp
  80205c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80205d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802060:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802063:	8b 55 0c             	mov    0xc(%ebp),%edx
  802066:	8b 45 08             	mov    0x8(%ebp),%eax
  802069:	6a 00                	push   $0x0
  80206b:	53                   	push   %ebx
  80206c:	51                   	push   %ecx
  80206d:	52                   	push   %edx
  80206e:	50                   	push   %eax
  80206f:	6a 2e                	push   $0x2e
  802071:	e8 c8 f9 ff ff       	call   801a3e <syscall>
  802076:	83 c4 18             	add    $0x18,%esp
}
  802079:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80207c:	c9                   	leave  
  80207d:	c3                   	ret    

0080207e <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80207e:	55                   	push   %ebp
  80207f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802081:	8b 55 0c             	mov    0xc(%ebp),%edx
  802084:	8b 45 08             	mov    0x8(%ebp),%eax
  802087:	6a 00                	push   $0x0
  802089:	6a 00                	push   $0x0
  80208b:	6a 00                	push   $0x0
  80208d:	52                   	push   %edx
  80208e:	50                   	push   %eax
  80208f:	6a 2f                	push   $0x2f
  802091:	e8 a8 f9 ff ff       	call   801a3e <syscall>
  802096:	83 c4 18             	add    $0x18,%esp
}
  802099:	c9                   	leave  
  80209a:	c3                   	ret    
  80209b:	90                   	nop

0080209c <__udivdi3>:
  80209c:	55                   	push   %ebp
  80209d:	57                   	push   %edi
  80209e:	56                   	push   %esi
  80209f:	53                   	push   %ebx
  8020a0:	83 ec 1c             	sub    $0x1c,%esp
  8020a3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8020a7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8020ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020af:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8020b3:	89 ca                	mov    %ecx,%edx
  8020b5:	89 f8                	mov    %edi,%eax
  8020b7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8020bb:	85 f6                	test   %esi,%esi
  8020bd:	75 2d                	jne    8020ec <__udivdi3+0x50>
  8020bf:	39 cf                	cmp    %ecx,%edi
  8020c1:	77 65                	ja     802128 <__udivdi3+0x8c>
  8020c3:	89 fd                	mov    %edi,%ebp
  8020c5:	85 ff                	test   %edi,%edi
  8020c7:	75 0b                	jne    8020d4 <__udivdi3+0x38>
  8020c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8020ce:	31 d2                	xor    %edx,%edx
  8020d0:	f7 f7                	div    %edi
  8020d2:	89 c5                	mov    %eax,%ebp
  8020d4:	31 d2                	xor    %edx,%edx
  8020d6:	89 c8                	mov    %ecx,%eax
  8020d8:	f7 f5                	div    %ebp
  8020da:	89 c1                	mov    %eax,%ecx
  8020dc:	89 d8                	mov    %ebx,%eax
  8020de:	f7 f5                	div    %ebp
  8020e0:	89 cf                	mov    %ecx,%edi
  8020e2:	89 fa                	mov    %edi,%edx
  8020e4:	83 c4 1c             	add    $0x1c,%esp
  8020e7:	5b                   	pop    %ebx
  8020e8:	5e                   	pop    %esi
  8020e9:	5f                   	pop    %edi
  8020ea:	5d                   	pop    %ebp
  8020eb:	c3                   	ret    
  8020ec:	39 ce                	cmp    %ecx,%esi
  8020ee:	77 28                	ja     802118 <__udivdi3+0x7c>
  8020f0:	0f bd fe             	bsr    %esi,%edi
  8020f3:	83 f7 1f             	xor    $0x1f,%edi
  8020f6:	75 40                	jne    802138 <__udivdi3+0x9c>
  8020f8:	39 ce                	cmp    %ecx,%esi
  8020fa:	72 0a                	jb     802106 <__udivdi3+0x6a>
  8020fc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802100:	0f 87 9e 00 00 00    	ja     8021a4 <__udivdi3+0x108>
  802106:	b8 01 00 00 00       	mov    $0x1,%eax
  80210b:	89 fa                	mov    %edi,%edx
  80210d:	83 c4 1c             	add    $0x1c,%esp
  802110:	5b                   	pop    %ebx
  802111:	5e                   	pop    %esi
  802112:	5f                   	pop    %edi
  802113:	5d                   	pop    %ebp
  802114:	c3                   	ret    
  802115:	8d 76 00             	lea    0x0(%esi),%esi
  802118:	31 ff                	xor    %edi,%edi
  80211a:	31 c0                	xor    %eax,%eax
  80211c:	89 fa                	mov    %edi,%edx
  80211e:	83 c4 1c             	add    $0x1c,%esp
  802121:	5b                   	pop    %ebx
  802122:	5e                   	pop    %esi
  802123:	5f                   	pop    %edi
  802124:	5d                   	pop    %ebp
  802125:	c3                   	ret    
  802126:	66 90                	xchg   %ax,%ax
  802128:	89 d8                	mov    %ebx,%eax
  80212a:	f7 f7                	div    %edi
  80212c:	31 ff                	xor    %edi,%edi
  80212e:	89 fa                	mov    %edi,%edx
  802130:	83 c4 1c             	add    $0x1c,%esp
  802133:	5b                   	pop    %ebx
  802134:	5e                   	pop    %esi
  802135:	5f                   	pop    %edi
  802136:	5d                   	pop    %ebp
  802137:	c3                   	ret    
  802138:	bd 20 00 00 00       	mov    $0x20,%ebp
  80213d:	89 eb                	mov    %ebp,%ebx
  80213f:	29 fb                	sub    %edi,%ebx
  802141:	89 f9                	mov    %edi,%ecx
  802143:	d3 e6                	shl    %cl,%esi
  802145:	89 c5                	mov    %eax,%ebp
  802147:	88 d9                	mov    %bl,%cl
  802149:	d3 ed                	shr    %cl,%ebp
  80214b:	89 e9                	mov    %ebp,%ecx
  80214d:	09 f1                	or     %esi,%ecx
  80214f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802153:	89 f9                	mov    %edi,%ecx
  802155:	d3 e0                	shl    %cl,%eax
  802157:	89 c5                	mov    %eax,%ebp
  802159:	89 d6                	mov    %edx,%esi
  80215b:	88 d9                	mov    %bl,%cl
  80215d:	d3 ee                	shr    %cl,%esi
  80215f:	89 f9                	mov    %edi,%ecx
  802161:	d3 e2                	shl    %cl,%edx
  802163:	8b 44 24 08          	mov    0x8(%esp),%eax
  802167:	88 d9                	mov    %bl,%cl
  802169:	d3 e8                	shr    %cl,%eax
  80216b:	09 c2                	or     %eax,%edx
  80216d:	89 d0                	mov    %edx,%eax
  80216f:	89 f2                	mov    %esi,%edx
  802171:	f7 74 24 0c          	divl   0xc(%esp)
  802175:	89 d6                	mov    %edx,%esi
  802177:	89 c3                	mov    %eax,%ebx
  802179:	f7 e5                	mul    %ebp
  80217b:	39 d6                	cmp    %edx,%esi
  80217d:	72 19                	jb     802198 <__udivdi3+0xfc>
  80217f:	74 0b                	je     80218c <__udivdi3+0xf0>
  802181:	89 d8                	mov    %ebx,%eax
  802183:	31 ff                	xor    %edi,%edi
  802185:	e9 58 ff ff ff       	jmp    8020e2 <__udivdi3+0x46>
  80218a:	66 90                	xchg   %ax,%ax
  80218c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802190:	89 f9                	mov    %edi,%ecx
  802192:	d3 e2                	shl    %cl,%edx
  802194:	39 c2                	cmp    %eax,%edx
  802196:	73 e9                	jae    802181 <__udivdi3+0xe5>
  802198:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80219b:	31 ff                	xor    %edi,%edi
  80219d:	e9 40 ff ff ff       	jmp    8020e2 <__udivdi3+0x46>
  8021a2:	66 90                	xchg   %ax,%ax
  8021a4:	31 c0                	xor    %eax,%eax
  8021a6:	e9 37 ff ff ff       	jmp    8020e2 <__udivdi3+0x46>
  8021ab:	90                   	nop

008021ac <__umoddi3>:
  8021ac:	55                   	push   %ebp
  8021ad:	57                   	push   %edi
  8021ae:	56                   	push   %esi
  8021af:	53                   	push   %ebx
  8021b0:	83 ec 1c             	sub    $0x1c,%esp
  8021b3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8021b7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8021bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021bf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8021c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8021c7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8021cb:	89 f3                	mov    %esi,%ebx
  8021cd:	89 fa                	mov    %edi,%edx
  8021cf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021d3:	89 34 24             	mov    %esi,(%esp)
  8021d6:	85 c0                	test   %eax,%eax
  8021d8:	75 1a                	jne    8021f4 <__umoddi3+0x48>
  8021da:	39 f7                	cmp    %esi,%edi
  8021dc:	0f 86 a2 00 00 00    	jbe    802284 <__umoddi3+0xd8>
  8021e2:	89 c8                	mov    %ecx,%eax
  8021e4:	89 f2                	mov    %esi,%edx
  8021e6:	f7 f7                	div    %edi
  8021e8:	89 d0                	mov    %edx,%eax
  8021ea:	31 d2                	xor    %edx,%edx
  8021ec:	83 c4 1c             	add    $0x1c,%esp
  8021ef:	5b                   	pop    %ebx
  8021f0:	5e                   	pop    %esi
  8021f1:	5f                   	pop    %edi
  8021f2:	5d                   	pop    %ebp
  8021f3:	c3                   	ret    
  8021f4:	39 f0                	cmp    %esi,%eax
  8021f6:	0f 87 ac 00 00 00    	ja     8022a8 <__umoddi3+0xfc>
  8021fc:	0f bd e8             	bsr    %eax,%ebp
  8021ff:	83 f5 1f             	xor    $0x1f,%ebp
  802202:	0f 84 ac 00 00 00    	je     8022b4 <__umoddi3+0x108>
  802208:	bf 20 00 00 00       	mov    $0x20,%edi
  80220d:	29 ef                	sub    %ebp,%edi
  80220f:	89 fe                	mov    %edi,%esi
  802211:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802215:	89 e9                	mov    %ebp,%ecx
  802217:	d3 e0                	shl    %cl,%eax
  802219:	89 d7                	mov    %edx,%edi
  80221b:	89 f1                	mov    %esi,%ecx
  80221d:	d3 ef                	shr    %cl,%edi
  80221f:	09 c7                	or     %eax,%edi
  802221:	89 e9                	mov    %ebp,%ecx
  802223:	d3 e2                	shl    %cl,%edx
  802225:	89 14 24             	mov    %edx,(%esp)
  802228:	89 d8                	mov    %ebx,%eax
  80222a:	d3 e0                	shl    %cl,%eax
  80222c:	89 c2                	mov    %eax,%edx
  80222e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802232:	d3 e0                	shl    %cl,%eax
  802234:	89 44 24 04          	mov    %eax,0x4(%esp)
  802238:	8b 44 24 08          	mov    0x8(%esp),%eax
  80223c:	89 f1                	mov    %esi,%ecx
  80223e:	d3 e8                	shr    %cl,%eax
  802240:	09 d0                	or     %edx,%eax
  802242:	d3 eb                	shr    %cl,%ebx
  802244:	89 da                	mov    %ebx,%edx
  802246:	f7 f7                	div    %edi
  802248:	89 d3                	mov    %edx,%ebx
  80224a:	f7 24 24             	mull   (%esp)
  80224d:	89 c6                	mov    %eax,%esi
  80224f:	89 d1                	mov    %edx,%ecx
  802251:	39 d3                	cmp    %edx,%ebx
  802253:	0f 82 87 00 00 00    	jb     8022e0 <__umoddi3+0x134>
  802259:	0f 84 91 00 00 00    	je     8022f0 <__umoddi3+0x144>
  80225f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802263:	29 f2                	sub    %esi,%edx
  802265:	19 cb                	sbb    %ecx,%ebx
  802267:	89 d8                	mov    %ebx,%eax
  802269:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80226d:	d3 e0                	shl    %cl,%eax
  80226f:	89 e9                	mov    %ebp,%ecx
  802271:	d3 ea                	shr    %cl,%edx
  802273:	09 d0                	or     %edx,%eax
  802275:	89 e9                	mov    %ebp,%ecx
  802277:	d3 eb                	shr    %cl,%ebx
  802279:	89 da                	mov    %ebx,%edx
  80227b:	83 c4 1c             	add    $0x1c,%esp
  80227e:	5b                   	pop    %ebx
  80227f:	5e                   	pop    %esi
  802280:	5f                   	pop    %edi
  802281:	5d                   	pop    %ebp
  802282:	c3                   	ret    
  802283:	90                   	nop
  802284:	89 fd                	mov    %edi,%ebp
  802286:	85 ff                	test   %edi,%edi
  802288:	75 0b                	jne    802295 <__umoddi3+0xe9>
  80228a:	b8 01 00 00 00       	mov    $0x1,%eax
  80228f:	31 d2                	xor    %edx,%edx
  802291:	f7 f7                	div    %edi
  802293:	89 c5                	mov    %eax,%ebp
  802295:	89 f0                	mov    %esi,%eax
  802297:	31 d2                	xor    %edx,%edx
  802299:	f7 f5                	div    %ebp
  80229b:	89 c8                	mov    %ecx,%eax
  80229d:	f7 f5                	div    %ebp
  80229f:	89 d0                	mov    %edx,%eax
  8022a1:	e9 44 ff ff ff       	jmp    8021ea <__umoddi3+0x3e>
  8022a6:	66 90                	xchg   %ax,%ax
  8022a8:	89 c8                	mov    %ecx,%eax
  8022aa:	89 f2                	mov    %esi,%edx
  8022ac:	83 c4 1c             	add    $0x1c,%esp
  8022af:	5b                   	pop    %ebx
  8022b0:	5e                   	pop    %esi
  8022b1:	5f                   	pop    %edi
  8022b2:	5d                   	pop    %ebp
  8022b3:	c3                   	ret    
  8022b4:	3b 04 24             	cmp    (%esp),%eax
  8022b7:	72 06                	jb     8022bf <__umoddi3+0x113>
  8022b9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8022bd:	77 0f                	ja     8022ce <__umoddi3+0x122>
  8022bf:	89 f2                	mov    %esi,%edx
  8022c1:	29 f9                	sub    %edi,%ecx
  8022c3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8022c7:	89 14 24             	mov    %edx,(%esp)
  8022ca:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022ce:	8b 44 24 04          	mov    0x4(%esp),%eax
  8022d2:	8b 14 24             	mov    (%esp),%edx
  8022d5:	83 c4 1c             	add    $0x1c,%esp
  8022d8:	5b                   	pop    %ebx
  8022d9:	5e                   	pop    %esi
  8022da:	5f                   	pop    %edi
  8022db:	5d                   	pop    %ebp
  8022dc:	c3                   	ret    
  8022dd:	8d 76 00             	lea    0x0(%esi),%esi
  8022e0:	2b 04 24             	sub    (%esp),%eax
  8022e3:	19 fa                	sbb    %edi,%edx
  8022e5:	89 d1                	mov    %edx,%ecx
  8022e7:	89 c6                	mov    %eax,%esi
  8022e9:	e9 71 ff ff ff       	jmp    80225f <__umoddi3+0xb3>
  8022ee:	66 90                	xchg   %ax,%ax
  8022f0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8022f4:	72 ea                	jb     8022e0 <__umoddi3+0x134>
  8022f6:	89 d9                	mov    %ebx,%ecx
  8022f8:	e9 62 ff ff ff       	jmp    80225f <__umoddi3+0xb3>
