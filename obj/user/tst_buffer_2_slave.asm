
obj/user/tst_buffer_2_slave:     file format elf32-i386


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
  800031:	e8 78 06 00 00       	call   8006ae <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#define arrSize PAGE_SIZE*8 / 4
int src[arrSize];
int dst[arrSize];

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 68             	sub    $0x68,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80004e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 a0 21 80 00       	push   $0x8021a0
  800065:	6a 17                	push   $0x17
  800067:	68 e8 21 80 00       	push   $0x8021e8
  80006c:	e8 82 07 00 00       	call   8007f3 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80007c:	83 c0 10             	add    $0x10,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800084:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 a0 21 80 00       	push   $0x8021a0
  80009b:	6a 18                	push   $0x18
  80009d:	68 e8 21 80 00       	push   $0x8021e8
  8000a2:	e8 4c 07 00 00       	call   8007f3 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b2:	83 c0 20             	add    $0x20,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 a0 21 80 00       	push   $0x8021a0
  8000d1:	6a 19                	push   $0x19
  8000d3:	68 e8 21 80 00       	push   $0x8021e8
  8000d8:	e8 16 07 00 00       	call   8007f3 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000e8:	83 c0 30             	add    $0x30,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8000f0:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 a0 21 80 00       	push   $0x8021a0
  800107:	6a 1a                	push   $0x1a
  800109:	68 e8 21 80 00       	push   $0x8021e8
  80010e:	e8 e0 06 00 00       	call   8007f3 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80011e:	83 c0 40             	add    $0x40,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800126:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 a0 21 80 00       	push   $0x8021a0
  80013d:	6a 1b                	push   $0x1b
  80013f:	68 e8 21 80 00       	push   $0x8021e8
  800144:	e8 aa 06 00 00       	call   8007f3 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800154:	83 c0 50             	add    $0x50,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80015c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 a0 21 80 00       	push   $0x8021a0
  800173:	6a 1c                	push   $0x1c
  800175:	68 e8 21 80 00       	push   $0x8021e8
  80017a:	e8 74 06 00 00       	call   8007f3 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80018a:	83 c0 60             	add    $0x60,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800192:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 a0 21 80 00       	push   $0x8021a0
  8001a9:	6a 1d                	push   $0x1d
  8001ab:	68 e8 21 80 00       	push   $0x8021e8
  8001b0:	e8 3e 06 00 00       	call   8007f3 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c0:	83 c0 70             	add    $0x70,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001c8:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 a0 21 80 00       	push   $0x8021a0
  8001df:	6a 1e                	push   $0x1e
  8001e1:	68 e8 21 80 00       	push   $0x8021e8
  8001e6:	e8 08 06 00 00       	call   8007f3 <_panic>
		//if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f6:	83 e8 80             	sub    $0xffffff80,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001fe:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 a0 21 80 00       	push   $0x8021a0
  800215:	6a 20                	push   $0x20
  800217:	68 e8 21 80 00       	push   $0x8021e8
  80021c:	e8 d2 05 00 00       	call   8007f3 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80022c:	05 90 00 00 00       	add    $0x90,%eax
  800231:	8b 00                	mov    (%eax),%eax
  800233:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800236:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800239:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023e:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800243:	74 14                	je     800259 <_main+0x221>
  800245:	83 ec 04             	sub    $0x4,%esp
  800248:	68 a0 21 80 00       	push   $0x8021a0
  80024d:	6a 21                	push   $0x21
  80024f:	68 e8 21 80 00       	push   $0x8021e8
  800254:	e8 9a 05 00 00       	call   8007f3 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800259:	a1 20 30 80 00       	mov    0x803020,%eax
  80025e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800264:	05 a0 00 00 00       	add    $0xa0,%eax
  800269:	8b 00                	mov    (%eax),%eax
  80026b:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80026e:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800271:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800276:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027b:	74 14                	je     800291 <_main+0x259>
  80027d:	83 ec 04             	sub    $0x4,%esp
  800280:	68 a0 21 80 00       	push   $0x8021a0
  800285:	6a 22                	push   $0x22
  800287:	68 e8 21 80 00       	push   $0x8021e8
  80028c:	e8 62 05 00 00       	call   8007f3 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  800291:	a1 20 30 80 00       	mov    0x803020,%eax
  800296:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80029c:	85 c0                	test   %eax,%eax
  80029e:	74 14                	je     8002b4 <_main+0x27c>
  8002a0:	83 ec 04             	sub    $0x4,%esp
  8002a3:	68 04 22 80 00       	push   $0x802204
  8002a8:	6a 23                	push   $0x23
  8002aa:	68 e8 21 80 00       	push   $0x8021e8
  8002af:	e8 3f 05 00 00       	call   8007f3 <_panic>
	}

	int initModBufCnt = sys_calculate_modified_frames();
  8002b4:	e8 eb 16 00 00       	call   8019a4 <sys_calculate_modified_frames>
  8002b9:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int initFreeBufCnt = sys_calculate_notmod_frames();
  8002bc:	e8 fc 16 00 00       	call   8019bd <sys_calculate_notmod_frames>
  8002c1:	89 45 a8             	mov    %eax,-0x58(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c4:	e8 45 17 00 00       	call   801a0e <sys_pf_calculate_allocated_pages>
  8002c9:	89 45 a4             	mov    %eax,-0x5c(%ebp)

	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
  8002cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum1 = 0;
  8002d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	int dummy = 0;
  8002da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  8002e1:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  8002e8:	eb 33                	jmp    80031d <_main+0x2e5>
	{
		dst[i] = i;
  8002ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002f0:	89 14 85 00 31 80 00 	mov    %edx,0x803100(,%eax,4)
		dstSum1 += i;
  8002f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002fa:	01 45 f0             	add    %eax,-0x10(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8002fd:	e8 bb 16 00 00       	call   8019bd <sys_calculate_notmod_frames>
  800302:	89 c2                	mov    %eax,%edx
  800304:	a1 20 30 80 00       	mov    0x803020,%eax
  800309:	8b 40 4c             	mov    0x4c(%eax),%eax
  80030c:	01 c2                	add    %eax,%edx
  80030e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800311:	01 d0                	add    %edx,%eax
  800313:	89 45 ec             	mov    %eax,-0x14(%ebp)

	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
	int dstSum1 = 0;
	int dummy = 0;
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  800316:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  80031d:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800324:	7e c4                	jle    8002ea <_main+0x2b2>
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}



	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800326:	e8 92 16 00 00       	call   8019bd <sys_calculate_notmod_frames>
  80032b:	89 c2                	mov    %eax,%edx
  80032d:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800330:	29 c2                	sub    %eax,%edx
  800332:	89 d0                	mov    %edx,%eax
  800334:	83 f8 07             	cmp    $0x7,%eax
  800337:	74 14                	je     80034d <_main+0x315>
  800339:	83 ec 04             	sub    $0x4,%esp
  80033c:	68 54 22 80 00       	push   $0x802254
  800341:	6a 37                	push   $0x37
  800343:	68 e8 21 80 00       	push   $0x8021e8
  800348:	e8 a6 04 00 00       	call   8007f3 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  80034d:	e8 52 16 00 00       	call   8019a4 <sys_calculate_modified_frames>
  800352:	89 c2                	mov    %eax,%edx
  800354:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800357:	39 c2                	cmp    %eax,%edx
  800359:	74 14                	je     80036f <_main+0x337>
  80035b:	83 ec 04             	sub    $0x4,%esp
  80035e:	68 b8 22 80 00       	push   $0x8022b8
  800363:	6a 38                	push   $0x38
  800365:	68 e8 21 80 00       	push   $0x8021e8
  80036a:	e8 84 04 00 00       	call   8007f3 <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  80036f:	e8 49 16 00 00       	call   8019bd <sys_calculate_notmod_frames>
  800374:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800377:	e8 28 16 00 00       	call   8019a4 <sys_calculate_modified_frames>
  80037c:	89 45 ac             	mov    %eax,-0x54(%ebp)

	//[2]Bring 7 unmodified pages (7 modified will be buffered)
	int srcSum1 = 0 ;
  80037f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	i = PAGE_SIZE/4;
  800386:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
	for(;i<arrSize;i+=PAGE_SIZE/4)
  80038d:	eb 2d                	jmp    8003bc <_main+0x384>
	{
		srcSum1 += src[i];
  80038f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800392:	8b 04 85 20 b1 80 00 	mov    0x80b120(,%eax,4),%eax
  800399:	01 45 e8             	add    %eax,-0x18(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80039c:	e8 1c 16 00 00       	call   8019bd <sys_calculate_notmod_frames>
  8003a1:	89 c2                	mov    %eax,%edx
  8003a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a8:	8b 40 4c             	mov    0x4c(%eax),%eax
  8003ab:	01 c2                	add    %eax,%edx
  8003ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003b0:	01 d0                	add    %edx,%eax
  8003b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[2]Bring 7 unmodified pages (7 modified will be buffered)
	int srcSum1 = 0 ;
	i = PAGE_SIZE/4;
	for(;i<arrSize;i+=PAGE_SIZE/4)
  8003b5:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  8003bc:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  8003c3:	7e ca                	jle    80038f <_main+0x357>
		srcSum1 += src[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	//cprintf("sys_calculate_notmod_frames()  - initFreeBufCnt = %d\n", sys_calculate_notmod_frames()  - initFreeBufCnt);
	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  8003c5:	e8 f3 15 00 00       	call   8019bd <sys_calculate_notmod_frames>
  8003ca:	89 c2                	mov    %eax,%edx
  8003cc:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003cf:	39 c2                	cmp    %eax,%edx
  8003d1:	74 14                	je     8003e7 <_main+0x3af>
  8003d3:	83 ec 04             	sub    $0x4,%esp
  8003d6:	68 54 22 80 00       	push   $0x802254
  8003db:	6a 47                	push   $0x47
  8003dd:	68 e8 21 80 00       	push   $0x8021e8
  8003e2:	e8 0c 04 00 00       	call   8007f3 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  8003e7:	e8 b8 15 00 00       	call   8019a4 <sys_calculate_modified_frames>
  8003ec:	89 c2                	mov    %eax,%edx
  8003ee:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8003f1:	29 c2                	sub    %eax,%edx
  8003f3:	89 d0                	mov    %edx,%eax
  8003f5:	83 f8 07             	cmp    $0x7,%eax
  8003f8:	74 14                	je     80040e <_main+0x3d6>
  8003fa:	83 ec 04             	sub    $0x4,%esp
  8003fd:	68 b8 22 80 00       	push   $0x8022b8
  800402:	6a 48                	push   $0x48
  800404:	68 e8 21 80 00       	push   $0x8021e8
  800409:	e8 e5 03 00 00       	call   8007f3 <_panic>
	initFreeBufCnt = sys_calculate_notmod_frames();
  80040e:	e8 aa 15 00 00       	call   8019bd <sys_calculate_notmod_frames>
  800413:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800416:	e8 89 15 00 00       	call   8019a4 <sys_calculate_modified_frames>
  80041b:	89 45 ac             	mov    %eax,-0x54(%ebp)

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)

	i = 0;
  80041e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum2 = 0 ;
  800425:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  80042c:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  800433:	eb 2d                	jmp    800462 <_main+0x42a>
	{
		dstSum2 += dst[i];
  800435:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800438:	8b 04 85 00 31 80 00 	mov    0x803100(,%eax,4),%eax
  80043f:	01 45 e4             	add    %eax,-0x1c(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800442:	e8 76 15 00 00       	call   8019bd <sys_calculate_notmod_frames>
  800447:	89 c2                	mov    %eax,%edx
  800449:	a1 20 30 80 00       	mov    0x803020,%eax
  80044e:	8b 40 4c             	mov    0x4c(%eax),%eax
  800451:	01 c2                	add    %eax,%edx
  800453:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800456:	01 d0                	add    %edx,%eax
  800458:	89 45 ec             	mov    %eax,-0x14(%ebp)

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)

	i = 0;
	int dstSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  80045b:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800462:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800469:	7e ca                	jle    800435 <_main+0x3fd>
	{
		dstSum2 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  80046b:	e8 4d 15 00 00       	call   8019bd <sys_calculate_notmod_frames>
  800470:	89 c2                	mov    %eax,%edx
  800472:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800475:	29 c2                	sub    %eax,%edx
  800477:	89 d0                	mov    %edx,%eax
  800479:	83 f8 07             	cmp    $0x7,%eax
  80047c:	74 14                	je     800492 <_main+0x45a>
  80047e:	83 ec 04             	sub    $0x4,%esp
  800481:	68 54 22 80 00       	push   $0x802254
  800486:	6a 56                	push   $0x56
  800488:	68 e8 21 80 00       	push   $0x8021e8
  80048d:	e8 61 03 00 00       	call   8007f3 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != -7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800492:	e8 0d 15 00 00       	call   8019a4 <sys_calculate_modified_frames>
  800497:	89 c2                	mov    %eax,%edx
  800499:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80049c:	29 c2                	sub    %eax,%edx
  80049e:	89 d0                	mov    %edx,%eax
  8004a0:	83 f8 f9             	cmp    $0xfffffff9,%eax
  8004a3:	74 14                	je     8004b9 <_main+0x481>
  8004a5:	83 ec 04             	sub    $0x4,%esp
  8004a8:	68 b8 22 80 00       	push   $0x8022b8
  8004ad:	6a 57                	push   $0x57
  8004af:	68 e8 21 80 00       	push   $0x8021e8
  8004b4:	e8 3a 03 00 00       	call   8007f3 <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  8004b9:	e8 ff 14 00 00       	call   8019bd <sys_calculate_notmod_frames>
  8004be:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8004c1:	e8 de 14 00 00       	call   8019a4 <sys_calculate_modified_frames>
  8004c6:	89 45 ac             	mov    %eax,-0x54(%ebp)

	//[4]Bring the 7 unmodified pages again and ensure their values are correct (7 modified will be buffered)
	i = 0;
  8004c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int srcSum2 = 0 ;
  8004d0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  8004d7:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  8004de:	eb 2d                	jmp    80050d <_main+0x4d5>
	{
		srcSum2 += src[i];
  8004e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e3:	8b 04 85 20 b1 80 00 	mov    0x80b120(,%eax,4),%eax
  8004ea:	01 45 e0             	add    %eax,-0x20(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8004ed:	e8 cb 14 00 00       	call   8019bd <sys_calculate_notmod_frames>
  8004f2:	89 c2                	mov    %eax,%edx
  8004f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f9:	8b 40 4c             	mov    0x4c(%eax),%eax
  8004fc:	01 c2                	add    %eax,%edx
  8004fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800501:	01 d0                	add    %edx,%eax
  800503:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[4]Bring the 7 unmodified pages again and ensure their values are correct (7 modified will be buffered)
	i = 0;
	int srcSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800506:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  80050d:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800514:	7e ca                	jle    8004e0 <_main+0x4a8>
	{
		srcSum2 += src[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != -7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800516:	e8 a2 14 00 00       	call   8019bd <sys_calculate_notmod_frames>
  80051b:	89 c2                	mov    %eax,%edx
  80051d:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800520:	29 c2                	sub    %eax,%edx
  800522:	89 d0                	mov    %edx,%eax
  800524:	83 f8 f9             	cmp    $0xfffffff9,%eax
  800527:	74 14                	je     80053d <_main+0x505>
  800529:	83 ec 04             	sub    $0x4,%esp
  80052c:	68 54 22 80 00       	push   $0x802254
  800531:	6a 65                	push   $0x65
  800533:	68 e8 21 80 00       	push   $0x8021e8
  800538:	e8 b6 02 00 00       	call   8007f3 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  80053d:	e8 62 14 00 00       	call   8019a4 <sys_calculate_modified_frames>
  800542:	89 c2                	mov    %eax,%edx
  800544:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800547:	29 c2                	sub    %eax,%edx
  800549:	89 d0                	mov    %edx,%eax
  80054b:	83 f8 07             	cmp    $0x7,%eax
  80054e:	74 14                	je     800564 <_main+0x52c>
  800550:	83 ec 04             	sub    $0x4,%esp
  800553:	68 b8 22 80 00       	push   $0x8022b8
  800558:	6a 66                	push   $0x66
  80055a:	68 e8 21 80 00       	push   $0x8021e8
  80055f:	e8 8f 02 00 00       	call   8007f3 <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  800564:	e8 a5 14 00 00       	call   801a0e <sys_pf_calculate_allocated_pages>
  800569:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
  80056c:	74 14                	je     800582 <_main+0x54a>
  80056e:	83 ec 04             	sub    $0x4,%esp
  800571:	68 24 23 80 00       	push   $0x802324
  800576:	6a 68                	push   $0x68
  800578:	68 e8 21 80 00       	push   $0x8021e8
  80057d:	e8 71 02 00 00       	call   8007f3 <_panic>

	if (srcSum1 != srcSum2 || dstSum1 != dstSum2) 	panic("Error in buffering/restoring modified/not modified pages") ;
  800582:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800585:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800588:	75 08                	jne    800592 <_main+0x55a>
  80058a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80058d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800590:	74 14                	je     8005a6 <_main+0x56e>
  800592:	83 ec 04             	sub    $0x4,%esp
  800595:	68 94 23 80 00       	push   $0x802394
  80059a:	6a 6a                	push   $0x6a
  80059c:	68 e8 21 80 00       	push   $0x8021e8
  8005a1:	e8 4d 02 00 00       	call   8007f3 <_panic>

	/*[5] BUSY-WAIT FOR A WHILE TILL FINISHING THE MASTER PROGRAM */
	env_sleep(5000);
  8005a6:	83 ec 0c             	sub    $0xc,%esp
  8005a9:	68 88 13 00 00       	push   $0x1388
  8005ae:	e8 c9 18 00 00       	call   801e7c <env_sleep>
  8005b3:	83 c4 10             	add    $0x10,%esp

	/*[6] Read the modified pages of this slave program (after they have been written on page file) */
	initFreeBufCnt = sys_calculate_notmod_frames();
  8005b6:	e8 02 14 00 00       	call   8019bd <sys_calculate_notmod_frames>
  8005bb:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8005be:	e8 e1 13 00 00       	call   8019a4 <sys_calculate_modified_frames>
  8005c3:	89 45 ac             	mov    %eax,-0x54(%ebp)
	i = 0;
  8005c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum3 = 0 ;
  8005cd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	dummy = 0;
  8005d4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	for(i=0;i<arrSize;i+=PAGE_SIZE/4)
  8005db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005e2:	eb 2d                	jmp    800611 <_main+0x5d9>
	{
		dstSum3 += dst[i];
  8005e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e7:	8b 04 85 00 31 80 00 	mov    0x803100(,%eax,4),%eax
  8005ee:	01 45 dc             	add    %eax,-0x24(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8005f1:	e8 c7 13 00 00       	call   8019bd <sys_calculate_notmod_frames>
  8005f6:	89 c2                	mov    %eax,%edx
  8005f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005fd:	8b 40 4c             	mov    0x4c(%eax),%eax
  800600:	01 c2                	add    %eax,%edx
  800602:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800605:	01 d0                	add    %edx,%eax
  800607:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initFreeBufCnt = sys_calculate_notmod_frames();
	initModBufCnt = sys_calculate_modified_frames();
	i = 0;
	int dstSum3 = 0 ;
	dummy = 0;
	for(i=0;i<arrSize;i+=PAGE_SIZE/4)
  80060a:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800611:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800618:	7e ca                	jle    8005e4 <_main+0x5ac>
	{
		dstSum3 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  80061a:	e8 9e 13 00 00       	call   8019bd <sys_calculate_notmod_frames>
  80061f:	89 c2                	mov    %eax,%edx
  800621:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800624:	39 c2                	cmp    %eax,%edx
  800626:	74 14                	je     80063c <_main+0x604>
  800628:	83 ec 04             	sub    $0x4,%esp
  80062b:	68 54 22 80 00       	push   $0x802254
  800630:	6a 7b                	push   $0x7b
  800632:	68 e8 21 80 00       	push   $0x8021e8
  800637:	e8 b7 01 00 00       	call   8007f3 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  80063c:	e8 63 13 00 00       	call   8019a4 <sys_calculate_modified_frames>
  800641:	89 c2                	mov    %eax,%edx
  800643:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800646:	39 c2                	cmp    %eax,%edx
  800648:	74 14                	je     80065e <_main+0x626>
  80064a:	83 ec 04             	sub    $0x4,%esp
  80064d:	68 b8 22 80 00       	push   $0x8022b8
  800652:	6a 7c                	push   $0x7c
  800654:	68 e8 21 80 00       	push   $0x8021e8
  800659:	e8 95 01 00 00       	call   8007f3 <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  80065e:	e8 ab 13 00 00       	call   801a0e <sys_pf_calculate_allocated_pages>
  800663:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
  800666:	74 14                	je     80067c <_main+0x644>
  800668:	83 ec 04             	sub    $0x4,%esp
  80066b:	68 24 23 80 00       	push   $0x802324
  800670:	6a 7e                	push   $0x7e
  800672:	68 e8 21 80 00       	push   $0x8021e8
  800677:	e8 77 01 00 00       	call   8007f3 <_panic>

	if (dstSum1 != dstSum3) 	panic("Error in buffering/restoring modified pages after freeing the modified list") ;
  80067c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80067f:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800682:	74 17                	je     80069b <_main+0x663>
  800684:	83 ec 04             	sub    $0x4,%esp
  800687:	68 d0 23 80 00       	push   $0x8023d0
  80068c:	68 80 00 00 00       	push   $0x80
  800691:	68 e8 21 80 00       	push   $0x8021e8
  800696:	e8 58 01 00 00       	call   8007f3 <_panic>

	cprintf("Congratulations!! modified list is cleared and updated successfully.\n");
  80069b:	83 ec 0c             	sub    $0xc,%esp
  80069e:	68 1c 24 80 00       	push   $0x80241c
  8006a3:	e8 ed 03 00 00       	call   800a95 <cprintf>
  8006a8:	83 c4 10             	add    $0x10,%esp

	return;
  8006ab:	90                   	nop

}
  8006ac:	c9                   	leave  
  8006ad:	c3                   	ret    

008006ae <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006ae:	55                   	push   %ebp
  8006af:	89 e5                	mov    %esp,%ebp
  8006b1:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006b4:	e8 07 12 00 00       	call   8018c0 <sys_getenvindex>
  8006b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006bf:	89 d0                	mov    %edx,%eax
  8006c1:	c1 e0 03             	shl    $0x3,%eax
  8006c4:	01 d0                	add    %edx,%eax
  8006c6:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8006cd:	01 c8                	add    %ecx,%eax
  8006cf:	01 c0                	add    %eax,%eax
  8006d1:	01 d0                	add    %edx,%eax
  8006d3:	01 c0                	add    %eax,%eax
  8006d5:	01 d0                	add    %edx,%eax
  8006d7:	89 c2                	mov    %eax,%edx
  8006d9:	c1 e2 05             	shl    $0x5,%edx
  8006dc:	29 c2                	sub    %eax,%edx
  8006de:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8006e5:	89 c2                	mov    %eax,%edx
  8006e7:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8006ed:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006f7:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8006fd:	84 c0                	test   %al,%al
  8006ff:	74 0f                	je     800710 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800701:	a1 20 30 80 00       	mov    0x803020,%eax
  800706:	05 40 3c 01 00       	add    $0x13c40,%eax
  80070b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800710:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800714:	7e 0a                	jle    800720 <libmain+0x72>
		binaryname = argv[0];
  800716:	8b 45 0c             	mov    0xc(%ebp),%eax
  800719:	8b 00                	mov    (%eax),%eax
  80071b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800720:	83 ec 08             	sub    $0x8,%esp
  800723:	ff 75 0c             	pushl  0xc(%ebp)
  800726:	ff 75 08             	pushl  0x8(%ebp)
  800729:	e8 0a f9 ff ff       	call   800038 <_main>
  80072e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800731:	e8 25 13 00 00       	call   801a5b <sys_disable_interrupt>
	cprintf("**************************************\n");
  800736:	83 ec 0c             	sub    $0xc,%esp
  800739:	68 7c 24 80 00       	push   $0x80247c
  80073e:	e8 52 03 00 00       	call   800a95 <cprintf>
  800743:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800746:	a1 20 30 80 00       	mov    0x803020,%eax
  80074b:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800751:	a1 20 30 80 00       	mov    0x803020,%eax
  800756:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80075c:	83 ec 04             	sub    $0x4,%esp
  80075f:	52                   	push   %edx
  800760:	50                   	push   %eax
  800761:	68 a4 24 80 00       	push   $0x8024a4
  800766:	e8 2a 03 00 00       	call   800a95 <cprintf>
  80076b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80076e:	a1 20 30 80 00       	mov    0x803020,%eax
  800773:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800779:	a1 20 30 80 00       	mov    0x803020,%eax
  80077e:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800784:	83 ec 04             	sub    $0x4,%esp
  800787:	52                   	push   %edx
  800788:	50                   	push   %eax
  800789:	68 cc 24 80 00       	push   $0x8024cc
  80078e:	e8 02 03 00 00       	call   800a95 <cprintf>
  800793:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800796:	a1 20 30 80 00       	mov    0x803020,%eax
  80079b:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8007a1:	83 ec 08             	sub    $0x8,%esp
  8007a4:	50                   	push   %eax
  8007a5:	68 0d 25 80 00       	push   $0x80250d
  8007aa:	e8 e6 02 00 00       	call   800a95 <cprintf>
  8007af:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8007b2:	83 ec 0c             	sub    $0xc,%esp
  8007b5:	68 7c 24 80 00       	push   $0x80247c
  8007ba:	e8 d6 02 00 00       	call   800a95 <cprintf>
  8007bf:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007c2:	e8 ae 12 00 00       	call   801a75 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007c7:	e8 19 00 00 00       	call   8007e5 <exit>
}
  8007cc:	90                   	nop
  8007cd:	c9                   	leave  
  8007ce:	c3                   	ret    

008007cf <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007cf:	55                   	push   %ebp
  8007d0:	89 e5                	mov    %esp,%ebp
  8007d2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007d5:	83 ec 0c             	sub    $0xc,%esp
  8007d8:	6a 00                	push   $0x0
  8007da:	e8 ad 10 00 00       	call   80188c <sys_env_destroy>
  8007df:	83 c4 10             	add    $0x10,%esp
}
  8007e2:	90                   	nop
  8007e3:	c9                   	leave  
  8007e4:	c3                   	ret    

008007e5 <exit>:

void
exit(void)
{
  8007e5:	55                   	push   %ebp
  8007e6:	89 e5                	mov    %esp,%ebp
  8007e8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007eb:	e8 02 11 00 00       	call   8018f2 <sys_env_exit>
}
  8007f0:	90                   	nop
  8007f1:	c9                   	leave  
  8007f2:	c3                   	ret    

008007f3 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007f3:	55                   	push   %ebp
  8007f4:	89 e5                	mov    %esp,%ebp
  8007f6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007f9:	8d 45 10             	lea    0x10(%ebp),%eax
  8007fc:	83 c0 04             	add    $0x4,%eax
  8007ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800802:	a1 24 31 81 00       	mov    0x813124,%eax
  800807:	85 c0                	test   %eax,%eax
  800809:	74 16                	je     800821 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80080b:	a1 24 31 81 00       	mov    0x813124,%eax
  800810:	83 ec 08             	sub    $0x8,%esp
  800813:	50                   	push   %eax
  800814:	68 24 25 80 00       	push   $0x802524
  800819:	e8 77 02 00 00       	call   800a95 <cprintf>
  80081e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800821:	a1 00 30 80 00       	mov    0x803000,%eax
  800826:	ff 75 0c             	pushl  0xc(%ebp)
  800829:	ff 75 08             	pushl  0x8(%ebp)
  80082c:	50                   	push   %eax
  80082d:	68 29 25 80 00       	push   $0x802529
  800832:	e8 5e 02 00 00       	call   800a95 <cprintf>
  800837:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80083a:	8b 45 10             	mov    0x10(%ebp),%eax
  80083d:	83 ec 08             	sub    $0x8,%esp
  800840:	ff 75 f4             	pushl  -0xc(%ebp)
  800843:	50                   	push   %eax
  800844:	e8 e1 01 00 00       	call   800a2a <vcprintf>
  800849:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80084c:	83 ec 08             	sub    $0x8,%esp
  80084f:	6a 00                	push   $0x0
  800851:	68 45 25 80 00       	push   $0x802545
  800856:	e8 cf 01 00 00       	call   800a2a <vcprintf>
  80085b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80085e:	e8 82 ff ff ff       	call   8007e5 <exit>

	// should not return here
	while (1) ;
  800863:	eb fe                	jmp    800863 <_panic+0x70>

00800865 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800865:	55                   	push   %ebp
  800866:	89 e5                	mov    %esp,%ebp
  800868:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80086b:	a1 20 30 80 00       	mov    0x803020,%eax
  800870:	8b 50 74             	mov    0x74(%eax),%edx
  800873:	8b 45 0c             	mov    0xc(%ebp),%eax
  800876:	39 c2                	cmp    %eax,%edx
  800878:	74 14                	je     80088e <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80087a:	83 ec 04             	sub    $0x4,%esp
  80087d:	68 48 25 80 00       	push   $0x802548
  800882:	6a 26                	push   $0x26
  800884:	68 94 25 80 00       	push   $0x802594
  800889:	e8 65 ff ff ff       	call   8007f3 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80088e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800895:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80089c:	e9 b6 00 00 00       	jmp    800957 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8008a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	01 d0                	add    %edx,%eax
  8008b0:	8b 00                	mov    (%eax),%eax
  8008b2:	85 c0                	test   %eax,%eax
  8008b4:	75 08                	jne    8008be <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008b6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008b9:	e9 96 00 00 00       	jmp    800954 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8008be:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008c5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008cc:	eb 5d                	jmp    80092b <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8008d3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008d9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008dc:	c1 e2 04             	shl    $0x4,%edx
  8008df:	01 d0                	add    %edx,%eax
  8008e1:	8a 40 04             	mov    0x4(%eax),%al
  8008e4:	84 c0                	test   %al,%al
  8008e6:	75 40                	jne    800928 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8008ed:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008f3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008f6:	c1 e2 04             	shl    $0x4,%edx
  8008f9:	01 d0                	add    %edx,%eax
  8008fb:	8b 00                	mov    (%eax),%eax
  8008fd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800900:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800903:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800908:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80090a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80090d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800914:	8b 45 08             	mov    0x8(%ebp),%eax
  800917:	01 c8                	add    %ecx,%eax
  800919:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80091b:	39 c2                	cmp    %eax,%edx
  80091d:	75 09                	jne    800928 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80091f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800926:	eb 12                	jmp    80093a <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800928:	ff 45 e8             	incl   -0x18(%ebp)
  80092b:	a1 20 30 80 00       	mov    0x803020,%eax
  800930:	8b 50 74             	mov    0x74(%eax),%edx
  800933:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800936:	39 c2                	cmp    %eax,%edx
  800938:	77 94                	ja     8008ce <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80093a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80093e:	75 14                	jne    800954 <CheckWSWithoutLastIndex+0xef>
			panic(
  800940:	83 ec 04             	sub    $0x4,%esp
  800943:	68 a0 25 80 00       	push   $0x8025a0
  800948:	6a 3a                	push   $0x3a
  80094a:	68 94 25 80 00       	push   $0x802594
  80094f:	e8 9f fe ff ff       	call   8007f3 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800954:	ff 45 f0             	incl   -0x10(%ebp)
  800957:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80095a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80095d:	0f 8c 3e ff ff ff    	jl     8008a1 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800963:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80096a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800971:	eb 20                	jmp    800993 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800973:	a1 20 30 80 00       	mov    0x803020,%eax
  800978:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80097e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800981:	c1 e2 04             	shl    $0x4,%edx
  800984:	01 d0                	add    %edx,%eax
  800986:	8a 40 04             	mov    0x4(%eax),%al
  800989:	3c 01                	cmp    $0x1,%al
  80098b:	75 03                	jne    800990 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80098d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800990:	ff 45 e0             	incl   -0x20(%ebp)
  800993:	a1 20 30 80 00       	mov    0x803020,%eax
  800998:	8b 50 74             	mov    0x74(%eax),%edx
  80099b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80099e:	39 c2                	cmp    %eax,%edx
  8009a0:	77 d1                	ja     800973 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009a5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009a8:	74 14                	je     8009be <CheckWSWithoutLastIndex+0x159>
		panic(
  8009aa:	83 ec 04             	sub    $0x4,%esp
  8009ad:	68 f4 25 80 00       	push   $0x8025f4
  8009b2:	6a 44                	push   $0x44
  8009b4:	68 94 25 80 00       	push   $0x802594
  8009b9:	e8 35 fe ff ff       	call   8007f3 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009be:	90                   	nop
  8009bf:	c9                   	leave  
  8009c0:	c3                   	ret    

008009c1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009c1:	55                   	push   %ebp
  8009c2:	89 e5                	mov    %esp,%ebp
  8009c4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ca:	8b 00                	mov    (%eax),%eax
  8009cc:	8d 48 01             	lea    0x1(%eax),%ecx
  8009cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d2:	89 0a                	mov    %ecx,(%edx)
  8009d4:	8b 55 08             	mov    0x8(%ebp),%edx
  8009d7:	88 d1                	mov    %dl,%cl
  8009d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009dc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e3:	8b 00                	mov    (%eax),%eax
  8009e5:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009ea:	75 2c                	jne    800a18 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009ec:	a0 24 30 80 00       	mov    0x803024,%al
  8009f1:	0f b6 c0             	movzbl %al,%eax
  8009f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f7:	8b 12                	mov    (%edx),%edx
  8009f9:	89 d1                	mov    %edx,%ecx
  8009fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009fe:	83 c2 08             	add    $0x8,%edx
  800a01:	83 ec 04             	sub    $0x4,%esp
  800a04:	50                   	push   %eax
  800a05:	51                   	push   %ecx
  800a06:	52                   	push   %edx
  800a07:	e8 3e 0e 00 00       	call   80184a <sys_cputs>
  800a0c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a12:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1b:	8b 40 04             	mov    0x4(%eax),%eax
  800a1e:	8d 50 01             	lea    0x1(%eax),%edx
  800a21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a24:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a27:	90                   	nop
  800a28:	c9                   	leave  
  800a29:	c3                   	ret    

00800a2a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a2a:	55                   	push   %ebp
  800a2b:	89 e5                	mov    %esp,%ebp
  800a2d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a33:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a3a:	00 00 00 
	b.cnt = 0;
  800a3d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a44:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a47:	ff 75 0c             	pushl  0xc(%ebp)
  800a4a:	ff 75 08             	pushl  0x8(%ebp)
  800a4d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a53:	50                   	push   %eax
  800a54:	68 c1 09 80 00       	push   $0x8009c1
  800a59:	e8 11 02 00 00       	call   800c6f <vprintfmt>
  800a5e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a61:	a0 24 30 80 00       	mov    0x803024,%al
  800a66:	0f b6 c0             	movzbl %al,%eax
  800a69:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a6f:	83 ec 04             	sub    $0x4,%esp
  800a72:	50                   	push   %eax
  800a73:	52                   	push   %edx
  800a74:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a7a:	83 c0 08             	add    $0x8,%eax
  800a7d:	50                   	push   %eax
  800a7e:	e8 c7 0d 00 00       	call   80184a <sys_cputs>
  800a83:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a86:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800a8d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a93:	c9                   	leave  
  800a94:	c3                   	ret    

00800a95 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a95:	55                   	push   %ebp
  800a96:	89 e5                	mov    %esp,%ebp
  800a98:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a9b:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800aa2:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aa5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	83 ec 08             	sub    $0x8,%esp
  800aae:	ff 75 f4             	pushl  -0xc(%ebp)
  800ab1:	50                   	push   %eax
  800ab2:	e8 73 ff ff ff       	call   800a2a <vcprintf>
  800ab7:	83 c4 10             	add    $0x10,%esp
  800aba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800abd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ac0:	c9                   	leave  
  800ac1:	c3                   	ret    

00800ac2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ac2:	55                   	push   %ebp
  800ac3:	89 e5                	mov    %esp,%ebp
  800ac5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ac8:	e8 8e 0f 00 00       	call   801a5b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800acd:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ad0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	83 ec 08             	sub    $0x8,%esp
  800ad9:	ff 75 f4             	pushl  -0xc(%ebp)
  800adc:	50                   	push   %eax
  800add:	e8 48 ff ff ff       	call   800a2a <vcprintf>
  800ae2:	83 c4 10             	add    $0x10,%esp
  800ae5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800ae8:	e8 88 0f 00 00       	call   801a75 <sys_enable_interrupt>
	return cnt;
  800aed:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800af0:	c9                   	leave  
  800af1:	c3                   	ret    

00800af2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800af2:	55                   	push   %ebp
  800af3:	89 e5                	mov    %esp,%ebp
  800af5:	53                   	push   %ebx
  800af6:	83 ec 14             	sub    $0x14,%esp
  800af9:	8b 45 10             	mov    0x10(%ebp),%eax
  800afc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aff:	8b 45 14             	mov    0x14(%ebp),%eax
  800b02:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b05:	8b 45 18             	mov    0x18(%ebp),%eax
  800b08:	ba 00 00 00 00       	mov    $0x0,%edx
  800b0d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b10:	77 55                	ja     800b67 <printnum+0x75>
  800b12:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b15:	72 05                	jb     800b1c <printnum+0x2a>
  800b17:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b1a:	77 4b                	ja     800b67 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b1c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b1f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b22:	8b 45 18             	mov    0x18(%ebp),%eax
  800b25:	ba 00 00 00 00       	mov    $0x0,%edx
  800b2a:	52                   	push   %edx
  800b2b:	50                   	push   %eax
  800b2c:	ff 75 f4             	pushl  -0xc(%ebp)
  800b2f:	ff 75 f0             	pushl  -0x10(%ebp)
  800b32:	e8 f9 13 00 00       	call   801f30 <__udivdi3>
  800b37:	83 c4 10             	add    $0x10,%esp
  800b3a:	83 ec 04             	sub    $0x4,%esp
  800b3d:	ff 75 20             	pushl  0x20(%ebp)
  800b40:	53                   	push   %ebx
  800b41:	ff 75 18             	pushl  0x18(%ebp)
  800b44:	52                   	push   %edx
  800b45:	50                   	push   %eax
  800b46:	ff 75 0c             	pushl  0xc(%ebp)
  800b49:	ff 75 08             	pushl  0x8(%ebp)
  800b4c:	e8 a1 ff ff ff       	call   800af2 <printnum>
  800b51:	83 c4 20             	add    $0x20,%esp
  800b54:	eb 1a                	jmp    800b70 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b56:	83 ec 08             	sub    $0x8,%esp
  800b59:	ff 75 0c             	pushl  0xc(%ebp)
  800b5c:	ff 75 20             	pushl  0x20(%ebp)
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	ff d0                	call   *%eax
  800b64:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b67:	ff 4d 1c             	decl   0x1c(%ebp)
  800b6a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b6e:	7f e6                	jg     800b56 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b70:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b73:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b78:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b7e:	53                   	push   %ebx
  800b7f:	51                   	push   %ecx
  800b80:	52                   	push   %edx
  800b81:	50                   	push   %eax
  800b82:	e8 b9 14 00 00       	call   802040 <__umoddi3>
  800b87:	83 c4 10             	add    $0x10,%esp
  800b8a:	05 54 28 80 00       	add    $0x802854,%eax
  800b8f:	8a 00                	mov    (%eax),%al
  800b91:	0f be c0             	movsbl %al,%eax
  800b94:	83 ec 08             	sub    $0x8,%esp
  800b97:	ff 75 0c             	pushl  0xc(%ebp)
  800b9a:	50                   	push   %eax
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	ff d0                	call   *%eax
  800ba0:	83 c4 10             	add    $0x10,%esp
}
  800ba3:	90                   	nop
  800ba4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ba7:	c9                   	leave  
  800ba8:	c3                   	ret    

00800ba9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ba9:	55                   	push   %ebp
  800baa:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bac:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bb0:	7e 1c                	jle    800bce <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb5:	8b 00                	mov    (%eax),%eax
  800bb7:	8d 50 08             	lea    0x8(%eax),%edx
  800bba:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbd:	89 10                	mov    %edx,(%eax)
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc2:	8b 00                	mov    (%eax),%eax
  800bc4:	83 e8 08             	sub    $0x8,%eax
  800bc7:	8b 50 04             	mov    0x4(%eax),%edx
  800bca:	8b 00                	mov    (%eax),%eax
  800bcc:	eb 40                	jmp    800c0e <getuint+0x65>
	else if (lflag)
  800bce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bd2:	74 1e                	je     800bf2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800bd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd7:	8b 00                	mov    (%eax),%eax
  800bd9:	8d 50 04             	lea    0x4(%eax),%edx
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	89 10                	mov    %edx,(%eax)
  800be1:	8b 45 08             	mov    0x8(%ebp),%eax
  800be4:	8b 00                	mov    (%eax),%eax
  800be6:	83 e8 04             	sub    $0x4,%eax
  800be9:	8b 00                	mov    (%eax),%eax
  800beb:	ba 00 00 00 00       	mov    $0x0,%edx
  800bf0:	eb 1c                	jmp    800c0e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	8b 00                	mov    (%eax),%eax
  800bf7:	8d 50 04             	lea    0x4(%eax),%edx
  800bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfd:	89 10                	mov    %edx,(%eax)
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
  800c02:	8b 00                	mov    (%eax),%eax
  800c04:	83 e8 04             	sub    $0x4,%eax
  800c07:	8b 00                	mov    (%eax),%eax
  800c09:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c0e:	5d                   	pop    %ebp
  800c0f:	c3                   	ret    

00800c10 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c10:	55                   	push   %ebp
  800c11:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c13:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c17:	7e 1c                	jle    800c35 <getint+0x25>
		return va_arg(*ap, long long);
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	8b 00                	mov    (%eax),%eax
  800c1e:	8d 50 08             	lea    0x8(%eax),%edx
  800c21:	8b 45 08             	mov    0x8(%ebp),%eax
  800c24:	89 10                	mov    %edx,(%eax)
  800c26:	8b 45 08             	mov    0x8(%ebp),%eax
  800c29:	8b 00                	mov    (%eax),%eax
  800c2b:	83 e8 08             	sub    $0x8,%eax
  800c2e:	8b 50 04             	mov    0x4(%eax),%edx
  800c31:	8b 00                	mov    (%eax),%eax
  800c33:	eb 38                	jmp    800c6d <getint+0x5d>
	else if (lflag)
  800c35:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c39:	74 1a                	je     800c55 <getint+0x45>
		return va_arg(*ap, long);
  800c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3e:	8b 00                	mov    (%eax),%eax
  800c40:	8d 50 04             	lea    0x4(%eax),%edx
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	89 10                	mov    %edx,(%eax)
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	8b 00                	mov    (%eax),%eax
  800c4d:	83 e8 04             	sub    $0x4,%eax
  800c50:	8b 00                	mov    (%eax),%eax
  800c52:	99                   	cltd   
  800c53:	eb 18                	jmp    800c6d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c55:	8b 45 08             	mov    0x8(%ebp),%eax
  800c58:	8b 00                	mov    (%eax),%eax
  800c5a:	8d 50 04             	lea    0x4(%eax),%edx
  800c5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c60:	89 10                	mov    %edx,(%eax)
  800c62:	8b 45 08             	mov    0x8(%ebp),%eax
  800c65:	8b 00                	mov    (%eax),%eax
  800c67:	83 e8 04             	sub    $0x4,%eax
  800c6a:	8b 00                	mov    (%eax),%eax
  800c6c:	99                   	cltd   
}
  800c6d:	5d                   	pop    %ebp
  800c6e:	c3                   	ret    

00800c6f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c6f:	55                   	push   %ebp
  800c70:	89 e5                	mov    %esp,%ebp
  800c72:	56                   	push   %esi
  800c73:	53                   	push   %ebx
  800c74:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c77:	eb 17                	jmp    800c90 <vprintfmt+0x21>
			if (ch == '\0')
  800c79:	85 db                	test   %ebx,%ebx
  800c7b:	0f 84 af 03 00 00    	je     801030 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c81:	83 ec 08             	sub    $0x8,%esp
  800c84:	ff 75 0c             	pushl  0xc(%ebp)
  800c87:	53                   	push   %ebx
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8b:	ff d0                	call   *%eax
  800c8d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c90:	8b 45 10             	mov    0x10(%ebp),%eax
  800c93:	8d 50 01             	lea    0x1(%eax),%edx
  800c96:	89 55 10             	mov    %edx,0x10(%ebp)
  800c99:	8a 00                	mov    (%eax),%al
  800c9b:	0f b6 d8             	movzbl %al,%ebx
  800c9e:	83 fb 25             	cmp    $0x25,%ebx
  800ca1:	75 d6                	jne    800c79 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800ca3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ca7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800cae:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cb5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cbc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800cc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc6:	8d 50 01             	lea    0x1(%eax),%edx
  800cc9:	89 55 10             	mov    %edx,0x10(%ebp)
  800ccc:	8a 00                	mov    (%eax),%al
  800cce:	0f b6 d8             	movzbl %al,%ebx
  800cd1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800cd4:	83 f8 55             	cmp    $0x55,%eax
  800cd7:	0f 87 2b 03 00 00    	ja     801008 <vprintfmt+0x399>
  800cdd:	8b 04 85 78 28 80 00 	mov    0x802878(,%eax,4),%eax
  800ce4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ce6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cea:	eb d7                	jmp    800cc3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cec:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cf0:	eb d1                	jmp    800cc3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cf2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800cf9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cfc:	89 d0                	mov    %edx,%eax
  800cfe:	c1 e0 02             	shl    $0x2,%eax
  800d01:	01 d0                	add    %edx,%eax
  800d03:	01 c0                	add    %eax,%eax
  800d05:	01 d8                	add    %ebx,%eax
  800d07:	83 e8 30             	sub    $0x30,%eax
  800d0a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d10:	8a 00                	mov    (%eax),%al
  800d12:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d15:	83 fb 2f             	cmp    $0x2f,%ebx
  800d18:	7e 3e                	jle    800d58 <vprintfmt+0xe9>
  800d1a:	83 fb 39             	cmp    $0x39,%ebx
  800d1d:	7f 39                	jg     800d58 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d1f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d22:	eb d5                	jmp    800cf9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d24:	8b 45 14             	mov    0x14(%ebp),%eax
  800d27:	83 c0 04             	add    $0x4,%eax
  800d2a:	89 45 14             	mov    %eax,0x14(%ebp)
  800d2d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d30:	83 e8 04             	sub    $0x4,%eax
  800d33:	8b 00                	mov    (%eax),%eax
  800d35:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d38:	eb 1f                	jmp    800d59 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d3a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d3e:	79 83                	jns    800cc3 <vprintfmt+0x54>
				width = 0;
  800d40:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d47:	e9 77 ff ff ff       	jmp    800cc3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d4c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d53:	e9 6b ff ff ff       	jmp    800cc3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d58:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d59:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d5d:	0f 89 60 ff ff ff    	jns    800cc3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d63:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d66:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d69:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d70:	e9 4e ff ff ff       	jmp    800cc3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d75:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d78:	e9 46 ff ff ff       	jmp    800cc3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d7d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d80:	83 c0 04             	add    $0x4,%eax
  800d83:	89 45 14             	mov    %eax,0x14(%ebp)
  800d86:	8b 45 14             	mov    0x14(%ebp),%eax
  800d89:	83 e8 04             	sub    $0x4,%eax
  800d8c:	8b 00                	mov    (%eax),%eax
  800d8e:	83 ec 08             	sub    $0x8,%esp
  800d91:	ff 75 0c             	pushl  0xc(%ebp)
  800d94:	50                   	push   %eax
  800d95:	8b 45 08             	mov    0x8(%ebp),%eax
  800d98:	ff d0                	call   *%eax
  800d9a:	83 c4 10             	add    $0x10,%esp
			break;
  800d9d:	e9 89 02 00 00       	jmp    80102b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800da2:	8b 45 14             	mov    0x14(%ebp),%eax
  800da5:	83 c0 04             	add    $0x4,%eax
  800da8:	89 45 14             	mov    %eax,0x14(%ebp)
  800dab:	8b 45 14             	mov    0x14(%ebp),%eax
  800dae:	83 e8 04             	sub    $0x4,%eax
  800db1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800db3:	85 db                	test   %ebx,%ebx
  800db5:	79 02                	jns    800db9 <vprintfmt+0x14a>
				err = -err;
  800db7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800db9:	83 fb 64             	cmp    $0x64,%ebx
  800dbc:	7f 0b                	jg     800dc9 <vprintfmt+0x15a>
  800dbe:	8b 34 9d c0 26 80 00 	mov    0x8026c0(,%ebx,4),%esi
  800dc5:	85 f6                	test   %esi,%esi
  800dc7:	75 19                	jne    800de2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800dc9:	53                   	push   %ebx
  800dca:	68 65 28 80 00       	push   $0x802865
  800dcf:	ff 75 0c             	pushl  0xc(%ebp)
  800dd2:	ff 75 08             	pushl  0x8(%ebp)
  800dd5:	e8 5e 02 00 00       	call   801038 <printfmt>
  800dda:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ddd:	e9 49 02 00 00       	jmp    80102b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800de2:	56                   	push   %esi
  800de3:	68 6e 28 80 00       	push   $0x80286e
  800de8:	ff 75 0c             	pushl  0xc(%ebp)
  800deb:	ff 75 08             	pushl  0x8(%ebp)
  800dee:	e8 45 02 00 00       	call   801038 <printfmt>
  800df3:	83 c4 10             	add    $0x10,%esp
			break;
  800df6:	e9 30 02 00 00       	jmp    80102b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800dfb:	8b 45 14             	mov    0x14(%ebp),%eax
  800dfe:	83 c0 04             	add    $0x4,%eax
  800e01:	89 45 14             	mov    %eax,0x14(%ebp)
  800e04:	8b 45 14             	mov    0x14(%ebp),%eax
  800e07:	83 e8 04             	sub    $0x4,%eax
  800e0a:	8b 30                	mov    (%eax),%esi
  800e0c:	85 f6                	test   %esi,%esi
  800e0e:	75 05                	jne    800e15 <vprintfmt+0x1a6>
				p = "(null)";
  800e10:	be 71 28 80 00       	mov    $0x802871,%esi
			if (width > 0 && padc != '-')
  800e15:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e19:	7e 6d                	jle    800e88 <vprintfmt+0x219>
  800e1b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e1f:	74 67                	je     800e88 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e21:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e24:	83 ec 08             	sub    $0x8,%esp
  800e27:	50                   	push   %eax
  800e28:	56                   	push   %esi
  800e29:	e8 0c 03 00 00       	call   80113a <strnlen>
  800e2e:	83 c4 10             	add    $0x10,%esp
  800e31:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e34:	eb 16                	jmp    800e4c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e36:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e3a:	83 ec 08             	sub    $0x8,%esp
  800e3d:	ff 75 0c             	pushl  0xc(%ebp)
  800e40:	50                   	push   %eax
  800e41:	8b 45 08             	mov    0x8(%ebp),%eax
  800e44:	ff d0                	call   *%eax
  800e46:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e49:	ff 4d e4             	decl   -0x1c(%ebp)
  800e4c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e50:	7f e4                	jg     800e36 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e52:	eb 34                	jmp    800e88 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e54:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e58:	74 1c                	je     800e76 <vprintfmt+0x207>
  800e5a:	83 fb 1f             	cmp    $0x1f,%ebx
  800e5d:	7e 05                	jle    800e64 <vprintfmt+0x1f5>
  800e5f:	83 fb 7e             	cmp    $0x7e,%ebx
  800e62:	7e 12                	jle    800e76 <vprintfmt+0x207>
					putch('?', putdat);
  800e64:	83 ec 08             	sub    $0x8,%esp
  800e67:	ff 75 0c             	pushl  0xc(%ebp)
  800e6a:	6a 3f                	push   $0x3f
  800e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6f:	ff d0                	call   *%eax
  800e71:	83 c4 10             	add    $0x10,%esp
  800e74:	eb 0f                	jmp    800e85 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e76:	83 ec 08             	sub    $0x8,%esp
  800e79:	ff 75 0c             	pushl  0xc(%ebp)
  800e7c:	53                   	push   %ebx
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	ff d0                	call   *%eax
  800e82:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e85:	ff 4d e4             	decl   -0x1c(%ebp)
  800e88:	89 f0                	mov    %esi,%eax
  800e8a:	8d 70 01             	lea    0x1(%eax),%esi
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	0f be d8             	movsbl %al,%ebx
  800e92:	85 db                	test   %ebx,%ebx
  800e94:	74 24                	je     800eba <vprintfmt+0x24b>
  800e96:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e9a:	78 b8                	js     800e54 <vprintfmt+0x1e5>
  800e9c:	ff 4d e0             	decl   -0x20(%ebp)
  800e9f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ea3:	79 af                	jns    800e54 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ea5:	eb 13                	jmp    800eba <vprintfmt+0x24b>
				putch(' ', putdat);
  800ea7:	83 ec 08             	sub    $0x8,%esp
  800eaa:	ff 75 0c             	pushl  0xc(%ebp)
  800ead:	6a 20                	push   $0x20
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	ff d0                	call   *%eax
  800eb4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800eb7:	ff 4d e4             	decl   -0x1c(%ebp)
  800eba:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ebe:	7f e7                	jg     800ea7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ec0:	e9 66 01 00 00       	jmp    80102b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ec5:	83 ec 08             	sub    $0x8,%esp
  800ec8:	ff 75 e8             	pushl  -0x18(%ebp)
  800ecb:	8d 45 14             	lea    0x14(%ebp),%eax
  800ece:	50                   	push   %eax
  800ecf:	e8 3c fd ff ff       	call   800c10 <getint>
  800ed4:	83 c4 10             	add    $0x10,%esp
  800ed7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eda:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800edd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ee0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ee3:	85 d2                	test   %edx,%edx
  800ee5:	79 23                	jns    800f0a <vprintfmt+0x29b>
				putch('-', putdat);
  800ee7:	83 ec 08             	sub    $0x8,%esp
  800eea:	ff 75 0c             	pushl  0xc(%ebp)
  800eed:	6a 2d                	push   $0x2d
  800eef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef2:	ff d0                	call   *%eax
  800ef4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ef7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800efa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800efd:	f7 d8                	neg    %eax
  800eff:	83 d2 00             	adc    $0x0,%edx
  800f02:	f7 da                	neg    %edx
  800f04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f07:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f0a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f11:	e9 bc 00 00 00       	jmp    800fd2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f16:	83 ec 08             	sub    $0x8,%esp
  800f19:	ff 75 e8             	pushl  -0x18(%ebp)
  800f1c:	8d 45 14             	lea    0x14(%ebp),%eax
  800f1f:	50                   	push   %eax
  800f20:	e8 84 fc ff ff       	call   800ba9 <getuint>
  800f25:	83 c4 10             	add    $0x10,%esp
  800f28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f2b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f2e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f35:	e9 98 00 00 00       	jmp    800fd2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f3a:	83 ec 08             	sub    $0x8,%esp
  800f3d:	ff 75 0c             	pushl  0xc(%ebp)
  800f40:	6a 58                	push   $0x58
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	ff d0                	call   *%eax
  800f47:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f4a:	83 ec 08             	sub    $0x8,%esp
  800f4d:	ff 75 0c             	pushl  0xc(%ebp)
  800f50:	6a 58                	push   $0x58
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	ff d0                	call   *%eax
  800f57:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f5a:	83 ec 08             	sub    $0x8,%esp
  800f5d:	ff 75 0c             	pushl  0xc(%ebp)
  800f60:	6a 58                	push   $0x58
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	ff d0                	call   *%eax
  800f67:	83 c4 10             	add    $0x10,%esp
			break;
  800f6a:	e9 bc 00 00 00       	jmp    80102b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f6f:	83 ec 08             	sub    $0x8,%esp
  800f72:	ff 75 0c             	pushl  0xc(%ebp)
  800f75:	6a 30                	push   $0x30
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	ff d0                	call   *%eax
  800f7c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f7f:	83 ec 08             	sub    $0x8,%esp
  800f82:	ff 75 0c             	pushl  0xc(%ebp)
  800f85:	6a 78                	push   $0x78
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8a:	ff d0                	call   *%eax
  800f8c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f92:	83 c0 04             	add    $0x4,%eax
  800f95:	89 45 14             	mov    %eax,0x14(%ebp)
  800f98:	8b 45 14             	mov    0x14(%ebp),%eax
  800f9b:	83 e8 04             	sub    $0x4,%eax
  800f9e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fa0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fa3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800faa:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fb1:	eb 1f                	jmp    800fd2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fb3:	83 ec 08             	sub    $0x8,%esp
  800fb6:	ff 75 e8             	pushl  -0x18(%ebp)
  800fb9:	8d 45 14             	lea    0x14(%ebp),%eax
  800fbc:	50                   	push   %eax
  800fbd:	e8 e7 fb ff ff       	call   800ba9 <getuint>
  800fc2:	83 c4 10             	add    $0x10,%esp
  800fc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fcb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800fd2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fd6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fd9:	83 ec 04             	sub    $0x4,%esp
  800fdc:	52                   	push   %edx
  800fdd:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fe0:	50                   	push   %eax
  800fe1:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe4:	ff 75 f0             	pushl  -0x10(%ebp)
  800fe7:	ff 75 0c             	pushl  0xc(%ebp)
  800fea:	ff 75 08             	pushl  0x8(%ebp)
  800fed:	e8 00 fb ff ff       	call   800af2 <printnum>
  800ff2:	83 c4 20             	add    $0x20,%esp
			break;
  800ff5:	eb 34                	jmp    80102b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ff7:	83 ec 08             	sub    $0x8,%esp
  800ffa:	ff 75 0c             	pushl  0xc(%ebp)
  800ffd:	53                   	push   %ebx
  800ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  801001:	ff d0                	call   *%eax
  801003:	83 c4 10             	add    $0x10,%esp
			break;
  801006:	eb 23                	jmp    80102b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801008:	83 ec 08             	sub    $0x8,%esp
  80100b:	ff 75 0c             	pushl  0xc(%ebp)
  80100e:	6a 25                	push   $0x25
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	ff d0                	call   *%eax
  801015:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801018:	ff 4d 10             	decl   0x10(%ebp)
  80101b:	eb 03                	jmp    801020 <vprintfmt+0x3b1>
  80101d:	ff 4d 10             	decl   0x10(%ebp)
  801020:	8b 45 10             	mov    0x10(%ebp),%eax
  801023:	48                   	dec    %eax
  801024:	8a 00                	mov    (%eax),%al
  801026:	3c 25                	cmp    $0x25,%al
  801028:	75 f3                	jne    80101d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80102a:	90                   	nop
		}
	}
  80102b:	e9 47 fc ff ff       	jmp    800c77 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801030:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801031:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801034:	5b                   	pop    %ebx
  801035:	5e                   	pop    %esi
  801036:	5d                   	pop    %ebp
  801037:	c3                   	ret    

00801038 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801038:	55                   	push   %ebp
  801039:	89 e5                	mov    %esp,%ebp
  80103b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80103e:	8d 45 10             	lea    0x10(%ebp),%eax
  801041:	83 c0 04             	add    $0x4,%eax
  801044:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801047:	8b 45 10             	mov    0x10(%ebp),%eax
  80104a:	ff 75 f4             	pushl  -0xc(%ebp)
  80104d:	50                   	push   %eax
  80104e:	ff 75 0c             	pushl  0xc(%ebp)
  801051:	ff 75 08             	pushl  0x8(%ebp)
  801054:	e8 16 fc ff ff       	call   800c6f <vprintfmt>
  801059:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80105c:	90                   	nop
  80105d:	c9                   	leave  
  80105e:	c3                   	ret    

0080105f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80105f:	55                   	push   %ebp
  801060:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801062:	8b 45 0c             	mov    0xc(%ebp),%eax
  801065:	8b 40 08             	mov    0x8(%eax),%eax
  801068:	8d 50 01             	lea    0x1(%eax),%edx
  80106b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801071:	8b 45 0c             	mov    0xc(%ebp),%eax
  801074:	8b 10                	mov    (%eax),%edx
  801076:	8b 45 0c             	mov    0xc(%ebp),%eax
  801079:	8b 40 04             	mov    0x4(%eax),%eax
  80107c:	39 c2                	cmp    %eax,%edx
  80107e:	73 12                	jae    801092 <sprintputch+0x33>
		*b->buf++ = ch;
  801080:	8b 45 0c             	mov    0xc(%ebp),%eax
  801083:	8b 00                	mov    (%eax),%eax
  801085:	8d 48 01             	lea    0x1(%eax),%ecx
  801088:	8b 55 0c             	mov    0xc(%ebp),%edx
  80108b:	89 0a                	mov    %ecx,(%edx)
  80108d:	8b 55 08             	mov    0x8(%ebp),%edx
  801090:	88 10                	mov    %dl,(%eax)
}
  801092:	90                   	nop
  801093:	5d                   	pop    %ebp
  801094:	c3                   	ret    

00801095 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801095:	55                   	push   %ebp
  801096:	89 e5                	mov    %esp,%ebp
  801098:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80109b:	8b 45 08             	mov    0x8(%ebp),%eax
  80109e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010aa:	01 d0                	add    %edx,%eax
  8010ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010b6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010ba:	74 06                	je     8010c2 <vsnprintf+0x2d>
  8010bc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010c0:	7f 07                	jg     8010c9 <vsnprintf+0x34>
		return -E_INVAL;
  8010c2:	b8 03 00 00 00       	mov    $0x3,%eax
  8010c7:	eb 20                	jmp    8010e9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010c9:	ff 75 14             	pushl  0x14(%ebp)
  8010cc:	ff 75 10             	pushl  0x10(%ebp)
  8010cf:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010d2:	50                   	push   %eax
  8010d3:	68 5f 10 80 00       	push   $0x80105f
  8010d8:	e8 92 fb ff ff       	call   800c6f <vprintfmt>
  8010dd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010e3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010e9:	c9                   	leave  
  8010ea:	c3                   	ret    

008010eb <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010eb:	55                   	push   %ebp
  8010ec:	89 e5                	mov    %esp,%ebp
  8010ee:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010f1:	8d 45 10             	lea    0x10(%ebp),%eax
  8010f4:	83 c0 04             	add    $0x4,%eax
  8010f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fd:	ff 75 f4             	pushl  -0xc(%ebp)
  801100:	50                   	push   %eax
  801101:	ff 75 0c             	pushl  0xc(%ebp)
  801104:	ff 75 08             	pushl  0x8(%ebp)
  801107:	e8 89 ff ff ff       	call   801095 <vsnprintf>
  80110c:	83 c4 10             	add    $0x10,%esp
  80110f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801112:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801115:	c9                   	leave  
  801116:	c3                   	ret    

00801117 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801117:	55                   	push   %ebp
  801118:	89 e5                	mov    %esp,%ebp
  80111a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80111d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801124:	eb 06                	jmp    80112c <strlen+0x15>
		n++;
  801126:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801129:	ff 45 08             	incl   0x8(%ebp)
  80112c:	8b 45 08             	mov    0x8(%ebp),%eax
  80112f:	8a 00                	mov    (%eax),%al
  801131:	84 c0                	test   %al,%al
  801133:	75 f1                	jne    801126 <strlen+0xf>
		n++;
	return n;
  801135:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801138:	c9                   	leave  
  801139:	c3                   	ret    

0080113a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80113a:	55                   	push   %ebp
  80113b:	89 e5                	mov    %esp,%ebp
  80113d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801140:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801147:	eb 09                	jmp    801152 <strnlen+0x18>
		n++;
  801149:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80114c:	ff 45 08             	incl   0x8(%ebp)
  80114f:	ff 4d 0c             	decl   0xc(%ebp)
  801152:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801156:	74 09                	je     801161 <strnlen+0x27>
  801158:	8b 45 08             	mov    0x8(%ebp),%eax
  80115b:	8a 00                	mov    (%eax),%al
  80115d:	84 c0                	test   %al,%al
  80115f:	75 e8                	jne    801149 <strnlen+0xf>
		n++;
	return n;
  801161:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801164:	c9                   	leave  
  801165:	c3                   	ret    

00801166 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801166:	55                   	push   %ebp
  801167:	89 e5                	mov    %esp,%ebp
  801169:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80116c:	8b 45 08             	mov    0x8(%ebp),%eax
  80116f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801172:	90                   	nop
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8d 50 01             	lea    0x1(%eax),%edx
  801179:	89 55 08             	mov    %edx,0x8(%ebp)
  80117c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80117f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801182:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801185:	8a 12                	mov    (%edx),%dl
  801187:	88 10                	mov    %dl,(%eax)
  801189:	8a 00                	mov    (%eax),%al
  80118b:	84 c0                	test   %al,%al
  80118d:	75 e4                	jne    801173 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80118f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801192:	c9                   	leave  
  801193:	c3                   	ret    

00801194 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801194:	55                   	push   %ebp
  801195:	89 e5                	mov    %esp,%ebp
  801197:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8011a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011a7:	eb 1f                	jmp    8011c8 <strncpy+0x34>
		*dst++ = *src;
  8011a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ac:	8d 50 01             	lea    0x1(%eax),%edx
  8011af:	89 55 08             	mov    %edx,0x8(%ebp)
  8011b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011b5:	8a 12                	mov    (%edx),%dl
  8011b7:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8011b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bc:	8a 00                	mov    (%eax),%al
  8011be:	84 c0                	test   %al,%al
  8011c0:	74 03                	je     8011c5 <strncpy+0x31>
			src++;
  8011c2:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8011c5:	ff 45 fc             	incl   -0x4(%ebp)
  8011c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011cb:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011ce:	72 d9                	jb     8011a9 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8011d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011d3:	c9                   	leave  
  8011d4:	c3                   	ret    

008011d5 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8011d5:	55                   	push   %ebp
  8011d6:	89 e5                	mov    %esp,%ebp
  8011d8:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8011e1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011e5:	74 30                	je     801217 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8011e7:	eb 16                	jmp    8011ff <strlcpy+0x2a>
			*dst++ = *src++;
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	8d 50 01             	lea    0x1(%eax),%edx
  8011ef:	89 55 08             	mov    %edx,0x8(%ebp)
  8011f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011f5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011f8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8011fb:	8a 12                	mov    (%edx),%dl
  8011fd:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8011ff:	ff 4d 10             	decl   0x10(%ebp)
  801202:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801206:	74 09                	je     801211 <strlcpy+0x3c>
  801208:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120b:	8a 00                	mov    (%eax),%al
  80120d:	84 c0                	test   %al,%al
  80120f:	75 d8                	jne    8011e9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801217:	8b 55 08             	mov    0x8(%ebp),%edx
  80121a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80121d:	29 c2                	sub    %eax,%edx
  80121f:	89 d0                	mov    %edx,%eax
}
  801221:	c9                   	leave  
  801222:	c3                   	ret    

00801223 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801223:	55                   	push   %ebp
  801224:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801226:	eb 06                	jmp    80122e <strcmp+0xb>
		p++, q++;
  801228:	ff 45 08             	incl   0x8(%ebp)
  80122b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	8a 00                	mov    (%eax),%al
  801233:	84 c0                	test   %al,%al
  801235:	74 0e                	je     801245 <strcmp+0x22>
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	8a 10                	mov    (%eax),%dl
  80123c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123f:	8a 00                	mov    (%eax),%al
  801241:	38 c2                	cmp    %al,%dl
  801243:	74 e3                	je     801228 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801245:	8b 45 08             	mov    0x8(%ebp),%eax
  801248:	8a 00                	mov    (%eax),%al
  80124a:	0f b6 d0             	movzbl %al,%edx
  80124d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801250:	8a 00                	mov    (%eax),%al
  801252:	0f b6 c0             	movzbl %al,%eax
  801255:	29 c2                	sub    %eax,%edx
  801257:	89 d0                	mov    %edx,%eax
}
  801259:	5d                   	pop    %ebp
  80125a:	c3                   	ret    

0080125b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80125b:	55                   	push   %ebp
  80125c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80125e:	eb 09                	jmp    801269 <strncmp+0xe>
		n--, p++, q++;
  801260:	ff 4d 10             	decl   0x10(%ebp)
  801263:	ff 45 08             	incl   0x8(%ebp)
  801266:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801269:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80126d:	74 17                	je     801286 <strncmp+0x2b>
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
  801272:	8a 00                	mov    (%eax),%al
  801274:	84 c0                	test   %al,%al
  801276:	74 0e                	je     801286 <strncmp+0x2b>
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	8a 10                	mov    (%eax),%dl
  80127d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801280:	8a 00                	mov    (%eax),%al
  801282:	38 c2                	cmp    %al,%dl
  801284:	74 da                	je     801260 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801286:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80128a:	75 07                	jne    801293 <strncmp+0x38>
		return 0;
  80128c:	b8 00 00 00 00       	mov    $0x0,%eax
  801291:	eb 14                	jmp    8012a7 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
  801296:	8a 00                	mov    (%eax),%al
  801298:	0f b6 d0             	movzbl %al,%edx
  80129b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129e:	8a 00                	mov    (%eax),%al
  8012a0:	0f b6 c0             	movzbl %al,%eax
  8012a3:	29 c2                	sub    %eax,%edx
  8012a5:	89 d0                	mov    %edx,%eax
}
  8012a7:	5d                   	pop    %ebp
  8012a8:	c3                   	ret    

008012a9 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8012a9:	55                   	push   %ebp
  8012aa:	89 e5                	mov    %esp,%ebp
  8012ac:	83 ec 04             	sub    $0x4,%esp
  8012af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012b5:	eb 12                	jmp    8012c9 <strchr+0x20>
		if (*s == c)
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ba:	8a 00                	mov    (%eax),%al
  8012bc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8012bf:	75 05                	jne    8012c6 <strchr+0x1d>
			return (char *) s;
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	eb 11                	jmp    8012d7 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8012c6:	ff 45 08             	incl   0x8(%ebp)
  8012c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cc:	8a 00                	mov    (%eax),%al
  8012ce:	84 c0                	test   %al,%al
  8012d0:	75 e5                	jne    8012b7 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8012d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012d7:	c9                   	leave  
  8012d8:	c3                   	ret    

008012d9 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8012d9:	55                   	push   %ebp
  8012da:	89 e5                	mov    %esp,%ebp
  8012dc:	83 ec 04             	sub    $0x4,%esp
  8012df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012e5:	eb 0d                	jmp    8012f4 <strfind+0x1b>
		if (*s == c)
  8012e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ea:	8a 00                	mov    (%eax),%al
  8012ec:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8012ef:	74 0e                	je     8012ff <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8012f1:	ff 45 08             	incl   0x8(%ebp)
  8012f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f7:	8a 00                	mov    (%eax),%al
  8012f9:	84 c0                	test   %al,%al
  8012fb:	75 ea                	jne    8012e7 <strfind+0xe>
  8012fd:	eb 01                	jmp    801300 <strfind+0x27>
		if (*s == c)
			break;
  8012ff:	90                   	nop
	return (char *) s;
  801300:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
  801308:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801311:	8b 45 10             	mov    0x10(%ebp),%eax
  801314:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801317:	eb 0e                	jmp    801327 <memset+0x22>
		*p++ = c;
  801319:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131c:	8d 50 01             	lea    0x1(%eax),%edx
  80131f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801322:	8b 55 0c             	mov    0xc(%ebp),%edx
  801325:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801327:	ff 4d f8             	decl   -0x8(%ebp)
  80132a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80132e:	79 e9                	jns    801319 <memset+0x14>
		*p++ = c;

	return v;
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801333:	c9                   	leave  
  801334:	c3                   	ret    

00801335 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801335:	55                   	push   %ebp
  801336:	89 e5                	mov    %esp,%ebp
  801338:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80133b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801347:	eb 16                	jmp    80135f <memcpy+0x2a>
		*d++ = *s++;
  801349:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80134c:	8d 50 01             	lea    0x1(%eax),%edx
  80134f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801352:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801355:	8d 4a 01             	lea    0x1(%edx),%ecx
  801358:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80135b:	8a 12                	mov    (%edx),%dl
  80135d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80135f:	8b 45 10             	mov    0x10(%ebp),%eax
  801362:	8d 50 ff             	lea    -0x1(%eax),%edx
  801365:	89 55 10             	mov    %edx,0x10(%ebp)
  801368:	85 c0                	test   %eax,%eax
  80136a:	75 dd                	jne    801349 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80136f:	c9                   	leave  
  801370:	c3                   	ret    

00801371 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801371:	55                   	push   %ebp
  801372:	89 e5                	mov    %esp,%ebp
  801374:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801377:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80137d:	8b 45 08             	mov    0x8(%ebp),%eax
  801380:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801383:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801386:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801389:	73 50                	jae    8013db <memmove+0x6a>
  80138b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80138e:	8b 45 10             	mov    0x10(%ebp),%eax
  801391:	01 d0                	add    %edx,%eax
  801393:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801396:	76 43                	jbe    8013db <memmove+0x6a>
		s += n;
  801398:	8b 45 10             	mov    0x10(%ebp),%eax
  80139b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80139e:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a1:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8013a4:	eb 10                	jmp    8013b6 <memmove+0x45>
			*--d = *--s;
  8013a6:	ff 4d f8             	decl   -0x8(%ebp)
  8013a9:	ff 4d fc             	decl   -0x4(%ebp)
  8013ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013af:	8a 10                	mov    (%eax),%dl
  8013b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013b4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8013b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013bc:	89 55 10             	mov    %edx,0x10(%ebp)
  8013bf:	85 c0                	test   %eax,%eax
  8013c1:	75 e3                	jne    8013a6 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8013c3:	eb 23                	jmp    8013e8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8013c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013c8:	8d 50 01             	lea    0x1(%eax),%edx
  8013cb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013ce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013d1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013d4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8013d7:	8a 12                	mov    (%edx),%dl
  8013d9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8013db:	8b 45 10             	mov    0x10(%ebp),%eax
  8013de:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013e1:	89 55 10             	mov    %edx,0x10(%ebp)
  8013e4:	85 c0                	test   %eax,%eax
  8013e6:	75 dd                	jne    8013c5 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8013e8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013eb:	c9                   	leave  
  8013ec:	c3                   	ret    

008013ed <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8013ed:	55                   	push   %ebp
  8013ee:	89 e5                	mov    %esp,%ebp
  8013f0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8013f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8013f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fc:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8013ff:	eb 2a                	jmp    80142b <memcmp+0x3e>
		if (*s1 != *s2)
  801401:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801404:	8a 10                	mov    (%eax),%dl
  801406:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801409:	8a 00                	mov    (%eax),%al
  80140b:	38 c2                	cmp    %al,%dl
  80140d:	74 16                	je     801425 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80140f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801412:	8a 00                	mov    (%eax),%al
  801414:	0f b6 d0             	movzbl %al,%edx
  801417:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80141a:	8a 00                	mov    (%eax),%al
  80141c:	0f b6 c0             	movzbl %al,%eax
  80141f:	29 c2                	sub    %eax,%edx
  801421:	89 d0                	mov    %edx,%eax
  801423:	eb 18                	jmp    80143d <memcmp+0x50>
		s1++, s2++;
  801425:	ff 45 fc             	incl   -0x4(%ebp)
  801428:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80142b:	8b 45 10             	mov    0x10(%ebp),%eax
  80142e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801431:	89 55 10             	mov    %edx,0x10(%ebp)
  801434:	85 c0                	test   %eax,%eax
  801436:	75 c9                	jne    801401 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801438:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80143d:	c9                   	leave  
  80143e:	c3                   	ret    

0080143f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80143f:	55                   	push   %ebp
  801440:	89 e5                	mov    %esp,%ebp
  801442:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801445:	8b 55 08             	mov    0x8(%ebp),%edx
  801448:	8b 45 10             	mov    0x10(%ebp),%eax
  80144b:	01 d0                	add    %edx,%eax
  80144d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801450:	eb 15                	jmp    801467 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
  801455:	8a 00                	mov    (%eax),%al
  801457:	0f b6 d0             	movzbl %al,%edx
  80145a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145d:	0f b6 c0             	movzbl %al,%eax
  801460:	39 c2                	cmp    %eax,%edx
  801462:	74 0d                	je     801471 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801464:	ff 45 08             	incl   0x8(%ebp)
  801467:	8b 45 08             	mov    0x8(%ebp),%eax
  80146a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80146d:	72 e3                	jb     801452 <memfind+0x13>
  80146f:	eb 01                	jmp    801472 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801471:	90                   	nop
	return (void *) s;
  801472:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801475:	c9                   	leave  
  801476:	c3                   	ret    

00801477 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
  80147a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80147d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801484:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80148b:	eb 03                	jmp    801490 <strtol+0x19>
		s++;
  80148d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	8a 00                	mov    (%eax),%al
  801495:	3c 20                	cmp    $0x20,%al
  801497:	74 f4                	je     80148d <strtol+0x16>
  801499:	8b 45 08             	mov    0x8(%ebp),%eax
  80149c:	8a 00                	mov    (%eax),%al
  80149e:	3c 09                	cmp    $0x9,%al
  8014a0:	74 eb                	je     80148d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	8a 00                	mov    (%eax),%al
  8014a7:	3c 2b                	cmp    $0x2b,%al
  8014a9:	75 05                	jne    8014b0 <strtol+0x39>
		s++;
  8014ab:	ff 45 08             	incl   0x8(%ebp)
  8014ae:	eb 13                	jmp    8014c3 <strtol+0x4c>
	else if (*s == '-')
  8014b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b3:	8a 00                	mov    (%eax),%al
  8014b5:	3c 2d                	cmp    $0x2d,%al
  8014b7:	75 0a                	jne    8014c3 <strtol+0x4c>
		s++, neg = 1;
  8014b9:	ff 45 08             	incl   0x8(%ebp)
  8014bc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8014c3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014c7:	74 06                	je     8014cf <strtol+0x58>
  8014c9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8014cd:	75 20                	jne    8014ef <strtol+0x78>
  8014cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d2:	8a 00                	mov    (%eax),%al
  8014d4:	3c 30                	cmp    $0x30,%al
  8014d6:	75 17                	jne    8014ef <strtol+0x78>
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	40                   	inc    %eax
  8014dc:	8a 00                	mov    (%eax),%al
  8014de:	3c 78                	cmp    $0x78,%al
  8014e0:	75 0d                	jne    8014ef <strtol+0x78>
		s += 2, base = 16;
  8014e2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8014e6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8014ed:	eb 28                	jmp    801517 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8014ef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014f3:	75 15                	jne    80150a <strtol+0x93>
  8014f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f8:	8a 00                	mov    (%eax),%al
  8014fa:	3c 30                	cmp    $0x30,%al
  8014fc:	75 0c                	jne    80150a <strtol+0x93>
		s++, base = 8;
  8014fe:	ff 45 08             	incl   0x8(%ebp)
  801501:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801508:	eb 0d                	jmp    801517 <strtol+0xa0>
	else if (base == 0)
  80150a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80150e:	75 07                	jne    801517 <strtol+0xa0>
		base = 10;
  801510:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	8a 00                	mov    (%eax),%al
  80151c:	3c 2f                	cmp    $0x2f,%al
  80151e:	7e 19                	jle    801539 <strtol+0xc2>
  801520:	8b 45 08             	mov    0x8(%ebp),%eax
  801523:	8a 00                	mov    (%eax),%al
  801525:	3c 39                	cmp    $0x39,%al
  801527:	7f 10                	jg     801539 <strtol+0xc2>
			dig = *s - '0';
  801529:	8b 45 08             	mov    0x8(%ebp),%eax
  80152c:	8a 00                	mov    (%eax),%al
  80152e:	0f be c0             	movsbl %al,%eax
  801531:	83 e8 30             	sub    $0x30,%eax
  801534:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801537:	eb 42                	jmp    80157b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801539:	8b 45 08             	mov    0x8(%ebp),%eax
  80153c:	8a 00                	mov    (%eax),%al
  80153e:	3c 60                	cmp    $0x60,%al
  801540:	7e 19                	jle    80155b <strtol+0xe4>
  801542:	8b 45 08             	mov    0x8(%ebp),%eax
  801545:	8a 00                	mov    (%eax),%al
  801547:	3c 7a                	cmp    $0x7a,%al
  801549:	7f 10                	jg     80155b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	8a 00                	mov    (%eax),%al
  801550:	0f be c0             	movsbl %al,%eax
  801553:	83 e8 57             	sub    $0x57,%eax
  801556:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801559:	eb 20                	jmp    80157b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	8a 00                	mov    (%eax),%al
  801560:	3c 40                	cmp    $0x40,%al
  801562:	7e 39                	jle    80159d <strtol+0x126>
  801564:	8b 45 08             	mov    0x8(%ebp),%eax
  801567:	8a 00                	mov    (%eax),%al
  801569:	3c 5a                	cmp    $0x5a,%al
  80156b:	7f 30                	jg     80159d <strtol+0x126>
			dig = *s - 'A' + 10;
  80156d:	8b 45 08             	mov    0x8(%ebp),%eax
  801570:	8a 00                	mov    (%eax),%al
  801572:	0f be c0             	movsbl %al,%eax
  801575:	83 e8 37             	sub    $0x37,%eax
  801578:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80157b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80157e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801581:	7d 19                	jge    80159c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801583:	ff 45 08             	incl   0x8(%ebp)
  801586:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801589:	0f af 45 10          	imul   0x10(%ebp),%eax
  80158d:	89 c2                	mov    %eax,%edx
  80158f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801592:	01 d0                	add    %edx,%eax
  801594:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801597:	e9 7b ff ff ff       	jmp    801517 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80159c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80159d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015a1:	74 08                	je     8015ab <strtol+0x134>
		*endptr = (char *) s;
  8015a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a6:	8b 55 08             	mov    0x8(%ebp),%edx
  8015a9:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8015ab:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015af:	74 07                	je     8015b8 <strtol+0x141>
  8015b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015b4:	f7 d8                	neg    %eax
  8015b6:	eb 03                	jmp    8015bb <strtol+0x144>
  8015b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015bb:	c9                   	leave  
  8015bc:	c3                   	ret    

008015bd <ltostr>:

void
ltostr(long value, char *str)
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
  8015c0:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8015c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8015ca:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8015d1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015d5:	79 13                	jns    8015ea <ltostr+0x2d>
	{
		neg = 1;
  8015d7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8015de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8015e4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8015e7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ed:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8015f2:	99                   	cltd   
  8015f3:	f7 f9                	idiv   %ecx
  8015f5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8015f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015fb:	8d 50 01             	lea    0x1(%eax),%edx
  8015fe:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801601:	89 c2                	mov    %eax,%edx
  801603:	8b 45 0c             	mov    0xc(%ebp),%eax
  801606:	01 d0                	add    %edx,%eax
  801608:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80160b:	83 c2 30             	add    $0x30,%edx
  80160e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801610:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801613:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801618:	f7 e9                	imul   %ecx
  80161a:	c1 fa 02             	sar    $0x2,%edx
  80161d:	89 c8                	mov    %ecx,%eax
  80161f:	c1 f8 1f             	sar    $0x1f,%eax
  801622:	29 c2                	sub    %eax,%edx
  801624:	89 d0                	mov    %edx,%eax
  801626:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801629:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80162c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801631:	f7 e9                	imul   %ecx
  801633:	c1 fa 02             	sar    $0x2,%edx
  801636:	89 c8                	mov    %ecx,%eax
  801638:	c1 f8 1f             	sar    $0x1f,%eax
  80163b:	29 c2                	sub    %eax,%edx
  80163d:	89 d0                	mov    %edx,%eax
  80163f:	c1 e0 02             	shl    $0x2,%eax
  801642:	01 d0                	add    %edx,%eax
  801644:	01 c0                	add    %eax,%eax
  801646:	29 c1                	sub    %eax,%ecx
  801648:	89 ca                	mov    %ecx,%edx
  80164a:	85 d2                	test   %edx,%edx
  80164c:	75 9c                	jne    8015ea <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80164e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801655:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801658:	48                   	dec    %eax
  801659:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80165c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801660:	74 3d                	je     80169f <ltostr+0xe2>
		start = 1 ;
  801662:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801669:	eb 34                	jmp    80169f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80166b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80166e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801671:	01 d0                	add    %edx,%eax
  801673:	8a 00                	mov    (%eax),%al
  801675:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801678:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80167b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80167e:	01 c2                	add    %eax,%edx
  801680:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801683:	8b 45 0c             	mov    0xc(%ebp),%eax
  801686:	01 c8                	add    %ecx,%eax
  801688:	8a 00                	mov    (%eax),%al
  80168a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80168c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80168f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801692:	01 c2                	add    %eax,%edx
  801694:	8a 45 eb             	mov    -0x15(%ebp),%al
  801697:	88 02                	mov    %al,(%edx)
		start++ ;
  801699:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80169c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80169f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016a2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016a5:	7c c4                	jl     80166b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8016a7:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8016aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ad:	01 d0                	add    %edx,%eax
  8016af:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8016b2:	90                   	nop
  8016b3:	c9                   	leave  
  8016b4:	c3                   	ret    

008016b5 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8016b5:	55                   	push   %ebp
  8016b6:	89 e5                	mov    %esp,%ebp
  8016b8:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8016bb:	ff 75 08             	pushl  0x8(%ebp)
  8016be:	e8 54 fa ff ff       	call   801117 <strlen>
  8016c3:	83 c4 04             	add    $0x4,%esp
  8016c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8016c9:	ff 75 0c             	pushl  0xc(%ebp)
  8016cc:	e8 46 fa ff ff       	call   801117 <strlen>
  8016d1:	83 c4 04             	add    $0x4,%esp
  8016d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8016d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8016de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016e5:	eb 17                	jmp    8016fe <strcconcat+0x49>
		final[s] = str1[s] ;
  8016e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ed:	01 c2                	add    %eax,%edx
  8016ef:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8016f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f5:	01 c8                	add    %ecx,%eax
  8016f7:	8a 00                	mov    (%eax),%al
  8016f9:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8016fb:	ff 45 fc             	incl   -0x4(%ebp)
  8016fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801701:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801704:	7c e1                	jl     8016e7 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801706:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80170d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801714:	eb 1f                	jmp    801735 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801716:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801719:	8d 50 01             	lea    0x1(%eax),%edx
  80171c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80171f:	89 c2                	mov    %eax,%edx
  801721:	8b 45 10             	mov    0x10(%ebp),%eax
  801724:	01 c2                	add    %eax,%edx
  801726:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801729:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172c:	01 c8                	add    %ecx,%eax
  80172e:	8a 00                	mov    (%eax),%al
  801730:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801732:	ff 45 f8             	incl   -0x8(%ebp)
  801735:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801738:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80173b:	7c d9                	jl     801716 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80173d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801740:	8b 45 10             	mov    0x10(%ebp),%eax
  801743:	01 d0                	add    %edx,%eax
  801745:	c6 00 00             	movb   $0x0,(%eax)
}
  801748:	90                   	nop
  801749:	c9                   	leave  
  80174a:	c3                   	ret    

0080174b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80174b:	55                   	push   %ebp
  80174c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80174e:	8b 45 14             	mov    0x14(%ebp),%eax
  801751:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801757:	8b 45 14             	mov    0x14(%ebp),%eax
  80175a:	8b 00                	mov    (%eax),%eax
  80175c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801763:	8b 45 10             	mov    0x10(%ebp),%eax
  801766:	01 d0                	add    %edx,%eax
  801768:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80176e:	eb 0c                	jmp    80177c <strsplit+0x31>
			*string++ = 0;
  801770:	8b 45 08             	mov    0x8(%ebp),%eax
  801773:	8d 50 01             	lea    0x1(%eax),%edx
  801776:	89 55 08             	mov    %edx,0x8(%ebp)
  801779:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80177c:	8b 45 08             	mov    0x8(%ebp),%eax
  80177f:	8a 00                	mov    (%eax),%al
  801781:	84 c0                	test   %al,%al
  801783:	74 18                	je     80179d <strsplit+0x52>
  801785:	8b 45 08             	mov    0x8(%ebp),%eax
  801788:	8a 00                	mov    (%eax),%al
  80178a:	0f be c0             	movsbl %al,%eax
  80178d:	50                   	push   %eax
  80178e:	ff 75 0c             	pushl  0xc(%ebp)
  801791:	e8 13 fb ff ff       	call   8012a9 <strchr>
  801796:	83 c4 08             	add    $0x8,%esp
  801799:	85 c0                	test   %eax,%eax
  80179b:	75 d3                	jne    801770 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80179d:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a0:	8a 00                	mov    (%eax),%al
  8017a2:	84 c0                	test   %al,%al
  8017a4:	74 5a                	je     801800 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8017a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8017a9:	8b 00                	mov    (%eax),%eax
  8017ab:	83 f8 0f             	cmp    $0xf,%eax
  8017ae:	75 07                	jne    8017b7 <strsplit+0x6c>
		{
			return 0;
  8017b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8017b5:	eb 66                	jmp    80181d <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8017b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8017ba:	8b 00                	mov    (%eax),%eax
  8017bc:	8d 48 01             	lea    0x1(%eax),%ecx
  8017bf:	8b 55 14             	mov    0x14(%ebp),%edx
  8017c2:	89 0a                	mov    %ecx,(%edx)
  8017c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ce:	01 c2                	add    %eax,%edx
  8017d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d3:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017d5:	eb 03                	jmp    8017da <strsplit+0x8f>
			string++;
  8017d7:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017da:	8b 45 08             	mov    0x8(%ebp),%eax
  8017dd:	8a 00                	mov    (%eax),%al
  8017df:	84 c0                	test   %al,%al
  8017e1:	74 8b                	je     80176e <strsplit+0x23>
  8017e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e6:	8a 00                	mov    (%eax),%al
  8017e8:	0f be c0             	movsbl %al,%eax
  8017eb:	50                   	push   %eax
  8017ec:	ff 75 0c             	pushl  0xc(%ebp)
  8017ef:	e8 b5 fa ff ff       	call   8012a9 <strchr>
  8017f4:	83 c4 08             	add    $0x8,%esp
  8017f7:	85 c0                	test   %eax,%eax
  8017f9:	74 dc                	je     8017d7 <strsplit+0x8c>
			string++;
	}
  8017fb:	e9 6e ff ff ff       	jmp    80176e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801800:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801801:	8b 45 14             	mov    0x14(%ebp),%eax
  801804:	8b 00                	mov    (%eax),%eax
  801806:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80180d:	8b 45 10             	mov    0x10(%ebp),%eax
  801810:	01 d0                	add    %edx,%eax
  801812:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801818:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80181d:	c9                   	leave  
  80181e:	c3                   	ret    

0080181f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80181f:	55                   	push   %ebp
  801820:	89 e5                	mov    %esp,%ebp
  801822:	57                   	push   %edi
  801823:	56                   	push   %esi
  801824:	53                   	push   %ebx
  801825:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801828:	8b 45 08             	mov    0x8(%ebp),%eax
  80182b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801831:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801834:	8b 7d 18             	mov    0x18(%ebp),%edi
  801837:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80183a:	cd 30                	int    $0x30
  80183c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80183f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801842:	83 c4 10             	add    $0x10,%esp
  801845:	5b                   	pop    %ebx
  801846:	5e                   	pop    %esi
  801847:	5f                   	pop    %edi
  801848:	5d                   	pop    %ebp
  801849:	c3                   	ret    

0080184a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80184a:	55                   	push   %ebp
  80184b:	89 e5                	mov    %esp,%ebp
  80184d:	83 ec 04             	sub    $0x4,%esp
  801850:	8b 45 10             	mov    0x10(%ebp),%eax
  801853:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801856:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80185a:	8b 45 08             	mov    0x8(%ebp),%eax
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	52                   	push   %edx
  801862:	ff 75 0c             	pushl  0xc(%ebp)
  801865:	50                   	push   %eax
  801866:	6a 00                	push   $0x0
  801868:	e8 b2 ff ff ff       	call   80181f <syscall>
  80186d:	83 c4 18             	add    $0x18,%esp
}
  801870:	90                   	nop
  801871:	c9                   	leave  
  801872:	c3                   	ret    

00801873 <sys_cgetc>:

int
sys_cgetc(void)
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 01                	push   $0x1
  801882:	e8 98 ff ff ff       	call   80181f <syscall>
  801887:	83 c4 18             	add    $0x18,%esp
}
  80188a:	c9                   	leave  
  80188b:	c3                   	ret    

0080188c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80188c:	55                   	push   %ebp
  80188d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80188f:	8b 45 08             	mov    0x8(%ebp),%eax
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	50                   	push   %eax
  80189b:	6a 05                	push   $0x5
  80189d:	e8 7d ff ff ff       	call   80181f <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 02                	push   $0x2
  8018b6:	e8 64 ff ff ff       	call   80181f <syscall>
  8018bb:	83 c4 18             	add    $0x18,%esp
}
  8018be:	c9                   	leave  
  8018bf:	c3                   	ret    

008018c0 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018c0:	55                   	push   %ebp
  8018c1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 03                	push   $0x3
  8018cf:	e8 4b ff ff ff       	call   80181f <syscall>
  8018d4:	83 c4 18             	add    $0x18,%esp
}
  8018d7:	c9                   	leave  
  8018d8:	c3                   	ret    

008018d9 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018d9:	55                   	push   %ebp
  8018da:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 04                	push   $0x4
  8018e8:	e8 32 ff ff ff       	call   80181f <syscall>
  8018ed:	83 c4 18             	add    $0x18,%esp
}
  8018f0:	c9                   	leave  
  8018f1:	c3                   	ret    

008018f2 <sys_env_exit>:


void sys_env_exit(void)
{
  8018f2:	55                   	push   %ebp
  8018f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 06                	push   $0x6
  801901:	e8 19 ff ff ff       	call   80181f <syscall>
  801906:	83 c4 18             	add    $0x18,%esp
}
  801909:	90                   	nop
  80190a:	c9                   	leave  
  80190b:	c3                   	ret    

0080190c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80190c:	55                   	push   %ebp
  80190d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80190f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	52                   	push   %edx
  80191c:	50                   	push   %eax
  80191d:	6a 07                	push   $0x7
  80191f:	e8 fb fe ff ff       	call   80181f <syscall>
  801924:	83 c4 18             	add    $0x18,%esp
}
  801927:	c9                   	leave  
  801928:	c3                   	ret    

00801929 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801929:	55                   	push   %ebp
  80192a:	89 e5                	mov    %esp,%ebp
  80192c:	56                   	push   %esi
  80192d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80192e:	8b 75 18             	mov    0x18(%ebp),%esi
  801931:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801934:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801937:	8b 55 0c             	mov    0xc(%ebp),%edx
  80193a:	8b 45 08             	mov    0x8(%ebp),%eax
  80193d:	56                   	push   %esi
  80193e:	53                   	push   %ebx
  80193f:	51                   	push   %ecx
  801940:	52                   	push   %edx
  801941:	50                   	push   %eax
  801942:	6a 08                	push   $0x8
  801944:	e8 d6 fe ff ff       	call   80181f <syscall>
  801949:	83 c4 18             	add    $0x18,%esp
}
  80194c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80194f:	5b                   	pop    %ebx
  801950:	5e                   	pop    %esi
  801951:	5d                   	pop    %ebp
  801952:	c3                   	ret    

00801953 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801956:	8b 55 0c             	mov    0xc(%ebp),%edx
  801959:	8b 45 08             	mov    0x8(%ebp),%eax
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	52                   	push   %edx
  801963:	50                   	push   %eax
  801964:	6a 09                	push   $0x9
  801966:	e8 b4 fe ff ff       	call   80181f <syscall>
  80196b:	83 c4 18             	add    $0x18,%esp
}
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	ff 75 0c             	pushl  0xc(%ebp)
  80197c:	ff 75 08             	pushl  0x8(%ebp)
  80197f:	6a 0a                	push   $0xa
  801981:	e8 99 fe ff ff       	call   80181f <syscall>
  801986:	83 c4 18             	add    $0x18,%esp
}
  801989:	c9                   	leave  
  80198a:	c3                   	ret    

0080198b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80198b:	55                   	push   %ebp
  80198c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 0b                	push   $0xb
  80199a:	e8 80 fe ff ff       	call   80181f <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
}
  8019a2:	c9                   	leave  
  8019a3:	c3                   	ret    

008019a4 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8019a4:	55                   	push   %ebp
  8019a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 0c                	push   $0xc
  8019b3:	e8 67 fe ff ff       	call   80181f <syscall>
  8019b8:	83 c4 18             	add    $0x18,%esp
}
  8019bb:	c9                   	leave  
  8019bc:	c3                   	ret    

008019bd <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8019bd:	55                   	push   %ebp
  8019be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 0d                	push   $0xd
  8019cc:	e8 4e fe ff ff       	call   80181f <syscall>
  8019d1:	83 c4 18             	add    $0x18,%esp
}
  8019d4:	c9                   	leave  
  8019d5:	c3                   	ret    

008019d6 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019d6:	55                   	push   %ebp
  8019d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	ff 75 0c             	pushl  0xc(%ebp)
  8019e2:	ff 75 08             	pushl  0x8(%ebp)
  8019e5:	6a 11                	push   $0x11
  8019e7:	e8 33 fe ff ff       	call   80181f <syscall>
  8019ec:	83 c4 18             	add    $0x18,%esp
	return;
  8019ef:	90                   	nop
}
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	ff 75 0c             	pushl  0xc(%ebp)
  8019fe:	ff 75 08             	pushl  0x8(%ebp)
  801a01:	6a 12                	push   $0x12
  801a03:	e8 17 fe ff ff       	call   80181f <syscall>
  801a08:	83 c4 18             	add    $0x18,%esp
	return ;
  801a0b:	90                   	nop
}
  801a0c:	c9                   	leave  
  801a0d:	c3                   	ret    

00801a0e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a0e:	55                   	push   %ebp
  801a0f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 00                	push   $0x0
  801a1b:	6a 0e                	push   $0xe
  801a1d:	e8 fd fd ff ff       	call   80181f <syscall>
  801a22:	83 c4 18             	add    $0x18,%esp
}
  801a25:	c9                   	leave  
  801a26:	c3                   	ret    

00801a27 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	ff 75 08             	pushl  0x8(%ebp)
  801a35:	6a 0f                	push   $0xf
  801a37:	e8 e3 fd ff ff       	call   80181f <syscall>
  801a3c:	83 c4 18             	add    $0x18,%esp
}
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a44:	6a 00                	push   $0x0
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 10                	push   $0x10
  801a50:	e8 ca fd ff ff       	call   80181f <syscall>
  801a55:	83 c4 18             	add    $0x18,%esp
}
  801a58:	90                   	nop
  801a59:	c9                   	leave  
  801a5a:	c3                   	ret    

00801a5b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a5b:	55                   	push   %ebp
  801a5c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	6a 14                	push   $0x14
  801a6a:	e8 b0 fd ff ff       	call   80181f <syscall>
  801a6f:	83 c4 18             	add    $0x18,%esp
}
  801a72:	90                   	nop
  801a73:	c9                   	leave  
  801a74:	c3                   	ret    

00801a75 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a75:	55                   	push   %ebp
  801a76:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 15                	push   $0x15
  801a84:	e8 96 fd ff ff       	call   80181f <syscall>
  801a89:	83 c4 18             	add    $0x18,%esp
}
  801a8c:	90                   	nop
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <sys_cputc>:


void
sys_cputc(const char c)
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
  801a92:	83 ec 04             	sub    $0x4,%esp
  801a95:	8b 45 08             	mov    0x8(%ebp),%eax
  801a98:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a9b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	50                   	push   %eax
  801aa8:	6a 16                	push   $0x16
  801aaa:	e8 70 fd ff ff       	call   80181f <syscall>
  801aaf:	83 c4 18             	add    $0x18,%esp
}
  801ab2:	90                   	nop
  801ab3:	c9                   	leave  
  801ab4:	c3                   	ret    

00801ab5 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ab5:	55                   	push   %ebp
  801ab6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 17                	push   $0x17
  801ac4:	e8 56 fd ff ff       	call   80181f <syscall>
  801ac9:	83 c4 18             	add    $0x18,%esp
}
  801acc:	90                   	nop
  801acd:	c9                   	leave  
  801ace:	c3                   	ret    

00801acf <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801acf:	55                   	push   %ebp
  801ad0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	ff 75 0c             	pushl  0xc(%ebp)
  801ade:	50                   	push   %eax
  801adf:	6a 18                	push   $0x18
  801ae1:	e8 39 fd ff ff       	call   80181f <syscall>
  801ae6:	83 c4 18             	add    $0x18,%esp
}
  801ae9:	c9                   	leave  
  801aea:	c3                   	ret    

00801aeb <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801aeb:	55                   	push   %ebp
  801aec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801aee:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af1:	8b 45 08             	mov    0x8(%ebp),%eax
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	52                   	push   %edx
  801afb:	50                   	push   %eax
  801afc:	6a 1b                	push   $0x1b
  801afe:	e8 1c fd ff ff       	call   80181f <syscall>
  801b03:	83 c4 18             	add    $0x18,%esp
}
  801b06:	c9                   	leave  
  801b07:	c3                   	ret    

00801b08 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b08:	55                   	push   %ebp
  801b09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	52                   	push   %edx
  801b18:	50                   	push   %eax
  801b19:	6a 19                	push   $0x19
  801b1b:	e8 ff fc ff ff       	call   80181f <syscall>
  801b20:	83 c4 18             	add    $0x18,%esp
}
  801b23:	90                   	nop
  801b24:	c9                   	leave  
  801b25:	c3                   	ret    

00801b26 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b26:	55                   	push   %ebp
  801b27:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b29:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	52                   	push   %edx
  801b36:	50                   	push   %eax
  801b37:	6a 1a                	push   $0x1a
  801b39:	e8 e1 fc ff ff       	call   80181f <syscall>
  801b3e:	83 c4 18             	add    $0x18,%esp
}
  801b41:	90                   	nop
  801b42:	c9                   	leave  
  801b43:	c3                   	ret    

00801b44 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b44:	55                   	push   %ebp
  801b45:	89 e5                	mov    %esp,%ebp
  801b47:	83 ec 04             	sub    $0x4,%esp
  801b4a:	8b 45 10             	mov    0x10(%ebp),%eax
  801b4d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b50:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b53:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b57:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5a:	6a 00                	push   $0x0
  801b5c:	51                   	push   %ecx
  801b5d:	52                   	push   %edx
  801b5e:	ff 75 0c             	pushl  0xc(%ebp)
  801b61:	50                   	push   %eax
  801b62:	6a 1c                	push   $0x1c
  801b64:	e8 b6 fc ff ff       	call   80181f <syscall>
  801b69:	83 c4 18             	add    $0x18,%esp
}
  801b6c:	c9                   	leave  
  801b6d:	c3                   	ret    

00801b6e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b6e:	55                   	push   %ebp
  801b6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b71:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b74:	8b 45 08             	mov    0x8(%ebp),%eax
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	52                   	push   %edx
  801b7e:	50                   	push   %eax
  801b7f:	6a 1d                	push   $0x1d
  801b81:	e8 99 fc ff ff       	call   80181f <syscall>
  801b86:	83 c4 18             	add    $0x18,%esp
}
  801b89:	c9                   	leave  
  801b8a:	c3                   	ret    

00801b8b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b8b:	55                   	push   %ebp
  801b8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b8e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b91:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b94:	8b 45 08             	mov    0x8(%ebp),%eax
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	51                   	push   %ecx
  801b9c:	52                   	push   %edx
  801b9d:	50                   	push   %eax
  801b9e:	6a 1e                	push   $0x1e
  801ba0:	e8 7a fc ff ff       	call   80181f <syscall>
  801ba5:	83 c4 18             	add    $0x18,%esp
}
  801ba8:	c9                   	leave  
  801ba9:	c3                   	ret    

00801baa <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801baa:	55                   	push   %ebp
  801bab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801bad:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	52                   	push   %edx
  801bba:	50                   	push   %eax
  801bbb:	6a 1f                	push   $0x1f
  801bbd:	e8 5d fc ff ff       	call   80181f <syscall>
  801bc2:	83 c4 18             	add    $0x18,%esp
}
  801bc5:	c9                   	leave  
  801bc6:	c3                   	ret    

00801bc7 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801bc7:	55                   	push   %ebp
  801bc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 20                	push   $0x20
  801bd6:	e8 44 fc ff ff       	call   80181f <syscall>
  801bdb:	83 c4 18             	add    $0x18,%esp
}
  801bde:	c9                   	leave  
  801bdf:	c3                   	ret    

00801be0 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801be0:	55                   	push   %ebp
  801be1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801be3:	8b 45 08             	mov    0x8(%ebp),%eax
  801be6:	6a 00                	push   $0x0
  801be8:	ff 75 14             	pushl  0x14(%ebp)
  801beb:	ff 75 10             	pushl  0x10(%ebp)
  801bee:	ff 75 0c             	pushl  0xc(%ebp)
  801bf1:	50                   	push   %eax
  801bf2:	6a 21                	push   $0x21
  801bf4:	e8 26 fc ff ff       	call   80181f <syscall>
  801bf9:	83 c4 18             	add    $0x18,%esp
}
  801bfc:	c9                   	leave  
  801bfd:	c3                   	ret    

00801bfe <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801bfe:	55                   	push   %ebp
  801bff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c01:	8b 45 08             	mov    0x8(%ebp),%eax
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	50                   	push   %eax
  801c0d:	6a 22                	push   $0x22
  801c0f:	e8 0b fc ff ff       	call   80181f <syscall>
  801c14:	83 c4 18             	add    $0x18,%esp
}
  801c17:	90                   	nop
  801c18:	c9                   	leave  
  801c19:	c3                   	ret    

00801c1a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c1a:	55                   	push   %ebp
  801c1b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c20:	6a 00                	push   $0x0
  801c22:	6a 00                	push   $0x0
  801c24:	6a 00                	push   $0x0
  801c26:	6a 00                	push   $0x0
  801c28:	50                   	push   %eax
  801c29:	6a 23                	push   $0x23
  801c2b:	e8 ef fb ff ff       	call   80181f <syscall>
  801c30:	83 c4 18             	add    $0x18,%esp
}
  801c33:	90                   	nop
  801c34:	c9                   	leave  
  801c35:	c3                   	ret    

00801c36 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c36:	55                   	push   %ebp
  801c37:	89 e5                	mov    %esp,%ebp
  801c39:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c3c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c3f:	8d 50 04             	lea    0x4(%eax),%edx
  801c42:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	52                   	push   %edx
  801c4c:	50                   	push   %eax
  801c4d:	6a 24                	push   $0x24
  801c4f:	e8 cb fb ff ff       	call   80181f <syscall>
  801c54:	83 c4 18             	add    $0x18,%esp
	return result;
  801c57:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c5a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c5d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c60:	89 01                	mov    %eax,(%ecx)
  801c62:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c65:	8b 45 08             	mov    0x8(%ebp),%eax
  801c68:	c9                   	leave  
  801c69:	c2 04 00             	ret    $0x4

00801c6c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c6c:	55                   	push   %ebp
  801c6d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	ff 75 10             	pushl  0x10(%ebp)
  801c76:	ff 75 0c             	pushl  0xc(%ebp)
  801c79:	ff 75 08             	pushl  0x8(%ebp)
  801c7c:	6a 13                	push   $0x13
  801c7e:	e8 9c fb ff ff       	call   80181f <syscall>
  801c83:	83 c4 18             	add    $0x18,%esp
	return ;
  801c86:	90                   	nop
}
  801c87:	c9                   	leave  
  801c88:	c3                   	ret    

00801c89 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c89:	55                   	push   %ebp
  801c8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 25                	push   $0x25
  801c98:	e8 82 fb ff ff       	call   80181f <syscall>
  801c9d:	83 c4 18             	add    $0x18,%esp
}
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    

00801ca2 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
  801ca5:	83 ec 04             	sub    $0x4,%esp
  801ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cab:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801cae:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	50                   	push   %eax
  801cbb:	6a 26                	push   $0x26
  801cbd:	e8 5d fb ff ff       	call   80181f <syscall>
  801cc2:	83 c4 18             	add    $0x18,%esp
	return ;
  801cc5:	90                   	nop
}
  801cc6:	c9                   	leave  
  801cc7:	c3                   	ret    

00801cc8 <rsttst>:
void rsttst()
{
  801cc8:	55                   	push   %ebp
  801cc9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 28                	push   $0x28
  801cd7:	e8 43 fb ff ff       	call   80181f <syscall>
  801cdc:	83 c4 18             	add    $0x18,%esp
	return ;
  801cdf:	90                   	nop
}
  801ce0:	c9                   	leave  
  801ce1:	c3                   	ret    

00801ce2 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ce2:	55                   	push   %ebp
  801ce3:	89 e5                	mov    %esp,%ebp
  801ce5:	83 ec 04             	sub    $0x4,%esp
  801ce8:	8b 45 14             	mov    0x14(%ebp),%eax
  801ceb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801cee:	8b 55 18             	mov    0x18(%ebp),%edx
  801cf1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cf5:	52                   	push   %edx
  801cf6:	50                   	push   %eax
  801cf7:	ff 75 10             	pushl  0x10(%ebp)
  801cfa:	ff 75 0c             	pushl  0xc(%ebp)
  801cfd:	ff 75 08             	pushl  0x8(%ebp)
  801d00:	6a 27                	push   $0x27
  801d02:	e8 18 fb ff ff       	call   80181f <syscall>
  801d07:	83 c4 18             	add    $0x18,%esp
	return ;
  801d0a:	90                   	nop
}
  801d0b:	c9                   	leave  
  801d0c:	c3                   	ret    

00801d0d <chktst>:
void chktst(uint32 n)
{
  801d0d:	55                   	push   %ebp
  801d0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	ff 75 08             	pushl  0x8(%ebp)
  801d1b:	6a 29                	push   $0x29
  801d1d:	e8 fd fa ff ff       	call   80181f <syscall>
  801d22:	83 c4 18             	add    $0x18,%esp
	return ;
  801d25:	90                   	nop
}
  801d26:	c9                   	leave  
  801d27:	c3                   	ret    

00801d28 <inctst>:

void inctst()
{
  801d28:	55                   	push   %ebp
  801d29:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	6a 00                	push   $0x0
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 2a                	push   $0x2a
  801d37:	e8 e3 fa ff ff       	call   80181f <syscall>
  801d3c:	83 c4 18             	add    $0x18,%esp
	return ;
  801d3f:	90                   	nop
}
  801d40:	c9                   	leave  
  801d41:	c3                   	ret    

00801d42 <gettst>:
uint32 gettst()
{
  801d42:	55                   	push   %ebp
  801d43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 00                	push   $0x0
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 2b                	push   $0x2b
  801d51:	e8 c9 fa ff ff       	call   80181f <syscall>
  801d56:	83 c4 18             	add    $0x18,%esp
}
  801d59:	c9                   	leave  
  801d5a:	c3                   	ret    

00801d5b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d5b:	55                   	push   %ebp
  801d5c:	89 e5                	mov    %esp,%ebp
  801d5e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d61:	6a 00                	push   $0x0
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 2c                	push   $0x2c
  801d6d:	e8 ad fa ff ff       	call   80181f <syscall>
  801d72:	83 c4 18             	add    $0x18,%esp
  801d75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d78:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d7c:	75 07                	jne    801d85 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d83:	eb 05                	jmp    801d8a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d85:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d8a:	c9                   	leave  
  801d8b:	c3                   	ret    

00801d8c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d8c:	55                   	push   %ebp
  801d8d:	89 e5                	mov    %esp,%ebp
  801d8f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 2c                	push   $0x2c
  801d9e:	e8 7c fa ff ff       	call   80181f <syscall>
  801da3:	83 c4 18             	add    $0x18,%esp
  801da6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801da9:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801dad:	75 07                	jne    801db6 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801daf:	b8 01 00 00 00       	mov    $0x1,%eax
  801db4:	eb 05                	jmp    801dbb <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801db6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dbb:	c9                   	leave  
  801dbc:	c3                   	ret    

00801dbd <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801dbd:	55                   	push   %ebp
  801dbe:	89 e5                	mov    %esp,%ebp
  801dc0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 2c                	push   $0x2c
  801dcf:	e8 4b fa ff ff       	call   80181f <syscall>
  801dd4:	83 c4 18             	add    $0x18,%esp
  801dd7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801dda:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801dde:	75 07                	jne    801de7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801de0:	b8 01 00 00 00       	mov    $0x1,%eax
  801de5:	eb 05                	jmp    801dec <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801de7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dec:	c9                   	leave  
  801ded:	c3                   	ret    

00801dee <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801dee:	55                   	push   %ebp
  801def:	89 e5                	mov    %esp,%ebp
  801df1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 00                	push   $0x0
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 2c                	push   $0x2c
  801e00:	e8 1a fa ff ff       	call   80181f <syscall>
  801e05:	83 c4 18             	add    $0x18,%esp
  801e08:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e0b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e0f:	75 07                	jne    801e18 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e11:	b8 01 00 00 00       	mov    $0x1,%eax
  801e16:	eb 05                	jmp    801e1d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e18:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e1d:	c9                   	leave  
  801e1e:	c3                   	ret    

00801e1f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e1f:	55                   	push   %ebp
  801e20:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	6a 00                	push   $0x0
  801e2a:	ff 75 08             	pushl  0x8(%ebp)
  801e2d:	6a 2d                	push   $0x2d
  801e2f:	e8 eb f9 ff ff       	call   80181f <syscall>
  801e34:	83 c4 18             	add    $0x18,%esp
	return ;
  801e37:	90                   	nop
}
  801e38:	c9                   	leave  
  801e39:	c3                   	ret    

00801e3a <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e3a:	55                   	push   %ebp
  801e3b:	89 e5                	mov    %esp,%ebp
  801e3d:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e3e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e41:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e44:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e47:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4a:	6a 00                	push   $0x0
  801e4c:	53                   	push   %ebx
  801e4d:	51                   	push   %ecx
  801e4e:	52                   	push   %edx
  801e4f:	50                   	push   %eax
  801e50:	6a 2e                	push   $0x2e
  801e52:	e8 c8 f9 ff ff       	call   80181f <syscall>
  801e57:	83 c4 18             	add    $0x18,%esp
}
  801e5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801e5d:	c9                   	leave  
  801e5e:	c3                   	ret    

00801e5f <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801e5f:	55                   	push   %ebp
  801e60:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801e62:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e65:	8b 45 08             	mov    0x8(%ebp),%eax
  801e68:	6a 00                	push   $0x0
  801e6a:	6a 00                	push   $0x0
  801e6c:	6a 00                	push   $0x0
  801e6e:	52                   	push   %edx
  801e6f:	50                   	push   %eax
  801e70:	6a 2f                	push   $0x2f
  801e72:	e8 a8 f9 ff ff       	call   80181f <syscall>
  801e77:	83 c4 18             	add    $0x18,%esp
}
  801e7a:	c9                   	leave  
  801e7b:	c3                   	ret    

00801e7c <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801e7c:	55                   	push   %ebp
  801e7d:	89 e5                	mov    %esp,%ebp
  801e7f:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801e82:	8b 55 08             	mov    0x8(%ebp),%edx
  801e85:	89 d0                	mov    %edx,%eax
  801e87:	c1 e0 02             	shl    $0x2,%eax
  801e8a:	01 d0                	add    %edx,%eax
  801e8c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e93:	01 d0                	add    %edx,%eax
  801e95:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e9c:	01 d0                	add    %edx,%eax
  801e9e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ea5:	01 d0                	add    %edx,%eax
  801ea7:	c1 e0 04             	shl    $0x4,%eax
  801eaa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801ead:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801eb4:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801eb7:	83 ec 0c             	sub    $0xc,%esp
  801eba:	50                   	push   %eax
  801ebb:	e8 76 fd ff ff       	call   801c36 <sys_get_virtual_time>
  801ec0:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801ec3:	eb 41                	jmp    801f06 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801ec5:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801ec8:	83 ec 0c             	sub    $0xc,%esp
  801ecb:	50                   	push   %eax
  801ecc:	e8 65 fd ff ff       	call   801c36 <sys_get_virtual_time>
  801ed1:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801ed4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ed7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801eda:	29 c2                	sub    %eax,%edx
  801edc:	89 d0                	mov    %edx,%eax
  801ede:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801ee1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801ee4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ee7:	89 d1                	mov    %edx,%ecx
  801ee9:	29 c1                	sub    %eax,%ecx
  801eeb:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801eee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ef1:	39 c2                	cmp    %eax,%edx
  801ef3:	0f 97 c0             	seta   %al
  801ef6:	0f b6 c0             	movzbl %al,%eax
  801ef9:	29 c1                	sub    %eax,%ecx
  801efb:	89 c8                	mov    %ecx,%eax
  801efd:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801f00:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801f03:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801f06:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f09:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801f0c:	72 b7                	jb     801ec5 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801f0e:	90                   	nop
  801f0f:	c9                   	leave  
  801f10:	c3                   	ret    

00801f11 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
  801f14:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801f17:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801f1e:	eb 03                	jmp    801f23 <busy_wait+0x12>
  801f20:	ff 45 fc             	incl   -0x4(%ebp)
  801f23:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f26:	3b 45 08             	cmp    0x8(%ebp),%eax
  801f29:	72 f5                	jb     801f20 <busy_wait+0xf>
	return i;
  801f2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f2e:	c9                   	leave  
  801f2f:	c3                   	ret    

00801f30 <__udivdi3>:
  801f30:	55                   	push   %ebp
  801f31:	57                   	push   %edi
  801f32:	56                   	push   %esi
  801f33:	53                   	push   %ebx
  801f34:	83 ec 1c             	sub    $0x1c,%esp
  801f37:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f3b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f3f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f43:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f47:	89 ca                	mov    %ecx,%edx
  801f49:	89 f8                	mov    %edi,%eax
  801f4b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f4f:	85 f6                	test   %esi,%esi
  801f51:	75 2d                	jne    801f80 <__udivdi3+0x50>
  801f53:	39 cf                	cmp    %ecx,%edi
  801f55:	77 65                	ja     801fbc <__udivdi3+0x8c>
  801f57:	89 fd                	mov    %edi,%ebp
  801f59:	85 ff                	test   %edi,%edi
  801f5b:	75 0b                	jne    801f68 <__udivdi3+0x38>
  801f5d:	b8 01 00 00 00       	mov    $0x1,%eax
  801f62:	31 d2                	xor    %edx,%edx
  801f64:	f7 f7                	div    %edi
  801f66:	89 c5                	mov    %eax,%ebp
  801f68:	31 d2                	xor    %edx,%edx
  801f6a:	89 c8                	mov    %ecx,%eax
  801f6c:	f7 f5                	div    %ebp
  801f6e:	89 c1                	mov    %eax,%ecx
  801f70:	89 d8                	mov    %ebx,%eax
  801f72:	f7 f5                	div    %ebp
  801f74:	89 cf                	mov    %ecx,%edi
  801f76:	89 fa                	mov    %edi,%edx
  801f78:	83 c4 1c             	add    $0x1c,%esp
  801f7b:	5b                   	pop    %ebx
  801f7c:	5e                   	pop    %esi
  801f7d:	5f                   	pop    %edi
  801f7e:	5d                   	pop    %ebp
  801f7f:	c3                   	ret    
  801f80:	39 ce                	cmp    %ecx,%esi
  801f82:	77 28                	ja     801fac <__udivdi3+0x7c>
  801f84:	0f bd fe             	bsr    %esi,%edi
  801f87:	83 f7 1f             	xor    $0x1f,%edi
  801f8a:	75 40                	jne    801fcc <__udivdi3+0x9c>
  801f8c:	39 ce                	cmp    %ecx,%esi
  801f8e:	72 0a                	jb     801f9a <__udivdi3+0x6a>
  801f90:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f94:	0f 87 9e 00 00 00    	ja     802038 <__udivdi3+0x108>
  801f9a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f9f:	89 fa                	mov    %edi,%edx
  801fa1:	83 c4 1c             	add    $0x1c,%esp
  801fa4:	5b                   	pop    %ebx
  801fa5:	5e                   	pop    %esi
  801fa6:	5f                   	pop    %edi
  801fa7:	5d                   	pop    %ebp
  801fa8:	c3                   	ret    
  801fa9:	8d 76 00             	lea    0x0(%esi),%esi
  801fac:	31 ff                	xor    %edi,%edi
  801fae:	31 c0                	xor    %eax,%eax
  801fb0:	89 fa                	mov    %edi,%edx
  801fb2:	83 c4 1c             	add    $0x1c,%esp
  801fb5:	5b                   	pop    %ebx
  801fb6:	5e                   	pop    %esi
  801fb7:	5f                   	pop    %edi
  801fb8:	5d                   	pop    %ebp
  801fb9:	c3                   	ret    
  801fba:	66 90                	xchg   %ax,%ax
  801fbc:	89 d8                	mov    %ebx,%eax
  801fbe:	f7 f7                	div    %edi
  801fc0:	31 ff                	xor    %edi,%edi
  801fc2:	89 fa                	mov    %edi,%edx
  801fc4:	83 c4 1c             	add    $0x1c,%esp
  801fc7:	5b                   	pop    %ebx
  801fc8:	5e                   	pop    %esi
  801fc9:	5f                   	pop    %edi
  801fca:	5d                   	pop    %ebp
  801fcb:	c3                   	ret    
  801fcc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801fd1:	89 eb                	mov    %ebp,%ebx
  801fd3:	29 fb                	sub    %edi,%ebx
  801fd5:	89 f9                	mov    %edi,%ecx
  801fd7:	d3 e6                	shl    %cl,%esi
  801fd9:	89 c5                	mov    %eax,%ebp
  801fdb:	88 d9                	mov    %bl,%cl
  801fdd:	d3 ed                	shr    %cl,%ebp
  801fdf:	89 e9                	mov    %ebp,%ecx
  801fe1:	09 f1                	or     %esi,%ecx
  801fe3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801fe7:	89 f9                	mov    %edi,%ecx
  801fe9:	d3 e0                	shl    %cl,%eax
  801feb:	89 c5                	mov    %eax,%ebp
  801fed:	89 d6                	mov    %edx,%esi
  801fef:	88 d9                	mov    %bl,%cl
  801ff1:	d3 ee                	shr    %cl,%esi
  801ff3:	89 f9                	mov    %edi,%ecx
  801ff5:	d3 e2                	shl    %cl,%edx
  801ff7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ffb:	88 d9                	mov    %bl,%cl
  801ffd:	d3 e8                	shr    %cl,%eax
  801fff:	09 c2                	or     %eax,%edx
  802001:	89 d0                	mov    %edx,%eax
  802003:	89 f2                	mov    %esi,%edx
  802005:	f7 74 24 0c          	divl   0xc(%esp)
  802009:	89 d6                	mov    %edx,%esi
  80200b:	89 c3                	mov    %eax,%ebx
  80200d:	f7 e5                	mul    %ebp
  80200f:	39 d6                	cmp    %edx,%esi
  802011:	72 19                	jb     80202c <__udivdi3+0xfc>
  802013:	74 0b                	je     802020 <__udivdi3+0xf0>
  802015:	89 d8                	mov    %ebx,%eax
  802017:	31 ff                	xor    %edi,%edi
  802019:	e9 58 ff ff ff       	jmp    801f76 <__udivdi3+0x46>
  80201e:	66 90                	xchg   %ax,%ax
  802020:	8b 54 24 08          	mov    0x8(%esp),%edx
  802024:	89 f9                	mov    %edi,%ecx
  802026:	d3 e2                	shl    %cl,%edx
  802028:	39 c2                	cmp    %eax,%edx
  80202a:	73 e9                	jae    802015 <__udivdi3+0xe5>
  80202c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80202f:	31 ff                	xor    %edi,%edi
  802031:	e9 40 ff ff ff       	jmp    801f76 <__udivdi3+0x46>
  802036:	66 90                	xchg   %ax,%ax
  802038:	31 c0                	xor    %eax,%eax
  80203a:	e9 37 ff ff ff       	jmp    801f76 <__udivdi3+0x46>
  80203f:	90                   	nop

00802040 <__umoddi3>:
  802040:	55                   	push   %ebp
  802041:	57                   	push   %edi
  802042:	56                   	push   %esi
  802043:	53                   	push   %ebx
  802044:	83 ec 1c             	sub    $0x1c,%esp
  802047:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80204b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80204f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802053:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802057:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80205b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80205f:	89 f3                	mov    %esi,%ebx
  802061:	89 fa                	mov    %edi,%edx
  802063:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802067:	89 34 24             	mov    %esi,(%esp)
  80206a:	85 c0                	test   %eax,%eax
  80206c:	75 1a                	jne    802088 <__umoddi3+0x48>
  80206e:	39 f7                	cmp    %esi,%edi
  802070:	0f 86 a2 00 00 00    	jbe    802118 <__umoddi3+0xd8>
  802076:	89 c8                	mov    %ecx,%eax
  802078:	89 f2                	mov    %esi,%edx
  80207a:	f7 f7                	div    %edi
  80207c:	89 d0                	mov    %edx,%eax
  80207e:	31 d2                	xor    %edx,%edx
  802080:	83 c4 1c             	add    $0x1c,%esp
  802083:	5b                   	pop    %ebx
  802084:	5e                   	pop    %esi
  802085:	5f                   	pop    %edi
  802086:	5d                   	pop    %ebp
  802087:	c3                   	ret    
  802088:	39 f0                	cmp    %esi,%eax
  80208a:	0f 87 ac 00 00 00    	ja     80213c <__umoddi3+0xfc>
  802090:	0f bd e8             	bsr    %eax,%ebp
  802093:	83 f5 1f             	xor    $0x1f,%ebp
  802096:	0f 84 ac 00 00 00    	je     802148 <__umoddi3+0x108>
  80209c:	bf 20 00 00 00       	mov    $0x20,%edi
  8020a1:	29 ef                	sub    %ebp,%edi
  8020a3:	89 fe                	mov    %edi,%esi
  8020a5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8020a9:	89 e9                	mov    %ebp,%ecx
  8020ab:	d3 e0                	shl    %cl,%eax
  8020ad:	89 d7                	mov    %edx,%edi
  8020af:	89 f1                	mov    %esi,%ecx
  8020b1:	d3 ef                	shr    %cl,%edi
  8020b3:	09 c7                	or     %eax,%edi
  8020b5:	89 e9                	mov    %ebp,%ecx
  8020b7:	d3 e2                	shl    %cl,%edx
  8020b9:	89 14 24             	mov    %edx,(%esp)
  8020bc:	89 d8                	mov    %ebx,%eax
  8020be:	d3 e0                	shl    %cl,%eax
  8020c0:	89 c2                	mov    %eax,%edx
  8020c2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020c6:	d3 e0                	shl    %cl,%eax
  8020c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8020cc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020d0:	89 f1                	mov    %esi,%ecx
  8020d2:	d3 e8                	shr    %cl,%eax
  8020d4:	09 d0                	or     %edx,%eax
  8020d6:	d3 eb                	shr    %cl,%ebx
  8020d8:	89 da                	mov    %ebx,%edx
  8020da:	f7 f7                	div    %edi
  8020dc:	89 d3                	mov    %edx,%ebx
  8020de:	f7 24 24             	mull   (%esp)
  8020e1:	89 c6                	mov    %eax,%esi
  8020e3:	89 d1                	mov    %edx,%ecx
  8020e5:	39 d3                	cmp    %edx,%ebx
  8020e7:	0f 82 87 00 00 00    	jb     802174 <__umoddi3+0x134>
  8020ed:	0f 84 91 00 00 00    	je     802184 <__umoddi3+0x144>
  8020f3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8020f7:	29 f2                	sub    %esi,%edx
  8020f9:	19 cb                	sbb    %ecx,%ebx
  8020fb:	89 d8                	mov    %ebx,%eax
  8020fd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802101:	d3 e0                	shl    %cl,%eax
  802103:	89 e9                	mov    %ebp,%ecx
  802105:	d3 ea                	shr    %cl,%edx
  802107:	09 d0                	or     %edx,%eax
  802109:	89 e9                	mov    %ebp,%ecx
  80210b:	d3 eb                	shr    %cl,%ebx
  80210d:	89 da                	mov    %ebx,%edx
  80210f:	83 c4 1c             	add    $0x1c,%esp
  802112:	5b                   	pop    %ebx
  802113:	5e                   	pop    %esi
  802114:	5f                   	pop    %edi
  802115:	5d                   	pop    %ebp
  802116:	c3                   	ret    
  802117:	90                   	nop
  802118:	89 fd                	mov    %edi,%ebp
  80211a:	85 ff                	test   %edi,%edi
  80211c:	75 0b                	jne    802129 <__umoddi3+0xe9>
  80211e:	b8 01 00 00 00       	mov    $0x1,%eax
  802123:	31 d2                	xor    %edx,%edx
  802125:	f7 f7                	div    %edi
  802127:	89 c5                	mov    %eax,%ebp
  802129:	89 f0                	mov    %esi,%eax
  80212b:	31 d2                	xor    %edx,%edx
  80212d:	f7 f5                	div    %ebp
  80212f:	89 c8                	mov    %ecx,%eax
  802131:	f7 f5                	div    %ebp
  802133:	89 d0                	mov    %edx,%eax
  802135:	e9 44 ff ff ff       	jmp    80207e <__umoddi3+0x3e>
  80213a:	66 90                	xchg   %ax,%ax
  80213c:	89 c8                	mov    %ecx,%eax
  80213e:	89 f2                	mov    %esi,%edx
  802140:	83 c4 1c             	add    $0x1c,%esp
  802143:	5b                   	pop    %ebx
  802144:	5e                   	pop    %esi
  802145:	5f                   	pop    %edi
  802146:	5d                   	pop    %ebp
  802147:	c3                   	ret    
  802148:	3b 04 24             	cmp    (%esp),%eax
  80214b:	72 06                	jb     802153 <__umoddi3+0x113>
  80214d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802151:	77 0f                	ja     802162 <__umoddi3+0x122>
  802153:	89 f2                	mov    %esi,%edx
  802155:	29 f9                	sub    %edi,%ecx
  802157:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80215b:	89 14 24             	mov    %edx,(%esp)
  80215e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802162:	8b 44 24 04          	mov    0x4(%esp),%eax
  802166:	8b 14 24             	mov    (%esp),%edx
  802169:	83 c4 1c             	add    $0x1c,%esp
  80216c:	5b                   	pop    %ebx
  80216d:	5e                   	pop    %esi
  80216e:	5f                   	pop    %edi
  80216f:	5d                   	pop    %ebp
  802170:	c3                   	ret    
  802171:	8d 76 00             	lea    0x0(%esi),%esi
  802174:	2b 04 24             	sub    (%esp),%eax
  802177:	19 fa                	sbb    %edi,%edx
  802179:	89 d1                	mov    %edx,%ecx
  80217b:	89 c6                	mov    %eax,%esi
  80217d:	e9 71 ff ff ff       	jmp    8020f3 <__umoddi3+0xb3>
  802182:	66 90                	xchg   %ax,%ax
  802184:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802188:	72 ea                	jb     802174 <__umoddi3+0x134>
  80218a:	89 d9                	mov    %ebx,%ecx
  80218c:	e9 62 ff ff ff       	jmp    8020f3 <__umoddi3+0xb3>
