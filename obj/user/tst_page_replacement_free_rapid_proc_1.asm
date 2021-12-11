
obj/user/tst_page_replacement_free_rapid_proc_1:     file format elf32-i386


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
  800031:	e8 f5 03 00 00       	call   80042b <libmain>
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
  80003b:	53                   	push   %ebx
  80003c:	83 ec 54             	sub    $0x54,%esp

//	cprintf("envID = %d\n",envID);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003f:	a1 20 30 80 00       	mov    0x803020,%eax
  800044:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80004a:	8b 00                	mov    (%eax),%eax
  80004c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800052:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800057:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005c:	74 14                	je     800072 <_main+0x3a>
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	68 60 1e 80 00       	push   $0x801e60
  800066:	6a 12                	push   $0x12
  800068:	68 a4 1e 80 00       	push   $0x801ea4
  80006d:	e8 fe 04 00 00       	call   800570 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800072:	a1 20 30 80 00       	mov    0x803020,%eax
  800077:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80007d:	83 c0 10             	add    $0x10,%eax
  800080:	8b 00                	mov    (%eax),%eax
  800082:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800085:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800088:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008d:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800092:	74 14                	je     8000a8 <_main+0x70>
  800094:	83 ec 04             	sub    $0x4,%esp
  800097:	68 60 1e 80 00       	push   $0x801e60
  80009c:	6a 13                	push   $0x13
  80009e:	68 a4 1e 80 00       	push   $0x801ea4
  8000a3:	e8 c8 04 00 00       	call   800570 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ad:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b3:	83 c0 20             	add    $0x20,%eax
  8000b6:	8b 00                	mov    (%eax),%eax
  8000b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000be:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c3:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c8:	74 14                	je     8000de <_main+0xa6>
  8000ca:	83 ec 04             	sub    $0x4,%esp
  8000cd:	68 60 1e 80 00       	push   $0x801e60
  8000d2:	6a 14                	push   $0x14
  8000d4:	68 a4 1e 80 00       	push   $0x801ea4
  8000d9:	e8 92 04 00 00       	call   800570 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000de:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000e9:	83 c0 30             	add    $0x30,%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f9:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fe:	74 14                	je     800114 <_main+0xdc>
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	68 60 1e 80 00       	push   $0x801e60
  800108:	6a 15                	push   $0x15
  80010a:	68 a4 1e 80 00       	push   $0x801ea4
  80010f:	e8 5c 04 00 00       	call   800570 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80011f:	83 c0 40             	add    $0x40,%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012f:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800134:	74 14                	je     80014a <_main+0x112>
  800136:	83 ec 04             	sub    $0x4,%esp
  800139:	68 60 1e 80 00       	push   $0x801e60
  80013e:	6a 16                	push   $0x16
  800140:	68 a4 1e 80 00       	push   $0x801ea4
  800145:	e8 26 04 00 00       	call   800570 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014a:	a1 20 30 80 00       	mov    0x803020,%eax
  80014f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800155:	83 c0 50             	add    $0x50,%eax
  800158:	8b 00                	mov    (%eax),%eax
  80015a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800160:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800165:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016a:	74 14                	je     800180 <_main+0x148>
  80016c:	83 ec 04             	sub    $0x4,%esp
  80016f:	68 60 1e 80 00       	push   $0x801e60
  800174:	6a 17                	push   $0x17
  800176:	68 a4 1e 80 00       	push   $0x801ea4
  80017b:	e8 f0 03 00 00       	call   800570 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800180:	a1 20 30 80 00       	mov    0x803020,%eax
  800185:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80018b:	83 c0 60             	add    $0x60,%eax
  80018e:	8b 00                	mov    (%eax),%eax
  800190:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800193:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800196:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019b:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a0:	74 14                	je     8001b6 <_main+0x17e>
  8001a2:	83 ec 04             	sub    $0x4,%esp
  8001a5:	68 60 1e 80 00       	push   $0x801e60
  8001aa:	6a 18                	push   $0x18
  8001ac:	68 a4 1e 80 00       	push   $0x801ea4
  8001b1:	e8 ba 03 00 00       	call   800570 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c1:	83 c0 70             	add    $0x70,%eax
  8001c4:	8b 00                	mov    (%eax),%eax
  8001c6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001c9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d1:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d6:	74 14                	je     8001ec <_main+0x1b4>
  8001d8:	83 ec 04             	sub    $0x4,%esp
  8001db:	68 60 1e 80 00       	push   $0x801e60
  8001e0:	6a 19                	push   $0x19
  8001e2:	68 a4 1e 80 00       	push   $0x801ea4
  8001e7:	e8 84 03 00 00       	call   800570 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f7:	83 e8 80             	sub    $0xffffff80,%eax
  8001fa:	8b 00                	mov    (%eax),%eax
  8001fc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001ff:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800202:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800207:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020c:	74 14                	je     800222 <_main+0x1ea>
  80020e:	83 ec 04             	sub    $0x4,%esp
  800211:	68 60 1e 80 00       	push   $0x801e60
  800216:	6a 1a                	push   $0x1a
  800218:	68 a4 1e 80 00       	push   $0x801ea4
  80021d:	e8 4e 03 00 00       	call   800570 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800222:	a1 20 30 80 00       	mov    0x803020,%eax
  800227:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80022d:	05 90 00 00 00       	add    $0x90,%eax
  800232:	8b 00                	mov    (%eax),%eax
  800234:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800237:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80023a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023f:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800244:	74 14                	je     80025a <_main+0x222>
  800246:	83 ec 04             	sub    $0x4,%esp
  800249:	68 60 1e 80 00       	push   $0x801e60
  80024e:	6a 1b                	push   $0x1b
  800250:	68 a4 1e 80 00       	push   $0x801ea4
  800255:	e8 16 03 00 00       	call   800570 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025a:	a1 20 30 80 00       	mov    0x803020,%eax
  80025f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800265:	05 a0 00 00 00       	add    $0xa0,%eax
  80026a:	8b 00                	mov    (%eax),%eax
  80026c:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80026f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800272:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800277:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027c:	74 14                	je     800292 <_main+0x25a>
  80027e:	83 ec 04             	sub    $0x4,%esp
  800281:	68 60 1e 80 00       	push   $0x801e60
  800286:	6a 1c                	push   $0x1c
  800288:	68 a4 1e 80 00       	push   $0x801ea4
  80028d:	e8 de 02 00 00       	call   800570 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800292:	a1 20 30 80 00       	mov    0x803020,%eax
  800297:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80029d:	85 c0                	test   %eax,%eax
  80029f:	74 14                	je     8002b5 <_main+0x27d>
  8002a1:	83 ec 04             	sub    $0x4,%esp
  8002a4:	68 d4 1e 80 00       	push   $0x801ed4
  8002a9:	6a 1d                	push   $0x1d
  8002ab:	68 a4 1e 80 00       	push   $0x801ea4
  8002b0:	e8 bb 02 00 00       	call   800570 <_panic>
	}

	int freePages = sys_calculate_free_frames();
  8002b5:	e8 4e 14 00 00       	call   801708 <sys_calculate_free_frames>
  8002ba:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002bd:	e8 c9 14 00 00       	call   80178b <sys_pf_calculate_allocated_pages>
  8002c2:	89 45 c0             	mov    %eax,-0x40(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002c5:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002ca:	88 45 bf             	mov    %al,-0x41(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002cd:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002d2:	88 45 be             	mov    %al,-0x42(%ebp)

	//AFTER freeing WS called followed by 2 allocations, then 2 frame taken be arr[PAGE_SIZE*11-1] and arr[PAGE_SIZE*11-1] and 5 frames are become free
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  8002d5:	e8 b1 14 00 00       	call   80178b <sys_pf_calculate_allocated_pages>
  8002da:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  8002dd:	74 14                	je     8002f3 <_main+0x2bb>
  8002df:	83 ec 04             	sub    $0x4,%esp
  8002e2:	68 1c 1f 80 00       	push   $0x801f1c
  8002e7:	6a 29                	push   $0x29
  8002e9:	68 a4 1e 80 00       	push   $0x801ea4
  8002ee:	e8 7d 02 00 00       	call   800570 <_panic>
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8002f3:	e8 10 14 00 00       	call   801708 <sys_calculate_free_frames>
  8002f8:	89 c3                	mov    %eax,%ebx
  8002fa:	e8 22 14 00 00       	call   801721 <sys_calculate_modified_frames>
  8002ff:	01 d8                	add    %ebx,%eax
  800301:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if( (freePages - freePagesAfter) != -5 )
  800304:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800307:	2b 45 b8             	sub    -0x48(%ebp),%eax
  80030a:	83 f8 fb             	cmp    $0xfffffffb,%eax
  80030d:	74 14                	je     800323 <_main+0x2eb>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  80030f:	83 ec 04             	sub    $0x4,%esp
  800312:	68 88 1f 80 00       	push   $0x801f88
  800317:	6a 2c                	push   $0x2c
  800319:	68 a4 1e 80 00       	push   $0x801ea4
  80031e:	e8 4d 02 00 00       	call   800570 <_panic>
	}

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800323:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80032a:	e9 8b 00 00 00       	jmp    8003ba <_main+0x382>
	{
		arr[i] = -1 ;
  80032f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800332:	05 40 30 80 00       	add    $0x803040,%eax
  800337:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  80033a:	a1 04 30 80 00       	mov    0x803004,%eax
  80033f:	8b 15 00 30 80 00    	mov    0x803000,%edx
  800345:	8a 12                	mov    (%edx),%dl
  800347:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  800349:	a1 00 30 80 00       	mov    0x803000,%eax
  80034e:	40                   	inc    %eax
  80034f:	a3 00 30 80 00       	mov    %eax,0x803000
  800354:	a1 04 30 80 00       	mov    0x803004,%eax
  800359:	40                   	inc    %eax
  80035a:	a3 04 30 80 00       	mov    %eax,0x803004
		if(i == 6)
  80035f:	83 7d f4 06          	cmpl   $0x6,-0xc(%ebp)
  800363:	75 4e                	jne    8003b3 <_main+0x37b>
		{
			//cprintf("Checking Allocation in Mem & Page File... \n");
			//After freeing WS for the the second time called, then 1 frame taken be arr[6] and 6 frames are become free
			{
				if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800365:	e8 21 14 00 00       	call   80178b <sys_pf_calculate_allocated_pages>
  80036a:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  80036d:	74 14                	je     800383 <_main+0x34b>
  80036f:	83 ec 04             	sub    $0x4,%esp
  800372:	68 1c 1f 80 00       	push   $0x801f1c
  800377:	6a 3f                	push   $0x3f
  800379:	68 a4 1e 80 00       	push   $0x801ea4
  80037e:	e8 ed 01 00 00       	call   800570 <_panic>
				uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800383:	e8 80 13 00 00       	call   801708 <sys_calculate_free_frames>
  800388:	89 c3                	mov    %eax,%ebx
  80038a:	e8 92 13 00 00       	call   801721 <sys_calculate_modified_frames>
  80038f:	01 d8                	add    %ebx,%eax
  800391:	89 45 b4             	mov    %eax,-0x4c(%ebp)
				if( (freePages - freePagesAfter) != -6 )
  800394:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800397:	2b 45 b4             	sub    -0x4c(%ebp),%eax
  80039a:	83 f8 fa             	cmp    $0xfffffffa,%eax
  80039d:	74 14                	je     8003b3 <_main+0x37b>
					panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  80039f:	83 ec 04             	sub    $0x4,%esp
  8003a2:	68 88 1f 80 00       	push   $0x801f88
  8003a7:	6a 42                	push   $0x42
  8003a9:	68 a4 1e 80 00       	push   $0x801ea4
  8003ae:	e8 bd 01 00 00       	call   800570 <_panic>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
	}

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8003b3:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8003ba:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8003c1:	0f 8e 68 ff ff ff    	jle    80032f <_main+0x2f7>

	//===================

	//cprintf("Checking Allocation in Mem & Page File... \n");
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  8003c7:	e8 bf 13 00 00       	call   80178b <sys_pf_calculate_allocated_pages>
  8003cc:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  8003cf:	74 14                	je     8003e5 <_main+0x3ad>
  8003d1:	83 ec 04             	sub    $0x4,%esp
  8003d4:	68 1c 1f 80 00       	push   $0x801f1c
  8003d9:	6a 4b                	push   $0x4b
  8003db:	68 a4 1e 80 00       	push   $0x801ea4
  8003e0:	e8 8b 01 00 00       	call   800570 <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8003e5:	e8 1e 13 00 00       	call   801708 <sys_calculate_free_frames>
  8003ea:	89 c3                	mov    %eax,%ebx
  8003ec:	e8 30 13 00 00       	call   801721 <sys_calculate_modified_frames>
  8003f1:	01 d8                	add    %ebx,%eax
  8003f3:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if( (freePages - freePagesAfter) != -2 )
  8003f6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8003f9:	2b 45 b0             	sub    -0x50(%ebp),%eax
  8003fc:	83 f8 fe             	cmp    $0xfffffffe,%eax
  8003ff:	74 14                	je     800415 <_main+0x3dd>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  800401:	83 ec 04             	sub    $0x4,%esp
  800404:	68 88 1f 80 00       	push   $0x801f88
  800409:	6a 4f                	push   $0x4f
  80040b:	68 a4 1e 80 00       	push   $0x801ea4
  800410:	e8 5b 01 00 00       	call   800570 <_panic>
	}

	cprintf("Congratulations!! test PAGE replacement [FREEING RAPID PROCESS 1] is completed successfully.\n");
  800415:	83 ec 0c             	sub    $0xc,%esp
  800418:	68 04 20 80 00       	push   $0x802004
  80041d:	e8 f0 03 00 00       	call   800812 <cprintf>
  800422:	83 c4 10             	add    $0x10,%esp
	return;
  800425:	90                   	nop
}
  800426:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800429:	c9                   	leave  
  80042a:	c3                   	ret    

0080042b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80042b:	55                   	push   %ebp
  80042c:	89 e5                	mov    %esp,%ebp
  80042e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800431:	e8 07 12 00 00       	call   80163d <sys_getenvindex>
  800436:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800439:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80043c:	89 d0                	mov    %edx,%eax
  80043e:	c1 e0 03             	shl    $0x3,%eax
  800441:	01 d0                	add    %edx,%eax
  800443:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80044a:	01 c8                	add    %ecx,%eax
  80044c:	01 c0                	add    %eax,%eax
  80044e:	01 d0                	add    %edx,%eax
  800450:	01 c0                	add    %eax,%eax
  800452:	01 d0                	add    %edx,%eax
  800454:	89 c2                	mov    %eax,%edx
  800456:	c1 e2 05             	shl    $0x5,%edx
  800459:	29 c2                	sub    %eax,%edx
  80045b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800462:	89 c2                	mov    %eax,%edx
  800464:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80046a:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80046f:	a1 20 30 80 00       	mov    0x803020,%eax
  800474:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80047a:	84 c0                	test   %al,%al
  80047c:	74 0f                	je     80048d <libmain+0x62>
		binaryname = myEnv->prog_name;
  80047e:	a1 20 30 80 00       	mov    0x803020,%eax
  800483:	05 40 3c 01 00       	add    $0x13c40,%eax
  800488:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80048d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800491:	7e 0a                	jle    80049d <libmain+0x72>
		binaryname = argv[0];
  800493:	8b 45 0c             	mov    0xc(%ebp),%eax
  800496:	8b 00                	mov    (%eax),%eax
  800498:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  80049d:	83 ec 08             	sub    $0x8,%esp
  8004a0:	ff 75 0c             	pushl  0xc(%ebp)
  8004a3:	ff 75 08             	pushl  0x8(%ebp)
  8004a6:	e8 8d fb ff ff       	call   800038 <_main>
  8004ab:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8004ae:	e8 25 13 00 00       	call   8017d8 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8004b3:	83 ec 0c             	sub    $0xc,%esp
  8004b6:	68 7c 20 80 00       	push   $0x80207c
  8004bb:	e8 52 03 00 00       	call   800812 <cprintf>
  8004c0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8004c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c8:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8004ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d3:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8004d9:	83 ec 04             	sub    $0x4,%esp
  8004dc:	52                   	push   %edx
  8004dd:	50                   	push   %eax
  8004de:	68 a4 20 80 00       	push   $0x8020a4
  8004e3:	e8 2a 03 00 00       	call   800812 <cprintf>
  8004e8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8004eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f0:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8004f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004fb:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800501:	83 ec 04             	sub    $0x4,%esp
  800504:	52                   	push   %edx
  800505:	50                   	push   %eax
  800506:	68 cc 20 80 00       	push   $0x8020cc
  80050b:	e8 02 03 00 00       	call   800812 <cprintf>
  800510:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800513:	a1 20 30 80 00       	mov    0x803020,%eax
  800518:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80051e:	83 ec 08             	sub    $0x8,%esp
  800521:	50                   	push   %eax
  800522:	68 0d 21 80 00       	push   $0x80210d
  800527:	e8 e6 02 00 00       	call   800812 <cprintf>
  80052c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80052f:	83 ec 0c             	sub    $0xc,%esp
  800532:	68 7c 20 80 00       	push   $0x80207c
  800537:	e8 d6 02 00 00       	call   800812 <cprintf>
  80053c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80053f:	e8 ae 12 00 00       	call   8017f2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800544:	e8 19 00 00 00       	call   800562 <exit>
}
  800549:	90                   	nop
  80054a:	c9                   	leave  
  80054b:	c3                   	ret    

0080054c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80054c:	55                   	push   %ebp
  80054d:	89 e5                	mov    %esp,%ebp
  80054f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800552:	83 ec 0c             	sub    $0xc,%esp
  800555:	6a 00                	push   $0x0
  800557:	e8 ad 10 00 00       	call   801609 <sys_env_destroy>
  80055c:	83 c4 10             	add    $0x10,%esp
}
  80055f:	90                   	nop
  800560:	c9                   	leave  
  800561:	c3                   	ret    

00800562 <exit>:

void
exit(void)
{
  800562:	55                   	push   %ebp
  800563:	89 e5                	mov    %esp,%ebp
  800565:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800568:	e8 02 11 00 00       	call   80166f <sys_env_exit>
}
  80056d:	90                   	nop
  80056e:	c9                   	leave  
  80056f:	c3                   	ret    

00800570 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800570:	55                   	push   %ebp
  800571:	89 e5                	mov    %esp,%ebp
  800573:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800576:	8d 45 10             	lea    0x10(%ebp),%eax
  800579:	83 c0 04             	add    $0x4,%eax
  80057c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80057f:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800584:	85 c0                	test   %eax,%eax
  800586:	74 16                	je     80059e <_panic+0x2e>
		cprintf("%s: ", argv0);
  800588:	a1 18 f1 80 00       	mov    0x80f118,%eax
  80058d:	83 ec 08             	sub    $0x8,%esp
  800590:	50                   	push   %eax
  800591:	68 24 21 80 00       	push   $0x802124
  800596:	e8 77 02 00 00       	call   800812 <cprintf>
  80059b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80059e:	a1 08 30 80 00       	mov    0x803008,%eax
  8005a3:	ff 75 0c             	pushl  0xc(%ebp)
  8005a6:	ff 75 08             	pushl  0x8(%ebp)
  8005a9:	50                   	push   %eax
  8005aa:	68 29 21 80 00       	push   $0x802129
  8005af:	e8 5e 02 00 00       	call   800812 <cprintf>
  8005b4:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8005b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8005ba:	83 ec 08             	sub    $0x8,%esp
  8005bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c0:	50                   	push   %eax
  8005c1:	e8 e1 01 00 00       	call   8007a7 <vcprintf>
  8005c6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8005c9:	83 ec 08             	sub    $0x8,%esp
  8005cc:	6a 00                	push   $0x0
  8005ce:	68 45 21 80 00       	push   $0x802145
  8005d3:	e8 cf 01 00 00       	call   8007a7 <vcprintf>
  8005d8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8005db:	e8 82 ff ff ff       	call   800562 <exit>

	// should not return here
	while (1) ;
  8005e0:	eb fe                	jmp    8005e0 <_panic+0x70>

008005e2 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8005e2:	55                   	push   %ebp
  8005e3:	89 e5                	mov    %esp,%ebp
  8005e5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8005e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ed:	8b 50 74             	mov    0x74(%eax),%edx
  8005f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005f3:	39 c2                	cmp    %eax,%edx
  8005f5:	74 14                	je     80060b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8005f7:	83 ec 04             	sub    $0x4,%esp
  8005fa:	68 48 21 80 00       	push   $0x802148
  8005ff:	6a 26                	push   $0x26
  800601:	68 94 21 80 00       	push   $0x802194
  800606:	e8 65 ff ff ff       	call   800570 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80060b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800612:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800619:	e9 b6 00 00 00       	jmp    8006d4 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80061e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800621:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800628:	8b 45 08             	mov    0x8(%ebp),%eax
  80062b:	01 d0                	add    %edx,%eax
  80062d:	8b 00                	mov    (%eax),%eax
  80062f:	85 c0                	test   %eax,%eax
  800631:	75 08                	jne    80063b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800633:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800636:	e9 96 00 00 00       	jmp    8006d1 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80063b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800642:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800649:	eb 5d                	jmp    8006a8 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80064b:	a1 20 30 80 00       	mov    0x803020,%eax
  800650:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800656:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800659:	c1 e2 04             	shl    $0x4,%edx
  80065c:	01 d0                	add    %edx,%eax
  80065e:	8a 40 04             	mov    0x4(%eax),%al
  800661:	84 c0                	test   %al,%al
  800663:	75 40                	jne    8006a5 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800665:	a1 20 30 80 00       	mov    0x803020,%eax
  80066a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800670:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800673:	c1 e2 04             	shl    $0x4,%edx
  800676:	01 d0                	add    %edx,%eax
  800678:	8b 00                	mov    (%eax),%eax
  80067a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80067d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800680:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800685:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800687:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80068a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800691:	8b 45 08             	mov    0x8(%ebp),%eax
  800694:	01 c8                	add    %ecx,%eax
  800696:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800698:	39 c2                	cmp    %eax,%edx
  80069a:	75 09                	jne    8006a5 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80069c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8006a3:	eb 12                	jmp    8006b7 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006a5:	ff 45 e8             	incl   -0x18(%ebp)
  8006a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ad:	8b 50 74             	mov    0x74(%eax),%edx
  8006b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006b3:	39 c2                	cmp    %eax,%edx
  8006b5:	77 94                	ja     80064b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8006b7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8006bb:	75 14                	jne    8006d1 <CheckWSWithoutLastIndex+0xef>
			panic(
  8006bd:	83 ec 04             	sub    $0x4,%esp
  8006c0:	68 a0 21 80 00       	push   $0x8021a0
  8006c5:	6a 3a                	push   $0x3a
  8006c7:	68 94 21 80 00       	push   $0x802194
  8006cc:	e8 9f fe ff ff       	call   800570 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8006d1:	ff 45 f0             	incl   -0x10(%ebp)
  8006d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006da:	0f 8c 3e ff ff ff    	jl     80061e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8006e0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006e7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8006ee:	eb 20                	jmp    800710 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8006f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8006f5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8006fb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006fe:	c1 e2 04             	shl    $0x4,%edx
  800701:	01 d0                	add    %edx,%eax
  800703:	8a 40 04             	mov    0x4(%eax),%al
  800706:	3c 01                	cmp    $0x1,%al
  800708:	75 03                	jne    80070d <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80070a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80070d:	ff 45 e0             	incl   -0x20(%ebp)
  800710:	a1 20 30 80 00       	mov    0x803020,%eax
  800715:	8b 50 74             	mov    0x74(%eax),%edx
  800718:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80071b:	39 c2                	cmp    %eax,%edx
  80071d:	77 d1                	ja     8006f0 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80071f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800722:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800725:	74 14                	je     80073b <CheckWSWithoutLastIndex+0x159>
		panic(
  800727:	83 ec 04             	sub    $0x4,%esp
  80072a:	68 f4 21 80 00       	push   $0x8021f4
  80072f:	6a 44                	push   $0x44
  800731:	68 94 21 80 00       	push   $0x802194
  800736:	e8 35 fe ff ff       	call   800570 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80073b:	90                   	nop
  80073c:	c9                   	leave  
  80073d:	c3                   	ret    

0080073e <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80073e:	55                   	push   %ebp
  80073f:	89 e5                	mov    %esp,%ebp
  800741:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800744:	8b 45 0c             	mov    0xc(%ebp),%eax
  800747:	8b 00                	mov    (%eax),%eax
  800749:	8d 48 01             	lea    0x1(%eax),%ecx
  80074c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80074f:	89 0a                	mov    %ecx,(%edx)
  800751:	8b 55 08             	mov    0x8(%ebp),%edx
  800754:	88 d1                	mov    %dl,%cl
  800756:	8b 55 0c             	mov    0xc(%ebp),%edx
  800759:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80075d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800760:	8b 00                	mov    (%eax),%eax
  800762:	3d ff 00 00 00       	cmp    $0xff,%eax
  800767:	75 2c                	jne    800795 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800769:	a0 24 30 80 00       	mov    0x803024,%al
  80076e:	0f b6 c0             	movzbl %al,%eax
  800771:	8b 55 0c             	mov    0xc(%ebp),%edx
  800774:	8b 12                	mov    (%edx),%edx
  800776:	89 d1                	mov    %edx,%ecx
  800778:	8b 55 0c             	mov    0xc(%ebp),%edx
  80077b:	83 c2 08             	add    $0x8,%edx
  80077e:	83 ec 04             	sub    $0x4,%esp
  800781:	50                   	push   %eax
  800782:	51                   	push   %ecx
  800783:	52                   	push   %edx
  800784:	e8 3e 0e 00 00       	call   8015c7 <sys_cputs>
  800789:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80078c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80078f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800795:	8b 45 0c             	mov    0xc(%ebp),%eax
  800798:	8b 40 04             	mov    0x4(%eax),%eax
  80079b:	8d 50 01             	lea    0x1(%eax),%edx
  80079e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a1:	89 50 04             	mov    %edx,0x4(%eax)
}
  8007a4:	90                   	nop
  8007a5:	c9                   	leave  
  8007a6:	c3                   	ret    

008007a7 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8007a7:	55                   	push   %ebp
  8007a8:	89 e5                	mov    %esp,%ebp
  8007aa:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8007b0:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8007b7:	00 00 00 
	b.cnt = 0;
  8007ba:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8007c1:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8007c4:	ff 75 0c             	pushl  0xc(%ebp)
  8007c7:	ff 75 08             	pushl  0x8(%ebp)
  8007ca:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007d0:	50                   	push   %eax
  8007d1:	68 3e 07 80 00       	push   $0x80073e
  8007d6:	e8 11 02 00 00       	call   8009ec <vprintfmt>
  8007db:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8007de:	a0 24 30 80 00       	mov    0x803024,%al
  8007e3:	0f b6 c0             	movzbl %al,%eax
  8007e6:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8007ec:	83 ec 04             	sub    $0x4,%esp
  8007ef:	50                   	push   %eax
  8007f0:	52                   	push   %edx
  8007f1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007f7:	83 c0 08             	add    $0x8,%eax
  8007fa:	50                   	push   %eax
  8007fb:	e8 c7 0d 00 00       	call   8015c7 <sys_cputs>
  800800:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800803:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80080a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800810:	c9                   	leave  
  800811:	c3                   	ret    

00800812 <cprintf>:

int cprintf(const char *fmt, ...) {
  800812:	55                   	push   %ebp
  800813:	89 e5                	mov    %esp,%ebp
  800815:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800818:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80081f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800822:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	83 ec 08             	sub    $0x8,%esp
  80082b:	ff 75 f4             	pushl  -0xc(%ebp)
  80082e:	50                   	push   %eax
  80082f:	e8 73 ff ff ff       	call   8007a7 <vcprintf>
  800834:	83 c4 10             	add    $0x10,%esp
  800837:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80083a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80083d:	c9                   	leave  
  80083e:	c3                   	ret    

0080083f <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80083f:	55                   	push   %ebp
  800840:	89 e5                	mov    %esp,%ebp
  800842:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800845:	e8 8e 0f 00 00       	call   8017d8 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80084a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80084d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800850:	8b 45 08             	mov    0x8(%ebp),%eax
  800853:	83 ec 08             	sub    $0x8,%esp
  800856:	ff 75 f4             	pushl  -0xc(%ebp)
  800859:	50                   	push   %eax
  80085a:	e8 48 ff ff ff       	call   8007a7 <vcprintf>
  80085f:	83 c4 10             	add    $0x10,%esp
  800862:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800865:	e8 88 0f 00 00       	call   8017f2 <sys_enable_interrupt>
	return cnt;
  80086a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80086d:	c9                   	leave  
  80086e:	c3                   	ret    

0080086f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80086f:	55                   	push   %ebp
  800870:	89 e5                	mov    %esp,%ebp
  800872:	53                   	push   %ebx
  800873:	83 ec 14             	sub    $0x14,%esp
  800876:	8b 45 10             	mov    0x10(%ebp),%eax
  800879:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80087c:	8b 45 14             	mov    0x14(%ebp),%eax
  80087f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800882:	8b 45 18             	mov    0x18(%ebp),%eax
  800885:	ba 00 00 00 00       	mov    $0x0,%edx
  80088a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80088d:	77 55                	ja     8008e4 <printnum+0x75>
  80088f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800892:	72 05                	jb     800899 <printnum+0x2a>
  800894:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800897:	77 4b                	ja     8008e4 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800899:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80089c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80089f:	8b 45 18             	mov    0x18(%ebp),%eax
  8008a2:	ba 00 00 00 00       	mov    $0x0,%edx
  8008a7:	52                   	push   %edx
  8008a8:	50                   	push   %eax
  8008a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ac:	ff 75 f0             	pushl  -0x10(%ebp)
  8008af:	e8 48 13 00 00       	call   801bfc <__udivdi3>
  8008b4:	83 c4 10             	add    $0x10,%esp
  8008b7:	83 ec 04             	sub    $0x4,%esp
  8008ba:	ff 75 20             	pushl  0x20(%ebp)
  8008bd:	53                   	push   %ebx
  8008be:	ff 75 18             	pushl  0x18(%ebp)
  8008c1:	52                   	push   %edx
  8008c2:	50                   	push   %eax
  8008c3:	ff 75 0c             	pushl  0xc(%ebp)
  8008c6:	ff 75 08             	pushl  0x8(%ebp)
  8008c9:	e8 a1 ff ff ff       	call   80086f <printnum>
  8008ce:	83 c4 20             	add    $0x20,%esp
  8008d1:	eb 1a                	jmp    8008ed <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008d3:	83 ec 08             	sub    $0x8,%esp
  8008d6:	ff 75 0c             	pushl  0xc(%ebp)
  8008d9:	ff 75 20             	pushl  0x20(%ebp)
  8008dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008df:	ff d0                	call   *%eax
  8008e1:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008e4:	ff 4d 1c             	decl   0x1c(%ebp)
  8008e7:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008eb:	7f e6                	jg     8008d3 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008ed:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008f0:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008fb:	53                   	push   %ebx
  8008fc:	51                   	push   %ecx
  8008fd:	52                   	push   %edx
  8008fe:	50                   	push   %eax
  8008ff:	e8 08 14 00 00       	call   801d0c <__umoddi3>
  800904:	83 c4 10             	add    $0x10,%esp
  800907:	05 54 24 80 00       	add    $0x802454,%eax
  80090c:	8a 00                	mov    (%eax),%al
  80090e:	0f be c0             	movsbl %al,%eax
  800911:	83 ec 08             	sub    $0x8,%esp
  800914:	ff 75 0c             	pushl  0xc(%ebp)
  800917:	50                   	push   %eax
  800918:	8b 45 08             	mov    0x8(%ebp),%eax
  80091b:	ff d0                	call   *%eax
  80091d:	83 c4 10             	add    $0x10,%esp
}
  800920:	90                   	nop
  800921:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800924:	c9                   	leave  
  800925:	c3                   	ret    

00800926 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800926:	55                   	push   %ebp
  800927:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800929:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80092d:	7e 1c                	jle    80094b <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80092f:	8b 45 08             	mov    0x8(%ebp),%eax
  800932:	8b 00                	mov    (%eax),%eax
  800934:	8d 50 08             	lea    0x8(%eax),%edx
  800937:	8b 45 08             	mov    0x8(%ebp),%eax
  80093a:	89 10                	mov    %edx,(%eax)
  80093c:	8b 45 08             	mov    0x8(%ebp),%eax
  80093f:	8b 00                	mov    (%eax),%eax
  800941:	83 e8 08             	sub    $0x8,%eax
  800944:	8b 50 04             	mov    0x4(%eax),%edx
  800947:	8b 00                	mov    (%eax),%eax
  800949:	eb 40                	jmp    80098b <getuint+0x65>
	else if (lflag)
  80094b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80094f:	74 1e                	je     80096f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800951:	8b 45 08             	mov    0x8(%ebp),%eax
  800954:	8b 00                	mov    (%eax),%eax
  800956:	8d 50 04             	lea    0x4(%eax),%edx
  800959:	8b 45 08             	mov    0x8(%ebp),%eax
  80095c:	89 10                	mov    %edx,(%eax)
  80095e:	8b 45 08             	mov    0x8(%ebp),%eax
  800961:	8b 00                	mov    (%eax),%eax
  800963:	83 e8 04             	sub    $0x4,%eax
  800966:	8b 00                	mov    (%eax),%eax
  800968:	ba 00 00 00 00       	mov    $0x0,%edx
  80096d:	eb 1c                	jmp    80098b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80096f:	8b 45 08             	mov    0x8(%ebp),%eax
  800972:	8b 00                	mov    (%eax),%eax
  800974:	8d 50 04             	lea    0x4(%eax),%edx
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	89 10                	mov    %edx,(%eax)
  80097c:	8b 45 08             	mov    0x8(%ebp),%eax
  80097f:	8b 00                	mov    (%eax),%eax
  800981:	83 e8 04             	sub    $0x4,%eax
  800984:	8b 00                	mov    (%eax),%eax
  800986:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80098b:	5d                   	pop    %ebp
  80098c:	c3                   	ret    

0080098d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80098d:	55                   	push   %ebp
  80098e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800990:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800994:	7e 1c                	jle    8009b2 <getint+0x25>
		return va_arg(*ap, long long);
  800996:	8b 45 08             	mov    0x8(%ebp),%eax
  800999:	8b 00                	mov    (%eax),%eax
  80099b:	8d 50 08             	lea    0x8(%eax),%edx
  80099e:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a1:	89 10                	mov    %edx,(%eax)
  8009a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a6:	8b 00                	mov    (%eax),%eax
  8009a8:	83 e8 08             	sub    $0x8,%eax
  8009ab:	8b 50 04             	mov    0x4(%eax),%edx
  8009ae:	8b 00                	mov    (%eax),%eax
  8009b0:	eb 38                	jmp    8009ea <getint+0x5d>
	else if (lflag)
  8009b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009b6:	74 1a                	je     8009d2 <getint+0x45>
		return va_arg(*ap, long);
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
  8009d0:	eb 18                	jmp    8009ea <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d5:	8b 00                	mov    (%eax),%eax
  8009d7:	8d 50 04             	lea    0x4(%eax),%edx
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	89 10                	mov    %edx,(%eax)
  8009df:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e2:	8b 00                	mov    (%eax),%eax
  8009e4:	83 e8 04             	sub    $0x4,%eax
  8009e7:	8b 00                	mov    (%eax),%eax
  8009e9:	99                   	cltd   
}
  8009ea:	5d                   	pop    %ebp
  8009eb:	c3                   	ret    

008009ec <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009ec:	55                   	push   %ebp
  8009ed:	89 e5                	mov    %esp,%ebp
  8009ef:	56                   	push   %esi
  8009f0:	53                   	push   %ebx
  8009f1:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009f4:	eb 17                	jmp    800a0d <vprintfmt+0x21>
			if (ch == '\0')
  8009f6:	85 db                	test   %ebx,%ebx
  8009f8:	0f 84 af 03 00 00    	je     800dad <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8009fe:	83 ec 08             	sub    $0x8,%esp
  800a01:	ff 75 0c             	pushl  0xc(%ebp)
  800a04:	53                   	push   %ebx
  800a05:	8b 45 08             	mov    0x8(%ebp),%eax
  800a08:	ff d0                	call   *%eax
  800a0a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800a10:	8d 50 01             	lea    0x1(%eax),%edx
  800a13:	89 55 10             	mov    %edx,0x10(%ebp)
  800a16:	8a 00                	mov    (%eax),%al
  800a18:	0f b6 d8             	movzbl %al,%ebx
  800a1b:	83 fb 25             	cmp    $0x25,%ebx
  800a1e:	75 d6                	jne    8009f6 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a20:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a24:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a2b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a32:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a39:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a40:	8b 45 10             	mov    0x10(%ebp),%eax
  800a43:	8d 50 01             	lea    0x1(%eax),%edx
  800a46:	89 55 10             	mov    %edx,0x10(%ebp)
  800a49:	8a 00                	mov    (%eax),%al
  800a4b:	0f b6 d8             	movzbl %al,%ebx
  800a4e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a51:	83 f8 55             	cmp    $0x55,%eax
  800a54:	0f 87 2b 03 00 00    	ja     800d85 <vprintfmt+0x399>
  800a5a:	8b 04 85 78 24 80 00 	mov    0x802478(,%eax,4),%eax
  800a61:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a63:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a67:	eb d7                	jmp    800a40 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a69:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a6d:	eb d1                	jmp    800a40 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a6f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a76:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a79:	89 d0                	mov    %edx,%eax
  800a7b:	c1 e0 02             	shl    $0x2,%eax
  800a7e:	01 d0                	add    %edx,%eax
  800a80:	01 c0                	add    %eax,%eax
  800a82:	01 d8                	add    %ebx,%eax
  800a84:	83 e8 30             	sub    $0x30,%eax
  800a87:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a8a:	8b 45 10             	mov    0x10(%ebp),%eax
  800a8d:	8a 00                	mov    (%eax),%al
  800a8f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a92:	83 fb 2f             	cmp    $0x2f,%ebx
  800a95:	7e 3e                	jle    800ad5 <vprintfmt+0xe9>
  800a97:	83 fb 39             	cmp    $0x39,%ebx
  800a9a:	7f 39                	jg     800ad5 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a9c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a9f:	eb d5                	jmp    800a76 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800aa1:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa4:	83 c0 04             	add    $0x4,%eax
  800aa7:	89 45 14             	mov    %eax,0x14(%ebp)
  800aaa:	8b 45 14             	mov    0x14(%ebp),%eax
  800aad:	83 e8 04             	sub    $0x4,%eax
  800ab0:	8b 00                	mov    (%eax),%eax
  800ab2:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ab5:	eb 1f                	jmp    800ad6 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ab7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800abb:	79 83                	jns    800a40 <vprintfmt+0x54>
				width = 0;
  800abd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ac4:	e9 77 ff ff ff       	jmp    800a40 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ac9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ad0:	e9 6b ff ff ff       	jmp    800a40 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ad5:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ad6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ada:	0f 89 60 ff ff ff    	jns    800a40 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ae0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ae3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ae6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800aed:	e9 4e ff ff ff       	jmp    800a40 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800af2:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800af5:	e9 46 ff ff ff       	jmp    800a40 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800afa:	8b 45 14             	mov    0x14(%ebp),%eax
  800afd:	83 c0 04             	add    $0x4,%eax
  800b00:	89 45 14             	mov    %eax,0x14(%ebp)
  800b03:	8b 45 14             	mov    0x14(%ebp),%eax
  800b06:	83 e8 04             	sub    $0x4,%eax
  800b09:	8b 00                	mov    (%eax),%eax
  800b0b:	83 ec 08             	sub    $0x8,%esp
  800b0e:	ff 75 0c             	pushl  0xc(%ebp)
  800b11:	50                   	push   %eax
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	ff d0                	call   *%eax
  800b17:	83 c4 10             	add    $0x10,%esp
			break;
  800b1a:	e9 89 02 00 00       	jmp    800da8 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800b22:	83 c0 04             	add    $0x4,%eax
  800b25:	89 45 14             	mov    %eax,0x14(%ebp)
  800b28:	8b 45 14             	mov    0x14(%ebp),%eax
  800b2b:	83 e8 04             	sub    $0x4,%eax
  800b2e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b30:	85 db                	test   %ebx,%ebx
  800b32:	79 02                	jns    800b36 <vprintfmt+0x14a>
				err = -err;
  800b34:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b36:	83 fb 64             	cmp    $0x64,%ebx
  800b39:	7f 0b                	jg     800b46 <vprintfmt+0x15a>
  800b3b:	8b 34 9d c0 22 80 00 	mov    0x8022c0(,%ebx,4),%esi
  800b42:	85 f6                	test   %esi,%esi
  800b44:	75 19                	jne    800b5f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b46:	53                   	push   %ebx
  800b47:	68 65 24 80 00       	push   $0x802465
  800b4c:	ff 75 0c             	pushl  0xc(%ebp)
  800b4f:	ff 75 08             	pushl  0x8(%ebp)
  800b52:	e8 5e 02 00 00       	call   800db5 <printfmt>
  800b57:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b5a:	e9 49 02 00 00       	jmp    800da8 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b5f:	56                   	push   %esi
  800b60:	68 6e 24 80 00       	push   $0x80246e
  800b65:	ff 75 0c             	pushl  0xc(%ebp)
  800b68:	ff 75 08             	pushl  0x8(%ebp)
  800b6b:	e8 45 02 00 00       	call   800db5 <printfmt>
  800b70:	83 c4 10             	add    $0x10,%esp
			break;
  800b73:	e9 30 02 00 00       	jmp    800da8 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b78:	8b 45 14             	mov    0x14(%ebp),%eax
  800b7b:	83 c0 04             	add    $0x4,%eax
  800b7e:	89 45 14             	mov    %eax,0x14(%ebp)
  800b81:	8b 45 14             	mov    0x14(%ebp),%eax
  800b84:	83 e8 04             	sub    $0x4,%eax
  800b87:	8b 30                	mov    (%eax),%esi
  800b89:	85 f6                	test   %esi,%esi
  800b8b:	75 05                	jne    800b92 <vprintfmt+0x1a6>
				p = "(null)";
  800b8d:	be 71 24 80 00       	mov    $0x802471,%esi
			if (width > 0 && padc != '-')
  800b92:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b96:	7e 6d                	jle    800c05 <vprintfmt+0x219>
  800b98:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b9c:	74 67                	je     800c05 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b9e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ba1:	83 ec 08             	sub    $0x8,%esp
  800ba4:	50                   	push   %eax
  800ba5:	56                   	push   %esi
  800ba6:	e8 0c 03 00 00       	call   800eb7 <strnlen>
  800bab:	83 c4 10             	add    $0x10,%esp
  800bae:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800bb1:	eb 16                	jmp    800bc9 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bb3:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bb7:	83 ec 08             	sub    $0x8,%esp
  800bba:	ff 75 0c             	pushl  0xc(%ebp)
  800bbd:	50                   	push   %eax
  800bbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc1:	ff d0                	call   *%eax
  800bc3:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800bc6:	ff 4d e4             	decl   -0x1c(%ebp)
  800bc9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bcd:	7f e4                	jg     800bb3 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bcf:	eb 34                	jmp    800c05 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bd1:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bd5:	74 1c                	je     800bf3 <vprintfmt+0x207>
  800bd7:	83 fb 1f             	cmp    $0x1f,%ebx
  800bda:	7e 05                	jle    800be1 <vprintfmt+0x1f5>
  800bdc:	83 fb 7e             	cmp    $0x7e,%ebx
  800bdf:	7e 12                	jle    800bf3 <vprintfmt+0x207>
					putch('?', putdat);
  800be1:	83 ec 08             	sub    $0x8,%esp
  800be4:	ff 75 0c             	pushl  0xc(%ebp)
  800be7:	6a 3f                	push   $0x3f
  800be9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bec:	ff d0                	call   *%eax
  800bee:	83 c4 10             	add    $0x10,%esp
  800bf1:	eb 0f                	jmp    800c02 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800bf3:	83 ec 08             	sub    $0x8,%esp
  800bf6:	ff 75 0c             	pushl  0xc(%ebp)
  800bf9:	53                   	push   %ebx
  800bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfd:	ff d0                	call   *%eax
  800bff:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c02:	ff 4d e4             	decl   -0x1c(%ebp)
  800c05:	89 f0                	mov    %esi,%eax
  800c07:	8d 70 01             	lea    0x1(%eax),%esi
  800c0a:	8a 00                	mov    (%eax),%al
  800c0c:	0f be d8             	movsbl %al,%ebx
  800c0f:	85 db                	test   %ebx,%ebx
  800c11:	74 24                	je     800c37 <vprintfmt+0x24b>
  800c13:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c17:	78 b8                	js     800bd1 <vprintfmt+0x1e5>
  800c19:	ff 4d e0             	decl   -0x20(%ebp)
  800c1c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c20:	79 af                	jns    800bd1 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c22:	eb 13                	jmp    800c37 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c24:	83 ec 08             	sub    $0x8,%esp
  800c27:	ff 75 0c             	pushl  0xc(%ebp)
  800c2a:	6a 20                	push   $0x20
  800c2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2f:	ff d0                	call   *%eax
  800c31:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c34:	ff 4d e4             	decl   -0x1c(%ebp)
  800c37:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c3b:	7f e7                	jg     800c24 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c3d:	e9 66 01 00 00       	jmp    800da8 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c42:	83 ec 08             	sub    $0x8,%esp
  800c45:	ff 75 e8             	pushl  -0x18(%ebp)
  800c48:	8d 45 14             	lea    0x14(%ebp),%eax
  800c4b:	50                   	push   %eax
  800c4c:	e8 3c fd ff ff       	call   80098d <getint>
  800c51:	83 c4 10             	add    $0x10,%esp
  800c54:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c57:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c5d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c60:	85 d2                	test   %edx,%edx
  800c62:	79 23                	jns    800c87 <vprintfmt+0x29b>
				putch('-', putdat);
  800c64:	83 ec 08             	sub    $0x8,%esp
  800c67:	ff 75 0c             	pushl  0xc(%ebp)
  800c6a:	6a 2d                	push   $0x2d
  800c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6f:	ff d0                	call   *%eax
  800c71:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c74:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c77:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c7a:	f7 d8                	neg    %eax
  800c7c:	83 d2 00             	adc    $0x0,%edx
  800c7f:	f7 da                	neg    %edx
  800c81:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c84:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c87:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c8e:	e9 bc 00 00 00       	jmp    800d4f <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c93:	83 ec 08             	sub    $0x8,%esp
  800c96:	ff 75 e8             	pushl  -0x18(%ebp)
  800c99:	8d 45 14             	lea    0x14(%ebp),%eax
  800c9c:	50                   	push   %eax
  800c9d:	e8 84 fc ff ff       	call   800926 <getuint>
  800ca2:	83 c4 10             	add    $0x10,%esp
  800ca5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800cab:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cb2:	e9 98 00 00 00       	jmp    800d4f <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cb7:	83 ec 08             	sub    $0x8,%esp
  800cba:	ff 75 0c             	pushl  0xc(%ebp)
  800cbd:	6a 58                	push   $0x58
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	ff d0                	call   *%eax
  800cc4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cc7:	83 ec 08             	sub    $0x8,%esp
  800cca:	ff 75 0c             	pushl  0xc(%ebp)
  800ccd:	6a 58                	push   $0x58
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	ff d0                	call   *%eax
  800cd4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cd7:	83 ec 08             	sub    $0x8,%esp
  800cda:	ff 75 0c             	pushl  0xc(%ebp)
  800cdd:	6a 58                	push   $0x58
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	ff d0                	call   *%eax
  800ce4:	83 c4 10             	add    $0x10,%esp
			break;
  800ce7:	e9 bc 00 00 00       	jmp    800da8 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800cec:	83 ec 08             	sub    $0x8,%esp
  800cef:	ff 75 0c             	pushl  0xc(%ebp)
  800cf2:	6a 30                	push   $0x30
  800cf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf7:	ff d0                	call   *%eax
  800cf9:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cfc:	83 ec 08             	sub    $0x8,%esp
  800cff:	ff 75 0c             	pushl  0xc(%ebp)
  800d02:	6a 78                	push   $0x78
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	ff d0                	call   *%eax
  800d09:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d0c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d0f:	83 c0 04             	add    $0x4,%eax
  800d12:	89 45 14             	mov    %eax,0x14(%ebp)
  800d15:	8b 45 14             	mov    0x14(%ebp),%eax
  800d18:	83 e8 04             	sub    $0x4,%eax
  800d1b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d20:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d27:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d2e:	eb 1f                	jmp    800d4f <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d30:	83 ec 08             	sub    $0x8,%esp
  800d33:	ff 75 e8             	pushl  -0x18(%ebp)
  800d36:	8d 45 14             	lea    0x14(%ebp),%eax
  800d39:	50                   	push   %eax
  800d3a:	e8 e7 fb ff ff       	call   800926 <getuint>
  800d3f:	83 c4 10             	add    $0x10,%esp
  800d42:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d45:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d48:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d4f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d53:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d56:	83 ec 04             	sub    $0x4,%esp
  800d59:	52                   	push   %edx
  800d5a:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d5d:	50                   	push   %eax
  800d5e:	ff 75 f4             	pushl  -0xc(%ebp)
  800d61:	ff 75 f0             	pushl  -0x10(%ebp)
  800d64:	ff 75 0c             	pushl  0xc(%ebp)
  800d67:	ff 75 08             	pushl  0x8(%ebp)
  800d6a:	e8 00 fb ff ff       	call   80086f <printnum>
  800d6f:	83 c4 20             	add    $0x20,%esp
			break;
  800d72:	eb 34                	jmp    800da8 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d74:	83 ec 08             	sub    $0x8,%esp
  800d77:	ff 75 0c             	pushl  0xc(%ebp)
  800d7a:	53                   	push   %ebx
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7e:	ff d0                	call   *%eax
  800d80:	83 c4 10             	add    $0x10,%esp
			break;
  800d83:	eb 23                	jmp    800da8 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d85:	83 ec 08             	sub    $0x8,%esp
  800d88:	ff 75 0c             	pushl  0xc(%ebp)
  800d8b:	6a 25                	push   $0x25
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	ff d0                	call   *%eax
  800d92:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d95:	ff 4d 10             	decl   0x10(%ebp)
  800d98:	eb 03                	jmp    800d9d <vprintfmt+0x3b1>
  800d9a:	ff 4d 10             	decl   0x10(%ebp)
  800d9d:	8b 45 10             	mov    0x10(%ebp),%eax
  800da0:	48                   	dec    %eax
  800da1:	8a 00                	mov    (%eax),%al
  800da3:	3c 25                	cmp    $0x25,%al
  800da5:	75 f3                	jne    800d9a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800da7:	90                   	nop
		}
	}
  800da8:	e9 47 fc ff ff       	jmp    8009f4 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800dad:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800dae:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800db1:	5b                   	pop    %ebx
  800db2:	5e                   	pop    %esi
  800db3:	5d                   	pop    %ebp
  800db4:	c3                   	ret    

00800db5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800db5:	55                   	push   %ebp
  800db6:	89 e5                	mov    %esp,%ebp
  800db8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800dbb:	8d 45 10             	lea    0x10(%ebp),%eax
  800dbe:	83 c0 04             	add    $0x4,%eax
  800dc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800dc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc7:	ff 75 f4             	pushl  -0xc(%ebp)
  800dca:	50                   	push   %eax
  800dcb:	ff 75 0c             	pushl  0xc(%ebp)
  800dce:	ff 75 08             	pushl  0x8(%ebp)
  800dd1:	e8 16 fc ff ff       	call   8009ec <vprintfmt>
  800dd6:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800dd9:	90                   	nop
  800dda:	c9                   	leave  
  800ddb:	c3                   	ret    

00800ddc <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ddc:	55                   	push   %ebp
  800ddd:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de2:	8b 40 08             	mov    0x8(%eax),%eax
  800de5:	8d 50 01             	lea    0x1(%eax),%edx
  800de8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800deb:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800dee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df1:	8b 10                	mov    (%eax),%edx
  800df3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df6:	8b 40 04             	mov    0x4(%eax),%eax
  800df9:	39 c2                	cmp    %eax,%edx
  800dfb:	73 12                	jae    800e0f <sprintputch+0x33>
		*b->buf++ = ch;
  800dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e00:	8b 00                	mov    (%eax),%eax
  800e02:	8d 48 01             	lea    0x1(%eax),%ecx
  800e05:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e08:	89 0a                	mov    %ecx,(%edx)
  800e0a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e0d:	88 10                	mov    %dl,(%eax)
}
  800e0f:	90                   	nop
  800e10:	5d                   	pop    %ebp
  800e11:	c3                   	ret    

00800e12 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e12:	55                   	push   %ebp
  800e13:	89 e5                	mov    %esp,%ebp
  800e15:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e21:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
  800e27:	01 d0                	add    %edx,%eax
  800e29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e33:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e37:	74 06                	je     800e3f <vsnprintf+0x2d>
  800e39:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e3d:	7f 07                	jg     800e46 <vsnprintf+0x34>
		return -E_INVAL;
  800e3f:	b8 03 00 00 00       	mov    $0x3,%eax
  800e44:	eb 20                	jmp    800e66 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e46:	ff 75 14             	pushl  0x14(%ebp)
  800e49:	ff 75 10             	pushl  0x10(%ebp)
  800e4c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e4f:	50                   	push   %eax
  800e50:	68 dc 0d 80 00       	push   $0x800ddc
  800e55:	e8 92 fb ff ff       	call   8009ec <vprintfmt>
  800e5a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e60:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e63:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e66:	c9                   	leave  
  800e67:	c3                   	ret    

00800e68 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e68:	55                   	push   %ebp
  800e69:	89 e5                	mov    %esp,%ebp
  800e6b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e6e:	8d 45 10             	lea    0x10(%ebp),%eax
  800e71:	83 c0 04             	add    $0x4,%eax
  800e74:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e77:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7a:	ff 75 f4             	pushl  -0xc(%ebp)
  800e7d:	50                   	push   %eax
  800e7e:	ff 75 0c             	pushl  0xc(%ebp)
  800e81:	ff 75 08             	pushl  0x8(%ebp)
  800e84:	e8 89 ff ff ff       	call   800e12 <vsnprintf>
  800e89:	83 c4 10             	add    $0x10,%esp
  800e8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e92:	c9                   	leave  
  800e93:	c3                   	ret    

00800e94 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e94:	55                   	push   %ebp
  800e95:	89 e5                	mov    %esp,%ebp
  800e97:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ea1:	eb 06                	jmp    800ea9 <strlen+0x15>
		n++;
  800ea3:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ea6:	ff 45 08             	incl   0x8(%ebp)
  800ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eac:	8a 00                	mov    (%eax),%al
  800eae:	84 c0                	test   %al,%al
  800eb0:	75 f1                	jne    800ea3 <strlen+0xf>
		n++;
	return n;
  800eb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eb5:	c9                   	leave  
  800eb6:	c3                   	ret    

00800eb7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800eb7:	55                   	push   %ebp
  800eb8:	89 e5                	mov    %esp,%ebp
  800eba:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ebd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ec4:	eb 09                	jmp    800ecf <strnlen+0x18>
		n++;
  800ec6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ec9:	ff 45 08             	incl   0x8(%ebp)
  800ecc:	ff 4d 0c             	decl   0xc(%ebp)
  800ecf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ed3:	74 09                	je     800ede <strnlen+0x27>
  800ed5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed8:	8a 00                	mov    (%eax),%al
  800eda:	84 c0                	test   %al,%al
  800edc:	75 e8                	jne    800ec6 <strnlen+0xf>
		n++;
	return n;
  800ede:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ee1:	c9                   	leave  
  800ee2:	c3                   	ret    

00800ee3 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ee3:	55                   	push   %ebp
  800ee4:	89 e5                	mov    %esp,%ebp
  800ee6:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800eef:	90                   	nop
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	8d 50 01             	lea    0x1(%eax),%edx
  800ef6:	89 55 08             	mov    %edx,0x8(%ebp)
  800ef9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800efc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eff:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f02:	8a 12                	mov    (%edx),%dl
  800f04:	88 10                	mov    %dl,(%eax)
  800f06:	8a 00                	mov    (%eax),%al
  800f08:	84 c0                	test   %al,%al
  800f0a:	75 e4                	jne    800ef0 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f0f:	c9                   	leave  
  800f10:	c3                   	ret    

00800f11 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f11:	55                   	push   %ebp
  800f12:	89 e5                	mov    %esp,%ebp
  800f14:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f1d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f24:	eb 1f                	jmp    800f45 <strncpy+0x34>
		*dst++ = *src;
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	8d 50 01             	lea    0x1(%eax),%edx
  800f2c:	89 55 08             	mov    %edx,0x8(%ebp)
  800f2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f32:	8a 12                	mov    (%edx),%dl
  800f34:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f39:	8a 00                	mov    (%eax),%al
  800f3b:	84 c0                	test   %al,%al
  800f3d:	74 03                	je     800f42 <strncpy+0x31>
			src++;
  800f3f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f42:	ff 45 fc             	incl   -0x4(%ebp)
  800f45:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f48:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f4b:	72 d9                	jb     800f26 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f4d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f50:	c9                   	leave  
  800f51:	c3                   	ret    

00800f52 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f52:	55                   	push   %ebp
  800f53:	89 e5                	mov    %esp,%ebp
  800f55:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f5e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f62:	74 30                	je     800f94 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f64:	eb 16                	jmp    800f7c <strlcpy+0x2a>
			*dst++ = *src++;
  800f66:	8b 45 08             	mov    0x8(%ebp),%eax
  800f69:	8d 50 01             	lea    0x1(%eax),%edx
  800f6c:	89 55 08             	mov    %edx,0x8(%ebp)
  800f6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f72:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f75:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f78:	8a 12                	mov    (%edx),%dl
  800f7a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f7c:	ff 4d 10             	decl   0x10(%ebp)
  800f7f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f83:	74 09                	je     800f8e <strlcpy+0x3c>
  800f85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f88:	8a 00                	mov    (%eax),%al
  800f8a:	84 c0                	test   %al,%al
  800f8c:	75 d8                	jne    800f66 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f94:	8b 55 08             	mov    0x8(%ebp),%edx
  800f97:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f9a:	29 c2                	sub    %eax,%edx
  800f9c:	89 d0                	mov    %edx,%eax
}
  800f9e:	c9                   	leave  
  800f9f:	c3                   	ret    

00800fa0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fa0:	55                   	push   %ebp
  800fa1:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fa3:	eb 06                	jmp    800fab <strcmp+0xb>
		p++, q++;
  800fa5:	ff 45 08             	incl   0x8(%ebp)
  800fa8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	8a 00                	mov    (%eax),%al
  800fb0:	84 c0                	test   %al,%al
  800fb2:	74 0e                	je     800fc2 <strcmp+0x22>
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	8a 10                	mov    (%eax),%dl
  800fb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbc:	8a 00                	mov    (%eax),%al
  800fbe:	38 c2                	cmp    %al,%dl
  800fc0:	74 e3                	je     800fa5 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc5:	8a 00                	mov    (%eax),%al
  800fc7:	0f b6 d0             	movzbl %al,%edx
  800fca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcd:	8a 00                	mov    (%eax),%al
  800fcf:	0f b6 c0             	movzbl %al,%eax
  800fd2:	29 c2                	sub    %eax,%edx
  800fd4:	89 d0                	mov    %edx,%eax
}
  800fd6:	5d                   	pop    %ebp
  800fd7:	c3                   	ret    

00800fd8 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800fd8:	55                   	push   %ebp
  800fd9:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800fdb:	eb 09                	jmp    800fe6 <strncmp+0xe>
		n--, p++, q++;
  800fdd:	ff 4d 10             	decl   0x10(%ebp)
  800fe0:	ff 45 08             	incl   0x8(%ebp)
  800fe3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800fe6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fea:	74 17                	je     801003 <strncmp+0x2b>
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	84 c0                	test   %al,%al
  800ff3:	74 0e                	je     801003 <strncmp+0x2b>
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	8a 10                	mov    (%eax),%dl
  800ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	38 c2                	cmp    %al,%dl
  801001:	74 da                	je     800fdd <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801003:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801007:	75 07                	jne    801010 <strncmp+0x38>
		return 0;
  801009:	b8 00 00 00 00       	mov    $0x0,%eax
  80100e:	eb 14                	jmp    801024 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	8a 00                	mov    (%eax),%al
  801015:	0f b6 d0             	movzbl %al,%edx
  801018:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101b:	8a 00                	mov    (%eax),%al
  80101d:	0f b6 c0             	movzbl %al,%eax
  801020:	29 c2                	sub    %eax,%edx
  801022:	89 d0                	mov    %edx,%eax
}
  801024:	5d                   	pop    %ebp
  801025:	c3                   	ret    

00801026 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801026:	55                   	push   %ebp
  801027:	89 e5                	mov    %esp,%ebp
  801029:	83 ec 04             	sub    $0x4,%esp
  80102c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801032:	eb 12                	jmp    801046 <strchr+0x20>
		if (*s == c)
  801034:	8b 45 08             	mov    0x8(%ebp),%eax
  801037:	8a 00                	mov    (%eax),%al
  801039:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80103c:	75 05                	jne    801043 <strchr+0x1d>
			return (char *) s;
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	eb 11                	jmp    801054 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801043:	ff 45 08             	incl   0x8(%ebp)
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	8a 00                	mov    (%eax),%al
  80104b:	84 c0                	test   %al,%al
  80104d:	75 e5                	jne    801034 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80104f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801054:	c9                   	leave  
  801055:	c3                   	ret    

00801056 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801056:	55                   	push   %ebp
  801057:	89 e5                	mov    %esp,%ebp
  801059:	83 ec 04             	sub    $0x4,%esp
  80105c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801062:	eb 0d                	jmp    801071 <strfind+0x1b>
		if (*s == c)
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	8a 00                	mov    (%eax),%al
  801069:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80106c:	74 0e                	je     80107c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80106e:	ff 45 08             	incl   0x8(%ebp)
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	8a 00                	mov    (%eax),%al
  801076:	84 c0                	test   %al,%al
  801078:	75 ea                	jne    801064 <strfind+0xe>
  80107a:	eb 01                	jmp    80107d <strfind+0x27>
		if (*s == c)
			break;
  80107c:	90                   	nop
	return (char *) s;
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801080:	c9                   	leave  
  801081:	c3                   	ret    

00801082 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801082:	55                   	push   %ebp
  801083:	89 e5                	mov    %esp,%ebp
  801085:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80108e:	8b 45 10             	mov    0x10(%ebp),%eax
  801091:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801094:	eb 0e                	jmp    8010a4 <memset+0x22>
		*p++ = c;
  801096:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801099:	8d 50 01             	lea    0x1(%eax),%edx
  80109c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80109f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a2:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8010a4:	ff 4d f8             	decl   -0x8(%ebp)
  8010a7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8010ab:	79 e9                	jns    801096 <memset+0x14>
		*p++ = c;

	return v;
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010b0:	c9                   	leave  
  8010b1:	c3                   	ret    

008010b2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8010b2:	55                   	push   %ebp
  8010b3:	89 e5                	mov    %esp,%ebp
  8010b5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8010c4:	eb 16                	jmp    8010dc <memcpy+0x2a>
		*d++ = *s++;
  8010c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c9:	8d 50 01             	lea    0x1(%eax),%edx
  8010cc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010d2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010d5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010d8:	8a 12                	mov    (%edx),%dl
  8010da:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8010dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010df:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8010e5:	85 c0                	test   %eax,%eax
  8010e7:	75 dd                	jne    8010c6 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8010e9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010ec:	c9                   	leave  
  8010ed:	c3                   	ret    

008010ee <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010ee:	55                   	push   %ebp
  8010ef:	89 e5                	mov    %esp,%ebp
  8010f1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801100:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801103:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801106:	73 50                	jae    801158 <memmove+0x6a>
  801108:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80110b:	8b 45 10             	mov    0x10(%ebp),%eax
  80110e:	01 d0                	add    %edx,%eax
  801110:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801113:	76 43                	jbe    801158 <memmove+0x6a>
		s += n;
  801115:	8b 45 10             	mov    0x10(%ebp),%eax
  801118:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80111b:	8b 45 10             	mov    0x10(%ebp),%eax
  80111e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801121:	eb 10                	jmp    801133 <memmove+0x45>
			*--d = *--s;
  801123:	ff 4d f8             	decl   -0x8(%ebp)
  801126:	ff 4d fc             	decl   -0x4(%ebp)
  801129:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112c:	8a 10                	mov    (%eax),%dl
  80112e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801131:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801133:	8b 45 10             	mov    0x10(%ebp),%eax
  801136:	8d 50 ff             	lea    -0x1(%eax),%edx
  801139:	89 55 10             	mov    %edx,0x10(%ebp)
  80113c:	85 c0                	test   %eax,%eax
  80113e:	75 e3                	jne    801123 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801140:	eb 23                	jmp    801165 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801142:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801145:	8d 50 01             	lea    0x1(%eax),%edx
  801148:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80114b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80114e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801151:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801154:	8a 12                	mov    (%edx),%dl
  801156:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801158:	8b 45 10             	mov    0x10(%ebp),%eax
  80115b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80115e:	89 55 10             	mov    %edx,0x10(%ebp)
  801161:	85 c0                	test   %eax,%eax
  801163:	75 dd                	jne    801142 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801168:	c9                   	leave  
  801169:	c3                   	ret    

0080116a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80116a:	55                   	push   %ebp
  80116b:	89 e5                	mov    %esp,%ebp
  80116d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801170:	8b 45 08             	mov    0x8(%ebp),%eax
  801173:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801176:	8b 45 0c             	mov    0xc(%ebp),%eax
  801179:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80117c:	eb 2a                	jmp    8011a8 <memcmp+0x3e>
		if (*s1 != *s2)
  80117e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801181:	8a 10                	mov    (%eax),%dl
  801183:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801186:	8a 00                	mov    (%eax),%al
  801188:	38 c2                	cmp    %al,%dl
  80118a:	74 16                	je     8011a2 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80118c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	0f b6 d0             	movzbl %al,%edx
  801194:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801197:	8a 00                	mov    (%eax),%al
  801199:	0f b6 c0             	movzbl %al,%eax
  80119c:	29 c2                	sub    %eax,%edx
  80119e:	89 d0                	mov    %edx,%eax
  8011a0:	eb 18                	jmp    8011ba <memcmp+0x50>
		s1++, s2++;
  8011a2:	ff 45 fc             	incl   -0x4(%ebp)
  8011a5:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8011a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ab:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011ae:	89 55 10             	mov    %edx,0x10(%ebp)
  8011b1:	85 c0                	test   %eax,%eax
  8011b3:	75 c9                	jne    80117e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8011b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011ba:	c9                   	leave  
  8011bb:	c3                   	ret    

008011bc <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8011bc:	55                   	push   %ebp
  8011bd:	89 e5                	mov    %esp,%ebp
  8011bf:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8011c2:	8b 55 08             	mov    0x8(%ebp),%edx
  8011c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c8:	01 d0                	add    %edx,%eax
  8011ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8011cd:	eb 15                	jmp    8011e4 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8011cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d2:	8a 00                	mov    (%eax),%al
  8011d4:	0f b6 d0             	movzbl %al,%edx
  8011d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011da:	0f b6 c0             	movzbl %al,%eax
  8011dd:	39 c2                	cmp    %eax,%edx
  8011df:	74 0d                	je     8011ee <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8011e1:	ff 45 08             	incl   0x8(%ebp)
  8011e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8011ea:	72 e3                	jb     8011cf <memfind+0x13>
  8011ec:	eb 01                	jmp    8011ef <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011ee:	90                   	nop
	return (void *) s;
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011f2:	c9                   	leave  
  8011f3:	c3                   	ret    

008011f4 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8011f4:	55                   	push   %ebp
  8011f5:	89 e5                	mov    %esp,%ebp
  8011f7:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8011fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801201:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801208:	eb 03                	jmp    80120d <strtol+0x19>
		s++;
  80120a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80120d:	8b 45 08             	mov    0x8(%ebp),%eax
  801210:	8a 00                	mov    (%eax),%al
  801212:	3c 20                	cmp    $0x20,%al
  801214:	74 f4                	je     80120a <strtol+0x16>
  801216:	8b 45 08             	mov    0x8(%ebp),%eax
  801219:	8a 00                	mov    (%eax),%al
  80121b:	3c 09                	cmp    $0x9,%al
  80121d:	74 eb                	je     80120a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
  801222:	8a 00                	mov    (%eax),%al
  801224:	3c 2b                	cmp    $0x2b,%al
  801226:	75 05                	jne    80122d <strtol+0x39>
		s++;
  801228:	ff 45 08             	incl   0x8(%ebp)
  80122b:	eb 13                	jmp    801240 <strtol+0x4c>
	else if (*s == '-')
  80122d:	8b 45 08             	mov    0x8(%ebp),%eax
  801230:	8a 00                	mov    (%eax),%al
  801232:	3c 2d                	cmp    $0x2d,%al
  801234:	75 0a                	jne    801240 <strtol+0x4c>
		s++, neg = 1;
  801236:	ff 45 08             	incl   0x8(%ebp)
  801239:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801240:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801244:	74 06                	je     80124c <strtol+0x58>
  801246:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80124a:	75 20                	jne    80126c <strtol+0x78>
  80124c:	8b 45 08             	mov    0x8(%ebp),%eax
  80124f:	8a 00                	mov    (%eax),%al
  801251:	3c 30                	cmp    $0x30,%al
  801253:	75 17                	jne    80126c <strtol+0x78>
  801255:	8b 45 08             	mov    0x8(%ebp),%eax
  801258:	40                   	inc    %eax
  801259:	8a 00                	mov    (%eax),%al
  80125b:	3c 78                	cmp    $0x78,%al
  80125d:	75 0d                	jne    80126c <strtol+0x78>
		s += 2, base = 16;
  80125f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801263:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80126a:	eb 28                	jmp    801294 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80126c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801270:	75 15                	jne    801287 <strtol+0x93>
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	8a 00                	mov    (%eax),%al
  801277:	3c 30                	cmp    $0x30,%al
  801279:	75 0c                	jne    801287 <strtol+0x93>
		s++, base = 8;
  80127b:	ff 45 08             	incl   0x8(%ebp)
  80127e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801285:	eb 0d                	jmp    801294 <strtol+0xa0>
	else if (base == 0)
  801287:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80128b:	75 07                	jne    801294 <strtol+0xa0>
		base = 10;
  80128d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	8a 00                	mov    (%eax),%al
  801299:	3c 2f                	cmp    $0x2f,%al
  80129b:	7e 19                	jle    8012b6 <strtol+0xc2>
  80129d:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a0:	8a 00                	mov    (%eax),%al
  8012a2:	3c 39                	cmp    $0x39,%al
  8012a4:	7f 10                	jg     8012b6 <strtol+0xc2>
			dig = *s - '0';
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	8a 00                	mov    (%eax),%al
  8012ab:	0f be c0             	movsbl %al,%eax
  8012ae:	83 e8 30             	sub    $0x30,%eax
  8012b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012b4:	eb 42                	jmp    8012f8 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8012b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b9:	8a 00                	mov    (%eax),%al
  8012bb:	3c 60                	cmp    $0x60,%al
  8012bd:	7e 19                	jle    8012d8 <strtol+0xe4>
  8012bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c2:	8a 00                	mov    (%eax),%al
  8012c4:	3c 7a                	cmp    $0x7a,%al
  8012c6:	7f 10                	jg     8012d8 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	8a 00                	mov    (%eax),%al
  8012cd:	0f be c0             	movsbl %al,%eax
  8012d0:	83 e8 57             	sub    $0x57,%eax
  8012d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012d6:	eb 20                	jmp    8012f8 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	8a 00                	mov    (%eax),%al
  8012dd:	3c 40                	cmp    $0x40,%al
  8012df:	7e 39                	jle    80131a <strtol+0x126>
  8012e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e4:	8a 00                	mov    (%eax),%al
  8012e6:	3c 5a                	cmp    $0x5a,%al
  8012e8:	7f 30                	jg     80131a <strtol+0x126>
			dig = *s - 'A' + 10;
  8012ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ed:	8a 00                	mov    (%eax),%al
  8012ef:	0f be c0             	movsbl %al,%eax
  8012f2:	83 e8 37             	sub    $0x37,%eax
  8012f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8012f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012fb:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012fe:	7d 19                	jge    801319 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801300:	ff 45 08             	incl   0x8(%ebp)
  801303:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801306:	0f af 45 10          	imul   0x10(%ebp),%eax
  80130a:	89 c2                	mov    %eax,%edx
  80130c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80130f:	01 d0                	add    %edx,%eax
  801311:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801314:	e9 7b ff ff ff       	jmp    801294 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801319:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80131a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80131e:	74 08                	je     801328 <strtol+0x134>
		*endptr = (char *) s;
  801320:	8b 45 0c             	mov    0xc(%ebp),%eax
  801323:	8b 55 08             	mov    0x8(%ebp),%edx
  801326:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801328:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80132c:	74 07                	je     801335 <strtol+0x141>
  80132e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801331:	f7 d8                	neg    %eax
  801333:	eb 03                	jmp    801338 <strtol+0x144>
  801335:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801338:	c9                   	leave  
  801339:	c3                   	ret    

0080133a <ltostr>:

void
ltostr(long value, char *str)
{
  80133a:	55                   	push   %ebp
  80133b:	89 e5                	mov    %esp,%ebp
  80133d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801340:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801347:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80134e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801352:	79 13                	jns    801367 <ltostr+0x2d>
	{
		neg = 1;
  801354:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80135b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801361:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801364:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801367:	8b 45 08             	mov    0x8(%ebp),%eax
  80136a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80136f:	99                   	cltd   
  801370:	f7 f9                	idiv   %ecx
  801372:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801375:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801378:	8d 50 01             	lea    0x1(%eax),%edx
  80137b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80137e:	89 c2                	mov    %eax,%edx
  801380:	8b 45 0c             	mov    0xc(%ebp),%eax
  801383:	01 d0                	add    %edx,%eax
  801385:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801388:	83 c2 30             	add    $0x30,%edx
  80138b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80138d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801390:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801395:	f7 e9                	imul   %ecx
  801397:	c1 fa 02             	sar    $0x2,%edx
  80139a:	89 c8                	mov    %ecx,%eax
  80139c:	c1 f8 1f             	sar    $0x1f,%eax
  80139f:	29 c2                	sub    %eax,%edx
  8013a1:	89 d0                	mov    %edx,%eax
  8013a3:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8013a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013a9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013ae:	f7 e9                	imul   %ecx
  8013b0:	c1 fa 02             	sar    $0x2,%edx
  8013b3:	89 c8                	mov    %ecx,%eax
  8013b5:	c1 f8 1f             	sar    $0x1f,%eax
  8013b8:	29 c2                	sub    %eax,%edx
  8013ba:	89 d0                	mov    %edx,%eax
  8013bc:	c1 e0 02             	shl    $0x2,%eax
  8013bf:	01 d0                	add    %edx,%eax
  8013c1:	01 c0                	add    %eax,%eax
  8013c3:	29 c1                	sub    %eax,%ecx
  8013c5:	89 ca                	mov    %ecx,%edx
  8013c7:	85 d2                	test   %edx,%edx
  8013c9:	75 9c                	jne    801367 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8013cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8013d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013d5:	48                   	dec    %eax
  8013d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8013d9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013dd:	74 3d                	je     80141c <ltostr+0xe2>
		start = 1 ;
  8013df:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8013e6:	eb 34                	jmp    80141c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8013e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ee:	01 d0                	add    %edx,%eax
  8013f0:	8a 00                	mov    (%eax),%al
  8013f2:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8013f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fb:	01 c2                	add    %eax,%edx
  8013fd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801400:	8b 45 0c             	mov    0xc(%ebp),%eax
  801403:	01 c8                	add    %ecx,%eax
  801405:	8a 00                	mov    (%eax),%al
  801407:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801409:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80140c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140f:	01 c2                	add    %eax,%edx
  801411:	8a 45 eb             	mov    -0x15(%ebp),%al
  801414:	88 02                	mov    %al,(%edx)
		start++ ;
  801416:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801419:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80141c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80141f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801422:	7c c4                	jl     8013e8 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801424:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801427:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142a:	01 d0                	add    %edx,%eax
  80142c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80142f:	90                   	nop
  801430:	c9                   	leave  
  801431:	c3                   	ret    

00801432 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801432:	55                   	push   %ebp
  801433:	89 e5                	mov    %esp,%ebp
  801435:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801438:	ff 75 08             	pushl  0x8(%ebp)
  80143b:	e8 54 fa ff ff       	call   800e94 <strlen>
  801440:	83 c4 04             	add    $0x4,%esp
  801443:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801446:	ff 75 0c             	pushl  0xc(%ebp)
  801449:	e8 46 fa ff ff       	call   800e94 <strlen>
  80144e:	83 c4 04             	add    $0x4,%esp
  801451:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801454:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80145b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801462:	eb 17                	jmp    80147b <strcconcat+0x49>
		final[s] = str1[s] ;
  801464:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801467:	8b 45 10             	mov    0x10(%ebp),%eax
  80146a:	01 c2                	add    %eax,%edx
  80146c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	01 c8                	add    %ecx,%eax
  801474:	8a 00                	mov    (%eax),%al
  801476:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801478:	ff 45 fc             	incl   -0x4(%ebp)
  80147b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80147e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801481:	7c e1                	jl     801464 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801483:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80148a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801491:	eb 1f                	jmp    8014b2 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801493:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801496:	8d 50 01             	lea    0x1(%eax),%edx
  801499:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80149c:	89 c2                	mov    %eax,%edx
  80149e:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a1:	01 c2                	add    %eax,%edx
  8014a3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8014a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a9:	01 c8                	add    %ecx,%eax
  8014ab:	8a 00                	mov    (%eax),%al
  8014ad:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8014af:	ff 45 f8             	incl   -0x8(%ebp)
  8014b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014b8:	7c d9                	jl     801493 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8014ba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c0:	01 d0                	add    %edx,%eax
  8014c2:	c6 00 00             	movb   $0x0,(%eax)
}
  8014c5:	90                   	nop
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8014cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ce:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8014d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d7:	8b 00                	mov    (%eax),%eax
  8014d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e3:	01 d0                	add    %edx,%eax
  8014e5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014eb:	eb 0c                	jmp    8014f9 <strsplit+0x31>
			*string++ = 0;
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f0:	8d 50 01             	lea    0x1(%eax),%edx
  8014f3:	89 55 08             	mov    %edx,0x8(%ebp)
  8014f6:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fc:	8a 00                	mov    (%eax),%al
  8014fe:	84 c0                	test   %al,%al
  801500:	74 18                	je     80151a <strsplit+0x52>
  801502:	8b 45 08             	mov    0x8(%ebp),%eax
  801505:	8a 00                	mov    (%eax),%al
  801507:	0f be c0             	movsbl %al,%eax
  80150a:	50                   	push   %eax
  80150b:	ff 75 0c             	pushl  0xc(%ebp)
  80150e:	e8 13 fb ff ff       	call   801026 <strchr>
  801513:	83 c4 08             	add    $0x8,%esp
  801516:	85 c0                	test   %eax,%eax
  801518:	75 d3                	jne    8014ed <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	8a 00                	mov    (%eax),%al
  80151f:	84 c0                	test   %al,%al
  801521:	74 5a                	je     80157d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801523:	8b 45 14             	mov    0x14(%ebp),%eax
  801526:	8b 00                	mov    (%eax),%eax
  801528:	83 f8 0f             	cmp    $0xf,%eax
  80152b:	75 07                	jne    801534 <strsplit+0x6c>
		{
			return 0;
  80152d:	b8 00 00 00 00       	mov    $0x0,%eax
  801532:	eb 66                	jmp    80159a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801534:	8b 45 14             	mov    0x14(%ebp),%eax
  801537:	8b 00                	mov    (%eax),%eax
  801539:	8d 48 01             	lea    0x1(%eax),%ecx
  80153c:	8b 55 14             	mov    0x14(%ebp),%edx
  80153f:	89 0a                	mov    %ecx,(%edx)
  801541:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801548:	8b 45 10             	mov    0x10(%ebp),%eax
  80154b:	01 c2                	add    %eax,%edx
  80154d:	8b 45 08             	mov    0x8(%ebp),%eax
  801550:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801552:	eb 03                	jmp    801557 <strsplit+0x8f>
			string++;
  801554:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801557:	8b 45 08             	mov    0x8(%ebp),%eax
  80155a:	8a 00                	mov    (%eax),%al
  80155c:	84 c0                	test   %al,%al
  80155e:	74 8b                	je     8014eb <strsplit+0x23>
  801560:	8b 45 08             	mov    0x8(%ebp),%eax
  801563:	8a 00                	mov    (%eax),%al
  801565:	0f be c0             	movsbl %al,%eax
  801568:	50                   	push   %eax
  801569:	ff 75 0c             	pushl  0xc(%ebp)
  80156c:	e8 b5 fa ff ff       	call   801026 <strchr>
  801571:	83 c4 08             	add    $0x8,%esp
  801574:	85 c0                	test   %eax,%eax
  801576:	74 dc                	je     801554 <strsplit+0x8c>
			string++;
	}
  801578:	e9 6e ff ff ff       	jmp    8014eb <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80157d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80157e:	8b 45 14             	mov    0x14(%ebp),%eax
  801581:	8b 00                	mov    (%eax),%eax
  801583:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80158a:	8b 45 10             	mov    0x10(%ebp),%eax
  80158d:	01 d0                	add    %edx,%eax
  80158f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801595:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80159a:	c9                   	leave  
  80159b:	c3                   	ret    

0080159c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80159c:	55                   	push   %ebp
  80159d:	89 e5                	mov    %esp,%ebp
  80159f:	57                   	push   %edi
  8015a0:	56                   	push   %esi
  8015a1:	53                   	push   %ebx
  8015a2:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015ae:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015b1:	8b 7d 18             	mov    0x18(%ebp),%edi
  8015b4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8015b7:	cd 30                	int    $0x30
  8015b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8015bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015bf:	83 c4 10             	add    $0x10,%esp
  8015c2:	5b                   	pop    %ebx
  8015c3:	5e                   	pop    %esi
  8015c4:	5f                   	pop    %edi
  8015c5:	5d                   	pop    %ebp
  8015c6:	c3                   	ret    

008015c7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
  8015ca:	83 ec 04             	sub    $0x4,%esp
  8015cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8015d3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	52                   	push   %edx
  8015df:	ff 75 0c             	pushl  0xc(%ebp)
  8015e2:	50                   	push   %eax
  8015e3:	6a 00                	push   $0x0
  8015e5:	e8 b2 ff ff ff       	call   80159c <syscall>
  8015ea:	83 c4 18             	add    $0x18,%esp
}
  8015ed:	90                   	nop
  8015ee:	c9                   	leave  
  8015ef:	c3                   	ret    

008015f0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8015f0:	55                   	push   %ebp
  8015f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 01                	push   $0x1
  8015ff:	e8 98 ff ff ff       	call   80159c <syscall>
  801604:	83 c4 18             	add    $0x18,%esp
}
  801607:	c9                   	leave  
  801608:	c3                   	ret    

00801609 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801609:	55                   	push   %ebp
  80160a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	50                   	push   %eax
  801618:	6a 05                	push   $0x5
  80161a:	e8 7d ff ff ff       	call   80159c <syscall>
  80161f:	83 c4 18             	add    $0x18,%esp
}
  801622:	c9                   	leave  
  801623:	c3                   	ret    

00801624 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 02                	push   $0x2
  801633:	e8 64 ff ff ff       	call   80159c <syscall>
  801638:	83 c4 18             	add    $0x18,%esp
}
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    

0080163d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80163d:	55                   	push   %ebp
  80163e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 03                	push   $0x3
  80164c:	e8 4b ff ff ff       	call   80159c <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 04                	push   $0x4
  801665:	e8 32 ff ff ff       	call   80159c <syscall>
  80166a:	83 c4 18             	add    $0x18,%esp
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <sys_env_exit>:


void sys_env_exit(void)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 06                	push   $0x6
  80167e:	e8 19 ff ff ff       	call   80159c <syscall>
  801683:	83 c4 18             	add    $0x18,%esp
}
  801686:	90                   	nop
  801687:	c9                   	leave  
  801688:	c3                   	ret    

00801689 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801689:	55                   	push   %ebp
  80168a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80168c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	52                   	push   %edx
  801699:	50                   	push   %eax
  80169a:	6a 07                	push   $0x7
  80169c:	e8 fb fe ff ff       	call   80159c <syscall>
  8016a1:	83 c4 18             	add    $0x18,%esp
}
  8016a4:	c9                   	leave  
  8016a5:	c3                   	ret    

008016a6 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016a6:	55                   	push   %ebp
  8016a7:	89 e5                	mov    %esp,%ebp
  8016a9:	56                   	push   %esi
  8016aa:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016ab:	8b 75 18             	mov    0x18(%ebp),%esi
  8016ae:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016b1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ba:	56                   	push   %esi
  8016bb:	53                   	push   %ebx
  8016bc:	51                   	push   %ecx
  8016bd:	52                   	push   %edx
  8016be:	50                   	push   %eax
  8016bf:	6a 08                	push   $0x8
  8016c1:	e8 d6 fe ff ff       	call   80159c <syscall>
  8016c6:	83 c4 18             	add    $0x18,%esp
}
  8016c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016cc:	5b                   	pop    %ebx
  8016cd:	5e                   	pop    %esi
  8016ce:	5d                   	pop    %ebp
  8016cf:	c3                   	ret    

008016d0 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8016d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	52                   	push   %edx
  8016e0:	50                   	push   %eax
  8016e1:	6a 09                	push   $0x9
  8016e3:	e8 b4 fe ff ff       	call   80159c <syscall>
  8016e8:	83 c4 18             	add    $0x18,%esp
}
  8016eb:	c9                   	leave  
  8016ec:	c3                   	ret    

008016ed <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8016ed:	55                   	push   %ebp
  8016ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	ff 75 0c             	pushl  0xc(%ebp)
  8016f9:	ff 75 08             	pushl  0x8(%ebp)
  8016fc:	6a 0a                	push   $0xa
  8016fe:	e8 99 fe ff ff       	call   80159c <syscall>
  801703:	83 c4 18             	add    $0x18,%esp
}
  801706:	c9                   	leave  
  801707:	c3                   	ret    

00801708 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801708:	55                   	push   %ebp
  801709:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 0b                	push   $0xb
  801717:	e8 80 fe ff ff       	call   80159c <syscall>
  80171c:	83 c4 18             	add    $0x18,%esp
}
  80171f:	c9                   	leave  
  801720:	c3                   	ret    

00801721 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801721:	55                   	push   %ebp
  801722:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 0c                	push   $0xc
  801730:	e8 67 fe ff ff       	call   80159c <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
}
  801738:	c9                   	leave  
  801739:	c3                   	ret    

0080173a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80173a:	55                   	push   %ebp
  80173b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	6a 00                	push   $0x0
  801747:	6a 0d                	push   $0xd
  801749:	e8 4e fe ff ff       	call   80159c <syscall>
  80174e:	83 c4 18             	add    $0x18,%esp
}
  801751:	c9                   	leave  
  801752:	c3                   	ret    

00801753 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801753:	55                   	push   %ebp
  801754:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	ff 75 0c             	pushl  0xc(%ebp)
  80175f:	ff 75 08             	pushl  0x8(%ebp)
  801762:	6a 11                	push   $0x11
  801764:	e8 33 fe ff ff       	call   80159c <syscall>
  801769:	83 c4 18             	add    $0x18,%esp
	return;
  80176c:	90                   	nop
}
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	ff 75 0c             	pushl  0xc(%ebp)
  80177b:	ff 75 08             	pushl  0x8(%ebp)
  80177e:	6a 12                	push   $0x12
  801780:	e8 17 fe ff ff       	call   80159c <syscall>
  801785:	83 c4 18             	add    $0x18,%esp
	return ;
  801788:	90                   	nop
}
  801789:	c9                   	leave  
  80178a:	c3                   	ret    

0080178b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80178b:	55                   	push   %ebp
  80178c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 0e                	push   $0xe
  80179a:	e8 fd fd ff ff       	call   80159c <syscall>
  80179f:	83 c4 18             	add    $0x18,%esp
}
  8017a2:	c9                   	leave  
  8017a3:	c3                   	ret    

008017a4 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8017a4:	55                   	push   %ebp
  8017a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	ff 75 08             	pushl  0x8(%ebp)
  8017b2:	6a 0f                	push   $0xf
  8017b4:	e8 e3 fd ff ff       	call   80159c <syscall>
  8017b9:	83 c4 18             	add    $0x18,%esp
}
  8017bc:	c9                   	leave  
  8017bd:	c3                   	ret    

008017be <sys_scarce_memory>:

void sys_scarce_memory()
{
  8017be:	55                   	push   %ebp
  8017bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 10                	push   $0x10
  8017cd:	e8 ca fd ff ff       	call   80159c <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
}
  8017d5:	90                   	nop
  8017d6:	c9                   	leave  
  8017d7:	c3                   	ret    

008017d8 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8017d8:	55                   	push   %ebp
  8017d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 14                	push   $0x14
  8017e7:	e8 b0 fd ff ff       	call   80159c <syscall>
  8017ec:	83 c4 18             	add    $0x18,%esp
}
  8017ef:	90                   	nop
  8017f0:	c9                   	leave  
  8017f1:	c3                   	ret    

008017f2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8017f2:	55                   	push   %ebp
  8017f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 15                	push   $0x15
  801801:	e8 96 fd ff ff       	call   80159c <syscall>
  801806:	83 c4 18             	add    $0x18,%esp
}
  801809:	90                   	nop
  80180a:	c9                   	leave  
  80180b:	c3                   	ret    

0080180c <sys_cputc>:


void
sys_cputc(const char c)
{
  80180c:	55                   	push   %ebp
  80180d:	89 e5                	mov    %esp,%ebp
  80180f:	83 ec 04             	sub    $0x4,%esp
  801812:	8b 45 08             	mov    0x8(%ebp),%eax
  801815:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801818:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	50                   	push   %eax
  801825:	6a 16                	push   $0x16
  801827:	e8 70 fd ff ff       	call   80159c <syscall>
  80182c:	83 c4 18             	add    $0x18,%esp
}
  80182f:	90                   	nop
  801830:	c9                   	leave  
  801831:	c3                   	ret    

00801832 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801832:	55                   	push   %ebp
  801833:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 17                	push   $0x17
  801841:	e8 56 fd ff ff       	call   80159c <syscall>
  801846:	83 c4 18             	add    $0x18,%esp
}
  801849:	90                   	nop
  80184a:	c9                   	leave  
  80184b:	c3                   	ret    

0080184c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80184c:	55                   	push   %ebp
  80184d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80184f:	8b 45 08             	mov    0x8(%ebp),%eax
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	ff 75 0c             	pushl  0xc(%ebp)
  80185b:	50                   	push   %eax
  80185c:	6a 18                	push   $0x18
  80185e:	e8 39 fd ff ff       	call   80159c <syscall>
  801863:	83 c4 18             	add    $0x18,%esp
}
  801866:	c9                   	leave  
  801867:	c3                   	ret    

00801868 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801868:	55                   	push   %ebp
  801869:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80186b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80186e:	8b 45 08             	mov    0x8(%ebp),%eax
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	52                   	push   %edx
  801878:	50                   	push   %eax
  801879:	6a 1b                	push   $0x1b
  80187b:	e8 1c fd ff ff       	call   80159c <syscall>
  801880:	83 c4 18             	add    $0x18,%esp
}
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801888:	8b 55 0c             	mov    0xc(%ebp),%edx
  80188b:	8b 45 08             	mov    0x8(%ebp),%eax
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	52                   	push   %edx
  801895:	50                   	push   %eax
  801896:	6a 19                	push   $0x19
  801898:	e8 ff fc ff ff       	call   80159c <syscall>
  80189d:	83 c4 18             	add    $0x18,%esp
}
  8018a0:	90                   	nop
  8018a1:	c9                   	leave  
  8018a2:	c3                   	ret    

008018a3 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018a3:	55                   	push   %ebp
  8018a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	52                   	push   %edx
  8018b3:	50                   	push   %eax
  8018b4:	6a 1a                	push   $0x1a
  8018b6:	e8 e1 fc ff ff       	call   80159c <syscall>
  8018bb:	83 c4 18             	add    $0x18,%esp
}
  8018be:	90                   	nop
  8018bf:	c9                   	leave  
  8018c0:	c3                   	ret    

008018c1 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
  8018c4:	83 ec 04             	sub    $0x4,%esp
  8018c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ca:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8018cd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018d0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d7:	6a 00                	push   $0x0
  8018d9:	51                   	push   %ecx
  8018da:	52                   	push   %edx
  8018db:	ff 75 0c             	pushl  0xc(%ebp)
  8018de:	50                   	push   %eax
  8018df:	6a 1c                	push   $0x1c
  8018e1:	e8 b6 fc ff ff       	call   80159c <syscall>
  8018e6:	83 c4 18             	add    $0x18,%esp
}
  8018e9:	c9                   	leave  
  8018ea:	c3                   	ret    

008018eb <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8018eb:	55                   	push   %ebp
  8018ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8018ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	52                   	push   %edx
  8018fb:	50                   	push   %eax
  8018fc:	6a 1d                	push   $0x1d
  8018fe:	e8 99 fc ff ff       	call   80159c <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
}
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80190b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80190e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	51                   	push   %ecx
  801919:	52                   	push   %edx
  80191a:	50                   	push   %eax
  80191b:	6a 1e                	push   $0x1e
  80191d:	e8 7a fc ff ff       	call   80159c <syscall>
  801922:	83 c4 18             	add    $0x18,%esp
}
  801925:	c9                   	leave  
  801926:	c3                   	ret    

00801927 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80192a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80192d:	8b 45 08             	mov    0x8(%ebp),%eax
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	52                   	push   %edx
  801937:	50                   	push   %eax
  801938:	6a 1f                	push   $0x1f
  80193a:	e8 5d fc ff ff       	call   80159c <syscall>
  80193f:	83 c4 18             	add    $0x18,%esp
}
  801942:	c9                   	leave  
  801943:	c3                   	ret    

00801944 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 20                	push   $0x20
  801953:	e8 44 fc ff ff       	call   80159c <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
}
  80195b:	c9                   	leave  
  80195c:	c3                   	ret    

0080195d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80195d:	55                   	push   %ebp
  80195e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801960:	8b 45 08             	mov    0x8(%ebp),%eax
  801963:	6a 00                	push   $0x0
  801965:	ff 75 14             	pushl  0x14(%ebp)
  801968:	ff 75 10             	pushl  0x10(%ebp)
  80196b:	ff 75 0c             	pushl  0xc(%ebp)
  80196e:	50                   	push   %eax
  80196f:	6a 21                	push   $0x21
  801971:	e8 26 fc ff ff       	call   80159c <syscall>
  801976:	83 c4 18             	add    $0x18,%esp
}
  801979:	c9                   	leave  
  80197a:	c3                   	ret    

0080197b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80197b:	55                   	push   %ebp
  80197c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80197e:	8b 45 08             	mov    0x8(%ebp),%eax
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	50                   	push   %eax
  80198a:	6a 22                	push   $0x22
  80198c:	e8 0b fc ff ff       	call   80159c <syscall>
  801991:	83 c4 18             	add    $0x18,%esp
}
  801994:	90                   	nop
  801995:	c9                   	leave  
  801996:	c3                   	ret    

00801997 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801997:	55                   	push   %ebp
  801998:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80199a:	8b 45 08             	mov    0x8(%ebp),%eax
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	50                   	push   %eax
  8019a6:	6a 23                	push   $0x23
  8019a8:	e8 ef fb ff ff       	call   80159c <syscall>
  8019ad:	83 c4 18             	add    $0x18,%esp
}
  8019b0:	90                   	nop
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
  8019b6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8019b9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019bc:	8d 50 04             	lea    0x4(%eax),%edx
  8019bf:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	52                   	push   %edx
  8019c9:	50                   	push   %eax
  8019ca:	6a 24                	push   $0x24
  8019cc:	e8 cb fb ff ff       	call   80159c <syscall>
  8019d1:	83 c4 18             	add    $0x18,%esp
	return result;
  8019d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019da:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019dd:	89 01                	mov    %eax,(%ecx)
  8019df:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8019e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e5:	c9                   	leave  
  8019e6:	c2 04 00             	ret    $0x4

008019e9 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019e9:	55                   	push   %ebp
  8019ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	ff 75 10             	pushl  0x10(%ebp)
  8019f3:	ff 75 0c             	pushl  0xc(%ebp)
  8019f6:	ff 75 08             	pushl  0x8(%ebp)
  8019f9:	6a 13                	push   $0x13
  8019fb:	e8 9c fb ff ff       	call   80159c <syscall>
  801a00:	83 c4 18             	add    $0x18,%esp
	return ;
  801a03:	90                   	nop
}
  801a04:	c9                   	leave  
  801a05:	c3                   	ret    

00801a06 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a06:	55                   	push   %ebp
  801a07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 25                	push   $0x25
  801a15:	e8 82 fb ff ff       	call   80159c <syscall>
  801a1a:	83 c4 18             	add    $0x18,%esp
}
  801a1d:	c9                   	leave  
  801a1e:	c3                   	ret    

00801a1f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a1f:	55                   	push   %ebp
  801a20:	89 e5                	mov    %esp,%ebp
  801a22:	83 ec 04             	sub    $0x4,%esp
  801a25:	8b 45 08             	mov    0x8(%ebp),%eax
  801a28:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a2b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 00                	push   $0x0
  801a35:	6a 00                	push   $0x0
  801a37:	50                   	push   %eax
  801a38:	6a 26                	push   $0x26
  801a3a:	e8 5d fb ff ff       	call   80159c <syscall>
  801a3f:	83 c4 18             	add    $0x18,%esp
	return ;
  801a42:	90                   	nop
}
  801a43:	c9                   	leave  
  801a44:	c3                   	ret    

00801a45 <rsttst>:
void rsttst()
{
  801a45:	55                   	push   %ebp
  801a46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 28                	push   $0x28
  801a54:	e8 43 fb ff ff       	call   80159c <syscall>
  801a59:	83 c4 18             	add    $0x18,%esp
	return ;
  801a5c:	90                   	nop
}
  801a5d:	c9                   	leave  
  801a5e:	c3                   	ret    

00801a5f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a5f:	55                   	push   %ebp
  801a60:	89 e5                	mov    %esp,%ebp
  801a62:	83 ec 04             	sub    $0x4,%esp
  801a65:	8b 45 14             	mov    0x14(%ebp),%eax
  801a68:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a6b:	8b 55 18             	mov    0x18(%ebp),%edx
  801a6e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a72:	52                   	push   %edx
  801a73:	50                   	push   %eax
  801a74:	ff 75 10             	pushl  0x10(%ebp)
  801a77:	ff 75 0c             	pushl  0xc(%ebp)
  801a7a:	ff 75 08             	pushl  0x8(%ebp)
  801a7d:	6a 27                	push   $0x27
  801a7f:	e8 18 fb ff ff       	call   80159c <syscall>
  801a84:	83 c4 18             	add    $0x18,%esp
	return ;
  801a87:	90                   	nop
}
  801a88:	c9                   	leave  
  801a89:	c3                   	ret    

00801a8a <chktst>:
void chktst(uint32 n)
{
  801a8a:	55                   	push   %ebp
  801a8b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	ff 75 08             	pushl  0x8(%ebp)
  801a98:	6a 29                	push   $0x29
  801a9a:	e8 fd fa ff ff       	call   80159c <syscall>
  801a9f:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa2:	90                   	nop
}
  801aa3:	c9                   	leave  
  801aa4:	c3                   	ret    

00801aa5 <inctst>:

void inctst()
{
  801aa5:	55                   	push   %ebp
  801aa6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 2a                	push   $0x2a
  801ab4:	e8 e3 fa ff ff       	call   80159c <syscall>
  801ab9:	83 c4 18             	add    $0x18,%esp
	return ;
  801abc:	90                   	nop
}
  801abd:	c9                   	leave  
  801abe:	c3                   	ret    

00801abf <gettst>:
uint32 gettst()
{
  801abf:	55                   	push   %ebp
  801ac0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 2b                	push   $0x2b
  801ace:	e8 c9 fa ff ff       	call   80159c <syscall>
  801ad3:	83 c4 18             	add    $0x18,%esp
}
  801ad6:	c9                   	leave  
  801ad7:	c3                   	ret    

00801ad8 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ad8:	55                   	push   %ebp
  801ad9:	89 e5                	mov    %esp,%ebp
  801adb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 2c                	push   $0x2c
  801aea:	e8 ad fa ff ff       	call   80159c <syscall>
  801aef:	83 c4 18             	add    $0x18,%esp
  801af2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801af5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801af9:	75 07                	jne    801b02 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801afb:	b8 01 00 00 00       	mov    $0x1,%eax
  801b00:	eb 05                	jmp    801b07 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b02:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b07:	c9                   	leave  
  801b08:	c3                   	ret    

00801b09 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b09:	55                   	push   %ebp
  801b0a:	89 e5                	mov    %esp,%ebp
  801b0c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 2c                	push   $0x2c
  801b1b:	e8 7c fa ff ff       	call   80159c <syscall>
  801b20:	83 c4 18             	add    $0x18,%esp
  801b23:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b26:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b2a:	75 07                	jne    801b33 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b2c:	b8 01 00 00 00       	mov    $0x1,%eax
  801b31:	eb 05                	jmp    801b38 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b33:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b38:	c9                   	leave  
  801b39:	c3                   	ret    

00801b3a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b3a:	55                   	push   %ebp
  801b3b:	89 e5                	mov    %esp,%ebp
  801b3d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 2c                	push   $0x2c
  801b4c:	e8 4b fa ff ff       	call   80159c <syscall>
  801b51:	83 c4 18             	add    $0x18,%esp
  801b54:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b57:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b5b:	75 07                	jne    801b64 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b5d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b62:	eb 05                	jmp    801b69 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b64:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b69:	c9                   	leave  
  801b6a:	c3                   	ret    

00801b6b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b6b:	55                   	push   %ebp
  801b6c:	89 e5                	mov    %esp,%ebp
  801b6e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 2c                	push   $0x2c
  801b7d:	e8 1a fa ff ff       	call   80159c <syscall>
  801b82:	83 c4 18             	add    $0x18,%esp
  801b85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b88:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b8c:	75 07                	jne    801b95 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b93:	eb 05                	jmp    801b9a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b95:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b9a:	c9                   	leave  
  801b9b:	c3                   	ret    

00801b9c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b9c:	55                   	push   %ebp
  801b9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	ff 75 08             	pushl  0x8(%ebp)
  801baa:	6a 2d                	push   $0x2d
  801bac:	e8 eb f9 ff ff       	call   80159c <syscall>
  801bb1:	83 c4 18             	add    $0x18,%esp
	return ;
  801bb4:	90                   	nop
}
  801bb5:	c9                   	leave  
  801bb6:	c3                   	ret    

00801bb7 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
  801bba:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801bbb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bbe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bc1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc7:	6a 00                	push   $0x0
  801bc9:	53                   	push   %ebx
  801bca:	51                   	push   %ecx
  801bcb:	52                   	push   %edx
  801bcc:	50                   	push   %eax
  801bcd:	6a 2e                	push   $0x2e
  801bcf:	e8 c8 f9 ff ff       	call   80159c <syscall>
  801bd4:	83 c4 18             	add    $0x18,%esp
}
  801bd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801bda:	c9                   	leave  
  801bdb:	c3                   	ret    

00801bdc <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801bdc:	55                   	push   %ebp
  801bdd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801bdf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be2:	8b 45 08             	mov    0x8(%ebp),%eax
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	52                   	push   %edx
  801bec:	50                   	push   %eax
  801bed:	6a 2f                	push   $0x2f
  801bef:	e8 a8 f9 ff ff       	call   80159c <syscall>
  801bf4:	83 c4 18             	add    $0x18,%esp
}
  801bf7:	c9                   	leave  
  801bf8:	c3                   	ret    
  801bf9:	66 90                	xchg   %ax,%ax
  801bfb:	90                   	nop

00801bfc <__udivdi3>:
  801bfc:	55                   	push   %ebp
  801bfd:	57                   	push   %edi
  801bfe:	56                   	push   %esi
  801bff:	53                   	push   %ebx
  801c00:	83 ec 1c             	sub    $0x1c,%esp
  801c03:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c07:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c0f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c13:	89 ca                	mov    %ecx,%edx
  801c15:	89 f8                	mov    %edi,%eax
  801c17:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c1b:	85 f6                	test   %esi,%esi
  801c1d:	75 2d                	jne    801c4c <__udivdi3+0x50>
  801c1f:	39 cf                	cmp    %ecx,%edi
  801c21:	77 65                	ja     801c88 <__udivdi3+0x8c>
  801c23:	89 fd                	mov    %edi,%ebp
  801c25:	85 ff                	test   %edi,%edi
  801c27:	75 0b                	jne    801c34 <__udivdi3+0x38>
  801c29:	b8 01 00 00 00       	mov    $0x1,%eax
  801c2e:	31 d2                	xor    %edx,%edx
  801c30:	f7 f7                	div    %edi
  801c32:	89 c5                	mov    %eax,%ebp
  801c34:	31 d2                	xor    %edx,%edx
  801c36:	89 c8                	mov    %ecx,%eax
  801c38:	f7 f5                	div    %ebp
  801c3a:	89 c1                	mov    %eax,%ecx
  801c3c:	89 d8                	mov    %ebx,%eax
  801c3e:	f7 f5                	div    %ebp
  801c40:	89 cf                	mov    %ecx,%edi
  801c42:	89 fa                	mov    %edi,%edx
  801c44:	83 c4 1c             	add    $0x1c,%esp
  801c47:	5b                   	pop    %ebx
  801c48:	5e                   	pop    %esi
  801c49:	5f                   	pop    %edi
  801c4a:	5d                   	pop    %ebp
  801c4b:	c3                   	ret    
  801c4c:	39 ce                	cmp    %ecx,%esi
  801c4e:	77 28                	ja     801c78 <__udivdi3+0x7c>
  801c50:	0f bd fe             	bsr    %esi,%edi
  801c53:	83 f7 1f             	xor    $0x1f,%edi
  801c56:	75 40                	jne    801c98 <__udivdi3+0x9c>
  801c58:	39 ce                	cmp    %ecx,%esi
  801c5a:	72 0a                	jb     801c66 <__udivdi3+0x6a>
  801c5c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c60:	0f 87 9e 00 00 00    	ja     801d04 <__udivdi3+0x108>
  801c66:	b8 01 00 00 00       	mov    $0x1,%eax
  801c6b:	89 fa                	mov    %edi,%edx
  801c6d:	83 c4 1c             	add    $0x1c,%esp
  801c70:	5b                   	pop    %ebx
  801c71:	5e                   	pop    %esi
  801c72:	5f                   	pop    %edi
  801c73:	5d                   	pop    %ebp
  801c74:	c3                   	ret    
  801c75:	8d 76 00             	lea    0x0(%esi),%esi
  801c78:	31 ff                	xor    %edi,%edi
  801c7a:	31 c0                	xor    %eax,%eax
  801c7c:	89 fa                	mov    %edi,%edx
  801c7e:	83 c4 1c             	add    $0x1c,%esp
  801c81:	5b                   	pop    %ebx
  801c82:	5e                   	pop    %esi
  801c83:	5f                   	pop    %edi
  801c84:	5d                   	pop    %ebp
  801c85:	c3                   	ret    
  801c86:	66 90                	xchg   %ax,%ax
  801c88:	89 d8                	mov    %ebx,%eax
  801c8a:	f7 f7                	div    %edi
  801c8c:	31 ff                	xor    %edi,%edi
  801c8e:	89 fa                	mov    %edi,%edx
  801c90:	83 c4 1c             	add    $0x1c,%esp
  801c93:	5b                   	pop    %ebx
  801c94:	5e                   	pop    %esi
  801c95:	5f                   	pop    %edi
  801c96:	5d                   	pop    %ebp
  801c97:	c3                   	ret    
  801c98:	bd 20 00 00 00       	mov    $0x20,%ebp
  801c9d:	89 eb                	mov    %ebp,%ebx
  801c9f:	29 fb                	sub    %edi,%ebx
  801ca1:	89 f9                	mov    %edi,%ecx
  801ca3:	d3 e6                	shl    %cl,%esi
  801ca5:	89 c5                	mov    %eax,%ebp
  801ca7:	88 d9                	mov    %bl,%cl
  801ca9:	d3 ed                	shr    %cl,%ebp
  801cab:	89 e9                	mov    %ebp,%ecx
  801cad:	09 f1                	or     %esi,%ecx
  801caf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801cb3:	89 f9                	mov    %edi,%ecx
  801cb5:	d3 e0                	shl    %cl,%eax
  801cb7:	89 c5                	mov    %eax,%ebp
  801cb9:	89 d6                	mov    %edx,%esi
  801cbb:	88 d9                	mov    %bl,%cl
  801cbd:	d3 ee                	shr    %cl,%esi
  801cbf:	89 f9                	mov    %edi,%ecx
  801cc1:	d3 e2                	shl    %cl,%edx
  801cc3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cc7:	88 d9                	mov    %bl,%cl
  801cc9:	d3 e8                	shr    %cl,%eax
  801ccb:	09 c2                	or     %eax,%edx
  801ccd:	89 d0                	mov    %edx,%eax
  801ccf:	89 f2                	mov    %esi,%edx
  801cd1:	f7 74 24 0c          	divl   0xc(%esp)
  801cd5:	89 d6                	mov    %edx,%esi
  801cd7:	89 c3                	mov    %eax,%ebx
  801cd9:	f7 e5                	mul    %ebp
  801cdb:	39 d6                	cmp    %edx,%esi
  801cdd:	72 19                	jb     801cf8 <__udivdi3+0xfc>
  801cdf:	74 0b                	je     801cec <__udivdi3+0xf0>
  801ce1:	89 d8                	mov    %ebx,%eax
  801ce3:	31 ff                	xor    %edi,%edi
  801ce5:	e9 58 ff ff ff       	jmp    801c42 <__udivdi3+0x46>
  801cea:	66 90                	xchg   %ax,%ax
  801cec:	8b 54 24 08          	mov    0x8(%esp),%edx
  801cf0:	89 f9                	mov    %edi,%ecx
  801cf2:	d3 e2                	shl    %cl,%edx
  801cf4:	39 c2                	cmp    %eax,%edx
  801cf6:	73 e9                	jae    801ce1 <__udivdi3+0xe5>
  801cf8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801cfb:	31 ff                	xor    %edi,%edi
  801cfd:	e9 40 ff ff ff       	jmp    801c42 <__udivdi3+0x46>
  801d02:	66 90                	xchg   %ax,%ax
  801d04:	31 c0                	xor    %eax,%eax
  801d06:	e9 37 ff ff ff       	jmp    801c42 <__udivdi3+0x46>
  801d0b:	90                   	nop

00801d0c <__umoddi3>:
  801d0c:	55                   	push   %ebp
  801d0d:	57                   	push   %edi
  801d0e:	56                   	push   %esi
  801d0f:	53                   	push   %ebx
  801d10:	83 ec 1c             	sub    $0x1c,%esp
  801d13:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d17:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d1f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d23:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d27:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d2b:	89 f3                	mov    %esi,%ebx
  801d2d:	89 fa                	mov    %edi,%edx
  801d2f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d33:	89 34 24             	mov    %esi,(%esp)
  801d36:	85 c0                	test   %eax,%eax
  801d38:	75 1a                	jne    801d54 <__umoddi3+0x48>
  801d3a:	39 f7                	cmp    %esi,%edi
  801d3c:	0f 86 a2 00 00 00    	jbe    801de4 <__umoddi3+0xd8>
  801d42:	89 c8                	mov    %ecx,%eax
  801d44:	89 f2                	mov    %esi,%edx
  801d46:	f7 f7                	div    %edi
  801d48:	89 d0                	mov    %edx,%eax
  801d4a:	31 d2                	xor    %edx,%edx
  801d4c:	83 c4 1c             	add    $0x1c,%esp
  801d4f:	5b                   	pop    %ebx
  801d50:	5e                   	pop    %esi
  801d51:	5f                   	pop    %edi
  801d52:	5d                   	pop    %ebp
  801d53:	c3                   	ret    
  801d54:	39 f0                	cmp    %esi,%eax
  801d56:	0f 87 ac 00 00 00    	ja     801e08 <__umoddi3+0xfc>
  801d5c:	0f bd e8             	bsr    %eax,%ebp
  801d5f:	83 f5 1f             	xor    $0x1f,%ebp
  801d62:	0f 84 ac 00 00 00    	je     801e14 <__umoddi3+0x108>
  801d68:	bf 20 00 00 00       	mov    $0x20,%edi
  801d6d:	29 ef                	sub    %ebp,%edi
  801d6f:	89 fe                	mov    %edi,%esi
  801d71:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d75:	89 e9                	mov    %ebp,%ecx
  801d77:	d3 e0                	shl    %cl,%eax
  801d79:	89 d7                	mov    %edx,%edi
  801d7b:	89 f1                	mov    %esi,%ecx
  801d7d:	d3 ef                	shr    %cl,%edi
  801d7f:	09 c7                	or     %eax,%edi
  801d81:	89 e9                	mov    %ebp,%ecx
  801d83:	d3 e2                	shl    %cl,%edx
  801d85:	89 14 24             	mov    %edx,(%esp)
  801d88:	89 d8                	mov    %ebx,%eax
  801d8a:	d3 e0                	shl    %cl,%eax
  801d8c:	89 c2                	mov    %eax,%edx
  801d8e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d92:	d3 e0                	shl    %cl,%eax
  801d94:	89 44 24 04          	mov    %eax,0x4(%esp)
  801d98:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d9c:	89 f1                	mov    %esi,%ecx
  801d9e:	d3 e8                	shr    %cl,%eax
  801da0:	09 d0                	or     %edx,%eax
  801da2:	d3 eb                	shr    %cl,%ebx
  801da4:	89 da                	mov    %ebx,%edx
  801da6:	f7 f7                	div    %edi
  801da8:	89 d3                	mov    %edx,%ebx
  801daa:	f7 24 24             	mull   (%esp)
  801dad:	89 c6                	mov    %eax,%esi
  801daf:	89 d1                	mov    %edx,%ecx
  801db1:	39 d3                	cmp    %edx,%ebx
  801db3:	0f 82 87 00 00 00    	jb     801e40 <__umoddi3+0x134>
  801db9:	0f 84 91 00 00 00    	je     801e50 <__umoddi3+0x144>
  801dbf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801dc3:	29 f2                	sub    %esi,%edx
  801dc5:	19 cb                	sbb    %ecx,%ebx
  801dc7:	89 d8                	mov    %ebx,%eax
  801dc9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801dcd:	d3 e0                	shl    %cl,%eax
  801dcf:	89 e9                	mov    %ebp,%ecx
  801dd1:	d3 ea                	shr    %cl,%edx
  801dd3:	09 d0                	or     %edx,%eax
  801dd5:	89 e9                	mov    %ebp,%ecx
  801dd7:	d3 eb                	shr    %cl,%ebx
  801dd9:	89 da                	mov    %ebx,%edx
  801ddb:	83 c4 1c             	add    $0x1c,%esp
  801dde:	5b                   	pop    %ebx
  801ddf:	5e                   	pop    %esi
  801de0:	5f                   	pop    %edi
  801de1:	5d                   	pop    %ebp
  801de2:	c3                   	ret    
  801de3:	90                   	nop
  801de4:	89 fd                	mov    %edi,%ebp
  801de6:	85 ff                	test   %edi,%edi
  801de8:	75 0b                	jne    801df5 <__umoddi3+0xe9>
  801dea:	b8 01 00 00 00       	mov    $0x1,%eax
  801def:	31 d2                	xor    %edx,%edx
  801df1:	f7 f7                	div    %edi
  801df3:	89 c5                	mov    %eax,%ebp
  801df5:	89 f0                	mov    %esi,%eax
  801df7:	31 d2                	xor    %edx,%edx
  801df9:	f7 f5                	div    %ebp
  801dfb:	89 c8                	mov    %ecx,%eax
  801dfd:	f7 f5                	div    %ebp
  801dff:	89 d0                	mov    %edx,%eax
  801e01:	e9 44 ff ff ff       	jmp    801d4a <__umoddi3+0x3e>
  801e06:	66 90                	xchg   %ax,%ax
  801e08:	89 c8                	mov    %ecx,%eax
  801e0a:	89 f2                	mov    %esi,%edx
  801e0c:	83 c4 1c             	add    $0x1c,%esp
  801e0f:	5b                   	pop    %ebx
  801e10:	5e                   	pop    %esi
  801e11:	5f                   	pop    %edi
  801e12:	5d                   	pop    %ebp
  801e13:	c3                   	ret    
  801e14:	3b 04 24             	cmp    (%esp),%eax
  801e17:	72 06                	jb     801e1f <__umoddi3+0x113>
  801e19:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e1d:	77 0f                	ja     801e2e <__umoddi3+0x122>
  801e1f:	89 f2                	mov    %esi,%edx
  801e21:	29 f9                	sub    %edi,%ecx
  801e23:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e27:	89 14 24             	mov    %edx,(%esp)
  801e2a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e2e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e32:	8b 14 24             	mov    (%esp),%edx
  801e35:	83 c4 1c             	add    $0x1c,%esp
  801e38:	5b                   	pop    %ebx
  801e39:	5e                   	pop    %esi
  801e3a:	5f                   	pop    %edi
  801e3b:	5d                   	pop    %ebp
  801e3c:	c3                   	ret    
  801e3d:	8d 76 00             	lea    0x0(%esi),%esi
  801e40:	2b 04 24             	sub    (%esp),%eax
  801e43:	19 fa                	sbb    %edi,%edx
  801e45:	89 d1                	mov    %edx,%ecx
  801e47:	89 c6                	mov    %eax,%esi
  801e49:	e9 71 ff ff ff       	jmp    801dbf <__umoddi3+0xb3>
  801e4e:	66 90                	xchg   %ax,%ax
  801e50:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e54:	72 ea                	jb     801e40 <__umoddi3+0x134>
  801e56:	89 d9                	mov    %ebx,%ecx
  801e58:	e9 62 ff ff ff       	jmp    801dbf <__umoddi3+0xb3>
