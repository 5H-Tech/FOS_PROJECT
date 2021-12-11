
obj/user/tst_page_replacement_FIFO_2:     file format elf32-i386


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
  800031:	e8 21 07 00 00       	call   800757 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec bc 00 00 00    	sub    $0xbc,%esp

//	cprintf("envID = %d\n",envID);



	char* tempArr = (char*)0x80000000;
  800044:	c7 45 cc 00 00 00 80 	movl   $0x80000000,-0x34(%ebp)
	//sys_allocateMem(0x80000000, 15*1024);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80004b:	a1 20 30 80 00       	mov    0x803020,%eax
  800050:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800056:	8b 00                	mov    (%eax),%eax
  800058:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80005b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80005e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800063:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800068:	74 14                	je     80007e <_main+0x46>
  80006a:	83 ec 04             	sub    $0x4,%esp
  80006d:	68 a0 21 80 00       	push   $0x8021a0
  800072:	6a 17                	push   $0x17
  800074:	68 e4 21 80 00       	push   $0x8021e4
  800079:	e8 1e 08 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80007e:	a1 20 30 80 00       	mov    0x803020,%eax
  800083:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800089:	83 c0 10             	add    $0x10,%eax
  80008c:	8b 00                	mov    (%eax),%eax
  80008e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800091:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800094:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800099:	3d 00 10 20 00       	cmp    $0x201000,%eax
  80009e:	74 14                	je     8000b4 <_main+0x7c>
  8000a0:	83 ec 04             	sub    $0x4,%esp
  8000a3:	68 a0 21 80 00       	push   $0x8021a0
  8000a8:	6a 18                	push   $0x18
  8000aa:	68 e4 21 80 00       	push   $0x8021e4
  8000af:	e8 e8 07 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000bf:	83 c0 20             	add    $0x20,%eax
  8000c2:	8b 00                	mov    (%eax),%eax
  8000c4:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8000c7:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8000ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000cf:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000d4:	74 14                	je     8000ea <_main+0xb2>
  8000d6:	83 ec 04             	sub    $0x4,%esp
  8000d9:	68 a0 21 80 00       	push   $0x8021a0
  8000de:	6a 19                	push   $0x19
  8000e0:	68 e4 21 80 00       	push   $0x8021e4
  8000e5:	e8 b2 07 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ef:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000f5:	83 c0 30             	add    $0x30,%eax
  8000f8:	8b 00                	mov    (%eax),%eax
  8000fa:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8000fd:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800100:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800105:	3d 00 30 20 00       	cmp    $0x203000,%eax
  80010a:	74 14                	je     800120 <_main+0xe8>
  80010c:	83 ec 04             	sub    $0x4,%esp
  80010f:	68 a0 21 80 00       	push   $0x8021a0
  800114:	6a 1a                	push   $0x1a
  800116:	68 e4 21 80 00       	push   $0x8021e4
  80011b:	e8 7c 07 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800120:	a1 20 30 80 00       	mov    0x803020,%eax
  800125:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80012b:	83 c0 40             	add    $0x40,%eax
  80012e:	8b 00                	mov    (%eax),%eax
  800130:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800133:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800136:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80013b:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800140:	74 14                	je     800156 <_main+0x11e>
  800142:	83 ec 04             	sub    $0x4,%esp
  800145:	68 a0 21 80 00       	push   $0x8021a0
  80014a:	6a 1b                	push   $0x1b
  80014c:	68 e4 21 80 00       	push   $0x8021e4
  800151:	e8 46 07 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800156:	a1 20 30 80 00       	mov    0x803020,%eax
  80015b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800161:	83 c0 50             	add    $0x50,%eax
  800164:	8b 00                	mov    (%eax),%eax
  800166:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800169:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80016c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800171:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800176:	74 14                	je     80018c <_main+0x154>
  800178:	83 ec 04             	sub    $0x4,%esp
  80017b:	68 a0 21 80 00       	push   $0x8021a0
  800180:	6a 1c                	push   $0x1c
  800182:	68 e4 21 80 00       	push   $0x8021e4
  800187:	e8 10 07 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80018c:	a1 20 30 80 00       	mov    0x803020,%eax
  800191:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800197:	83 c0 60             	add    $0x60,%eax
  80019a:	8b 00                	mov    (%eax),%eax
  80019c:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80019f:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8001a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a7:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001ac:	74 14                	je     8001c2 <_main+0x18a>
  8001ae:	83 ec 04             	sub    $0x4,%esp
  8001b1:	68 a0 21 80 00       	push   $0x8021a0
  8001b6:	6a 1d                	push   $0x1d
  8001b8:	68 e4 21 80 00       	push   $0x8021e4
  8001bd:	e8 da 06 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001cd:	83 c0 70             	add    $0x70,%eax
  8001d0:	8b 00                	mov    (%eax),%eax
  8001d2:	89 45 ac             	mov    %eax,-0x54(%ebp)
  8001d5:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8001d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001dd:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001e2:	74 14                	je     8001f8 <_main+0x1c0>
  8001e4:	83 ec 04             	sub    $0x4,%esp
  8001e7:	68 a0 21 80 00       	push   $0x8021a0
  8001ec:	6a 1e                	push   $0x1e
  8001ee:	68 e4 21 80 00       	push   $0x8021e4
  8001f3:	e8 a4 06 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800203:	83 e8 80             	sub    $0xffffff80,%eax
  800206:	8b 00                	mov    (%eax),%eax
  800208:	89 45 a8             	mov    %eax,-0x58(%ebp)
  80020b:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80020e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800213:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800218:	74 14                	je     80022e <_main+0x1f6>
  80021a:	83 ec 04             	sub    $0x4,%esp
  80021d:	68 a0 21 80 00       	push   $0x8021a0
  800222:	6a 1f                	push   $0x1f
  800224:	68 e4 21 80 00       	push   $0x8021e4
  800229:	e8 6e 06 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80022e:	a1 20 30 80 00       	mov    0x803020,%eax
  800233:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800239:	05 90 00 00 00       	add    $0x90,%eax
  80023e:	8b 00                	mov    (%eax),%eax
  800240:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800243:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800246:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80024b:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800250:	74 14                	je     800266 <_main+0x22e>
  800252:	83 ec 04             	sub    $0x4,%esp
  800255:	68 a0 21 80 00       	push   $0x8021a0
  80025a:	6a 20                	push   $0x20
  80025c:	68 e4 21 80 00       	push   $0x8021e4
  800261:	e8 36 06 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800266:	a1 20 30 80 00       	mov    0x803020,%eax
  80026b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800271:	05 a0 00 00 00       	add    $0xa0,%eax
  800276:	8b 00                	mov    (%eax),%eax
  800278:	89 45 a0             	mov    %eax,-0x60(%ebp)
  80027b:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80027e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800283:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800288:	74 14                	je     80029e <_main+0x266>
  80028a:	83 ec 04             	sub    $0x4,%esp
  80028d:	68 a0 21 80 00       	push   $0x8021a0
  800292:	6a 21                	push   $0x21
  800294:	68 e4 21 80 00       	push   $0x8021e4
  800299:	e8 fe 05 00 00       	call   80089c <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80029e:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a3:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  8002a9:	85 c0                	test   %eax,%eax
  8002ab:	74 14                	je     8002c1 <_main+0x289>
  8002ad:	83 ec 04             	sub    $0x4,%esp
  8002b0:	68 08 22 80 00       	push   $0x802208
  8002b5:	6a 22                	push   $0x22
  8002b7:	68 e4 21 80 00       	push   $0x8021e4
  8002bc:	e8 db 05 00 00       	call   80089c <_panic>
	}

	int freePages = sys_calculate_free_frames();
  8002c1:	e8 6e 17 00 00       	call   801a34 <sys_calculate_free_frames>
  8002c6:	89 45 9c             	mov    %eax,-0x64(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c9:	e8 e9 17 00 00       	call   801ab7 <sys_pf_calculate_allocated_pages>
  8002ce:	89 45 98             	mov    %eax,-0x68(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1];
  8002d1:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002d6:	88 45 97             	mov    %al,-0x69(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1];
  8002d9:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002de:	88 45 96             	mov    %al,-0x6a(%ebp)
	char garbage4, garbage5;

	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*5 ; i+=PAGE_SIZE/2)
  8002e1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8002e8:	eb 26                	jmp    800310 <_main+0x2d8>
	{
		arr[i] = -1 ;
  8002ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002ed:	05 40 30 80 00       	add    $0x803040,%eax
  8002f2:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		//ptr++ ; ptr2++ ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		garbage4 = *ptr ;
  8002f5:	a1 00 30 80 00       	mov    0x803000,%eax
  8002fa:	8a 00                	mov    (%eax),%al
  8002fc:	88 45 e7             	mov    %al,-0x19(%ebp)
		garbage5 = *ptr2 ;
  8002ff:	a1 04 30 80 00       	mov    0x803004,%eax
  800304:	8a 00                	mov    (%eax),%al
  800306:	88 45 e6             	mov    %al,-0x1a(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1];
	char garbage4, garbage5;

	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*5 ; i+=PAGE_SIZE/2)
  800309:	81 45 e0 00 08 00 00 	addl   $0x800,-0x20(%ebp)
  800310:	81 7d e0 ff 4f 00 00 	cmpl   $0x4fff,-0x20(%ebp)
  800317:	7e d1                	jle    8002ea <_main+0x2b2>
		garbage5 = *ptr2 ;
	}

	//Check FIFO 1
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x80e000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800319:	a1 20 30 80 00       	mov    0x803020,%eax
  80031e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800324:	8b 00                	mov    (%eax),%eax
  800326:	89 45 90             	mov    %eax,-0x70(%ebp)
  800329:	8b 45 90             	mov    -0x70(%ebp),%eax
  80032c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800331:	3d 00 e0 80 00       	cmp    $0x80e000,%eax
  800336:	74 14                	je     80034c <_main+0x314>
  800338:	83 ec 04             	sub    $0x4,%esp
  80033b:	68 50 22 80 00       	push   $0x802250
  800340:	6a 3d                	push   $0x3d
  800342:	68 e4 21 80 00       	push   $0x8021e4
  800347:	e8 50 05 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80f000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80034c:	a1 20 30 80 00       	mov    0x803020,%eax
  800351:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800357:	83 c0 10             	add    $0x10,%eax
  80035a:	8b 00                	mov    (%eax),%eax
  80035c:	89 45 8c             	mov    %eax,-0x74(%ebp)
  80035f:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800362:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800367:	3d 00 f0 80 00       	cmp    $0x80f000,%eax
  80036c:	74 14                	je     800382 <_main+0x34a>
  80036e:	83 ec 04             	sub    $0x4,%esp
  800371:	68 50 22 80 00       	push   $0x802250
  800376:	6a 3e                	push   $0x3e
  800378:	68 e4 21 80 00       	push   $0x8021e4
  80037d:	e8 1a 05 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800382:	a1 20 30 80 00       	mov    0x803020,%eax
  800387:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80038d:	83 c0 20             	add    $0x20,%eax
  800390:	8b 00                	mov    (%eax),%eax
  800392:	89 45 88             	mov    %eax,-0x78(%ebp)
  800395:	8b 45 88             	mov    -0x78(%ebp),%eax
  800398:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80039d:	3d 00 40 80 00       	cmp    $0x804000,%eax
  8003a2:	74 14                	je     8003b8 <_main+0x380>
  8003a4:	83 ec 04             	sub    $0x4,%esp
  8003a7:	68 50 22 80 00       	push   $0x802250
  8003ac:	6a 3f                	push   $0x3f
  8003ae:	68 e4 21 80 00       	push   $0x8021e4
  8003b3:	e8 e4 04 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x805000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003c3:	83 c0 30             	add    $0x30,%eax
  8003c6:	8b 00                	mov    (%eax),%eax
  8003c8:	89 45 84             	mov    %eax,-0x7c(%ebp)
  8003cb:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8003ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d3:	3d 00 50 80 00       	cmp    $0x805000,%eax
  8003d8:	74 14                	je     8003ee <_main+0x3b6>
  8003da:	83 ec 04             	sub    $0x4,%esp
  8003dd:	68 50 22 80 00       	push   $0x802250
  8003e2:	6a 40                	push   $0x40
  8003e4:	68 e4 21 80 00       	push   $0x8021e4
  8003e9:	e8 ae 04 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x806000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003f9:	83 c0 40             	add    $0x40,%eax
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	89 45 80             	mov    %eax,-0x80(%ebp)
  800401:	8b 45 80             	mov    -0x80(%ebp),%eax
  800404:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800409:	3d 00 60 80 00       	cmp    $0x806000,%eax
  80040e:	74 14                	je     800424 <_main+0x3ec>
  800410:	83 ec 04             	sub    $0x4,%esp
  800413:	68 50 22 80 00       	push   $0x802250
  800418:	6a 41                	push   $0x41
  80041a:	68 e4 21 80 00       	push   $0x8021e4
  80041f:	e8 78 04 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x807000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800424:	a1 20 30 80 00       	mov    0x803020,%eax
  800429:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80042f:	83 c0 50             	add    $0x50,%eax
  800432:	8b 00                	mov    (%eax),%eax
  800434:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80043a:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800440:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800445:	3d 00 70 80 00       	cmp    $0x807000,%eax
  80044a:	74 14                	je     800460 <_main+0x428>
  80044c:	83 ec 04             	sub    $0x4,%esp
  80044f:	68 50 22 80 00       	push   $0x802250
  800454:	6a 42                	push   $0x42
  800456:	68 e4 21 80 00       	push   $0x8021e4
  80045b:	e8 3c 04 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800460:	a1 20 30 80 00       	mov    0x803020,%eax
  800465:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80046b:	83 c0 60             	add    $0x60,%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  800476:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80047c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800481:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800486:	74 14                	je     80049c <_main+0x464>
  800488:	83 ec 04             	sub    $0x4,%esp
  80048b:	68 50 22 80 00       	push   $0x802250
  800490:	6a 43                	push   $0x43
  800492:	68 e4 21 80 00       	push   $0x8021e4
  800497:	e8 00 04 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80049c:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004a7:	83 c0 70             	add    $0x70,%eax
  8004aa:	8b 00                	mov    (%eax),%eax
  8004ac:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  8004b2:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8004b8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004bd:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8004c2:	74 14                	je     8004d8 <_main+0x4a0>
  8004c4:	83 ec 04             	sub    $0x4,%esp
  8004c7:	68 50 22 80 00       	push   $0x802250
  8004cc:	6a 44                	push   $0x44
  8004ce:	68 e4 21 80 00       	push   $0x8021e4
  8004d3:	e8 c4 03 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x802000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8004d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8004dd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004e3:	83 e8 80             	sub    $0xffffff80,%eax
  8004e6:	8b 00                	mov    (%eax),%eax
  8004e8:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  8004ee:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8004f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004f9:	3d 00 20 80 00       	cmp    $0x802000,%eax
  8004fe:	74 14                	je     800514 <_main+0x4dc>
  800500:	83 ec 04             	sub    $0x4,%esp
  800503:	68 50 22 80 00       	push   $0x802250
  800508:	6a 45                	push   $0x45
  80050a:	68 e4 21 80 00       	push   $0x8021e4
  80050f:	e8 88 03 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800514:	a1 20 30 80 00       	mov    0x803020,%eax
  800519:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80051f:	05 90 00 00 00       	add    $0x90,%eax
  800524:	8b 00                	mov    (%eax),%eax
  800526:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  80052c:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800532:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800537:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80053c:	74 14                	je     800552 <_main+0x51a>
  80053e:	83 ec 04             	sub    $0x4,%esp
  800541:	68 50 22 80 00       	push   $0x802250
  800546:	6a 46                	push   $0x46
  800548:	68 e4 21 80 00       	push   $0x8021e4
  80054d:	e8 4a 03 00 00       	call   80089c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800552:	a1 20 30 80 00       	mov    0x803020,%eax
  800557:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80055d:	05 a0 00 00 00       	add    $0xa0,%eax
  800562:	8b 00                	mov    (%eax),%eax
  800564:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  80056a:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800570:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800575:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80057a:	74 14                	je     800590 <_main+0x558>
  80057c:	83 ec 04             	sub    $0x4,%esp
  80057f:	68 50 22 80 00       	push   $0x802250
  800584:	6a 47                	push   $0x47
  800586:	68 e4 21 80 00       	push   $0x8021e4
  80058b:	e8 0c 03 00 00       	call   80089c <_panic>

		if(myEnv->page_last_WS_index != 6) panic("wrong PAGE WS pointer location");
  800590:	a1 20 30 80 00       	mov    0x803020,%eax
  800595:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80059b:	83 f8 06             	cmp    $0x6,%eax
  80059e:	74 14                	je     8005b4 <_main+0x57c>
  8005a0:	83 ec 04             	sub    $0x4,%esp
  8005a3:	68 9c 22 80 00       	push   $0x80229c
  8005a8:	6a 49                	push   $0x49
  8005aa:	68 e4 21 80 00       	push   $0x8021e4
  8005af:	e8 e8 02 00 00       	call   80089c <_panic>
	}

	sys_allocateMem(0x80000000, 4*PAGE_SIZE);
  8005b4:	83 ec 08             	sub    $0x8,%esp
  8005b7:	68 00 40 00 00       	push   $0x4000
  8005bc:	68 00 00 00 80       	push   $0x80000000
  8005c1:	e8 d5 14 00 00       	call   801a9b <sys_allocateMem>
  8005c6:	83 c4 10             	add    $0x10,%esp
	//cprintf("1\n");

	int c;
	for(c = 0;c< 15*1024;c++)
  8005c9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8005d0:	eb 0e                	jmp    8005e0 <_main+0x5a8>
	{
		tempArr[c] = 'a';
  8005d2:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8005d5:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8005d8:	01 d0                	add    %edx,%eax
  8005da:	c6 00 61             	movb   $0x61,(%eax)

	sys_allocateMem(0x80000000, 4*PAGE_SIZE);
	//cprintf("1\n");

	int c;
	for(c = 0;c< 15*1024;c++)
  8005dd:	ff 45 dc             	incl   -0x24(%ebp)
  8005e0:	81 7d dc ff 3b 00 00 	cmpl   $0x3bff,-0x24(%ebp)
  8005e7:	7e e9                	jle    8005d2 <_main+0x59a>
		tempArr[c] = 'a';
	}

	//cprintf("2\n");

	sys_freeMem(0x80000000, 4*PAGE_SIZE);
  8005e9:	83 ec 08             	sub    $0x8,%esp
  8005ec:	68 00 40 00 00       	push   $0x4000
  8005f1:	68 00 00 00 80       	push   $0x80000000
  8005f6:	e8 84 14 00 00       	call   801a7f <sys_freeMem>
  8005fb:	83 c4 10             	add    $0x10,%esp
	//cprintf("3\n");

	//Check after free either push records up or leave them empty
	for (i = PAGE_SIZE*5 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8005fe:	c7 45 e0 00 50 00 00 	movl   $0x5000,-0x20(%ebp)
  800605:	eb 26                	jmp    80062d <_main+0x5f5>
	{
		arr[i] = -1 ;
  800607:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80060a:	05 40 30 80 00       	add    $0x803040,%eax
  80060f:	c6 00 ff             	movb   $0xff,(%eax)
		//always use pages at 0x801000 and 0x804000
		garbage4 = *ptr ;
  800612:	a1 00 30 80 00       	mov    0x803000,%eax
  800617:	8a 00                	mov    (%eax),%al
  800619:	88 45 e7             	mov    %al,-0x19(%ebp)
		garbage5 = *ptr2 ;
  80061c:	a1 04 30 80 00       	mov    0x803004,%eax
  800621:	8a 00                	mov    (%eax),%al
  800623:	88 45 e6             	mov    %al,-0x1a(%ebp)

	sys_freeMem(0x80000000, 4*PAGE_SIZE);
	//cprintf("3\n");

	//Check after free either push records up or leave them empty
	for (i = PAGE_SIZE*5 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800626:	81 45 e0 00 08 00 00 	addl   $0x800,-0x20(%ebp)
  80062d:	81 7d e0 ff 9f 00 00 	cmpl   $0x9fff,-0x20(%ebp)
  800634:	7e d1                	jle    800607 <_main+0x5cf>
		garbage5 = *ptr2 ;
	}
	//cprintf("4\n");

	//===================
	uint32 finalPageNums[11] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x808000,0x809000,0x80a000,0x80b000,0x80c000,0xeebfd000};
  800636:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
  80063c:	bb 40 23 80 00       	mov    $0x802340,%ebx
  800641:	ba 0b 00 00 00       	mov    $0xb,%edx
  800646:	89 c7                	mov    %eax,%edi
  800648:	89 de                	mov    %ebx,%esi
  80064a:	89 d1                	mov    %edx,%ecx
  80064c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	//cprintf("Checking PAGE FIFO algorithm after Free and replacement... \n");
	{
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80064e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  800655:	e9 91 00 00 00       	jmp    8006eb <_main+0x6b3>
		{
			uint8 found = 0;
  80065a:	c6 45 d7 00          	movb   $0x0,-0x29(%ebp)
			for (int j = 0; j < myEnv->page_WS_max_size; ++j)
  80065e:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  800665:	eb 3d                	jmp    8006a4 <_main+0x66c>
			{
				if(finalPageNums[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE))
  800667:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80066a:	8b 94 85 38 ff ff ff 	mov    -0xc8(%ebp,%eax,4),%edx
  800671:	a1 20 30 80 00       	mov    0x803020,%eax
  800676:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80067c:	8b 4d d0             	mov    -0x30(%ebp),%ecx
  80067f:	c1 e1 04             	shl    $0x4,%ecx
  800682:	01 c8                	add    %ecx,%eax
  800684:	8b 00                	mov    (%eax),%eax
  800686:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  80068c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800692:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800697:	39 c2                	cmp    %eax,%edx
  800699:	75 06                	jne    8006a1 <_main+0x669>
				{
					found = 1;
  80069b:	c6 45 d7 01          	movb   $0x1,-0x29(%ebp)
					break;
  80069f:	eb 12                	jmp    8006b3 <_main+0x67b>
	//cprintf("Checking PAGE FIFO algorithm after Free and replacement... \n");
	{
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
		{
			uint8 found = 0;
			for (int j = 0; j < myEnv->page_WS_max_size; ++j)
  8006a1:	ff 45 d0             	incl   -0x30(%ebp)
  8006a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a9:	8b 50 74             	mov    0x74(%eax),%edx
  8006ac:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8006af:	39 c2                	cmp    %eax,%edx
  8006b1:	77 b4                	ja     800667 <_main+0x62f>
				{
					found = 1;
					break;
				}
			}
			if (found == 0)
  8006b3:	80 7d d7 00          	cmpb   $0x0,-0x29(%ebp)
  8006b7:	75 2f                	jne    8006e8 <_main+0x6b0>
			{
				cprintf("%x NOT FOUND\n", finalPageNums[i]);
  8006b9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006bc:	8b 84 85 38 ff ff ff 	mov    -0xc8(%ebp,%eax,4),%eax
  8006c3:	83 ec 08             	sub    $0x8,%esp
  8006c6:	50                   	push   %eax
  8006c7:	68 bb 22 80 00       	push   $0x8022bb
  8006cc:	e8 6d 04 00 00       	call   800b3e <cprintf>
  8006d1:	83 c4 10             	add    $0x10,%esp
				panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8006d4:	83 ec 04             	sub    $0x4,%esp
  8006d7:	68 50 22 80 00       	push   $0x802250
  8006dc:	6a 77                	push   $0x77
  8006de:	68 e4 21 80 00       	push   $0x8021e4
  8006e3:	e8 b4 01 00 00       	call   80089c <_panic>
	//===================
	uint32 finalPageNums[11] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x808000,0x809000,0x80a000,0x80b000,0x80c000,0xeebfd000};

	//cprintf("Checking PAGE FIFO algorithm after Free and replacement... \n");
	{
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  8006e8:	ff 45 d8             	incl   -0x28(%ebp)
  8006eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8006f0:	8b 50 74             	mov    0x74(%eax),%edx
  8006f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006f6:	39 c2                	cmp    %eax,%edx
  8006f8:	0f 87 5c ff ff ff    	ja     80065a <_main+0x622>
			}
		}
	}

	{
		if (garbage4 != *ptr) panic("test failed!");
  8006fe:	a1 00 30 80 00       	mov    0x803000,%eax
  800703:	8a 00                	mov    (%eax),%al
  800705:	3a 45 e7             	cmp    -0x19(%ebp),%al
  800708:	74 14                	je     80071e <_main+0x6e6>
  80070a:	83 ec 04             	sub    $0x4,%esp
  80070d:	68 c9 22 80 00       	push   $0x8022c9
  800712:	6a 7d                	push   $0x7d
  800714:	68 e4 21 80 00       	push   $0x8021e4
  800719:	e8 7e 01 00 00       	call   80089c <_panic>
		if (garbage5 != *ptr2) panic("test failed!");
  80071e:	a1 04 30 80 00       	mov    0x803004,%eax
  800723:	8a 00                	mov    (%eax),%al
  800725:	3a 45 e6             	cmp    -0x1a(%ebp),%al
  800728:	74 14                	je     80073e <_main+0x706>
  80072a:	83 ec 04             	sub    $0x4,%esp
  80072d:	68 c9 22 80 00       	push   $0x8022c9
  800732:	6a 7e                	push   $0x7e
  800734:	68 e4 21 80 00       	push   $0x8021e4
  800739:	e8 5e 01 00 00       	call   80089c <_panic>
	}

	cprintf("Congratulations!! test PAGE replacement [FIFO 2] is completed successfully.\n");
  80073e:	83 ec 0c             	sub    $0xc,%esp
  800741:	68 d8 22 80 00       	push   $0x8022d8
  800746:	e8 f3 03 00 00       	call   800b3e <cprintf>
  80074b:	83 c4 10             	add    $0x10,%esp
	return;
  80074e:	90                   	nop
}
  80074f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800752:	5b                   	pop    %ebx
  800753:	5e                   	pop    %esi
  800754:	5f                   	pop    %edi
  800755:	5d                   	pop    %ebp
  800756:	c3                   	ret    

00800757 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800757:	55                   	push   %ebp
  800758:	89 e5                	mov    %esp,%ebp
  80075a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80075d:	e8 07 12 00 00       	call   801969 <sys_getenvindex>
  800762:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800765:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800768:	89 d0                	mov    %edx,%eax
  80076a:	c1 e0 03             	shl    $0x3,%eax
  80076d:	01 d0                	add    %edx,%eax
  80076f:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800776:	01 c8                	add    %ecx,%eax
  800778:	01 c0                	add    %eax,%eax
  80077a:	01 d0                	add    %edx,%eax
  80077c:	01 c0                	add    %eax,%eax
  80077e:	01 d0                	add    %edx,%eax
  800780:	89 c2                	mov    %eax,%edx
  800782:	c1 e2 05             	shl    $0x5,%edx
  800785:	29 c2                	sub    %eax,%edx
  800787:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80078e:	89 c2                	mov    %eax,%edx
  800790:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800796:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80079b:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a0:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8007a6:	84 c0                	test   %al,%al
  8007a8:	74 0f                	je     8007b9 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8007aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8007af:	05 40 3c 01 00       	add    $0x13c40,%eax
  8007b4:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007b9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8007bd:	7e 0a                	jle    8007c9 <libmain+0x72>
		binaryname = argv[0];
  8007bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007c2:	8b 00                	mov    (%eax),%eax
  8007c4:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8007c9:	83 ec 08             	sub    $0x8,%esp
  8007cc:	ff 75 0c             	pushl  0xc(%ebp)
  8007cf:	ff 75 08             	pushl  0x8(%ebp)
  8007d2:	e8 61 f8 ff ff       	call   800038 <_main>
  8007d7:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8007da:	e8 25 13 00 00       	call   801b04 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8007df:	83 ec 0c             	sub    $0xc,%esp
  8007e2:	68 84 23 80 00       	push   $0x802384
  8007e7:	e8 52 03 00 00       	call   800b3e <cprintf>
  8007ec:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8007ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8007f4:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8007fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ff:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800805:	83 ec 04             	sub    $0x4,%esp
  800808:	52                   	push   %edx
  800809:	50                   	push   %eax
  80080a:	68 ac 23 80 00       	push   $0x8023ac
  80080f:	e8 2a 03 00 00       	call   800b3e <cprintf>
  800814:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800817:	a1 20 30 80 00       	mov    0x803020,%eax
  80081c:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800822:	a1 20 30 80 00       	mov    0x803020,%eax
  800827:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80082d:	83 ec 04             	sub    $0x4,%esp
  800830:	52                   	push   %edx
  800831:	50                   	push   %eax
  800832:	68 d4 23 80 00       	push   $0x8023d4
  800837:	e8 02 03 00 00       	call   800b3e <cprintf>
  80083c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80083f:	a1 20 30 80 00       	mov    0x803020,%eax
  800844:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80084a:	83 ec 08             	sub    $0x8,%esp
  80084d:	50                   	push   %eax
  80084e:	68 15 24 80 00       	push   $0x802415
  800853:	e8 e6 02 00 00       	call   800b3e <cprintf>
  800858:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80085b:	83 ec 0c             	sub    $0xc,%esp
  80085e:	68 84 23 80 00       	push   $0x802384
  800863:	e8 d6 02 00 00       	call   800b3e <cprintf>
  800868:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80086b:	e8 ae 12 00 00       	call   801b1e <sys_enable_interrupt>

	// exit gracefully
	exit();
  800870:	e8 19 00 00 00       	call   80088e <exit>
}
  800875:	90                   	nop
  800876:	c9                   	leave  
  800877:	c3                   	ret    

00800878 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800878:	55                   	push   %ebp
  800879:	89 e5                	mov    %esp,%ebp
  80087b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80087e:	83 ec 0c             	sub    $0xc,%esp
  800881:	6a 00                	push   $0x0
  800883:	e8 ad 10 00 00       	call   801935 <sys_env_destroy>
  800888:	83 c4 10             	add    $0x10,%esp
}
  80088b:	90                   	nop
  80088c:	c9                   	leave  
  80088d:	c3                   	ret    

0080088e <exit>:

void
exit(void)
{
  80088e:	55                   	push   %ebp
  80088f:	89 e5                	mov    %esp,%ebp
  800891:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800894:	e8 02 11 00 00       	call   80199b <sys_env_exit>
}
  800899:	90                   	nop
  80089a:	c9                   	leave  
  80089b:	c3                   	ret    

0080089c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80089c:	55                   	push   %ebp
  80089d:	89 e5                	mov    %esp,%ebp
  80089f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008a2:	8d 45 10             	lea    0x10(%ebp),%eax
  8008a5:	83 c0 04             	add    $0x4,%eax
  8008a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008ab:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8008b0:	85 c0                	test   %eax,%eax
  8008b2:	74 16                	je     8008ca <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008b4:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8008b9:	83 ec 08             	sub    $0x8,%esp
  8008bc:	50                   	push   %eax
  8008bd:	68 2c 24 80 00       	push   $0x80242c
  8008c2:	e8 77 02 00 00       	call   800b3e <cprintf>
  8008c7:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8008ca:	a1 08 30 80 00       	mov    0x803008,%eax
  8008cf:	ff 75 0c             	pushl  0xc(%ebp)
  8008d2:	ff 75 08             	pushl  0x8(%ebp)
  8008d5:	50                   	push   %eax
  8008d6:	68 31 24 80 00       	push   $0x802431
  8008db:	e8 5e 02 00 00       	call   800b3e <cprintf>
  8008e0:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8008e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e6:	83 ec 08             	sub    $0x8,%esp
  8008e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ec:	50                   	push   %eax
  8008ed:	e8 e1 01 00 00       	call   800ad3 <vcprintf>
  8008f2:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8008f5:	83 ec 08             	sub    $0x8,%esp
  8008f8:	6a 00                	push   $0x0
  8008fa:	68 4d 24 80 00       	push   $0x80244d
  8008ff:	e8 cf 01 00 00       	call   800ad3 <vcprintf>
  800904:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800907:	e8 82 ff ff ff       	call   80088e <exit>

	// should not return here
	while (1) ;
  80090c:	eb fe                	jmp    80090c <_panic+0x70>

0080090e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80090e:	55                   	push   %ebp
  80090f:	89 e5                	mov    %esp,%ebp
  800911:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800914:	a1 20 30 80 00       	mov    0x803020,%eax
  800919:	8b 50 74             	mov    0x74(%eax),%edx
  80091c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091f:	39 c2                	cmp    %eax,%edx
  800921:	74 14                	je     800937 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800923:	83 ec 04             	sub    $0x4,%esp
  800926:	68 50 24 80 00       	push   $0x802450
  80092b:	6a 26                	push   $0x26
  80092d:	68 9c 24 80 00       	push   $0x80249c
  800932:	e8 65 ff ff ff       	call   80089c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800937:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80093e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800945:	e9 b6 00 00 00       	jmp    800a00 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80094a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80094d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800954:	8b 45 08             	mov    0x8(%ebp),%eax
  800957:	01 d0                	add    %edx,%eax
  800959:	8b 00                	mov    (%eax),%eax
  80095b:	85 c0                	test   %eax,%eax
  80095d:	75 08                	jne    800967 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80095f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800962:	e9 96 00 00 00       	jmp    8009fd <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800967:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80096e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800975:	eb 5d                	jmp    8009d4 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800977:	a1 20 30 80 00       	mov    0x803020,%eax
  80097c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800982:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800985:	c1 e2 04             	shl    $0x4,%edx
  800988:	01 d0                	add    %edx,%eax
  80098a:	8a 40 04             	mov    0x4(%eax),%al
  80098d:	84 c0                	test   %al,%al
  80098f:	75 40                	jne    8009d1 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800991:	a1 20 30 80 00       	mov    0x803020,%eax
  800996:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80099c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80099f:	c1 e2 04             	shl    $0x4,%edx
  8009a2:	01 d0                	add    %edx,%eax
  8009a4:	8b 00                	mov    (%eax),%eax
  8009a6:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009a9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009ac:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009b1:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009b6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c0:	01 c8                	add    %ecx,%eax
  8009c2:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009c4:	39 c2                	cmp    %eax,%edx
  8009c6:	75 09                	jne    8009d1 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8009c8:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8009cf:	eb 12                	jmp    8009e3 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009d1:	ff 45 e8             	incl   -0x18(%ebp)
  8009d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8009d9:	8b 50 74             	mov    0x74(%eax),%edx
  8009dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8009df:	39 c2                	cmp    %eax,%edx
  8009e1:	77 94                	ja     800977 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8009e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8009e7:	75 14                	jne    8009fd <CheckWSWithoutLastIndex+0xef>
			panic(
  8009e9:	83 ec 04             	sub    $0x4,%esp
  8009ec:	68 a8 24 80 00       	push   $0x8024a8
  8009f1:	6a 3a                	push   $0x3a
  8009f3:	68 9c 24 80 00       	push   $0x80249c
  8009f8:	e8 9f fe ff ff       	call   80089c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009fd:	ff 45 f0             	incl   -0x10(%ebp)
  800a00:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a03:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a06:	0f 8c 3e ff ff ff    	jl     80094a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a0c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a13:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a1a:	eb 20                	jmp    800a3c <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a1c:	a1 20 30 80 00       	mov    0x803020,%eax
  800a21:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a27:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a2a:	c1 e2 04             	shl    $0x4,%edx
  800a2d:	01 d0                	add    %edx,%eax
  800a2f:	8a 40 04             	mov    0x4(%eax),%al
  800a32:	3c 01                	cmp    $0x1,%al
  800a34:	75 03                	jne    800a39 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800a36:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a39:	ff 45 e0             	incl   -0x20(%ebp)
  800a3c:	a1 20 30 80 00       	mov    0x803020,%eax
  800a41:	8b 50 74             	mov    0x74(%eax),%edx
  800a44:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a47:	39 c2                	cmp    %eax,%edx
  800a49:	77 d1                	ja     800a1c <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a4e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a51:	74 14                	je     800a67 <CheckWSWithoutLastIndex+0x159>
		panic(
  800a53:	83 ec 04             	sub    $0x4,%esp
  800a56:	68 fc 24 80 00       	push   $0x8024fc
  800a5b:	6a 44                	push   $0x44
  800a5d:	68 9c 24 80 00       	push   $0x80249c
  800a62:	e8 35 fe ff ff       	call   80089c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a67:	90                   	nop
  800a68:	c9                   	leave  
  800a69:	c3                   	ret    

00800a6a <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800a6a:	55                   	push   %ebp
  800a6b:	89 e5                	mov    %esp,%ebp
  800a6d:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800a70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a73:	8b 00                	mov    (%eax),%eax
  800a75:	8d 48 01             	lea    0x1(%eax),%ecx
  800a78:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a7b:	89 0a                	mov    %ecx,(%edx)
  800a7d:	8b 55 08             	mov    0x8(%ebp),%edx
  800a80:	88 d1                	mov    %dl,%cl
  800a82:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a85:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8c:	8b 00                	mov    (%eax),%eax
  800a8e:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a93:	75 2c                	jne    800ac1 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a95:	a0 24 30 80 00       	mov    0x803024,%al
  800a9a:	0f b6 c0             	movzbl %al,%eax
  800a9d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aa0:	8b 12                	mov    (%edx),%edx
  800aa2:	89 d1                	mov    %edx,%ecx
  800aa4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aa7:	83 c2 08             	add    $0x8,%edx
  800aaa:	83 ec 04             	sub    $0x4,%esp
  800aad:	50                   	push   %eax
  800aae:	51                   	push   %ecx
  800aaf:	52                   	push   %edx
  800ab0:	e8 3e 0e 00 00       	call   8018f3 <sys_cputs>
  800ab5:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800ab8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800ac1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac4:	8b 40 04             	mov    0x4(%eax),%eax
  800ac7:	8d 50 01             	lea    0x1(%eax),%edx
  800aca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acd:	89 50 04             	mov    %edx,0x4(%eax)
}
  800ad0:	90                   	nop
  800ad1:	c9                   	leave  
  800ad2:	c3                   	ret    

00800ad3 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ad3:	55                   	push   %ebp
  800ad4:	89 e5                	mov    %esp,%ebp
  800ad6:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800adc:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ae3:	00 00 00 
	b.cnt = 0;
  800ae6:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800aed:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800af0:	ff 75 0c             	pushl  0xc(%ebp)
  800af3:	ff 75 08             	pushl  0x8(%ebp)
  800af6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800afc:	50                   	push   %eax
  800afd:	68 6a 0a 80 00       	push   $0x800a6a
  800b02:	e8 11 02 00 00       	call   800d18 <vprintfmt>
  800b07:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b0a:	a0 24 30 80 00       	mov    0x803024,%al
  800b0f:	0f b6 c0             	movzbl %al,%eax
  800b12:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b18:	83 ec 04             	sub    $0x4,%esp
  800b1b:	50                   	push   %eax
  800b1c:	52                   	push   %edx
  800b1d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b23:	83 c0 08             	add    $0x8,%eax
  800b26:	50                   	push   %eax
  800b27:	e8 c7 0d 00 00       	call   8018f3 <sys_cputs>
  800b2c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b2f:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800b36:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b3c:	c9                   	leave  
  800b3d:	c3                   	ret    

00800b3e <cprintf>:

int cprintf(const char *fmt, ...) {
  800b3e:	55                   	push   %ebp
  800b3f:	89 e5                	mov    %esp,%ebp
  800b41:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b44:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800b4b:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b51:	8b 45 08             	mov    0x8(%ebp),%eax
  800b54:	83 ec 08             	sub    $0x8,%esp
  800b57:	ff 75 f4             	pushl  -0xc(%ebp)
  800b5a:	50                   	push   %eax
  800b5b:	e8 73 ff ff ff       	call   800ad3 <vcprintf>
  800b60:	83 c4 10             	add    $0x10,%esp
  800b63:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b66:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b69:	c9                   	leave  
  800b6a:	c3                   	ret    

00800b6b <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800b6b:	55                   	push   %ebp
  800b6c:	89 e5                	mov    %esp,%ebp
  800b6e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800b71:	e8 8e 0f 00 00       	call   801b04 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800b76:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b79:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7f:	83 ec 08             	sub    $0x8,%esp
  800b82:	ff 75 f4             	pushl  -0xc(%ebp)
  800b85:	50                   	push   %eax
  800b86:	e8 48 ff ff ff       	call   800ad3 <vcprintf>
  800b8b:	83 c4 10             	add    $0x10,%esp
  800b8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b91:	e8 88 0f 00 00       	call   801b1e <sys_enable_interrupt>
	return cnt;
  800b96:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b99:	c9                   	leave  
  800b9a:	c3                   	ret    

00800b9b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b9b:	55                   	push   %ebp
  800b9c:	89 e5                	mov    %esp,%ebp
  800b9e:	53                   	push   %ebx
  800b9f:	83 ec 14             	sub    $0x14,%esp
  800ba2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba8:	8b 45 14             	mov    0x14(%ebp),%eax
  800bab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bae:	8b 45 18             	mov    0x18(%ebp),%eax
  800bb1:	ba 00 00 00 00       	mov    $0x0,%edx
  800bb6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bb9:	77 55                	ja     800c10 <printnum+0x75>
  800bbb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bbe:	72 05                	jb     800bc5 <printnum+0x2a>
  800bc0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bc3:	77 4b                	ja     800c10 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800bc5:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800bc8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800bcb:	8b 45 18             	mov    0x18(%ebp),%eax
  800bce:	ba 00 00 00 00       	mov    $0x0,%edx
  800bd3:	52                   	push   %edx
  800bd4:	50                   	push   %eax
  800bd5:	ff 75 f4             	pushl  -0xc(%ebp)
  800bd8:	ff 75 f0             	pushl  -0x10(%ebp)
  800bdb:	e8 48 13 00 00       	call   801f28 <__udivdi3>
  800be0:	83 c4 10             	add    $0x10,%esp
  800be3:	83 ec 04             	sub    $0x4,%esp
  800be6:	ff 75 20             	pushl  0x20(%ebp)
  800be9:	53                   	push   %ebx
  800bea:	ff 75 18             	pushl  0x18(%ebp)
  800bed:	52                   	push   %edx
  800bee:	50                   	push   %eax
  800bef:	ff 75 0c             	pushl  0xc(%ebp)
  800bf2:	ff 75 08             	pushl  0x8(%ebp)
  800bf5:	e8 a1 ff ff ff       	call   800b9b <printnum>
  800bfa:	83 c4 20             	add    $0x20,%esp
  800bfd:	eb 1a                	jmp    800c19 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800bff:	83 ec 08             	sub    $0x8,%esp
  800c02:	ff 75 0c             	pushl  0xc(%ebp)
  800c05:	ff 75 20             	pushl  0x20(%ebp)
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	ff d0                	call   *%eax
  800c0d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c10:	ff 4d 1c             	decl   0x1c(%ebp)
  800c13:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c17:	7f e6                	jg     800bff <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c19:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c1c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c21:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c24:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c27:	53                   	push   %ebx
  800c28:	51                   	push   %ecx
  800c29:	52                   	push   %edx
  800c2a:	50                   	push   %eax
  800c2b:	e8 08 14 00 00       	call   802038 <__umoddi3>
  800c30:	83 c4 10             	add    $0x10,%esp
  800c33:	05 74 27 80 00       	add    $0x802774,%eax
  800c38:	8a 00                	mov    (%eax),%al
  800c3a:	0f be c0             	movsbl %al,%eax
  800c3d:	83 ec 08             	sub    $0x8,%esp
  800c40:	ff 75 0c             	pushl  0xc(%ebp)
  800c43:	50                   	push   %eax
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	ff d0                	call   *%eax
  800c49:	83 c4 10             	add    $0x10,%esp
}
  800c4c:	90                   	nop
  800c4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c50:	c9                   	leave  
  800c51:	c3                   	ret    

00800c52 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c52:	55                   	push   %ebp
  800c53:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c55:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c59:	7e 1c                	jle    800c77 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5e:	8b 00                	mov    (%eax),%eax
  800c60:	8d 50 08             	lea    0x8(%eax),%edx
  800c63:	8b 45 08             	mov    0x8(%ebp),%eax
  800c66:	89 10                	mov    %edx,(%eax)
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	8b 00                	mov    (%eax),%eax
  800c6d:	83 e8 08             	sub    $0x8,%eax
  800c70:	8b 50 04             	mov    0x4(%eax),%edx
  800c73:	8b 00                	mov    (%eax),%eax
  800c75:	eb 40                	jmp    800cb7 <getuint+0x65>
	else if (lflag)
  800c77:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c7b:	74 1e                	je     800c9b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	8b 00                	mov    (%eax),%eax
  800c82:	8d 50 04             	lea    0x4(%eax),%edx
  800c85:	8b 45 08             	mov    0x8(%ebp),%eax
  800c88:	89 10                	mov    %edx,(%eax)
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8b 00                	mov    (%eax),%eax
  800c8f:	83 e8 04             	sub    $0x4,%eax
  800c92:	8b 00                	mov    (%eax),%eax
  800c94:	ba 00 00 00 00       	mov    $0x0,%edx
  800c99:	eb 1c                	jmp    800cb7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	8b 00                	mov    (%eax),%eax
  800ca0:	8d 50 04             	lea    0x4(%eax),%edx
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	89 10                	mov    %edx,(%eax)
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	8b 00                	mov    (%eax),%eax
  800cad:	83 e8 04             	sub    $0x4,%eax
  800cb0:	8b 00                	mov    (%eax),%eax
  800cb2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cb7:	5d                   	pop    %ebp
  800cb8:	c3                   	ret    

00800cb9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cb9:	55                   	push   %ebp
  800cba:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cbc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cc0:	7e 1c                	jle    800cde <getint+0x25>
		return va_arg(*ap, long long);
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	8b 00                	mov    (%eax),%eax
  800cc7:	8d 50 08             	lea    0x8(%eax),%edx
  800cca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccd:	89 10                	mov    %edx,(%eax)
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	8b 00                	mov    (%eax),%eax
  800cd4:	83 e8 08             	sub    $0x8,%eax
  800cd7:	8b 50 04             	mov    0x4(%eax),%edx
  800cda:	8b 00                	mov    (%eax),%eax
  800cdc:	eb 38                	jmp    800d16 <getint+0x5d>
	else if (lflag)
  800cde:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ce2:	74 1a                	je     800cfe <getint+0x45>
		return va_arg(*ap, long);
  800ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce7:	8b 00                	mov    (%eax),%eax
  800ce9:	8d 50 04             	lea    0x4(%eax),%edx
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	89 10                	mov    %edx,(%eax)
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	8b 00                	mov    (%eax),%eax
  800cf6:	83 e8 04             	sub    $0x4,%eax
  800cf9:	8b 00                	mov    (%eax),%eax
  800cfb:	99                   	cltd   
  800cfc:	eb 18                	jmp    800d16 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8b 00                	mov    (%eax),%eax
  800d03:	8d 50 04             	lea    0x4(%eax),%edx
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	89 10                	mov    %edx,(%eax)
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8b 00                	mov    (%eax),%eax
  800d10:	83 e8 04             	sub    $0x4,%eax
  800d13:	8b 00                	mov    (%eax),%eax
  800d15:	99                   	cltd   
}
  800d16:	5d                   	pop    %ebp
  800d17:	c3                   	ret    

00800d18 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d18:	55                   	push   %ebp
  800d19:	89 e5                	mov    %esp,%ebp
  800d1b:	56                   	push   %esi
  800d1c:	53                   	push   %ebx
  800d1d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d20:	eb 17                	jmp    800d39 <vprintfmt+0x21>
			if (ch == '\0')
  800d22:	85 db                	test   %ebx,%ebx
  800d24:	0f 84 af 03 00 00    	je     8010d9 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d2a:	83 ec 08             	sub    $0x8,%esp
  800d2d:	ff 75 0c             	pushl  0xc(%ebp)
  800d30:	53                   	push   %ebx
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	ff d0                	call   *%eax
  800d36:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d39:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3c:	8d 50 01             	lea    0x1(%eax),%edx
  800d3f:	89 55 10             	mov    %edx,0x10(%ebp)
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	0f b6 d8             	movzbl %al,%ebx
  800d47:	83 fb 25             	cmp    $0x25,%ebx
  800d4a:	75 d6                	jne    800d22 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d4c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d50:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d57:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d5e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d65:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6f:	8d 50 01             	lea    0x1(%eax),%edx
  800d72:	89 55 10             	mov    %edx,0x10(%ebp)
  800d75:	8a 00                	mov    (%eax),%al
  800d77:	0f b6 d8             	movzbl %al,%ebx
  800d7a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d7d:	83 f8 55             	cmp    $0x55,%eax
  800d80:	0f 87 2b 03 00 00    	ja     8010b1 <vprintfmt+0x399>
  800d86:	8b 04 85 98 27 80 00 	mov    0x802798(,%eax,4),%eax
  800d8d:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d8f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d93:	eb d7                	jmp    800d6c <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d95:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d99:	eb d1                	jmp    800d6c <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d9b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800da2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800da5:	89 d0                	mov    %edx,%eax
  800da7:	c1 e0 02             	shl    $0x2,%eax
  800daa:	01 d0                	add    %edx,%eax
  800dac:	01 c0                	add    %eax,%eax
  800dae:	01 d8                	add    %ebx,%eax
  800db0:	83 e8 30             	sub    $0x30,%eax
  800db3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800db6:	8b 45 10             	mov    0x10(%ebp),%eax
  800db9:	8a 00                	mov    (%eax),%al
  800dbb:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800dbe:	83 fb 2f             	cmp    $0x2f,%ebx
  800dc1:	7e 3e                	jle    800e01 <vprintfmt+0xe9>
  800dc3:	83 fb 39             	cmp    $0x39,%ebx
  800dc6:	7f 39                	jg     800e01 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dc8:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800dcb:	eb d5                	jmp    800da2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800dcd:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd0:	83 c0 04             	add    $0x4,%eax
  800dd3:	89 45 14             	mov    %eax,0x14(%ebp)
  800dd6:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd9:	83 e8 04             	sub    $0x4,%eax
  800ddc:	8b 00                	mov    (%eax),%eax
  800dde:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800de1:	eb 1f                	jmp    800e02 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800de3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de7:	79 83                	jns    800d6c <vprintfmt+0x54>
				width = 0;
  800de9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800df0:	e9 77 ff ff ff       	jmp    800d6c <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800df5:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800dfc:	e9 6b ff ff ff       	jmp    800d6c <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e01:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e06:	0f 89 60 ff ff ff    	jns    800d6c <vprintfmt+0x54>
				width = precision, precision = -1;
  800e0c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e0f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e12:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e19:	e9 4e ff ff ff       	jmp    800d6c <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e1e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e21:	e9 46 ff ff ff       	jmp    800d6c <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e26:	8b 45 14             	mov    0x14(%ebp),%eax
  800e29:	83 c0 04             	add    $0x4,%eax
  800e2c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e32:	83 e8 04             	sub    $0x4,%eax
  800e35:	8b 00                	mov    (%eax),%eax
  800e37:	83 ec 08             	sub    $0x8,%esp
  800e3a:	ff 75 0c             	pushl  0xc(%ebp)
  800e3d:	50                   	push   %eax
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	ff d0                	call   *%eax
  800e43:	83 c4 10             	add    $0x10,%esp
			break;
  800e46:	e9 89 02 00 00       	jmp    8010d4 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e4b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e4e:	83 c0 04             	add    $0x4,%eax
  800e51:	89 45 14             	mov    %eax,0x14(%ebp)
  800e54:	8b 45 14             	mov    0x14(%ebp),%eax
  800e57:	83 e8 04             	sub    $0x4,%eax
  800e5a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e5c:	85 db                	test   %ebx,%ebx
  800e5e:	79 02                	jns    800e62 <vprintfmt+0x14a>
				err = -err;
  800e60:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e62:	83 fb 64             	cmp    $0x64,%ebx
  800e65:	7f 0b                	jg     800e72 <vprintfmt+0x15a>
  800e67:	8b 34 9d e0 25 80 00 	mov    0x8025e0(,%ebx,4),%esi
  800e6e:	85 f6                	test   %esi,%esi
  800e70:	75 19                	jne    800e8b <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e72:	53                   	push   %ebx
  800e73:	68 85 27 80 00       	push   $0x802785
  800e78:	ff 75 0c             	pushl  0xc(%ebp)
  800e7b:	ff 75 08             	pushl  0x8(%ebp)
  800e7e:	e8 5e 02 00 00       	call   8010e1 <printfmt>
  800e83:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800e86:	e9 49 02 00 00       	jmp    8010d4 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e8b:	56                   	push   %esi
  800e8c:	68 8e 27 80 00       	push   $0x80278e
  800e91:	ff 75 0c             	pushl  0xc(%ebp)
  800e94:	ff 75 08             	pushl  0x8(%ebp)
  800e97:	e8 45 02 00 00       	call   8010e1 <printfmt>
  800e9c:	83 c4 10             	add    $0x10,%esp
			break;
  800e9f:	e9 30 02 00 00       	jmp    8010d4 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ea4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea7:	83 c0 04             	add    $0x4,%eax
  800eaa:	89 45 14             	mov    %eax,0x14(%ebp)
  800ead:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb0:	83 e8 04             	sub    $0x4,%eax
  800eb3:	8b 30                	mov    (%eax),%esi
  800eb5:	85 f6                	test   %esi,%esi
  800eb7:	75 05                	jne    800ebe <vprintfmt+0x1a6>
				p = "(null)";
  800eb9:	be 91 27 80 00       	mov    $0x802791,%esi
			if (width > 0 && padc != '-')
  800ebe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ec2:	7e 6d                	jle    800f31 <vprintfmt+0x219>
  800ec4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ec8:	74 67                	je     800f31 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800eca:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ecd:	83 ec 08             	sub    $0x8,%esp
  800ed0:	50                   	push   %eax
  800ed1:	56                   	push   %esi
  800ed2:	e8 0c 03 00 00       	call   8011e3 <strnlen>
  800ed7:	83 c4 10             	add    $0x10,%esp
  800eda:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800edd:	eb 16                	jmp    800ef5 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800edf:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ee3:	83 ec 08             	sub    $0x8,%esp
  800ee6:	ff 75 0c             	pushl  0xc(%ebp)
  800ee9:	50                   	push   %eax
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	ff d0                	call   *%eax
  800eef:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ef2:	ff 4d e4             	decl   -0x1c(%ebp)
  800ef5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ef9:	7f e4                	jg     800edf <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800efb:	eb 34                	jmp    800f31 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800efd:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f01:	74 1c                	je     800f1f <vprintfmt+0x207>
  800f03:	83 fb 1f             	cmp    $0x1f,%ebx
  800f06:	7e 05                	jle    800f0d <vprintfmt+0x1f5>
  800f08:	83 fb 7e             	cmp    $0x7e,%ebx
  800f0b:	7e 12                	jle    800f1f <vprintfmt+0x207>
					putch('?', putdat);
  800f0d:	83 ec 08             	sub    $0x8,%esp
  800f10:	ff 75 0c             	pushl  0xc(%ebp)
  800f13:	6a 3f                	push   $0x3f
  800f15:	8b 45 08             	mov    0x8(%ebp),%eax
  800f18:	ff d0                	call   *%eax
  800f1a:	83 c4 10             	add    $0x10,%esp
  800f1d:	eb 0f                	jmp    800f2e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f1f:	83 ec 08             	sub    $0x8,%esp
  800f22:	ff 75 0c             	pushl  0xc(%ebp)
  800f25:	53                   	push   %ebx
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	ff d0                	call   *%eax
  800f2b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f2e:	ff 4d e4             	decl   -0x1c(%ebp)
  800f31:	89 f0                	mov    %esi,%eax
  800f33:	8d 70 01             	lea    0x1(%eax),%esi
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	0f be d8             	movsbl %al,%ebx
  800f3b:	85 db                	test   %ebx,%ebx
  800f3d:	74 24                	je     800f63 <vprintfmt+0x24b>
  800f3f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f43:	78 b8                	js     800efd <vprintfmt+0x1e5>
  800f45:	ff 4d e0             	decl   -0x20(%ebp)
  800f48:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f4c:	79 af                	jns    800efd <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f4e:	eb 13                	jmp    800f63 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f50:	83 ec 08             	sub    $0x8,%esp
  800f53:	ff 75 0c             	pushl  0xc(%ebp)
  800f56:	6a 20                	push   $0x20
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	ff d0                	call   *%eax
  800f5d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f60:	ff 4d e4             	decl   -0x1c(%ebp)
  800f63:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f67:	7f e7                	jg     800f50 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f69:	e9 66 01 00 00       	jmp    8010d4 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f6e:	83 ec 08             	sub    $0x8,%esp
  800f71:	ff 75 e8             	pushl  -0x18(%ebp)
  800f74:	8d 45 14             	lea    0x14(%ebp),%eax
  800f77:	50                   	push   %eax
  800f78:	e8 3c fd ff ff       	call   800cb9 <getint>
  800f7d:	83 c4 10             	add    $0x10,%esp
  800f80:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f83:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800f86:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f89:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f8c:	85 d2                	test   %edx,%edx
  800f8e:	79 23                	jns    800fb3 <vprintfmt+0x29b>
				putch('-', putdat);
  800f90:	83 ec 08             	sub    $0x8,%esp
  800f93:	ff 75 0c             	pushl  0xc(%ebp)
  800f96:	6a 2d                	push   $0x2d
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	ff d0                	call   *%eax
  800f9d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fa3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fa6:	f7 d8                	neg    %eax
  800fa8:	83 d2 00             	adc    $0x0,%edx
  800fab:	f7 da                	neg    %edx
  800fad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800fb3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fba:	e9 bc 00 00 00       	jmp    80107b <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800fbf:	83 ec 08             	sub    $0x8,%esp
  800fc2:	ff 75 e8             	pushl  -0x18(%ebp)
  800fc5:	8d 45 14             	lea    0x14(%ebp),%eax
  800fc8:	50                   	push   %eax
  800fc9:	e8 84 fc ff ff       	call   800c52 <getuint>
  800fce:	83 c4 10             	add    $0x10,%esp
  800fd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800fd7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fde:	e9 98 00 00 00       	jmp    80107b <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800fe3:	83 ec 08             	sub    $0x8,%esp
  800fe6:	ff 75 0c             	pushl  0xc(%ebp)
  800fe9:	6a 58                	push   $0x58
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	ff d0                	call   *%eax
  800ff0:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ff3:	83 ec 08             	sub    $0x8,%esp
  800ff6:	ff 75 0c             	pushl  0xc(%ebp)
  800ff9:	6a 58                	push   $0x58
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	ff d0                	call   *%eax
  801000:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801003:	83 ec 08             	sub    $0x8,%esp
  801006:	ff 75 0c             	pushl  0xc(%ebp)
  801009:	6a 58                	push   $0x58
  80100b:	8b 45 08             	mov    0x8(%ebp),%eax
  80100e:	ff d0                	call   *%eax
  801010:	83 c4 10             	add    $0x10,%esp
			break;
  801013:	e9 bc 00 00 00       	jmp    8010d4 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801018:	83 ec 08             	sub    $0x8,%esp
  80101b:	ff 75 0c             	pushl  0xc(%ebp)
  80101e:	6a 30                	push   $0x30
  801020:	8b 45 08             	mov    0x8(%ebp),%eax
  801023:	ff d0                	call   *%eax
  801025:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801028:	83 ec 08             	sub    $0x8,%esp
  80102b:	ff 75 0c             	pushl  0xc(%ebp)
  80102e:	6a 78                	push   $0x78
  801030:	8b 45 08             	mov    0x8(%ebp),%eax
  801033:	ff d0                	call   *%eax
  801035:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801038:	8b 45 14             	mov    0x14(%ebp),%eax
  80103b:	83 c0 04             	add    $0x4,%eax
  80103e:	89 45 14             	mov    %eax,0x14(%ebp)
  801041:	8b 45 14             	mov    0x14(%ebp),%eax
  801044:	83 e8 04             	sub    $0x4,%eax
  801047:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801049:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80104c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801053:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80105a:	eb 1f                	jmp    80107b <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80105c:	83 ec 08             	sub    $0x8,%esp
  80105f:	ff 75 e8             	pushl  -0x18(%ebp)
  801062:	8d 45 14             	lea    0x14(%ebp),%eax
  801065:	50                   	push   %eax
  801066:	e8 e7 fb ff ff       	call   800c52 <getuint>
  80106b:	83 c4 10             	add    $0x10,%esp
  80106e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801071:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801074:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80107b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80107f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801082:	83 ec 04             	sub    $0x4,%esp
  801085:	52                   	push   %edx
  801086:	ff 75 e4             	pushl  -0x1c(%ebp)
  801089:	50                   	push   %eax
  80108a:	ff 75 f4             	pushl  -0xc(%ebp)
  80108d:	ff 75 f0             	pushl  -0x10(%ebp)
  801090:	ff 75 0c             	pushl  0xc(%ebp)
  801093:	ff 75 08             	pushl  0x8(%ebp)
  801096:	e8 00 fb ff ff       	call   800b9b <printnum>
  80109b:	83 c4 20             	add    $0x20,%esp
			break;
  80109e:	eb 34                	jmp    8010d4 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010a0:	83 ec 08             	sub    $0x8,%esp
  8010a3:	ff 75 0c             	pushl  0xc(%ebp)
  8010a6:	53                   	push   %ebx
  8010a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010aa:	ff d0                	call   *%eax
  8010ac:	83 c4 10             	add    $0x10,%esp
			break;
  8010af:	eb 23                	jmp    8010d4 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010b1:	83 ec 08             	sub    $0x8,%esp
  8010b4:	ff 75 0c             	pushl  0xc(%ebp)
  8010b7:	6a 25                	push   $0x25
  8010b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bc:	ff d0                	call   *%eax
  8010be:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010c1:	ff 4d 10             	decl   0x10(%ebp)
  8010c4:	eb 03                	jmp    8010c9 <vprintfmt+0x3b1>
  8010c6:	ff 4d 10             	decl   0x10(%ebp)
  8010c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010cc:	48                   	dec    %eax
  8010cd:	8a 00                	mov    (%eax),%al
  8010cf:	3c 25                	cmp    $0x25,%al
  8010d1:	75 f3                	jne    8010c6 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8010d3:	90                   	nop
		}
	}
  8010d4:	e9 47 fc ff ff       	jmp    800d20 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8010d9:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8010da:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010dd:	5b                   	pop    %ebx
  8010de:	5e                   	pop    %esi
  8010df:	5d                   	pop    %ebp
  8010e0:	c3                   	ret    

008010e1 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8010e1:	55                   	push   %ebp
  8010e2:	89 e5                	mov    %esp,%ebp
  8010e4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8010e7:	8d 45 10             	lea    0x10(%ebp),%eax
  8010ea:	83 c0 04             	add    $0x4,%eax
  8010ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8010f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f3:	ff 75 f4             	pushl  -0xc(%ebp)
  8010f6:	50                   	push   %eax
  8010f7:	ff 75 0c             	pushl  0xc(%ebp)
  8010fa:	ff 75 08             	pushl  0x8(%ebp)
  8010fd:	e8 16 fc ff ff       	call   800d18 <vprintfmt>
  801102:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801105:	90                   	nop
  801106:	c9                   	leave  
  801107:	c3                   	ret    

00801108 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801108:	55                   	push   %ebp
  801109:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80110b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110e:	8b 40 08             	mov    0x8(%eax),%eax
  801111:	8d 50 01             	lea    0x1(%eax),%edx
  801114:	8b 45 0c             	mov    0xc(%ebp),%eax
  801117:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80111a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111d:	8b 10                	mov    (%eax),%edx
  80111f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801122:	8b 40 04             	mov    0x4(%eax),%eax
  801125:	39 c2                	cmp    %eax,%edx
  801127:	73 12                	jae    80113b <sprintputch+0x33>
		*b->buf++ = ch;
  801129:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112c:	8b 00                	mov    (%eax),%eax
  80112e:	8d 48 01             	lea    0x1(%eax),%ecx
  801131:	8b 55 0c             	mov    0xc(%ebp),%edx
  801134:	89 0a                	mov    %ecx,(%edx)
  801136:	8b 55 08             	mov    0x8(%ebp),%edx
  801139:	88 10                	mov    %dl,(%eax)
}
  80113b:	90                   	nop
  80113c:	5d                   	pop    %ebp
  80113d:	c3                   	ret    

0080113e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80113e:	55                   	push   %ebp
  80113f:	89 e5                	mov    %esp,%ebp
  801141:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80114a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	01 d0                	add    %edx,%eax
  801155:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801158:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80115f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801163:	74 06                	je     80116b <vsnprintf+0x2d>
  801165:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801169:	7f 07                	jg     801172 <vsnprintf+0x34>
		return -E_INVAL;
  80116b:	b8 03 00 00 00       	mov    $0x3,%eax
  801170:	eb 20                	jmp    801192 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801172:	ff 75 14             	pushl  0x14(%ebp)
  801175:	ff 75 10             	pushl  0x10(%ebp)
  801178:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80117b:	50                   	push   %eax
  80117c:	68 08 11 80 00       	push   $0x801108
  801181:	e8 92 fb ff ff       	call   800d18 <vprintfmt>
  801186:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801189:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80118c:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80118f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801192:	c9                   	leave  
  801193:	c3                   	ret    

00801194 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801194:	55                   	push   %ebp
  801195:	89 e5                	mov    %esp,%ebp
  801197:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80119a:	8d 45 10             	lea    0x10(%ebp),%eax
  80119d:	83 c0 04             	add    $0x4,%eax
  8011a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a6:	ff 75 f4             	pushl  -0xc(%ebp)
  8011a9:	50                   	push   %eax
  8011aa:	ff 75 0c             	pushl  0xc(%ebp)
  8011ad:	ff 75 08             	pushl  0x8(%ebp)
  8011b0:	e8 89 ff ff ff       	call   80113e <vsnprintf>
  8011b5:	83 c4 10             	add    $0x10,%esp
  8011b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011be:	c9                   	leave  
  8011bf:	c3                   	ret    

008011c0 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8011c0:	55                   	push   %ebp
  8011c1:	89 e5                	mov    %esp,%ebp
  8011c3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8011c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011cd:	eb 06                	jmp    8011d5 <strlen+0x15>
		n++;
  8011cf:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8011d2:	ff 45 08             	incl   0x8(%ebp)
  8011d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d8:	8a 00                	mov    (%eax),%al
  8011da:	84 c0                	test   %al,%al
  8011dc:	75 f1                	jne    8011cf <strlen+0xf>
		n++;
	return n;
  8011de:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011e1:	c9                   	leave  
  8011e2:	c3                   	ret    

008011e3 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8011e3:	55                   	push   %ebp
  8011e4:	89 e5                	mov    %esp,%ebp
  8011e6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8011e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011f0:	eb 09                	jmp    8011fb <strnlen+0x18>
		n++;
  8011f2:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8011f5:	ff 45 08             	incl   0x8(%ebp)
  8011f8:	ff 4d 0c             	decl   0xc(%ebp)
  8011fb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011ff:	74 09                	je     80120a <strnlen+0x27>
  801201:	8b 45 08             	mov    0x8(%ebp),%eax
  801204:	8a 00                	mov    (%eax),%al
  801206:	84 c0                	test   %al,%al
  801208:	75 e8                	jne    8011f2 <strnlen+0xf>
		n++;
	return n;
  80120a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80120d:	c9                   	leave  
  80120e:	c3                   	ret    

0080120f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80120f:	55                   	push   %ebp
  801210:	89 e5                	mov    %esp,%ebp
  801212:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801215:	8b 45 08             	mov    0x8(%ebp),%eax
  801218:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80121b:	90                   	nop
  80121c:	8b 45 08             	mov    0x8(%ebp),%eax
  80121f:	8d 50 01             	lea    0x1(%eax),%edx
  801222:	89 55 08             	mov    %edx,0x8(%ebp)
  801225:	8b 55 0c             	mov    0xc(%ebp),%edx
  801228:	8d 4a 01             	lea    0x1(%edx),%ecx
  80122b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80122e:	8a 12                	mov    (%edx),%dl
  801230:	88 10                	mov    %dl,(%eax)
  801232:	8a 00                	mov    (%eax),%al
  801234:	84 c0                	test   %al,%al
  801236:	75 e4                	jne    80121c <strcpy+0xd>
		/* do nothing */;
	return ret;
  801238:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80123b:	c9                   	leave  
  80123c:	c3                   	ret    

0080123d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80123d:	55                   	push   %ebp
  80123e:	89 e5                	mov    %esp,%ebp
  801240:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801243:	8b 45 08             	mov    0x8(%ebp),%eax
  801246:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801249:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801250:	eb 1f                	jmp    801271 <strncpy+0x34>
		*dst++ = *src;
  801252:	8b 45 08             	mov    0x8(%ebp),%eax
  801255:	8d 50 01             	lea    0x1(%eax),%edx
  801258:	89 55 08             	mov    %edx,0x8(%ebp)
  80125b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80125e:	8a 12                	mov    (%edx),%dl
  801260:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801262:	8b 45 0c             	mov    0xc(%ebp),%eax
  801265:	8a 00                	mov    (%eax),%al
  801267:	84 c0                	test   %al,%al
  801269:	74 03                	je     80126e <strncpy+0x31>
			src++;
  80126b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80126e:	ff 45 fc             	incl   -0x4(%ebp)
  801271:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801274:	3b 45 10             	cmp    0x10(%ebp),%eax
  801277:	72 d9                	jb     801252 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801279:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80127c:	c9                   	leave  
  80127d:	c3                   	ret    

0080127e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80127e:	55                   	push   %ebp
  80127f:	89 e5                	mov    %esp,%ebp
  801281:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801284:	8b 45 08             	mov    0x8(%ebp),%eax
  801287:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80128a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80128e:	74 30                	je     8012c0 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801290:	eb 16                	jmp    8012a8 <strlcpy+0x2a>
			*dst++ = *src++;
  801292:	8b 45 08             	mov    0x8(%ebp),%eax
  801295:	8d 50 01             	lea    0x1(%eax),%edx
  801298:	89 55 08             	mov    %edx,0x8(%ebp)
  80129b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80129e:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012a1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012a4:	8a 12                	mov    (%edx),%dl
  8012a6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8012a8:	ff 4d 10             	decl   0x10(%ebp)
  8012ab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012af:	74 09                	je     8012ba <strlcpy+0x3c>
  8012b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b4:	8a 00                	mov    (%eax),%al
  8012b6:	84 c0                	test   %al,%al
  8012b8:	75 d8                	jne    801292 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8012ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bd:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8012c0:	8b 55 08             	mov    0x8(%ebp),%edx
  8012c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c6:	29 c2                	sub    %eax,%edx
  8012c8:	89 d0                	mov    %edx,%eax
}
  8012ca:	c9                   	leave  
  8012cb:	c3                   	ret    

008012cc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8012cc:	55                   	push   %ebp
  8012cd:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8012cf:	eb 06                	jmp    8012d7 <strcmp+0xb>
		p++, q++;
  8012d1:	ff 45 08             	incl   0x8(%ebp)
  8012d4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012da:	8a 00                	mov    (%eax),%al
  8012dc:	84 c0                	test   %al,%al
  8012de:	74 0e                	je     8012ee <strcmp+0x22>
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	8a 10                	mov    (%eax),%dl
  8012e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e8:	8a 00                	mov    (%eax),%al
  8012ea:	38 c2                	cmp    %al,%dl
  8012ec:	74 e3                	je     8012d1 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	8a 00                	mov    (%eax),%al
  8012f3:	0f b6 d0             	movzbl %al,%edx
  8012f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f9:	8a 00                	mov    (%eax),%al
  8012fb:	0f b6 c0             	movzbl %al,%eax
  8012fe:	29 c2                	sub    %eax,%edx
  801300:	89 d0                	mov    %edx,%eax
}
  801302:	5d                   	pop    %ebp
  801303:	c3                   	ret    

00801304 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801304:	55                   	push   %ebp
  801305:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801307:	eb 09                	jmp    801312 <strncmp+0xe>
		n--, p++, q++;
  801309:	ff 4d 10             	decl   0x10(%ebp)
  80130c:	ff 45 08             	incl   0x8(%ebp)
  80130f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801312:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801316:	74 17                	je     80132f <strncmp+0x2b>
  801318:	8b 45 08             	mov    0x8(%ebp),%eax
  80131b:	8a 00                	mov    (%eax),%al
  80131d:	84 c0                	test   %al,%al
  80131f:	74 0e                	je     80132f <strncmp+0x2b>
  801321:	8b 45 08             	mov    0x8(%ebp),%eax
  801324:	8a 10                	mov    (%eax),%dl
  801326:	8b 45 0c             	mov    0xc(%ebp),%eax
  801329:	8a 00                	mov    (%eax),%al
  80132b:	38 c2                	cmp    %al,%dl
  80132d:	74 da                	je     801309 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80132f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801333:	75 07                	jne    80133c <strncmp+0x38>
		return 0;
  801335:	b8 00 00 00 00       	mov    $0x0,%eax
  80133a:	eb 14                	jmp    801350 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80133c:	8b 45 08             	mov    0x8(%ebp),%eax
  80133f:	8a 00                	mov    (%eax),%al
  801341:	0f b6 d0             	movzbl %al,%edx
  801344:	8b 45 0c             	mov    0xc(%ebp),%eax
  801347:	8a 00                	mov    (%eax),%al
  801349:	0f b6 c0             	movzbl %al,%eax
  80134c:	29 c2                	sub    %eax,%edx
  80134e:	89 d0                	mov    %edx,%eax
}
  801350:	5d                   	pop    %ebp
  801351:	c3                   	ret    

00801352 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801352:	55                   	push   %ebp
  801353:	89 e5                	mov    %esp,%ebp
  801355:	83 ec 04             	sub    $0x4,%esp
  801358:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80135e:	eb 12                	jmp    801372 <strchr+0x20>
		if (*s == c)
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	8a 00                	mov    (%eax),%al
  801365:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801368:	75 05                	jne    80136f <strchr+0x1d>
			return (char *) s;
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	eb 11                	jmp    801380 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80136f:	ff 45 08             	incl   0x8(%ebp)
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	8a 00                	mov    (%eax),%al
  801377:	84 c0                	test   %al,%al
  801379:	75 e5                	jne    801360 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80137b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801380:	c9                   	leave  
  801381:	c3                   	ret    

00801382 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
  801385:	83 ec 04             	sub    $0x4,%esp
  801388:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80138e:	eb 0d                	jmp    80139d <strfind+0x1b>
		if (*s == c)
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	8a 00                	mov    (%eax),%al
  801395:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801398:	74 0e                	je     8013a8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80139a:	ff 45 08             	incl   0x8(%ebp)
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	84 c0                	test   %al,%al
  8013a4:	75 ea                	jne    801390 <strfind+0xe>
  8013a6:	eb 01                	jmp    8013a9 <strfind+0x27>
		if (*s == c)
			break;
  8013a8:	90                   	nop
	return (char *) s;
  8013a9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
  8013b1:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8013ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8013bd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8013c0:	eb 0e                	jmp    8013d0 <memset+0x22>
		*p++ = c;
  8013c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013c5:	8d 50 01             	lea    0x1(%eax),%edx
  8013c8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ce:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8013d0:	ff 4d f8             	decl   -0x8(%ebp)
  8013d3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8013d7:	79 e9                	jns    8013c2 <memset+0x14>
		*p++ = c;

	return v;
  8013d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013dc:	c9                   	leave  
  8013dd:	c3                   	ret    

008013de <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8013de:	55                   	push   %ebp
  8013df:	89 e5                	mov    %esp,%ebp
  8013e1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8013e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8013f0:	eb 16                	jmp    801408 <memcpy+0x2a>
		*d++ = *s++;
  8013f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013f5:	8d 50 01             	lea    0x1(%eax),%edx
  8013f8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013fe:	8d 4a 01             	lea    0x1(%edx),%ecx
  801401:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801404:	8a 12                	mov    (%edx),%dl
  801406:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801408:	8b 45 10             	mov    0x10(%ebp),%eax
  80140b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80140e:	89 55 10             	mov    %edx,0x10(%ebp)
  801411:	85 c0                	test   %eax,%eax
  801413:	75 dd                	jne    8013f2 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801415:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801418:	c9                   	leave  
  801419:	c3                   	ret    

0080141a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80141a:	55                   	push   %ebp
  80141b:	89 e5                	mov    %esp,%ebp
  80141d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801420:	8b 45 0c             	mov    0xc(%ebp),%eax
  801423:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801426:	8b 45 08             	mov    0x8(%ebp),%eax
  801429:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80142c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80142f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801432:	73 50                	jae    801484 <memmove+0x6a>
  801434:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801437:	8b 45 10             	mov    0x10(%ebp),%eax
  80143a:	01 d0                	add    %edx,%eax
  80143c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80143f:	76 43                	jbe    801484 <memmove+0x6a>
		s += n;
  801441:	8b 45 10             	mov    0x10(%ebp),%eax
  801444:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801447:	8b 45 10             	mov    0x10(%ebp),%eax
  80144a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80144d:	eb 10                	jmp    80145f <memmove+0x45>
			*--d = *--s;
  80144f:	ff 4d f8             	decl   -0x8(%ebp)
  801452:	ff 4d fc             	decl   -0x4(%ebp)
  801455:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801458:	8a 10                	mov    (%eax),%dl
  80145a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80145d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80145f:	8b 45 10             	mov    0x10(%ebp),%eax
  801462:	8d 50 ff             	lea    -0x1(%eax),%edx
  801465:	89 55 10             	mov    %edx,0x10(%ebp)
  801468:	85 c0                	test   %eax,%eax
  80146a:	75 e3                	jne    80144f <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80146c:	eb 23                	jmp    801491 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80146e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801471:	8d 50 01             	lea    0x1(%eax),%edx
  801474:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801477:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80147a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80147d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801480:	8a 12                	mov    (%edx),%dl
  801482:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801484:	8b 45 10             	mov    0x10(%ebp),%eax
  801487:	8d 50 ff             	lea    -0x1(%eax),%edx
  80148a:	89 55 10             	mov    %edx,0x10(%ebp)
  80148d:	85 c0                	test   %eax,%eax
  80148f:	75 dd                	jne    80146e <memmove+0x54>
			*d++ = *s++;

	return dst;
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801494:	c9                   	leave  
  801495:	c3                   	ret    

00801496 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801496:	55                   	push   %ebp
  801497:	89 e5                	mov    %esp,%ebp
  801499:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8014a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8014a8:	eb 2a                	jmp    8014d4 <memcmp+0x3e>
		if (*s1 != *s2)
  8014aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ad:	8a 10                	mov    (%eax),%dl
  8014af:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b2:	8a 00                	mov    (%eax),%al
  8014b4:	38 c2                	cmp    %al,%dl
  8014b6:	74 16                	je     8014ce <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8014b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014bb:	8a 00                	mov    (%eax),%al
  8014bd:	0f b6 d0             	movzbl %al,%edx
  8014c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c3:	8a 00                	mov    (%eax),%al
  8014c5:	0f b6 c0             	movzbl %al,%eax
  8014c8:	29 c2                	sub    %eax,%edx
  8014ca:	89 d0                	mov    %edx,%eax
  8014cc:	eb 18                	jmp    8014e6 <memcmp+0x50>
		s1++, s2++;
  8014ce:	ff 45 fc             	incl   -0x4(%ebp)
  8014d1:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8014d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014da:	89 55 10             	mov    %edx,0x10(%ebp)
  8014dd:	85 c0                	test   %eax,%eax
  8014df:	75 c9                	jne    8014aa <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8014e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014e6:	c9                   	leave  
  8014e7:	c3                   	ret    

008014e8 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8014e8:	55                   	push   %ebp
  8014e9:	89 e5                	mov    %esp,%ebp
  8014eb:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8014ee:	8b 55 08             	mov    0x8(%ebp),%edx
  8014f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f4:	01 d0                	add    %edx,%eax
  8014f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8014f9:	eb 15                	jmp    801510 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8014fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fe:	8a 00                	mov    (%eax),%al
  801500:	0f b6 d0             	movzbl %al,%edx
  801503:	8b 45 0c             	mov    0xc(%ebp),%eax
  801506:	0f b6 c0             	movzbl %al,%eax
  801509:	39 c2                	cmp    %eax,%edx
  80150b:	74 0d                	je     80151a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80150d:	ff 45 08             	incl   0x8(%ebp)
  801510:	8b 45 08             	mov    0x8(%ebp),%eax
  801513:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801516:	72 e3                	jb     8014fb <memfind+0x13>
  801518:	eb 01                	jmp    80151b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80151a:	90                   	nop
	return (void *) s;
  80151b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
  801523:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801526:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80152d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801534:	eb 03                	jmp    801539 <strtol+0x19>
		s++;
  801536:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801539:	8b 45 08             	mov    0x8(%ebp),%eax
  80153c:	8a 00                	mov    (%eax),%al
  80153e:	3c 20                	cmp    $0x20,%al
  801540:	74 f4                	je     801536 <strtol+0x16>
  801542:	8b 45 08             	mov    0x8(%ebp),%eax
  801545:	8a 00                	mov    (%eax),%al
  801547:	3c 09                	cmp    $0x9,%al
  801549:	74 eb                	je     801536 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	8a 00                	mov    (%eax),%al
  801550:	3c 2b                	cmp    $0x2b,%al
  801552:	75 05                	jne    801559 <strtol+0x39>
		s++;
  801554:	ff 45 08             	incl   0x8(%ebp)
  801557:	eb 13                	jmp    80156c <strtol+0x4c>
	else if (*s == '-')
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	8a 00                	mov    (%eax),%al
  80155e:	3c 2d                	cmp    $0x2d,%al
  801560:	75 0a                	jne    80156c <strtol+0x4c>
		s++, neg = 1;
  801562:	ff 45 08             	incl   0x8(%ebp)
  801565:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80156c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801570:	74 06                	je     801578 <strtol+0x58>
  801572:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801576:	75 20                	jne    801598 <strtol+0x78>
  801578:	8b 45 08             	mov    0x8(%ebp),%eax
  80157b:	8a 00                	mov    (%eax),%al
  80157d:	3c 30                	cmp    $0x30,%al
  80157f:	75 17                	jne    801598 <strtol+0x78>
  801581:	8b 45 08             	mov    0x8(%ebp),%eax
  801584:	40                   	inc    %eax
  801585:	8a 00                	mov    (%eax),%al
  801587:	3c 78                	cmp    $0x78,%al
  801589:	75 0d                	jne    801598 <strtol+0x78>
		s += 2, base = 16;
  80158b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80158f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801596:	eb 28                	jmp    8015c0 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801598:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80159c:	75 15                	jne    8015b3 <strtol+0x93>
  80159e:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a1:	8a 00                	mov    (%eax),%al
  8015a3:	3c 30                	cmp    $0x30,%al
  8015a5:	75 0c                	jne    8015b3 <strtol+0x93>
		s++, base = 8;
  8015a7:	ff 45 08             	incl   0x8(%ebp)
  8015aa:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8015b1:	eb 0d                	jmp    8015c0 <strtol+0xa0>
	else if (base == 0)
  8015b3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015b7:	75 07                	jne    8015c0 <strtol+0xa0>
		base = 10;
  8015b9:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8015c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c3:	8a 00                	mov    (%eax),%al
  8015c5:	3c 2f                	cmp    $0x2f,%al
  8015c7:	7e 19                	jle    8015e2 <strtol+0xc2>
  8015c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cc:	8a 00                	mov    (%eax),%al
  8015ce:	3c 39                	cmp    $0x39,%al
  8015d0:	7f 10                	jg     8015e2 <strtol+0xc2>
			dig = *s - '0';
  8015d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d5:	8a 00                	mov    (%eax),%al
  8015d7:	0f be c0             	movsbl %al,%eax
  8015da:	83 e8 30             	sub    $0x30,%eax
  8015dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8015e0:	eb 42                	jmp    801624 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8015e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e5:	8a 00                	mov    (%eax),%al
  8015e7:	3c 60                	cmp    $0x60,%al
  8015e9:	7e 19                	jle    801604 <strtol+0xe4>
  8015eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ee:	8a 00                	mov    (%eax),%al
  8015f0:	3c 7a                	cmp    $0x7a,%al
  8015f2:	7f 10                	jg     801604 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8015f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f7:	8a 00                	mov    (%eax),%al
  8015f9:	0f be c0             	movsbl %al,%eax
  8015fc:	83 e8 57             	sub    $0x57,%eax
  8015ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801602:	eb 20                	jmp    801624 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801604:	8b 45 08             	mov    0x8(%ebp),%eax
  801607:	8a 00                	mov    (%eax),%al
  801609:	3c 40                	cmp    $0x40,%al
  80160b:	7e 39                	jle    801646 <strtol+0x126>
  80160d:	8b 45 08             	mov    0x8(%ebp),%eax
  801610:	8a 00                	mov    (%eax),%al
  801612:	3c 5a                	cmp    $0x5a,%al
  801614:	7f 30                	jg     801646 <strtol+0x126>
			dig = *s - 'A' + 10;
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	8a 00                	mov    (%eax),%al
  80161b:	0f be c0             	movsbl %al,%eax
  80161e:	83 e8 37             	sub    $0x37,%eax
  801621:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801624:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801627:	3b 45 10             	cmp    0x10(%ebp),%eax
  80162a:	7d 19                	jge    801645 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80162c:	ff 45 08             	incl   0x8(%ebp)
  80162f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801632:	0f af 45 10          	imul   0x10(%ebp),%eax
  801636:	89 c2                	mov    %eax,%edx
  801638:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80163b:	01 d0                	add    %edx,%eax
  80163d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801640:	e9 7b ff ff ff       	jmp    8015c0 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801645:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801646:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80164a:	74 08                	je     801654 <strtol+0x134>
		*endptr = (char *) s;
  80164c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164f:	8b 55 08             	mov    0x8(%ebp),%edx
  801652:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801654:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801658:	74 07                	je     801661 <strtol+0x141>
  80165a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80165d:	f7 d8                	neg    %eax
  80165f:	eb 03                	jmp    801664 <strtol+0x144>
  801661:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <ltostr>:

void
ltostr(long value, char *str)
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
  801669:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80166c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801673:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80167a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80167e:	79 13                	jns    801693 <ltostr+0x2d>
	{
		neg = 1;
  801680:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801687:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80168d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801690:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80169b:	99                   	cltd   
  80169c:	f7 f9                	idiv   %ecx
  80169e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8016a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a4:	8d 50 01             	lea    0x1(%eax),%edx
  8016a7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016aa:	89 c2                	mov    %eax,%edx
  8016ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016af:	01 d0                	add    %edx,%eax
  8016b1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016b4:	83 c2 30             	add    $0x30,%edx
  8016b7:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8016b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016bc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8016c1:	f7 e9                	imul   %ecx
  8016c3:	c1 fa 02             	sar    $0x2,%edx
  8016c6:	89 c8                	mov    %ecx,%eax
  8016c8:	c1 f8 1f             	sar    $0x1f,%eax
  8016cb:	29 c2                	sub    %eax,%edx
  8016cd:	89 d0                	mov    %edx,%eax
  8016cf:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8016d2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016d5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8016da:	f7 e9                	imul   %ecx
  8016dc:	c1 fa 02             	sar    $0x2,%edx
  8016df:	89 c8                	mov    %ecx,%eax
  8016e1:	c1 f8 1f             	sar    $0x1f,%eax
  8016e4:	29 c2                	sub    %eax,%edx
  8016e6:	89 d0                	mov    %edx,%eax
  8016e8:	c1 e0 02             	shl    $0x2,%eax
  8016eb:	01 d0                	add    %edx,%eax
  8016ed:	01 c0                	add    %eax,%eax
  8016ef:	29 c1                	sub    %eax,%ecx
  8016f1:	89 ca                	mov    %ecx,%edx
  8016f3:	85 d2                	test   %edx,%edx
  8016f5:	75 9c                	jne    801693 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8016f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8016fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801701:	48                   	dec    %eax
  801702:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801705:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801709:	74 3d                	je     801748 <ltostr+0xe2>
		start = 1 ;
  80170b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801712:	eb 34                	jmp    801748 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801714:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801717:	8b 45 0c             	mov    0xc(%ebp),%eax
  80171a:	01 d0                	add    %edx,%eax
  80171c:	8a 00                	mov    (%eax),%al
  80171e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801721:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801724:	8b 45 0c             	mov    0xc(%ebp),%eax
  801727:	01 c2                	add    %eax,%edx
  801729:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80172c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172f:	01 c8                	add    %ecx,%eax
  801731:	8a 00                	mov    (%eax),%al
  801733:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801735:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801738:	8b 45 0c             	mov    0xc(%ebp),%eax
  80173b:	01 c2                	add    %eax,%edx
  80173d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801740:	88 02                	mov    %al,(%edx)
		start++ ;
  801742:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801745:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801748:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80174b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80174e:	7c c4                	jl     801714 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801750:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801753:	8b 45 0c             	mov    0xc(%ebp),%eax
  801756:	01 d0                	add    %edx,%eax
  801758:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80175b:	90                   	nop
  80175c:	c9                   	leave  
  80175d:	c3                   	ret    

0080175e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80175e:	55                   	push   %ebp
  80175f:	89 e5                	mov    %esp,%ebp
  801761:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801764:	ff 75 08             	pushl  0x8(%ebp)
  801767:	e8 54 fa ff ff       	call   8011c0 <strlen>
  80176c:	83 c4 04             	add    $0x4,%esp
  80176f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801772:	ff 75 0c             	pushl  0xc(%ebp)
  801775:	e8 46 fa ff ff       	call   8011c0 <strlen>
  80177a:	83 c4 04             	add    $0x4,%esp
  80177d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801780:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801787:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80178e:	eb 17                	jmp    8017a7 <strcconcat+0x49>
		final[s] = str1[s] ;
  801790:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801793:	8b 45 10             	mov    0x10(%ebp),%eax
  801796:	01 c2                	add    %eax,%edx
  801798:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80179b:	8b 45 08             	mov    0x8(%ebp),%eax
  80179e:	01 c8                	add    %ecx,%eax
  8017a0:	8a 00                	mov    (%eax),%al
  8017a2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8017a4:	ff 45 fc             	incl   -0x4(%ebp)
  8017a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017aa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8017ad:	7c e1                	jl     801790 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8017af:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8017b6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8017bd:	eb 1f                	jmp    8017de <strcconcat+0x80>
		final[s++] = str2[i] ;
  8017bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017c2:	8d 50 01             	lea    0x1(%eax),%edx
  8017c5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8017c8:	89 c2                	mov    %eax,%edx
  8017ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8017cd:	01 c2                	add    %eax,%edx
  8017cf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8017d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d5:	01 c8                	add    %ecx,%eax
  8017d7:	8a 00                	mov    (%eax),%al
  8017d9:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8017db:	ff 45 f8             	incl   -0x8(%ebp)
  8017de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017e1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017e4:	7c d9                	jl     8017bf <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8017e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ec:	01 d0                	add    %edx,%eax
  8017ee:	c6 00 00             	movb   $0x0,(%eax)
}
  8017f1:	90                   	nop
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8017f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8017fa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801800:	8b 45 14             	mov    0x14(%ebp),%eax
  801803:	8b 00                	mov    (%eax),%eax
  801805:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80180c:	8b 45 10             	mov    0x10(%ebp),%eax
  80180f:	01 d0                	add    %edx,%eax
  801811:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801817:	eb 0c                	jmp    801825 <strsplit+0x31>
			*string++ = 0;
  801819:	8b 45 08             	mov    0x8(%ebp),%eax
  80181c:	8d 50 01             	lea    0x1(%eax),%edx
  80181f:	89 55 08             	mov    %edx,0x8(%ebp)
  801822:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801825:	8b 45 08             	mov    0x8(%ebp),%eax
  801828:	8a 00                	mov    (%eax),%al
  80182a:	84 c0                	test   %al,%al
  80182c:	74 18                	je     801846 <strsplit+0x52>
  80182e:	8b 45 08             	mov    0x8(%ebp),%eax
  801831:	8a 00                	mov    (%eax),%al
  801833:	0f be c0             	movsbl %al,%eax
  801836:	50                   	push   %eax
  801837:	ff 75 0c             	pushl  0xc(%ebp)
  80183a:	e8 13 fb ff ff       	call   801352 <strchr>
  80183f:	83 c4 08             	add    $0x8,%esp
  801842:	85 c0                	test   %eax,%eax
  801844:	75 d3                	jne    801819 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801846:	8b 45 08             	mov    0x8(%ebp),%eax
  801849:	8a 00                	mov    (%eax),%al
  80184b:	84 c0                	test   %al,%al
  80184d:	74 5a                	je     8018a9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80184f:	8b 45 14             	mov    0x14(%ebp),%eax
  801852:	8b 00                	mov    (%eax),%eax
  801854:	83 f8 0f             	cmp    $0xf,%eax
  801857:	75 07                	jne    801860 <strsplit+0x6c>
		{
			return 0;
  801859:	b8 00 00 00 00       	mov    $0x0,%eax
  80185e:	eb 66                	jmp    8018c6 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801860:	8b 45 14             	mov    0x14(%ebp),%eax
  801863:	8b 00                	mov    (%eax),%eax
  801865:	8d 48 01             	lea    0x1(%eax),%ecx
  801868:	8b 55 14             	mov    0x14(%ebp),%edx
  80186b:	89 0a                	mov    %ecx,(%edx)
  80186d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801874:	8b 45 10             	mov    0x10(%ebp),%eax
  801877:	01 c2                	add    %eax,%edx
  801879:	8b 45 08             	mov    0x8(%ebp),%eax
  80187c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80187e:	eb 03                	jmp    801883 <strsplit+0x8f>
			string++;
  801880:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801883:	8b 45 08             	mov    0x8(%ebp),%eax
  801886:	8a 00                	mov    (%eax),%al
  801888:	84 c0                	test   %al,%al
  80188a:	74 8b                	je     801817 <strsplit+0x23>
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
  80188f:	8a 00                	mov    (%eax),%al
  801891:	0f be c0             	movsbl %al,%eax
  801894:	50                   	push   %eax
  801895:	ff 75 0c             	pushl  0xc(%ebp)
  801898:	e8 b5 fa ff ff       	call   801352 <strchr>
  80189d:	83 c4 08             	add    $0x8,%esp
  8018a0:	85 c0                	test   %eax,%eax
  8018a2:	74 dc                	je     801880 <strsplit+0x8c>
			string++;
	}
  8018a4:	e9 6e ff ff ff       	jmp    801817 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8018a9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8018aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ad:	8b 00                	mov    (%eax),%eax
  8018af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b9:	01 d0                	add    %edx,%eax
  8018bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8018c1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8018c6:	c9                   	leave  
  8018c7:	c3                   	ret    

008018c8 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8018c8:	55                   	push   %ebp
  8018c9:	89 e5                	mov    %esp,%ebp
  8018cb:	57                   	push   %edi
  8018cc:	56                   	push   %esi
  8018cd:	53                   	push   %ebx
  8018ce:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8018d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018da:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018dd:	8b 7d 18             	mov    0x18(%ebp),%edi
  8018e0:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8018e3:	cd 30                	int    $0x30
  8018e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8018e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8018eb:	83 c4 10             	add    $0x10,%esp
  8018ee:	5b                   	pop    %ebx
  8018ef:	5e                   	pop    %esi
  8018f0:	5f                   	pop    %edi
  8018f1:	5d                   	pop    %ebp
  8018f2:	c3                   	ret    

008018f3 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8018f3:	55                   	push   %ebp
  8018f4:	89 e5                	mov    %esp,%ebp
  8018f6:	83 ec 04             	sub    $0x4,%esp
  8018f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018fc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8018ff:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801903:	8b 45 08             	mov    0x8(%ebp),%eax
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	52                   	push   %edx
  80190b:	ff 75 0c             	pushl  0xc(%ebp)
  80190e:	50                   	push   %eax
  80190f:	6a 00                	push   $0x0
  801911:	e8 b2 ff ff ff       	call   8018c8 <syscall>
  801916:	83 c4 18             	add    $0x18,%esp
}
  801919:	90                   	nop
  80191a:	c9                   	leave  
  80191b:	c3                   	ret    

0080191c <sys_cgetc>:

int
sys_cgetc(void)
{
  80191c:	55                   	push   %ebp
  80191d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 01                	push   $0x1
  80192b:	e8 98 ff ff ff       	call   8018c8 <syscall>
  801930:	83 c4 18             	add    $0x18,%esp
}
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801938:	8b 45 08             	mov    0x8(%ebp),%eax
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	50                   	push   %eax
  801944:	6a 05                	push   $0x5
  801946:	e8 7d ff ff ff       	call   8018c8 <syscall>
  80194b:	83 c4 18             	add    $0x18,%esp
}
  80194e:	c9                   	leave  
  80194f:	c3                   	ret    

00801950 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801950:	55                   	push   %ebp
  801951:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 02                	push   $0x2
  80195f:	e8 64 ff ff ff       	call   8018c8 <syscall>
  801964:	83 c4 18             	add    $0x18,%esp
}
  801967:	c9                   	leave  
  801968:	c3                   	ret    

00801969 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801969:	55                   	push   %ebp
  80196a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 03                	push   $0x3
  801978:	e8 4b ff ff ff       	call   8018c8 <syscall>
  80197d:	83 c4 18             	add    $0x18,%esp
}
  801980:	c9                   	leave  
  801981:	c3                   	ret    

00801982 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801982:	55                   	push   %ebp
  801983:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 04                	push   $0x4
  801991:	e8 32 ff ff ff       	call   8018c8 <syscall>
  801996:	83 c4 18             	add    $0x18,%esp
}
  801999:	c9                   	leave  
  80199a:	c3                   	ret    

0080199b <sys_env_exit>:


void sys_env_exit(void)
{
  80199b:	55                   	push   %ebp
  80199c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 06                	push   $0x6
  8019aa:	e8 19 ff ff ff       	call   8018c8 <syscall>
  8019af:	83 c4 18             	add    $0x18,%esp
}
  8019b2:	90                   	nop
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8019b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	52                   	push   %edx
  8019c5:	50                   	push   %eax
  8019c6:	6a 07                	push   $0x7
  8019c8:	e8 fb fe ff ff       	call   8018c8 <syscall>
  8019cd:	83 c4 18             	add    $0x18,%esp
}
  8019d0:	c9                   	leave  
  8019d1:	c3                   	ret    

008019d2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8019d2:	55                   	push   %ebp
  8019d3:	89 e5                	mov    %esp,%ebp
  8019d5:	56                   	push   %esi
  8019d6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8019d7:	8b 75 18             	mov    0x18(%ebp),%esi
  8019da:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e6:	56                   	push   %esi
  8019e7:	53                   	push   %ebx
  8019e8:	51                   	push   %ecx
  8019e9:	52                   	push   %edx
  8019ea:	50                   	push   %eax
  8019eb:	6a 08                	push   $0x8
  8019ed:	e8 d6 fe ff ff       	call   8018c8 <syscall>
  8019f2:	83 c4 18             	add    $0x18,%esp
}
  8019f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8019f8:	5b                   	pop    %ebx
  8019f9:	5e                   	pop    %esi
  8019fa:	5d                   	pop    %ebp
  8019fb:	c3                   	ret    

008019fc <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8019ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a02:	8b 45 08             	mov    0x8(%ebp),%eax
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	52                   	push   %edx
  801a0c:	50                   	push   %eax
  801a0d:	6a 09                	push   $0x9
  801a0f:	e8 b4 fe ff ff       	call   8018c8 <syscall>
  801a14:	83 c4 18             	add    $0x18,%esp
}
  801a17:	c9                   	leave  
  801a18:	c3                   	ret    

00801a19 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	ff 75 0c             	pushl  0xc(%ebp)
  801a25:	ff 75 08             	pushl  0x8(%ebp)
  801a28:	6a 0a                	push   $0xa
  801a2a:	e8 99 fe ff ff       	call   8018c8 <syscall>
  801a2f:	83 c4 18             	add    $0x18,%esp
}
  801a32:	c9                   	leave  
  801a33:	c3                   	ret    

00801a34 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801a34:	55                   	push   %ebp
  801a35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 0b                	push   $0xb
  801a43:	e8 80 fe ff ff       	call   8018c8 <syscall>
  801a48:	83 c4 18             	add    $0x18,%esp
}
  801a4b:	c9                   	leave  
  801a4c:	c3                   	ret    

00801a4d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801a4d:	55                   	push   %ebp
  801a4e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 0c                	push   $0xc
  801a5c:	e8 67 fe ff ff       	call   8018c8 <syscall>
  801a61:	83 c4 18             	add    $0x18,%esp
}
  801a64:	c9                   	leave  
  801a65:	c3                   	ret    

00801a66 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801a66:	55                   	push   %ebp
  801a67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 0d                	push   $0xd
  801a75:	e8 4e fe ff ff       	call   8018c8 <syscall>
  801a7a:	83 c4 18             	add    $0x18,%esp
}
  801a7d:	c9                   	leave  
  801a7e:	c3                   	ret    

00801a7f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801a7f:	55                   	push   %ebp
  801a80:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	ff 75 0c             	pushl  0xc(%ebp)
  801a8b:	ff 75 08             	pushl  0x8(%ebp)
  801a8e:	6a 11                	push   $0x11
  801a90:	e8 33 fe ff ff       	call   8018c8 <syscall>
  801a95:	83 c4 18             	add    $0x18,%esp
	return;
  801a98:	90                   	nop
}
  801a99:	c9                   	leave  
  801a9a:	c3                   	ret    

00801a9b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a9b:	55                   	push   %ebp
  801a9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	ff 75 0c             	pushl  0xc(%ebp)
  801aa7:	ff 75 08             	pushl  0x8(%ebp)
  801aaa:	6a 12                	push   $0x12
  801aac:	e8 17 fe ff ff       	call   8018c8 <syscall>
  801ab1:	83 c4 18             	add    $0x18,%esp
	return ;
  801ab4:	90                   	nop
}
  801ab5:	c9                   	leave  
  801ab6:	c3                   	ret    

00801ab7 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801ab7:	55                   	push   %ebp
  801ab8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 0e                	push   $0xe
  801ac6:	e8 fd fd ff ff       	call   8018c8 <syscall>
  801acb:	83 c4 18             	add    $0x18,%esp
}
  801ace:	c9                   	leave  
  801acf:	c3                   	ret    

00801ad0 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ad0:	55                   	push   %ebp
  801ad1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	ff 75 08             	pushl  0x8(%ebp)
  801ade:	6a 0f                	push   $0xf
  801ae0:	e8 e3 fd ff ff       	call   8018c8 <syscall>
  801ae5:	83 c4 18             	add    $0x18,%esp
}
  801ae8:	c9                   	leave  
  801ae9:	c3                   	ret    

00801aea <sys_scarce_memory>:

void sys_scarce_memory()
{
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	6a 10                	push   $0x10
  801af9:	e8 ca fd ff ff       	call   8018c8 <syscall>
  801afe:	83 c4 18             	add    $0x18,%esp
}
  801b01:	90                   	nop
  801b02:	c9                   	leave  
  801b03:	c3                   	ret    

00801b04 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801b04:	55                   	push   %ebp
  801b05:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801b07:	6a 00                	push   $0x0
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 14                	push   $0x14
  801b13:	e8 b0 fd ff ff       	call   8018c8 <syscall>
  801b18:	83 c4 18             	add    $0x18,%esp
}
  801b1b:	90                   	nop
  801b1c:	c9                   	leave  
  801b1d:	c3                   	ret    

00801b1e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801b1e:	55                   	push   %ebp
  801b1f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 15                	push   $0x15
  801b2d:	e8 96 fd ff ff       	call   8018c8 <syscall>
  801b32:	83 c4 18             	add    $0x18,%esp
}
  801b35:	90                   	nop
  801b36:	c9                   	leave  
  801b37:	c3                   	ret    

00801b38 <sys_cputc>:


void
sys_cputc(const char c)
{
  801b38:	55                   	push   %ebp
  801b39:	89 e5                	mov    %esp,%ebp
  801b3b:	83 ec 04             	sub    $0x4,%esp
  801b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b41:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801b44:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	50                   	push   %eax
  801b51:	6a 16                	push   $0x16
  801b53:	e8 70 fd ff ff       	call   8018c8 <syscall>
  801b58:	83 c4 18             	add    $0x18,%esp
}
  801b5b:	90                   	nop
  801b5c:	c9                   	leave  
  801b5d:	c3                   	ret    

00801b5e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801b5e:	55                   	push   %ebp
  801b5f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 17                	push   $0x17
  801b6d:	e8 56 fd ff ff       	call   8018c8 <syscall>
  801b72:	83 c4 18             	add    $0x18,%esp
}
  801b75:	90                   	nop
  801b76:	c9                   	leave  
  801b77:	c3                   	ret    

00801b78 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801b78:	55                   	push   %ebp
  801b79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	ff 75 0c             	pushl  0xc(%ebp)
  801b87:	50                   	push   %eax
  801b88:	6a 18                	push   $0x18
  801b8a:	e8 39 fd ff ff       	call   8018c8 <syscall>
  801b8f:	83 c4 18             	add    $0x18,%esp
}
  801b92:	c9                   	leave  
  801b93:	c3                   	ret    

00801b94 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b94:	55                   	push   %ebp
  801b95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	52                   	push   %edx
  801ba4:	50                   	push   %eax
  801ba5:	6a 1b                	push   $0x1b
  801ba7:	e8 1c fd ff ff       	call   8018c8 <syscall>
  801bac:	83 c4 18             	add    $0x18,%esp
}
  801baf:	c9                   	leave  
  801bb0:	c3                   	ret    

00801bb1 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801bb1:	55                   	push   %ebp
  801bb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801bb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 00                	push   $0x0
  801bc0:	52                   	push   %edx
  801bc1:	50                   	push   %eax
  801bc2:	6a 19                	push   $0x19
  801bc4:	e8 ff fc ff ff       	call   8018c8 <syscall>
  801bc9:	83 c4 18             	add    $0x18,%esp
}
  801bcc:	90                   	nop
  801bcd:	c9                   	leave  
  801bce:	c3                   	ret    

00801bcf <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801bcf:	55                   	push   %ebp
  801bd0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801bd2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	52                   	push   %edx
  801bdf:	50                   	push   %eax
  801be0:	6a 1a                	push   $0x1a
  801be2:	e8 e1 fc ff ff       	call   8018c8 <syscall>
  801be7:	83 c4 18             	add    $0x18,%esp
}
  801bea:	90                   	nop
  801beb:	c9                   	leave  
  801bec:	c3                   	ret    

00801bed <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801bed:	55                   	push   %ebp
  801bee:	89 e5                	mov    %esp,%ebp
  801bf0:	83 ec 04             	sub    $0x4,%esp
  801bf3:	8b 45 10             	mov    0x10(%ebp),%eax
  801bf6:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801bf9:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801bfc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c00:	8b 45 08             	mov    0x8(%ebp),%eax
  801c03:	6a 00                	push   $0x0
  801c05:	51                   	push   %ecx
  801c06:	52                   	push   %edx
  801c07:	ff 75 0c             	pushl  0xc(%ebp)
  801c0a:	50                   	push   %eax
  801c0b:	6a 1c                	push   $0x1c
  801c0d:	e8 b6 fc ff ff       	call   8018c8 <syscall>
  801c12:	83 c4 18             	add    $0x18,%esp
}
  801c15:	c9                   	leave  
  801c16:	c3                   	ret    

00801c17 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801c17:	55                   	push   %ebp
  801c18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801c1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c20:	6a 00                	push   $0x0
  801c22:	6a 00                	push   $0x0
  801c24:	6a 00                	push   $0x0
  801c26:	52                   	push   %edx
  801c27:	50                   	push   %eax
  801c28:	6a 1d                	push   $0x1d
  801c2a:	e8 99 fc ff ff       	call   8018c8 <syscall>
  801c2f:	83 c4 18             	add    $0x18,%esp
}
  801c32:	c9                   	leave  
  801c33:	c3                   	ret    

00801c34 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801c34:	55                   	push   %ebp
  801c35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801c37:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	51                   	push   %ecx
  801c45:	52                   	push   %edx
  801c46:	50                   	push   %eax
  801c47:	6a 1e                	push   $0x1e
  801c49:	e8 7a fc ff ff       	call   8018c8 <syscall>
  801c4e:	83 c4 18             	add    $0x18,%esp
}
  801c51:	c9                   	leave  
  801c52:	c3                   	ret    

00801c53 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801c53:	55                   	push   %ebp
  801c54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801c56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c59:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	52                   	push   %edx
  801c63:	50                   	push   %eax
  801c64:	6a 1f                	push   $0x1f
  801c66:	e8 5d fc ff ff       	call   8018c8 <syscall>
  801c6b:	83 c4 18             	add    $0x18,%esp
}
  801c6e:	c9                   	leave  
  801c6f:	c3                   	ret    

00801c70 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801c70:	55                   	push   %ebp
  801c71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 20                	push   $0x20
  801c7f:	e8 44 fc ff ff       	call   8018c8 <syscall>
  801c84:	83 c4 18             	add    $0x18,%esp
}
  801c87:	c9                   	leave  
  801c88:	c3                   	ret    

00801c89 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801c89:	55                   	push   %ebp
  801c8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8f:	6a 00                	push   $0x0
  801c91:	ff 75 14             	pushl  0x14(%ebp)
  801c94:	ff 75 10             	pushl  0x10(%ebp)
  801c97:	ff 75 0c             	pushl  0xc(%ebp)
  801c9a:	50                   	push   %eax
  801c9b:	6a 21                	push   $0x21
  801c9d:	e8 26 fc ff ff       	call   8018c8 <syscall>
  801ca2:	83 c4 18             	add    $0x18,%esp
}
  801ca5:	c9                   	leave  
  801ca6:	c3                   	ret    

00801ca7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ca7:	55                   	push   %ebp
  801ca8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801caa:	8b 45 08             	mov    0x8(%ebp),%eax
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	50                   	push   %eax
  801cb6:	6a 22                	push   $0x22
  801cb8:	e8 0b fc ff ff       	call   8018c8 <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
}
  801cc0:	90                   	nop
  801cc1:	c9                   	leave  
  801cc2:	c3                   	ret    

00801cc3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801cc3:	55                   	push   %ebp
  801cc4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	50                   	push   %eax
  801cd2:	6a 23                	push   $0x23
  801cd4:	e8 ef fb ff ff       	call   8018c8 <syscall>
  801cd9:	83 c4 18             	add    $0x18,%esp
}
  801cdc:	90                   	nop
  801cdd:	c9                   	leave  
  801cde:	c3                   	ret    

00801cdf <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801cdf:	55                   	push   %ebp
  801ce0:	89 e5                	mov    %esp,%ebp
  801ce2:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ce5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ce8:	8d 50 04             	lea    0x4(%eax),%edx
  801ceb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	52                   	push   %edx
  801cf5:	50                   	push   %eax
  801cf6:	6a 24                	push   $0x24
  801cf8:	e8 cb fb ff ff       	call   8018c8 <syscall>
  801cfd:	83 c4 18             	add    $0x18,%esp
	return result;
  801d00:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d03:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d06:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d09:	89 01                	mov    %eax,(%ecx)
  801d0b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d11:	c9                   	leave  
  801d12:	c2 04 00             	ret    $0x4

00801d15 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d15:	55                   	push   %ebp
  801d16:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	ff 75 10             	pushl  0x10(%ebp)
  801d1f:	ff 75 0c             	pushl  0xc(%ebp)
  801d22:	ff 75 08             	pushl  0x8(%ebp)
  801d25:	6a 13                	push   $0x13
  801d27:	e8 9c fb ff ff       	call   8018c8 <syscall>
  801d2c:	83 c4 18             	add    $0x18,%esp
	return ;
  801d2f:	90                   	nop
}
  801d30:	c9                   	leave  
  801d31:	c3                   	ret    

00801d32 <sys_rcr2>:
uint32 sys_rcr2()
{
  801d32:	55                   	push   %ebp
  801d33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 25                	push   $0x25
  801d41:	e8 82 fb ff ff       	call   8018c8 <syscall>
  801d46:	83 c4 18             	add    $0x18,%esp
}
  801d49:	c9                   	leave  
  801d4a:	c3                   	ret    

00801d4b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801d4b:	55                   	push   %ebp
  801d4c:	89 e5                	mov    %esp,%ebp
  801d4e:	83 ec 04             	sub    $0x4,%esp
  801d51:	8b 45 08             	mov    0x8(%ebp),%eax
  801d54:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d57:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	50                   	push   %eax
  801d64:	6a 26                	push   $0x26
  801d66:	e8 5d fb ff ff       	call   8018c8 <syscall>
  801d6b:	83 c4 18             	add    $0x18,%esp
	return ;
  801d6e:	90                   	nop
}
  801d6f:	c9                   	leave  
  801d70:	c3                   	ret    

00801d71 <rsttst>:
void rsttst()
{
  801d71:	55                   	push   %ebp
  801d72:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	6a 00                	push   $0x0
  801d7e:	6a 28                	push   $0x28
  801d80:	e8 43 fb ff ff       	call   8018c8 <syscall>
  801d85:	83 c4 18             	add    $0x18,%esp
	return ;
  801d88:	90                   	nop
}
  801d89:	c9                   	leave  
  801d8a:	c3                   	ret    

00801d8b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d8b:	55                   	push   %ebp
  801d8c:	89 e5                	mov    %esp,%ebp
  801d8e:	83 ec 04             	sub    $0x4,%esp
  801d91:	8b 45 14             	mov    0x14(%ebp),%eax
  801d94:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d97:	8b 55 18             	mov    0x18(%ebp),%edx
  801d9a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d9e:	52                   	push   %edx
  801d9f:	50                   	push   %eax
  801da0:	ff 75 10             	pushl  0x10(%ebp)
  801da3:	ff 75 0c             	pushl  0xc(%ebp)
  801da6:	ff 75 08             	pushl  0x8(%ebp)
  801da9:	6a 27                	push   $0x27
  801dab:	e8 18 fb ff ff       	call   8018c8 <syscall>
  801db0:	83 c4 18             	add    $0x18,%esp
	return ;
  801db3:	90                   	nop
}
  801db4:	c9                   	leave  
  801db5:	c3                   	ret    

00801db6 <chktst>:
void chktst(uint32 n)
{
  801db6:	55                   	push   %ebp
  801db7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	ff 75 08             	pushl  0x8(%ebp)
  801dc4:	6a 29                	push   $0x29
  801dc6:	e8 fd fa ff ff       	call   8018c8 <syscall>
  801dcb:	83 c4 18             	add    $0x18,%esp
	return ;
  801dce:	90                   	nop
}
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <inctst>:

void inctst()
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 2a                	push   $0x2a
  801de0:	e8 e3 fa ff ff       	call   8018c8 <syscall>
  801de5:	83 c4 18             	add    $0x18,%esp
	return ;
  801de8:	90                   	nop
}
  801de9:	c9                   	leave  
  801dea:	c3                   	ret    

00801deb <gettst>:
uint32 gettst()
{
  801deb:	55                   	push   %ebp
  801dec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 2b                	push   $0x2b
  801dfa:	e8 c9 fa ff ff       	call   8018c8 <syscall>
  801dff:	83 c4 18             	add    $0x18,%esp
}
  801e02:	c9                   	leave  
  801e03:	c3                   	ret    

00801e04 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801e04:	55                   	push   %ebp
  801e05:	89 e5                	mov    %esp,%ebp
  801e07:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 2c                	push   $0x2c
  801e16:	e8 ad fa ff ff       	call   8018c8 <syscall>
  801e1b:	83 c4 18             	add    $0x18,%esp
  801e1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801e21:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801e25:	75 07                	jne    801e2e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801e27:	b8 01 00 00 00       	mov    $0x1,%eax
  801e2c:	eb 05                	jmp    801e33 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801e2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e33:	c9                   	leave  
  801e34:	c3                   	ret    

00801e35 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801e35:	55                   	push   %ebp
  801e36:	89 e5                	mov    %esp,%ebp
  801e38:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	6a 2c                	push   $0x2c
  801e47:	e8 7c fa ff ff       	call   8018c8 <syscall>
  801e4c:	83 c4 18             	add    $0x18,%esp
  801e4f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801e52:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801e56:	75 07                	jne    801e5f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801e58:	b8 01 00 00 00       	mov    $0x1,%eax
  801e5d:	eb 05                	jmp    801e64 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801e5f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e64:	c9                   	leave  
  801e65:	c3                   	ret    

00801e66 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801e66:	55                   	push   %ebp
  801e67:	89 e5                	mov    %esp,%ebp
  801e69:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 2c                	push   $0x2c
  801e78:	e8 4b fa ff ff       	call   8018c8 <syscall>
  801e7d:	83 c4 18             	add    $0x18,%esp
  801e80:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e83:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e87:	75 07                	jne    801e90 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e89:	b8 01 00 00 00       	mov    $0x1,%eax
  801e8e:	eb 05                	jmp    801e95 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e90:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e95:	c9                   	leave  
  801e96:	c3                   	ret    

00801e97 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e97:	55                   	push   %ebp
  801e98:	89 e5                	mov    %esp,%ebp
  801e9a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 2c                	push   $0x2c
  801ea9:	e8 1a fa ff ff       	call   8018c8 <syscall>
  801eae:	83 c4 18             	add    $0x18,%esp
  801eb1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801eb4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801eb8:	75 07                	jne    801ec1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801eba:	b8 01 00 00 00       	mov    $0x1,%eax
  801ebf:	eb 05                	jmp    801ec6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ec1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ec6:	c9                   	leave  
  801ec7:	c3                   	ret    

00801ec8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ec8:	55                   	push   %ebp
  801ec9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	ff 75 08             	pushl  0x8(%ebp)
  801ed6:	6a 2d                	push   $0x2d
  801ed8:	e8 eb f9 ff ff       	call   8018c8 <syscall>
  801edd:	83 c4 18             	add    $0x18,%esp
	return ;
  801ee0:	90                   	nop
}
  801ee1:	c9                   	leave  
  801ee2:	c3                   	ret    

00801ee3 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801ee3:	55                   	push   %ebp
  801ee4:	89 e5                	mov    %esp,%ebp
  801ee6:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801ee7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801eea:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801eed:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef3:	6a 00                	push   $0x0
  801ef5:	53                   	push   %ebx
  801ef6:	51                   	push   %ecx
  801ef7:	52                   	push   %edx
  801ef8:	50                   	push   %eax
  801ef9:	6a 2e                	push   $0x2e
  801efb:	e8 c8 f9 ff ff       	call   8018c8 <syscall>
  801f00:	83 c4 18             	add    $0x18,%esp
}
  801f03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801f06:	c9                   	leave  
  801f07:	c3                   	ret    

00801f08 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801f08:	55                   	push   %ebp
  801f09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801f0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f11:	6a 00                	push   $0x0
  801f13:	6a 00                	push   $0x0
  801f15:	6a 00                	push   $0x0
  801f17:	52                   	push   %edx
  801f18:	50                   	push   %eax
  801f19:	6a 2f                	push   $0x2f
  801f1b:	e8 a8 f9 ff ff       	call   8018c8 <syscall>
  801f20:	83 c4 18             	add    $0x18,%esp
}
  801f23:	c9                   	leave  
  801f24:	c3                   	ret    
  801f25:	66 90                	xchg   %ax,%ax
  801f27:	90                   	nop

00801f28 <__udivdi3>:
  801f28:	55                   	push   %ebp
  801f29:	57                   	push   %edi
  801f2a:	56                   	push   %esi
  801f2b:	53                   	push   %ebx
  801f2c:	83 ec 1c             	sub    $0x1c,%esp
  801f2f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f33:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f3b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f3f:	89 ca                	mov    %ecx,%edx
  801f41:	89 f8                	mov    %edi,%eax
  801f43:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f47:	85 f6                	test   %esi,%esi
  801f49:	75 2d                	jne    801f78 <__udivdi3+0x50>
  801f4b:	39 cf                	cmp    %ecx,%edi
  801f4d:	77 65                	ja     801fb4 <__udivdi3+0x8c>
  801f4f:	89 fd                	mov    %edi,%ebp
  801f51:	85 ff                	test   %edi,%edi
  801f53:	75 0b                	jne    801f60 <__udivdi3+0x38>
  801f55:	b8 01 00 00 00       	mov    $0x1,%eax
  801f5a:	31 d2                	xor    %edx,%edx
  801f5c:	f7 f7                	div    %edi
  801f5e:	89 c5                	mov    %eax,%ebp
  801f60:	31 d2                	xor    %edx,%edx
  801f62:	89 c8                	mov    %ecx,%eax
  801f64:	f7 f5                	div    %ebp
  801f66:	89 c1                	mov    %eax,%ecx
  801f68:	89 d8                	mov    %ebx,%eax
  801f6a:	f7 f5                	div    %ebp
  801f6c:	89 cf                	mov    %ecx,%edi
  801f6e:	89 fa                	mov    %edi,%edx
  801f70:	83 c4 1c             	add    $0x1c,%esp
  801f73:	5b                   	pop    %ebx
  801f74:	5e                   	pop    %esi
  801f75:	5f                   	pop    %edi
  801f76:	5d                   	pop    %ebp
  801f77:	c3                   	ret    
  801f78:	39 ce                	cmp    %ecx,%esi
  801f7a:	77 28                	ja     801fa4 <__udivdi3+0x7c>
  801f7c:	0f bd fe             	bsr    %esi,%edi
  801f7f:	83 f7 1f             	xor    $0x1f,%edi
  801f82:	75 40                	jne    801fc4 <__udivdi3+0x9c>
  801f84:	39 ce                	cmp    %ecx,%esi
  801f86:	72 0a                	jb     801f92 <__udivdi3+0x6a>
  801f88:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f8c:	0f 87 9e 00 00 00    	ja     802030 <__udivdi3+0x108>
  801f92:	b8 01 00 00 00       	mov    $0x1,%eax
  801f97:	89 fa                	mov    %edi,%edx
  801f99:	83 c4 1c             	add    $0x1c,%esp
  801f9c:	5b                   	pop    %ebx
  801f9d:	5e                   	pop    %esi
  801f9e:	5f                   	pop    %edi
  801f9f:	5d                   	pop    %ebp
  801fa0:	c3                   	ret    
  801fa1:	8d 76 00             	lea    0x0(%esi),%esi
  801fa4:	31 ff                	xor    %edi,%edi
  801fa6:	31 c0                	xor    %eax,%eax
  801fa8:	89 fa                	mov    %edi,%edx
  801faa:	83 c4 1c             	add    $0x1c,%esp
  801fad:	5b                   	pop    %ebx
  801fae:	5e                   	pop    %esi
  801faf:	5f                   	pop    %edi
  801fb0:	5d                   	pop    %ebp
  801fb1:	c3                   	ret    
  801fb2:	66 90                	xchg   %ax,%ax
  801fb4:	89 d8                	mov    %ebx,%eax
  801fb6:	f7 f7                	div    %edi
  801fb8:	31 ff                	xor    %edi,%edi
  801fba:	89 fa                	mov    %edi,%edx
  801fbc:	83 c4 1c             	add    $0x1c,%esp
  801fbf:	5b                   	pop    %ebx
  801fc0:	5e                   	pop    %esi
  801fc1:	5f                   	pop    %edi
  801fc2:	5d                   	pop    %ebp
  801fc3:	c3                   	ret    
  801fc4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801fc9:	89 eb                	mov    %ebp,%ebx
  801fcb:	29 fb                	sub    %edi,%ebx
  801fcd:	89 f9                	mov    %edi,%ecx
  801fcf:	d3 e6                	shl    %cl,%esi
  801fd1:	89 c5                	mov    %eax,%ebp
  801fd3:	88 d9                	mov    %bl,%cl
  801fd5:	d3 ed                	shr    %cl,%ebp
  801fd7:	89 e9                	mov    %ebp,%ecx
  801fd9:	09 f1                	or     %esi,%ecx
  801fdb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801fdf:	89 f9                	mov    %edi,%ecx
  801fe1:	d3 e0                	shl    %cl,%eax
  801fe3:	89 c5                	mov    %eax,%ebp
  801fe5:	89 d6                	mov    %edx,%esi
  801fe7:	88 d9                	mov    %bl,%cl
  801fe9:	d3 ee                	shr    %cl,%esi
  801feb:	89 f9                	mov    %edi,%ecx
  801fed:	d3 e2                	shl    %cl,%edx
  801fef:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ff3:	88 d9                	mov    %bl,%cl
  801ff5:	d3 e8                	shr    %cl,%eax
  801ff7:	09 c2                	or     %eax,%edx
  801ff9:	89 d0                	mov    %edx,%eax
  801ffb:	89 f2                	mov    %esi,%edx
  801ffd:	f7 74 24 0c          	divl   0xc(%esp)
  802001:	89 d6                	mov    %edx,%esi
  802003:	89 c3                	mov    %eax,%ebx
  802005:	f7 e5                	mul    %ebp
  802007:	39 d6                	cmp    %edx,%esi
  802009:	72 19                	jb     802024 <__udivdi3+0xfc>
  80200b:	74 0b                	je     802018 <__udivdi3+0xf0>
  80200d:	89 d8                	mov    %ebx,%eax
  80200f:	31 ff                	xor    %edi,%edi
  802011:	e9 58 ff ff ff       	jmp    801f6e <__udivdi3+0x46>
  802016:	66 90                	xchg   %ax,%ax
  802018:	8b 54 24 08          	mov    0x8(%esp),%edx
  80201c:	89 f9                	mov    %edi,%ecx
  80201e:	d3 e2                	shl    %cl,%edx
  802020:	39 c2                	cmp    %eax,%edx
  802022:	73 e9                	jae    80200d <__udivdi3+0xe5>
  802024:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802027:	31 ff                	xor    %edi,%edi
  802029:	e9 40 ff ff ff       	jmp    801f6e <__udivdi3+0x46>
  80202e:	66 90                	xchg   %ax,%ax
  802030:	31 c0                	xor    %eax,%eax
  802032:	e9 37 ff ff ff       	jmp    801f6e <__udivdi3+0x46>
  802037:	90                   	nop

00802038 <__umoddi3>:
  802038:	55                   	push   %ebp
  802039:	57                   	push   %edi
  80203a:	56                   	push   %esi
  80203b:	53                   	push   %ebx
  80203c:	83 ec 1c             	sub    $0x1c,%esp
  80203f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802043:	8b 74 24 34          	mov    0x34(%esp),%esi
  802047:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80204b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80204f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802053:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802057:	89 f3                	mov    %esi,%ebx
  802059:	89 fa                	mov    %edi,%edx
  80205b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80205f:	89 34 24             	mov    %esi,(%esp)
  802062:	85 c0                	test   %eax,%eax
  802064:	75 1a                	jne    802080 <__umoddi3+0x48>
  802066:	39 f7                	cmp    %esi,%edi
  802068:	0f 86 a2 00 00 00    	jbe    802110 <__umoddi3+0xd8>
  80206e:	89 c8                	mov    %ecx,%eax
  802070:	89 f2                	mov    %esi,%edx
  802072:	f7 f7                	div    %edi
  802074:	89 d0                	mov    %edx,%eax
  802076:	31 d2                	xor    %edx,%edx
  802078:	83 c4 1c             	add    $0x1c,%esp
  80207b:	5b                   	pop    %ebx
  80207c:	5e                   	pop    %esi
  80207d:	5f                   	pop    %edi
  80207e:	5d                   	pop    %ebp
  80207f:	c3                   	ret    
  802080:	39 f0                	cmp    %esi,%eax
  802082:	0f 87 ac 00 00 00    	ja     802134 <__umoddi3+0xfc>
  802088:	0f bd e8             	bsr    %eax,%ebp
  80208b:	83 f5 1f             	xor    $0x1f,%ebp
  80208e:	0f 84 ac 00 00 00    	je     802140 <__umoddi3+0x108>
  802094:	bf 20 00 00 00       	mov    $0x20,%edi
  802099:	29 ef                	sub    %ebp,%edi
  80209b:	89 fe                	mov    %edi,%esi
  80209d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8020a1:	89 e9                	mov    %ebp,%ecx
  8020a3:	d3 e0                	shl    %cl,%eax
  8020a5:	89 d7                	mov    %edx,%edi
  8020a7:	89 f1                	mov    %esi,%ecx
  8020a9:	d3 ef                	shr    %cl,%edi
  8020ab:	09 c7                	or     %eax,%edi
  8020ad:	89 e9                	mov    %ebp,%ecx
  8020af:	d3 e2                	shl    %cl,%edx
  8020b1:	89 14 24             	mov    %edx,(%esp)
  8020b4:	89 d8                	mov    %ebx,%eax
  8020b6:	d3 e0                	shl    %cl,%eax
  8020b8:	89 c2                	mov    %eax,%edx
  8020ba:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020be:	d3 e0                	shl    %cl,%eax
  8020c0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8020c4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020c8:	89 f1                	mov    %esi,%ecx
  8020ca:	d3 e8                	shr    %cl,%eax
  8020cc:	09 d0                	or     %edx,%eax
  8020ce:	d3 eb                	shr    %cl,%ebx
  8020d0:	89 da                	mov    %ebx,%edx
  8020d2:	f7 f7                	div    %edi
  8020d4:	89 d3                	mov    %edx,%ebx
  8020d6:	f7 24 24             	mull   (%esp)
  8020d9:	89 c6                	mov    %eax,%esi
  8020db:	89 d1                	mov    %edx,%ecx
  8020dd:	39 d3                	cmp    %edx,%ebx
  8020df:	0f 82 87 00 00 00    	jb     80216c <__umoddi3+0x134>
  8020e5:	0f 84 91 00 00 00    	je     80217c <__umoddi3+0x144>
  8020eb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8020ef:	29 f2                	sub    %esi,%edx
  8020f1:	19 cb                	sbb    %ecx,%ebx
  8020f3:	89 d8                	mov    %ebx,%eax
  8020f5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8020f9:	d3 e0                	shl    %cl,%eax
  8020fb:	89 e9                	mov    %ebp,%ecx
  8020fd:	d3 ea                	shr    %cl,%edx
  8020ff:	09 d0                	or     %edx,%eax
  802101:	89 e9                	mov    %ebp,%ecx
  802103:	d3 eb                	shr    %cl,%ebx
  802105:	89 da                	mov    %ebx,%edx
  802107:	83 c4 1c             	add    $0x1c,%esp
  80210a:	5b                   	pop    %ebx
  80210b:	5e                   	pop    %esi
  80210c:	5f                   	pop    %edi
  80210d:	5d                   	pop    %ebp
  80210e:	c3                   	ret    
  80210f:	90                   	nop
  802110:	89 fd                	mov    %edi,%ebp
  802112:	85 ff                	test   %edi,%edi
  802114:	75 0b                	jne    802121 <__umoddi3+0xe9>
  802116:	b8 01 00 00 00       	mov    $0x1,%eax
  80211b:	31 d2                	xor    %edx,%edx
  80211d:	f7 f7                	div    %edi
  80211f:	89 c5                	mov    %eax,%ebp
  802121:	89 f0                	mov    %esi,%eax
  802123:	31 d2                	xor    %edx,%edx
  802125:	f7 f5                	div    %ebp
  802127:	89 c8                	mov    %ecx,%eax
  802129:	f7 f5                	div    %ebp
  80212b:	89 d0                	mov    %edx,%eax
  80212d:	e9 44 ff ff ff       	jmp    802076 <__umoddi3+0x3e>
  802132:	66 90                	xchg   %ax,%ax
  802134:	89 c8                	mov    %ecx,%eax
  802136:	89 f2                	mov    %esi,%edx
  802138:	83 c4 1c             	add    $0x1c,%esp
  80213b:	5b                   	pop    %ebx
  80213c:	5e                   	pop    %esi
  80213d:	5f                   	pop    %edi
  80213e:	5d                   	pop    %ebp
  80213f:	c3                   	ret    
  802140:	3b 04 24             	cmp    (%esp),%eax
  802143:	72 06                	jb     80214b <__umoddi3+0x113>
  802145:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802149:	77 0f                	ja     80215a <__umoddi3+0x122>
  80214b:	89 f2                	mov    %esi,%edx
  80214d:	29 f9                	sub    %edi,%ecx
  80214f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802153:	89 14 24             	mov    %edx,(%esp)
  802156:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80215a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80215e:	8b 14 24             	mov    (%esp),%edx
  802161:	83 c4 1c             	add    $0x1c,%esp
  802164:	5b                   	pop    %ebx
  802165:	5e                   	pop    %esi
  802166:	5f                   	pop    %edi
  802167:	5d                   	pop    %ebp
  802168:	c3                   	ret    
  802169:	8d 76 00             	lea    0x0(%esi),%esi
  80216c:	2b 04 24             	sub    (%esp),%eax
  80216f:	19 fa                	sbb    %edi,%edx
  802171:	89 d1                	mov    %edx,%ecx
  802173:	89 c6                	mov    %eax,%esi
  802175:	e9 71 ff ff ff       	jmp    8020eb <__umoddi3+0xb3>
  80217a:	66 90                	xchg   %ax,%ax
  80217c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802180:	72 ea                	jb     80216c <__umoddi3+0x134>
  802182:	89 d9                	mov    %ebx,%ecx
  802184:	e9 62 ff ff ff       	jmp    8020eb <__umoddi3+0xb3>
