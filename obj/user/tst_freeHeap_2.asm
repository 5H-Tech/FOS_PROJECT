
obj/user/tst_freeHeap_2:     file format elf32-i386


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
  800031:	e8 a4 05 00 00       	call   8005da <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

char z[5*1024*1024] ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec cc 00 00 00    	sub    $0xcc,%esp
	
	

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x0)  		panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800044:	a1 20 30 80 00       	mov    0x803020,%eax
  800049:	8b 80 f8 38 01 00    	mov    0x138f8(%eax),%eax
  80004f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800052:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800055:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  80005a:	85 c0                	test   %eax,%eax
  80005c:	74 14                	je     800072 <_main+0x3a>
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	68 a0 23 80 00       	push   $0x8023a0
  800066:	6a 13                	push   $0x13
  800068:	68 e9 23 80 00       	push   $0x8023e9
  80006d:	e8 ad 06 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x800000)  	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800072:	a1 20 30 80 00       	mov    0x803020,%eax
  800077:	8b 80 08 39 01 00    	mov    0x13908(%eax),%eax
  80007d:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800080:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800083:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800088:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80008d:	74 14                	je     8000a3 <_main+0x6b>
  80008f:	83 ec 04             	sub    $0x4,%esp
  800092:	68 a0 23 80 00       	push   $0x8023a0
  800097:	6a 14                	push   $0x14
  800099:	68 e9 23 80 00       	push   $0x8023e9
  80009e:	e8 7c 06 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)	panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a8:	8b 80 18 39 01 00    	mov    0x13918(%eax),%eax
  8000ae:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8000b1:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000b4:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000b9:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000be:	74 14                	je     8000d4 <_main+0x9c>
  8000c0:	83 ec 04             	sub    $0x4,%esp
  8000c3:	68 a0 23 80 00       	push   $0x8023a0
  8000c8:	6a 15                	push   $0x15
  8000ca:	68 e9 23 80 00       	push   $0x8023e9
  8000cf:	e8 4b 06 00 00       	call   80071f <_panic>
		if( myEnv->__ptr_tws[3].empty !=  1)  											panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d9:	8a 80 2c 39 01 00    	mov    0x1392c(%eax),%al
  8000df:	3c 01                	cmp    $0x1,%al
  8000e1:	74 14                	je     8000f7 <_main+0xbf>
  8000e3:	83 ec 04             	sub    $0x4,%esp
  8000e6:	68 a0 23 80 00       	push   $0x8023a0
  8000eb:	6a 16                	push   $0x16
  8000ed:	68 e9 23 80 00       	push   $0x8023e9
  8000f2:	e8 28 06 00 00       	call   80071f <_panic>

		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000f7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000fc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800102:	8b 00                	mov    (%eax),%eax
  800104:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800107:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80010a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80010f:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800114:	74 14                	je     80012a <_main+0xf2>
  800116:	83 ec 04             	sub    $0x4,%esp
  800119:	68 00 24 80 00       	push   $0x802400
  80011e:	6a 18                	push   $0x18
  800120:	68 e9 23 80 00       	push   $0x8023e9
  800125:	e8 f5 05 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80012a:	a1 20 30 80 00       	mov    0x803020,%eax
  80012f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800135:	83 c0 10             	add    $0x10,%eax
  800138:	8b 00                	mov    (%eax),%eax
  80013a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80013d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800140:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800145:	3d 00 10 20 00       	cmp    $0x201000,%eax
  80014a:	74 14                	je     800160 <_main+0x128>
  80014c:	83 ec 04             	sub    $0x4,%esp
  80014f:	68 00 24 80 00       	push   $0x802400
  800154:	6a 19                	push   $0x19
  800156:	68 e9 23 80 00       	push   $0x8023e9
  80015b:	e8 bf 05 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800160:	a1 20 30 80 00       	mov    0x803020,%eax
  800165:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80016b:	83 c0 20             	add    $0x20,%eax
  80016e:	8b 00                	mov    (%eax),%eax
  800170:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800173:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800176:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80017b:	3d 00 20 20 00       	cmp    $0x202000,%eax
  800180:	74 14                	je     800196 <_main+0x15e>
  800182:	83 ec 04             	sub    $0x4,%esp
  800185:	68 00 24 80 00       	push   $0x802400
  80018a:	6a 1a                	push   $0x1a
  80018c:	68 e9 23 80 00       	push   $0x8023e9
  800191:	e8 89 05 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800196:	a1 20 30 80 00       	mov    0x803020,%eax
  80019b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001a1:	83 c0 30             	add    $0x30,%eax
  8001a4:	8b 00                	mov    (%eax),%eax
  8001a6:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001a9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001ac:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001b1:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8001b6:	74 14                	je     8001cc <_main+0x194>
  8001b8:	83 ec 04             	sub    $0x4,%esp
  8001bb:	68 00 24 80 00       	push   $0x802400
  8001c0:	6a 1b                	push   $0x1b
  8001c2:	68 e9 23 80 00       	push   $0x8023e9
  8001c7:	e8 53 05 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001d7:	83 c0 40             	add    $0x40,%eax
  8001da:	8b 00                	mov    (%eax),%eax
  8001dc:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001df:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8001e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001e7:	3d 00 40 20 00       	cmp    $0x204000,%eax
  8001ec:	74 14                	je     800202 <_main+0x1ca>
  8001ee:	83 ec 04             	sub    $0x4,%esp
  8001f1:	68 00 24 80 00       	push   $0x802400
  8001f6:	6a 1c                	push   $0x1c
  8001f8:	68 e9 23 80 00       	push   $0x8023e9
  8001fd:	e8 1d 05 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800202:	a1 20 30 80 00       	mov    0x803020,%eax
  800207:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80020d:	83 c0 50             	add    $0x50,%eax
  800210:	8b 00                	mov    (%eax),%eax
  800212:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800215:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800218:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80021d:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800222:	74 14                	je     800238 <_main+0x200>
  800224:	83 ec 04             	sub    $0x4,%esp
  800227:	68 00 24 80 00       	push   $0x802400
  80022c:	6a 1d                	push   $0x1d
  80022e:	68 e9 23 80 00       	push   $0x8023e9
  800233:	e8 e7 04 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800238:	a1 20 30 80 00       	mov    0x803020,%eax
  80023d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800243:	83 c0 60             	add    $0x60,%eax
  800246:	8b 00                	mov    (%eax),%eax
  800248:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80024b:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80024e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800253:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800258:	74 14                	je     80026e <_main+0x236>
  80025a:	83 ec 04             	sub    $0x4,%esp
  80025d:	68 00 24 80 00       	push   $0x802400
  800262:	6a 1e                	push   $0x1e
  800264:	68 e9 23 80 00       	push   $0x8023e9
  800269:	e8 b1 04 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80026e:	a1 20 30 80 00       	mov    0x803020,%eax
  800273:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800279:	83 c0 70             	add    $0x70,%eax
  80027c:	8b 00                	mov    (%eax),%eax
  80027e:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800281:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800284:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800289:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80028e:	74 14                	je     8002a4 <_main+0x26c>
  800290:	83 ec 04             	sub    $0x4,%esp
  800293:	68 00 24 80 00       	push   $0x802400
  800298:	6a 1f                	push   $0x1f
  80029a:	68 e9 23 80 00       	push   $0x8023e9
  80029f:	e8 7b 04 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002af:	83 e8 80             	sub    $0xffffff80,%eax
  8002b2:	8b 00                	mov    (%eax),%eax
  8002b4:	89 45 a8             	mov    %eax,-0x58(%ebp)
  8002b7:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8002ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002bf:	3d 00 20 80 00       	cmp    $0x802000,%eax
  8002c4:	74 14                	je     8002da <_main+0x2a2>
  8002c6:	83 ec 04             	sub    $0x4,%esp
  8002c9:	68 00 24 80 00       	push   $0x802400
  8002ce:	6a 20                	push   $0x20
  8002d0:	68 e9 23 80 00       	push   $0x8023e9
  8002d5:	e8 45 04 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8002da:	a1 20 30 80 00       	mov    0x803020,%eax
  8002df:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002e5:	05 90 00 00 00       	add    $0x90,%eax
  8002ea:	8b 00                	mov    (%eax),%eax
  8002ec:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8002ef:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8002f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002f7:	3d 00 30 80 00       	cmp    $0x803000,%eax
  8002fc:	74 14                	je     800312 <_main+0x2da>
  8002fe:	83 ec 04             	sub    $0x4,%esp
  800301:	68 00 24 80 00       	push   $0x802400
  800306:	6a 21                	push   $0x21
  800308:	68 e9 23 80 00       	push   $0x8023e9
  80030d:	e8 0d 04 00 00       	call   80071f <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800312:	a1 20 30 80 00       	mov    0x803020,%eax
  800317:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80031d:	05 a0 00 00 00       	add    $0xa0,%eax
  800322:	8b 00                	mov    (%eax),%eax
  800324:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800327:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80032a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80032f:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800334:	74 14                	je     80034a <_main+0x312>
  800336:	83 ec 04             	sub    $0x4,%esp
  800339:	68 00 24 80 00       	push   $0x802400
  80033e:	6a 22                	push   $0x22
  800340:	68 e9 23 80 00       	push   $0x8023e9
  800345:	e8 d5 03 00 00       	call   80071f <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  80034a:	a1 20 30 80 00       	mov    0x803020,%eax
  80034f:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  800355:	85 c0                	test   %eax,%eax
  800357:	74 14                	je     80036d <_main+0x335>
  800359:	83 ec 04             	sub    $0x4,%esp
  80035c:	68 48 24 80 00       	push   $0x802448
  800361:	6a 23                	push   $0x23
  800363:	68 e9 23 80 00       	push   $0x8023e9
  800368:	e8 b2 03 00 00       	call   80071f <_panic>
	}


	int kilo = 1024;
  80036d:	c7 45 9c 00 04 00 00 	movl   $0x400,-0x64(%ebp)
	int Mega = 1024*1024;
  800374:	c7 45 98 00 00 10 00 	movl   $0x100000,-0x68(%ebp)

	/// testing freeHeap()
	{

		uint32 size = 13*Mega;
  80037b:	8b 55 98             	mov    -0x68(%ebp),%edx
  80037e:	89 d0                	mov    %edx,%eax
  800380:	01 c0                	add    %eax,%eax
  800382:	01 d0                	add    %edx,%eax
  800384:	c1 e0 02             	shl    $0x2,%eax
  800387:	01 d0                	add    %edx,%eax
  800389:	89 45 94             	mov    %eax,-0x6c(%ebp)
		char *x = malloc(sizeof( char)*size) ;
  80038c:	83 ec 0c             	sub    $0xc,%esp
  80038f:	ff 75 94             	pushl  -0x6c(%ebp)
  800392:	e8 b4 13 00 00       	call   80174b <malloc>
  800397:	83 c4 10             	add    $0x10,%esp
  80039a:	89 45 90             	mov    %eax,-0x70(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  80039d:	83 ec 0c             	sub    $0xc,%esp
  8003a0:	ff 75 94             	pushl  -0x6c(%ebp)
  8003a3:	e8 a3 13 00 00       	call   80174b <malloc>
  8003a8:	83 c4 10             	add    $0x10,%esp
  8003ab:	89 45 8c             	mov    %eax,-0x74(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003ae:	e8 02 19 00 00       	call   801cb5 <sys_pf_calculate_allocated_pages>
  8003b3:	89 45 88             	mov    %eax,-0x78(%ebp)

		x[1]=-1;
  8003b6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003b9:	40                   	inc    %eax
  8003ba:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega]=-1;
  8003bd:	8b 55 98             	mov    -0x68(%ebp),%edx
  8003c0:	89 d0                	mov    %edx,%eax
  8003c2:	c1 e0 02             	shl    $0x2,%eax
  8003c5:	01 d0                	add    %edx,%eax
  8003c7:	89 c2                	mov    %eax,%edx
  8003c9:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003cc:	01 d0                	add    %edx,%eax
  8003ce:	c6 00 ff             	movb   $0xff,(%eax)

		z[4*Mega] = 'M' ;
  8003d1:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003d4:	c1 e0 02             	shl    $0x2,%eax
  8003d7:	c6 80 20 31 80 00 4d 	movb   $0x4d,0x803120(%eax)

		x[8*Mega] = -1;
  8003de:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003e1:	c1 e0 03             	shl    $0x3,%eax
  8003e4:	89 c2                	mov    %eax,%edx
  8003e6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003e9:	01 d0                	add    %edx,%eax
  8003eb:	c6 00 ff             	movb   $0xff,(%eax)

		x[12*Mega]=-1;
  8003ee:	8b 55 98             	mov    -0x68(%ebp),%edx
  8003f1:	89 d0                	mov    %edx,%eax
  8003f3:	01 c0                	add    %eax,%eax
  8003f5:	01 d0                	add    %edx,%eax
  8003f7:	c1 e0 02             	shl    $0x2,%eax
  8003fa:	89 c2                	mov    %eax,%edx
  8003fc:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003ff:	01 d0                	add    %edx,%eax
  800401:	c6 00 ff             	movb   $0xff,(%eax)


		free(x);
  800404:	83 ec 0c             	sub    $0xc,%esp
  800407:	ff 75 90             	pushl  -0x70(%ebp)
  80040a:	e8 4c 15 00 00       	call   80195b <free>
  80040f:	83 c4 10             	add    $0x10,%esp
		free(y);
  800412:	83 ec 0c             	sub    $0xc,%esp
  800415:	ff 75 8c             	pushl  -0x74(%ebp)
  800418:	e8 3e 15 00 00       	call   80195b <free>
  80041d:	83 c4 10             	add    $0x10,%esp

		int freePages = sys_calculate_free_frames();
  800420:	e8 0d 18 00 00       	call   801c32 <sys_calculate_free_frames>
  800425:	89 45 84             	mov    %eax,-0x7c(%ebp)

		x = malloc(sizeof(char)*size) ;
  800428:	83 ec 0c             	sub    $0xc,%esp
  80042b:	ff 75 94             	pushl  -0x6c(%ebp)
  80042e:	e8 18 13 00 00       	call   80174b <malloc>
  800433:	83 c4 10             	add    $0x10,%esp
  800436:	89 45 90             	mov    %eax,-0x70(%ebp)

		x[1]=-2;
  800439:	8b 45 90             	mov    -0x70(%ebp),%eax
  80043c:	40                   	inc    %eax
  80043d:	c6 00 fe             	movb   $0xfe,(%eax)

		x[5*Mega]=-2;
  800440:	8b 55 98             	mov    -0x68(%ebp),%edx
  800443:	89 d0                	mov    %edx,%eax
  800445:	c1 e0 02             	shl    $0x2,%eax
  800448:	01 d0                	add    %edx,%eax
  80044a:	89 c2                	mov    %eax,%edx
  80044c:	8b 45 90             	mov    -0x70(%ebp),%eax
  80044f:	01 d0                	add    %edx,%eax
  800451:	c6 00 fe             	movb   $0xfe,(%eax)

		x[8*Mega] = -2;
  800454:	8b 45 98             	mov    -0x68(%ebp),%eax
  800457:	c1 e0 03             	shl    $0x3,%eax
  80045a:	89 c2                	mov    %eax,%edx
  80045c:	8b 45 90             	mov    -0x70(%ebp),%eax
  80045f:	01 d0                	add    %edx,%eax
  800461:	c6 00 fe             	movb   $0xfe,(%eax)

		x[12*Mega]=-2;
  800464:	8b 55 98             	mov    -0x68(%ebp),%edx
  800467:	89 d0                	mov    %edx,%eax
  800469:	01 c0                	add    %eax,%eax
  80046b:	01 d0                	add    %edx,%eax
  80046d:	c1 e0 02             	shl    $0x2,%eax
  800470:	89 c2                	mov    %eax,%edx
  800472:	8b 45 90             	mov    -0x70(%ebp),%eax
  800475:	01 d0                	add    %edx,%eax
  800477:	c6 00 fe             	movb   $0xfe,(%eax)


		uint32 pageWSEntries[11] = {0x800000,0x801000,0x802000,0x803000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0xc03000, 0x205000, 0xeebfd000};
  80047a:	8d 85 50 ff ff ff    	lea    -0xb0(%ebp),%eax
  800480:	bb 00 26 80 00       	mov    $0x802600,%ebx
  800485:	ba 0b 00 00 00       	mov    $0xb,%edx
  80048a:	89 c7                	mov    %eax,%edi
  80048c:	89 de                	mov    %ebx,%esi
  80048e:	89 d1                	mov    %edx,%ecx
  800490:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

		int i = 0, j ;
  800492:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (; i < (myEnv->page_WS_max_size); i++)
  800499:	eb 76                	jmp    800511 <_main+0x4d9>
		{
			int found = 0 ;
  80049b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8004a2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004a9:	eb 3a                	jmp    8004e5 <_main+0x4ad>
			{
				if (pageWSEntries[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE) )
  8004ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8004ae:	8b 94 85 50 ff ff ff 	mov    -0xb0(%ebp,%eax,4),%edx
  8004b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ba:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004c0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  8004c3:	c1 e1 04             	shl    $0x4,%ecx
  8004c6:	01 c8                	add    %ecx,%eax
  8004c8:	8b 00                	mov    (%eax),%eax
  8004ca:	89 45 80             	mov    %eax,-0x80(%ebp)
  8004cd:	8b 45 80             	mov    -0x80(%ebp),%eax
  8004d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d5:	39 c2                	cmp    %eax,%edx
  8004d7:	75 09                	jne    8004e2 <_main+0x4aa>
				{
					found = 1 ;
  8004d9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
					break;
  8004e0:	eb 12                	jmp    8004f4 <_main+0x4bc>

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
		{
			int found = 0 ;
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8004e2:	ff 45 e0             	incl   -0x20(%ebp)
  8004e5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ea:	8b 50 74             	mov    0x74(%eax),%edx
  8004ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004f0:	39 c2                	cmp    %eax,%edx
  8004f2:	77 b7                	ja     8004ab <_main+0x473>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  8004f4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8004f8:	75 14                	jne    80050e <_main+0x4d6>
				panic("PAGE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
  8004fa:	83 ec 04             	sub    $0x4,%esp
  8004fd:	68 98 24 80 00       	push   $0x802498
  800502:	6a 5f                	push   $0x5f
  800504:	68 e9 23 80 00       	push   $0x8023e9
  800509:	e8 11 02 00 00       	call   80071f <_panic>


		uint32 pageWSEntries[11] = {0x800000,0x801000,0x802000,0x803000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0xc03000, 0x205000, 0xeebfd000};

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
  80050e:	ff 45 e4             	incl   -0x1c(%ebp)
  800511:	a1 20 30 80 00       	mov    0x803020,%eax
  800516:	8b 50 74             	mov    0x74(%eax),%edx
  800519:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80051c:	39 c2                	cmp    %eax,%edx
  80051e:	0f 87 77 ff ff ff    	ja     80049b <_main+0x463>
			}
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
		}

		uint32 tableWSEntries[8] = {0x0, 0x80400000, 0x80800000, 0x80c00000, 0x80000000, 0x800000,0xc00000, 0xee800000};
  800524:	8d 85 30 ff ff ff    	lea    -0xd0(%ebp),%eax
  80052a:	bb 40 26 80 00       	mov    $0x802640,%ebx
  80052f:	ba 08 00 00 00       	mov    $0x8,%edx
  800534:	89 c7                	mov    %eax,%edi
  800536:	89 de                	mov    %ebx,%esi
  800538:	89 d1                	mov    %edx,%ecx
  80053a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)


		for (i=0; i < __TWS_MAX_SIZE; i++)
  80053c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800543:	eb 76                	jmp    8005bb <_main+0x583>
		{
			int found = 0 ;
  800545:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for (j=0; j < __TWS_MAX_SIZE; j++)
  80054c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800553:	eb 43                	jmp    800598 <_main+0x560>
			{
				if (tableWSEntries[i] == ROUNDDOWN(myEnv->__ptr_tws[j].virtual_address,1024*PAGE_SIZE) )
  800555:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800558:	8b 94 85 30 ff ff ff 	mov    -0xd0(%ebp,%eax,4),%edx
  80055f:	a1 20 30 80 00       	mov    0x803020,%eax
  800564:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  800567:	81 c1 8f 13 00 00    	add    $0x138f,%ecx
  80056d:	c1 e1 04             	shl    $0x4,%ecx
  800570:	01 c8                	add    %ecx,%eax
  800572:	83 c0 08             	add    $0x8,%eax
  800575:	8b 00                	mov    (%eax),%eax
  800577:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80057d:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800583:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800588:	39 c2                	cmp    %eax,%edx
  80058a:	75 09                	jne    800595 <_main+0x55d>
				{
					found = 1 ;
  80058c:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
					break;
  800593:	eb 09                	jmp    80059e <_main+0x566>


		for (i=0; i < __TWS_MAX_SIZE; i++)
		{
			int found = 0 ;
			for (j=0; j < __TWS_MAX_SIZE; j++)
  800595:	ff 45 e0             	incl   -0x20(%ebp)
  800598:	83 7d e0 31          	cmpl   $0x31,-0x20(%ebp)
  80059c:	7e b7                	jle    800555 <_main+0x51d>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  80059e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  8005a2:	75 14                	jne    8005b8 <_main+0x580>
				panic("TABLE Placement algorithm failed after applying freeHeap.. make sure you SEARCH for the empty location in the WS before setting it");
  8005a4:	83 ec 04             	sub    $0x4,%esp
  8005a7:	68 1c 25 80 00       	push   $0x80251c
  8005ac:	6a 71                	push   $0x71
  8005ae:	68 e9 23 80 00       	push   $0x8023e9
  8005b3:	e8 67 01 00 00       	call   80071f <_panic>
		}

		uint32 tableWSEntries[8] = {0x0, 0x80400000, 0x80800000, 0x80c00000, 0x80000000, 0x800000,0xc00000, 0xee800000};


		for (i=0; i < __TWS_MAX_SIZE; i++)
  8005b8:	ff 45 e4             	incl   -0x1c(%ebp)
  8005bb:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
  8005bf:	7e 84                	jle    800545 <_main+0x50d>


		//if( (freePages - sys_calculate_free_frames() ) != 8 ) panic("Extra/Less memory are wrongly allocated");
	}

	cprintf("Congratulations!! test freeHeap 2 [WITH REPLACEMENT] completed successfully.\n");
  8005c1:	83 ec 0c             	sub    $0xc,%esp
  8005c4:	68 a0 25 80 00       	push   $0x8025a0
  8005c9:	e8 f3 03 00 00       	call   8009c1 <cprintf>
  8005ce:	83 c4 10             	add    $0x10,%esp


	return;
  8005d1:	90                   	nop
}
  8005d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8005d5:	5b                   	pop    %ebx
  8005d6:	5e                   	pop    %esi
  8005d7:	5f                   	pop    %edi
  8005d8:	5d                   	pop    %ebp
  8005d9:	c3                   	ret    

008005da <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005da:	55                   	push   %ebp
  8005db:	89 e5                	mov    %esp,%ebp
  8005dd:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005e0:	e8 82 15 00 00       	call   801b67 <sys_getenvindex>
  8005e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005eb:	89 d0                	mov    %edx,%eax
  8005ed:	c1 e0 03             	shl    $0x3,%eax
  8005f0:	01 d0                	add    %edx,%eax
  8005f2:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005f9:	01 c8                	add    %ecx,%eax
  8005fb:	01 c0                	add    %eax,%eax
  8005fd:	01 d0                	add    %edx,%eax
  8005ff:	01 c0                	add    %eax,%eax
  800601:	01 d0                	add    %edx,%eax
  800603:	89 c2                	mov    %eax,%edx
  800605:	c1 e2 05             	shl    $0x5,%edx
  800608:	29 c2                	sub    %eax,%edx
  80060a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800611:	89 c2                	mov    %eax,%edx
  800613:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800619:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80061e:	a1 20 30 80 00       	mov    0x803020,%eax
  800623:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800629:	84 c0                	test   %al,%al
  80062b:	74 0f                	je     80063c <libmain+0x62>
		binaryname = myEnv->prog_name;
  80062d:	a1 20 30 80 00       	mov    0x803020,%eax
  800632:	05 40 3c 01 00       	add    $0x13c40,%eax
  800637:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80063c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800640:	7e 0a                	jle    80064c <libmain+0x72>
		binaryname = argv[0];
  800642:	8b 45 0c             	mov    0xc(%ebp),%eax
  800645:	8b 00                	mov    (%eax),%eax
  800647:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80064c:	83 ec 08             	sub    $0x8,%esp
  80064f:	ff 75 0c             	pushl  0xc(%ebp)
  800652:	ff 75 08             	pushl  0x8(%ebp)
  800655:	e8 de f9 ff ff       	call   800038 <_main>
  80065a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80065d:	e8 a0 16 00 00       	call   801d02 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800662:	83 ec 0c             	sub    $0xc,%esp
  800665:	68 78 26 80 00       	push   $0x802678
  80066a:	e8 52 03 00 00       	call   8009c1 <cprintf>
  80066f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800672:	a1 20 30 80 00       	mov    0x803020,%eax
  800677:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80067d:	a1 20 30 80 00       	mov    0x803020,%eax
  800682:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800688:	83 ec 04             	sub    $0x4,%esp
  80068b:	52                   	push   %edx
  80068c:	50                   	push   %eax
  80068d:	68 a0 26 80 00       	push   $0x8026a0
  800692:	e8 2a 03 00 00       	call   8009c1 <cprintf>
  800697:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80069a:	a1 20 30 80 00       	mov    0x803020,%eax
  80069f:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006a5:	a1 20 30 80 00       	mov    0x803020,%eax
  8006aa:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006b0:	83 ec 04             	sub    $0x4,%esp
  8006b3:	52                   	push   %edx
  8006b4:	50                   	push   %eax
  8006b5:	68 c8 26 80 00       	push   $0x8026c8
  8006ba:	e8 02 03 00 00       	call   8009c1 <cprintf>
  8006bf:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c7:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006cd:	83 ec 08             	sub    $0x8,%esp
  8006d0:	50                   	push   %eax
  8006d1:	68 09 27 80 00       	push   $0x802709
  8006d6:	e8 e6 02 00 00       	call   8009c1 <cprintf>
  8006db:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006de:	83 ec 0c             	sub    $0xc,%esp
  8006e1:	68 78 26 80 00       	push   $0x802678
  8006e6:	e8 d6 02 00 00       	call   8009c1 <cprintf>
  8006eb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006ee:	e8 29 16 00 00       	call   801d1c <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006f3:	e8 19 00 00 00       	call   800711 <exit>
}
  8006f8:	90                   	nop
  8006f9:	c9                   	leave  
  8006fa:	c3                   	ret    

008006fb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006fb:	55                   	push   %ebp
  8006fc:	89 e5                	mov    %esp,%ebp
  8006fe:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800701:	83 ec 0c             	sub    $0xc,%esp
  800704:	6a 00                	push   $0x0
  800706:	e8 28 14 00 00       	call   801b33 <sys_env_destroy>
  80070b:	83 c4 10             	add    $0x10,%esp
}
  80070e:	90                   	nop
  80070f:	c9                   	leave  
  800710:	c3                   	ret    

00800711 <exit>:

void
exit(void)
{
  800711:	55                   	push   %ebp
  800712:	89 e5                	mov    %esp,%ebp
  800714:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800717:	e8 7d 14 00 00       	call   801b99 <sys_env_exit>
}
  80071c:	90                   	nop
  80071d:	c9                   	leave  
  80071e:	c3                   	ret    

0080071f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80071f:	55                   	push   %ebp
  800720:	89 e5                	mov    %esp,%ebp
  800722:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800725:	8d 45 10             	lea    0x10(%ebp),%eax
  800728:	83 c0 04             	add    $0x4,%eax
  80072b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80072e:	a1 34 31 d0 00       	mov    0xd03134,%eax
  800733:	85 c0                	test   %eax,%eax
  800735:	74 16                	je     80074d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800737:	a1 34 31 d0 00       	mov    0xd03134,%eax
  80073c:	83 ec 08             	sub    $0x8,%esp
  80073f:	50                   	push   %eax
  800740:	68 20 27 80 00       	push   $0x802720
  800745:	e8 77 02 00 00       	call   8009c1 <cprintf>
  80074a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80074d:	a1 00 30 80 00       	mov    0x803000,%eax
  800752:	ff 75 0c             	pushl  0xc(%ebp)
  800755:	ff 75 08             	pushl  0x8(%ebp)
  800758:	50                   	push   %eax
  800759:	68 25 27 80 00       	push   $0x802725
  80075e:	e8 5e 02 00 00       	call   8009c1 <cprintf>
  800763:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800766:	8b 45 10             	mov    0x10(%ebp),%eax
  800769:	83 ec 08             	sub    $0x8,%esp
  80076c:	ff 75 f4             	pushl  -0xc(%ebp)
  80076f:	50                   	push   %eax
  800770:	e8 e1 01 00 00       	call   800956 <vcprintf>
  800775:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800778:	83 ec 08             	sub    $0x8,%esp
  80077b:	6a 00                	push   $0x0
  80077d:	68 41 27 80 00       	push   $0x802741
  800782:	e8 cf 01 00 00       	call   800956 <vcprintf>
  800787:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80078a:	e8 82 ff ff ff       	call   800711 <exit>

	// should not return here
	while (1) ;
  80078f:	eb fe                	jmp    80078f <_panic+0x70>

00800791 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800791:	55                   	push   %ebp
  800792:	89 e5                	mov    %esp,%ebp
  800794:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800797:	a1 20 30 80 00       	mov    0x803020,%eax
  80079c:	8b 50 74             	mov    0x74(%eax),%edx
  80079f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a2:	39 c2                	cmp    %eax,%edx
  8007a4:	74 14                	je     8007ba <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007a6:	83 ec 04             	sub    $0x4,%esp
  8007a9:	68 44 27 80 00       	push   $0x802744
  8007ae:	6a 26                	push   $0x26
  8007b0:	68 90 27 80 00       	push   $0x802790
  8007b5:	e8 65 ff ff ff       	call   80071f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007c8:	e9 b6 00 00 00       	jmp    800883 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8007cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007da:	01 d0                	add    %edx,%eax
  8007dc:	8b 00                	mov    (%eax),%eax
  8007de:	85 c0                	test   %eax,%eax
  8007e0:	75 08                	jne    8007ea <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007e2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007e5:	e9 96 00 00 00       	jmp    800880 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007ea:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007f1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007f8:	eb 5d                	jmp    800857 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ff:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800805:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800808:	c1 e2 04             	shl    $0x4,%edx
  80080b:	01 d0                	add    %edx,%eax
  80080d:	8a 40 04             	mov    0x4(%eax),%al
  800810:	84 c0                	test   %al,%al
  800812:	75 40                	jne    800854 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800814:	a1 20 30 80 00       	mov    0x803020,%eax
  800819:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80081f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800822:	c1 e2 04             	shl    $0x4,%edx
  800825:	01 d0                	add    %edx,%eax
  800827:	8b 00                	mov    (%eax),%eax
  800829:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80082c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80082f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800834:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800836:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800839:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800840:	8b 45 08             	mov    0x8(%ebp),%eax
  800843:	01 c8                	add    %ecx,%eax
  800845:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800847:	39 c2                	cmp    %eax,%edx
  800849:	75 09                	jne    800854 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80084b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800852:	eb 12                	jmp    800866 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800854:	ff 45 e8             	incl   -0x18(%ebp)
  800857:	a1 20 30 80 00       	mov    0x803020,%eax
  80085c:	8b 50 74             	mov    0x74(%eax),%edx
  80085f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800862:	39 c2                	cmp    %eax,%edx
  800864:	77 94                	ja     8007fa <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800866:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80086a:	75 14                	jne    800880 <CheckWSWithoutLastIndex+0xef>
			panic(
  80086c:	83 ec 04             	sub    $0x4,%esp
  80086f:	68 9c 27 80 00       	push   $0x80279c
  800874:	6a 3a                	push   $0x3a
  800876:	68 90 27 80 00       	push   $0x802790
  80087b:	e8 9f fe ff ff       	call   80071f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800880:	ff 45 f0             	incl   -0x10(%ebp)
  800883:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800886:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800889:	0f 8c 3e ff ff ff    	jl     8007cd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80088f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800896:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80089d:	eb 20                	jmp    8008bf <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80089f:	a1 20 30 80 00       	mov    0x803020,%eax
  8008a4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008ad:	c1 e2 04             	shl    $0x4,%edx
  8008b0:	01 d0                	add    %edx,%eax
  8008b2:	8a 40 04             	mov    0x4(%eax),%al
  8008b5:	3c 01                	cmp    $0x1,%al
  8008b7:	75 03                	jne    8008bc <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008b9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008bc:	ff 45 e0             	incl   -0x20(%ebp)
  8008bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8008c4:	8b 50 74             	mov    0x74(%eax),%edx
  8008c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008ca:	39 c2                	cmp    %eax,%edx
  8008cc:	77 d1                	ja     80089f <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008d1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008d4:	74 14                	je     8008ea <CheckWSWithoutLastIndex+0x159>
		panic(
  8008d6:	83 ec 04             	sub    $0x4,%esp
  8008d9:	68 f0 27 80 00       	push   $0x8027f0
  8008de:	6a 44                	push   $0x44
  8008e0:	68 90 27 80 00       	push   $0x802790
  8008e5:	e8 35 fe ff ff       	call   80071f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008ea:	90                   	nop
  8008eb:	c9                   	leave  
  8008ec:	c3                   	ret    

008008ed <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008ed:	55                   	push   %ebp
  8008ee:	89 e5                	mov    %esp,%ebp
  8008f0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f6:	8b 00                	mov    (%eax),%eax
  8008f8:	8d 48 01             	lea    0x1(%eax),%ecx
  8008fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008fe:	89 0a                	mov    %ecx,(%edx)
  800900:	8b 55 08             	mov    0x8(%ebp),%edx
  800903:	88 d1                	mov    %dl,%cl
  800905:	8b 55 0c             	mov    0xc(%ebp),%edx
  800908:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80090c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090f:	8b 00                	mov    (%eax),%eax
  800911:	3d ff 00 00 00       	cmp    $0xff,%eax
  800916:	75 2c                	jne    800944 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800918:	a0 24 30 80 00       	mov    0x803024,%al
  80091d:	0f b6 c0             	movzbl %al,%eax
  800920:	8b 55 0c             	mov    0xc(%ebp),%edx
  800923:	8b 12                	mov    (%edx),%edx
  800925:	89 d1                	mov    %edx,%ecx
  800927:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092a:	83 c2 08             	add    $0x8,%edx
  80092d:	83 ec 04             	sub    $0x4,%esp
  800930:	50                   	push   %eax
  800931:	51                   	push   %ecx
  800932:	52                   	push   %edx
  800933:	e8 b9 11 00 00       	call   801af1 <sys_cputs>
  800938:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80093b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800944:	8b 45 0c             	mov    0xc(%ebp),%eax
  800947:	8b 40 04             	mov    0x4(%eax),%eax
  80094a:	8d 50 01             	lea    0x1(%eax),%edx
  80094d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800950:	89 50 04             	mov    %edx,0x4(%eax)
}
  800953:	90                   	nop
  800954:	c9                   	leave  
  800955:	c3                   	ret    

00800956 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800956:	55                   	push   %ebp
  800957:	89 e5                	mov    %esp,%ebp
  800959:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80095f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800966:	00 00 00 
	b.cnt = 0;
  800969:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800970:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800973:	ff 75 0c             	pushl  0xc(%ebp)
  800976:	ff 75 08             	pushl  0x8(%ebp)
  800979:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80097f:	50                   	push   %eax
  800980:	68 ed 08 80 00       	push   $0x8008ed
  800985:	e8 11 02 00 00       	call   800b9b <vprintfmt>
  80098a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80098d:	a0 24 30 80 00       	mov    0x803024,%al
  800992:	0f b6 c0             	movzbl %al,%eax
  800995:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80099b:	83 ec 04             	sub    $0x4,%esp
  80099e:	50                   	push   %eax
  80099f:	52                   	push   %edx
  8009a0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009a6:	83 c0 08             	add    $0x8,%eax
  8009a9:	50                   	push   %eax
  8009aa:	e8 42 11 00 00       	call   801af1 <sys_cputs>
  8009af:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009b2:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009b9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009bf:	c9                   	leave  
  8009c0:	c3                   	ret    

008009c1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009c1:	55                   	push   %ebp
  8009c2:	89 e5                	mov    %esp,%ebp
  8009c4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009c7:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009ce:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d7:	83 ec 08             	sub    $0x8,%esp
  8009da:	ff 75 f4             	pushl  -0xc(%ebp)
  8009dd:	50                   	push   %eax
  8009de:	e8 73 ff ff ff       	call   800956 <vcprintf>
  8009e3:	83 c4 10             	add    $0x10,%esp
  8009e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009ec:	c9                   	leave  
  8009ed:	c3                   	ret    

008009ee <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009ee:	55                   	push   %ebp
  8009ef:	89 e5                	mov    %esp,%ebp
  8009f1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009f4:	e8 09 13 00 00       	call   801d02 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009f9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800a02:	83 ec 08             	sub    $0x8,%esp
  800a05:	ff 75 f4             	pushl  -0xc(%ebp)
  800a08:	50                   	push   %eax
  800a09:	e8 48 ff ff ff       	call   800956 <vcprintf>
  800a0e:	83 c4 10             	add    $0x10,%esp
  800a11:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a14:	e8 03 13 00 00       	call   801d1c <sys_enable_interrupt>
	return cnt;
  800a19:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a1c:	c9                   	leave  
  800a1d:	c3                   	ret    

00800a1e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a1e:	55                   	push   %ebp
  800a1f:	89 e5                	mov    %esp,%ebp
  800a21:	53                   	push   %ebx
  800a22:	83 ec 14             	sub    $0x14,%esp
  800a25:	8b 45 10             	mov    0x10(%ebp),%eax
  800a28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a31:	8b 45 18             	mov    0x18(%ebp),%eax
  800a34:	ba 00 00 00 00       	mov    $0x0,%edx
  800a39:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a3c:	77 55                	ja     800a93 <printnum+0x75>
  800a3e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a41:	72 05                	jb     800a48 <printnum+0x2a>
  800a43:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a46:	77 4b                	ja     800a93 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a48:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a4b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a4e:	8b 45 18             	mov    0x18(%ebp),%eax
  800a51:	ba 00 00 00 00       	mov    $0x0,%edx
  800a56:	52                   	push   %edx
  800a57:	50                   	push   %eax
  800a58:	ff 75 f4             	pushl  -0xc(%ebp)
  800a5b:	ff 75 f0             	pushl  -0x10(%ebp)
  800a5e:	e8 c1 16 00 00       	call   802124 <__udivdi3>
  800a63:	83 c4 10             	add    $0x10,%esp
  800a66:	83 ec 04             	sub    $0x4,%esp
  800a69:	ff 75 20             	pushl  0x20(%ebp)
  800a6c:	53                   	push   %ebx
  800a6d:	ff 75 18             	pushl  0x18(%ebp)
  800a70:	52                   	push   %edx
  800a71:	50                   	push   %eax
  800a72:	ff 75 0c             	pushl  0xc(%ebp)
  800a75:	ff 75 08             	pushl  0x8(%ebp)
  800a78:	e8 a1 ff ff ff       	call   800a1e <printnum>
  800a7d:	83 c4 20             	add    $0x20,%esp
  800a80:	eb 1a                	jmp    800a9c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a82:	83 ec 08             	sub    $0x8,%esp
  800a85:	ff 75 0c             	pushl  0xc(%ebp)
  800a88:	ff 75 20             	pushl  0x20(%ebp)
  800a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8e:	ff d0                	call   *%eax
  800a90:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a93:	ff 4d 1c             	decl   0x1c(%ebp)
  800a96:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a9a:	7f e6                	jg     800a82 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a9c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a9f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aa7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aaa:	53                   	push   %ebx
  800aab:	51                   	push   %ecx
  800aac:	52                   	push   %edx
  800aad:	50                   	push   %eax
  800aae:	e8 81 17 00 00       	call   802234 <__umoddi3>
  800ab3:	83 c4 10             	add    $0x10,%esp
  800ab6:	05 54 2a 80 00       	add    $0x802a54,%eax
  800abb:	8a 00                	mov    (%eax),%al
  800abd:	0f be c0             	movsbl %al,%eax
  800ac0:	83 ec 08             	sub    $0x8,%esp
  800ac3:	ff 75 0c             	pushl  0xc(%ebp)
  800ac6:	50                   	push   %eax
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	ff d0                	call   *%eax
  800acc:	83 c4 10             	add    $0x10,%esp
}
  800acf:	90                   	nop
  800ad0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ad3:	c9                   	leave  
  800ad4:	c3                   	ret    

00800ad5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ad5:	55                   	push   %ebp
  800ad6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ad8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800adc:	7e 1c                	jle    800afa <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	8b 00                	mov    (%eax),%eax
  800ae3:	8d 50 08             	lea    0x8(%eax),%edx
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	89 10                	mov    %edx,(%eax)
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	8b 00                	mov    (%eax),%eax
  800af0:	83 e8 08             	sub    $0x8,%eax
  800af3:	8b 50 04             	mov    0x4(%eax),%edx
  800af6:	8b 00                	mov    (%eax),%eax
  800af8:	eb 40                	jmp    800b3a <getuint+0x65>
	else if (lflag)
  800afa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800afe:	74 1e                	je     800b1e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	8b 00                	mov    (%eax),%eax
  800b05:	8d 50 04             	lea    0x4(%eax),%edx
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	89 10                	mov    %edx,(%eax)
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	8b 00                	mov    (%eax),%eax
  800b12:	83 e8 04             	sub    $0x4,%eax
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	ba 00 00 00 00       	mov    $0x0,%edx
  800b1c:	eb 1c                	jmp    800b3a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	8b 00                	mov    (%eax),%eax
  800b23:	8d 50 04             	lea    0x4(%eax),%edx
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	89 10                	mov    %edx,(%eax)
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	8b 00                	mov    (%eax),%eax
  800b30:	83 e8 04             	sub    $0x4,%eax
  800b33:	8b 00                	mov    (%eax),%eax
  800b35:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b3a:	5d                   	pop    %ebp
  800b3b:	c3                   	ret    

00800b3c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b3c:	55                   	push   %ebp
  800b3d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b3f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b43:	7e 1c                	jle    800b61 <getint+0x25>
		return va_arg(*ap, long long);
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	8b 00                	mov    (%eax),%eax
  800b4a:	8d 50 08             	lea    0x8(%eax),%edx
  800b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b50:	89 10                	mov    %edx,(%eax)
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	8b 00                	mov    (%eax),%eax
  800b57:	83 e8 08             	sub    $0x8,%eax
  800b5a:	8b 50 04             	mov    0x4(%eax),%edx
  800b5d:	8b 00                	mov    (%eax),%eax
  800b5f:	eb 38                	jmp    800b99 <getint+0x5d>
	else if (lflag)
  800b61:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b65:	74 1a                	je     800b81 <getint+0x45>
		return va_arg(*ap, long);
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	8b 00                	mov    (%eax),%eax
  800b6c:	8d 50 04             	lea    0x4(%eax),%edx
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	89 10                	mov    %edx,(%eax)
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	8b 00                	mov    (%eax),%eax
  800b79:	83 e8 04             	sub    $0x4,%eax
  800b7c:	8b 00                	mov    (%eax),%eax
  800b7e:	99                   	cltd   
  800b7f:	eb 18                	jmp    800b99 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	8b 00                	mov    (%eax),%eax
  800b86:	8d 50 04             	lea    0x4(%eax),%edx
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	89 10                	mov    %edx,(%eax)
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	8b 00                	mov    (%eax),%eax
  800b93:	83 e8 04             	sub    $0x4,%eax
  800b96:	8b 00                	mov    (%eax),%eax
  800b98:	99                   	cltd   
}
  800b99:	5d                   	pop    %ebp
  800b9a:	c3                   	ret    

00800b9b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b9b:	55                   	push   %ebp
  800b9c:	89 e5                	mov    %esp,%ebp
  800b9e:	56                   	push   %esi
  800b9f:	53                   	push   %ebx
  800ba0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ba3:	eb 17                	jmp    800bbc <vprintfmt+0x21>
			if (ch == '\0')
  800ba5:	85 db                	test   %ebx,%ebx
  800ba7:	0f 84 af 03 00 00    	je     800f5c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bad:	83 ec 08             	sub    $0x8,%esp
  800bb0:	ff 75 0c             	pushl  0xc(%ebp)
  800bb3:	53                   	push   %ebx
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	ff d0                	call   *%eax
  800bb9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbf:	8d 50 01             	lea    0x1(%eax),%edx
  800bc2:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc5:	8a 00                	mov    (%eax),%al
  800bc7:	0f b6 d8             	movzbl %al,%ebx
  800bca:	83 fb 25             	cmp    $0x25,%ebx
  800bcd:	75 d6                	jne    800ba5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bcf:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bd3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bda:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800be1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800be8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bef:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf2:	8d 50 01             	lea    0x1(%eax),%edx
  800bf5:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf8:	8a 00                	mov    (%eax),%al
  800bfa:	0f b6 d8             	movzbl %al,%ebx
  800bfd:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c00:	83 f8 55             	cmp    $0x55,%eax
  800c03:	0f 87 2b 03 00 00    	ja     800f34 <vprintfmt+0x399>
  800c09:	8b 04 85 78 2a 80 00 	mov    0x802a78(,%eax,4),%eax
  800c10:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c12:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c16:	eb d7                	jmp    800bef <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c18:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c1c:	eb d1                	jmp    800bef <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c1e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c25:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c28:	89 d0                	mov    %edx,%eax
  800c2a:	c1 e0 02             	shl    $0x2,%eax
  800c2d:	01 d0                	add    %edx,%eax
  800c2f:	01 c0                	add    %eax,%eax
  800c31:	01 d8                	add    %ebx,%eax
  800c33:	83 e8 30             	sub    $0x30,%eax
  800c36:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c39:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3c:	8a 00                	mov    (%eax),%al
  800c3e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c41:	83 fb 2f             	cmp    $0x2f,%ebx
  800c44:	7e 3e                	jle    800c84 <vprintfmt+0xe9>
  800c46:	83 fb 39             	cmp    $0x39,%ebx
  800c49:	7f 39                	jg     800c84 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c4b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c4e:	eb d5                	jmp    800c25 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c50:	8b 45 14             	mov    0x14(%ebp),%eax
  800c53:	83 c0 04             	add    $0x4,%eax
  800c56:	89 45 14             	mov    %eax,0x14(%ebp)
  800c59:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5c:	83 e8 04             	sub    $0x4,%eax
  800c5f:	8b 00                	mov    (%eax),%eax
  800c61:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c64:	eb 1f                	jmp    800c85 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c66:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c6a:	79 83                	jns    800bef <vprintfmt+0x54>
				width = 0;
  800c6c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c73:	e9 77 ff ff ff       	jmp    800bef <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c78:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c7f:	e9 6b ff ff ff       	jmp    800bef <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c84:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c85:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c89:	0f 89 60 ff ff ff    	jns    800bef <vprintfmt+0x54>
				width = precision, precision = -1;
  800c8f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c92:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c95:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c9c:	e9 4e ff ff ff       	jmp    800bef <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ca1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ca4:	e9 46 ff ff ff       	jmp    800bef <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ca9:	8b 45 14             	mov    0x14(%ebp),%eax
  800cac:	83 c0 04             	add    $0x4,%eax
  800caf:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb2:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb5:	83 e8 04             	sub    $0x4,%eax
  800cb8:	8b 00                	mov    (%eax),%eax
  800cba:	83 ec 08             	sub    $0x8,%esp
  800cbd:	ff 75 0c             	pushl  0xc(%ebp)
  800cc0:	50                   	push   %eax
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	ff d0                	call   *%eax
  800cc6:	83 c4 10             	add    $0x10,%esp
			break;
  800cc9:	e9 89 02 00 00       	jmp    800f57 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cce:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd1:	83 c0 04             	add    $0x4,%eax
  800cd4:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cda:	83 e8 04             	sub    $0x4,%eax
  800cdd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cdf:	85 db                	test   %ebx,%ebx
  800ce1:	79 02                	jns    800ce5 <vprintfmt+0x14a>
				err = -err;
  800ce3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ce5:	83 fb 64             	cmp    $0x64,%ebx
  800ce8:	7f 0b                	jg     800cf5 <vprintfmt+0x15a>
  800cea:	8b 34 9d c0 28 80 00 	mov    0x8028c0(,%ebx,4),%esi
  800cf1:	85 f6                	test   %esi,%esi
  800cf3:	75 19                	jne    800d0e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cf5:	53                   	push   %ebx
  800cf6:	68 65 2a 80 00       	push   $0x802a65
  800cfb:	ff 75 0c             	pushl  0xc(%ebp)
  800cfe:	ff 75 08             	pushl  0x8(%ebp)
  800d01:	e8 5e 02 00 00       	call   800f64 <printfmt>
  800d06:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d09:	e9 49 02 00 00       	jmp    800f57 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d0e:	56                   	push   %esi
  800d0f:	68 6e 2a 80 00       	push   $0x802a6e
  800d14:	ff 75 0c             	pushl  0xc(%ebp)
  800d17:	ff 75 08             	pushl  0x8(%ebp)
  800d1a:	e8 45 02 00 00       	call   800f64 <printfmt>
  800d1f:	83 c4 10             	add    $0x10,%esp
			break;
  800d22:	e9 30 02 00 00       	jmp    800f57 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d27:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2a:	83 c0 04             	add    $0x4,%eax
  800d2d:	89 45 14             	mov    %eax,0x14(%ebp)
  800d30:	8b 45 14             	mov    0x14(%ebp),%eax
  800d33:	83 e8 04             	sub    $0x4,%eax
  800d36:	8b 30                	mov    (%eax),%esi
  800d38:	85 f6                	test   %esi,%esi
  800d3a:	75 05                	jne    800d41 <vprintfmt+0x1a6>
				p = "(null)";
  800d3c:	be 71 2a 80 00       	mov    $0x802a71,%esi
			if (width > 0 && padc != '-')
  800d41:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d45:	7e 6d                	jle    800db4 <vprintfmt+0x219>
  800d47:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d4b:	74 67                	je     800db4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d4d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d50:	83 ec 08             	sub    $0x8,%esp
  800d53:	50                   	push   %eax
  800d54:	56                   	push   %esi
  800d55:	e8 0c 03 00 00       	call   801066 <strnlen>
  800d5a:	83 c4 10             	add    $0x10,%esp
  800d5d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d60:	eb 16                	jmp    800d78 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d62:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d66:	83 ec 08             	sub    $0x8,%esp
  800d69:	ff 75 0c             	pushl  0xc(%ebp)
  800d6c:	50                   	push   %eax
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	ff d0                	call   *%eax
  800d72:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d75:	ff 4d e4             	decl   -0x1c(%ebp)
  800d78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d7c:	7f e4                	jg     800d62 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d7e:	eb 34                	jmp    800db4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d80:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d84:	74 1c                	je     800da2 <vprintfmt+0x207>
  800d86:	83 fb 1f             	cmp    $0x1f,%ebx
  800d89:	7e 05                	jle    800d90 <vprintfmt+0x1f5>
  800d8b:	83 fb 7e             	cmp    $0x7e,%ebx
  800d8e:	7e 12                	jle    800da2 <vprintfmt+0x207>
					putch('?', putdat);
  800d90:	83 ec 08             	sub    $0x8,%esp
  800d93:	ff 75 0c             	pushl  0xc(%ebp)
  800d96:	6a 3f                	push   $0x3f
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	ff d0                	call   *%eax
  800d9d:	83 c4 10             	add    $0x10,%esp
  800da0:	eb 0f                	jmp    800db1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800da2:	83 ec 08             	sub    $0x8,%esp
  800da5:	ff 75 0c             	pushl  0xc(%ebp)
  800da8:	53                   	push   %ebx
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	ff d0                	call   *%eax
  800dae:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800db1:	ff 4d e4             	decl   -0x1c(%ebp)
  800db4:	89 f0                	mov    %esi,%eax
  800db6:	8d 70 01             	lea    0x1(%eax),%esi
  800db9:	8a 00                	mov    (%eax),%al
  800dbb:	0f be d8             	movsbl %al,%ebx
  800dbe:	85 db                	test   %ebx,%ebx
  800dc0:	74 24                	je     800de6 <vprintfmt+0x24b>
  800dc2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc6:	78 b8                	js     800d80 <vprintfmt+0x1e5>
  800dc8:	ff 4d e0             	decl   -0x20(%ebp)
  800dcb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dcf:	79 af                	jns    800d80 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd1:	eb 13                	jmp    800de6 <vprintfmt+0x24b>
				putch(' ', putdat);
  800dd3:	83 ec 08             	sub    $0x8,%esp
  800dd6:	ff 75 0c             	pushl  0xc(%ebp)
  800dd9:	6a 20                	push   $0x20
  800ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dde:	ff d0                	call   *%eax
  800de0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800de3:	ff 4d e4             	decl   -0x1c(%ebp)
  800de6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dea:	7f e7                	jg     800dd3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dec:	e9 66 01 00 00       	jmp    800f57 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800df1:	83 ec 08             	sub    $0x8,%esp
  800df4:	ff 75 e8             	pushl  -0x18(%ebp)
  800df7:	8d 45 14             	lea    0x14(%ebp),%eax
  800dfa:	50                   	push   %eax
  800dfb:	e8 3c fd ff ff       	call   800b3c <getint>
  800e00:	83 c4 10             	add    $0x10,%esp
  800e03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e06:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e0f:	85 d2                	test   %edx,%edx
  800e11:	79 23                	jns    800e36 <vprintfmt+0x29b>
				putch('-', putdat);
  800e13:	83 ec 08             	sub    $0x8,%esp
  800e16:	ff 75 0c             	pushl  0xc(%ebp)
  800e19:	6a 2d                	push   $0x2d
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	ff d0                	call   *%eax
  800e20:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e23:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e26:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e29:	f7 d8                	neg    %eax
  800e2b:	83 d2 00             	adc    $0x0,%edx
  800e2e:	f7 da                	neg    %edx
  800e30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e33:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e36:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e3d:	e9 bc 00 00 00       	jmp    800efe <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e42:	83 ec 08             	sub    $0x8,%esp
  800e45:	ff 75 e8             	pushl  -0x18(%ebp)
  800e48:	8d 45 14             	lea    0x14(%ebp),%eax
  800e4b:	50                   	push   %eax
  800e4c:	e8 84 fc ff ff       	call   800ad5 <getuint>
  800e51:	83 c4 10             	add    $0x10,%esp
  800e54:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e57:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e5a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e61:	e9 98 00 00 00       	jmp    800efe <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e66:	83 ec 08             	sub    $0x8,%esp
  800e69:	ff 75 0c             	pushl  0xc(%ebp)
  800e6c:	6a 58                	push   $0x58
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	ff d0                	call   *%eax
  800e73:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e76:	83 ec 08             	sub    $0x8,%esp
  800e79:	ff 75 0c             	pushl  0xc(%ebp)
  800e7c:	6a 58                	push   $0x58
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	ff d0                	call   *%eax
  800e83:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e86:	83 ec 08             	sub    $0x8,%esp
  800e89:	ff 75 0c             	pushl  0xc(%ebp)
  800e8c:	6a 58                	push   $0x58
  800e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e91:	ff d0                	call   *%eax
  800e93:	83 c4 10             	add    $0x10,%esp
			break;
  800e96:	e9 bc 00 00 00       	jmp    800f57 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e9b:	83 ec 08             	sub    $0x8,%esp
  800e9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ea1:	6a 30                	push   $0x30
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	ff d0                	call   *%eax
  800ea8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eab:	83 ec 08             	sub    $0x8,%esp
  800eae:	ff 75 0c             	pushl  0xc(%ebp)
  800eb1:	6a 78                	push   $0x78
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	ff d0                	call   *%eax
  800eb8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ebb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ebe:	83 c0 04             	add    $0x4,%eax
  800ec1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ec4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec7:	83 e8 04             	sub    $0x4,%eax
  800eca:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ecc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ecf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ed6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800edd:	eb 1f                	jmp    800efe <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800edf:	83 ec 08             	sub    $0x8,%esp
  800ee2:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee5:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee8:	50                   	push   %eax
  800ee9:	e8 e7 fb ff ff       	call   800ad5 <getuint>
  800eee:	83 c4 10             	add    $0x10,%esp
  800ef1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ef7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800efe:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f02:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f05:	83 ec 04             	sub    $0x4,%esp
  800f08:	52                   	push   %edx
  800f09:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f0c:	50                   	push   %eax
  800f0d:	ff 75 f4             	pushl  -0xc(%ebp)
  800f10:	ff 75 f0             	pushl  -0x10(%ebp)
  800f13:	ff 75 0c             	pushl  0xc(%ebp)
  800f16:	ff 75 08             	pushl  0x8(%ebp)
  800f19:	e8 00 fb ff ff       	call   800a1e <printnum>
  800f1e:	83 c4 20             	add    $0x20,%esp
			break;
  800f21:	eb 34                	jmp    800f57 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f23:	83 ec 08             	sub    $0x8,%esp
  800f26:	ff 75 0c             	pushl  0xc(%ebp)
  800f29:	53                   	push   %ebx
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	ff d0                	call   *%eax
  800f2f:	83 c4 10             	add    $0x10,%esp
			break;
  800f32:	eb 23                	jmp    800f57 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f34:	83 ec 08             	sub    $0x8,%esp
  800f37:	ff 75 0c             	pushl  0xc(%ebp)
  800f3a:	6a 25                	push   $0x25
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	ff d0                	call   *%eax
  800f41:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f44:	ff 4d 10             	decl   0x10(%ebp)
  800f47:	eb 03                	jmp    800f4c <vprintfmt+0x3b1>
  800f49:	ff 4d 10             	decl   0x10(%ebp)
  800f4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4f:	48                   	dec    %eax
  800f50:	8a 00                	mov    (%eax),%al
  800f52:	3c 25                	cmp    $0x25,%al
  800f54:	75 f3                	jne    800f49 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f56:	90                   	nop
		}
	}
  800f57:	e9 47 fc ff ff       	jmp    800ba3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f5c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f5d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f60:	5b                   	pop    %ebx
  800f61:	5e                   	pop    %esi
  800f62:	5d                   	pop    %ebp
  800f63:	c3                   	ret    

00800f64 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f64:	55                   	push   %ebp
  800f65:	89 e5                	mov    %esp,%ebp
  800f67:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f6a:	8d 45 10             	lea    0x10(%ebp),%eax
  800f6d:	83 c0 04             	add    $0x4,%eax
  800f70:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f73:	8b 45 10             	mov    0x10(%ebp),%eax
  800f76:	ff 75 f4             	pushl  -0xc(%ebp)
  800f79:	50                   	push   %eax
  800f7a:	ff 75 0c             	pushl  0xc(%ebp)
  800f7d:	ff 75 08             	pushl  0x8(%ebp)
  800f80:	e8 16 fc ff ff       	call   800b9b <vprintfmt>
  800f85:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f88:	90                   	nop
  800f89:	c9                   	leave  
  800f8a:	c3                   	ret    

00800f8b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f8b:	55                   	push   %ebp
  800f8c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f91:	8b 40 08             	mov    0x8(%eax),%eax
  800f94:	8d 50 01             	lea    0x1(%eax),%edx
  800f97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa0:	8b 10                	mov    (%eax),%edx
  800fa2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa5:	8b 40 04             	mov    0x4(%eax),%eax
  800fa8:	39 c2                	cmp    %eax,%edx
  800faa:	73 12                	jae    800fbe <sprintputch+0x33>
		*b->buf++ = ch;
  800fac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800faf:	8b 00                	mov    (%eax),%eax
  800fb1:	8d 48 01             	lea    0x1(%eax),%ecx
  800fb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb7:	89 0a                	mov    %ecx,(%edx)
  800fb9:	8b 55 08             	mov    0x8(%ebp),%edx
  800fbc:	88 10                	mov    %dl,(%eax)
}
  800fbe:	90                   	nop
  800fbf:	5d                   	pop    %ebp
  800fc0:	c3                   	ret    

00800fc1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fc1:	55                   	push   %ebp
  800fc2:	89 e5                	mov    %esp,%ebp
  800fc4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd6:	01 d0                	add    %edx,%eax
  800fd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fdb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fe2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fe6:	74 06                	je     800fee <vsnprintf+0x2d>
  800fe8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fec:	7f 07                	jg     800ff5 <vsnprintf+0x34>
		return -E_INVAL;
  800fee:	b8 03 00 00 00       	mov    $0x3,%eax
  800ff3:	eb 20                	jmp    801015 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ff5:	ff 75 14             	pushl  0x14(%ebp)
  800ff8:	ff 75 10             	pushl  0x10(%ebp)
  800ffb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ffe:	50                   	push   %eax
  800fff:	68 8b 0f 80 00       	push   $0x800f8b
  801004:	e8 92 fb ff ff       	call   800b9b <vprintfmt>
  801009:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80100c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80100f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801012:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801015:	c9                   	leave  
  801016:	c3                   	ret    

00801017 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801017:	55                   	push   %ebp
  801018:	89 e5                	mov    %esp,%ebp
  80101a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80101d:	8d 45 10             	lea    0x10(%ebp),%eax
  801020:	83 c0 04             	add    $0x4,%eax
  801023:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801026:	8b 45 10             	mov    0x10(%ebp),%eax
  801029:	ff 75 f4             	pushl  -0xc(%ebp)
  80102c:	50                   	push   %eax
  80102d:	ff 75 0c             	pushl  0xc(%ebp)
  801030:	ff 75 08             	pushl  0x8(%ebp)
  801033:	e8 89 ff ff ff       	call   800fc1 <vsnprintf>
  801038:	83 c4 10             	add    $0x10,%esp
  80103b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80103e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801041:	c9                   	leave  
  801042:	c3                   	ret    

00801043 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801043:	55                   	push   %ebp
  801044:	89 e5                	mov    %esp,%ebp
  801046:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801049:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801050:	eb 06                	jmp    801058 <strlen+0x15>
		n++;
  801052:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801055:	ff 45 08             	incl   0x8(%ebp)
  801058:	8b 45 08             	mov    0x8(%ebp),%eax
  80105b:	8a 00                	mov    (%eax),%al
  80105d:	84 c0                	test   %al,%al
  80105f:	75 f1                	jne    801052 <strlen+0xf>
		n++;
	return n;
  801061:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801064:	c9                   	leave  
  801065:	c3                   	ret    

00801066 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801066:	55                   	push   %ebp
  801067:	89 e5                	mov    %esp,%ebp
  801069:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80106c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801073:	eb 09                	jmp    80107e <strnlen+0x18>
		n++;
  801075:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801078:	ff 45 08             	incl   0x8(%ebp)
  80107b:	ff 4d 0c             	decl   0xc(%ebp)
  80107e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801082:	74 09                	je     80108d <strnlen+0x27>
  801084:	8b 45 08             	mov    0x8(%ebp),%eax
  801087:	8a 00                	mov    (%eax),%al
  801089:	84 c0                	test   %al,%al
  80108b:	75 e8                	jne    801075 <strnlen+0xf>
		n++;
	return n;
  80108d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801090:	c9                   	leave  
  801091:	c3                   	ret    

00801092 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801092:	55                   	push   %ebp
  801093:	89 e5                	mov    %esp,%ebp
  801095:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801098:	8b 45 08             	mov    0x8(%ebp),%eax
  80109b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80109e:	90                   	nop
  80109f:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a2:	8d 50 01             	lea    0x1(%eax),%edx
  8010a5:	89 55 08             	mov    %edx,0x8(%ebp)
  8010a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ab:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010ae:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010b1:	8a 12                	mov    (%edx),%dl
  8010b3:	88 10                	mov    %dl,(%eax)
  8010b5:	8a 00                	mov    (%eax),%al
  8010b7:	84 c0                	test   %al,%al
  8010b9:	75 e4                	jne    80109f <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010be:	c9                   	leave  
  8010bf:	c3                   	ret    

008010c0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
  8010c3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010d3:	eb 1f                	jmp    8010f4 <strncpy+0x34>
		*dst++ = *src;
  8010d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d8:	8d 50 01             	lea    0x1(%eax),%edx
  8010db:	89 55 08             	mov    %edx,0x8(%ebp)
  8010de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e1:	8a 12                	mov    (%edx),%dl
  8010e3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e8:	8a 00                	mov    (%eax),%al
  8010ea:	84 c0                	test   %al,%al
  8010ec:	74 03                	je     8010f1 <strncpy+0x31>
			src++;
  8010ee:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010f1:	ff 45 fc             	incl   -0x4(%ebp)
  8010f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010fa:	72 d9                	jb     8010d5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010ff:	c9                   	leave  
  801100:	c3                   	ret    

00801101 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801101:	55                   	push   %ebp
  801102:	89 e5                	mov    %esp,%ebp
  801104:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
  80110a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80110d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801111:	74 30                	je     801143 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801113:	eb 16                	jmp    80112b <strlcpy+0x2a>
			*dst++ = *src++;
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	8d 50 01             	lea    0x1(%eax),%edx
  80111b:	89 55 08             	mov    %edx,0x8(%ebp)
  80111e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801121:	8d 4a 01             	lea    0x1(%edx),%ecx
  801124:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801127:	8a 12                	mov    (%edx),%dl
  801129:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80112b:	ff 4d 10             	decl   0x10(%ebp)
  80112e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801132:	74 09                	je     80113d <strlcpy+0x3c>
  801134:	8b 45 0c             	mov    0xc(%ebp),%eax
  801137:	8a 00                	mov    (%eax),%al
  801139:	84 c0                	test   %al,%al
  80113b:	75 d8                	jne    801115 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801143:	8b 55 08             	mov    0x8(%ebp),%edx
  801146:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801149:	29 c2                	sub    %eax,%edx
  80114b:	89 d0                	mov    %edx,%eax
}
  80114d:	c9                   	leave  
  80114e:	c3                   	ret    

0080114f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80114f:	55                   	push   %ebp
  801150:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801152:	eb 06                	jmp    80115a <strcmp+0xb>
		p++, q++;
  801154:	ff 45 08             	incl   0x8(%ebp)
  801157:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	8a 00                	mov    (%eax),%al
  80115f:	84 c0                	test   %al,%al
  801161:	74 0e                	je     801171 <strcmp+0x22>
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
  801166:	8a 10                	mov    (%eax),%dl
  801168:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116b:	8a 00                	mov    (%eax),%al
  80116d:	38 c2                	cmp    %al,%dl
  80116f:	74 e3                	je     801154 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	8a 00                	mov    (%eax),%al
  801176:	0f b6 d0             	movzbl %al,%edx
  801179:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117c:	8a 00                	mov    (%eax),%al
  80117e:	0f b6 c0             	movzbl %al,%eax
  801181:	29 c2                	sub    %eax,%edx
  801183:	89 d0                	mov    %edx,%eax
}
  801185:	5d                   	pop    %ebp
  801186:	c3                   	ret    

00801187 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801187:	55                   	push   %ebp
  801188:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80118a:	eb 09                	jmp    801195 <strncmp+0xe>
		n--, p++, q++;
  80118c:	ff 4d 10             	decl   0x10(%ebp)
  80118f:	ff 45 08             	incl   0x8(%ebp)
  801192:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801195:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801199:	74 17                	je     8011b2 <strncmp+0x2b>
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	8a 00                	mov    (%eax),%al
  8011a0:	84 c0                	test   %al,%al
  8011a2:	74 0e                	je     8011b2 <strncmp+0x2b>
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	8a 10                	mov    (%eax),%dl
  8011a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ac:	8a 00                	mov    (%eax),%al
  8011ae:	38 c2                	cmp    %al,%dl
  8011b0:	74 da                	je     80118c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b6:	75 07                	jne    8011bf <strncmp+0x38>
		return 0;
  8011b8:	b8 00 00 00 00       	mov    $0x0,%eax
  8011bd:	eb 14                	jmp    8011d3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	0f b6 d0             	movzbl %al,%edx
  8011c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	0f b6 c0             	movzbl %al,%eax
  8011cf:	29 c2                	sub    %eax,%edx
  8011d1:	89 d0                	mov    %edx,%eax
}
  8011d3:	5d                   	pop    %ebp
  8011d4:	c3                   	ret    

008011d5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011d5:	55                   	push   %ebp
  8011d6:	89 e5                	mov    %esp,%ebp
  8011d8:	83 ec 04             	sub    $0x4,%esp
  8011db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011de:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011e1:	eb 12                	jmp    8011f5 <strchr+0x20>
		if (*s == c)
  8011e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e6:	8a 00                	mov    (%eax),%al
  8011e8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011eb:	75 05                	jne    8011f2 <strchr+0x1d>
			return (char *) s;
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	eb 11                	jmp    801203 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011f2:	ff 45 08             	incl   0x8(%ebp)
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	84 c0                	test   %al,%al
  8011fc:	75 e5                	jne    8011e3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801203:	c9                   	leave  
  801204:	c3                   	ret    

00801205 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801205:	55                   	push   %ebp
  801206:	89 e5                	mov    %esp,%ebp
  801208:	83 ec 04             	sub    $0x4,%esp
  80120b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801211:	eb 0d                	jmp    801220 <strfind+0x1b>
		if (*s == c)
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
  801216:	8a 00                	mov    (%eax),%al
  801218:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80121b:	74 0e                	je     80122b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80121d:	ff 45 08             	incl   0x8(%ebp)
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	8a 00                	mov    (%eax),%al
  801225:	84 c0                	test   %al,%al
  801227:	75 ea                	jne    801213 <strfind+0xe>
  801229:	eb 01                	jmp    80122c <strfind+0x27>
		if (*s == c)
			break;
  80122b:	90                   	nop
	return (char *) s;
  80122c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80122f:	c9                   	leave  
  801230:	c3                   	ret    

00801231 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801231:	55                   	push   %ebp
  801232:	89 e5                	mov    %esp,%ebp
  801234:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80123d:	8b 45 10             	mov    0x10(%ebp),%eax
  801240:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801243:	eb 0e                	jmp    801253 <memset+0x22>
		*p++ = c;
  801245:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801248:	8d 50 01             	lea    0x1(%eax),%edx
  80124b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80124e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801251:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801253:	ff 4d f8             	decl   -0x8(%ebp)
  801256:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80125a:	79 e9                	jns    801245 <memset+0x14>
		*p++ = c;

	return v;
  80125c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80125f:	c9                   	leave  
  801260:	c3                   	ret    

00801261 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801261:	55                   	push   %ebp
  801262:	89 e5                	mov    %esp,%ebp
  801264:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801267:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801273:	eb 16                	jmp    80128b <memcpy+0x2a>
		*d++ = *s++;
  801275:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801278:	8d 50 01             	lea    0x1(%eax),%edx
  80127b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80127e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801281:	8d 4a 01             	lea    0x1(%edx),%ecx
  801284:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801287:	8a 12                	mov    (%edx),%dl
  801289:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80128b:	8b 45 10             	mov    0x10(%ebp),%eax
  80128e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801291:	89 55 10             	mov    %edx,0x10(%ebp)
  801294:	85 c0                	test   %eax,%eax
  801296:	75 dd                	jne    801275 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801298:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80129b:	c9                   	leave  
  80129c:	c3                   	ret    

0080129d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80129d:	55                   	push   %ebp
  80129e:	89 e5                	mov    %esp,%ebp
  8012a0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8012a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012b5:	73 50                	jae    801307 <memmove+0x6a>
  8012b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bd:	01 d0                	add    %edx,%eax
  8012bf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012c2:	76 43                	jbe    801307 <memmove+0x6a>
		s += n;
  8012c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012d0:	eb 10                	jmp    8012e2 <memmove+0x45>
			*--d = *--s;
  8012d2:	ff 4d f8             	decl   -0x8(%ebp)
  8012d5:	ff 4d fc             	decl   -0x4(%ebp)
  8012d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012db:	8a 10                	mov    (%eax),%dl
  8012dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e8:	89 55 10             	mov    %edx,0x10(%ebp)
  8012eb:	85 c0                	test   %eax,%eax
  8012ed:	75 e3                	jne    8012d2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012ef:	eb 23                	jmp    801314 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f4:	8d 50 01             	lea    0x1(%eax),%edx
  8012f7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012fd:	8d 4a 01             	lea    0x1(%edx),%ecx
  801300:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801303:	8a 12                	mov    (%edx),%dl
  801305:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801307:	8b 45 10             	mov    0x10(%ebp),%eax
  80130a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80130d:	89 55 10             	mov    %edx,0x10(%ebp)
  801310:	85 c0                	test   %eax,%eax
  801312:	75 dd                	jne    8012f1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801314:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801317:	c9                   	leave  
  801318:	c3                   	ret    

00801319 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801319:	55                   	push   %ebp
  80131a:	89 e5                	mov    %esp,%ebp
  80131c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80131f:	8b 45 08             	mov    0x8(%ebp),%eax
  801322:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801325:	8b 45 0c             	mov    0xc(%ebp),%eax
  801328:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80132b:	eb 2a                	jmp    801357 <memcmp+0x3e>
		if (*s1 != *s2)
  80132d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801330:	8a 10                	mov    (%eax),%dl
  801332:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801335:	8a 00                	mov    (%eax),%al
  801337:	38 c2                	cmp    %al,%dl
  801339:	74 16                	je     801351 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80133b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80133e:	8a 00                	mov    (%eax),%al
  801340:	0f b6 d0             	movzbl %al,%edx
  801343:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801346:	8a 00                	mov    (%eax),%al
  801348:	0f b6 c0             	movzbl %al,%eax
  80134b:	29 c2                	sub    %eax,%edx
  80134d:	89 d0                	mov    %edx,%eax
  80134f:	eb 18                	jmp    801369 <memcmp+0x50>
		s1++, s2++;
  801351:	ff 45 fc             	incl   -0x4(%ebp)
  801354:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801357:	8b 45 10             	mov    0x10(%ebp),%eax
  80135a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80135d:	89 55 10             	mov    %edx,0x10(%ebp)
  801360:	85 c0                	test   %eax,%eax
  801362:	75 c9                	jne    80132d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801364:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
  80136e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801371:	8b 55 08             	mov    0x8(%ebp),%edx
  801374:	8b 45 10             	mov    0x10(%ebp),%eax
  801377:	01 d0                	add    %edx,%eax
  801379:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80137c:	eb 15                	jmp    801393 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	0f b6 d0             	movzbl %al,%edx
  801386:	8b 45 0c             	mov    0xc(%ebp),%eax
  801389:	0f b6 c0             	movzbl %al,%eax
  80138c:	39 c2                	cmp    %eax,%edx
  80138e:	74 0d                	je     80139d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801390:	ff 45 08             	incl   0x8(%ebp)
  801393:	8b 45 08             	mov    0x8(%ebp),%eax
  801396:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801399:	72 e3                	jb     80137e <memfind+0x13>
  80139b:	eb 01                	jmp    80139e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80139d:	90                   	nop
	return (void *) s;
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013a1:	c9                   	leave  
  8013a2:	c3                   	ret    

008013a3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8013a3:	55                   	push   %ebp
  8013a4:	89 e5                	mov    %esp,%ebp
  8013a6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013b0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013b7:	eb 03                	jmp    8013bc <strtol+0x19>
		s++;
  8013b9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bf:	8a 00                	mov    (%eax),%al
  8013c1:	3c 20                	cmp    $0x20,%al
  8013c3:	74 f4                	je     8013b9 <strtol+0x16>
  8013c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c8:	8a 00                	mov    (%eax),%al
  8013ca:	3c 09                	cmp    $0x9,%al
  8013cc:	74 eb                	je     8013b9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	8a 00                	mov    (%eax),%al
  8013d3:	3c 2b                	cmp    $0x2b,%al
  8013d5:	75 05                	jne    8013dc <strtol+0x39>
		s++;
  8013d7:	ff 45 08             	incl   0x8(%ebp)
  8013da:	eb 13                	jmp    8013ef <strtol+0x4c>
	else if (*s == '-')
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	8a 00                	mov    (%eax),%al
  8013e1:	3c 2d                	cmp    $0x2d,%al
  8013e3:	75 0a                	jne    8013ef <strtol+0x4c>
		s++, neg = 1;
  8013e5:	ff 45 08             	incl   0x8(%ebp)
  8013e8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013ef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f3:	74 06                	je     8013fb <strtol+0x58>
  8013f5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013f9:	75 20                	jne    80141b <strtol+0x78>
  8013fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fe:	8a 00                	mov    (%eax),%al
  801400:	3c 30                	cmp    $0x30,%al
  801402:	75 17                	jne    80141b <strtol+0x78>
  801404:	8b 45 08             	mov    0x8(%ebp),%eax
  801407:	40                   	inc    %eax
  801408:	8a 00                	mov    (%eax),%al
  80140a:	3c 78                	cmp    $0x78,%al
  80140c:	75 0d                	jne    80141b <strtol+0x78>
		s += 2, base = 16;
  80140e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801412:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801419:	eb 28                	jmp    801443 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80141b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80141f:	75 15                	jne    801436 <strtol+0x93>
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	3c 30                	cmp    $0x30,%al
  801428:	75 0c                	jne    801436 <strtol+0x93>
		s++, base = 8;
  80142a:	ff 45 08             	incl   0x8(%ebp)
  80142d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801434:	eb 0d                	jmp    801443 <strtol+0xa0>
	else if (base == 0)
  801436:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80143a:	75 07                	jne    801443 <strtol+0xa0>
		base = 10;
  80143c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	3c 2f                	cmp    $0x2f,%al
  80144a:	7e 19                	jle    801465 <strtol+0xc2>
  80144c:	8b 45 08             	mov    0x8(%ebp),%eax
  80144f:	8a 00                	mov    (%eax),%al
  801451:	3c 39                	cmp    $0x39,%al
  801453:	7f 10                	jg     801465 <strtol+0xc2>
			dig = *s - '0';
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	8a 00                	mov    (%eax),%al
  80145a:	0f be c0             	movsbl %al,%eax
  80145d:	83 e8 30             	sub    $0x30,%eax
  801460:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801463:	eb 42                	jmp    8014a7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801465:	8b 45 08             	mov    0x8(%ebp),%eax
  801468:	8a 00                	mov    (%eax),%al
  80146a:	3c 60                	cmp    $0x60,%al
  80146c:	7e 19                	jle    801487 <strtol+0xe4>
  80146e:	8b 45 08             	mov    0x8(%ebp),%eax
  801471:	8a 00                	mov    (%eax),%al
  801473:	3c 7a                	cmp    $0x7a,%al
  801475:	7f 10                	jg     801487 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801477:	8b 45 08             	mov    0x8(%ebp),%eax
  80147a:	8a 00                	mov    (%eax),%al
  80147c:	0f be c0             	movsbl %al,%eax
  80147f:	83 e8 57             	sub    $0x57,%eax
  801482:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801485:	eb 20                	jmp    8014a7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
  80148a:	8a 00                	mov    (%eax),%al
  80148c:	3c 40                	cmp    $0x40,%al
  80148e:	7e 39                	jle    8014c9 <strtol+0x126>
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	8a 00                	mov    (%eax),%al
  801495:	3c 5a                	cmp    $0x5a,%al
  801497:	7f 30                	jg     8014c9 <strtol+0x126>
			dig = *s - 'A' + 10;
  801499:	8b 45 08             	mov    0x8(%ebp),%eax
  80149c:	8a 00                	mov    (%eax),%al
  80149e:	0f be c0             	movsbl %al,%eax
  8014a1:	83 e8 37             	sub    $0x37,%eax
  8014a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014aa:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014ad:	7d 19                	jge    8014c8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014af:	ff 45 08             	incl   0x8(%ebp)
  8014b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b5:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014b9:	89 c2                	mov    %eax,%edx
  8014bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014be:	01 d0                	add    %edx,%eax
  8014c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014c3:	e9 7b ff ff ff       	jmp    801443 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014c8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014cd:	74 08                	je     8014d7 <strtol+0x134>
		*endptr = (char *) s;
  8014cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8014d5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014d7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014db:	74 07                	je     8014e4 <strtol+0x141>
  8014dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e0:	f7 d8                	neg    %eax
  8014e2:	eb 03                	jmp    8014e7 <strtol+0x144>
  8014e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <ltostr>:

void
ltostr(long value, char *str)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
  8014ec:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014f6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801501:	79 13                	jns    801516 <ltostr+0x2d>
	{
		neg = 1;
  801503:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80150a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801510:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801513:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
  801519:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80151e:	99                   	cltd   
  80151f:	f7 f9                	idiv   %ecx
  801521:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801524:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801527:	8d 50 01             	lea    0x1(%eax),%edx
  80152a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80152d:	89 c2                	mov    %eax,%edx
  80152f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801532:	01 d0                	add    %edx,%eax
  801534:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801537:	83 c2 30             	add    $0x30,%edx
  80153a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80153c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80153f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801544:	f7 e9                	imul   %ecx
  801546:	c1 fa 02             	sar    $0x2,%edx
  801549:	89 c8                	mov    %ecx,%eax
  80154b:	c1 f8 1f             	sar    $0x1f,%eax
  80154e:	29 c2                	sub    %eax,%edx
  801550:	89 d0                	mov    %edx,%eax
  801552:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801555:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801558:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80155d:	f7 e9                	imul   %ecx
  80155f:	c1 fa 02             	sar    $0x2,%edx
  801562:	89 c8                	mov    %ecx,%eax
  801564:	c1 f8 1f             	sar    $0x1f,%eax
  801567:	29 c2                	sub    %eax,%edx
  801569:	89 d0                	mov    %edx,%eax
  80156b:	c1 e0 02             	shl    $0x2,%eax
  80156e:	01 d0                	add    %edx,%eax
  801570:	01 c0                	add    %eax,%eax
  801572:	29 c1                	sub    %eax,%ecx
  801574:	89 ca                	mov    %ecx,%edx
  801576:	85 d2                	test   %edx,%edx
  801578:	75 9c                	jne    801516 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80157a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801581:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801584:	48                   	dec    %eax
  801585:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801588:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80158c:	74 3d                	je     8015cb <ltostr+0xe2>
		start = 1 ;
  80158e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801595:	eb 34                	jmp    8015cb <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801597:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80159a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159d:	01 d0                	add    %edx,%eax
  80159f:	8a 00                	mov    (%eax),%al
  8015a1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8015a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015aa:	01 c2                	add    %eax,%edx
  8015ac:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b2:	01 c8                	add    %ecx,%eax
  8015b4:	8a 00                	mov    (%eax),%al
  8015b6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015b8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015be:	01 c2                	add    %eax,%edx
  8015c0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015c3:	88 02                	mov    %al,(%edx)
		start++ ;
  8015c5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015c8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015d1:	7c c4                	jl     801597 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015d3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d9:	01 d0                	add    %edx,%eax
  8015db:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015de:	90                   	nop
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
  8015e4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015e7:	ff 75 08             	pushl  0x8(%ebp)
  8015ea:	e8 54 fa ff ff       	call   801043 <strlen>
  8015ef:	83 c4 04             	add    $0x4,%esp
  8015f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015f5:	ff 75 0c             	pushl  0xc(%ebp)
  8015f8:	e8 46 fa ff ff       	call   801043 <strlen>
  8015fd:	83 c4 04             	add    $0x4,%esp
  801600:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801603:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80160a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801611:	eb 17                	jmp    80162a <strcconcat+0x49>
		final[s] = str1[s] ;
  801613:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801616:	8b 45 10             	mov    0x10(%ebp),%eax
  801619:	01 c2                	add    %eax,%edx
  80161b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80161e:	8b 45 08             	mov    0x8(%ebp),%eax
  801621:	01 c8                	add    %ecx,%eax
  801623:	8a 00                	mov    (%eax),%al
  801625:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801627:	ff 45 fc             	incl   -0x4(%ebp)
  80162a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80162d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801630:	7c e1                	jl     801613 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801632:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801639:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801640:	eb 1f                	jmp    801661 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801642:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801645:	8d 50 01             	lea    0x1(%eax),%edx
  801648:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80164b:	89 c2                	mov    %eax,%edx
  80164d:	8b 45 10             	mov    0x10(%ebp),%eax
  801650:	01 c2                	add    %eax,%edx
  801652:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801655:	8b 45 0c             	mov    0xc(%ebp),%eax
  801658:	01 c8                	add    %ecx,%eax
  80165a:	8a 00                	mov    (%eax),%al
  80165c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80165e:	ff 45 f8             	incl   -0x8(%ebp)
  801661:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801664:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801667:	7c d9                	jl     801642 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801669:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80166c:	8b 45 10             	mov    0x10(%ebp),%eax
  80166f:	01 d0                	add    %edx,%eax
  801671:	c6 00 00             	movb   $0x0,(%eax)
}
  801674:	90                   	nop
  801675:	c9                   	leave  
  801676:	c3                   	ret    

00801677 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801677:	55                   	push   %ebp
  801678:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80167a:	8b 45 14             	mov    0x14(%ebp),%eax
  80167d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801683:	8b 45 14             	mov    0x14(%ebp),%eax
  801686:	8b 00                	mov    (%eax),%eax
  801688:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80168f:	8b 45 10             	mov    0x10(%ebp),%eax
  801692:	01 d0                	add    %edx,%eax
  801694:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80169a:	eb 0c                	jmp    8016a8 <strsplit+0x31>
			*string++ = 0;
  80169c:	8b 45 08             	mov    0x8(%ebp),%eax
  80169f:	8d 50 01             	lea    0x1(%eax),%edx
  8016a2:	89 55 08             	mov    %edx,0x8(%ebp)
  8016a5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	8a 00                	mov    (%eax),%al
  8016ad:	84 c0                	test   %al,%al
  8016af:	74 18                	je     8016c9 <strsplit+0x52>
  8016b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b4:	8a 00                	mov    (%eax),%al
  8016b6:	0f be c0             	movsbl %al,%eax
  8016b9:	50                   	push   %eax
  8016ba:	ff 75 0c             	pushl  0xc(%ebp)
  8016bd:	e8 13 fb ff ff       	call   8011d5 <strchr>
  8016c2:	83 c4 08             	add    $0x8,%esp
  8016c5:	85 c0                	test   %eax,%eax
  8016c7:	75 d3                	jne    80169c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cc:	8a 00                	mov    (%eax),%al
  8016ce:	84 c0                	test   %al,%al
  8016d0:	74 5a                	je     80172c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d5:	8b 00                	mov    (%eax),%eax
  8016d7:	83 f8 0f             	cmp    $0xf,%eax
  8016da:	75 07                	jne    8016e3 <strsplit+0x6c>
		{
			return 0;
  8016dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8016e1:	eb 66                	jmp    801749 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e6:	8b 00                	mov    (%eax),%eax
  8016e8:	8d 48 01             	lea    0x1(%eax),%ecx
  8016eb:	8b 55 14             	mov    0x14(%ebp),%edx
  8016ee:	89 0a                	mov    %ecx,(%edx)
  8016f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8016fa:	01 c2                	add    %eax,%edx
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801701:	eb 03                	jmp    801706 <strsplit+0x8f>
			string++;
  801703:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801706:	8b 45 08             	mov    0x8(%ebp),%eax
  801709:	8a 00                	mov    (%eax),%al
  80170b:	84 c0                	test   %al,%al
  80170d:	74 8b                	je     80169a <strsplit+0x23>
  80170f:	8b 45 08             	mov    0x8(%ebp),%eax
  801712:	8a 00                	mov    (%eax),%al
  801714:	0f be c0             	movsbl %al,%eax
  801717:	50                   	push   %eax
  801718:	ff 75 0c             	pushl  0xc(%ebp)
  80171b:	e8 b5 fa ff ff       	call   8011d5 <strchr>
  801720:	83 c4 08             	add    $0x8,%esp
  801723:	85 c0                	test   %eax,%eax
  801725:	74 dc                	je     801703 <strsplit+0x8c>
			string++;
	}
  801727:	e9 6e ff ff ff       	jmp    80169a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80172c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80172d:	8b 45 14             	mov    0x14(%ebp),%eax
  801730:	8b 00                	mov    (%eax),%eax
  801732:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801739:	8b 45 10             	mov    0x10(%ebp),%eax
  80173c:	01 d0                	add    %edx,%eax
  80173e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801744:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801749:	c9                   	leave  
  80174a:	c3                   	ret    

0080174b <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  80174b:	55                   	push   %ebp
  80174c:	89 e5                	mov    %esp,%ebp
  80174e:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801751:	8b 45 08             	mov    0x8(%ebp),%eax
  801754:	c1 e8 0c             	shr    $0xc,%eax
  801757:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  80175a:	8b 45 08             	mov    0x8(%ebp),%eax
  80175d:	25 ff 0f 00 00       	and    $0xfff,%eax
  801762:	85 c0                	test   %eax,%eax
  801764:	74 03                	je     801769 <malloc+0x1e>
			num++;
  801766:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801769:	a1 04 30 80 00       	mov    0x803004,%eax
  80176e:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801773:	75 73                	jne    8017e8 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801775:	83 ec 08             	sub    $0x8,%esp
  801778:	ff 75 08             	pushl  0x8(%ebp)
  80177b:	68 00 00 00 80       	push   $0x80000000
  801780:	e8 14 05 00 00       	call   801c99 <sys_allocateMem>
  801785:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801788:	a1 04 30 80 00       	mov    0x803004,%eax
  80178d:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801790:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801793:	c1 e0 0c             	shl    $0xc,%eax
  801796:	89 c2                	mov    %eax,%edx
  801798:	a1 04 30 80 00       	mov    0x803004,%eax
  80179d:	01 d0                	add    %edx,%eax
  80179f:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  8017a4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017ac:	89 14 85 40 66 dc 00 	mov    %edx,0xdc6640(,%eax,4)
			addresses[sizeofarray]=last_addres;
  8017b3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017b8:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8017be:	89 14 85 40 31 d0 00 	mov    %edx,0xd03140(,%eax,4)
			changed[sizeofarray]=1;
  8017c5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017ca:	c7 04 85 c0 4b d6 00 	movl   $0x1,0xd64bc0(,%eax,4)
  8017d1:	01 00 00 00 
			sizeofarray++;
  8017d5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017da:	40                   	inc    %eax
  8017db:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  8017e0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8017e3:	e9 71 01 00 00       	jmp    801959 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8017e8:	a1 28 30 80 00       	mov    0x803028,%eax
  8017ed:	85 c0                	test   %eax,%eax
  8017ef:	75 71                	jne    801862 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  8017f1:	a1 04 30 80 00       	mov    0x803004,%eax
  8017f6:	83 ec 08             	sub    $0x8,%esp
  8017f9:	ff 75 08             	pushl  0x8(%ebp)
  8017fc:	50                   	push   %eax
  8017fd:	e8 97 04 00 00       	call   801c99 <sys_allocateMem>
  801802:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801805:	a1 04 30 80 00       	mov    0x803004,%eax
  80180a:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  80180d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801810:	c1 e0 0c             	shl    $0xc,%eax
  801813:	89 c2                	mov    %eax,%edx
  801815:	a1 04 30 80 00       	mov    0x803004,%eax
  80181a:	01 d0                	add    %edx,%eax
  80181c:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801821:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801826:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801829:	89 14 85 40 66 dc 00 	mov    %edx,0xdc6640(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801830:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801835:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801838:	89 14 85 40 31 d0 00 	mov    %edx,0xd03140(,%eax,4)
				changed[sizeofarray]=1;
  80183f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801844:	c7 04 85 c0 4b d6 00 	movl   $0x1,0xd64bc0(,%eax,4)
  80184b:	01 00 00 00 
				sizeofarray++;
  80184f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801854:	40                   	inc    %eax
  801855:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  80185a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80185d:	e9 f7 00 00 00       	jmp    801959 <malloc+0x20e>
			}
			else{
				int count=0;
  801862:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801869:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801870:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801877:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  80187e:	eb 7c                	jmp    8018fc <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801880:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801887:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  80188e:	eb 1a                	jmp    8018aa <malloc+0x15f>
					{
						if(addresses[j]==i)
  801890:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801893:	8b 04 85 40 31 d0 00 	mov    0xd03140(,%eax,4),%eax
  80189a:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80189d:	75 08                	jne    8018a7 <malloc+0x15c>
						{
							index=j;
  80189f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8018a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8018a5:	eb 0d                	jmp    8018b4 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  8018a7:	ff 45 dc             	incl   -0x24(%ebp)
  8018aa:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018af:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8018b2:	7c dc                	jl     801890 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  8018b4:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8018b8:	75 05                	jne    8018bf <malloc+0x174>
					{
						count++;
  8018ba:	ff 45 f0             	incl   -0x10(%ebp)
  8018bd:	eb 36                	jmp    8018f5 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  8018bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018c2:	8b 04 85 c0 4b d6 00 	mov    0xd64bc0(,%eax,4),%eax
  8018c9:	85 c0                	test   %eax,%eax
  8018cb:	75 05                	jne    8018d2 <malloc+0x187>
						{
							count++;
  8018cd:	ff 45 f0             	incl   -0x10(%ebp)
  8018d0:	eb 23                	jmp    8018f5 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  8018d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018d5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8018d8:	7d 14                	jge    8018ee <malloc+0x1a3>
  8018da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018dd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018e0:	7c 0c                	jl     8018ee <malloc+0x1a3>
							{
								min=count;
  8018e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8018e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8018ee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8018f5:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8018fc:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801903:	0f 86 77 ff ff ff    	jbe    801880 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801909:	83 ec 08             	sub    $0x8,%esp
  80190c:	ff 75 08             	pushl  0x8(%ebp)
  80190f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801912:	e8 82 03 00 00       	call   801c99 <sys_allocateMem>
  801917:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  80191a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80191f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801922:	89 14 85 40 66 dc 00 	mov    %edx,0xdc6640(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801929:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80192e:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801934:	89 14 85 40 31 d0 00 	mov    %edx,0xd03140(,%eax,4)
				changed[sizeofarray]=1;
  80193b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801940:	c7 04 85 c0 4b d6 00 	movl   $0x1,0xd64bc0(,%eax,4)
  801947:	01 00 00 00 
				sizeofarray++;
  80194b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801950:	40                   	inc    %eax
  801951:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  801956:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801959:	c9                   	leave  
  80195a:	c3                   	ret    

0080195b <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80195b:	55                   	push   %ebp
  80195c:	89 e5                	mov    %esp,%ebp
  80195e:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  801961:	8b 45 08             	mov    0x8(%ebp),%eax
  801964:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  801967:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  80196e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801975:	eb 30                	jmp    8019a7 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  801977:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80197a:	8b 04 85 40 31 d0 00 	mov    0xd03140(,%eax,4),%eax
  801981:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801984:	75 1e                	jne    8019a4 <free+0x49>
  801986:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801989:	8b 04 85 c0 4b d6 00 	mov    0xd64bc0(,%eax,4),%eax
  801990:	83 f8 01             	cmp    $0x1,%eax
  801993:	75 0f                	jne    8019a4 <free+0x49>
    		is_found=1;
  801995:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  80199c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80199f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  8019a2:	eb 0d                	jmp    8019b1 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  8019a4:	ff 45 ec             	incl   -0x14(%ebp)
  8019a7:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019ac:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8019af:	7c c6                	jl     801977 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  8019b1:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8019b5:	75 3b                	jne    8019f2 <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  8019b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019ba:	8b 04 85 40 66 dc 00 	mov    0xdc6640(,%eax,4),%eax
  8019c1:	c1 e0 0c             	shl    $0xc,%eax
  8019c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  8019c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8019ca:	83 ec 08             	sub    $0x8,%esp
  8019cd:	50                   	push   %eax
  8019ce:	ff 75 e8             	pushl  -0x18(%ebp)
  8019d1:	e8 a7 02 00 00       	call   801c7d <sys_freeMem>
  8019d6:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  8019d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019dc:	c7 04 85 c0 4b d6 00 	movl   $0x0,0xd64bc0(,%eax,4)
  8019e3:	00 00 00 00 
    	changes++;
  8019e7:	a1 28 30 80 00       	mov    0x803028,%eax
  8019ec:	40                   	inc    %eax
  8019ed:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  8019f2:	90                   	nop
  8019f3:	c9                   	leave  
  8019f4:	c3                   	ret    

008019f5 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019f5:	55                   	push   %ebp
  8019f6:	89 e5                	mov    %esp,%ebp
  8019f8:	83 ec 18             	sub    $0x18,%esp
  8019fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8019fe:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a01:	83 ec 04             	sub    $0x4,%esp
  801a04:	68 d0 2b 80 00       	push   $0x802bd0
  801a09:	68 9f 00 00 00       	push   $0x9f
  801a0e:	68 f3 2b 80 00       	push   $0x802bf3
  801a13:	e8 07 ed ff ff       	call   80071f <_panic>

00801a18 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a18:	55                   	push   %ebp
  801a19:	89 e5                	mov    %esp,%ebp
  801a1b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a1e:	83 ec 04             	sub    $0x4,%esp
  801a21:	68 d0 2b 80 00       	push   $0x802bd0
  801a26:	68 a5 00 00 00       	push   $0xa5
  801a2b:	68 f3 2b 80 00       	push   $0x802bf3
  801a30:	e8 ea ec ff ff       	call   80071f <_panic>

00801a35 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801a35:	55                   	push   %ebp
  801a36:	89 e5                	mov    %esp,%ebp
  801a38:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a3b:	83 ec 04             	sub    $0x4,%esp
  801a3e:	68 d0 2b 80 00       	push   $0x802bd0
  801a43:	68 ab 00 00 00       	push   $0xab
  801a48:	68 f3 2b 80 00       	push   $0x802bf3
  801a4d:	e8 cd ec ff ff       	call   80071f <_panic>

00801a52 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
  801a55:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a58:	83 ec 04             	sub    $0x4,%esp
  801a5b:	68 d0 2b 80 00       	push   $0x802bd0
  801a60:	68 b0 00 00 00       	push   $0xb0
  801a65:	68 f3 2b 80 00       	push   $0x802bf3
  801a6a:	e8 b0 ec ff ff       	call   80071f <_panic>

00801a6f <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801a6f:	55                   	push   %ebp
  801a70:	89 e5                	mov    %esp,%ebp
  801a72:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a75:	83 ec 04             	sub    $0x4,%esp
  801a78:	68 d0 2b 80 00       	push   $0x802bd0
  801a7d:	68 b6 00 00 00       	push   $0xb6
  801a82:	68 f3 2b 80 00       	push   $0x802bf3
  801a87:	e8 93 ec ff ff       	call   80071f <_panic>

00801a8c <shrink>:
}
void shrink(uint32 newSize)
{
  801a8c:	55                   	push   %ebp
  801a8d:	89 e5                	mov    %esp,%ebp
  801a8f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a92:	83 ec 04             	sub    $0x4,%esp
  801a95:	68 d0 2b 80 00       	push   $0x802bd0
  801a9a:	68 ba 00 00 00       	push   $0xba
  801a9f:	68 f3 2b 80 00       	push   $0x802bf3
  801aa4:	e8 76 ec ff ff       	call   80071f <_panic>

00801aa9 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801aa9:	55                   	push   %ebp
  801aaa:	89 e5                	mov    %esp,%ebp
  801aac:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aaf:	83 ec 04             	sub    $0x4,%esp
  801ab2:	68 d0 2b 80 00       	push   $0x802bd0
  801ab7:	68 bf 00 00 00       	push   $0xbf
  801abc:	68 f3 2b 80 00       	push   $0x802bf3
  801ac1:	e8 59 ec ff ff       	call   80071f <_panic>

00801ac6 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ac6:	55                   	push   %ebp
  801ac7:	89 e5                	mov    %esp,%ebp
  801ac9:	57                   	push   %edi
  801aca:	56                   	push   %esi
  801acb:	53                   	push   %ebx
  801acc:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801acf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ad8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801adb:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ade:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801ae1:	cd 30                	int    $0x30
  801ae3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ae9:	83 c4 10             	add    $0x10,%esp
  801aec:	5b                   	pop    %ebx
  801aed:	5e                   	pop    %esi
  801aee:	5f                   	pop    %edi
  801aef:	5d                   	pop    %ebp
  801af0:	c3                   	ret    

00801af1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
  801af4:	83 ec 04             	sub    $0x4,%esp
  801af7:	8b 45 10             	mov    0x10(%ebp),%eax
  801afa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801afd:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b01:	8b 45 08             	mov    0x8(%ebp),%eax
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	52                   	push   %edx
  801b09:	ff 75 0c             	pushl  0xc(%ebp)
  801b0c:	50                   	push   %eax
  801b0d:	6a 00                	push   $0x0
  801b0f:	e8 b2 ff ff ff       	call   801ac6 <syscall>
  801b14:	83 c4 18             	add    $0x18,%esp
}
  801b17:	90                   	nop
  801b18:	c9                   	leave  
  801b19:	c3                   	ret    

00801b1a <sys_cgetc>:

int
sys_cgetc(void)
{
  801b1a:	55                   	push   %ebp
  801b1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 01                	push   $0x1
  801b29:	e8 98 ff ff ff       	call   801ac6 <syscall>
  801b2e:	83 c4 18             	add    $0x18,%esp
}
  801b31:	c9                   	leave  
  801b32:	c3                   	ret    

00801b33 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b33:	55                   	push   %ebp
  801b34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b36:	8b 45 08             	mov    0x8(%ebp),%eax
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	50                   	push   %eax
  801b42:	6a 05                	push   $0x5
  801b44:	e8 7d ff ff ff       	call   801ac6 <syscall>
  801b49:	83 c4 18             	add    $0x18,%esp
}
  801b4c:	c9                   	leave  
  801b4d:	c3                   	ret    

00801b4e <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b4e:	55                   	push   %ebp
  801b4f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	6a 00                	push   $0x0
  801b5b:	6a 02                	push   $0x2
  801b5d:	e8 64 ff ff ff       	call   801ac6 <syscall>
  801b62:	83 c4 18             	add    $0x18,%esp
}
  801b65:	c9                   	leave  
  801b66:	c3                   	ret    

00801b67 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b67:	55                   	push   %ebp
  801b68:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b6a:	6a 00                	push   $0x0
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 03                	push   $0x3
  801b76:	e8 4b ff ff ff       	call   801ac6 <syscall>
  801b7b:	83 c4 18             	add    $0x18,%esp
}
  801b7e:	c9                   	leave  
  801b7f:	c3                   	ret    

00801b80 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b80:	55                   	push   %ebp
  801b81:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 04                	push   $0x4
  801b8f:	e8 32 ff ff ff       	call   801ac6 <syscall>
  801b94:	83 c4 18             	add    $0x18,%esp
}
  801b97:	c9                   	leave  
  801b98:	c3                   	ret    

00801b99 <sys_env_exit>:


void sys_env_exit(void)
{
  801b99:	55                   	push   %ebp
  801b9a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 06                	push   $0x6
  801ba8:	e8 19 ff ff ff       	call   801ac6 <syscall>
  801bad:	83 c4 18             	add    $0x18,%esp
}
  801bb0:	90                   	nop
  801bb1:	c9                   	leave  
  801bb2:	c3                   	ret    

00801bb3 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801bb3:	55                   	push   %ebp
  801bb4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 00                	push   $0x0
  801bc2:	52                   	push   %edx
  801bc3:	50                   	push   %eax
  801bc4:	6a 07                	push   $0x7
  801bc6:	e8 fb fe ff ff       	call   801ac6 <syscall>
  801bcb:	83 c4 18             	add    $0x18,%esp
}
  801bce:	c9                   	leave  
  801bcf:	c3                   	ret    

00801bd0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
  801bd3:	56                   	push   %esi
  801bd4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801bd5:	8b 75 18             	mov    0x18(%ebp),%esi
  801bd8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bdb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bde:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be1:	8b 45 08             	mov    0x8(%ebp),%eax
  801be4:	56                   	push   %esi
  801be5:	53                   	push   %ebx
  801be6:	51                   	push   %ecx
  801be7:	52                   	push   %edx
  801be8:	50                   	push   %eax
  801be9:	6a 08                	push   $0x8
  801beb:	e8 d6 fe ff ff       	call   801ac6 <syscall>
  801bf0:	83 c4 18             	add    $0x18,%esp
}
  801bf3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bf6:	5b                   	pop    %ebx
  801bf7:	5e                   	pop    %esi
  801bf8:	5d                   	pop    %ebp
  801bf9:	c3                   	ret    

00801bfa <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801bfa:	55                   	push   %ebp
  801bfb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801bfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c00:	8b 45 08             	mov    0x8(%ebp),%eax
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	52                   	push   %edx
  801c0a:	50                   	push   %eax
  801c0b:	6a 09                	push   $0x9
  801c0d:	e8 b4 fe ff ff       	call   801ac6 <syscall>
  801c12:	83 c4 18             	add    $0x18,%esp
}
  801c15:	c9                   	leave  
  801c16:	c3                   	ret    

00801c17 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c17:	55                   	push   %ebp
  801c18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	ff 75 0c             	pushl  0xc(%ebp)
  801c23:	ff 75 08             	pushl  0x8(%ebp)
  801c26:	6a 0a                	push   $0xa
  801c28:	e8 99 fe ff ff       	call   801ac6 <syscall>
  801c2d:	83 c4 18             	add    $0x18,%esp
}
  801c30:	c9                   	leave  
  801c31:	c3                   	ret    

00801c32 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c32:	55                   	push   %ebp
  801c33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 0b                	push   $0xb
  801c41:	e8 80 fe ff ff       	call   801ac6 <syscall>
  801c46:	83 c4 18             	add    $0x18,%esp
}
  801c49:	c9                   	leave  
  801c4a:	c3                   	ret    

00801c4b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c4b:	55                   	push   %ebp
  801c4c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 0c                	push   $0xc
  801c5a:	e8 67 fe ff ff       	call   801ac6 <syscall>
  801c5f:	83 c4 18             	add    $0x18,%esp
}
  801c62:	c9                   	leave  
  801c63:	c3                   	ret    

00801c64 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c64:	55                   	push   %ebp
  801c65:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 0d                	push   $0xd
  801c73:	e8 4e fe ff ff       	call   801ac6 <syscall>
  801c78:	83 c4 18             	add    $0x18,%esp
}
  801c7b:	c9                   	leave  
  801c7c:	c3                   	ret    

00801c7d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c7d:	55                   	push   %ebp
  801c7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c80:	6a 00                	push   $0x0
  801c82:	6a 00                	push   $0x0
  801c84:	6a 00                	push   $0x0
  801c86:	ff 75 0c             	pushl  0xc(%ebp)
  801c89:	ff 75 08             	pushl  0x8(%ebp)
  801c8c:	6a 11                	push   $0x11
  801c8e:	e8 33 fe ff ff       	call   801ac6 <syscall>
  801c93:	83 c4 18             	add    $0x18,%esp
	return;
  801c96:	90                   	nop
}
  801c97:	c9                   	leave  
  801c98:	c3                   	ret    

00801c99 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c99:	55                   	push   %ebp
  801c9a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	ff 75 0c             	pushl  0xc(%ebp)
  801ca5:	ff 75 08             	pushl  0x8(%ebp)
  801ca8:	6a 12                	push   $0x12
  801caa:	e8 17 fe ff ff       	call   801ac6 <syscall>
  801caf:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb2:	90                   	nop
}
  801cb3:	c9                   	leave  
  801cb4:	c3                   	ret    

00801cb5 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801cb5:	55                   	push   %ebp
  801cb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 0e                	push   $0xe
  801cc4:	e8 fd fd ff ff       	call   801ac6 <syscall>
  801cc9:	83 c4 18             	add    $0x18,%esp
}
  801ccc:	c9                   	leave  
  801ccd:	c3                   	ret    

00801cce <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801cce:	55                   	push   %ebp
  801ccf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	ff 75 08             	pushl  0x8(%ebp)
  801cdc:	6a 0f                	push   $0xf
  801cde:	e8 e3 fd ff ff       	call   801ac6 <syscall>
  801ce3:	83 c4 18             	add    $0x18,%esp
}
  801ce6:	c9                   	leave  
  801ce7:	c3                   	ret    

00801ce8 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ce8:	55                   	push   %ebp
  801ce9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 10                	push   $0x10
  801cf7:	e8 ca fd ff ff       	call   801ac6 <syscall>
  801cfc:	83 c4 18             	add    $0x18,%esp
}
  801cff:	90                   	nop
  801d00:	c9                   	leave  
  801d01:	c3                   	ret    

00801d02 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d02:	55                   	push   %ebp
  801d03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 14                	push   $0x14
  801d11:	e8 b0 fd ff ff       	call   801ac6 <syscall>
  801d16:	83 c4 18             	add    $0x18,%esp
}
  801d19:	90                   	nop
  801d1a:	c9                   	leave  
  801d1b:	c3                   	ret    

00801d1c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d1c:	55                   	push   %ebp
  801d1d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	6a 00                	push   $0x0
  801d29:	6a 15                	push   $0x15
  801d2b:	e8 96 fd ff ff       	call   801ac6 <syscall>
  801d30:	83 c4 18             	add    $0x18,%esp
}
  801d33:	90                   	nop
  801d34:	c9                   	leave  
  801d35:	c3                   	ret    

00801d36 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d36:	55                   	push   %ebp
  801d37:	89 e5                	mov    %esp,%ebp
  801d39:	83 ec 04             	sub    $0x4,%esp
  801d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d42:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	50                   	push   %eax
  801d4f:	6a 16                	push   $0x16
  801d51:	e8 70 fd ff ff       	call   801ac6 <syscall>
  801d56:	83 c4 18             	add    $0x18,%esp
}
  801d59:	90                   	nop
  801d5a:	c9                   	leave  
  801d5b:	c3                   	ret    

00801d5c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d5c:	55                   	push   %ebp
  801d5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 17                	push   $0x17
  801d6b:	e8 56 fd ff ff       	call   801ac6 <syscall>
  801d70:	83 c4 18             	add    $0x18,%esp
}
  801d73:	90                   	nop
  801d74:	c9                   	leave  
  801d75:	c3                   	ret    

00801d76 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d76:	55                   	push   %ebp
  801d77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d79:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7c:	6a 00                	push   $0x0
  801d7e:	6a 00                	push   $0x0
  801d80:	6a 00                	push   $0x0
  801d82:	ff 75 0c             	pushl  0xc(%ebp)
  801d85:	50                   	push   %eax
  801d86:	6a 18                	push   $0x18
  801d88:	e8 39 fd ff ff       	call   801ac6 <syscall>
  801d8d:	83 c4 18             	add    $0x18,%esp
}
  801d90:	c9                   	leave  
  801d91:	c3                   	ret    

00801d92 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d92:	55                   	push   %ebp
  801d93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d98:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	52                   	push   %edx
  801da2:	50                   	push   %eax
  801da3:	6a 1b                	push   $0x1b
  801da5:	e8 1c fd ff ff       	call   801ac6 <syscall>
  801daa:	83 c4 18             	add    $0x18,%esp
}
  801dad:	c9                   	leave  
  801dae:	c3                   	ret    

00801daf <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801daf:	55                   	push   %ebp
  801db0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801db2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db5:	8b 45 08             	mov    0x8(%ebp),%eax
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	52                   	push   %edx
  801dbf:	50                   	push   %eax
  801dc0:	6a 19                	push   $0x19
  801dc2:	e8 ff fc ff ff       	call   801ac6 <syscall>
  801dc7:	83 c4 18             	add    $0x18,%esp
}
  801dca:	90                   	nop
  801dcb:	c9                   	leave  
  801dcc:	c3                   	ret    

00801dcd <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801dcd:	55                   	push   %ebp
  801dce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	52                   	push   %edx
  801ddd:	50                   	push   %eax
  801dde:	6a 1a                	push   $0x1a
  801de0:	e8 e1 fc ff ff       	call   801ac6 <syscall>
  801de5:	83 c4 18             	add    $0x18,%esp
}
  801de8:	90                   	nop
  801de9:	c9                   	leave  
  801dea:	c3                   	ret    

00801deb <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801deb:	55                   	push   %ebp
  801dec:	89 e5                	mov    %esp,%ebp
  801dee:	83 ec 04             	sub    $0x4,%esp
  801df1:	8b 45 10             	mov    0x10(%ebp),%eax
  801df4:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801df7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801dfa:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  801e01:	6a 00                	push   $0x0
  801e03:	51                   	push   %ecx
  801e04:	52                   	push   %edx
  801e05:	ff 75 0c             	pushl  0xc(%ebp)
  801e08:	50                   	push   %eax
  801e09:	6a 1c                	push   $0x1c
  801e0b:	e8 b6 fc ff ff       	call   801ac6 <syscall>
  801e10:	83 c4 18             	add    $0x18,%esp
}
  801e13:	c9                   	leave  
  801e14:	c3                   	ret    

00801e15 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e15:	55                   	push   %ebp
  801e16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e18:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	52                   	push   %edx
  801e25:	50                   	push   %eax
  801e26:	6a 1d                	push   $0x1d
  801e28:	e8 99 fc ff ff       	call   801ac6 <syscall>
  801e2d:	83 c4 18             	add    $0x18,%esp
}
  801e30:	c9                   	leave  
  801e31:	c3                   	ret    

00801e32 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e32:	55                   	push   %ebp
  801e33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e35:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e38:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	51                   	push   %ecx
  801e43:	52                   	push   %edx
  801e44:	50                   	push   %eax
  801e45:	6a 1e                	push   $0x1e
  801e47:	e8 7a fc ff ff       	call   801ac6 <syscall>
  801e4c:	83 c4 18             	add    $0x18,%esp
}
  801e4f:	c9                   	leave  
  801e50:	c3                   	ret    

00801e51 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e51:	55                   	push   %ebp
  801e52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e57:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 00                	push   $0x0
  801e60:	52                   	push   %edx
  801e61:	50                   	push   %eax
  801e62:	6a 1f                	push   $0x1f
  801e64:	e8 5d fc ff ff       	call   801ac6 <syscall>
  801e69:	83 c4 18             	add    $0x18,%esp
}
  801e6c:	c9                   	leave  
  801e6d:	c3                   	ret    

00801e6e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e6e:	55                   	push   %ebp
  801e6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e71:	6a 00                	push   $0x0
  801e73:	6a 00                	push   $0x0
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 20                	push   $0x20
  801e7d:	e8 44 fc ff ff       	call   801ac6 <syscall>
  801e82:	83 c4 18             	add    $0x18,%esp
}
  801e85:	c9                   	leave  
  801e86:	c3                   	ret    

00801e87 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801e87:	55                   	push   %ebp
  801e88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8d:	6a 00                	push   $0x0
  801e8f:	ff 75 14             	pushl  0x14(%ebp)
  801e92:	ff 75 10             	pushl  0x10(%ebp)
  801e95:	ff 75 0c             	pushl  0xc(%ebp)
  801e98:	50                   	push   %eax
  801e99:	6a 21                	push   $0x21
  801e9b:	e8 26 fc ff ff       	call   801ac6 <syscall>
  801ea0:	83 c4 18             	add    $0x18,%esp
}
  801ea3:	c9                   	leave  
  801ea4:	c3                   	ret    

00801ea5 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ea5:	55                   	push   %ebp
  801ea6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	50                   	push   %eax
  801eb4:	6a 22                	push   $0x22
  801eb6:	e8 0b fc ff ff       	call   801ac6 <syscall>
  801ebb:	83 c4 18             	add    $0x18,%esp
}
  801ebe:	90                   	nop
  801ebf:	c9                   	leave  
  801ec0:	c3                   	ret    

00801ec1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ec1:	55                   	push   %ebp
  801ec2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ec4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	50                   	push   %eax
  801ed0:	6a 23                	push   $0x23
  801ed2:	e8 ef fb ff ff       	call   801ac6 <syscall>
  801ed7:	83 c4 18             	add    $0x18,%esp
}
  801eda:	90                   	nop
  801edb:	c9                   	leave  
  801edc:	c3                   	ret    

00801edd <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801edd:	55                   	push   %ebp
  801ede:	89 e5                	mov    %esp,%ebp
  801ee0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ee3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ee6:	8d 50 04             	lea    0x4(%eax),%edx
  801ee9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	52                   	push   %edx
  801ef3:	50                   	push   %eax
  801ef4:	6a 24                	push   $0x24
  801ef6:	e8 cb fb ff ff       	call   801ac6 <syscall>
  801efb:	83 c4 18             	add    $0x18,%esp
	return result;
  801efe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f04:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f07:	89 01                	mov    %eax,(%ecx)
  801f09:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0f:	c9                   	leave  
  801f10:	c2 04 00             	ret    $0x4

00801f13 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f13:	55                   	push   %ebp
  801f14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	ff 75 10             	pushl  0x10(%ebp)
  801f1d:	ff 75 0c             	pushl  0xc(%ebp)
  801f20:	ff 75 08             	pushl  0x8(%ebp)
  801f23:	6a 13                	push   $0x13
  801f25:	e8 9c fb ff ff       	call   801ac6 <syscall>
  801f2a:	83 c4 18             	add    $0x18,%esp
	return ;
  801f2d:	90                   	nop
}
  801f2e:	c9                   	leave  
  801f2f:	c3                   	ret    

00801f30 <sys_rcr2>:
uint32 sys_rcr2()
{
  801f30:	55                   	push   %ebp
  801f31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 25                	push   $0x25
  801f3f:	e8 82 fb ff ff       	call   801ac6 <syscall>
  801f44:	83 c4 18             	add    $0x18,%esp
}
  801f47:	c9                   	leave  
  801f48:	c3                   	ret    

00801f49 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f49:	55                   	push   %ebp
  801f4a:	89 e5                	mov    %esp,%ebp
  801f4c:	83 ec 04             	sub    $0x4,%esp
  801f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f52:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f55:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 00                	push   $0x0
  801f61:	50                   	push   %eax
  801f62:	6a 26                	push   $0x26
  801f64:	e8 5d fb ff ff       	call   801ac6 <syscall>
  801f69:	83 c4 18             	add    $0x18,%esp
	return ;
  801f6c:	90                   	nop
}
  801f6d:	c9                   	leave  
  801f6e:	c3                   	ret    

00801f6f <rsttst>:
void rsttst()
{
  801f6f:	55                   	push   %ebp
  801f70:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 28                	push   $0x28
  801f7e:	e8 43 fb ff ff       	call   801ac6 <syscall>
  801f83:	83 c4 18             	add    $0x18,%esp
	return ;
  801f86:	90                   	nop
}
  801f87:	c9                   	leave  
  801f88:	c3                   	ret    

00801f89 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f89:	55                   	push   %ebp
  801f8a:	89 e5                	mov    %esp,%ebp
  801f8c:	83 ec 04             	sub    $0x4,%esp
  801f8f:	8b 45 14             	mov    0x14(%ebp),%eax
  801f92:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f95:	8b 55 18             	mov    0x18(%ebp),%edx
  801f98:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f9c:	52                   	push   %edx
  801f9d:	50                   	push   %eax
  801f9e:	ff 75 10             	pushl  0x10(%ebp)
  801fa1:	ff 75 0c             	pushl  0xc(%ebp)
  801fa4:	ff 75 08             	pushl  0x8(%ebp)
  801fa7:	6a 27                	push   $0x27
  801fa9:	e8 18 fb ff ff       	call   801ac6 <syscall>
  801fae:	83 c4 18             	add    $0x18,%esp
	return ;
  801fb1:	90                   	nop
}
  801fb2:	c9                   	leave  
  801fb3:	c3                   	ret    

00801fb4 <chktst>:
void chktst(uint32 n)
{
  801fb4:	55                   	push   %ebp
  801fb5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	ff 75 08             	pushl  0x8(%ebp)
  801fc2:	6a 29                	push   $0x29
  801fc4:	e8 fd fa ff ff       	call   801ac6 <syscall>
  801fc9:	83 c4 18             	add    $0x18,%esp
	return ;
  801fcc:	90                   	nop
}
  801fcd:	c9                   	leave  
  801fce:	c3                   	ret    

00801fcf <inctst>:

void inctst()
{
  801fcf:	55                   	push   %ebp
  801fd0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 2a                	push   $0x2a
  801fde:	e8 e3 fa ff ff       	call   801ac6 <syscall>
  801fe3:	83 c4 18             	add    $0x18,%esp
	return ;
  801fe6:	90                   	nop
}
  801fe7:	c9                   	leave  
  801fe8:	c3                   	ret    

00801fe9 <gettst>:
uint32 gettst()
{
  801fe9:	55                   	push   %ebp
  801fea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 2b                	push   $0x2b
  801ff8:	e8 c9 fa ff ff       	call   801ac6 <syscall>
  801ffd:	83 c4 18             	add    $0x18,%esp
}
  802000:	c9                   	leave  
  802001:	c3                   	ret    

00802002 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802002:	55                   	push   %ebp
  802003:	89 e5                	mov    %esp,%ebp
  802005:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	6a 2c                	push   $0x2c
  802014:	e8 ad fa ff ff       	call   801ac6 <syscall>
  802019:	83 c4 18             	add    $0x18,%esp
  80201c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80201f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802023:	75 07                	jne    80202c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802025:	b8 01 00 00 00       	mov    $0x1,%eax
  80202a:	eb 05                	jmp    802031 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80202c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802031:	c9                   	leave  
  802032:	c3                   	ret    

00802033 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802033:	55                   	push   %ebp
  802034:	89 e5                	mov    %esp,%ebp
  802036:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	6a 2c                	push   $0x2c
  802045:	e8 7c fa ff ff       	call   801ac6 <syscall>
  80204a:	83 c4 18             	add    $0x18,%esp
  80204d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802050:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802054:	75 07                	jne    80205d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802056:	b8 01 00 00 00       	mov    $0x1,%eax
  80205b:	eb 05                	jmp    802062 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80205d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802062:	c9                   	leave  
  802063:	c3                   	ret    

00802064 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802064:	55                   	push   %ebp
  802065:	89 e5                	mov    %esp,%ebp
  802067:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	6a 00                	push   $0x0
  802070:	6a 00                	push   $0x0
  802072:	6a 00                	push   $0x0
  802074:	6a 2c                	push   $0x2c
  802076:	e8 4b fa ff ff       	call   801ac6 <syscall>
  80207b:	83 c4 18             	add    $0x18,%esp
  80207e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802081:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802085:	75 07                	jne    80208e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802087:	b8 01 00 00 00       	mov    $0x1,%eax
  80208c:	eb 05                	jmp    802093 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80208e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802093:	c9                   	leave  
  802094:	c3                   	ret    

00802095 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802095:	55                   	push   %ebp
  802096:	89 e5                	mov    %esp,%ebp
  802098:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 00                	push   $0x0
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 2c                	push   $0x2c
  8020a7:	e8 1a fa ff ff       	call   801ac6 <syscall>
  8020ac:	83 c4 18             	add    $0x18,%esp
  8020af:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8020b2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8020b6:	75 07                	jne    8020bf <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8020b8:	b8 01 00 00 00       	mov    $0x1,%eax
  8020bd:	eb 05                	jmp    8020c4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8020bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020c4:	c9                   	leave  
  8020c5:	c3                   	ret    

008020c6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020c6:	55                   	push   %ebp
  8020c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	ff 75 08             	pushl  0x8(%ebp)
  8020d4:	6a 2d                	push   $0x2d
  8020d6:	e8 eb f9 ff ff       	call   801ac6 <syscall>
  8020db:	83 c4 18             	add    $0x18,%esp
	return ;
  8020de:	90                   	nop
}
  8020df:	c9                   	leave  
  8020e0:	c3                   	ret    

008020e1 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020e1:	55                   	push   %ebp
  8020e2:	89 e5                	mov    %esp,%ebp
  8020e4:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8020e5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f1:	6a 00                	push   $0x0
  8020f3:	53                   	push   %ebx
  8020f4:	51                   	push   %ecx
  8020f5:	52                   	push   %edx
  8020f6:	50                   	push   %eax
  8020f7:	6a 2e                	push   $0x2e
  8020f9:	e8 c8 f9 ff ff       	call   801ac6 <syscall>
  8020fe:	83 c4 18             	add    $0x18,%esp
}
  802101:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802104:	c9                   	leave  
  802105:	c3                   	ret    

00802106 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802106:	55                   	push   %ebp
  802107:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802109:	8b 55 0c             	mov    0xc(%ebp),%edx
  80210c:	8b 45 08             	mov    0x8(%ebp),%eax
  80210f:	6a 00                	push   $0x0
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	52                   	push   %edx
  802116:	50                   	push   %eax
  802117:	6a 2f                	push   $0x2f
  802119:	e8 a8 f9 ff ff       	call   801ac6 <syscall>
  80211e:	83 c4 18             	add    $0x18,%esp
}
  802121:	c9                   	leave  
  802122:	c3                   	ret    
  802123:	90                   	nop

00802124 <__udivdi3>:
  802124:	55                   	push   %ebp
  802125:	57                   	push   %edi
  802126:	56                   	push   %esi
  802127:	53                   	push   %ebx
  802128:	83 ec 1c             	sub    $0x1c,%esp
  80212b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80212f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802133:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802137:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80213b:	89 ca                	mov    %ecx,%edx
  80213d:	89 f8                	mov    %edi,%eax
  80213f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802143:	85 f6                	test   %esi,%esi
  802145:	75 2d                	jne    802174 <__udivdi3+0x50>
  802147:	39 cf                	cmp    %ecx,%edi
  802149:	77 65                	ja     8021b0 <__udivdi3+0x8c>
  80214b:	89 fd                	mov    %edi,%ebp
  80214d:	85 ff                	test   %edi,%edi
  80214f:	75 0b                	jne    80215c <__udivdi3+0x38>
  802151:	b8 01 00 00 00       	mov    $0x1,%eax
  802156:	31 d2                	xor    %edx,%edx
  802158:	f7 f7                	div    %edi
  80215a:	89 c5                	mov    %eax,%ebp
  80215c:	31 d2                	xor    %edx,%edx
  80215e:	89 c8                	mov    %ecx,%eax
  802160:	f7 f5                	div    %ebp
  802162:	89 c1                	mov    %eax,%ecx
  802164:	89 d8                	mov    %ebx,%eax
  802166:	f7 f5                	div    %ebp
  802168:	89 cf                	mov    %ecx,%edi
  80216a:	89 fa                	mov    %edi,%edx
  80216c:	83 c4 1c             	add    $0x1c,%esp
  80216f:	5b                   	pop    %ebx
  802170:	5e                   	pop    %esi
  802171:	5f                   	pop    %edi
  802172:	5d                   	pop    %ebp
  802173:	c3                   	ret    
  802174:	39 ce                	cmp    %ecx,%esi
  802176:	77 28                	ja     8021a0 <__udivdi3+0x7c>
  802178:	0f bd fe             	bsr    %esi,%edi
  80217b:	83 f7 1f             	xor    $0x1f,%edi
  80217e:	75 40                	jne    8021c0 <__udivdi3+0x9c>
  802180:	39 ce                	cmp    %ecx,%esi
  802182:	72 0a                	jb     80218e <__udivdi3+0x6a>
  802184:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802188:	0f 87 9e 00 00 00    	ja     80222c <__udivdi3+0x108>
  80218e:	b8 01 00 00 00       	mov    $0x1,%eax
  802193:	89 fa                	mov    %edi,%edx
  802195:	83 c4 1c             	add    $0x1c,%esp
  802198:	5b                   	pop    %ebx
  802199:	5e                   	pop    %esi
  80219a:	5f                   	pop    %edi
  80219b:	5d                   	pop    %ebp
  80219c:	c3                   	ret    
  80219d:	8d 76 00             	lea    0x0(%esi),%esi
  8021a0:	31 ff                	xor    %edi,%edi
  8021a2:	31 c0                	xor    %eax,%eax
  8021a4:	89 fa                	mov    %edi,%edx
  8021a6:	83 c4 1c             	add    $0x1c,%esp
  8021a9:	5b                   	pop    %ebx
  8021aa:	5e                   	pop    %esi
  8021ab:	5f                   	pop    %edi
  8021ac:	5d                   	pop    %ebp
  8021ad:	c3                   	ret    
  8021ae:	66 90                	xchg   %ax,%ax
  8021b0:	89 d8                	mov    %ebx,%eax
  8021b2:	f7 f7                	div    %edi
  8021b4:	31 ff                	xor    %edi,%edi
  8021b6:	89 fa                	mov    %edi,%edx
  8021b8:	83 c4 1c             	add    $0x1c,%esp
  8021bb:	5b                   	pop    %ebx
  8021bc:	5e                   	pop    %esi
  8021bd:	5f                   	pop    %edi
  8021be:	5d                   	pop    %ebp
  8021bf:	c3                   	ret    
  8021c0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8021c5:	89 eb                	mov    %ebp,%ebx
  8021c7:	29 fb                	sub    %edi,%ebx
  8021c9:	89 f9                	mov    %edi,%ecx
  8021cb:	d3 e6                	shl    %cl,%esi
  8021cd:	89 c5                	mov    %eax,%ebp
  8021cf:	88 d9                	mov    %bl,%cl
  8021d1:	d3 ed                	shr    %cl,%ebp
  8021d3:	89 e9                	mov    %ebp,%ecx
  8021d5:	09 f1                	or     %esi,%ecx
  8021d7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8021db:	89 f9                	mov    %edi,%ecx
  8021dd:	d3 e0                	shl    %cl,%eax
  8021df:	89 c5                	mov    %eax,%ebp
  8021e1:	89 d6                	mov    %edx,%esi
  8021e3:	88 d9                	mov    %bl,%cl
  8021e5:	d3 ee                	shr    %cl,%esi
  8021e7:	89 f9                	mov    %edi,%ecx
  8021e9:	d3 e2                	shl    %cl,%edx
  8021eb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021ef:	88 d9                	mov    %bl,%cl
  8021f1:	d3 e8                	shr    %cl,%eax
  8021f3:	09 c2                	or     %eax,%edx
  8021f5:	89 d0                	mov    %edx,%eax
  8021f7:	89 f2                	mov    %esi,%edx
  8021f9:	f7 74 24 0c          	divl   0xc(%esp)
  8021fd:	89 d6                	mov    %edx,%esi
  8021ff:	89 c3                	mov    %eax,%ebx
  802201:	f7 e5                	mul    %ebp
  802203:	39 d6                	cmp    %edx,%esi
  802205:	72 19                	jb     802220 <__udivdi3+0xfc>
  802207:	74 0b                	je     802214 <__udivdi3+0xf0>
  802209:	89 d8                	mov    %ebx,%eax
  80220b:	31 ff                	xor    %edi,%edi
  80220d:	e9 58 ff ff ff       	jmp    80216a <__udivdi3+0x46>
  802212:	66 90                	xchg   %ax,%ax
  802214:	8b 54 24 08          	mov    0x8(%esp),%edx
  802218:	89 f9                	mov    %edi,%ecx
  80221a:	d3 e2                	shl    %cl,%edx
  80221c:	39 c2                	cmp    %eax,%edx
  80221e:	73 e9                	jae    802209 <__udivdi3+0xe5>
  802220:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802223:	31 ff                	xor    %edi,%edi
  802225:	e9 40 ff ff ff       	jmp    80216a <__udivdi3+0x46>
  80222a:	66 90                	xchg   %ax,%ax
  80222c:	31 c0                	xor    %eax,%eax
  80222e:	e9 37 ff ff ff       	jmp    80216a <__udivdi3+0x46>
  802233:	90                   	nop

00802234 <__umoddi3>:
  802234:	55                   	push   %ebp
  802235:	57                   	push   %edi
  802236:	56                   	push   %esi
  802237:	53                   	push   %ebx
  802238:	83 ec 1c             	sub    $0x1c,%esp
  80223b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80223f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802243:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802247:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80224b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80224f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802253:	89 f3                	mov    %esi,%ebx
  802255:	89 fa                	mov    %edi,%edx
  802257:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80225b:	89 34 24             	mov    %esi,(%esp)
  80225e:	85 c0                	test   %eax,%eax
  802260:	75 1a                	jne    80227c <__umoddi3+0x48>
  802262:	39 f7                	cmp    %esi,%edi
  802264:	0f 86 a2 00 00 00    	jbe    80230c <__umoddi3+0xd8>
  80226a:	89 c8                	mov    %ecx,%eax
  80226c:	89 f2                	mov    %esi,%edx
  80226e:	f7 f7                	div    %edi
  802270:	89 d0                	mov    %edx,%eax
  802272:	31 d2                	xor    %edx,%edx
  802274:	83 c4 1c             	add    $0x1c,%esp
  802277:	5b                   	pop    %ebx
  802278:	5e                   	pop    %esi
  802279:	5f                   	pop    %edi
  80227a:	5d                   	pop    %ebp
  80227b:	c3                   	ret    
  80227c:	39 f0                	cmp    %esi,%eax
  80227e:	0f 87 ac 00 00 00    	ja     802330 <__umoddi3+0xfc>
  802284:	0f bd e8             	bsr    %eax,%ebp
  802287:	83 f5 1f             	xor    $0x1f,%ebp
  80228a:	0f 84 ac 00 00 00    	je     80233c <__umoddi3+0x108>
  802290:	bf 20 00 00 00       	mov    $0x20,%edi
  802295:	29 ef                	sub    %ebp,%edi
  802297:	89 fe                	mov    %edi,%esi
  802299:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80229d:	89 e9                	mov    %ebp,%ecx
  80229f:	d3 e0                	shl    %cl,%eax
  8022a1:	89 d7                	mov    %edx,%edi
  8022a3:	89 f1                	mov    %esi,%ecx
  8022a5:	d3 ef                	shr    %cl,%edi
  8022a7:	09 c7                	or     %eax,%edi
  8022a9:	89 e9                	mov    %ebp,%ecx
  8022ab:	d3 e2                	shl    %cl,%edx
  8022ad:	89 14 24             	mov    %edx,(%esp)
  8022b0:	89 d8                	mov    %ebx,%eax
  8022b2:	d3 e0                	shl    %cl,%eax
  8022b4:	89 c2                	mov    %eax,%edx
  8022b6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022ba:	d3 e0                	shl    %cl,%eax
  8022bc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022c0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022c4:	89 f1                	mov    %esi,%ecx
  8022c6:	d3 e8                	shr    %cl,%eax
  8022c8:	09 d0                	or     %edx,%eax
  8022ca:	d3 eb                	shr    %cl,%ebx
  8022cc:	89 da                	mov    %ebx,%edx
  8022ce:	f7 f7                	div    %edi
  8022d0:	89 d3                	mov    %edx,%ebx
  8022d2:	f7 24 24             	mull   (%esp)
  8022d5:	89 c6                	mov    %eax,%esi
  8022d7:	89 d1                	mov    %edx,%ecx
  8022d9:	39 d3                	cmp    %edx,%ebx
  8022db:	0f 82 87 00 00 00    	jb     802368 <__umoddi3+0x134>
  8022e1:	0f 84 91 00 00 00    	je     802378 <__umoddi3+0x144>
  8022e7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8022eb:	29 f2                	sub    %esi,%edx
  8022ed:	19 cb                	sbb    %ecx,%ebx
  8022ef:	89 d8                	mov    %ebx,%eax
  8022f1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8022f5:	d3 e0                	shl    %cl,%eax
  8022f7:	89 e9                	mov    %ebp,%ecx
  8022f9:	d3 ea                	shr    %cl,%edx
  8022fb:	09 d0                	or     %edx,%eax
  8022fd:	89 e9                	mov    %ebp,%ecx
  8022ff:	d3 eb                	shr    %cl,%ebx
  802301:	89 da                	mov    %ebx,%edx
  802303:	83 c4 1c             	add    $0x1c,%esp
  802306:	5b                   	pop    %ebx
  802307:	5e                   	pop    %esi
  802308:	5f                   	pop    %edi
  802309:	5d                   	pop    %ebp
  80230a:	c3                   	ret    
  80230b:	90                   	nop
  80230c:	89 fd                	mov    %edi,%ebp
  80230e:	85 ff                	test   %edi,%edi
  802310:	75 0b                	jne    80231d <__umoddi3+0xe9>
  802312:	b8 01 00 00 00       	mov    $0x1,%eax
  802317:	31 d2                	xor    %edx,%edx
  802319:	f7 f7                	div    %edi
  80231b:	89 c5                	mov    %eax,%ebp
  80231d:	89 f0                	mov    %esi,%eax
  80231f:	31 d2                	xor    %edx,%edx
  802321:	f7 f5                	div    %ebp
  802323:	89 c8                	mov    %ecx,%eax
  802325:	f7 f5                	div    %ebp
  802327:	89 d0                	mov    %edx,%eax
  802329:	e9 44 ff ff ff       	jmp    802272 <__umoddi3+0x3e>
  80232e:	66 90                	xchg   %ax,%ax
  802330:	89 c8                	mov    %ecx,%eax
  802332:	89 f2                	mov    %esi,%edx
  802334:	83 c4 1c             	add    $0x1c,%esp
  802337:	5b                   	pop    %ebx
  802338:	5e                   	pop    %esi
  802339:	5f                   	pop    %edi
  80233a:	5d                   	pop    %ebp
  80233b:	c3                   	ret    
  80233c:	3b 04 24             	cmp    (%esp),%eax
  80233f:	72 06                	jb     802347 <__umoddi3+0x113>
  802341:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802345:	77 0f                	ja     802356 <__umoddi3+0x122>
  802347:	89 f2                	mov    %esi,%edx
  802349:	29 f9                	sub    %edi,%ecx
  80234b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80234f:	89 14 24             	mov    %edx,(%esp)
  802352:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802356:	8b 44 24 04          	mov    0x4(%esp),%eax
  80235a:	8b 14 24             	mov    (%esp),%edx
  80235d:	83 c4 1c             	add    $0x1c,%esp
  802360:	5b                   	pop    %ebx
  802361:	5e                   	pop    %esi
  802362:	5f                   	pop    %edi
  802363:	5d                   	pop    %ebp
  802364:	c3                   	ret    
  802365:	8d 76 00             	lea    0x0(%esi),%esi
  802368:	2b 04 24             	sub    (%esp),%eax
  80236b:	19 fa                	sbb    %edi,%edx
  80236d:	89 d1                	mov    %edx,%ecx
  80236f:	89 c6                	mov    %eax,%esi
  802371:	e9 71 ff ff ff       	jmp    8022e7 <__umoddi3+0xb3>
  802376:	66 90                	xchg   %ax,%ax
  802378:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80237c:	72 ea                	jb     802368 <__umoddi3+0x134>
  80237e:	89 d9                	mov    %ebx,%ecx
  802380:	e9 62 ff ff ff       	jmp    8022e7 <__umoddi3+0xb3>
