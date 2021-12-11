
obj/user/tst_best_fit_2:     file format elf32-i386


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
  800031:	e8 9f 08 00 00       	call   8008d5 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 02                	push   $0x2
  800045:	e8 ec 20 00 00       	call   802136 <sys_set_uheap_strategy>
  80004a:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80004d:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800051:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800058:	eb 23                	jmp    80007d <_main+0x45>
		{
			if (myEnv->__uptr_pws[i].empty)
  80005a:	a1 20 30 80 00       	mov    0x803020,%eax
  80005f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800065:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800068:	c1 e2 04             	shl    $0x4,%edx
  80006b:	01 d0                	add    %edx,%eax
  80006d:	8a 40 04             	mov    0x4(%eax),%al
  800070:	84 c0                	test   %al,%al
  800072:	74 06                	je     80007a <_main+0x42>
			{
				fullWS = 0;
  800074:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800078:	eb 12                	jmp    80008c <_main+0x54>
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80007a:	ff 45 f0             	incl   -0x10(%ebp)
  80007d:	a1 20 30 80 00       	mov    0x803020,%eax
  800082:	8b 50 74             	mov    0x74(%eax),%edx
  800085:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800088:	39 c2                	cmp    %eax,%edx
  80008a:	77 ce                	ja     80005a <_main+0x22>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80008c:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800090:	74 14                	je     8000a6 <_main+0x6e>
  800092:	83 ec 04             	sub    $0x4,%esp
  800095:	68 00 24 80 00       	push   $0x802400
  80009a:	6a 1b                	push   $0x1b
  80009c:	68 1c 24 80 00       	push   $0x80241c
  8000a1:	e8 74 09 00 00       	call   800a1a <_panic>
	}

	int Mega = 1024*1024;
  8000a6:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000ad:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	void* ptr_allocations[20] = {0};
  8000b4:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000b7:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c1:	89 d7                	mov    %edx,%edi
  8000c3:	f3 ab                	rep stos %eax,%es:(%edi)

	//[1] Attempt to allocate more than heap size
	{
		ptr_allocations[0] = malloc(USER_HEAP_MAX - USER_HEAP_START + 1);
  8000c5:	83 ec 0c             	sub    $0xc,%esp
  8000c8:	68 01 00 00 20       	push   $0x20000001
  8000cd:	e8 74 19 00 00       	call   801a46 <malloc>
  8000d2:	83 c4 10             	add    $0x10,%esp
  8000d5:	89 45 90             	mov    %eax,-0x70(%ebp)
		if (ptr_allocations[0] != NULL) panic("Malloc: Attempt to allocate more than heap size, should return NULL");
  8000d8:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000db:	85 c0                	test   %eax,%eax
  8000dd:	74 14                	je     8000f3 <_main+0xbb>
  8000df:	83 ec 04             	sub    $0x4,%esp
  8000e2:	68 34 24 80 00       	push   $0x802434
  8000e7:	6a 25                	push   $0x25
  8000e9:	68 1c 24 80 00       	push   $0x80241c
  8000ee:	e8 27 09 00 00       	call   800a1a <_panic>
	}
	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  8000f3:	e8 aa 1b 00 00       	call   801ca2 <sys_calculate_free_frames>
  8000f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  8000fb:	e8 25 1c 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800100:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  800103:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800106:	01 c0                	add    %eax,%eax
  800108:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	50                   	push   %eax
  80010f:	e8 32 19 00 00       	call   801a46 <malloc>
  800114:	83 c4 10             	add    $0x10,%esp
  800117:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START) ) panic("Wrong start address for the allocated space... ");
  80011a:	8b 45 90             	mov    -0x70(%ebp),%eax
  80011d:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800122:	74 14                	je     800138 <_main+0x100>
  800124:	83 ec 04             	sub    $0x4,%esp
  800127:	68 78 24 80 00       	push   $0x802478
  80012c:	6a 2e                	push   $0x2e
  80012e:	68 1c 24 80 00       	push   $0x80241c
  800133:	e8 e2 08 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  800138:	e8 e8 1b 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  80013d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800140:	3d 00 02 00 00       	cmp    $0x200,%eax
  800145:	74 14                	je     80015b <_main+0x123>
  800147:	83 ec 04             	sub    $0x4,%esp
  80014a:	68 a8 24 80 00       	push   $0x8024a8
  80014f:	6a 30                	push   $0x30
  800151:	68 1c 24 80 00       	push   $0x80241c
  800156:	e8 bf 08 00 00       	call   800a1a <_panic>

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  80015b:	e8 42 1b 00 00       	call   801ca2 <sys_calculate_free_frames>
  800160:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800163:	e8 bd 1b 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800168:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80016b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80016e:	01 c0                	add    %eax,%eax
  800170:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800173:	83 ec 0c             	sub    $0xc,%esp
  800176:	50                   	push   %eax
  800177:	e8 ca 18 00 00       	call   801a46 <malloc>
  80017c:	83 c4 10             	add    $0x10,%esp
  80017f:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  800182:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800185:	89 c2                	mov    %eax,%edx
  800187:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018a:	01 c0                	add    %eax,%eax
  80018c:	05 00 00 00 80       	add    $0x80000000,%eax
  800191:	39 c2                	cmp    %eax,%edx
  800193:	74 14                	je     8001a9 <_main+0x171>
  800195:	83 ec 04             	sub    $0x4,%esp
  800198:	68 78 24 80 00       	push   $0x802478
  80019d:	6a 36                	push   $0x36
  80019f:	68 1c 24 80 00       	push   $0x80241c
  8001a4:	e8 71 08 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8001a9:	e8 77 1b 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8001ae:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b1:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001b6:	74 14                	je     8001cc <_main+0x194>
  8001b8:	83 ec 04             	sub    $0x4,%esp
  8001bb:	68 a8 24 80 00       	push   $0x8024a8
  8001c0:	6a 38                	push   $0x38
  8001c2:	68 1c 24 80 00       	push   $0x80241c
  8001c7:	e8 4e 08 00 00       	call   800a1a <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8001cc:	e8 d1 1a 00 00       	call   801ca2 <sys_calculate_free_frames>
  8001d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001d4:	e8 4c 1b 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8001d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  8001dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001df:	01 c0                	add    %eax,%eax
  8001e1:	83 ec 0c             	sub    $0xc,%esp
  8001e4:	50                   	push   %eax
  8001e5:	e8 5c 18 00 00       	call   801a46 <malloc>
  8001ea:	83 c4 10             	add    $0x10,%esp
  8001ed:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  8001f0:	8b 45 98             	mov    -0x68(%ebp),%eax
  8001f3:	89 c2                	mov    %eax,%edx
  8001f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001f8:	c1 e0 02             	shl    $0x2,%eax
  8001fb:	05 00 00 00 80       	add    $0x80000000,%eax
  800200:	39 c2                	cmp    %eax,%edx
  800202:	74 14                	je     800218 <_main+0x1e0>
  800204:	83 ec 04             	sub    $0x4,%esp
  800207:	68 78 24 80 00       	push   $0x802478
  80020c:	6a 3e                	push   $0x3e
  80020e:	68 1c 24 80 00       	push   $0x80241c
  800213:	e8 02 08 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  800218:	e8 08 1b 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  80021d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800220:	83 f8 01             	cmp    $0x1,%eax
  800223:	74 14                	je     800239 <_main+0x201>
  800225:	83 ec 04             	sub    $0x4,%esp
  800228:	68 a8 24 80 00       	push   $0x8024a8
  80022d:	6a 40                	push   $0x40
  80022f:	68 1c 24 80 00       	push   $0x80241c
  800234:	e8 e1 07 00 00       	call   800a1a <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  800239:	e8 64 1a 00 00       	call   801ca2 <sys_calculate_free_frames>
  80023e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800241:	e8 df 1a 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800246:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  800249:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80024c:	01 c0                	add    %eax,%eax
  80024e:	83 ec 0c             	sub    $0xc,%esp
  800251:	50                   	push   %eax
  800252:	e8 ef 17 00 00       	call   801a46 <malloc>
  800257:	83 c4 10             	add    $0x10,%esp
  80025a:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 4*Mega + 4*kilo)) panic("Wrong start address for the allocated space... ");
  80025d:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800260:	89 c2                	mov    %eax,%edx
  800262:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800265:	c1 e0 02             	shl    $0x2,%eax
  800268:	89 c1                	mov    %eax,%ecx
  80026a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80026d:	c1 e0 02             	shl    $0x2,%eax
  800270:	01 c8                	add    %ecx,%eax
  800272:	05 00 00 00 80       	add    $0x80000000,%eax
  800277:	39 c2                	cmp    %eax,%edx
  800279:	74 14                	je     80028f <_main+0x257>
  80027b:	83 ec 04             	sub    $0x4,%esp
  80027e:	68 78 24 80 00       	push   $0x802478
  800283:	6a 46                	push   $0x46
  800285:	68 1c 24 80 00       	push   $0x80241c
  80028a:	e8 8b 07 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  80028f:	e8 91 1a 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800294:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800297:	83 f8 01             	cmp    $0x1,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 a8 24 80 00       	push   $0x8024a8
  8002a4:	6a 48                	push   $0x48
  8002a6:	68 1c 24 80 00       	push   $0x80241c
  8002ab:	e8 6a 07 00 00       	call   800a1a <_panic>

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002b0:	e8 ed 19 00 00       	call   801ca2 <sys_calculate_free_frames>
  8002b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8002b8:	e8 68 1a 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8002bd:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8002c0:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002c3:	83 ec 0c             	sub    $0xc,%esp
  8002c6:	50                   	push   %eax
  8002c7:	e8 94 17 00 00       	call   801a60 <free>
  8002cc:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1) panic("Wrong free: ");
		if( (usedDiskPages-sys_pf_calculate_allocated_pages()) !=  1) panic("Wrong page file free: ");
  8002cf:	e8 51 1a 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8002d4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002d7:	29 c2                	sub    %eax,%edx
  8002d9:	89 d0                	mov    %edx,%eax
  8002db:	83 f8 01             	cmp    $0x1,%eax
  8002de:	74 14                	je     8002f4 <_main+0x2bc>
  8002e0:	83 ec 04             	sub    $0x4,%esp
  8002e3:	68 c5 24 80 00       	push   $0x8024c5
  8002e8:	6a 4f                	push   $0x4f
  8002ea:	68 1c 24 80 00       	push   $0x80241c
  8002ef:	e8 26 07 00 00       	call   800a1a <_panic>

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  8002f4:	e8 a9 19 00 00       	call   801ca2 <sys_calculate_free_frames>
  8002f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8002fc:	e8 24 1a 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800301:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800304:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800307:	89 d0                	mov    %edx,%eax
  800309:	01 c0                	add    %eax,%eax
  80030b:	01 d0                	add    %edx,%eax
  80030d:	01 c0                	add    %eax,%eax
  80030f:	01 d0                	add    %edx,%eax
  800311:	83 ec 0c             	sub    $0xc,%esp
  800314:	50                   	push   %eax
  800315:	e8 2c 17 00 00       	call   801a46 <malloc>
  80031a:	83 c4 10             	add    $0x10,%esp
  80031d:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega + 8*kilo)) panic("Wrong start address for the allocated space... ");
  800320:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800323:	89 c2                	mov    %eax,%edx
  800325:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800328:	c1 e0 02             	shl    $0x2,%eax
  80032b:	89 c1                	mov    %eax,%ecx
  80032d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800330:	c1 e0 03             	shl    $0x3,%eax
  800333:	01 c8                	add    %ecx,%eax
  800335:	05 00 00 00 80       	add    $0x80000000,%eax
  80033a:	39 c2                	cmp    %eax,%edx
  80033c:	74 14                	je     800352 <_main+0x31a>
  80033e:	83 ec 04             	sub    $0x4,%esp
  800341:	68 78 24 80 00       	push   $0x802478
  800346:	6a 55                	push   $0x55
  800348:	68 1c 24 80 00       	push   $0x80241c
  80034d:	e8 c8 06 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  800352:	e8 ce 19 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800357:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80035a:	83 f8 02             	cmp    $0x2,%eax
  80035d:	74 14                	je     800373 <_main+0x33b>
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	68 a8 24 80 00       	push   $0x8024a8
  800367:	6a 57                	push   $0x57
  800369:	68 1c 24 80 00       	push   $0x80241c
  80036e:	e8 a7 06 00 00       	call   800a1a <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800373:	e8 2a 19 00 00       	call   801ca2 <sys_calculate_free_frames>
  800378:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80037b:	e8 a5 19 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800380:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[0]);
  800383:	8b 45 90             	mov    -0x70(%ebp),%eax
  800386:	83 ec 0c             	sub    $0xc,%esp
  800389:	50                   	push   %eax
  80038a:	e8 d1 16 00 00       	call   801a60 <free>
  80038f:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800392:	e8 8e 19 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800397:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80039a:	29 c2                	sub    %eax,%edx
  80039c:	89 d0                	mov    %edx,%eax
  80039e:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003a3:	74 14                	je     8003b9 <_main+0x381>
  8003a5:	83 ec 04             	sub    $0x4,%esp
  8003a8:	68 c5 24 80 00       	push   $0x8024c5
  8003ad:	6a 5e                	push   $0x5e
  8003af:	68 1c 24 80 00       	push   $0x80241c
  8003b4:	e8 61 06 00 00       	call   800a1a <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003b9:	e8 e4 18 00 00       	call   801ca2 <sys_calculate_free_frames>
  8003be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c1:	e8 5f 19 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8003c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8003c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003cc:	89 c2                	mov    %eax,%edx
  8003ce:	01 d2                	add    %edx,%edx
  8003d0:	01 d0                	add    %edx,%eax
  8003d2:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003d5:	83 ec 0c             	sub    $0xc,%esp
  8003d8:	50                   	push   %eax
  8003d9:	e8 68 16 00 00       	call   801a46 <malloc>
  8003de:	83 c4 10             	add    $0x10,%esp
  8003e1:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  8003e4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003e7:	89 c2                	mov    %eax,%edx
  8003e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003ec:	c1 e0 02             	shl    $0x2,%eax
  8003ef:	89 c1                	mov    %eax,%ecx
  8003f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003f4:	c1 e0 04             	shl    $0x4,%eax
  8003f7:	01 c8                	add    %ecx,%eax
  8003f9:	05 00 00 00 80       	add    $0x80000000,%eax
  8003fe:	39 c2                	cmp    %eax,%edx
  800400:	74 14                	je     800416 <_main+0x3de>
  800402:	83 ec 04             	sub    $0x4,%esp
  800405:	68 78 24 80 00       	push   $0x802478
  80040a:	6a 64                	push   $0x64
  80040c:	68 1c 24 80 00       	push   $0x80241c
  800411:	e8 04 06 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  800416:	e8 0a 19 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  80041b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80041e:	89 c2                	mov    %eax,%edx
  800420:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800423:	89 c1                	mov    %eax,%ecx
  800425:	01 c9                	add    %ecx,%ecx
  800427:	01 c8                	add    %ecx,%eax
  800429:	85 c0                	test   %eax,%eax
  80042b:	79 05                	jns    800432 <_main+0x3fa>
  80042d:	05 ff 0f 00 00       	add    $0xfff,%eax
  800432:	c1 f8 0c             	sar    $0xc,%eax
  800435:	39 c2                	cmp    %eax,%edx
  800437:	74 14                	je     80044d <_main+0x415>
  800439:	83 ec 04             	sub    $0x4,%esp
  80043c:	68 a8 24 80 00       	push   $0x8024a8
  800441:	6a 66                	push   $0x66
  800443:	68 1c 24 80 00       	push   $0x80241c
  800448:	e8 cd 05 00 00       	call   800a1a <_panic>

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  80044d:	e8 50 18 00 00       	call   801ca2 <sys_calculate_free_frames>
  800452:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800455:	e8 cb 18 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  80045a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(2*Mega + 6*kilo);
  80045d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800460:	89 c2                	mov    %eax,%edx
  800462:	01 d2                	add    %edx,%edx
  800464:	01 c2                	add    %eax,%edx
  800466:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800469:	01 d0                	add    %edx,%eax
  80046b:	01 c0                	add    %eax,%eax
  80046d:	83 ec 0c             	sub    $0xc,%esp
  800470:	50                   	push   %eax
  800471:	e8 d0 15 00 00       	call   801a46 <malloc>
  800476:	83 c4 10             	add    $0x10,%esp
  800479:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  80047c:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80047f:	89 c1                	mov    %eax,%ecx
  800481:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800484:	89 d0                	mov    %edx,%eax
  800486:	01 c0                	add    %eax,%eax
  800488:	01 d0                	add    %edx,%eax
  80048a:	01 c0                	add    %eax,%eax
  80048c:	01 d0                	add    %edx,%eax
  80048e:	89 c2                	mov    %eax,%edx
  800490:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800493:	c1 e0 04             	shl    $0x4,%eax
  800496:	01 d0                	add    %edx,%eax
  800498:	05 00 00 00 80       	add    $0x80000000,%eax
  80049d:	39 c1                	cmp    %eax,%ecx
  80049f:	74 14                	je     8004b5 <_main+0x47d>
  8004a1:	83 ec 04             	sub    $0x4,%esp
  8004a4:	68 78 24 80 00       	push   $0x802478
  8004a9:	6a 6c                	push   $0x6c
  8004ab:	68 1c 24 80 00       	push   $0x80241c
  8004b0:	e8 65 05 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 514+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  514) panic("Wrong page file allocation: ");
  8004b5:	e8 6b 18 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8004ba:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004bd:	3d 02 02 00 00       	cmp    $0x202,%eax
  8004c2:	74 14                	je     8004d8 <_main+0x4a0>
  8004c4:	83 ec 04             	sub    $0x4,%esp
  8004c7:	68 a8 24 80 00       	push   $0x8024a8
  8004cc:	6a 6e                	push   $0x6e
  8004ce:	68 1c 24 80 00       	push   $0x80241c
  8004d3:	e8 42 05 00 00       	call   800a1a <_panic>

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  8004d8:	e8 c5 17 00 00       	call   801ca2 <sys_calculate_free_frames>
  8004dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e0:	e8 40 18 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8004e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(5*Mega-kilo);
  8004e8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004eb:	89 d0                	mov    %edx,%eax
  8004ed:	c1 e0 02             	shl    $0x2,%eax
  8004f0:	01 d0                	add    %edx,%eax
  8004f2:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8004f5:	83 ec 0c             	sub    $0xc,%esp
  8004f8:	50                   	push   %eax
  8004f9:	e8 48 15 00 00       	call   801a46 <malloc>
  8004fe:	83 c4 10             	add    $0x10,%esp
  800501:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 9*Mega + 24*kilo)) panic("Wrong start address for the allocated space... ");
  800504:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800507:	89 c1                	mov    %eax,%ecx
  800509:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80050c:	89 d0                	mov    %edx,%eax
  80050e:	c1 e0 03             	shl    $0x3,%eax
  800511:	01 d0                	add    %edx,%eax
  800513:	89 c3                	mov    %eax,%ebx
  800515:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800518:	89 d0                	mov    %edx,%eax
  80051a:	01 c0                	add    %eax,%eax
  80051c:	01 d0                	add    %edx,%eax
  80051e:	c1 e0 03             	shl    $0x3,%eax
  800521:	01 d8                	add    %ebx,%eax
  800523:	05 00 00 00 80       	add    $0x80000000,%eax
  800528:	39 c1                	cmp    %eax,%ecx
  80052a:	74 14                	je     800540 <_main+0x508>
  80052c:	83 ec 04             	sub    $0x4,%esp
  80052f:	68 78 24 80 00       	push   $0x802478
  800534:	6a 74                	push   $0x74
  800536:	68 1c 24 80 00       	push   $0x80241c
  80053b:	e8 da 04 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 5*Mega/4096 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/4096) panic("Wrong page file allocation: ");
  800540:	e8 e0 17 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800545:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800548:	89 c1                	mov    %eax,%ecx
  80054a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80054d:	89 d0                	mov    %edx,%eax
  80054f:	c1 e0 02             	shl    $0x2,%eax
  800552:	01 d0                	add    %edx,%eax
  800554:	85 c0                	test   %eax,%eax
  800556:	79 05                	jns    80055d <_main+0x525>
  800558:	05 ff 0f 00 00       	add    $0xfff,%eax
  80055d:	c1 f8 0c             	sar    $0xc,%eax
  800560:	39 c1                	cmp    %eax,%ecx
  800562:	74 14                	je     800578 <_main+0x540>
  800564:	83 ec 04             	sub    $0x4,%esp
  800567:	68 a8 24 80 00       	push   $0x8024a8
  80056c:	6a 76                	push   $0x76
  80056e:	68 1c 24 80 00       	push   $0x80241c
  800573:	e8 a2 04 00 00       	call   800a1a <_panic>

		//2 MB + 8 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  800578:	e8 25 17 00 00       	call   801ca2 <sys_calculate_free_frames>
  80057d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800580:	e8 a0 17 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800585:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[6]);
  800588:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80058b:	83 ec 0c             	sub    $0xc,%esp
  80058e:	50                   	push   %eax
  80058f:	e8 cc 14 00 00       	call   801a60 <free>
  800594:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 514) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  514) panic("Wrong page file free: ");
  800597:	e8 89 17 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  80059c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80059f:	29 c2                	sub    %eax,%edx
  8005a1:	89 d0                	mov    %edx,%eax
  8005a3:	3d 02 02 00 00       	cmp    $0x202,%eax
  8005a8:	74 14                	je     8005be <_main+0x586>
  8005aa:	83 ec 04             	sub    $0x4,%esp
  8005ad:	68 c5 24 80 00       	push   $0x8024c5
  8005b2:	6a 7d                	push   $0x7d
  8005b4:	68 1c 24 80 00       	push   $0x80241c
  8005b9:	e8 5c 04 00 00       	call   800a1a <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005be:	e8 df 16 00 00       	call   801ca2 <sys_calculate_free_frames>
  8005c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005c6:	e8 5a 17 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8005cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  8005ce:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8005d1:	83 ec 0c             	sub    $0xc,%esp
  8005d4:	50                   	push   %eax
  8005d5:	e8 86 14 00 00       	call   801a60 <free>
  8005da:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  8005dd:	e8 43 17 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8005e2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005e5:	29 c2                	sub    %eax,%edx
  8005e7:	89 d0                	mov    %edx,%eax
  8005e9:	3d 00 02 00 00       	cmp    $0x200,%eax
  8005ee:	74 17                	je     800607 <_main+0x5cf>
  8005f0:	83 ec 04             	sub    $0x4,%esp
  8005f3:	68 c5 24 80 00       	push   $0x8024c5
  8005f8:	68 84 00 00 00       	push   $0x84
  8005fd:	68 1c 24 80 00       	push   $0x80241c
  800602:	e8 13 04 00 00       	call   800a1a <_panic>

		//2 MB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800607:	e8 96 16 00 00       	call   801ca2 <sys_calculate_free_frames>
  80060c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80060f:	e8 11 17 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800614:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(2*Mega-kilo);
  800617:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80061a:	01 c0                	add    %eax,%eax
  80061c:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80061f:	83 ec 0c             	sub    $0xc,%esp
  800622:	50                   	push   %eax
  800623:	e8 1e 14 00 00       	call   801a46 <malloc>
  800628:	83 c4 10             	add    $0x10,%esp
  80062b:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  80062e:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800631:	89 c1                	mov    %eax,%ecx
  800633:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800636:	89 d0                	mov    %edx,%eax
  800638:	01 c0                	add    %eax,%eax
  80063a:	01 d0                	add    %edx,%eax
  80063c:	01 c0                	add    %eax,%eax
  80063e:	01 d0                	add    %edx,%eax
  800640:	89 c2                	mov    %eax,%edx
  800642:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800645:	c1 e0 04             	shl    $0x4,%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	05 00 00 00 80       	add    $0x80000000,%eax
  80064f:	39 c1                	cmp    %eax,%ecx
  800651:	74 17                	je     80066a <_main+0x632>
  800653:	83 ec 04             	sub    $0x4,%esp
  800656:	68 78 24 80 00       	push   $0x802478
  80065b:	68 8a 00 00 00       	push   $0x8a
  800660:	68 1c 24 80 00       	push   $0x80241c
  800665:	e8 b0 03 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80066a:	e8 b6 16 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  80066f:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800672:	3d 00 02 00 00       	cmp    $0x200,%eax
  800677:	74 17                	je     800690 <_main+0x658>
  800679:	83 ec 04             	sub    $0x4,%esp
  80067c:	68 a8 24 80 00       	push   $0x8024a8
  800681:	68 8c 00 00 00       	push   $0x8c
  800686:	68 1c 24 80 00       	push   $0x80241c
  80068b:	e8 8a 03 00 00       	call   800a1a <_panic>

		//6 KB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800690:	e8 0d 16 00 00       	call   801ca2 <sys_calculate_free_frames>
  800695:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800698:	e8 88 16 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  80069d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(6*kilo);
  8006a0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006a3:	89 d0                	mov    %edx,%eax
  8006a5:	01 c0                	add    %eax,%eax
  8006a7:	01 d0                	add    %edx,%eax
  8006a9:	01 c0                	add    %eax,%eax
  8006ab:	83 ec 0c             	sub    $0xc,%esp
  8006ae:	50                   	push   %eax
  8006af:	e8 92 13 00 00       	call   801a46 <malloc>
  8006b4:	83 c4 10             	add    $0x10,%esp
  8006b7:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 9*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  8006ba:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8006bd:	89 c1                	mov    %eax,%ecx
  8006bf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006c2:	89 d0                	mov    %edx,%eax
  8006c4:	c1 e0 03             	shl    $0x3,%eax
  8006c7:	01 d0                	add    %edx,%eax
  8006c9:	89 c2                	mov    %eax,%edx
  8006cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006ce:	c1 e0 04             	shl    $0x4,%eax
  8006d1:	01 d0                	add    %edx,%eax
  8006d3:	05 00 00 00 80       	add    $0x80000000,%eax
  8006d8:	39 c1                	cmp    %eax,%ecx
  8006da:	74 17                	je     8006f3 <_main+0x6bb>
  8006dc:	83 ec 04             	sub    $0x4,%esp
  8006df:	68 78 24 80 00       	push   $0x802478
  8006e4:	68 92 00 00 00       	push   $0x92
  8006e9:	68 1c 24 80 00       	push   $0x80241c
  8006ee:	e8 27 03 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  8006f3:	e8 2d 16 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8006f8:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8006fb:	83 f8 02             	cmp    $0x2,%eax
  8006fe:	74 17                	je     800717 <_main+0x6df>
  800700:	83 ec 04             	sub    $0x4,%esp
  800703:	68 a8 24 80 00       	push   $0x8024a8
  800708:	68 94 00 00 00       	push   $0x94
  80070d:	68 1c 24 80 00       	push   $0x80241c
  800712:	e8 03 03 00 00       	call   800a1a <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800717:	e8 86 15 00 00       	call   801ca2 <sys_calculate_free_frames>
  80071c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80071f:	e8 01 16 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800724:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  800727:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80072a:	83 ec 0c             	sub    $0xc,%esp
  80072d:	50                   	push   %eax
  80072e:	e8 2d 13 00 00       	call   801a60 <free>
  800733:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  800736:	e8 ea 15 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  80073b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80073e:	29 c2                	sub    %eax,%edx
  800740:	89 d0                	mov    %edx,%eax
  800742:	3d 00 03 00 00       	cmp    $0x300,%eax
  800747:	74 17                	je     800760 <_main+0x728>
  800749:	83 ec 04             	sub    $0x4,%esp
  80074c:	68 c5 24 80 00       	push   $0x8024c5
  800751:	68 9b 00 00 00       	push   $0x9b
  800756:	68 1c 24 80 00       	push   $0x80241c
  80075b:	e8 ba 02 00 00       	call   800a1a <_panic>

		//3 MB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800760:	e8 3d 15 00 00       	call   801ca2 <sys_calculate_free_frames>
  800765:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800768:	e8 b8 15 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  80076d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(3*Mega-kilo);
  800770:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800773:	89 c2                	mov    %eax,%edx
  800775:	01 d2                	add    %edx,%edx
  800777:	01 d0                	add    %edx,%eax
  800779:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80077c:	83 ec 0c             	sub    $0xc,%esp
  80077f:	50                   	push   %eax
  800780:	e8 c1 12 00 00       	call   801a46 <malloc>
  800785:	83 c4 10             	add    $0x10,%esp
  800788:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  80078b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80078e:	89 c2                	mov    %eax,%edx
  800790:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800793:	c1 e0 02             	shl    $0x2,%eax
  800796:	89 c1                	mov    %eax,%ecx
  800798:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80079b:	c1 e0 04             	shl    $0x4,%eax
  80079e:	01 c8                	add    %ecx,%eax
  8007a0:	05 00 00 00 80       	add    $0x80000000,%eax
  8007a5:	39 c2                	cmp    %eax,%edx
  8007a7:	74 17                	je     8007c0 <_main+0x788>
  8007a9:	83 ec 04             	sub    $0x4,%esp
  8007ac:	68 78 24 80 00       	push   $0x802478
  8007b1:	68 a1 00 00 00       	push   $0xa1
  8007b6:	68 1c 24 80 00       	push   $0x80241c
  8007bb:	e8 5a 02 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  8007c0:	e8 60 15 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  8007c5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007c8:	89 c2                	mov    %eax,%edx
  8007ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007cd:	89 c1                	mov    %eax,%ecx
  8007cf:	01 c9                	add    %ecx,%ecx
  8007d1:	01 c8                	add    %ecx,%eax
  8007d3:	85 c0                	test   %eax,%eax
  8007d5:	79 05                	jns    8007dc <_main+0x7a4>
  8007d7:	05 ff 0f 00 00       	add    $0xfff,%eax
  8007dc:	c1 f8 0c             	sar    $0xc,%eax
  8007df:	39 c2                	cmp    %eax,%edx
  8007e1:	74 17                	je     8007fa <_main+0x7c2>
  8007e3:	83 ec 04             	sub    $0x4,%esp
  8007e6:	68 a8 24 80 00       	push   $0x8024a8
  8007eb:	68 a3 00 00 00       	push   $0xa3
  8007f0:	68 1c 24 80 00       	push   $0x80241c
  8007f5:	e8 20 02 00 00       	call   800a1a <_panic>

		//4 MB
		freeFrames = sys_calculate_free_frames() ;
  8007fa:	e8 a3 14 00 00       	call   801ca2 <sys_calculate_free_frames>
  8007ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800802:	e8 1e 15 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800807:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(4*Mega-kilo);
  80080a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80080d:	c1 e0 02             	shl    $0x2,%eax
  800810:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800813:	83 ec 0c             	sub    $0xc,%esp
  800816:	50                   	push   %eax
  800817:	e8 2a 12 00 00       	call   801a46 <malloc>
  80081c:	83 c4 10             	add    $0x10,%esp
  80081f:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800822:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800825:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80082a:	74 17                	je     800843 <_main+0x80b>
  80082c:	83 ec 04             	sub    $0x4,%esp
  80082f:	68 78 24 80 00       	push   $0x802478
  800834:	68 a9 00 00 00       	push   $0xa9
  800839:	68 1c 24 80 00       	push   $0x80241c
  80083e:	e8 d7 01 00 00       	call   800a1a <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 4*Mega/4096) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/4096) panic("Wrong page file allocation: ");
  800843:	e8 dd 14 00 00       	call   801d25 <sys_pf_calculate_allocated_pages>
  800848:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80084b:	89 c2                	mov    %eax,%edx
  80084d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800850:	c1 e0 02             	shl    $0x2,%eax
  800853:	85 c0                	test   %eax,%eax
  800855:	79 05                	jns    80085c <_main+0x824>
  800857:	05 ff 0f 00 00       	add    $0xfff,%eax
  80085c:	c1 f8 0c             	sar    $0xc,%eax
  80085f:	39 c2                	cmp    %eax,%edx
  800861:	74 17                	je     80087a <_main+0x842>
  800863:	83 ec 04             	sub    $0x4,%esp
  800866:	68 a8 24 80 00       	push   $0x8024a8
  80086b:	68 ab 00 00 00       	push   $0xab
  800870:	68 1c 24 80 00       	push   $0x80241c
  800875:	e8 a0 01 00 00       	call   800a1a <_panic>
	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		//int freeFrames = sys_calculate_free_frames() ;
		//usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[12] = malloc((USER_HEAP_MAX - USER_HEAP_START - 14*Mega));
  80087a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80087d:	89 d0                	mov    %edx,%eax
  80087f:	01 c0                	add    %eax,%eax
  800881:	01 d0                	add    %edx,%eax
  800883:	01 c0                	add    %eax,%eax
  800885:	01 d0                	add    %edx,%eax
  800887:	01 c0                	add    %eax,%eax
  800889:	f7 d8                	neg    %eax
  80088b:	05 00 00 00 20       	add    $0x20000000,%eax
  800890:	83 ec 0c             	sub    $0xc,%esp
  800893:	50                   	push   %eax
  800894:	e8 ad 11 00 00       	call   801a46 <malloc>
  800899:	83 c4 10             	add    $0x10,%esp
  80089c:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if (ptr_allocations[12] != NULL) panic("Malloc: Attempt to allocate large segment with no suitable fragment to fit on, should return NULL");
  80089f:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8008a2:	85 c0                	test   %eax,%eax
  8008a4:	74 17                	je     8008bd <_main+0x885>
  8008a6:	83 ec 04             	sub    $0x4,%esp
  8008a9:	68 dc 24 80 00       	push   $0x8024dc
  8008ae:	68 b4 00 00 00       	push   $0xb4
  8008b3:	68 1c 24 80 00       	push   $0x80241c
  8008b8:	e8 5d 01 00 00       	call   800a1a <_panic>

		cprintf("Congratulations!! test BEST FIT allocation (2) completed successfully.\n");
  8008bd:	83 ec 0c             	sub    $0xc,%esp
  8008c0:	68 40 25 80 00       	push   $0x802540
  8008c5:	e8 f2 03 00 00       	call   800cbc <cprintf>
  8008ca:	83 c4 10             	add    $0x10,%esp

		return;
  8008cd:	90                   	nop
	}
}
  8008ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008d1:	5b                   	pop    %ebx
  8008d2:	5f                   	pop    %edi
  8008d3:	5d                   	pop    %ebp
  8008d4:	c3                   	ret    

008008d5 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8008d5:	55                   	push   %ebp
  8008d6:	89 e5                	mov    %esp,%ebp
  8008d8:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8008db:	e8 f7 12 00 00       	call   801bd7 <sys_getenvindex>
  8008e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8008e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008e6:	89 d0                	mov    %edx,%eax
  8008e8:	c1 e0 03             	shl    $0x3,%eax
  8008eb:	01 d0                	add    %edx,%eax
  8008ed:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8008f4:	01 c8                	add    %ecx,%eax
  8008f6:	01 c0                	add    %eax,%eax
  8008f8:	01 d0                	add    %edx,%eax
  8008fa:	01 c0                	add    %eax,%eax
  8008fc:	01 d0                	add    %edx,%eax
  8008fe:	89 c2                	mov    %eax,%edx
  800900:	c1 e2 05             	shl    $0x5,%edx
  800903:	29 c2                	sub    %eax,%edx
  800905:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80090c:	89 c2                	mov    %eax,%edx
  80090e:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800914:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800919:	a1 20 30 80 00       	mov    0x803020,%eax
  80091e:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800924:	84 c0                	test   %al,%al
  800926:	74 0f                	je     800937 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800928:	a1 20 30 80 00       	mov    0x803020,%eax
  80092d:	05 40 3c 01 00       	add    $0x13c40,%eax
  800932:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800937:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80093b:	7e 0a                	jle    800947 <libmain+0x72>
		binaryname = argv[0];
  80093d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800940:	8b 00                	mov    (%eax),%eax
  800942:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800947:	83 ec 08             	sub    $0x8,%esp
  80094a:	ff 75 0c             	pushl  0xc(%ebp)
  80094d:	ff 75 08             	pushl  0x8(%ebp)
  800950:	e8 e3 f6 ff ff       	call   800038 <_main>
  800955:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800958:	e8 15 14 00 00       	call   801d72 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80095d:	83 ec 0c             	sub    $0xc,%esp
  800960:	68 a0 25 80 00       	push   $0x8025a0
  800965:	e8 52 03 00 00       	call   800cbc <cprintf>
  80096a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80096d:	a1 20 30 80 00       	mov    0x803020,%eax
  800972:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800978:	a1 20 30 80 00       	mov    0x803020,%eax
  80097d:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800983:	83 ec 04             	sub    $0x4,%esp
  800986:	52                   	push   %edx
  800987:	50                   	push   %eax
  800988:	68 c8 25 80 00       	push   $0x8025c8
  80098d:	e8 2a 03 00 00       	call   800cbc <cprintf>
  800992:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800995:	a1 20 30 80 00       	mov    0x803020,%eax
  80099a:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8009a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8009a5:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8009ab:	83 ec 04             	sub    $0x4,%esp
  8009ae:	52                   	push   %edx
  8009af:	50                   	push   %eax
  8009b0:	68 f0 25 80 00       	push   $0x8025f0
  8009b5:	e8 02 03 00 00       	call   800cbc <cprintf>
  8009ba:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8009bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8009c2:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8009c8:	83 ec 08             	sub    $0x8,%esp
  8009cb:	50                   	push   %eax
  8009cc:	68 31 26 80 00       	push   $0x802631
  8009d1:	e8 e6 02 00 00       	call   800cbc <cprintf>
  8009d6:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8009d9:	83 ec 0c             	sub    $0xc,%esp
  8009dc:	68 a0 25 80 00       	push   $0x8025a0
  8009e1:	e8 d6 02 00 00       	call   800cbc <cprintf>
  8009e6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8009e9:	e8 9e 13 00 00       	call   801d8c <sys_enable_interrupt>

	// exit gracefully
	exit();
  8009ee:	e8 19 00 00 00       	call   800a0c <exit>
}
  8009f3:	90                   	nop
  8009f4:	c9                   	leave  
  8009f5:	c3                   	ret    

008009f6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009f6:	55                   	push   %ebp
  8009f7:	89 e5                	mov    %esp,%ebp
  8009f9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8009fc:	83 ec 0c             	sub    $0xc,%esp
  8009ff:	6a 00                	push   $0x0
  800a01:	e8 9d 11 00 00       	call   801ba3 <sys_env_destroy>
  800a06:	83 c4 10             	add    $0x10,%esp
}
  800a09:	90                   	nop
  800a0a:	c9                   	leave  
  800a0b:	c3                   	ret    

00800a0c <exit>:

void
exit(void)
{
  800a0c:	55                   	push   %ebp
  800a0d:	89 e5                	mov    %esp,%ebp
  800a0f:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800a12:	e8 f2 11 00 00       	call   801c09 <sys_env_exit>
}
  800a17:	90                   	nop
  800a18:	c9                   	leave  
  800a19:	c3                   	ret    

00800a1a <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800a1a:	55                   	push   %ebp
  800a1b:	89 e5                	mov    %esp,%ebp
  800a1d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800a20:	8d 45 10             	lea    0x10(%ebp),%eax
  800a23:	83 c0 04             	add    $0x4,%eax
  800a26:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800a29:	a1 18 31 80 00       	mov    0x803118,%eax
  800a2e:	85 c0                	test   %eax,%eax
  800a30:	74 16                	je     800a48 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800a32:	a1 18 31 80 00       	mov    0x803118,%eax
  800a37:	83 ec 08             	sub    $0x8,%esp
  800a3a:	50                   	push   %eax
  800a3b:	68 48 26 80 00       	push   $0x802648
  800a40:	e8 77 02 00 00       	call   800cbc <cprintf>
  800a45:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800a48:	a1 00 30 80 00       	mov    0x803000,%eax
  800a4d:	ff 75 0c             	pushl  0xc(%ebp)
  800a50:	ff 75 08             	pushl  0x8(%ebp)
  800a53:	50                   	push   %eax
  800a54:	68 4d 26 80 00       	push   $0x80264d
  800a59:	e8 5e 02 00 00       	call   800cbc <cprintf>
  800a5e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800a61:	8b 45 10             	mov    0x10(%ebp),%eax
  800a64:	83 ec 08             	sub    $0x8,%esp
  800a67:	ff 75 f4             	pushl  -0xc(%ebp)
  800a6a:	50                   	push   %eax
  800a6b:	e8 e1 01 00 00       	call   800c51 <vcprintf>
  800a70:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a73:	83 ec 08             	sub    $0x8,%esp
  800a76:	6a 00                	push   $0x0
  800a78:	68 69 26 80 00       	push   $0x802669
  800a7d:	e8 cf 01 00 00       	call   800c51 <vcprintf>
  800a82:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a85:	e8 82 ff ff ff       	call   800a0c <exit>

	// should not return here
	while (1) ;
  800a8a:	eb fe                	jmp    800a8a <_panic+0x70>

00800a8c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a8c:	55                   	push   %ebp
  800a8d:	89 e5                	mov    %esp,%ebp
  800a8f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a92:	a1 20 30 80 00       	mov    0x803020,%eax
  800a97:	8b 50 74             	mov    0x74(%eax),%edx
  800a9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9d:	39 c2                	cmp    %eax,%edx
  800a9f:	74 14                	je     800ab5 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800aa1:	83 ec 04             	sub    $0x4,%esp
  800aa4:	68 6c 26 80 00       	push   $0x80266c
  800aa9:	6a 26                	push   $0x26
  800aab:	68 b8 26 80 00       	push   $0x8026b8
  800ab0:	e8 65 ff ff ff       	call   800a1a <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800ab5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800abc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800ac3:	e9 b6 00 00 00       	jmp    800b7e <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800ac8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800acb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	01 d0                	add    %edx,%eax
  800ad7:	8b 00                	mov    (%eax),%eax
  800ad9:	85 c0                	test   %eax,%eax
  800adb:	75 08                	jne    800ae5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800add:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800ae0:	e9 96 00 00 00       	jmp    800b7b <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800ae5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800aec:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800af3:	eb 5d                	jmp    800b52 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800af5:	a1 20 30 80 00       	mov    0x803020,%eax
  800afa:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b00:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b03:	c1 e2 04             	shl    $0x4,%edx
  800b06:	01 d0                	add    %edx,%eax
  800b08:	8a 40 04             	mov    0x4(%eax),%al
  800b0b:	84 c0                	test   %al,%al
  800b0d:	75 40                	jne    800b4f <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b0f:	a1 20 30 80 00       	mov    0x803020,%eax
  800b14:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b1a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b1d:	c1 e2 04             	shl    $0x4,%edx
  800b20:	01 d0                	add    %edx,%eax
  800b22:	8b 00                	mov    (%eax),%eax
  800b24:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800b27:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b2a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b2f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800b31:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b34:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	01 c8                	add    %ecx,%eax
  800b40:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b42:	39 c2                	cmp    %eax,%edx
  800b44:	75 09                	jne    800b4f <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800b46:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b4d:	eb 12                	jmp    800b61 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b4f:	ff 45 e8             	incl   -0x18(%ebp)
  800b52:	a1 20 30 80 00       	mov    0x803020,%eax
  800b57:	8b 50 74             	mov    0x74(%eax),%edx
  800b5a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b5d:	39 c2                	cmp    %eax,%edx
  800b5f:	77 94                	ja     800af5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b61:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b65:	75 14                	jne    800b7b <CheckWSWithoutLastIndex+0xef>
			panic(
  800b67:	83 ec 04             	sub    $0x4,%esp
  800b6a:	68 c4 26 80 00       	push   $0x8026c4
  800b6f:	6a 3a                	push   $0x3a
  800b71:	68 b8 26 80 00       	push   $0x8026b8
  800b76:	e8 9f fe ff ff       	call   800a1a <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b7b:	ff 45 f0             	incl   -0x10(%ebp)
  800b7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b81:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b84:	0f 8c 3e ff ff ff    	jl     800ac8 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b8a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b91:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b98:	eb 20                	jmp    800bba <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b9a:	a1 20 30 80 00       	mov    0x803020,%eax
  800b9f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800ba5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ba8:	c1 e2 04             	shl    $0x4,%edx
  800bab:	01 d0                	add    %edx,%eax
  800bad:	8a 40 04             	mov    0x4(%eax),%al
  800bb0:	3c 01                	cmp    $0x1,%al
  800bb2:	75 03                	jne    800bb7 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800bb4:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bb7:	ff 45 e0             	incl   -0x20(%ebp)
  800bba:	a1 20 30 80 00       	mov    0x803020,%eax
  800bbf:	8b 50 74             	mov    0x74(%eax),%edx
  800bc2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bc5:	39 c2                	cmp    %eax,%edx
  800bc7:	77 d1                	ja     800b9a <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800bc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bcc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800bcf:	74 14                	je     800be5 <CheckWSWithoutLastIndex+0x159>
		panic(
  800bd1:	83 ec 04             	sub    $0x4,%esp
  800bd4:	68 18 27 80 00       	push   $0x802718
  800bd9:	6a 44                	push   $0x44
  800bdb:	68 b8 26 80 00       	push   $0x8026b8
  800be0:	e8 35 fe ff ff       	call   800a1a <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800be5:	90                   	nop
  800be6:	c9                   	leave  
  800be7:	c3                   	ret    

00800be8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800be8:	55                   	push   %ebp
  800be9:	89 e5                	mov    %esp,%ebp
  800beb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800bee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf1:	8b 00                	mov    (%eax),%eax
  800bf3:	8d 48 01             	lea    0x1(%eax),%ecx
  800bf6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf9:	89 0a                	mov    %ecx,(%edx)
  800bfb:	8b 55 08             	mov    0x8(%ebp),%edx
  800bfe:	88 d1                	mov    %dl,%cl
  800c00:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c03:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800c07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0a:	8b 00                	mov    (%eax),%eax
  800c0c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800c11:	75 2c                	jne    800c3f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800c13:	a0 24 30 80 00       	mov    0x803024,%al
  800c18:	0f b6 c0             	movzbl %al,%eax
  800c1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c1e:	8b 12                	mov    (%edx),%edx
  800c20:	89 d1                	mov    %edx,%ecx
  800c22:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c25:	83 c2 08             	add    $0x8,%edx
  800c28:	83 ec 04             	sub    $0x4,%esp
  800c2b:	50                   	push   %eax
  800c2c:	51                   	push   %ecx
  800c2d:	52                   	push   %edx
  800c2e:	e8 2e 0f 00 00       	call   801b61 <sys_cputs>
  800c33:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c39:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c42:	8b 40 04             	mov    0x4(%eax),%eax
  800c45:	8d 50 01             	lea    0x1(%eax),%edx
  800c48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4b:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c4e:	90                   	nop
  800c4f:	c9                   	leave  
  800c50:	c3                   	ret    

00800c51 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c51:	55                   	push   %ebp
  800c52:	89 e5                	mov    %esp,%ebp
  800c54:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c5a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c61:	00 00 00 
	b.cnt = 0;
  800c64:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c6b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c6e:	ff 75 0c             	pushl  0xc(%ebp)
  800c71:	ff 75 08             	pushl  0x8(%ebp)
  800c74:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c7a:	50                   	push   %eax
  800c7b:	68 e8 0b 80 00       	push   $0x800be8
  800c80:	e8 11 02 00 00       	call   800e96 <vprintfmt>
  800c85:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c88:	a0 24 30 80 00       	mov    0x803024,%al
  800c8d:	0f b6 c0             	movzbl %al,%eax
  800c90:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c96:	83 ec 04             	sub    $0x4,%esp
  800c99:	50                   	push   %eax
  800c9a:	52                   	push   %edx
  800c9b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ca1:	83 c0 08             	add    $0x8,%eax
  800ca4:	50                   	push   %eax
  800ca5:	e8 b7 0e 00 00       	call   801b61 <sys_cputs>
  800caa:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800cad:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800cb4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800cba:	c9                   	leave  
  800cbb:	c3                   	ret    

00800cbc <cprintf>:

int cprintf(const char *fmt, ...) {
  800cbc:	55                   	push   %ebp
  800cbd:	89 e5                	mov    %esp,%ebp
  800cbf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800cc2:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800cc9:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ccc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	83 ec 08             	sub    $0x8,%esp
  800cd5:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd8:	50                   	push   %eax
  800cd9:	e8 73 ff ff ff       	call   800c51 <vcprintf>
  800cde:	83 c4 10             	add    $0x10,%esp
  800ce1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ce4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ce7:	c9                   	leave  
  800ce8:	c3                   	ret    

00800ce9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ce9:	55                   	push   %ebp
  800cea:	89 e5                	mov    %esp,%ebp
  800cec:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800cef:	e8 7e 10 00 00       	call   801d72 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800cf4:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cf7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	83 ec 08             	sub    $0x8,%esp
  800d00:	ff 75 f4             	pushl  -0xc(%ebp)
  800d03:	50                   	push   %eax
  800d04:	e8 48 ff ff ff       	call   800c51 <vcprintf>
  800d09:	83 c4 10             	add    $0x10,%esp
  800d0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800d0f:	e8 78 10 00 00       	call   801d8c <sys_enable_interrupt>
	return cnt;
  800d14:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d17:	c9                   	leave  
  800d18:	c3                   	ret    

00800d19 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800d19:	55                   	push   %ebp
  800d1a:	89 e5                	mov    %esp,%ebp
  800d1c:	53                   	push   %ebx
  800d1d:	83 ec 14             	sub    $0x14,%esp
  800d20:	8b 45 10             	mov    0x10(%ebp),%eax
  800d23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d26:	8b 45 14             	mov    0x14(%ebp),%eax
  800d29:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d2c:	8b 45 18             	mov    0x18(%ebp),%eax
  800d2f:	ba 00 00 00 00       	mov    $0x0,%edx
  800d34:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d37:	77 55                	ja     800d8e <printnum+0x75>
  800d39:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d3c:	72 05                	jb     800d43 <printnum+0x2a>
  800d3e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d41:	77 4b                	ja     800d8e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d43:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d46:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d49:	8b 45 18             	mov    0x18(%ebp),%eax
  800d4c:	ba 00 00 00 00       	mov    $0x0,%edx
  800d51:	52                   	push   %edx
  800d52:	50                   	push   %eax
  800d53:	ff 75 f4             	pushl  -0xc(%ebp)
  800d56:	ff 75 f0             	pushl  -0x10(%ebp)
  800d59:	e8 36 14 00 00       	call   802194 <__udivdi3>
  800d5e:	83 c4 10             	add    $0x10,%esp
  800d61:	83 ec 04             	sub    $0x4,%esp
  800d64:	ff 75 20             	pushl  0x20(%ebp)
  800d67:	53                   	push   %ebx
  800d68:	ff 75 18             	pushl  0x18(%ebp)
  800d6b:	52                   	push   %edx
  800d6c:	50                   	push   %eax
  800d6d:	ff 75 0c             	pushl  0xc(%ebp)
  800d70:	ff 75 08             	pushl  0x8(%ebp)
  800d73:	e8 a1 ff ff ff       	call   800d19 <printnum>
  800d78:	83 c4 20             	add    $0x20,%esp
  800d7b:	eb 1a                	jmp    800d97 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d7d:	83 ec 08             	sub    $0x8,%esp
  800d80:	ff 75 0c             	pushl  0xc(%ebp)
  800d83:	ff 75 20             	pushl  0x20(%ebp)
  800d86:	8b 45 08             	mov    0x8(%ebp),%eax
  800d89:	ff d0                	call   *%eax
  800d8b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d8e:	ff 4d 1c             	decl   0x1c(%ebp)
  800d91:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d95:	7f e6                	jg     800d7d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d97:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d9a:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800da2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800da5:	53                   	push   %ebx
  800da6:	51                   	push   %ecx
  800da7:	52                   	push   %edx
  800da8:	50                   	push   %eax
  800da9:	e8 f6 14 00 00       	call   8022a4 <__umoddi3>
  800dae:	83 c4 10             	add    $0x10,%esp
  800db1:	05 94 29 80 00       	add    $0x802994,%eax
  800db6:	8a 00                	mov    (%eax),%al
  800db8:	0f be c0             	movsbl %al,%eax
  800dbb:	83 ec 08             	sub    $0x8,%esp
  800dbe:	ff 75 0c             	pushl  0xc(%ebp)
  800dc1:	50                   	push   %eax
  800dc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc5:	ff d0                	call   *%eax
  800dc7:	83 c4 10             	add    $0x10,%esp
}
  800dca:	90                   	nop
  800dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800dce:	c9                   	leave  
  800dcf:	c3                   	ret    

00800dd0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800dd0:	55                   	push   %ebp
  800dd1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800dd3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800dd7:	7e 1c                	jle    800df5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	8b 00                	mov    (%eax),%eax
  800dde:	8d 50 08             	lea    0x8(%eax),%edx
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
  800de4:	89 10                	mov    %edx,(%eax)
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	8b 00                	mov    (%eax),%eax
  800deb:	83 e8 08             	sub    $0x8,%eax
  800dee:	8b 50 04             	mov    0x4(%eax),%edx
  800df1:	8b 00                	mov    (%eax),%eax
  800df3:	eb 40                	jmp    800e35 <getuint+0x65>
	else if (lflag)
  800df5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800df9:	74 1e                	je     800e19 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfe:	8b 00                	mov    (%eax),%eax
  800e00:	8d 50 04             	lea    0x4(%eax),%edx
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	89 10                	mov    %edx,(%eax)
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	8b 00                	mov    (%eax),%eax
  800e0d:	83 e8 04             	sub    $0x4,%eax
  800e10:	8b 00                	mov    (%eax),%eax
  800e12:	ba 00 00 00 00       	mov    $0x0,%edx
  800e17:	eb 1c                	jmp    800e35 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800e19:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1c:	8b 00                	mov    (%eax),%eax
  800e1e:	8d 50 04             	lea    0x4(%eax),%edx
  800e21:	8b 45 08             	mov    0x8(%ebp),%eax
  800e24:	89 10                	mov    %edx,(%eax)
  800e26:	8b 45 08             	mov    0x8(%ebp),%eax
  800e29:	8b 00                	mov    (%eax),%eax
  800e2b:	83 e8 04             	sub    $0x4,%eax
  800e2e:	8b 00                	mov    (%eax),%eax
  800e30:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e35:	5d                   	pop    %ebp
  800e36:	c3                   	ret    

00800e37 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e37:	55                   	push   %ebp
  800e38:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e3a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e3e:	7e 1c                	jle    800e5c <getint+0x25>
		return va_arg(*ap, long long);
  800e40:	8b 45 08             	mov    0x8(%ebp),%eax
  800e43:	8b 00                	mov    (%eax),%eax
  800e45:	8d 50 08             	lea    0x8(%eax),%edx
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	89 10                	mov    %edx,(%eax)
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e50:	8b 00                	mov    (%eax),%eax
  800e52:	83 e8 08             	sub    $0x8,%eax
  800e55:	8b 50 04             	mov    0x4(%eax),%edx
  800e58:	8b 00                	mov    (%eax),%eax
  800e5a:	eb 38                	jmp    800e94 <getint+0x5d>
	else if (lflag)
  800e5c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e60:	74 1a                	je     800e7c <getint+0x45>
		return va_arg(*ap, long);
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
  800e65:	8b 00                	mov    (%eax),%eax
  800e67:	8d 50 04             	lea    0x4(%eax),%edx
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6d:	89 10                	mov    %edx,(%eax)
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	8b 00                	mov    (%eax),%eax
  800e74:	83 e8 04             	sub    $0x4,%eax
  800e77:	8b 00                	mov    (%eax),%eax
  800e79:	99                   	cltd   
  800e7a:	eb 18                	jmp    800e94 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7f:	8b 00                	mov    (%eax),%eax
  800e81:	8d 50 04             	lea    0x4(%eax),%edx
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	89 10                	mov    %edx,(%eax)
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	8b 00                	mov    (%eax),%eax
  800e8e:	83 e8 04             	sub    $0x4,%eax
  800e91:	8b 00                	mov    (%eax),%eax
  800e93:	99                   	cltd   
}
  800e94:	5d                   	pop    %ebp
  800e95:	c3                   	ret    

00800e96 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e96:	55                   	push   %ebp
  800e97:	89 e5                	mov    %esp,%ebp
  800e99:	56                   	push   %esi
  800e9a:	53                   	push   %ebx
  800e9b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e9e:	eb 17                	jmp    800eb7 <vprintfmt+0x21>
			if (ch == '\0')
  800ea0:	85 db                	test   %ebx,%ebx
  800ea2:	0f 84 af 03 00 00    	je     801257 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ea8:	83 ec 08             	sub    $0x8,%esp
  800eab:	ff 75 0c             	pushl  0xc(%ebp)
  800eae:	53                   	push   %ebx
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	ff d0                	call   *%eax
  800eb4:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800eb7:	8b 45 10             	mov    0x10(%ebp),%eax
  800eba:	8d 50 01             	lea    0x1(%eax),%edx
  800ebd:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec0:	8a 00                	mov    (%eax),%al
  800ec2:	0f b6 d8             	movzbl %al,%ebx
  800ec5:	83 fb 25             	cmp    $0x25,%ebx
  800ec8:	75 d6                	jne    800ea0 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800eca:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ece:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ed5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800edc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ee3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800eea:	8b 45 10             	mov    0x10(%ebp),%eax
  800eed:	8d 50 01             	lea    0x1(%eax),%edx
  800ef0:	89 55 10             	mov    %edx,0x10(%ebp)
  800ef3:	8a 00                	mov    (%eax),%al
  800ef5:	0f b6 d8             	movzbl %al,%ebx
  800ef8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800efb:	83 f8 55             	cmp    $0x55,%eax
  800efe:	0f 87 2b 03 00 00    	ja     80122f <vprintfmt+0x399>
  800f04:	8b 04 85 b8 29 80 00 	mov    0x8029b8(,%eax,4),%eax
  800f0b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800f0d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800f11:	eb d7                	jmp    800eea <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800f13:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800f17:	eb d1                	jmp    800eea <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f19:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800f20:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800f23:	89 d0                	mov    %edx,%eax
  800f25:	c1 e0 02             	shl    $0x2,%eax
  800f28:	01 d0                	add    %edx,%eax
  800f2a:	01 c0                	add    %eax,%eax
  800f2c:	01 d8                	add    %ebx,%eax
  800f2e:	83 e8 30             	sub    $0x30,%eax
  800f31:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f34:	8b 45 10             	mov    0x10(%ebp),%eax
  800f37:	8a 00                	mov    (%eax),%al
  800f39:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f3c:	83 fb 2f             	cmp    $0x2f,%ebx
  800f3f:	7e 3e                	jle    800f7f <vprintfmt+0xe9>
  800f41:	83 fb 39             	cmp    $0x39,%ebx
  800f44:	7f 39                	jg     800f7f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f46:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f49:	eb d5                	jmp    800f20 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f4b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4e:	83 c0 04             	add    $0x4,%eax
  800f51:	89 45 14             	mov    %eax,0x14(%ebp)
  800f54:	8b 45 14             	mov    0x14(%ebp),%eax
  800f57:	83 e8 04             	sub    $0x4,%eax
  800f5a:	8b 00                	mov    (%eax),%eax
  800f5c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f5f:	eb 1f                	jmp    800f80 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f61:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f65:	79 83                	jns    800eea <vprintfmt+0x54>
				width = 0;
  800f67:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f6e:	e9 77 ff ff ff       	jmp    800eea <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f73:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f7a:	e9 6b ff ff ff       	jmp    800eea <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f7f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f80:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f84:	0f 89 60 ff ff ff    	jns    800eea <vprintfmt+0x54>
				width = precision, precision = -1;
  800f8a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f8d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f90:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f97:	e9 4e ff ff ff       	jmp    800eea <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f9c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f9f:	e9 46 ff ff ff       	jmp    800eea <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800fa4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa7:	83 c0 04             	add    $0x4,%eax
  800faa:	89 45 14             	mov    %eax,0x14(%ebp)
  800fad:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb0:	83 e8 04             	sub    $0x4,%eax
  800fb3:	8b 00                	mov    (%eax),%eax
  800fb5:	83 ec 08             	sub    $0x8,%esp
  800fb8:	ff 75 0c             	pushl  0xc(%ebp)
  800fbb:	50                   	push   %eax
  800fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbf:	ff d0                	call   *%eax
  800fc1:	83 c4 10             	add    $0x10,%esp
			break;
  800fc4:	e9 89 02 00 00       	jmp    801252 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800fc9:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcc:	83 c0 04             	add    $0x4,%eax
  800fcf:	89 45 14             	mov    %eax,0x14(%ebp)
  800fd2:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd5:	83 e8 04             	sub    $0x4,%eax
  800fd8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fda:	85 db                	test   %ebx,%ebx
  800fdc:	79 02                	jns    800fe0 <vprintfmt+0x14a>
				err = -err;
  800fde:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fe0:	83 fb 64             	cmp    $0x64,%ebx
  800fe3:	7f 0b                	jg     800ff0 <vprintfmt+0x15a>
  800fe5:	8b 34 9d 00 28 80 00 	mov    0x802800(,%ebx,4),%esi
  800fec:	85 f6                	test   %esi,%esi
  800fee:	75 19                	jne    801009 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ff0:	53                   	push   %ebx
  800ff1:	68 a5 29 80 00       	push   $0x8029a5
  800ff6:	ff 75 0c             	pushl  0xc(%ebp)
  800ff9:	ff 75 08             	pushl  0x8(%ebp)
  800ffc:	e8 5e 02 00 00       	call   80125f <printfmt>
  801001:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801004:	e9 49 02 00 00       	jmp    801252 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801009:	56                   	push   %esi
  80100a:	68 ae 29 80 00       	push   $0x8029ae
  80100f:	ff 75 0c             	pushl  0xc(%ebp)
  801012:	ff 75 08             	pushl  0x8(%ebp)
  801015:	e8 45 02 00 00       	call   80125f <printfmt>
  80101a:	83 c4 10             	add    $0x10,%esp
			break;
  80101d:	e9 30 02 00 00       	jmp    801252 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801022:	8b 45 14             	mov    0x14(%ebp),%eax
  801025:	83 c0 04             	add    $0x4,%eax
  801028:	89 45 14             	mov    %eax,0x14(%ebp)
  80102b:	8b 45 14             	mov    0x14(%ebp),%eax
  80102e:	83 e8 04             	sub    $0x4,%eax
  801031:	8b 30                	mov    (%eax),%esi
  801033:	85 f6                	test   %esi,%esi
  801035:	75 05                	jne    80103c <vprintfmt+0x1a6>
				p = "(null)";
  801037:	be b1 29 80 00       	mov    $0x8029b1,%esi
			if (width > 0 && padc != '-')
  80103c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801040:	7e 6d                	jle    8010af <vprintfmt+0x219>
  801042:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801046:	74 67                	je     8010af <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801048:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80104b:	83 ec 08             	sub    $0x8,%esp
  80104e:	50                   	push   %eax
  80104f:	56                   	push   %esi
  801050:	e8 0c 03 00 00       	call   801361 <strnlen>
  801055:	83 c4 10             	add    $0x10,%esp
  801058:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80105b:	eb 16                	jmp    801073 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80105d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801061:	83 ec 08             	sub    $0x8,%esp
  801064:	ff 75 0c             	pushl  0xc(%ebp)
  801067:	50                   	push   %eax
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	ff d0                	call   *%eax
  80106d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801070:	ff 4d e4             	decl   -0x1c(%ebp)
  801073:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801077:	7f e4                	jg     80105d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801079:	eb 34                	jmp    8010af <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80107b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80107f:	74 1c                	je     80109d <vprintfmt+0x207>
  801081:	83 fb 1f             	cmp    $0x1f,%ebx
  801084:	7e 05                	jle    80108b <vprintfmt+0x1f5>
  801086:	83 fb 7e             	cmp    $0x7e,%ebx
  801089:	7e 12                	jle    80109d <vprintfmt+0x207>
					putch('?', putdat);
  80108b:	83 ec 08             	sub    $0x8,%esp
  80108e:	ff 75 0c             	pushl  0xc(%ebp)
  801091:	6a 3f                	push   $0x3f
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	ff d0                	call   *%eax
  801098:	83 c4 10             	add    $0x10,%esp
  80109b:	eb 0f                	jmp    8010ac <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80109d:	83 ec 08             	sub    $0x8,%esp
  8010a0:	ff 75 0c             	pushl  0xc(%ebp)
  8010a3:	53                   	push   %ebx
  8010a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a7:	ff d0                	call   *%eax
  8010a9:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8010ac:	ff 4d e4             	decl   -0x1c(%ebp)
  8010af:	89 f0                	mov    %esi,%eax
  8010b1:	8d 70 01             	lea    0x1(%eax),%esi
  8010b4:	8a 00                	mov    (%eax),%al
  8010b6:	0f be d8             	movsbl %al,%ebx
  8010b9:	85 db                	test   %ebx,%ebx
  8010bb:	74 24                	je     8010e1 <vprintfmt+0x24b>
  8010bd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010c1:	78 b8                	js     80107b <vprintfmt+0x1e5>
  8010c3:	ff 4d e0             	decl   -0x20(%ebp)
  8010c6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8010ca:	79 af                	jns    80107b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010cc:	eb 13                	jmp    8010e1 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010ce:	83 ec 08             	sub    $0x8,%esp
  8010d1:	ff 75 0c             	pushl  0xc(%ebp)
  8010d4:	6a 20                	push   $0x20
  8010d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d9:	ff d0                	call   *%eax
  8010db:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010de:	ff 4d e4             	decl   -0x1c(%ebp)
  8010e1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010e5:	7f e7                	jg     8010ce <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010e7:	e9 66 01 00 00       	jmp    801252 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010ec:	83 ec 08             	sub    $0x8,%esp
  8010ef:	ff 75 e8             	pushl  -0x18(%ebp)
  8010f2:	8d 45 14             	lea    0x14(%ebp),%eax
  8010f5:	50                   	push   %eax
  8010f6:	e8 3c fd ff ff       	call   800e37 <getint>
  8010fb:	83 c4 10             	add    $0x10,%esp
  8010fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801101:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801104:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801107:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80110a:	85 d2                	test   %edx,%edx
  80110c:	79 23                	jns    801131 <vprintfmt+0x29b>
				putch('-', putdat);
  80110e:	83 ec 08             	sub    $0x8,%esp
  801111:	ff 75 0c             	pushl  0xc(%ebp)
  801114:	6a 2d                	push   $0x2d
  801116:	8b 45 08             	mov    0x8(%ebp),%eax
  801119:	ff d0                	call   *%eax
  80111b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80111e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801121:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801124:	f7 d8                	neg    %eax
  801126:	83 d2 00             	adc    $0x0,%edx
  801129:	f7 da                	neg    %edx
  80112b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80112e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801131:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801138:	e9 bc 00 00 00       	jmp    8011f9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80113d:	83 ec 08             	sub    $0x8,%esp
  801140:	ff 75 e8             	pushl  -0x18(%ebp)
  801143:	8d 45 14             	lea    0x14(%ebp),%eax
  801146:	50                   	push   %eax
  801147:	e8 84 fc ff ff       	call   800dd0 <getuint>
  80114c:	83 c4 10             	add    $0x10,%esp
  80114f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801152:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801155:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80115c:	e9 98 00 00 00       	jmp    8011f9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801161:	83 ec 08             	sub    $0x8,%esp
  801164:	ff 75 0c             	pushl  0xc(%ebp)
  801167:	6a 58                	push   $0x58
  801169:	8b 45 08             	mov    0x8(%ebp),%eax
  80116c:	ff d0                	call   *%eax
  80116e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801171:	83 ec 08             	sub    $0x8,%esp
  801174:	ff 75 0c             	pushl  0xc(%ebp)
  801177:	6a 58                	push   $0x58
  801179:	8b 45 08             	mov    0x8(%ebp),%eax
  80117c:	ff d0                	call   *%eax
  80117e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801181:	83 ec 08             	sub    $0x8,%esp
  801184:	ff 75 0c             	pushl  0xc(%ebp)
  801187:	6a 58                	push   $0x58
  801189:	8b 45 08             	mov    0x8(%ebp),%eax
  80118c:	ff d0                	call   *%eax
  80118e:	83 c4 10             	add    $0x10,%esp
			break;
  801191:	e9 bc 00 00 00       	jmp    801252 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801196:	83 ec 08             	sub    $0x8,%esp
  801199:	ff 75 0c             	pushl  0xc(%ebp)
  80119c:	6a 30                	push   $0x30
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	ff d0                	call   *%eax
  8011a3:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8011a6:	83 ec 08             	sub    $0x8,%esp
  8011a9:	ff 75 0c             	pushl  0xc(%ebp)
  8011ac:	6a 78                	push   $0x78
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	ff d0                	call   *%eax
  8011b3:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8011b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b9:	83 c0 04             	add    $0x4,%eax
  8011bc:	89 45 14             	mov    %eax,0x14(%ebp)
  8011bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c2:	83 e8 04             	sub    $0x4,%eax
  8011c5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8011c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011d1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011d8:	eb 1f                	jmp    8011f9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011da:	83 ec 08             	sub    $0x8,%esp
  8011dd:	ff 75 e8             	pushl  -0x18(%ebp)
  8011e0:	8d 45 14             	lea    0x14(%ebp),%eax
  8011e3:	50                   	push   %eax
  8011e4:	e8 e7 fb ff ff       	call   800dd0 <getuint>
  8011e9:	83 c4 10             	add    $0x10,%esp
  8011ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ef:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011f2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011f9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801200:	83 ec 04             	sub    $0x4,%esp
  801203:	52                   	push   %edx
  801204:	ff 75 e4             	pushl  -0x1c(%ebp)
  801207:	50                   	push   %eax
  801208:	ff 75 f4             	pushl  -0xc(%ebp)
  80120b:	ff 75 f0             	pushl  -0x10(%ebp)
  80120e:	ff 75 0c             	pushl  0xc(%ebp)
  801211:	ff 75 08             	pushl  0x8(%ebp)
  801214:	e8 00 fb ff ff       	call   800d19 <printnum>
  801219:	83 c4 20             	add    $0x20,%esp
			break;
  80121c:	eb 34                	jmp    801252 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80121e:	83 ec 08             	sub    $0x8,%esp
  801221:	ff 75 0c             	pushl  0xc(%ebp)
  801224:	53                   	push   %ebx
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	ff d0                	call   *%eax
  80122a:	83 c4 10             	add    $0x10,%esp
			break;
  80122d:	eb 23                	jmp    801252 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80122f:	83 ec 08             	sub    $0x8,%esp
  801232:	ff 75 0c             	pushl  0xc(%ebp)
  801235:	6a 25                	push   $0x25
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	ff d0                	call   *%eax
  80123c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80123f:	ff 4d 10             	decl   0x10(%ebp)
  801242:	eb 03                	jmp    801247 <vprintfmt+0x3b1>
  801244:	ff 4d 10             	decl   0x10(%ebp)
  801247:	8b 45 10             	mov    0x10(%ebp),%eax
  80124a:	48                   	dec    %eax
  80124b:	8a 00                	mov    (%eax),%al
  80124d:	3c 25                	cmp    $0x25,%al
  80124f:	75 f3                	jne    801244 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801251:	90                   	nop
		}
	}
  801252:	e9 47 fc ff ff       	jmp    800e9e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801257:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801258:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80125b:	5b                   	pop    %ebx
  80125c:	5e                   	pop    %esi
  80125d:	5d                   	pop    %ebp
  80125e:	c3                   	ret    

0080125f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80125f:	55                   	push   %ebp
  801260:	89 e5                	mov    %esp,%ebp
  801262:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801265:	8d 45 10             	lea    0x10(%ebp),%eax
  801268:	83 c0 04             	add    $0x4,%eax
  80126b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80126e:	8b 45 10             	mov    0x10(%ebp),%eax
  801271:	ff 75 f4             	pushl  -0xc(%ebp)
  801274:	50                   	push   %eax
  801275:	ff 75 0c             	pushl  0xc(%ebp)
  801278:	ff 75 08             	pushl  0x8(%ebp)
  80127b:	e8 16 fc ff ff       	call   800e96 <vprintfmt>
  801280:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801283:	90                   	nop
  801284:	c9                   	leave  
  801285:	c3                   	ret    

00801286 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801286:	55                   	push   %ebp
  801287:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801289:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128c:	8b 40 08             	mov    0x8(%eax),%eax
  80128f:	8d 50 01             	lea    0x1(%eax),%edx
  801292:	8b 45 0c             	mov    0xc(%ebp),%eax
  801295:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801298:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129b:	8b 10                	mov    (%eax),%edx
  80129d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a0:	8b 40 04             	mov    0x4(%eax),%eax
  8012a3:	39 c2                	cmp    %eax,%edx
  8012a5:	73 12                	jae    8012b9 <sprintputch+0x33>
		*b->buf++ = ch;
  8012a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012aa:	8b 00                	mov    (%eax),%eax
  8012ac:	8d 48 01             	lea    0x1(%eax),%ecx
  8012af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b2:	89 0a                	mov    %ecx,(%edx)
  8012b4:	8b 55 08             	mov    0x8(%ebp),%edx
  8012b7:	88 10                	mov    %dl,(%eax)
}
  8012b9:	90                   	nop
  8012ba:	5d                   	pop    %ebp
  8012bb:	c3                   	ret    

008012bc <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8012bc:	55                   	push   %ebp
  8012bd:	89 e5                	mov    %esp,%ebp
  8012bf:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8012c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	01 d0                	add    %edx,%eax
  8012d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012e1:	74 06                	je     8012e9 <vsnprintf+0x2d>
  8012e3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012e7:	7f 07                	jg     8012f0 <vsnprintf+0x34>
		return -E_INVAL;
  8012e9:	b8 03 00 00 00       	mov    $0x3,%eax
  8012ee:	eb 20                	jmp    801310 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012f0:	ff 75 14             	pushl  0x14(%ebp)
  8012f3:	ff 75 10             	pushl  0x10(%ebp)
  8012f6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012f9:	50                   	push   %eax
  8012fa:	68 86 12 80 00       	push   $0x801286
  8012ff:	e8 92 fb ff ff       	call   800e96 <vprintfmt>
  801304:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801307:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80130a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80130d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801310:	c9                   	leave  
  801311:	c3                   	ret    

00801312 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801312:	55                   	push   %ebp
  801313:	89 e5                	mov    %esp,%ebp
  801315:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801318:	8d 45 10             	lea    0x10(%ebp),%eax
  80131b:	83 c0 04             	add    $0x4,%eax
  80131e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801321:	8b 45 10             	mov    0x10(%ebp),%eax
  801324:	ff 75 f4             	pushl  -0xc(%ebp)
  801327:	50                   	push   %eax
  801328:	ff 75 0c             	pushl  0xc(%ebp)
  80132b:	ff 75 08             	pushl  0x8(%ebp)
  80132e:	e8 89 ff ff ff       	call   8012bc <vsnprintf>
  801333:	83 c4 10             	add    $0x10,%esp
  801336:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801339:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80133c:	c9                   	leave  
  80133d:	c3                   	ret    

0080133e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80133e:	55                   	push   %ebp
  80133f:	89 e5                	mov    %esp,%ebp
  801341:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801344:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80134b:	eb 06                	jmp    801353 <strlen+0x15>
		n++;
  80134d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801350:	ff 45 08             	incl   0x8(%ebp)
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	8a 00                	mov    (%eax),%al
  801358:	84 c0                	test   %al,%al
  80135a:	75 f1                	jne    80134d <strlen+0xf>
		n++;
	return n;
  80135c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80135f:	c9                   	leave  
  801360:	c3                   	ret    

00801361 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801361:	55                   	push   %ebp
  801362:	89 e5                	mov    %esp,%ebp
  801364:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801367:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80136e:	eb 09                	jmp    801379 <strnlen+0x18>
		n++;
  801370:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801373:	ff 45 08             	incl   0x8(%ebp)
  801376:	ff 4d 0c             	decl   0xc(%ebp)
  801379:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80137d:	74 09                	je     801388 <strnlen+0x27>
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	84 c0                	test   %al,%al
  801386:	75 e8                	jne    801370 <strnlen+0xf>
		n++;
	return n;
  801388:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80138b:	c9                   	leave  
  80138c:	c3                   	ret    

0080138d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80138d:	55                   	push   %ebp
  80138e:	89 e5                	mov    %esp,%ebp
  801390:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801393:	8b 45 08             	mov    0x8(%ebp),%eax
  801396:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801399:	90                   	nop
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
  80139d:	8d 50 01             	lea    0x1(%eax),%edx
  8013a0:	89 55 08             	mov    %edx,0x8(%ebp)
  8013a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013a9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013ac:	8a 12                	mov    (%edx),%dl
  8013ae:	88 10                	mov    %dl,(%eax)
  8013b0:	8a 00                	mov    (%eax),%al
  8013b2:	84 c0                	test   %al,%al
  8013b4:	75 e4                	jne    80139a <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013b9:	c9                   	leave  
  8013ba:	c3                   	ret    

008013bb <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013bb:	55                   	push   %ebp
  8013bc:	89 e5                	mov    %esp,%ebp
  8013be:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013ce:	eb 1f                	jmp    8013ef <strncpy+0x34>
		*dst++ = *src;
  8013d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d3:	8d 50 01             	lea    0x1(%eax),%edx
  8013d6:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013dc:	8a 12                	mov    (%edx),%dl
  8013de:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e3:	8a 00                	mov    (%eax),%al
  8013e5:	84 c0                	test   %al,%al
  8013e7:	74 03                	je     8013ec <strncpy+0x31>
			src++;
  8013e9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013ec:	ff 45 fc             	incl   -0x4(%ebp)
  8013ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013f5:	72 d9                	jb     8013d0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013fa:	c9                   	leave  
  8013fb:	c3                   	ret    

008013fc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013fc:	55                   	push   %ebp
  8013fd:	89 e5                	mov    %esp,%ebp
  8013ff:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801402:	8b 45 08             	mov    0x8(%ebp),%eax
  801405:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801408:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80140c:	74 30                	je     80143e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80140e:	eb 16                	jmp    801426 <strlcpy+0x2a>
			*dst++ = *src++;
  801410:	8b 45 08             	mov    0x8(%ebp),%eax
  801413:	8d 50 01             	lea    0x1(%eax),%edx
  801416:	89 55 08             	mov    %edx,0x8(%ebp)
  801419:	8b 55 0c             	mov    0xc(%ebp),%edx
  80141c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80141f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801422:	8a 12                	mov    (%edx),%dl
  801424:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801426:	ff 4d 10             	decl   0x10(%ebp)
  801429:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80142d:	74 09                	je     801438 <strlcpy+0x3c>
  80142f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	84 c0                	test   %al,%al
  801436:	75 d8                	jne    801410 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80143e:	8b 55 08             	mov    0x8(%ebp),%edx
  801441:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801444:	29 c2                	sub    %eax,%edx
  801446:	89 d0                	mov    %edx,%eax
}
  801448:	c9                   	leave  
  801449:	c3                   	ret    

0080144a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80144a:	55                   	push   %ebp
  80144b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80144d:	eb 06                	jmp    801455 <strcmp+0xb>
		p++, q++;
  80144f:	ff 45 08             	incl   0x8(%ebp)
  801452:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	8a 00                	mov    (%eax),%al
  80145a:	84 c0                	test   %al,%al
  80145c:	74 0e                	je     80146c <strcmp+0x22>
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	8a 10                	mov    (%eax),%dl
  801463:	8b 45 0c             	mov    0xc(%ebp),%eax
  801466:	8a 00                	mov    (%eax),%al
  801468:	38 c2                	cmp    %al,%dl
  80146a:	74 e3                	je     80144f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	8a 00                	mov    (%eax),%al
  801471:	0f b6 d0             	movzbl %al,%edx
  801474:	8b 45 0c             	mov    0xc(%ebp),%eax
  801477:	8a 00                	mov    (%eax),%al
  801479:	0f b6 c0             	movzbl %al,%eax
  80147c:	29 c2                	sub    %eax,%edx
  80147e:	89 d0                	mov    %edx,%eax
}
  801480:	5d                   	pop    %ebp
  801481:	c3                   	ret    

00801482 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801482:	55                   	push   %ebp
  801483:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801485:	eb 09                	jmp    801490 <strncmp+0xe>
		n--, p++, q++;
  801487:	ff 4d 10             	decl   0x10(%ebp)
  80148a:	ff 45 08             	incl   0x8(%ebp)
  80148d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801490:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801494:	74 17                	je     8014ad <strncmp+0x2b>
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
  801499:	8a 00                	mov    (%eax),%al
  80149b:	84 c0                	test   %al,%al
  80149d:	74 0e                	je     8014ad <strncmp+0x2b>
  80149f:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a2:	8a 10                	mov    (%eax),%dl
  8014a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a7:	8a 00                	mov    (%eax),%al
  8014a9:	38 c2                	cmp    %al,%dl
  8014ab:	74 da                	je     801487 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014b1:	75 07                	jne    8014ba <strncmp+0x38>
		return 0;
  8014b3:	b8 00 00 00 00       	mov    $0x0,%eax
  8014b8:	eb 14                	jmp    8014ce <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bd:	8a 00                	mov    (%eax),%al
  8014bf:	0f b6 d0             	movzbl %al,%edx
  8014c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c5:	8a 00                	mov    (%eax),%al
  8014c7:	0f b6 c0             	movzbl %al,%eax
  8014ca:	29 c2                	sub    %eax,%edx
  8014cc:	89 d0                	mov    %edx,%eax
}
  8014ce:	5d                   	pop    %ebp
  8014cf:	c3                   	ret    

008014d0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
  8014d3:	83 ec 04             	sub    $0x4,%esp
  8014d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014dc:	eb 12                	jmp    8014f0 <strchr+0x20>
		if (*s == c)
  8014de:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e1:	8a 00                	mov    (%eax),%al
  8014e3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014e6:	75 05                	jne    8014ed <strchr+0x1d>
			return (char *) s;
  8014e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014eb:	eb 11                	jmp    8014fe <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014ed:	ff 45 08             	incl   0x8(%ebp)
  8014f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f3:	8a 00                	mov    (%eax),%al
  8014f5:	84 c0                	test   %al,%al
  8014f7:	75 e5                	jne    8014de <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014f9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014fe:	c9                   	leave  
  8014ff:	c3                   	ret    

00801500 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801500:	55                   	push   %ebp
  801501:	89 e5                	mov    %esp,%ebp
  801503:	83 ec 04             	sub    $0x4,%esp
  801506:	8b 45 0c             	mov    0xc(%ebp),%eax
  801509:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80150c:	eb 0d                	jmp    80151b <strfind+0x1b>
		if (*s == c)
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
  801511:	8a 00                	mov    (%eax),%al
  801513:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801516:	74 0e                	je     801526 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801518:	ff 45 08             	incl   0x8(%ebp)
  80151b:	8b 45 08             	mov    0x8(%ebp),%eax
  80151e:	8a 00                	mov    (%eax),%al
  801520:	84 c0                	test   %al,%al
  801522:	75 ea                	jne    80150e <strfind+0xe>
  801524:	eb 01                	jmp    801527 <strfind+0x27>
		if (*s == c)
			break;
  801526:	90                   	nop
	return (char *) s;
  801527:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80152a:	c9                   	leave  
  80152b:	c3                   	ret    

0080152c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80152c:	55                   	push   %ebp
  80152d:	89 e5                	mov    %esp,%ebp
  80152f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801532:	8b 45 08             	mov    0x8(%ebp),%eax
  801535:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801538:	8b 45 10             	mov    0x10(%ebp),%eax
  80153b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80153e:	eb 0e                	jmp    80154e <memset+0x22>
		*p++ = c;
  801540:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801543:	8d 50 01             	lea    0x1(%eax),%edx
  801546:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801549:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80154e:	ff 4d f8             	decl   -0x8(%ebp)
  801551:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801555:	79 e9                	jns    801540 <memset+0x14>
		*p++ = c;

	return v;
  801557:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80155a:	c9                   	leave  
  80155b:	c3                   	ret    

0080155c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80155c:	55                   	push   %ebp
  80155d:	89 e5                	mov    %esp,%ebp
  80155f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801562:	8b 45 0c             	mov    0xc(%ebp),%eax
  801565:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80156e:	eb 16                	jmp    801586 <memcpy+0x2a>
		*d++ = *s++;
  801570:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801573:	8d 50 01             	lea    0x1(%eax),%edx
  801576:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801579:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80157c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80157f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801582:	8a 12                	mov    (%edx),%dl
  801584:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801586:	8b 45 10             	mov    0x10(%ebp),%eax
  801589:	8d 50 ff             	lea    -0x1(%eax),%edx
  80158c:	89 55 10             	mov    %edx,0x10(%ebp)
  80158f:	85 c0                	test   %eax,%eax
  801591:	75 dd                	jne    801570 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801596:	c9                   	leave  
  801597:	c3                   	ret    

00801598 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
  80159b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80159e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8015aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015b0:	73 50                	jae    801602 <memmove+0x6a>
  8015b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b8:	01 d0                	add    %edx,%eax
  8015ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015bd:	76 43                	jbe    801602 <memmove+0x6a>
		s += n;
  8015bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015cb:	eb 10                	jmp    8015dd <memmove+0x45>
			*--d = *--s;
  8015cd:	ff 4d f8             	decl   -0x8(%ebp)
  8015d0:	ff 4d fc             	decl   -0x4(%ebp)
  8015d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d6:	8a 10                	mov    (%eax),%dl
  8015d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015db:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015e3:	89 55 10             	mov    %edx,0x10(%ebp)
  8015e6:	85 c0                	test   %eax,%eax
  8015e8:	75 e3                	jne    8015cd <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015ea:	eb 23                	jmp    80160f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ef:	8d 50 01             	lea    0x1(%eax),%edx
  8015f2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015fb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015fe:	8a 12                	mov    (%edx),%dl
  801600:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801602:	8b 45 10             	mov    0x10(%ebp),%eax
  801605:	8d 50 ff             	lea    -0x1(%eax),%edx
  801608:	89 55 10             	mov    %edx,0x10(%ebp)
  80160b:	85 c0                	test   %eax,%eax
  80160d:	75 dd                	jne    8015ec <memmove+0x54>
			*d++ = *s++;

	return dst;
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801612:	c9                   	leave  
  801613:	c3                   	ret    

00801614 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801614:	55                   	push   %ebp
  801615:	89 e5                	mov    %esp,%ebp
  801617:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80161a:	8b 45 08             	mov    0x8(%ebp),%eax
  80161d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801620:	8b 45 0c             	mov    0xc(%ebp),%eax
  801623:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801626:	eb 2a                	jmp    801652 <memcmp+0x3e>
		if (*s1 != *s2)
  801628:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80162b:	8a 10                	mov    (%eax),%dl
  80162d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801630:	8a 00                	mov    (%eax),%al
  801632:	38 c2                	cmp    %al,%dl
  801634:	74 16                	je     80164c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801636:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801639:	8a 00                	mov    (%eax),%al
  80163b:	0f b6 d0             	movzbl %al,%edx
  80163e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801641:	8a 00                	mov    (%eax),%al
  801643:	0f b6 c0             	movzbl %al,%eax
  801646:	29 c2                	sub    %eax,%edx
  801648:	89 d0                	mov    %edx,%eax
  80164a:	eb 18                	jmp    801664 <memcmp+0x50>
		s1++, s2++;
  80164c:	ff 45 fc             	incl   -0x4(%ebp)
  80164f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801652:	8b 45 10             	mov    0x10(%ebp),%eax
  801655:	8d 50 ff             	lea    -0x1(%eax),%edx
  801658:	89 55 10             	mov    %edx,0x10(%ebp)
  80165b:	85 c0                	test   %eax,%eax
  80165d:	75 c9                	jne    801628 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80165f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
  801669:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80166c:	8b 55 08             	mov    0x8(%ebp),%edx
  80166f:	8b 45 10             	mov    0x10(%ebp),%eax
  801672:	01 d0                	add    %edx,%eax
  801674:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801677:	eb 15                	jmp    80168e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	8a 00                	mov    (%eax),%al
  80167e:	0f b6 d0             	movzbl %al,%edx
  801681:	8b 45 0c             	mov    0xc(%ebp),%eax
  801684:	0f b6 c0             	movzbl %al,%eax
  801687:	39 c2                	cmp    %eax,%edx
  801689:	74 0d                	je     801698 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80168b:	ff 45 08             	incl   0x8(%ebp)
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801694:	72 e3                	jb     801679 <memfind+0x13>
  801696:	eb 01                	jmp    801699 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801698:	90                   	nop
	return (void *) s;
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80169c:	c9                   	leave  
  80169d:	c3                   	ret    

0080169e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80169e:	55                   	push   %ebp
  80169f:	89 e5                	mov    %esp,%ebp
  8016a1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8016a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016ab:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016b2:	eb 03                	jmp    8016b7 <strtol+0x19>
		s++;
  8016b4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ba:	8a 00                	mov    (%eax),%al
  8016bc:	3c 20                	cmp    $0x20,%al
  8016be:	74 f4                	je     8016b4 <strtol+0x16>
  8016c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c3:	8a 00                	mov    (%eax),%al
  8016c5:	3c 09                	cmp    $0x9,%al
  8016c7:	74 eb                	je     8016b4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cc:	8a 00                	mov    (%eax),%al
  8016ce:	3c 2b                	cmp    $0x2b,%al
  8016d0:	75 05                	jne    8016d7 <strtol+0x39>
		s++;
  8016d2:	ff 45 08             	incl   0x8(%ebp)
  8016d5:	eb 13                	jmp    8016ea <strtol+0x4c>
	else if (*s == '-')
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	8a 00                	mov    (%eax),%al
  8016dc:	3c 2d                	cmp    $0x2d,%al
  8016de:	75 0a                	jne    8016ea <strtol+0x4c>
		s++, neg = 1;
  8016e0:	ff 45 08             	incl   0x8(%ebp)
  8016e3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016ea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016ee:	74 06                	je     8016f6 <strtol+0x58>
  8016f0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016f4:	75 20                	jne    801716 <strtol+0x78>
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	8a 00                	mov    (%eax),%al
  8016fb:	3c 30                	cmp    $0x30,%al
  8016fd:	75 17                	jne    801716 <strtol+0x78>
  8016ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801702:	40                   	inc    %eax
  801703:	8a 00                	mov    (%eax),%al
  801705:	3c 78                	cmp    $0x78,%al
  801707:	75 0d                	jne    801716 <strtol+0x78>
		s += 2, base = 16;
  801709:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80170d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801714:	eb 28                	jmp    80173e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801716:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80171a:	75 15                	jne    801731 <strtol+0x93>
  80171c:	8b 45 08             	mov    0x8(%ebp),%eax
  80171f:	8a 00                	mov    (%eax),%al
  801721:	3c 30                	cmp    $0x30,%al
  801723:	75 0c                	jne    801731 <strtol+0x93>
		s++, base = 8;
  801725:	ff 45 08             	incl   0x8(%ebp)
  801728:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80172f:	eb 0d                	jmp    80173e <strtol+0xa0>
	else if (base == 0)
  801731:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801735:	75 07                	jne    80173e <strtol+0xa0>
		base = 10;
  801737:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80173e:	8b 45 08             	mov    0x8(%ebp),%eax
  801741:	8a 00                	mov    (%eax),%al
  801743:	3c 2f                	cmp    $0x2f,%al
  801745:	7e 19                	jle    801760 <strtol+0xc2>
  801747:	8b 45 08             	mov    0x8(%ebp),%eax
  80174a:	8a 00                	mov    (%eax),%al
  80174c:	3c 39                	cmp    $0x39,%al
  80174e:	7f 10                	jg     801760 <strtol+0xc2>
			dig = *s - '0';
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	8a 00                	mov    (%eax),%al
  801755:	0f be c0             	movsbl %al,%eax
  801758:	83 e8 30             	sub    $0x30,%eax
  80175b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80175e:	eb 42                	jmp    8017a2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801760:	8b 45 08             	mov    0x8(%ebp),%eax
  801763:	8a 00                	mov    (%eax),%al
  801765:	3c 60                	cmp    $0x60,%al
  801767:	7e 19                	jle    801782 <strtol+0xe4>
  801769:	8b 45 08             	mov    0x8(%ebp),%eax
  80176c:	8a 00                	mov    (%eax),%al
  80176e:	3c 7a                	cmp    $0x7a,%al
  801770:	7f 10                	jg     801782 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801772:	8b 45 08             	mov    0x8(%ebp),%eax
  801775:	8a 00                	mov    (%eax),%al
  801777:	0f be c0             	movsbl %al,%eax
  80177a:	83 e8 57             	sub    $0x57,%eax
  80177d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801780:	eb 20                	jmp    8017a2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801782:	8b 45 08             	mov    0x8(%ebp),%eax
  801785:	8a 00                	mov    (%eax),%al
  801787:	3c 40                	cmp    $0x40,%al
  801789:	7e 39                	jle    8017c4 <strtol+0x126>
  80178b:	8b 45 08             	mov    0x8(%ebp),%eax
  80178e:	8a 00                	mov    (%eax),%al
  801790:	3c 5a                	cmp    $0x5a,%al
  801792:	7f 30                	jg     8017c4 <strtol+0x126>
			dig = *s - 'A' + 10;
  801794:	8b 45 08             	mov    0x8(%ebp),%eax
  801797:	8a 00                	mov    (%eax),%al
  801799:	0f be c0             	movsbl %al,%eax
  80179c:	83 e8 37             	sub    $0x37,%eax
  80179f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8017a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017a5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8017a8:	7d 19                	jge    8017c3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8017aa:	ff 45 08             	incl   0x8(%ebp)
  8017ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017b0:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017b4:	89 c2                	mov    %eax,%edx
  8017b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017b9:	01 d0                	add    %edx,%eax
  8017bb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017be:	e9 7b ff ff ff       	jmp    80173e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017c3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017c4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017c8:	74 08                	je     8017d2 <strtol+0x134>
		*endptr = (char *) s;
  8017ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cd:	8b 55 08             	mov    0x8(%ebp),%edx
  8017d0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017d2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017d6:	74 07                	je     8017df <strtol+0x141>
  8017d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017db:	f7 d8                	neg    %eax
  8017dd:	eb 03                	jmp    8017e2 <strtol+0x144>
  8017df:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017e2:	c9                   	leave  
  8017e3:	c3                   	ret    

008017e4 <ltostr>:

void
ltostr(long value, char *str)
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
  8017e7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017f1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017f8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017fc:	79 13                	jns    801811 <ltostr+0x2d>
	{
		neg = 1;
  8017fe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801805:	8b 45 0c             	mov    0xc(%ebp),%eax
  801808:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80180b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80180e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801811:	8b 45 08             	mov    0x8(%ebp),%eax
  801814:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801819:	99                   	cltd   
  80181a:	f7 f9                	idiv   %ecx
  80181c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80181f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801822:	8d 50 01             	lea    0x1(%eax),%edx
  801825:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801828:	89 c2                	mov    %eax,%edx
  80182a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182d:	01 d0                	add    %edx,%eax
  80182f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801832:	83 c2 30             	add    $0x30,%edx
  801835:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801837:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80183a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80183f:	f7 e9                	imul   %ecx
  801841:	c1 fa 02             	sar    $0x2,%edx
  801844:	89 c8                	mov    %ecx,%eax
  801846:	c1 f8 1f             	sar    $0x1f,%eax
  801849:	29 c2                	sub    %eax,%edx
  80184b:	89 d0                	mov    %edx,%eax
  80184d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801850:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801853:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801858:	f7 e9                	imul   %ecx
  80185a:	c1 fa 02             	sar    $0x2,%edx
  80185d:	89 c8                	mov    %ecx,%eax
  80185f:	c1 f8 1f             	sar    $0x1f,%eax
  801862:	29 c2                	sub    %eax,%edx
  801864:	89 d0                	mov    %edx,%eax
  801866:	c1 e0 02             	shl    $0x2,%eax
  801869:	01 d0                	add    %edx,%eax
  80186b:	01 c0                	add    %eax,%eax
  80186d:	29 c1                	sub    %eax,%ecx
  80186f:	89 ca                	mov    %ecx,%edx
  801871:	85 d2                	test   %edx,%edx
  801873:	75 9c                	jne    801811 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801875:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80187c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187f:	48                   	dec    %eax
  801880:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801883:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801887:	74 3d                	je     8018c6 <ltostr+0xe2>
		start = 1 ;
  801889:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801890:	eb 34                	jmp    8018c6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801892:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801895:	8b 45 0c             	mov    0xc(%ebp),%eax
  801898:	01 d0                	add    %edx,%eax
  80189a:	8a 00                	mov    (%eax),%al
  80189c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80189f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a5:	01 c2                	add    %eax,%edx
  8018a7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8018aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ad:	01 c8                	add    %ecx,%eax
  8018af:	8a 00                	mov    (%eax),%al
  8018b1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018b3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b9:	01 c2                	add    %eax,%edx
  8018bb:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018be:	88 02                	mov    %al,(%edx)
		start++ ;
  8018c0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018c3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018cc:	7c c4                	jl     801892 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018ce:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d4:	01 d0                	add    %edx,%eax
  8018d6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018d9:	90                   	nop
  8018da:	c9                   	leave  
  8018db:	c3                   	ret    

008018dc <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018dc:	55                   	push   %ebp
  8018dd:	89 e5                	mov    %esp,%ebp
  8018df:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018e2:	ff 75 08             	pushl  0x8(%ebp)
  8018e5:	e8 54 fa ff ff       	call   80133e <strlen>
  8018ea:	83 c4 04             	add    $0x4,%esp
  8018ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018f0:	ff 75 0c             	pushl  0xc(%ebp)
  8018f3:	e8 46 fa ff ff       	call   80133e <strlen>
  8018f8:	83 c4 04             	add    $0x4,%esp
  8018fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801905:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80190c:	eb 17                	jmp    801925 <strcconcat+0x49>
		final[s] = str1[s] ;
  80190e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801911:	8b 45 10             	mov    0x10(%ebp),%eax
  801914:	01 c2                	add    %eax,%edx
  801916:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801919:	8b 45 08             	mov    0x8(%ebp),%eax
  80191c:	01 c8                	add    %ecx,%eax
  80191e:	8a 00                	mov    (%eax),%al
  801920:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801922:	ff 45 fc             	incl   -0x4(%ebp)
  801925:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801928:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80192b:	7c e1                	jl     80190e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80192d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801934:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80193b:	eb 1f                	jmp    80195c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80193d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801940:	8d 50 01             	lea    0x1(%eax),%edx
  801943:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801946:	89 c2                	mov    %eax,%edx
  801948:	8b 45 10             	mov    0x10(%ebp),%eax
  80194b:	01 c2                	add    %eax,%edx
  80194d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801950:	8b 45 0c             	mov    0xc(%ebp),%eax
  801953:	01 c8                	add    %ecx,%eax
  801955:	8a 00                	mov    (%eax),%al
  801957:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801959:	ff 45 f8             	incl   -0x8(%ebp)
  80195c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801962:	7c d9                	jl     80193d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801964:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801967:	8b 45 10             	mov    0x10(%ebp),%eax
  80196a:	01 d0                	add    %edx,%eax
  80196c:	c6 00 00             	movb   $0x0,(%eax)
}
  80196f:	90                   	nop
  801970:	c9                   	leave  
  801971:	c3                   	ret    

00801972 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801972:	55                   	push   %ebp
  801973:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801975:	8b 45 14             	mov    0x14(%ebp),%eax
  801978:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80197e:	8b 45 14             	mov    0x14(%ebp),%eax
  801981:	8b 00                	mov    (%eax),%eax
  801983:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80198a:	8b 45 10             	mov    0x10(%ebp),%eax
  80198d:	01 d0                	add    %edx,%eax
  80198f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801995:	eb 0c                	jmp    8019a3 <strsplit+0x31>
			*string++ = 0;
  801997:	8b 45 08             	mov    0x8(%ebp),%eax
  80199a:	8d 50 01             	lea    0x1(%eax),%edx
  80199d:	89 55 08             	mov    %edx,0x8(%ebp)
  8019a0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	8a 00                	mov    (%eax),%al
  8019a8:	84 c0                	test   %al,%al
  8019aa:	74 18                	je     8019c4 <strsplit+0x52>
  8019ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8019af:	8a 00                	mov    (%eax),%al
  8019b1:	0f be c0             	movsbl %al,%eax
  8019b4:	50                   	push   %eax
  8019b5:	ff 75 0c             	pushl  0xc(%ebp)
  8019b8:	e8 13 fb ff ff       	call   8014d0 <strchr>
  8019bd:	83 c4 08             	add    $0x8,%esp
  8019c0:	85 c0                	test   %eax,%eax
  8019c2:	75 d3                	jne    801997 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8019c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c7:	8a 00                	mov    (%eax),%al
  8019c9:	84 c0                	test   %al,%al
  8019cb:	74 5a                	je     801a27 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8019cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8019d0:	8b 00                	mov    (%eax),%eax
  8019d2:	83 f8 0f             	cmp    $0xf,%eax
  8019d5:	75 07                	jne    8019de <strsplit+0x6c>
		{
			return 0;
  8019d7:	b8 00 00 00 00       	mov    $0x0,%eax
  8019dc:	eb 66                	jmp    801a44 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019de:	8b 45 14             	mov    0x14(%ebp),%eax
  8019e1:	8b 00                	mov    (%eax),%eax
  8019e3:	8d 48 01             	lea    0x1(%eax),%ecx
  8019e6:	8b 55 14             	mov    0x14(%ebp),%edx
  8019e9:	89 0a                	mov    %ecx,(%edx)
  8019eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f5:	01 c2                	add    %eax,%edx
  8019f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fa:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019fc:	eb 03                	jmp    801a01 <strsplit+0x8f>
			string++;
  8019fe:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a01:	8b 45 08             	mov    0x8(%ebp),%eax
  801a04:	8a 00                	mov    (%eax),%al
  801a06:	84 c0                	test   %al,%al
  801a08:	74 8b                	je     801995 <strsplit+0x23>
  801a0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0d:	8a 00                	mov    (%eax),%al
  801a0f:	0f be c0             	movsbl %al,%eax
  801a12:	50                   	push   %eax
  801a13:	ff 75 0c             	pushl  0xc(%ebp)
  801a16:	e8 b5 fa ff ff       	call   8014d0 <strchr>
  801a1b:	83 c4 08             	add    $0x8,%esp
  801a1e:	85 c0                	test   %eax,%eax
  801a20:	74 dc                	je     8019fe <strsplit+0x8c>
			string++;
	}
  801a22:	e9 6e ff ff ff       	jmp    801995 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a27:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a28:	8b 45 14             	mov    0x14(%ebp),%eax
  801a2b:	8b 00                	mov    (%eax),%eax
  801a2d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a34:	8b 45 10             	mov    0x10(%ebp),%eax
  801a37:	01 d0                	add    %edx,%eax
  801a39:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a3f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a44:	c9                   	leave  
  801a45:	c3                   	ret    

00801a46 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801a46:	55                   	push   %ebp
  801a47:	89 e5                	mov    %esp,%ebp
  801a49:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801a4c:	83 ec 04             	sub    $0x4,%esp
  801a4f:	68 10 2b 80 00       	push   $0x802b10
  801a54:	6a 16                	push   $0x16
  801a56:	68 35 2b 80 00       	push   $0x802b35
  801a5b:	e8 ba ef ff ff       	call   800a1a <_panic>

00801a60 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801a60:	55                   	push   %ebp
  801a61:	89 e5                	mov    %esp,%ebp
  801a63:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801a66:	83 ec 04             	sub    $0x4,%esp
  801a69:	68 44 2b 80 00       	push   $0x802b44
  801a6e:	6a 2e                	push   $0x2e
  801a70:	68 35 2b 80 00       	push   $0x802b35
  801a75:	e8 a0 ef ff ff       	call   800a1a <_panic>

00801a7a <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a7a:	55                   	push   %ebp
  801a7b:	89 e5                	mov    %esp,%ebp
  801a7d:	83 ec 18             	sub    $0x18,%esp
  801a80:	8b 45 10             	mov    0x10(%ebp),%eax
  801a83:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a86:	83 ec 04             	sub    $0x4,%esp
  801a89:	68 68 2b 80 00       	push   $0x802b68
  801a8e:	6a 3b                	push   $0x3b
  801a90:	68 35 2b 80 00       	push   $0x802b35
  801a95:	e8 80 ef ff ff       	call   800a1a <_panic>

00801a9a <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a9a:	55                   	push   %ebp
  801a9b:	89 e5                	mov    %esp,%ebp
  801a9d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aa0:	83 ec 04             	sub    $0x4,%esp
  801aa3:	68 68 2b 80 00       	push   $0x802b68
  801aa8:	6a 41                	push   $0x41
  801aaa:	68 35 2b 80 00       	push   $0x802b35
  801aaf:	e8 66 ef ff ff       	call   800a1a <_panic>

00801ab4 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801ab4:	55                   	push   %ebp
  801ab5:	89 e5                	mov    %esp,%ebp
  801ab7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aba:	83 ec 04             	sub    $0x4,%esp
  801abd:	68 68 2b 80 00       	push   $0x802b68
  801ac2:	6a 47                	push   $0x47
  801ac4:	68 35 2b 80 00       	push   $0x802b35
  801ac9:	e8 4c ef ff ff       	call   800a1a <_panic>

00801ace <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801ace:	55                   	push   %ebp
  801acf:	89 e5                	mov    %esp,%ebp
  801ad1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ad4:	83 ec 04             	sub    $0x4,%esp
  801ad7:	68 68 2b 80 00       	push   $0x802b68
  801adc:	6a 4c                	push   $0x4c
  801ade:	68 35 2b 80 00       	push   $0x802b35
  801ae3:	e8 32 ef ff ff       	call   800a1a <_panic>

00801ae8 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801ae8:	55                   	push   %ebp
  801ae9:	89 e5                	mov    %esp,%ebp
  801aeb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aee:	83 ec 04             	sub    $0x4,%esp
  801af1:	68 68 2b 80 00       	push   $0x802b68
  801af6:	6a 52                	push   $0x52
  801af8:	68 35 2b 80 00       	push   $0x802b35
  801afd:	e8 18 ef ff ff       	call   800a1a <_panic>

00801b02 <shrink>:
}
void shrink(uint32 newSize)
{
  801b02:	55                   	push   %ebp
  801b03:	89 e5                	mov    %esp,%ebp
  801b05:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b08:	83 ec 04             	sub    $0x4,%esp
  801b0b:	68 68 2b 80 00       	push   $0x802b68
  801b10:	6a 56                	push   $0x56
  801b12:	68 35 2b 80 00       	push   $0x802b35
  801b17:	e8 fe ee ff ff       	call   800a1a <_panic>

00801b1c <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801b1c:	55                   	push   %ebp
  801b1d:	89 e5                	mov    %esp,%ebp
  801b1f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b22:	83 ec 04             	sub    $0x4,%esp
  801b25:	68 68 2b 80 00       	push   $0x802b68
  801b2a:	6a 5b                	push   $0x5b
  801b2c:	68 35 2b 80 00       	push   $0x802b35
  801b31:	e8 e4 ee ff ff       	call   800a1a <_panic>

00801b36 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b36:	55                   	push   %ebp
  801b37:	89 e5                	mov    %esp,%ebp
  801b39:	57                   	push   %edi
  801b3a:	56                   	push   %esi
  801b3b:	53                   	push   %ebx
  801b3c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b42:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b45:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b48:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b4b:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b4e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b51:	cd 30                	int    $0x30
  801b53:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b56:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b59:	83 c4 10             	add    $0x10,%esp
  801b5c:	5b                   	pop    %ebx
  801b5d:	5e                   	pop    %esi
  801b5e:	5f                   	pop    %edi
  801b5f:	5d                   	pop    %ebp
  801b60:	c3                   	ret    

00801b61 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b61:	55                   	push   %ebp
  801b62:	89 e5                	mov    %esp,%ebp
  801b64:	83 ec 04             	sub    $0x4,%esp
  801b67:	8b 45 10             	mov    0x10(%ebp),%eax
  801b6a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b6d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b71:	8b 45 08             	mov    0x8(%ebp),%eax
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	52                   	push   %edx
  801b79:	ff 75 0c             	pushl  0xc(%ebp)
  801b7c:	50                   	push   %eax
  801b7d:	6a 00                	push   $0x0
  801b7f:	e8 b2 ff ff ff       	call   801b36 <syscall>
  801b84:	83 c4 18             	add    $0x18,%esp
}
  801b87:	90                   	nop
  801b88:	c9                   	leave  
  801b89:	c3                   	ret    

00801b8a <sys_cgetc>:

int
sys_cgetc(void)
{
  801b8a:	55                   	push   %ebp
  801b8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 01                	push   $0x1
  801b99:	e8 98 ff ff ff       	call   801b36 <syscall>
  801b9e:	83 c4 18             	add    $0x18,%esp
}
  801ba1:	c9                   	leave  
  801ba2:	c3                   	ret    

00801ba3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ba3:	55                   	push   %ebp
  801ba4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	50                   	push   %eax
  801bb2:	6a 05                	push   $0x5
  801bb4:	e8 7d ff ff ff       	call   801b36 <syscall>
  801bb9:	83 c4 18             	add    $0x18,%esp
}
  801bbc:	c9                   	leave  
  801bbd:	c3                   	ret    

00801bbe <sys_getenvid>:

int32 sys_getenvid(void)
{
  801bbe:	55                   	push   %ebp
  801bbf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 02                	push   $0x2
  801bcd:	e8 64 ff ff ff       	call   801b36 <syscall>
  801bd2:	83 c4 18             	add    $0x18,%esp
}
  801bd5:	c9                   	leave  
  801bd6:	c3                   	ret    

00801bd7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801bd7:	55                   	push   %ebp
  801bd8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 03                	push   $0x3
  801be6:	e8 4b ff ff ff       	call   801b36 <syscall>
  801beb:	83 c4 18             	add    $0x18,%esp
}
  801bee:	c9                   	leave  
  801bef:	c3                   	ret    

00801bf0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801bf0:	55                   	push   %ebp
  801bf1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 04                	push   $0x4
  801bff:	e8 32 ff ff ff       	call   801b36 <syscall>
  801c04:	83 c4 18             	add    $0x18,%esp
}
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    

00801c09 <sys_env_exit>:


void sys_env_exit(void)
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 06                	push   $0x6
  801c18:	e8 19 ff ff ff       	call   801b36 <syscall>
  801c1d:	83 c4 18             	add    $0x18,%esp
}
  801c20:	90                   	nop
  801c21:	c9                   	leave  
  801c22:	c3                   	ret    

00801c23 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c23:	55                   	push   %ebp
  801c24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c26:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c29:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	52                   	push   %edx
  801c33:	50                   	push   %eax
  801c34:	6a 07                	push   $0x7
  801c36:	e8 fb fe ff ff       	call   801b36 <syscall>
  801c3b:	83 c4 18             	add    $0x18,%esp
}
  801c3e:	c9                   	leave  
  801c3f:	c3                   	ret    

00801c40 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c40:	55                   	push   %ebp
  801c41:	89 e5                	mov    %esp,%ebp
  801c43:	56                   	push   %esi
  801c44:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c45:	8b 75 18             	mov    0x18(%ebp),%esi
  801c48:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c4b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c51:	8b 45 08             	mov    0x8(%ebp),%eax
  801c54:	56                   	push   %esi
  801c55:	53                   	push   %ebx
  801c56:	51                   	push   %ecx
  801c57:	52                   	push   %edx
  801c58:	50                   	push   %eax
  801c59:	6a 08                	push   $0x8
  801c5b:	e8 d6 fe ff ff       	call   801b36 <syscall>
  801c60:	83 c4 18             	add    $0x18,%esp
}
  801c63:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c66:	5b                   	pop    %ebx
  801c67:	5e                   	pop    %esi
  801c68:	5d                   	pop    %ebp
  801c69:	c3                   	ret    

00801c6a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c6a:	55                   	push   %ebp
  801c6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c70:	8b 45 08             	mov    0x8(%ebp),%eax
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	52                   	push   %edx
  801c7a:	50                   	push   %eax
  801c7b:	6a 09                	push   $0x9
  801c7d:	e8 b4 fe ff ff       	call   801b36 <syscall>
  801c82:	83 c4 18             	add    $0x18,%esp
}
  801c85:	c9                   	leave  
  801c86:	c3                   	ret    

00801c87 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c87:	55                   	push   %ebp
  801c88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	ff 75 0c             	pushl  0xc(%ebp)
  801c93:	ff 75 08             	pushl  0x8(%ebp)
  801c96:	6a 0a                	push   $0xa
  801c98:	e8 99 fe ff ff       	call   801b36 <syscall>
  801c9d:	83 c4 18             	add    $0x18,%esp
}
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    

00801ca2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 0b                	push   $0xb
  801cb1:	e8 80 fe ff ff       	call   801b36 <syscall>
  801cb6:	83 c4 18             	add    $0x18,%esp
}
  801cb9:	c9                   	leave  
  801cba:	c3                   	ret    

00801cbb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801cbb:	55                   	push   %ebp
  801cbc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 0c                	push   $0xc
  801cca:	e8 67 fe ff ff       	call   801b36 <syscall>
  801ccf:	83 c4 18             	add    $0x18,%esp
}
  801cd2:	c9                   	leave  
  801cd3:	c3                   	ret    

00801cd4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801cd4:	55                   	push   %ebp
  801cd5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 0d                	push   $0xd
  801ce3:	e8 4e fe ff ff       	call   801b36 <syscall>
  801ce8:	83 c4 18             	add    $0x18,%esp
}
  801ceb:	c9                   	leave  
  801cec:	c3                   	ret    

00801ced <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ced:	55                   	push   %ebp
  801cee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	ff 75 0c             	pushl  0xc(%ebp)
  801cf9:	ff 75 08             	pushl  0x8(%ebp)
  801cfc:	6a 11                	push   $0x11
  801cfe:	e8 33 fe ff ff       	call   801b36 <syscall>
  801d03:	83 c4 18             	add    $0x18,%esp
	return;
  801d06:	90                   	nop
}
  801d07:	c9                   	leave  
  801d08:	c3                   	ret    

00801d09 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d09:	55                   	push   %ebp
  801d0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	ff 75 0c             	pushl  0xc(%ebp)
  801d15:	ff 75 08             	pushl  0x8(%ebp)
  801d18:	6a 12                	push   $0x12
  801d1a:	e8 17 fe ff ff       	call   801b36 <syscall>
  801d1f:	83 c4 18             	add    $0x18,%esp
	return ;
  801d22:	90                   	nop
}
  801d23:	c9                   	leave  
  801d24:	c3                   	ret    

00801d25 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d25:	55                   	push   %ebp
  801d26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 0e                	push   $0xe
  801d34:	e8 fd fd ff ff       	call   801b36 <syscall>
  801d39:	83 c4 18             	add    $0x18,%esp
}
  801d3c:	c9                   	leave  
  801d3d:	c3                   	ret    

00801d3e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d3e:	55                   	push   %ebp
  801d3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	ff 75 08             	pushl  0x8(%ebp)
  801d4c:	6a 0f                	push   $0xf
  801d4e:	e8 e3 fd ff ff       	call   801b36 <syscall>
  801d53:	83 c4 18             	add    $0x18,%esp
}
  801d56:	c9                   	leave  
  801d57:	c3                   	ret    

00801d58 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d58:	55                   	push   %ebp
  801d59:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	6a 00                	push   $0x0
  801d65:	6a 10                	push   $0x10
  801d67:	e8 ca fd ff ff       	call   801b36 <syscall>
  801d6c:	83 c4 18             	add    $0x18,%esp
}
  801d6f:	90                   	nop
  801d70:	c9                   	leave  
  801d71:	c3                   	ret    

00801d72 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d72:	55                   	push   %ebp
  801d73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 14                	push   $0x14
  801d81:	e8 b0 fd ff ff       	call   801b36 <syscall>
  801d86:	83 c4 18             	add    $0x18,%esp
}
  801d89:	90                   	nop
  801d8a:	c9                   	leave  
  801d8b:	c3                   	ret    

00801d8c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d8c:	55                   	push   %ebp
  801d8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 00                	push   $0x0
  801d99:	6a 15                	push   $0x15
  801d9b:	e8 96 fd ff ff       	call   801b36 <syscall>
  801da0:	83 c4 18             	add    $0x18,%esp
}
  801da3:	90                   	nop
  801da4:	c9                   	leave  
  801da5:	c3                   	ret    

00801da6 <sys_cputc>:


void
sys_cputc(const char c)
{
  801da6:	55                   	push   %ebp
  801da7:	89 e5                	mov    %esp,%ebp
  801da9:	83 ec 04             	sub    $0x4,%esp
  801dac:	8b 45 08             	mov    0x8(%ebp),%eax
  801daf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801db2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	50                   	push   %eax
  801dbf:	6a 16                	push   $0x16
  801dc1:	e8 70 fd ff ff       	call   801b36 <syscall>
  801dc6:	83 c4 18             	add    $0x18,%esp
}
  801dc9:	90                   	nop
  801dca:	c9                   	leave  
  801dcb:	c3                   	ret    

00801dcc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801dcc:	55                   	push   %ebp
  801dcd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 17                	push   $0x17
  801ddb:	e8 56 fd ff ff       	call   801b36 <syscall>
  801de0:	83 c4 18             	add    $0x18,%esp
}
  801de3:	90                   	nop
  801de4:	c9                   	leave  
  801de5:	c3                   	ret    

00801de6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801de6:	55                   	push   %ebp
  801de7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801de9:	8b 45 08             	mov    0x8(%ebp),%eax
  801dec:	6a 00                	push   $0x0
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	ff 75 0c             	pushl  0xc(%ebp)
  801df5:	50                   	push   %eax
  801df6:	6a 18                	push   $0x18
  801df8:	e8 39 fd ff ff       	call   801b36 <syscall>
  801dfd:	83 c4 18             	add    $0x18,%esp
}
  801e00:	c9                   	leave  
  801e01:	c3                   	ret    

00801e02 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e02:	55                   	push   %ebp
  801e03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e05:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e08:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	52                   	push   %edx
  801e12:	50                   	push   %eax
  801e13:	6a 1b                	push   $0x1b
  801e15:	e8 1c fd ff ff       	call   801b36 <syscall>
  801e1a:	83 c4 18             	add    $0x18,%esp
}
  801e1d:	c9                   	leave  
  801e1e:	c3                   	ret    

00801e1f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e1f:	55                   	push   %ebp
  801e20:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e22:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e25:	8b 45 08             	mov    0x8(%ebp),%eax
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 00                	push   $0x0
  801e2e:	52                   	push   %edx
  801e2f:	50                   	push   %eax
  801e30:	6a 19                	push   $0x19
  801e32:	e8 ff fc ff ff       	call   801b36 <syscall>
  801e37:	83 c4 18             	add    $0x18,%esp
}
  801e3a:	90                   	nop
  801e3b:	c9                   	leave  
  801e3c:	c3                   	ret    

00801e3d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e3d:	55                   	push   %ebp
  801e3e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e40:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e43:	8b 45 08             	mov    0x8(%ebp),%eax
  801e46:	6a 00                	push   $0x0
  801e48:	6a 00                	push   $0x0
  801e4a:	6a 00                	push   $0x0
  801e4c:	52                   	push   %edx
  801e4d:	50                   	push   %eax
  801e4e:	6a 1a                	push   $0x1a
  801e50:	e8 e1 fc ff ff       	call   801b36 <syscall>
  801e55:	83 c4 18             	add    $0x18,%esp
}
  801e58:	90                   	nop
  801e59:	c9                   	leave  
  801e5a:	c3                   	ret    

00801e5b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e5b:	55                   	push   %ebp
  801e5c:	89 e5                	mov    %esp,%ebp
  801e5e:	83 ec 04             	sub    $0x4,%esp
  801e61:	8b 45 10             	mov    0x10(%ebp),%eax
  801e64:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e67:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e6a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e71:	6a 00                	push   $0x0
  801e73:	51                   	push   %ecx
  801e74:	52                   	push   %edx
  801e75:	ff 75 0c             	pushl  0xc(%ebp)
  801e78:	50                   	push   %eax
  801e79:	6a 1c                	push   $0x1c
  801e7b:	e8 b6 fc ff ff       	call   801b36 <syscall>
  801e80:	83 c4 18             	add    $0x18,%esp
}
  801e83:	c9                   	leave  
  801e84:	c3                   	ret    

00801e85 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e85:	55                   	push   %ebp
  801e86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e88:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	52                   	push   %edx
  801e95:	50                   	push   %eax
  801e96:	6a 1d                	push   $0x1d
  801e98:	e8 99 fc ff ff       	call   801b36 <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
}
  801ea0:	c9                   	leave  
  801ea1:	c3                   	ret    

00801ea2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ea2:	55                   	push   %ebp
  801ea3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ea5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ea8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eab:	8b 45 08             	mov    0x8(%ebp),%eax
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 00                	push   $0x0
  801eb2:	51                   	push   %ecx
  801eb3:	52                   	push   %edx
  801eb4:	50                   	push   %eax
  801eb5:	6a 1e                	push   $0x1e
  801eb7:	e8 7a fc ff ff       	call   801b36 <syscall>
  801ebc:	83 c4 18             	add    $0x18,%esp
}
  801ebf:	c9                   	leave  
  801ec0:	c3                   	ret    

00801ec1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ec1:	55                   	push   %ebp
  801ec2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ec4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 00                	push   $0x0
  801ed0:	52                   	push   %edx
  801ed1:	50                   	push   %eax
  801ed2:	6a 1f                	push   $0x1f
  801ed4:	e8 5d fc ff ff       	call   801b36 <syscall>
  801ed9:	83 c4 18             	add    $0x18,%esp
}
  801edc:	c9                   	leave  
  801edd:	c3                   	ret    

00801ede <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ede:	55                   	push   %ebp
  801edf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 20                	push   $0x20
  801eed:	e8 44 fc ff ff       	call   801b36 <syscall>
  801ef2:	83 c4 18             	add    $0x18,%esp
}
  801ef5:	c9                   	leave  
  801ef6:	c3                   	ret    

00801ef7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ef7:	55                   	push   %ebp
  801ef8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801efa:	8b 45 08             	mov    0x8(%ebp),%eax
  801efd:	6a 00                	push   $0x0
  801eff:	ff 75 14             	pushl  0x14(%ebp)
  801f02:	ff 75 10             	pushl  0x10(%ebp)
  801f05:	ff 75 0c             	pushl  0xc(%ebp)
  801f08:	50                   	push   %eax
  801f09:	6a 21                	push   $0x21
  801f0b:	e8 26 fc ff ff       	call   801b36 <syscall>
  801f10:	83 c4 18             	add    $0x18,%esp
}
  801f13:	c9                   	leave  
  801f14:	c3                   	ret    

00801f15 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801f15:	55                   	push   %ebp
  801f16:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f18:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	50                   	push   %eax
  801f24:	6a 22                	push   $0x22
  801f26:	e8 0b fc ff ff       	call   801b36 <syscall>
  801f2b:	83 c4 18             	add    $0x18,%esp
}
  801f2e:	90                   	nop
  801f2f:	c9                   	leave  
  801f30:	c3                   	ret    

00801f31 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f31:	55                   	push   %ebp
  801f32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f34:	8b 45 08             	mov    0x8(%ebp),%eax
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	50                   	push   %eax
  801f40:	6a 23                	push   $0x23
  801f42:	e8 ef fb ff ff       	call   801b36 <syscall>
  801f47:	83 c4 18             	add    $0x18,%esp
}
  801f4a:	90                   	nop
  801f4b:	c9                   	leave  
  801f4c:	c3                   	ret    

00801f4d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f4d:	55                   	push   %ebp
  801f4e:	89 e5                	mov    %esp,%ebp
  801f50:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f53:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f56:	8d 50 04             	lea    0x4(%eax),%edx
  801f59:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	52                   	push   %edx
  801f63:	50                   	push   %eax
  801f64:	6a 24                	push   $0x24
  801f66:	e8 cb fb ff ff       	call   801b36 <syscall>
  801f6b:	83 c4 18             	add    $0x18,%esp
	return result;
  801f6e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f74:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f77:	89 01                	mov    %eax,(%ecx)
  801f79:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7f:	c9                   	leave  
  801f80:	c2 04 00             	ret    $0x4

00801f83 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f83:	55                   	push   %ebp
  801f84:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f86:	6a 00                	push   $0x0
  801f88:	6a 00                	push   $0x0
  801f8a:	ff 75 10             	pushl  0x10(%ebp)
  801f8d:	ff 75 0c             	pushl  0xc(%ebp)
  801f90:	ff 75 08             	pushl  0x8(%ebp)
  801f93:	6a 13                	push   $0x13
  801f95:	e8 9c fb ff ff       	call   801b36 <syscall>
  801f9a:	83 c4 18             	add    $0x18,%esp
	return ;
  801f9d:	90                   	nop
}
  801f9e:	c9                   	leave  
  801f9f:	c3                   	ret    

00801fa0 <sys_rcr2>:
uint32 sys_rcr2()
{
  801fa0:	55                   	push   %ebp
  801fa1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fa3:	6a 00                	push   $0x0
  801fa5:	6a 00                	push   $0x0
  801fa7:	6a 00                	push   $0x0
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 00                	push   $0x0
  801fad:	6a 25                	push   $0x25
  801faf:	e8 82 fb ff ff       	call   801b36 <syscall>
  801fb4:	83 c4 18             	add    $0x18,%esp
}
  801fb7:	c9                   	leave  
  801fb8:	c3                   	ret    

00801fb9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801fb9:	55                   	push   %ebp
  801fba:	89 e5                	mov    %esp,%ebp
  801fbc:	83 ec 04             	sub    $0x4,%esp
  801fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801fc5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	50                   	push   %eax
  801fd2:	6a 26                	push   $0x26
  801fd4:	e8 5d fb ff ff       	call   801b36 <syscall>
  801fd9:	83 c4 18             	add    $0x18,%esp
	return ;
  801fdc:	90                   	nop
}
  801fdd:	c9                   	leave  
  801fde:	c3                   	ret    

00801fdf <rsttst>:
void rsttst()
{
  801fdf:	55                   	push   %ebp
  801fe0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 28                	push   $0x28
  801fee:	e8 43 fb ff ff       	call   801b36 <syscall>
  801ff3:	83 c4 18             	add    $0x18,%esp
	return ;
  801ff6:	90                   	nop
}
  801ff7:	c9                   	leave  
  801ff8:	c3                   	ret    

00801ff9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ff9:	55                   	push   %ebp
  801ffa:	89 e5                	mov    %esp,%ebp
  801ffc:	83 ec 04             	sub    $0x4,%esp
  801fff:	8b 45 14             	mov    0x14(%ebp),%eax
  802002:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802005:	8b 55 18             	mov    0x18(%ebp),%edx
  802008:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80200c:	52                   	push   %edx
  80200d:	50                   	push   %eax
  80200e:	ff 75 10             	pushl  0x10(%ebp)
  802011:	ff 75 0c             	pushl  0xc(%ebp)
  802014:	ff 75 08             	pushl  0x8(%ebp)
  802017:	6a 27                	push   $0x27
  802019:	e8 18 fb ff ff       	call   801b36 <syscall>
  80201e:	83 c4 18             	add    $0x18,%esp
	return ;
  802021:	90                   	nop
}
  802022:	c9                   	leave  
  802023:	c3                   	ret    

00802024 <chktst>:
void chktst(uint32 n)
{
  802024:	55                   	push   %ebp
  802025:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802027:	6a 00                	push   $0x0
  802029:	6a 00                	push   $0x0
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	ff 75 08             	pushl  0x8(%ebp)
  802032:	6a 29                	push   $0x29
  802034:	e8 fd fa ff ff       	call   801b36 <syscall>
  802039:	83 c4 18             	add    $0x18,%esp
	return ;
  80203c:	90                   	nop
}
  80203d:	c9                   	leave  
  80203e:	c3                   	ret    

0080203f <inctst>:

void inctst()
{
  80203f:	55                   	push   %ebp
  802040:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 2a                	push   $0x2a
  80204e:	e8 e3 fa ff ff       	call   801b36 <syscall>
  802053:	83 c4 18             	add    $0x18,%esp
	return ;
  802056:	90                   	nop
}
  802057:	c9                   	leave  
  802058:	c3                   	ret    

00802059 <gettst>:
uint32 gettst()
{
  802059:	55                   	push   %ebp
  80205a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 2b                	push   $0x2b
  802068:	e8 c9 fa ff ff       	call   801b36 <syscall>
  80206d:	83 c4 18             	add    $0x18,%esp
}
  802070:	c9                   	leave  
  802071:	c3                   	ret    

00802072 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802072:	55                   	push   %ebp
  802073:	89 e5                	mov    %esp,%ebp
  802075:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 00                	push   $0x0
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 2c                	push   $0x2c
  802084:	e8 ad fa ff ff       	call   801b36 <syscall>
  802089:	83 c4 18             	add    $0x18,%esp
  80208c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80208f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802093:	75 07                	jne    80209c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802095:	b8 01 00 00 00       	mov    $0x1,%eax
  80209a:	eb 05                	jmp    8020a1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80209c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020a1:	c9                   	leave  
  8020a2:	c3                   	ret    

008020a3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8020a3:	55                   	push   %ebp
  8020a4:	89 e5                	mov    %esp,%ebp
  8020a6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 2c                	push   $0x2c
  8020b5:	e8 7c fa ff ff       	call   801b36 <syscall>
  8020ba:	83 c4 18             	add    $0x18,%esp
  8020bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8020c0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8020c4:	75 07                	jne    8020cd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8020c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8020cb:	eb 05                	jmp    8020d2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8020cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020d2:	c9                   	leave  
  8020d3:	c3                   	ret    

008020d4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8020d4:	55                   	push   %ebp
  8020d5:	89 e5                	mov    %esp,%ebp
  8020d7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020da:	6a 00                	push   $0x0
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 00                	push   $0x0
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 2c                	push   $0x2c
  8020e6:	e8 4b fa ff ff       	call   801b36 <syscall>
  8020eb:	83 c4 18             	add    $0x18,%esp
  8020ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8020f1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8020f5:	75 07                	jne    8020fe <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8020f7:	b8 01 00 00 00       	mov    $0x1,%eax
  8020fc:	eb 05                	jmp    802103 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8020fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802103:	c9                   	leave  
  802104:	c3                   	ret    

00802105 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802105:	55                   	push   %ebp
  802106:	89 e5                	mov    %esp,%ebp
  802108:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80210b:	6a 00                	push   $0x0
  80210d:	6a 00                	push   $0x0
  80210f:	6a 00                	push   $0x0
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 2c                	push   $0x2c
  802117:	e8 1a fa ff ff       	call   801b36 <syscall>
  80211c:	83 c4 18             	add    $0x18,%esp
  80211f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802122:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802126:	75 07                	jne    80212f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802128:	b8 01 00 00 00       	mov    $0x1,%eax
  80212d:	eb 05                	jmp    802134 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80212f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802134:	c9                   	leave  
  802135:	c3                   	ret    

00802136 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802136:	55                   	push   %ebp
  802137:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802139:	6a 00                	push   $0x0
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	ff 75 08             	pushl  0x8(%ebp)
  802144:	6a 2d                	push   $0x2d
  802146:	e8 eb f9 ff ff       	call   801b36 <syscall>
  80214b:	83 c4 18             	add    $0x18,%esp
	return ;
  80214e:	90                   	nop
}
  80214f:	c9                   	leave  
  802150:	c3                   	ret    

00802151 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802151:	55                   	push   %ebp
  802152:	89 e5                	mov    %esp,%ebp
  802154:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802155:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802158:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80215b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80215e:	8b 45 08             	mov    0x8(%ebp),%eax
  802161:	6a 00                	push   $0x0
  802163:	53                   	push   %ebx
  802164:	51                   	push   %ecx
  802165:	52                   	push   %edx
  802166:	50                   	push   %eax
  802167:	6a 2e                	push   $0x2e
  802169:	e8 c8 f9 ff ff       	call   801b36 <syscall>
  80216e:	83 c4 18             	add    $0x18,%esp
}
  802171:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802174:	c9                   	leave  
  802175:	c3                   	ret    

00802176 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802176:	55                   	push   %ebp
  802177:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802179:	8b 55 0c             	mov    0xc(%ebp),%edx
  80217c:	8b 45 08             	mov    0x8(%ebp),%eax
  80217f:	6a 00                	push   $0x0
  802181:	6a 00                	push   $0x0
  802183:	6a 00                	push   $0x0
  802185:	52                   	push   %edx
  802186:	50                   	push   %eax
  802187:	6a 2f                	push   $0x2f
  802189:	e8 a8 f9 ff ff       	call   801b36 <syscall>
  80218e:	83 c4 18             	add    $0x18,%esp
}
  802191:	c9                   	leave  
  802192:	c3                   	ret    
  802193:	90                   	nop

00802194 <__udivdi3>:
  802194:	55                   	push   %ebp
  802195:	57                   	push   %edi
  802196:	56                   	push   %esi
  802197:	53                   	push   %ebx
  802198:	83 ec 1c             	sub    $0x1c,%esp
  80219b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80219f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021a3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021a7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021ab:	89 ca                	mov    %ecx,%edx
  8021ad:	89 f8                	mov    %edi,%eax
  8021af:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021b3:	85 f6                	test   %esi,%esi
  8021b5:	75 2d                	jne    8021e4 <__udivdi3+0x50>
  8021b7:	39 cf                	cmp    %ecx,%edi
  8021b9:	77 65                	ja     802220 <__udivdi3+0x8c>
  8021bb:	89 fd                	mov    %edi,%ebp
  8021bd:	85 ff                	test   %edi,%edi
  8021bf:	75 0b                	jne    8021cc <__udivdi3+0x38>
  8021c1:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c6:	31 d2                	xor    %edx,%edx
  8021c8:	f7 f7                	div    %edi
  8021ca:	89 c5                	mov    %eax,%ebp
  8021cc:	31 d2                	xor    %edx,%edx
  8021ce:	89 c8                	mov    %ecx,%eax
  8021d0:	f7 f5                	div    %ebp
  8021d2:	89 c1                	mov    %eax,%ecx
  8021d4:	89 d8                	mov    %ebx,%eax
  8021d6:	f7 f5                	div    %ebp
  8021d8:	89 cf                	mov    %ecx,%edi
  8021da:	89 fa                	mov    %edi,%edx
  8021dc:	83 c4 1c             	add    $0x1c,%esp
  8021df:	5b                   	pop    %ebx
  8021e0:	5e                   	pop    %esi
  8021e1:	5f                   	pop    %edi
  8021e2:	5d                   	pop    %ebp
  8021e3:	c3                   	ret    
  8021e4:	39 ce                	cmp    %ecx,%esi
  8021e6:	77 28                	ja     802210 <__udivdi3+0x7c>
  8021e8:	0f bd fe             	bsr    %esi,%edi
  8021eb:	83 f7 1f             	xor    $0x1f,%edi
  8021ee:	75 40                	jne    802230 <__udivdi3+0x9c>
  8021f0:	39 ce                	cmp    %ecx,%esi
  8021f2:	72 0a                	jb     8021fe <__udivdi3+0x6a>
  8021f4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8021f8:	0f 87 9e 00 00 00    	ja     80229c <__udivdi3+0x108>
  8021fe:	b8 01 00 00 00       	mov    $0x1,%eax
  802203:	89 fa                	mov    %edi,%edx
  802205:	83 c4 1c             	add    $0x1c,%esp
  802208:	5b                   	pop    %ebx
  802209:	5e                   	pop    %esi
  80220a:	5f                   	pop    %edi
  80220b:	5d                   	pop    %ebp
  80220c:	c3                   	ret    
  80220d:	8d 76 00             	lea    0x0(%esi),%esi
  802210:	31 ff                	xor    %edi,%edi
  802212:	31 c0                	xor    %eax,%eax
  802214:	89 fa                	mov    %edi,%edx
  802216:	83 c4 1c             	add    $0x1c,%esp
  802219:	5b                   	pop    %ebx
  80221a:	5e                   	pop    %esi
  80221b:	5f                   	pop    %edi
  80221c:	5d                   	pop    %ebp
  80221d:	c3                   	ret    
  80221e:	66 90                	xchg   %ax,%ax
  802220:	89 d8                	mov    %ebx,%eax
  802222:	f7 f7                	div    %edi
  802224:	31 ff                	xor    %edi,%edi
  802226:	89 fa                	mov    %edi,%edx
  802228:	83 c4 1c             	add    $0x1c,%esp
  80222b:	5b                   	pop    %ebx
  80222c:	5e                   	pop    %esi
  80222d:	5f                   	pop    %edi
  80222e:	5d                   	pop    %ebp
  80222f:	c3                   	ret    
  802230:	bd 20 00 00 00       	mov    $0x20,%ebp
  802235:	89 eb                	mov    %ebp,%ebx
  802237:	29 fb                	sub    %edi,%ebx
  802239:	89 f9                	mov    %edi,%ecx
  80223b:	d3 e6                	shl    %cl,%esi
  80223d:	89 c5                	mov    %eax,%ebp
  80223f:	88 d9                	mov    %bl,%cl
  802241:	d3 ed                	shr    %cl,%ebp
  802243:	89 e9                	mov    %ebp,%ecx
  802245:	09 f1                	or     %esi,%ecx
  802247:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80224b:	89 f9                	mov    %edi,%ecx
  80224d:	d3 e0                	shl    %cl,%eax
  80224f:	89 c5                	mov    %eax,%ebp
  802251:	89 d6                	mov    %edx,%esi
  802253:	88 d9                	mov    %bl,%cl
  802255:	d3 ee                	shr    %cl,%esi
  802257:	89 f9                	mov    %edi,%ecx
  802259:	d3 e2                	shl    %cl,%edx
  80225b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80225f:	88 d9                	mov    %bl,%cl
  802261:	d3 e8                	shr    %cl,%eax
  802263:	09 c2                	or     %eax,%edx
  802265:	89 d0                	mov    %edx,%eax
  802267:	89 f2                	mov    %esi,%edx
  802269:	f7 74 24 0c          	divl   0xc(%esp)
  80226d:	89 d6                	mov    %edx,%esi
  80226f:	89 c3                	mov    %eax,%ebx
  802271:	f7 e5                	mul    %ebp
  802273:	39 d6                	cmp    %edx,%esi
  802275:	72 19                	jb     802290 <__udivdi3+0xfc>
  802277:	74 0b                	je     802284 <__udivdi3+0xf0>
  802279:	89 d8                	mov    %ebx,%eax
  80227b:	31 ff                	xor    %edi,%edi
  80227d:	e9 58 ff ff ff       	jmp    8021da <__udivdi3+0x46>
  802282:	66 90                	xchg   %ax,%ax
  802284:	8b 54 24 08          	mov    0x8(%esp),%edx
  802288:	89 f9                	mov    %edi,%ecx
  80228a:	d3 e2                	shl    %cl,%edx
  80228c:	39 c2                	cmp    %eax,%edx
  80228e:	73 e9                	jae    802279 <__udivdi3+0xe5>
  802290:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802293:	31 ff                	xor    %edi,%edi
  802295:	e9 40 ff ff ff       	jmp    8021da <__udivdi3+0x46>
  80229a:	66 90                	xchg   %ax,%ax
  80229c:	31 c0                	xor    %eax,%eax
  80229e:	e9 37 ff ff ff       	jmp    8021da <__udivdi3+0x46>
  8022a3:	90                   	nop

008022a4 <__umoddi3>:
  8022a4:	55                   	push   %ebp
  8022a5:	57                   	push   %edi
  8022a6:	56                   	push   %esi
  8022a7:	53                   	push   %ebx
  8022a8:	83 ec 1c             	sub    $0x1c,%esp
  8022ab:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022af:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022b7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022bb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022bf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022c3:	89 f3                	mov    %esi,%ebx
  8022c5:	89 fa                	mov    %edi,%edx
  8022c7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022cb:	89 34 24             	mov    %esi,(%esp)
  8022ce:	85 c0                	test   %eax,%eax
  8022d0:	75 1a                	jne    8022ec <__umoddi3+0x48>
  8022d2:	39 f7                	cmp    %esi,%edi
  8022d4:	0f 86 a2 00 00 00    	jbe    80237c <__umoddi3+0xd8>
  8022da:	89 c8                	mov    %ecx,%eax
  8022dc:	89 f2                	mov    %esi,%edx
  8022de:	f7 f7                	div    %edi
  8022e0:	89 d0                	mov    %edx,%eax
  8022e2:	31 d2                	xor    %edx,%edx
  8022e4:	83 c4 1c             	add    $0x1c,%esp
  8022e7:	5b                   	pop    %ebx
  8022e8:	5e                   	pop    %esi
  8022e9:	5f                   	pop    %edi
  8022ea:	5d                   	pop    %ebp
  8022eb:	c3                   	ret    
  8022ec:	39 f0                	cmp    %esi,%eax
  8022ee:	0f 87 ac 00 00 00    	ja     8023a0 <__umoddi3+0xfc>
  8022f4:	0f bd e8             	bsr    %eax,%ebp
  8022f7:	83 f5 1f             	xor    $0x1f,%ebp
  8022fa:	0f 84 ac 00 00 00    	je     8023ac <__umoddi3+0x108>
  802300:	bf 20 00 00 00       	mov    $0x20,%edi
  802305:	29 ef                	sub    %ebp,%edi
  802307:	89 fe                	mov    %edi,%esi
  802309:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80230d:	89 e9                	mov    %ebp,%ecx
  80230f:	d3 e0                	shl    %cl,%eax
  802311:	89 d7                	mov    %edx,%edi
  802313:	89 f1                	mov    %esi,%ecx
  802315:	d3 ef                	shr    %cl,%edi
  802317:	09 c7                	or     %eax,%edi
  802319:	89 e9                	mov    %ebp,%ecx
  80231b:	d3 e2                	shl    %cl,%edx
  80231d:	89 14 24             	mov    %edx,(%esp)
  802320:	89 d8                	mov    %ebx,%eax
  802322:	d3 e0                	shl    %cl,%eax
  802324:	89 c2                	mov    %eax,%edx
  802326:	8b 44 24 08          	mov    0x8(%esp),%eax
  80232a:	d3 e0                	shl    %cl,%eax
  80232c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802330:	8b 44 24 08          	mov    0x8(%esp),%eax
  802334:	89 f1                	mov    %esi,%ecx
  802336:	d3 e8                	shr    %cl,%eax
  802338:	09 d0                	or     %edx,%eax
  80233a:	d3 eb                	shr    %cl,%ebx
  80233c:	89 da                	mov    %ebx,%edx
  80233e:	f7 f7                	div    %edi
  802340:	89 d3                	mov    %edx,%ebx
  802342:	f7 24 24             	mull   (%esp)
  802345:	89 c6                	mov    %eax,%esi
  802347:	89 d1                	mov    %edx,%ecx
  802349:	39 d3                	cmp    %edx,%ebx
  80234b:	0f 82 87 00 00 00    	jb     8023d8 <__umoddi3+0x134>
  802351:	0f 84 91 00 00 00    	je     8023e8 <__umoddi3+0x144>
  802357:	8b 54 24 04          	mov    0x4(%esp),%edx
  80235b:	29 f2                	sub    %esi,%edx
  80235d:	19 cb                	sbb    %ecx,%ebx
  80235f:	89 d8                	mov    %ebx,%eax
  802361:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802365:	d3 e0                	shl    %cl,%eax
  802367:	89 e9                	mov    %ebp,%ecx
  802369:	d3 ea                	shr    %cl,%edx
  80236b:	09 d0                	or     %edx,%eax
  80236d:	89 e9                	mov    %ebp,%ecx
  80236f:	d3 eb                	shr    %cl,%ebx
  802371:	89 da                	mov    %ebx,%edx
  802373:	83 c4 1c             	add    $0x1c,%esp
  802376:	5b                   	pop    %ebx
  802377:	5e                   	pop    %esi
  802378:	5f                   	pop    %edi
  802379:	5d                   	pop    %ebp
  80237a:	c3                   	ret    
  80237b:	90                   	nop
  80237c:	89 fd                	mov    %edi,%ebp
  80237e:	85 ff                	test   %edi,%edi
  802380:	75 0b                	jne    80238d <__umoddi3+0xe9>
  802382:	b8 01 00 00 00       	mov    $0x1,%eax
  802387:	31 d2                	xor    %edx,%edx
  802389:	f7 f7                	div    %edi
  80238b:	89 c5                	mov    %eax,%ebp
  80238d:	89 f0                	mov    %esi,%eax
  80238f:	31 d2                	xor    %edx,%edx
  802391:	f7 f5                	div    %ebp
  802393:	89 c8                	mov    %ecx,%eax
  802395:	f7 f5                	div    %ebp
  802397:	89 d0                	mov    %edx,%eax
  802399:	e9 44 ff ff ff       	jmp    8022e2 <__umoddi3+0x3e>
  80239e:	66 90                	xchg   %ax,%ax
  8023a0:	89 c8                	mov    %ecx,%eax
  8023a2:	89 f2                	mov    %esi,%edx
  8023a4:	83 c4 1c             	add    $0x1c,%esp
  8023a7:	5b                   	pop    %ebx
  8023a8:	5e                   	pop    %esi
  8023a9:	5f                   	pop    %edi
  8023aa:	5d                   	pop    %ebp
  8023ab:	c3                   	ret    
  8023ac:	3b 04 24             	cmp    (%esp),%eax
  8023af:	72 06                	jb     8023b7 <__umoddi3+0x113>
  8023b1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023b5:	77 0f                	ja     8023c6 <__umoddi3+0x122>
  8023b7:	89 f2                	mov    %esi,%edx
  8023b9:	29 f9                	sub    %edi,%ecx
  8023bb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023bf:	89 14 24             	mov    %edx,(%esp)
  8023c2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023c6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023ca:	8b 14 24             	mov    (%esp),%edx
  8023cd:	83 c4 1c             	add    $0x1c,%esp
  8023d0:	5b                   	pop    %ebx
  8023d1:	5e                   	pop    %esi
  8023d2:	5f                   	pop    %edi
  8023d3:	5d                   	pop    %ebp
  8023d4:	c3                   	ret    
  8023d5:	8d 76 00             	lea    0x0(%esi),%esi
  8023d8:	2b 04 24             	sub    (%esp),%eax
  8023db:	19 fa                	sbb    %edi,%edx
  8023dd:	89 d1                	mov    %edx,%ecx
  8023df:	89 c6                	mov    %eax,%esi
  8023e1:	e9 71 ff ff ff       	jmp    802357 <__umoddi3+0xb3>
  8023e6:	66 90                	xchg   %ax,%ax
  8023e8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023ec:	72 ea                	jb     8023d8 <__umoddi3+0x134>
  8023ee:	89 d9                	mov    %ebx,%ecx
  8023f0:	e9 62 ff ff ff       	jmp    802357 <__umoddi3+0xb3>
