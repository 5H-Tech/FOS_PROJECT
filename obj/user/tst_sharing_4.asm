
obj/user/tst_sharing_4:     file format elf32-i386


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
  800031:	e8 2e 05 00 00       	call   800564 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the free of shared variables (create_shared_memory)
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003f:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800043:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004a:	eb 23                	jmp    80006f <_main+0x37>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004c:	a1 20 30 80 00       	mov    0x803020,%eax
  800051:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800057:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005a:	c1 e2 04             	shl    $0x4,%edx
  80005d:	01 d0                	add    %edx,%eax
  80005f:	8a 40 04             	mov    0x4(%eax),%al
  800062:	84 c0                	test   %al,%al
  800064:	74 06                	je     80006c <_main+0x34>
			{
				fullWS = 0;
  800066:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006a:	eb 12                	jmp    80007e <_main+0x46>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006c:	ff 45 f0             	incl   -0x10(%ebp)
  80006f:	a1 20 30 80 00       	mov    0x803020,%eax
  800074:	8b 50 74             	mov    0x74(%eax),%edx
  800077:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007a:	39 c2                	cmp    %eax,%edx
  80007c:	77 ce                	ja     80004c <_main+0x14>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80007e:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800082:	74 14                	je     800098 <_main+0x60>
  800084:	83 ec 04             	sub    $0x4,%esp
  800087:	68 e0 23 80 00       	push   $0x8023e0
  80008c:	6a 12                	push   $0x12
  80008e:	68 fc 23 80 00       	push   $0x8023fc
  800093:	e8 11 06 00 00       	call   8006a9 <_panic>
	}

	cprintf("************************************************\n");
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	68 14 24 80 00       	push   $0x802414
  8000a0:	e8 a6 08 00 00       	call   80094b <cprintf>
  8000a5:	83 c4 10             	add    $0x10,%esp
	cprintf("MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  8000a8:	83 ec 0c             	sub    $0xc,%esp
  8000ab:	68 48 24 80 00       	push   $0x802448
  8000b0:	e8 96 08 00 00       	call   80094b <cprintf>
  8000b5:	83 c4 10             	add    $0x10,%esp
	cprintf("************************************************\n\n\n");
  8000b8:	83 ec 0c             	sub    $0xc,%esp
  8000bb:	68 a4 24 80 00       	push   $0x8024a4
  8000c0:	e8 86 08 00 00       	call   80094b <cprintf>
  8000c5:	83 c4 10             	add    $0x10,%esp

	int Mega = 1024*1024;
  8000c8:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000cf:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	int envID = sys_getenvid();
  8000d6:	e8 b4 1a 00 00       	call   801b8f <sys_getenvid>
  8000db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	cprintf("STEP A: checking free of a shared object ... \n");
  8000de:	83 ec 0c             	sub    $0xc,%esp
  8000e1:	68 d8 24 80 00       	push   $0x8024d8
  8000e6:	e8 60 08 00 00       	call   80094b <cprintf>
  8000eb:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x;
		int freeFrames = sys_calculate_free_frames() ;
  8000ee:	e8 80 1b 00 00       	call   801c73 <sys_calculate_free_frames>
  8000f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8000f6:	83 ec 04             	sub    $0x4,%esp
  8000f9:	6a 01                	push   $0x1
  8000fb:	68 00 10 00 00       	push   $0x1000
  800100:	68 07 25 80 00       	push   $0x802507
  800105:	e8 2c 19 00 00       	call   801a36 <smalloc>
  80010a:	83 c4 10             	add    $0x10,%esp
  80010d:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800110:	81 7d dc 00 00 00 80 	cmpl   $0x80000000,-0x24(%ebp)
  800117:	74 14                	je     80012d <_main+0xf5>
  800119:	83 ec 04             	sub    $0x4,%esp
  80011c:	68 0c 25 80 00       	push   $0x80250c
  800121:	6a 21                	push   $0x21
  800123:	68 fc 23 80 00       	push   $0x8023fc
  800128:	e8 7c 05 00 00       	call   8006a9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80012d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800130:	e8 3e 1b 00 00       	call   801c73 <sys_calculate_free_frames>
  800135:	29 c3                	sub    %eax,%ebx
  800137:	89 d8                	mov    %ebx,%eax
  800139:	83 f8 04             	cmp    $0x4,%eax
  80013c:	74 14                	je     800152 <_main+0x11a>
  80013e:	83 ec 04             	sub    $0x4,%esp
  800141:	68 78 25 80 00       	push   $0x802578
  800146:	6a 22                	push   $0x22
  800148:	68 fc 23 80 00       	push   $0x8023fc
  80014d:	e8 57 05 00 00       	call   8006a9 <_panic>

		sfree(x);
  800152:	83 ec 0c             	sub    $0xc,%esp
  800155:	ff 75 dc             	pushl  -0x24(%ebp)
  800158:	e8 19 19 00 00       	call   801a76 <sfree>
  80015d:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) ==  0+0+2) panic("Wrong free: make sure that you free the shared object by calling free_share_object()");
  800160:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800163:	e8 0b 1b 00 00       	call   801c73 <sys_calculate_free_frames>
  800168:	29 c3                	sub    %eax,%ebx
  80016a:	89 d8                	mov    %ebx,%eax
  80016c:	83 f8 02             	cmp    $0x2,%eax
  80016f:	75 14                	jne    800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 f8 25 80 00       	push   $0x8025f8
  800179:	6a 25                	push   $0x25
  80017b:	68 fc 23 80 00       	push   $0x8023fc
  800180:	e8 24 05 00 00       	call   8006a9 <_panic>
		else if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: revise your freeSharedObject logic");
  800185:	e8 e9 1a 00 00       	call   801c73 <sys_calculate_free_frames>
  80018a:	89 c2                	mov    %eax,%edx
  80018c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80018f:	39 c2                	cmp    %eax,%edx
  800191:	74 14                	je     8001a7 <_main+0x16f>
  800193:	83 ec 04             	sub    $0x4,%esp
  800196:	68 50 26 80 00       	push   $0x802650
  80019b:	6a 26                	push   $0x26
  80019d:	68 fc 23 80 00       	push   $0x8023fc
  8001a2:	e8 02 05 00 00       	call   8006a9 <_panic>
	}
	cprintf("Step A completed successfully!!\n\n\n");
  8001a7:	83 ec 0c             	sub    $0xc,%esp
  8001aa:	68 80 26 80 00       	push   $0x802680
  8001af:	e8 97 07 00 00       	call   80094b <cprintf>
  8001b4:	83 c4 10             	add    $0x10,%esp


	cprintf("STEP B: checking free of 2 shared objects ... \n");
  8001b7:	83 ec 0c             	sub    $0xc,%esp
  8001ba:	68 a4 26 80 00       	push   $0x8026a4
  8001bf:	e8 87 07 00 00       	call   80094b <cprintf>
  8001c4:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x, *z ;
		int freeFrames = sys_calculate_free_frames() ;
  8001c7:	e8 a7 1a 00 00       	call   801c73 <sys_calculate_free_frames>
  8001cc:	89 45 d8             	mov    %eax,-0x28(%ebp)
		z = smalloc("z", PAGE_SIZE, 1);
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	6a 01                	push   $0x1
  8001d4:	68 00 10 00 00       	push   $0x1000
  8001d9:	68 d4 26 80 00       	push   $0x8026d4
  8001de:	e8 53 18 00 00       	call   801a36 <smalloc>
  8001e3:	83 c4 10             	add    $0x10,%esp
  8001e6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8001e9:	83 ec 04             	sub    $0x4,%esp
  8001ec:	6a 01                	push   $0x1
  8001ee:	68 00 10 00 00       	push   $0x1000
  8001f3:	68 07 25 80 00       	push   $0x802507
  8001f8:	e8 39 18 00 00       	call   801a36 <smalloc>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 d0             	mov    %eax,-0x30(%ebp)

		if(x == NULL) panic("Wrong free: make sure that you free the shared object by calling free_share_object()");
  800203:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 f8 25 80 00       	push   $0x8025f8
  800211:	6a 32                	push   $0x32
  800213:	68 fc 23 80 00       	push   $0x8023fc
  800218:	e8 8c 04 00 00       	call   8006a9 <_panic>

		if ((freeFrames - sys_calculate_free_frames()) !=  2+1+4) panic("Wrong previous free: make sure that you correctly free shared object before (Step A)");
  80021d:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800220:	e8 4e 1a 00 00       	call   801c73 <sys_calculate_free_frames>
  800225:	29 c3                	sub    %eax,%ebx
  800227:	89 d8                	mov    %ebx,%eax
  800229:	83 f8 07             	cmp    $0x7,%eax
  80022c:	74 14                	je     800242 <_main+0x20a>
  80022e:	83 ec 04             	sub    $0x4,%esp
  800231:	68 d8 26 80 00       	push   $0x8026d8
  800236:	6a 34                	push   $0x34
  800238:	68 fc 23 80 00       	push   $0x8023fc
  80023d:	e8 67 04 00 00       	call   8006a9 <_panic>

		sfree(z);
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	ff 75 d4             	pushl  -0x2c(%ebp)
  800248:	e8 29 18 00 00       	call   801a76 <sfree>
  80024d:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  800250:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800253:	e8 1b 1a 00 00       	call   801c73 <sys_calculate_free_frames>
  800258:	29 c3                	sub    %eax,%ebx
  80025a:	89 d8                	mov    %ebx,%eax
  80025c:	83 f8 04             	cmp    $0x4,%eax
  80025f:	74 14                	je     800275 <_main+0x23d>
  800261:	83 ec 04             	sub    $0x4,%esp
  800264:	68 2d 27 80 00       	push   $0x80272d
  800269:	6a 37                	push   $0x37
  80026b:	68 fc 23 80 00       	push   $0x8023fc
  800270:	e8 34 04 00 00       	call   8006a9 <_panic>

		sfree(x);
  800275:	83 ec 0c             	sub    $0xc,%esp
  800278:	ff 75 d0             	pushl  -0x30(%ebp)
  80027b:	e8 f6 17 00 00       	call   801a76 <sfree>
  800280:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  800283:	e8 eb 19 00 00       	call   801c73 <sys_calculate_free_frames>
  800288:	89 c2                	mov    %eax,%edx
  80028a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80028d:	39 c2                	cmp    %eax,%edx
  80028f:	74 14                	je     8002a5 <_main+0x26d>
  800291:	83 ec 04             	sub    $0x4,%esp
  800294:	68 2d 27 80 00       	push   $0x80272d
  800299:	6a 3a                	push   $0x3a
  80029b:	68 fc 23 80 00       	push   $0x8023fc
  8002a0:	e8 04 04 00 00       	call   8006a9 <_panic>

	}
	cprintf("Step B completed successfully!!\n\n\n");
  8002a5:	83 ec 0c             	sub    $0xc,%esp
  8002a8:	68 4c 27 80 00       	push   $0x80274c
  8002ad:	e8 99 06 00 00       	call   80094b <cprintf>
  8002b2:	83 c4 10             	add    $0x10,%esp

	cprintf("STEP C: checking range of loop during free... \n");
  8002b5:	83 ec 0c             	sub    $0xc,%esp
  8002b8:	68 70 27 80 00       	push   $0x802770
  8002bd:	e8 89 06 00 00       	call   80094b <cprintf>
  8002c2:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *w, *u;
		int freeFrames = sys_calculate_free_frames() ;
  8002c5:	e8 a9 19 00 00       	call   801c73 <sys_calculate_free_frames>
  8002ca:	89 45 cc             	mov    %eax,-0x34(%ebp)
		w = smalloc("w", 3 * PAGE_SIZE+1, 1);
  8002cd:	83 ec 04             	sub    $0x4,%esp
  8002d0:	6a 01                	push   $0x1
  8002d2:	68 01 30 00 00       	push   $0x3001
  8002d7:	68 a0 27 80 00       	push   $0x8027a0
  8002dc:	e8 55 17 00 00       	call   801a36 <smalloc>
  8002e1:	83 c4 10             	add    $0x10,%esp
  8002e4:	89 45 c8             	mov    %eax,-0x38(%ebp)
		u = smalloc("u", PAGE_SIZE, 1);
  8002e7:	83 ec 04             	sub    $0x4,%esp
  8002ea:	6a 01                	push   $0x1
  8002ec:	68 00 10 00 00       	push   $0x1000
  8002f1:	68 a2 27 80 00       	push   $0x8027a2
  8002f6:	e8 3b 17 00 00       	call   801a36 <smalloc>
  8002fb:	83 c4 10             	add    $0x10,%esp
  8002fe:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 5+1+4) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800301:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800304:	e8 6a 19 00 00       	call   801c73 <sys_calculate_free_frames>
  800309:	29 c3                	sub    %eax,%ebx
  80030b:	89 d8                	mov    %ebx,%eax
  80030d:	83 f8 0a             	cmp    $0xa,%eax
  800310:	74 14                	je     800326 <_main+0x2ee>
  800312:	83 ec 04             	sub    $0x4,%esp
  800315:	68 78 25 80 00       	push   $0x802578
  80031a:	6a 45                	push   $0x45
  80031c:	68 fc 23 80 00       	push   $0x8023fc
  800321:	e8 83 03 00 00       	call   8006a9 <_panic>

		sfree(w);
  800326:	83 ec 0c             	sub    $0xc,%esp
  800329:	ff 75 c8             	pushl  -0x38(%ebp)
  80032c:	e8 45 17 00 00       	call   801a76 <sfree>
  800331:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  800334:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800337:	e8 37 19 00 00       	call   801c73 <sys_calculate_free_frames>
  80033c:	29 c3                	sub    %eax,%ebx
  80033e:	89 d8                	mov    %ebx,%eax
  800340:	83 f8 04             	cmp    $0x4,%eax
  800343:	74 14                	je     800359 <_main+0x321>
  800345:	83 ec 04             	sub    $0x4,%esp
  800348:	68 2d 27 80 00       	push   $0x80272d
  80034d:	6a 48                	push   $0x48
  80034f:	68 fc 23 80 00       	push   $0x8023fc
  800354:	e8 50 03 00 00       	call   8006a9 <_panic>

		uint32 *o;

		o = smalloc("o", 2 * PAGE_SIZE-1,1);
  800359:	83 ec 04             	sub    $0x4,%esp
  80035c:	6a 01                	push   $0x1
  80035e:	68 ff 1f 00 00       	push   $0x1fff
  800363:	68 a4 27 80 00       	push   $0x8027a4
  800368:	e8 c9 16 00 00       	call   801a36 <smalloc>
  80036d:	83 c4 10             	add    $0x10,%esp
  800370:	89 45 c0             	mov    %eax,-0x40(%ebp)

		cprintf("2\n");
  800373:	83 ec 0c             	sub    $0xc,%esp
  800376:	68 a6 27 80 00       	push   $0x8027a6
  80037b:	e8 cb 05 00 00       	call   80094b <cprintf>
  800380:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) != 3+1+4) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800383:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800386:	e8 e8 18 00 00       	call   801c73 <sys_calculate_free_frames>
  80038b:	29 c3                	sub    %eax,%ebx
  80038d:	89 d8                	mov    %ebx,%eax
  80038f:	83 f8 08             	cmp    $0x8,%eax
  800392:	74 14                	je     8003a8 <_main+0x370>
  800394:	83 ec 04             	sub    $0x4,%esp
  800397:	68 78 25 80 00       	push   $0x802578
  80039c:	6a 4f                	push   $0x4f
  80039e:	68 fc 23 80 00       	push   $0x8023fc
  8003a3:	e8 01 03 00 00       	call   8006a9 <_panic>

		sfree(o);
  8003a8:	83 ec 0c             	sub    $0xc,%esp
  8003ab:	ff 75 c0             	pushl  -0x40(%ebp)
  8003ae:	e8 c3 16 00 00       	call   801a76 <sfree>
  8003b3:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  8003b6:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8003b9:	e8 b5 18 00 00       	call   801c73 <sys_calculate_free_frames>
  8003be:	29 c3                	sub    %eax,%ebx
  8003c0:	89 d8                	mov    %ebx,%eax
  8003c2:	83 f8 04             	cmp    $0x4,%eax
  8003c5:	74 14                	je     8003db <_main+0x3a3>
  8003c7:	83 ec 04             	sub    $0x4,%esp
  8003ca:	68 2d 27 80 00       	push   $0x80272d
  8003cf:	6a 52                	push   $0x52
  8003d1:	68 fc 23 80 00       	push   $0x8023fc
  8003d6:	e8 ce 02 00 00       	call   8006a9 <_panic>

		sfree(u);
  8003db:	83 ec 0c             	sub    $0xc,%esp
  8003de:	ff 75 c4             	pushl  -0x3c(%ebp)
  8003e1:	e8 90 16 00 00       	call   801a76 <sfree>
  8003e6:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  8003e9:	e8 85 18 00 00       	call   801c73 <sys_calculate_free_frames>
  8003ee:	89 c2                	mov    %eax,%edx
  8003f0:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8003f3:	39 c2                	cmp    %eax,%edx
  8003f5:	74 14                	je     80040b <_main+0x3d3>
  8003f7:	83 ec 04             	sub    $0x4,%esp
  8003fa:	68 2d 27 80 00       	push   $0x80272d
  8003ff:	6a 55                	push   $0x55
  800401:	68 fc 23 80 00       	push   $0x8023fc
  800406:	e8 9e 02 00 00       	call   8006a9 <_panic>


		//Checking boundaries of page tables
		freeFrames = sys_calculate_free_frames() ;
  80040b:	e8 63 18 00 00       	call   801c73 <sys_calculate_free_frames>
  800410:	89 45 cc             	mov    %eax,-0x34(%ebp)
		w = smalloc("w", 3 * Mega - 1*kilo, 1);
  800413:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800416:	89 c2                	mov    %eax,%edx
  800418:	01 d2                	add    %edx,%edx
  80041a:	01 d0                	add    %edx,%eax
  80041c:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80041f:	83 ec 04             	sub    $0x4,%esp
  800422:	6a 01                	push   $0x1
  800424:	50                   	push   %eax
  800425:	68 a0 27 80 00       	push   $0x8027a0
  80042a:	e8 07 16 00 00       	call   801a36 <smalloc>
  80042f:	83 c4 10             	add    $0x10,%esp
  800432:	89 45 c8             	mov    %eax,-0x38(%ebp)
		u = smalloc("u", 7 * Mega - 1*kilo, 1);
  800435:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800438:	89 d0                	mov    %edx,%eax
  80043a:	01 c0                	add    %eax,%eax
  80043c:	01 d0                	add    %edx,%eax
  80043e:	01 c0                	add    %eax,%eax
  800440:	01 d0                	add    %edx,%eax
  800442:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800445:	83 ec 04             	sub    $0x4,%esp
  800448:	6a 01                	push   $0x1
  80044a:	50                   	push   %eax
  80044b:	68 a2 27 80 00       	push   $0x8027a2
  800450:	e8 e1 15 00 00       	call   801a36 <smalloc>
  800455:	83 c4 10             	add    $0x10,%esp
  800458:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		o = smalloc("o", 2 * Mega + 1*kilo, 1);
  80045b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80045e:	01 c0                	add    %eax,%eax
  800460:	89 c2                	mov    %eax,%edx
  800462:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800465:	01 d0                	add    %edx,%eax
  800467:	83 ec 04             	sub    $0x4,%esp
  80046a:	6a 01                	push   $0x1
  80046c:	50                   	push   %eax
  80046d:	68 a4 27 80 00       	push   $0x8027a4
  800472:	e8 bf 15 00 00       	call   801a36 <smalloc>
  800477:	83 c4 10             	add    $0x10,%esp
  80047a:	89 45 c0             	mov    %eax,-0x40(%ebp)

		if ((freeFrames - sys_calculate_free_frames()) != 3073+4+7) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80047d:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800480:	e8 ee 17 00 00       	call   801c73 <sys_calculate_free_frames>
  800485:	29 c3                	sub    %eax,%ebx
  800487:	89 d8                	mov    %ebx,%eax
  800489:	3d 0c 0c 00 00       	cmp    $0xc0c,%eax
  80048e:	74 14                	je     8004a4 <_main+0x46c>
  800490:	83 ec 04             	sub    $0x4,%esp
  800493:	68 78 25 80 00       	push   $0x802578
  800498:	6a 5e                	push   $0x5e
  80049a:	68 fc 23 80 00       	push   $0x8023fc
  80049f:	e8 05 02 00 00       	call   8006a9 <_panic>

		sfree(o);
  8004a4:	83 ec 0c             	sub    $0xc,%esp
  8004a7:	ff 75 c0             	pushl  -0x40(%ebp)
  8004aa:	e8 c7 15 00 00       	call   801a76 <sfree>
  8004af:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  2560+3+5) panic("Wrong free: check your logic");
  8004b2:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8004b5:	e8 b9 17 00 00       	call   801c73 <sys_calculate_free_frames>
  8004ba:	29 c3                	sub    %eax,%ebx
  8004bc:	89 d8                	mov    %ebx,%eax
  8004be:	3d 08 0a 00 00       	cmp    $0xa08,%eax
  8004c3:	74 14                	je     8004d9 <_main+0x4a1>
  8004c5:	83 ec 04             	sub    $0x4,%esp
  8004c8:	68 2d 27 80 00       	push   $0x80272d
  8004cd:	6a 61                	push   $0x61
  8004cf:	68 fc 23 80 00       	push   $0x8023fc
  8004d4:	e8 d0 01 00 00       	call   8006a9 <_panic>

		sfree(w);
  8004d9:	83 ec 0c             	sub    $0xc,%esp
  8004dc:	ff 75 c8             	pushl  -0x38(%ebp)
  8004df:	e8 92 15 00 00       	call   801a76 <sfree>
  8004e4:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1792+3+3) panic("Wrong free: check your logic");
  8004e7:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8004ea:	e8 84 17 00 00       	call   801c73 <sys_calculate_free_frames>
  8004ef:	29 c3                	sub    %eax,%ebx
  8004f1:	89 d8                	mov    %ebx,%eax
  8004f3:	3d 06 07 00 00       	cmp    $0x706,%eax
  8004f8:	74 14                	je     80050e <_main+0x4d6>
  8004fa:	83 ec 04             	sub    $0x4,%esp
  8004fd:	68 2d 27 80 00       	push   $0x80272d
  800502:	6a 64                	push   $0x64
  800504:	68 fc 23 80 00       	push   $0x8023fc
  800509:	e8 9b 01 00 00       	call   8006a9 <_panic>

		sfree(u);
  80050e:	83 ec 0c             	sub    $0xc,%esp
  800511:	ff 75 c4             	pushl  -0x3c(%ebp)
  800514:	e8 5d 15 00 00       	call   801a76 <sfree>
  800519:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  80051c:	e8 52 17 00 00       	call   801c73 <sys_calculate_free_frames>
  800521:	89 c2                	mov    %eax,%edx
  800523:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800526:	39 c2                	cmp    %eax,%edx
  800528:	74 14                	je     80053e <_main+0x506>
  80052a:	83 ec 04             	sub    $0x4,%esp
  80052d:	68 2d 27 80 00       	push   $0x80272d
  800532:	6a 67                	push   $0x67
  800534:	68 fc 23 80 00       	push   $0x8023fc
  800539:	e8 6b 01 00 00       	call   8006a9 <_panic>
	}
	cprintf("Step C completed successfully!!\n\n\n");
  80053e:	83 ec 0c             	sub    $0xc,%esp
  800541:	68 ac 27 80 00       	push   $0x8027ac
  800546:	e8 00 04 00 00       	call   80094b <cprintf>
  80054b:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! Test of freeSharedObjects [4] completed successfully!!\n\n\n");
  80054e:	83 ec 0c             	sub    $0xc,%esp
  800551:	68 d0 27 80 00       	push   $0x8027d0
  800556:	e8 f0 03 00 00       	call   80094b <cprintf>
  80055b:	83 c4 10             	add    $0x10,%esp

	return;
  80055e:	90                   	nop
}
  80055f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800562:	c9                   	leave  
  800563:	c3                   	ret    

00800564 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800564:	55                   	push   %ebp
  800565:	89 e5                	mov    %esp,%ebp
  800567:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80056a:	e8 39 16 00 00       	call   801ba8 <sys_getenvindex>
  80056f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800572:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800575:	89 d0                	mov    %edx,%eax
  800577:	c1 e0 03             	shl    $0x3,%eax
  80057a:	01 d0                	add    %edx,%eax
  80057c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800583:	01 c8                	add    %ecx,%eax
  800585:	01 c0                	add    %eax,%eax
  800587:	01 d0                	add    %edx,%eax
  800589:	01 c0                	add    %eax,%eax
  80058b:	01 d0                	add    %edx,%eax
  80058d:	89 c2                	mov    %eax,%edx
  80058f:	c1 e2 05             	shl    $0x5,%edx
  800592:	29 c2                	sub    %eax,%edx
  800594:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80059b:	89 c2                	mov    %eax,%edx
  80059d:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8005a3:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ad:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8005b3:	84 c0                	test   %al,%al
  8005b5:	74 0f                	je     8005c6 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8005b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8005bc:	05 40 3c 01 00       	add    $0x13c40,%eax
  8005c1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005c6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005ca:	7e 0a                	jle    8005d6 <libmain+0x72>
		binaryname = argv[0];
  8005cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005cf:	8b 00                	mov    (%eax),%eax
  8005d1:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8005d6:	83 ec 08             	sub    $0x8,%esp
  8005d9:	ff 75 0c             	pushl  0xc(%ebp)
  8005dc:	ff 75 08             	pushl  0x8(%ebp)
  8005df:	e8 54 fa ff ff       	call   800038 <_main>
  8005e4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8005e7:	e8 57 17 00 00       	call   801d43 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8005ec:	83 ec 0c             	sub    $0xc,%esp
  8005ef:	68 34 28 80 00       	push   $0x802834
  8005f4:	e8 52 03 00 00       	call   80094b <cprintf>
  8005f9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8005fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800601:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800607:	a1 20 30 80 00       	mov    0x803020,%eax
  80060c:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800612:	83 ec 04             	sub    $0x4,%esp
  800615:	52                   	push   %edx
  800616:	50                   	push   %eax
  800617:	68 5c 28 80 00       	push   $0x80285c
  80061c:	e8 2a 03 00 00       	call   80094b <cprintf>
  800621:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800624:	a1 20 30 80 00       	mov    0x803020,%eax
  800629:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80062f:	a1 20 30 80 00       	mov    0x803020,%eax
  800634:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80063a:	83 ec 04             	sub    $0x4,%esp
  80063d:	52                   	push   %edx
  80063e:	50                   	push   %eax
  80063f:	68 84 28 80 00       	push   $0x802884
  800644:	e8 02 03 00 00       	call   80094b <cprintf>
  800649:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80064c:	a1 20 30 80 00       	mov    0x803020,%eax
  800651:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800657:	83 ec 08             	sub    $0x8,%esp
  80065a:	50                   	push   %eax
  80065b:	68 c5 28 80 00       	push   $0x8028c5
  800660:	e8 e6 02 00 00       	call   80094b <cprintf>
  800665:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800668:	83 ec 0c             	sub    $0xc,%esp
  80066b:	68 34 28 80 00       	push   $0x802834
  800670:	e8 d6 02 00 00       	call   80094b <cprintf>
  800675:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800678:	e8 e0 16 00 00       	call   801d5d <sys_enable_interrupt>

	// exit gracefully
	exit();
  80067d:	e8 19 00 00 00       	call   80069b <exit>
}
  800682:	90                   	nop
  800683:	c9                   	leave  
  800684:	c3                   	ret    

00800685 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800685:	55                   	push   %ebp
  800686:	89 e5                	mov    %esp,%ebp
  800688:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80068b:	83 ec 0c             	sub    $0xc,%esp
  80068e:	6a 00                	push   $0x0
  800690:	e8 df 14 00 00       	call   801b74 <sys_env_destroy>
  800695:	83 c4 10             	add    $0x10,%esp
}
  800698:	90                   	nop
  800699:	c9                   	leave  
  80069a:	c3                   	ret    

0080069b <exit>:

void
exit(void)
{
  80069b:	55                   	push   %ebp
  80069c:	89 e5                	mov    %esp,%ebp
  80069e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006a1:	e8 34 15 00 00       	call   801bda <sys_env_exit>
}
  8006a6:	90                   	nop
  8006a7:	c9                   	leave  
  8006a8:	c3                   	ret    

008006a9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006a9:	55                   	push   %ebp
  8006aa:	89 e5                	mov    %esp,%ebp
  8006ac:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006af:	8d 45 10             	lea    0x10(%ebp),%eax
  8006b2:	83 c0 04             	add    $0x4,%eax
  8006b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006b8:	a1 18 31 80 00       	mov    0x803118,%eax
  8006bd:	85 c0                	test   %eax,%eax
  8006bf:	74 16                	je     8006d7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006c1:	a1 18 31 80 00       	mov    0x803118,%eax
  8006c6:	83 ec 08             	sub    $0x8,%esp
  8006c9:	50                   	push   %eax
  8006ca:	68 dc 28 80 00       	push   $0x8028dc
  8006cf:	e8 77 02 00 00       	call   80094b <cprintf>
  8006d4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006d7:	a1 00 30 80 00       	mov    0x803000,%eax
  8006dc:	ff 75 0c             	pushl  0xc(%ebp)
  8006df:	ff 75 08             	pushl  0x8(%ebp)
  8006e2:	50                   	push   %eax
  8006e3:	68 e1 28 80 00       	push   $0x8028e1
  8006e8:	e8 5e 02 00 00       	call   80094b <cprintf>
  8006ed:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8006f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8006f3:	83 ec 08             	sub    $0x8,%esp
  8006f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8006f9:	50                   	push   %eax
  8006fa:	e8 e1 01 00 00       	call   8008e0 <vcprintf>
  8006ff:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800702:	83 ec 08             	sub    $0x8,%esp
  800705:	6a 00                	push   $0x0
  800707:	68 fd 28 80 00       	push   $0x8028fd
  80070c:	e8 cf 01 00 00       	call   8008e0 <vcprintf>
  800711:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800714:	e8 82 ff ff ff       	call   80069b <exit>

	// should not return here
	while (1) ;
  800719:	eb fe                	jmp    800719 <_panic+0x70>

0080071b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80071b:	55                   	push   %ebp
  80071c:	89 e5                	mov    %esp,%ebp
  80071e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800721:	a1 20 30 80 00       	mov    0x803020,%eax
  800726:	8b 50 74             	mov    0x74(%eax),%edx
  800729:	8b 45 0c             	mov    0xc(%ebp),%eax
  80072c:	39 c2                	cmp    %eax,%edx
  80072e:	74 14                	je     800744 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800730:	83 ec 04             	sub    $0x4,%esp
  800733:	68 00 29 80 00       	push   $0x802900
  800738:	6a 26                	push   $0x26
  80073a:	68 4c 29 80 00       	push   $0x80294c
  80073f:	e8 65 ff ff ff       	call   8006a9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800744:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80074b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800752:	e9 b6 00 00 00       	jmp    80080d <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800757:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80075a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800761:	8b 45 08             	mov    0x8(%ebp),%eax
  800764:	01 d0                	add    %edx,%eax
  800766:	8b 00                	mov    (%eax),%eax
  800768:	85 c0                	test   %eax,%eax
  80076a:	75 08                	jne    800774 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80076c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80076f:	e9 96 00 00 00       	jmp    80080a <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800774:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80077b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800782:	eb 5d                	jmp    8007e1 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800784:	a1 20 30 80 00       	mov    0x803020,%eax
  800789:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80078f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800792:	c1 e2 04             	shl    $0x4,%edx
  800795:	01 d0                	add    %edx,%eax
  800797:	8a 40 04             	mov    0x4(%eax),%al
  80079a:	84 c0                	test   %al,%al
  80079c:	75 40                	jne    8007de <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80079e:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007a9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ac:	c1 e2 04             	shl    $0x4,%edx
  8007af:	01 d0                	add    %edx,%eax
  8007b1:	8b 00                	mov    (%eax),%eax
  8007b3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007b9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007be:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cd:	01 c8                	add    %ecx,%eax
  8007cf:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007d1:	39 c2                	cmp    %eax,%edx
  8007d3:	75 09                	jne    8007de <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8007d5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8007dc:	eb 12                	jmp    8007f0 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007de:	ff 45 e8             	incl   -0x18(%ebp)
  8007e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e6:	8b 50 74             	mov    0x74(%eax),%edx
  8007e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007ec:	39 c2                	cmp    %eax,%edx
  8007ee:	77 94                	ja     800784 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8007f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8007f4:	75 14                	jne    80080a <CheckWSWithoutLastIndex+0xef>
			panic(
  8007f6:	83 ec 04             	sub    $0x4,%esp
  8007f9:	68 58 29 80 00       	push   $0x802958
  8007fe:	6a 3a                	push   $0x3a
  800800:	68 4c 29 80 00       	push   $0x80294c
  800805:	e8 9f fe ff ff       	call   8006a9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80080a:	ff 45 f0             	incl   -0x10(%ebp)
  80080d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800810:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800813:	0f 8c 3e ff ff ff    	jl     800757 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800819:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800820:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800827:	eb 20                	jmp    800849 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800829:	a1 20 30 80 00       	mov    0x803020,%eax
  80082e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800834:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800837:	c1 e2 04             	shl    $0x4,%edx
  80083a:	01 d0                	add    %edx,%eax
  80083c:	8a 40 04             	mov    0x4(%eax),%al
  80083f:	3c 01                	cmp    $0x1,%al
  800841:	75 03                	jne    800846 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800843:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800846:	ff 45 e0             	incl   -0x20(%ebp)
  800849:	a1 20 30 80 00       	mov    0x803020,%eax
  80084e:	8b 50 74             	mov    0x74(%eax),%edx
  800851:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800854:	39 c2                	cmp    %eax,%edx
  800856:	77 d1                	ja     800829 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800858:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80085b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80085e:	74 14                	je     800874 <CheckWSWithoutLastIndex+0x159>
		panic(
  800860:	83 ec 04             	sub    $0x4,%esp
  800863:	68 ac 29 80 00       	push   $0x8029ac
  800868:	6a 44                	push   $0x44
  80086a:	68 4c 29 80 00       	push   $0x80294c
  80086f:	e8 35 fe ff ff       	call   8006a9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800874:	90                   	nop
  800875:	c9                   	leave  
  800876:	c3                   	ret    

00800877 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800877:	55                   	push   %ebp
  800878:	89 e5                	mov    %esp,%ebp
  80087a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80087d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800880:	8b 00                	mov    (%eax),%eax
  800882:	8d 48 01             	lea    0x1(%eax),%ecx
  800885:	8b 55 0c             	mov    0xc(%ebp),%edx
  800888:	89 0a                	mov    %ecx,(%edx)
  80088a:	8b 55 08             	mov    0x8(%ebp),%edx
  80088d:	88 d1                	mov    %dl,%cl
  80088f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800892:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800896:	8b 45 0c             	mov    0xc(%ebp),%eax
  800899:	8b 00                	mov    (%eax),%eax
  80089b:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008a0:	75 2c                	jne    8008ce <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008a2:	a0 24 30 80 00       	mov    0x803024,%al
  8008a7:	0f b6 c0             	movzbl %al,%eax
  8008aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ad:	8b 12                	mov    (%edx),%edx
  8008af:	89 d1                	mov    %edx,%ecx
  8008b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b4:	83 c2 08             	add    $0x8,%edx
  8008b7:	83 ec 04             	sub    $0x4,%esp
  8008ba:	50                   	push   %eax
  8008bb:	51                   	push   %ecx
  8008bc:	52                   	push   %edx
  8008bd:	e8 70 12 00 00       	call   801b32 <sys_cputs>
  8008c2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d1:	8b 40 04             	mov    0x4(%eax),%eax
  8008d4:	8d 50 01             	lea    0x1(%eax),%edx
  8008d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008da:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008dd:	90                   	nop
  8008de:	c9                   	leave  
  8008df:	c3                   	ret    

008008e0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8008e0:	55                   	push   %ebp
  8008e1:	89 e5                	mov    %esp,%ebp
  8008e3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8008e9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8008f0:	00 00 00 
	b.cnt = 0;
  8008f3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8008fa:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8008fd:	ff 75 0c             	pushl  0xc(%ebp)
  800900:	ff 75 08             	pushl  0x8(%ebp)
  800903:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800909:	50                   	push   %eax
  80090a:	68 77 08 80 00       	push   $0x800877
  80090f:	e8 11 02 00 00       	call   800b25 <vprintfmt>
  800914:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800917:	a0 24 30 80 00       	mov    0x803024,%al
  80091c:	0f b6 c0             	movzbl %al,%eax
  80091f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800925:	83 ec 04             	sub    $0x4,%esp
  800928:	50                   	push   %eax
  800929:	52                   	push   %edx
  80092a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800930:	83 c0 08             	add    $0x8,%eax
  800933:	50                   	push   %eax
  800934:	e8 f9 11 00 00       	call   801b32 <sys_cputs>
  800939:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80093c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800943:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800949:	c9                   	leave  
  80094a:	c3                   	ret    

0080094b <cprintf>:

int cprintf(const char *fmt, ...) {
  80094b:	55                   	push   %ebp
  80094c:	89 e5                	mov    %esp,%ebp
  80094e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800951:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800958:	8d 45 0c             	lea    0xc(%ebp),%eax
  80095b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80095e:	8b 45 08             	mov    0x8(%ebp),%eax
  800961:	83 ec 08             	sub    $0x8,%esp
  800964:	ff 75 f4             	pushl  -0xc(%ebp)
  800967:	50                   	push   %eax
  800968:	e8 73 ff ff ff       	call   8008e0 <vcprintf>
  80096d:	83 c4 10             	add    $0x10,%esp
  800970:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800973:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800976:	c9                   	leave  
  800977:	c3                   	ret    

00800978 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800978:	55                   	push   %ebp
  800979:	89 e5                	mov    %esp,%ebp
  80097b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80097e:	e8 c0 13 00 00       	call   801d43 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800983:	8d 45 0c             	lea    0xc(%ebp),%eax
  800986:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800989:	8b 45 08             	mov    0x8(%ebp),%eax
  80098c:	83 ec 08             	sub    $0x8,%esp
  80098f:	ff 75 f4             	pushl  -0xc(%ebp)
  800992:	50                   	push   %eax
  800993:	e8 48 ff ff ff       	call   8008e0 <vcprintf>
  800998:	83 c4 10             	add    $0x10,%esp
  80099b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80099e:	e8 ba 13 00 00       	call   801d5d <sys_enable_interrupt>
	return cnt;
  8009a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009a6:	c9                   	leave  
  8009a7:	c3                   	ret    

008009a8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009a8:	55                   	push   %ebp
  8009a9:	89 e5                	mov    %esp,%ebp
  8009ab:	53                   	push   %ebx
  8009ac:	83 ec 14             	sub    $0x14,%esp
  8009af:	8b 45 10             	mov    0x10(%ebp),%eax
  8009b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009bb:	8b 45 18             	mov    0x18(%ebp),%eax
  8009be:	ba 00 00 00 00       	mov    $0x0,%edx
  8009c3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009c6:	77 55                	ja     800a1d <printnum+0x75>
  8009c8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009cb:	72 05                	jb     8009d2 <printnum+0x2a>
  8009cd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009d0:	77 4b                	ja     800a1d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009d2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009d5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8009d8:	8b 45 18             	mov    0x18(%ebp),%eax
  8009db:	ba 00 00 00 00       	mov    $0x0,%edx
  8009e0:	52                   	push   %edx
  8009e1:	50                   	push   %eax
  8009e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e5:	ff 75 f0             	pushl  -0x10(%ebp)
  8009e8:	e8 77 17 00 00       	call   802164 <__udivdi3>
  8009ed:	83 c4 10             	add    $0x10,%esp
  8009f0:	83 ec 04             	sub    $0x4,%esp
  8009f3:	ff 75 20             	pushl  0x20(%ebp)
  8009f6:	53                   	push   %ebx
  8009f7:	ff 75 18             	pushl  0x18(%ebp)
  8009fa:	52                   	push   %edx
  8009fb:	50                   	push   %eax
  8009fc:	ff 75 0c             	pushl  0xc(%ebp)
  8009ff:	ff 75 08             	pushl  0x8(%ebp)
  800a02:	e8 a1 ff ff ff       	call   8009a8 <printnum>
  800a07:	83 c4 20             	add    $0x20,%esp
  800a0a:	eb 1a                	jmp    800a26 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a0c:	83 ec 08             	sub    $0x8,%esp
  800a0f:	ff 75 0c             	pushl  0xc(%ebp)
  800a12:	ff 75 20             	pushl  0x20(%ebp)
  800a15:	8b 45 08             	mov    0x8(%ebp),%eax
  800a18:	ff d0                	call   *%eax
  800a1a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a1d:	ff 4d 1c             	decl   0x1c(%ebp)
  800a20:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a24:	7f e6                	jg     800a0c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a26:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a29:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a31:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a34:	53                   	push   %ebx
  800a35:	51                   	push   %ecx
  800a36:	52                   	push   %edx
  800a37:	50                   	push   %eax
  800a38:	e8 37 18 00 00       	call   802274 <__umoddi3>
  800a3d:	83 c4 10             	add    $0x10,%esp
  800a40:	05 14 2c 80 00       	add    $0x802c14,%eax
  800a45:	8a 00                	mov    (%eax),%al
  800a47:	0f be c0             	movsbl %al,%eax
  800a4a:	83 ec 08             	sub    $0x8,%esp
  800a4d:	ff 75 0c             	pushl  0xc(%ebp)
  800a50:	50                   	push   %eax
  800a51:	8b 45 08             	mov    0x8(%ebp),%eax
  800a54:	ff d0                	call   *%eax
  800a56:	83 c4 10             	add    $0x10,%esp
}
  800a59:	90                   	nop
  800a5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a5d:	c9                   	leave  
  800a5e:	c3                   	ret    

00800a5f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a5f:	55                   	push   %ebp
  800a60:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a62:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a66:	7e 1c                	jle    800a84 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a68:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6b:	8b 00                	mov    (%eax),%eax
  800a6d:	8d 50 08             	lea    0x8(%eax),%edx
  800a70:	8b 45 08             	mov    0x8(%ebp),%eax
  800a73:	89 10                	mov    %edx,(%eax)
  800a75:	8b 45 08             	mov    0x8(%ebp),%eax
  800a78:	8b 00                	mov    (%eax),%eax
  800a7a:	83 e8 08             	sub    $0x8,%eax
  800a7d:	8b 50 04             	mov    0x4(%eax),%edx
  800a80:	8b 00                	mov    (%eax),%eax
  800a82:	eb 40                	jmp    800ac4 <getuint+0x65>
	else if (lflag)
  800a84:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a88:	74 1e                	je     800aa8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	8b 00                	mov    (%eax),%eax
  800a8f:	8d 50 04             	lea    0x4(%eax),%edx
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
  800a95:	89 10                	mov    %edx,(%eax)
  800a97:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9a:	8b 00                	mov    (%eax),%eax
  800a9c:	83 e8 04             	sub    $0x4,%eax
  800a9f:	8b 00                	mov    (%eax),%eax
  800aa1:	ba 00 00 00 00       	mov    $0x0,%edx
  800aa6:	eb 1c                	jmp    800ac4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	8b 00                	mov    (%eax),%eax
  800aad:	8d 50 04             	lea    0x4(%eax),%edx
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	89 10                	mov    %edx,(%eax)
  800ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab8:	8b 00                	mov    (%eax),%eax
  800aba:	83 e8 04             	sub    $0x4,%eax
  800abd:	8b 00                	mov    (%eax),%eax
  800abf:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800ac4:	5d                   	pop    %ebp
  800ac5:	c3                   	ret    

00800ac6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ac6:	55                   	push   %ebp
  800ac7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ac9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800acd:	7e 1c                	jle    800aeb <getint+0x25>
		return va_arg(*ap, long long);
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	8b 00                	mov    (%eax),%eax
  800ad4:	8d 50 08             	lea    0x8(%eax),%edx
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	89 10                	mov    %edx,(%eax)
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	8b 00                	mov    (%eax),%eax
  800ae1:	83 e8 08             	sub    $0x8,%eax
  800ae4:	8b 50 04             	mov    0x4(%eax),%edx
  800ae7:	8b 00                	mov    (%eax),%eax
  800ae9:	eb 38                	jmp    800b23 <getint+0x5d>
	else if (lflag)
  800aeb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aef:	74 1a                	je     800b0b <getint+0x45>
		return va_arg(*ap, long);
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	8b 00                	mov    (%eax),%eax
  800af6:	8d 50 04             	lea    0x4(%eax),%edx
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
  800afc:	89 10                	mov    %edx,(%eax)
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
  800b01:	8b 00                	mov    (%eax),%eax
  800b03:	83 e8 04             	sub    $0x4,%eax
  800b06:	8b 00                	mov    (%eax),%eax
  800b08:	99                   	cltd   
  800b09:	eb 18                	jmp    800b23 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0e:	8b 00                	mov    (%eax),%eax
  800b10:	8d 50 04             	lea    0x4(%eax),%edx
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
  800b16:	89 10                	mov    %edx,(%eax)
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	8b 00                	mov    (%eax),%eax
  800b1d:	83 e8 04             	sub    $0x4,%eax
  800b20:	8b 00                	mov    (%eax),%eax
  800b22:	99                   	cltd   
}
  800b23:	5d                   	pop    %ebp
  800b24:	c3                   	ret    

00800b25 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b25:	55                   	push   %ebp
  800b26:	89 e5                	mov    %esp,%ebp
  800b28:	56                   	push   %esi
  800b29:	53                   	push   %ebx
  800b2a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b2d:	eb 17                	jmp    800b46 <vprintfmt+0x21>
			if (ch == '\0')
  800b2f:	85 db                	test   %ebx,%ebx
  800b31:	0f 84 af 03 00 00    	je     800ee6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b37:	83 ec 08             	sub    $0x8,%esp
  800b3a:	ff 75 0c             	pushl  0xc(%ebp)
  800b3d:	53                   	push   %ebx
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	ff d0                	call   *%eax
  800b43:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b46:	8b 45 10             	mov    0x10(%ebp),%eax
  800b49:	8d 50 01             	lea    0x1(%eax),%edx
  800b4c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b4f:	8a 00                	mov    (%eax),%al
  800b51:	0f b6 d8             	movzbl %al,%ebx
  800b54:	83 fb 25             	cmp    $0x25,%ebx
  800b57:	75 d6                	jne    800b2f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b59:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b5d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b64:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b6b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b72:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b79:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7c:	8d 50 01             	lea    0x1(%eax),%edx
  800b7f:	89 55 10             	mov    %edx,0x10(%ebp)
  800b82:	8a 00                	mov    (%eax),%al
  800b84:	0f b6 d8             	movzbl %al,%ebx
  800b87:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800b8a:	83 f8 55             	cmp    $0x55,%eax
  800b8d:	0f 87 2b 03 00 00    	ja     800ebe <vprintfmt+0x399>
  800b93:	8b 04 85 38 2c 80 00 	mov    0x802c38(,%eax,4),%eax
  800b9a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800b9c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ba0:	eb d7                	jmp    800b79 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ba2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ba6:	eb d1                	jmp    800b79 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ba8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800baf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bb2:	89 d0                	mov    %edx,%eax
  800bb4:	c1 e0 02             	shl    $0x2,%eax
  800bb7:	01 d0                	add    %edx,%eax
  800bb9:	01 c0                	add    %eax,%eax
  800bbb:	01 d8                	add    %ebx,%eax
  800bbd:	83 e8 30             	sub    $0x30,%eax
  800bc0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc6:	8a 00                	mov    (%eax),%al
  800bc8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bcb:	83 fb 2f             	cmp    $0x2f,%ebx
  800bce:	7e 3e                	jle    800c0e <vprintfmt+0xe9>
  800bd0:	83 fb 39             	cmp    $0x39,%ebx
  800bd3:	7f 39                	jg     800c0e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bd5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800bd8:	eb d5                	jmp    800baf <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800bda:	8b 45 14             	mov    0x14(%ebp),%eax
  800bdd:	83 c0 04             	add    $0x4,%eax
  800be0:	89 45 14             	mov    %eax,0x14(%ebp)
  800be3:	8b 45 14             	mov    0x14(%ebp),%eax
  800be6:	83 e8 04             	sub    $0x4,%eax
  800be9:	8b 00                	mov    (%eax),%eax
  800beb:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800bee:	eb 1f                	jmp    800c0f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800bf0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bf4:	79 83                	jns    800b79 <vprintfmt+0x54>
				width = 0;
  800bf6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800bfd:	e9 77 ff ff ff       	jmp    800b79 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c02:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c09:	e9 6b ff ff ff       	jmp    800b79 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c0e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c0f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c13:	0f 89 60 ff ff ff    	jns    800b79 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c19:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c1f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c26:	e9 4e ff ff ff       	jmp    800b79 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c2b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c2e:	e9 46 ff ff ff       	jmp    800b79 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c33:	8b 45 14             	mov    0x14(%ebp),%eax
  800c36:	83 c0 04             	add    $0x4,%eax
  800c39:	89 45 14             	mov    %eax,0x14(%ebp)
  800c3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c3f:	83 e8 04             	sub    $0x4,%eax
  800c42:	8b 00                	mov    (%eax),%eax
  800c44:	83 ec 08             	sub    $0x8,%esp
  800c47:	ff 75 0c             	pushl  0xc(%ebp)
  800c4a:	50                   	push   %eax
  800c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4e:	ff d0                	call   *%eax
  800c50:	83 c4 10             	add    $0x10,%esp
			break;
  800c53:	e9 89 02 00 00       	jmp    800ee1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c58:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5b:	83 c0 04             	add    $0x4,%eax
  800c5e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c61:	8b 45 14             	mov    0x14(%ebp),%eax
  800c64:	83 e8 04             	sub    $0x4,%eax
  800c67:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c69:	85 db                	test   %ebx,%ebx
  800c6b:	79 02                	jns    800c6f <vprintfmt+0x14a>
				err = -err;
  800c6d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c6f:	83 fb 64             	cmp    $0x64,%ebx
  800c72:	7f 0b                	jg     800c7f <vprintfmt+0x15a>
  800c74:	8b 34 9d 80 2a 80 00 	mov    0x802a80(,%ebx,4),%esi
  800c7b:	85 f6                	test   %esi,%esi
  800c7d:	75 19                	jne    800c98 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c7f:	53                   	push   %ebx
  800c80:	68 25 2c 80 00       	push   $0x802c25
  800c85:	ff 75 0c             	pushl  0xc(%ebp)
  800c88:	ff 75 08             	pushl  0x8(%ebp)
  800c8b:	e8 5e 02 00 00       	call   800eee <printfmt>
  800c90:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800c93:	e9 49 02 00 00       	jmp    800ee1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800c98:	56                   	push   %esi
  800c99:	68 2e 2c 80 00       	push   $0x802c2e
  800c9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ca1:	ff 75 08             	pushl  0x8(%ebp)
  800ca4:	e8 45 02 00 00       	call   800eee <printfmt>
  800ca9:	83 c4 10             	add    $0x10,%esp
			break;
  800cac:	e9 30 02 00 00       	jmp    800ee1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb4:	83 c0 04             	add    $0x4,%eax
  800cb7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cba:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbd:	83 e8 04             	sub    $0x4,%eax
  800cc0:	8b 30                	mov    (%eax),%esi
  800cc2:	85 f6                	test   %esi,%esi
  800cc4:	75 05                	jne    800ccb <vprintfmt+0x1a6>
				p = "(null)";
  800cc6:	be 31 2c 80 00       	mov    $0x802c31,%esi
			if (width > 0 && padc != '-')
  800ccb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ccf:	7e 6d                	jle    800d3e <vprintfmt+0x219>
  800cd1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800cd5:	74 67                	je     800d3e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800cd7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cda:	83 ec 08             	sub    $0x8,%esp
  800cdd:	50                   	push   %eax
  800cde:	56                   	push   %esi
  800cdf:	e8 0c 03 00 00       	call   800ff0 <strnlen>
  800ce4:	83 c4 10             	add    $0x10,%esp
  800ce7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800cea:	eb 16                	jmp    800d02 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800cec:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800cf0:	83 ec 08             	sub    $0x8,%esp
  800cf3:	ff 75 0c             	pushl  0xc(%ebp)
  800cf6:	50                   	push   %eax
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	ff d0                	call   *%eax
  800cfc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800cff:	ff 4d e4             	decl   -0x1c(%ebp)
  800d02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d06:	7f e4                	jg     800cec <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d08:	eb 34                	jmp    800d3e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d0a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d0e:	74 1c                	je     800d2c <vprintfmt+0x207>
  800d10:	83 fb 1f             	cmp    $0x1f,%ebx
  800d13:	7e 05                	jle    800d1a <vprintfmt+0x1f5>
  800d15:	83 fb 7e             	cmp    $0x7e,%ebx
  800d18:	7e 12                	jle    800d2c <vprintfmt+0x207>
					putch('?', putdat);
  800d1a:	83 ec 08             	sub    $0x8,%esp
  800d1d:	ff 75 0c             	pushl  0xc(%ebp)
  800d20:	6a 3f                	push   $0x3f
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	ff d0                	call   *%eax
  800d27:	83 c4 10             	add    $0x10,%esp
  800d2a:	eb 0f                	jmp    800d3b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d2c:	83 ec 08             	sub    $0x8,%esp
  800d2f:	ff 75 0c             	pushl  0xc(%ebp)
  800d32:	53                   	push   %ebx
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	ff d0                	call   *%eax
  800d38:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d3b:	ff 4d e4             	decl   -0x1c(%ebp)
  800d3e:	89 f0                	mov    %esi,%eax
  800d40:	8d 70 01             	lea    0x1(%eax),%esi
  800d43:	8a 00                	mov    (%eax),%al
  800d45:	0f be d8             	movsbl %al,%ebx
  800d48:	85 db                	test   %ebx,%ebx
  800d4a:	74 24                	je     800d70 <vprintfmt+0x24b>
  800d4c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d50:	78 b8                	js     800d0a <vprintfmt+0x1e5>
  800d52:	ff 4d e0             	decl   -0x20(%ebp)
  800d55:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d59:	79 af                	jns    800d0a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d5b:	eb 13                	jmp    800d70 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d5d:	83 ec 08             	sub    $0x8,%esp
  800d60:	ff 75 0c             	pushl  0xc(%ebp)
  800d63:	6a 20                	push   $0x20
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	ff d0                	call   *%eax
  800d6a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d6d:	ff 4d e4             	decl   -0x1c(%ebp)
  800d70:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d74:	7f e7                	jg     800d5d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d76:	e9 66 01 00 00       	jmp    800ee1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d7b:	83 ec 08             	sub    $0x8,%esp
  800d7e:	ff 75 e8             	pushl  -0x18(%ebp)
  800d81:	8d 45 14             	lea    0x14(%ebp),%eax
  800d84:	50                   	push   %eax
  800d85:	e8 3c fd ff ff       	call   800ac6 <getint>
  800d8a:	83 c4 10             	add    $0x10,%esp
  800d8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d90:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800d93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d99:	85 d2                	test   %edx,%edx
  800d9b:	79 23                	jns    800dc0 <vprintfmt+0x29b>
				putch('-', putdat);
  800d9d:	83 ec 08             	sub    $0x8,%esp
  800da0:	ff 75 0c             	pushl  0xc(%ebp)
  800da3:	6a 2d                	push   $0x2d
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	ff d0                	call   *%eax
  800daa:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800db0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800db3:	f7 d8                	neg    %eax
  800db5:	83 d2 00             	adc    $0x0,%edx
  800db8:	f7 da                	neg    %edx
  800dba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dbd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800dc0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800dc7:	e9 bc 00 00 00       	jmp    800e88 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800dcc:	83 ec 08             	sub    $0x8,%esp
  800dcf:	ff 75 e8             	pushl  -0x18(%ebp)
  800dd2:	8d 45 14             	lea    0x14(%ebp),%eax
  800dd5:	50                   	push   %eax
  800dd6:	e8 84 fc ff ff       	call   800a5f <getuint>
  800ddb:	83 c4 10             	add    $0x10,%esp
  800dde:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800de4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800deb:	e9 98 00 00 00       	jmp    800e88 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800df0:	83 ec 08             	sub    $0x8,%esp
  800df3:	ff 75 0c             	pushl  0xc(%ebp)
  800df6:	6a 58                	push   $0x58
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	ff d0                	call   *%eax
  800dfd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e00:	83 ec 08             	sub    $0x8,%esp
  800e03:	ff 75 0c             	pushl  0xc(%ebp)
  800e06:	6a 58                	push   $0x58
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	ff d0                	call   *%eax
  800e0d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e10:	83 ec 08             	sub    $0x8,%esp
  800e13:	ff 75 0c             	pushl  0xc(%ebp)
  800e16:	6a 58                	push   $0x58
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	ff d0                	call   *%eax
  800e1d:	83 c4 10             	add    $0x10,%esp
			break;
  800e20:	e9 bc 00 00 00       	jmp    800ee1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e25:	83 ec 08             	sub    $0x8,%esp
  800e28:	ff 75 0c             	pushl  0xc(%ebp)
  800e2b:	6a 30                	push   $0x30
  800e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e30:	ff d0                	call   *%eax
  800e32:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e35:	83 ec 08             	sub    $0x8,%esp
  800e38:	ff 75 0c             	pushl  0xc(%ebp)
  800e3b:	6a 78                	push   $0x78
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e40:	ff d0                	call   *%eax
  800e42:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e45:	8b 45 14             	mov    0x14(%ebp),%eax
  800e48:	83 c0 04             	add    $0x4,%eax
  800e4b:	89 45 14             	mov    %eax,0x14(%ebp)
  800e4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e51:	83 e8 04             	sub    $0x4,%eax
  800e54:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e56:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e59:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e60:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e67:	eb 1f                	jmp    800e88 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e69:	83 ec 08             	sub    $0x8,%esp
  800e6c:	ff 75 e8             	pushl  -0x18(%ebp)
  800e6f:	8d 45 14             	lea    0x14(%ebp),%eax
  800e72:	50                   	push   %eax
  800e73:	e8 e7 fb ff ff       	call   800a5f <getuint>
  800e78:	83 c4 10             	add    $0x10,%esp
  800e7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e7e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e81:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800e88:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800e8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e8f:	83 ec 04             	sub    $0x4,%esp
  800e92:	52                   	push   %edx
  800e93:	ff 75 e4             	pushl  -0x1c(%ebp)
  800e96:	50                   	push   %eax
  800e97:	ff 75 f4             	pushl  -0xc(%ebp)
  800e9a:	ff 75 f0             	pushl  -0x10(%ebp)
  800e9d:	ff 75 0c             	pushl  0xc(%ebp)
  800ea0:	ff 75 08             	pushl  0x8(%ebp)
  800ea3:	e8 00 fb ff ff       	call   8009a8 <printnum>
  800ea8:	83 c4 20             	add    $0x20,%esp
			break;
  800eab:	eb 34                	jmp    800ee1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ead:	83 ec 08             	sub    $0x8,%esp
  800eb0:	ff 75 0c             	pushl  0xc(%ebp)
  800eb3:	53                   	push   %ebx
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb7:	ff d0                	call   *%eax
  800eb9:	83 c4 10             	add    $0x10,%esp
			break;
  800ebc:	eb 23                	jmp    800ee1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ebe:	83 ec 08             	sub    $0x8,%esp
  800ec1:	ff 75 0c             	pushl  0xc(%ebp)
  800ec4:	6a 25                	push   $0x25
  800ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec9:	ff d0                	call   *%eax
  800ecb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ece:	ff 4d 10             	decl   0x10(%ebp)
  800ed1:	eb 03                	jmp    800ed6 <vprintfmt+0x3b1>
  800ed3:	ff 4d 10             	decl   0x10(%ebp)
  800ed6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed9:	48                   	dec    %eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	3c 25                	cmp    $0x25,%al
  800ede:	75 f3                	jne    800ed3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ee0:	90                   	nop
		}
	}
  800ee1:	e9 47 fc ff ff       	jmp    800b2d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ee6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ee7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800eea:	5b                   	pop    %ebx
  800eeb:	5e                   	pop    %esi
  800eec:	5d                   	pop    %ebp
  800eed:	c3                   	ret    

00800eee <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800eee:	55                   	push   %ebp
  800eef:	89 e5                	mov    %esp,%ebp
  800ef1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ef4:	8d 45 10             	lea    0x10(%ebp),%eax
  800ef7:	83 c0 04             	add    $0x4,%eax
  800efa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800efd:	8b 45 10             	mov    0x10(%ebp),%eax
  800f00:	ff 75 f4             	pushl  -0xc(%ebp)
  800f03:	50                   	push   %eax
  800f04:	ff 75 0c             	pushl  0xc(%ebp)
  800f07:	ff 75 08             	pushl  0x8(%ebp)
  800f0a:	e8 16 fc ff ff       	call   800b25 <vprintfmt>
  800f0f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f12:	90                   	nop
  800f13:	c9                   	leave  
  800f14:	c3                   	ret    

00800f15 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f15:	55                   	push   %ebp
  800f16:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1b:	8b 40 08             	mov    0x8(%eax),%eax
  800f1e:	8d 50 01             	lea    0x1(%eax),%edx
  800f21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f24:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2a:	8b 10                	mov    (%eax),%edx
  800f2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2f:	8b 40 04             	mov    0x4(%eax),%eax
  800f32:	39 c2                	cmp    %eax,%edx
  800f34:	73 12                	jae    800f48 <sprintputch+0x33>
		*b->buf++ = ch;
  800f36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f39:	8b 00                	mov    (%eax),%eax
  800f3b:	8d 48 01             	lea    0x1(%eax),%ecx
  800f3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f41:	89 0a                	mov    %ecx,(%edx)
  800f43:	8b 55 08             	mov    0x8(%ebp),%edx
  800f46:	88 10                	mov    %dl,(%eax)
}
  800f48:	90                   	nop
  800f49:	5d                   	pop    %ebp
  800f4a:	c3                   	ret    

00800f4b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f4b:	55                   	push   %ebp
  800f4c:	89 e5                	mov    %esp,%ebp
  800f4e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f51:	8b 45 08             	mov    0x8(%ebp),%eax
  800f54:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	01 d0                	add    %edx,%eax
  800f62:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f65:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f6c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f70:	74 06                	je     800f78 <vsnprintf+0x2d>
  800f72:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f76:	7f 07                	jg     800f7f <vsnprintf+0x34>
		return -E_INVAL;
  800f78:	b8 03 00 00 00       	mov    $0x3,%eax
  800f7d:	eb 20                	jmp    800f9f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f7f:	ff 75 14             	pushl  0x14(%ebp)
  800f82:	ff 75 10             	pushl  0x10(%ebp)
  800f85:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800f88:	50                   	push   %eax
  800f89:	68 15 0f 80 00       	push   $0x800f15
  800f8e:	e8 92 fb ff ff       	call   800b25 <vprintfmt>
  800f93:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800f96:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f99:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800f9f:	c9                   	leave  
  800fa0:	c3                   	ret    

00800fa1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fa1:	55                   	push   %ebp
  800fa2:	89 e5                	mov    %esp,%ebp
  800fa4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fa7:	8d 45 10             	lea    0x10(%ebp),%eax
  800faa:	83 c0 04             	add    $0x4,%eax
  800fad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb3:	ff 75 f4             	pushl  -0xc(%ebp)
  800fb6:	50                   	push   %eax
  800fb7:	ff 75 0c             	pushl  0xc(%ebp)
  800fba:	ff 75 08             	pushl  0x8(%ebp)
  800fbd:	e8 89 ff ff ff       	call   800f4b <vsnprintf>
  800fc2:	83 c4 10             	add    $0x10,%esp
  800fc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800fc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fcb:	c9                   	leave  
  800fcc:	c3                   	ret    

00800fcd <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800fcd:	55                   	push   %ebp
  800fce:	89 e5                	mov    %esp,%ebp
  800fd0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800fd3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fda:	eb 06                	jmp    800fe2 <strlen+0x15>
		n++;
  800fdc:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800fdf:	ff 45 08             	incl   0x8(%ebp)
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	8a 00                	mov    (%eax),%al
  800fe7:	84 c0                	test   %al,%al
  800fe9:	75 f1                	jne    800fdc <strlen+0xf>
		n++;
	return n;
  800feb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fee:	c9                   	leave  
  800fef:	c3                   	ret    

00800ff0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ff0:	55                   	push   %ebp
  800ff1:	89 e5                	mov    %esp,%ebp
  800ff3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ff6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ffd:	eb 09                	jmp    801008 <strnlen+0x18>
		n++;
  800fff:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801002:	ff 45 08             	incl   0x8(%ebp)
  801005:	ff 4d 0c             	decl   0xc(%ebp)
  801008:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80100c:	74 09                	je     801017 <strnlen+0x27>
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	8a 00                	mov    (%eax),%al
  801013:	84 c0                	test   %al,%al
  801015:	75 e8                	jne    800fff <strnlen+0xf>
		n++;
	return n;
  801017:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80101a:	c9                   	leave  
  80101b:	c3                   	ret    

0080101c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80101c:	55                   	push   %ebp
  80101d:	89 e5                	mov    %esp,%ebp
  80101f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801028:	90                   	nop
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	8d 50 01             	lea    0x1(%eax),%edx
  80102f:	89 55 08             	mov    %edx,0x8(%ebp)
  801032:	8b 55 0c             	mov    0xc(%ebp),%edx
  801035:	8d 4a 01             	lea    0x1(%edx),%ecx
  801038:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80103b:	8a 12                	mov    (%edx),%dl
  80103d:	88 10                	mov    %dl,(%eax)
  80103f:	8a 00                	mov    (%eax),%al
  801041:	84 c0                	test   %al,%al
  801043:	75 e4                	jne    801029 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801045:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801048:	c9                   	leave  
  801049:	c3                   	ret    

0080104a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80104a:	55                   	push   %ebp
  80104b:	89 e5                	mov    %esp,%ebp
  80104d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801050:	8b 45 08             	mov    0x8(%ebp),%eax
  801053:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801056:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80105d:	eb 1f                	jmp    80107e <strncpy+0x34>
		*dst++ = *src;
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
  801062:	8d 50 01             	lea    0x1(%eax),%edx
  801065:	89 55 08             	mov    %edx,0x8(%ebp)
  801068:	8b 55 0c             	mov    0xc(%ebp),%edx
  80106b:	8a 12                	mov    (%edx),%dl
  80106d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80106f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801072:	8a 00                	mov    (%eax),%al
  801074:	84 c0                	test   %al,%al
  801076:	74 03                	je     80107b <strncpy+0x31>
			src++;
  801078:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80107b:	ff 45 fc             	incl   -0x4(%ebp)
  80107e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801081:	3b 45 10             	cmp    0x10(%ebp),%eax
  801084:	72 d9                	jb     80105f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801086:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801089:	c9                   	leave  
  80108a:	c3                   	ret    

0080108b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80108b:	55                   	push   %ebp
  80108c:	89 e5                	mov    %esp,%ebp
  80108e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801097:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80109b:	74 30                	je     8010cd <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80109d:	eb 16                	jmp    8010b5 <strlcpy+0x2a>
			*dst++ = *src++;
  80109f:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a2:	8d 50 01             	lea    0x1(%eax),%edx
  8010a5:	89 55 08             	mov    %edx,0x8(%ebp)
  8010a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ab:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010ae:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010b1:	8a 12                	mov    (%edx),%dl
  8010b3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010b5:	ff 4d 10             	decl   0x10(%ebp)
  8010b8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010bc:	74 09                	je     8010c7 <strlcpy+0x3c>
  8010be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c1:	8a 00                	mov    (%eax),%al
  8010c3:	84 c0                	test   %al,%al
  8010c5:	75 d8                	jne    80109f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ca:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010cd:	8b 55 08             	mov    0x8(%ebp),%edx
  8010d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d3:	29 c2                	sub    %eax,%edx
  8010d5:	89 d0                	mov    %edx,%eax
}
  8010d7:	c9                   	leave  
  8010d8:	c3                   	ret    

008010d9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8010d9:	55                   	push   %ebp
  8010da:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010dc:	eb 06                	jmp    8010e4 <strcmp+0xb>
		p++, q++;
  8010de:	ff 45 08             	incl   0x8(%ebp)
  8010e1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8010e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e7:	8a 00                	mov    (%eax),%al
  8010e9:	84 c0                	test   %al,%al
  8010eb:	74 0e                	je     8010fb <strcmp+0x22>
  8010ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f0:	8a 10                	mov    (%eax),%dl
  8010f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f5:	8a 00                	mov    (%eax),%al
  8010f7:	38 c2                	cmp    %al,%dl
  8010f9:	74 e3                	je     8010de <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	8a 00                	mov    (%eax),%al
  801100:	0f b6 d0             	movzbl %al,%edx
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	0f b6 c0             	movzbl %al,%eax
  80110b:	29 c2                	sub    %eax,%edx
  80110d:	89 d0                	mov    %edx,%eax
}
  80110f:	5d                   	pop    %ebp
  801110:	c3                   	ret    

00801111 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801111:	55                   	push   %ebp
  801112:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801114:	eb 09                	jmp    80111f <strncmp+0xe>
		n--, p++, q++;
  801116:	ff 4d 10             	decl   0x10(%ebp)
  801119:	ff 45 08             	incl   0x8(%ebp)
  80111c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80111f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801123:	74 17                	je     80113c <strncmp+0x2b>
  801125:	8b 45 08             	mov    0x8(%ebp),%eax
  801128:	8a 00                	mov    (%eax),%al
  80112a:	84 c0                	test   %al,%al
  80112c:	74 0e                	je     80113c <strncmp+0x2b>
  80112e:	8b 45 08             	mov    0x8(%ebp),%eax
  801131:	8a 10                	mov    (%eax),%dl
  801133:	8b 45 0c             	mov    0xc(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	38 c2                	cmp    %al,%dl
  80113a:	74 da                	je     801116 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80113c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801140:	75 07                	jne    801149 <strncmp+0x38>
		return 0;
  801142:	b8 00 00 00 00       	mov    $0x0,%eax
  801147:	eb 14                	jmp    80115d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
  80114c:	8a 00                	mov    (%eax),%al
  80114e:	0f b6 d0             	movzbl %al,%edx
  801151:	8b 45 0c             	mov    0xc(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	0f b6 c0             	movzbl %al,%eax
  801159:	29 c2                	sub    %eax,%edx
  80115b:	89 d0                	mov    %edx,%eax
}
  80115d:	5d                   	pop    %ebp
  80115e:	c3                   	ret    

0080115f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
  801162:	83 ec 04             	sub    $0x4,%esp
  801165:	8b 45 0c             	mov    0xc(%ebp),%eax
  801168:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80116b:	eb 12                	jmp    80117f <strchr+0x20>
		if (*s == c)
  80116d:	8b 45 08             	mov    0x8(%ebp),%eax
  801170:	8a 00                	mov    (%eax),%al
  801172:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801175:	75 05                	jne    80117c <strchr+0x1d>
			return (char *) s;
  801177:	8b 45 08             	mov    0x8(%ebp),%eax
  80117a:	eb 11                	jmp    80118d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80117c:	ff 45 08             	incl   0x8(%ebp)
  80117f:	8b 45 08             	mov    0x8(%ebp),%eax
  801182:	8a 00                	mov    (%eax),%al
  801184:	84 c0                	test   %al,%al
  801186:	75 e5                	jne    80116d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801188:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80118d:	c9                   	leave  
  80118e:	c3                   	ret    

0080118f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
  801192:	83 ec 04             	sub    $0x4,%esp
  801195:	8b 45 0c             	mov    0xc(%ebp),%eax
  801198:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80119b:	eb 0d                	jmp    8011aa <strfind+0x1b>
		if (*s == c)
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	8a 00                	mov    (%eax),%al
  8011a2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011a5:	74 0e                	je     8011b5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011a7:	ff 45 08             	incl   0x8(%ebp)
  8011aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ad:	8a 00                	mov    (%eax),%al
  8011af:	84 c0                	test   %al,%al
  8011b1:	75 ea                	jne    80119d <strfind+0xe>
  8011b3:	eb 01                	jmp    8011b6 <strfind+0x27>
		if (*s == c)
			break;
  8011b5:	90                   	nop
	return (char *) s;
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011b9:	c9                   	leave  
  8011ba:	c3                   	ret    

008011bb <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011bb:	55                   	push   %ebp
  8011bc:	89 e5                	mov    %esp,%ebp
  8011be:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ca:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011cd:	eb 0e                	jmp    8011dd <memset+0x22>
		*p++ = c;
  8011cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011d2:	8d 50 01             	lea    0x1(%eax),%edx
  8011d5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011db:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011dd:	ff 4d f8             	decl   -0x8(%ebp)
  8011e0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8011e4:	79 e9                	jns    8011cf <memset+0x14>
		*p++ = c;

	return v;
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
  8011ee:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8011fd:	eb 16                	jmp    801215 <memcpy+0x2a>
		*d++ = *s++;
  8011ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801202:	8d 50 01             	lea    0x1(%eax),%edx
  801205:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801208:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80120b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80120e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801211:	8a 12                	mov    (%edx),%dl
  801213:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801215:	8b 45 10             	mov    0x10(%ebp),%eax
  801218:	8d 50 ff             	lea    -0x1(%eax),%edx
  80121b:	89 55 10             	mov    %edx,0x10(%ebp)
  80121e:	85 c0                	test   %eax,%eax
  801220:	75 dd                	jne    8011ff <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801222:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801225:	c9                   	leave  
  801226:	c3                   	ret    

00801227 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801227:	55                   	push   %ebp
  801228:	89 e5                	mov    %esp,%ebp
  80122a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80122d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801230:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801233:	8b 45 08             	mov    0x8(%ebp),%eax
  801236:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801239:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80123c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80123f:	73 50                	jae    801291 <memmove+0x6a>
  801241:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801244:	8b 45 10             	mov    0x10(%ebp),%eax
  801247:	01 d0                	add    %edx,%eax
  801249:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80124c:	76 43                	jbe    801291 <memmove+0x6a>
		s += n;
  80124e:	8b 45 10             	mov    0x10(%ebp),%eax
  801251:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801254:	8b 45 10             	mov    0x10(%ebp),%eax
  801257:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80125a:	eb 10                	jmp    80126c <memmove+0x45>
			*--d = *--s;
  80125c:	ff 4d f8             	decl   -0x8(%ebp)
  80125f:	ff 4d fc             	decl   -0x4(%ebp)
  801262:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801265:	8a 10                	mov    (%eax),%dl
  801267:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80126a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80126c:	8b 45 10             	mov    0x10(%ebp),%eax
  80126f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801272:	89 55 10             	mov    %edx,0x10(%ebp)
  801275:	85 c0                	test   %eax,%eax
  801277:	75 e3                	jne    80125c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801279:	eb 23                	jmp    80129e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80127b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80127e:	8d 50 01             	lea    0x1(%eax),%edx
  801281:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801284:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801287:	8d 4a 01             	lea    0x1(%edx),%ecx
  80128a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80128d:	8a 12                	mov    (%edx),%dl
  80128f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801291:	8b 45 10             	mov    0x10(%ebp),%eax
  801294:	8d 50 ff             	lea    -0x1(%eax),%edx
  801297:	89 55 10             	mov    %edx,0x10(%ebp)
  80129a:	85 c0                	test   %eax,%eax
  80129c:	75 dd                	jne    80127b <memmove+0x54>
			*d++ = *s++;

	return dst;
  80129e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012a1:	c9                   	leave  
  8012a2:	c3                   	ret    

008012a3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012a3:	55                   	push   %ebp
  8012a4:	89 e5                	mov    %esp,%ebp
  8012a6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012b5:	eb 2a                	jmp    8012e1 <memcmp+0x3e>
		if (*s1 != *s2)
  8012b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ba:	8a 10                	mov    (%eax),%dl
  8012bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012bf:	8a 00                	mov    (%eax),%al
  8012c1:	38 c2                	cmp    %al,%dl
  8012c3:	74 16                	je     8012db <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c8:	8a 00                	mov    (%eax),%al
  8012ca:	0f b6 d0             	movzbl %al,%edx
  8012cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d0:	8a 00                	mov    (%eax),%al
  8012d2:	0f b6 c0             	movzbl %al,%eax
  8012d5:	29 c2                	sub    %eax,%edx
  8012d7:	89 d0                	mov    %edx,%eax
  8012d9:	eb 18                	jmp    8012f3 <memcmp+0x50>
		s1++, s2++;
  8012db:	ff 45 fc             	incl   -0x4(%ebp)
  8012de:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8012e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ea:	85 c0                	test   %eax,%eax
  8012ec:	75 c9                	jne    8012b7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8012ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012f3:	c9                   	leave  
  8012f4:	c3                   	ret    

008012f5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8012f5:	55                   	push   %ebp
  8012f6:	89 e5                	mov    %esp,%ebp
  8012f8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8012fb:	8b 55 08             	mov    0x8(%ebp),%edx
  8012fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801301:	01 d0                	add    %edx,%eax
  801303:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801306:	eb 15                	jmp    80131d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	8a 00                	mov    (%eax),%al
  80130d:	0f b6 d0             	movzbl %al,%edx
  801310:	8b 45 0c             	mov    0xc(%ebp),%eax
  801313:	0f b6 c0             	movzbl %al,%eax
  801316:	39 c2                	cmp    %eax,%edx
  801318:	74 0d                	je     801327 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80131a:	ff 45 08             	incl   0x8(%ebp)
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801323:	72 e3                	jb     801308 <memfind+0x13>
  801325:	eb 01                	jmp    801328 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801327:	90                   	nop
	return (void *) s;
  801328:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80132b:	c9                   	leave  
  80132c:	c3                   	ret    

0080132d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80132d:	55                   	push   %ebp
  80132e:	89 e5                	mov    %esp,%ebp
  801330:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801333:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80133a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801341:	eb 03                	jmp    801346 <strtol+0x19>
		s++;
  801343:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	8a 00                	mov    (%eax),%al
  80134b:	3c 20                	cmp    $0x20,%al
  80134d:	74 f4                	je     801343 <strtol+0x16>
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	8a 00                	mov    (%eax),%al
  801354:	3c 09                	cmp    $0x9,%al
  801356:	74 eb                	je     801343 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	8a 00                	mov    (%eax),%al
  80135d:	3c 2b                	cmp    $0x2b,%al
  80135f:	75 05                	jne    801366 <strtol+0x39>
		s++;
  801361:	ff 45 08             	incl   0x8(%ebp)
  801364:	eb 13                	jmp    801379 <strtol+0x4c>
	else if (*s == '-')
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	8a 00                	mov    (%eax),%al
  80136b:	3c 2d                	cmp    $0x2d,%al
  80136d:	75 0a                	jne    801379 <strtol+0x4c>
		s++, neg = 1;
  80136f:	ff 45 08             	incl   0x8(%ebp)
  801372:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801379:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80137d:	74 06                	je     801385 <strtol+0x58>
  80137f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801383:	75 20                	jne    8013a5 <strtol+0x78>
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	8a 00                	mov    (%eax),%al
  80138a:	3c 30                	cmp    $0x30,%al
  80138c:	75 17                	jne    8013a5 <strtol+0x78>
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	40                   	inc    %eax
  801392:	8a 00                	mov    (%eax),%al
  801394:	3c 78                	cmp    $0x78,%al
  801396:	75 0d                	jne    8013a5 <strtol+0x78>
		s += 2, base = 16;
  801398:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80139c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013a3:	eb 28                	jmp    8013cd <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a9:	75 15                	jne    8013c0 <strtol+0x93>
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	8a 00                	mov    (%eax),%al
  8013b0:	3c 30                	cmp    $0x30,%al
  8013b2:	75 0c                	jne    8013c0 <strtol+0x93>
		s++, base = 8;
  8013b4:	ff 45 08             	incl   0x8(%ebp)
  8013b7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013be:	eb 0d                	jmp    8013cd <strtol+0xa0>
	else if (base == 0)
  8013c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c4:	75 07                	jne    8013cd <strtol+0xa0>
		base = 10;
  8013c6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	8a 00                	mov    (%eax),%al
  8013d2:	3c 2f                	cmp    $0x2f,%al
  8013d4:	7e 19                	jle    8013ef <strtol+0xc2>
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	3c 39                	cmp    $0x39,%al
  8013dd:	7f 10                	jg     8013ef <strtol+0xc2>
			dig = *s - '0';
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e2:	8a 00                	mov    (%eax),%al
  8013e4:	0f be c0             	movsbl %al,%eax
  8013e7:	83 e8 30             	sub    $0x30,%eax
  8013ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013ed:	eb 42                	jmp    801431 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	8a 00                	mov    (%eax),%al
  8013f4:	3c 60                	cmp    $0x60,%al
  8013f6:	7e 19                	jle    801411 <strtol+0xe4>
  8013f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fb:	8a 00                	mov    (%eax),%al
  8013fd:	3c 7a                	cmp    $0x7a,%al
  8013ff:	7f 10                	jg     801411 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	8a 00                	mov    (%eax),%al
  801406:	0f be c0             	movsbl %al,%eax
  801409:	83 e8 57             	sub    $0x57,%eax
  80140c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80140f:	eb 20                	jmp    801431 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	3c 40                	cmp    $0x40,%al
  801418:	7e 39                	jle    801453 <strtol+0x126>
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	8a 00                	mov    (%eax),%al
  80141f:	3c 5a                	cmp    $0x5a,%al
  801421:	7f 30                	jg     801453 <strtol+0x126>
			dig = *s - 'A' + 10;
  801423:	8b 45 08             	mov    0x8(%ebp),%eax
  801426:	8a 00                	mov    (%eax),%al
  801428:	0f be c0             	movsbl %al,%eax
  80142b:	83 e8 37             	sub    $0x37,%eax
  80142e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801431:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801434:	3b 45 10             	cmp    0x10(%ebp),%eax
  801437:	7d 19                	jge    801452 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801439:	ff 45 08             	incl   0x8(%ebp)
  80143c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80143f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801443:	89 c2                	mov    %eax,%edx
  801445:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801448:	01 d0                	add    %edx,%eax
  80144a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80144d:	e9 7b ff ff ff       	jmp    8013cd <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801452:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801453:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801457:	74 08                	je     801461 <strtol+0x134>
		*endptr = (char *) s;
  801459:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145c:	8b 55 08             	mov    0x8(%ebp),%edx
  80145f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801461:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801465:	74 07                	je     80146e <strtol+0x141>
  801467:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80146a:	f7 d8                	neg    %eax
  80146c:	eb 03                	jmp    801471 <strtol+0x144>
  80146e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801471:	c9                   	leave  
  801472:	c3                   	ret    

00801473 <ltostr>:

void
ltostr(long value, char *str)
{
  801473:	55                   	push   %ebp
  801474:	89 e5                	mov    %esp,%ebp
  801476:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801479:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801480:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801487:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80148b:	79 13                	jns    8014a0 <ltostr+0x2d>
	{
		neg = 1;
  80148d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801494:	8b 45 0c             	mov    0xc(%ebp),%eax
  801497:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80149a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80149d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014a8:	99                   	cltd   
  8014a9:	f7 f9                	idiv   %ecx
  8014ab:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b1:	8d 50 01             	lea    0x1(%eax),%edx
  8014b4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014b7:	89 c2                	mov    %eax,%edx
  8014b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bc:	01 d0                	add    %edx,%eax
  8014be:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014c1:	83 c2 30             	add    $0x30,%edx
  8014c4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014c9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014ce:	f7 e9                	imul   %ecx
  8014d0:	c1 fa 02             	sar    $0x2,%edx
  8014d3:	89 c8                	mov    %ecx,%eax
  8014d5:	c1 f8 1f             	sar    $0x1f,%eax
  8014d8:	29 c2                	sub    %eax,%edx
  8014da:	89 d0                	mov    %edx,%eax
  8014dc:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014e2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014e7:	f7 e9                	imul   %ecx
  8014e9:	c1 fa 02             	sar    $0x2,%edx
  8014ec:	89 c8                	mov    %ecx,%eax
  8014ee:	c1 f8 1f             	sar    $0x1f,%eax
  8014f1:	29 c2                	sub    %eax,%edx
  8014f3:	89 d0                	mov    %edx,%eax
  8014f5:	c1 e0 02             	shl    $0x2,%eax
  8014f8:	01 d0                	add    %edx,%eax
  8014fa:	01 c0                	add    %eax,%eax
  8014fc:	29 c1                	sub    %eax,%ecx
  8014fe:	89 ca                	mov    %ecx,%edx
  801500:	85 d2                	test   %edx,%edx
  801502:	75 9c                	jne    8014a0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801504:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80150b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80150e:	48                   	dec    %eax
  80150f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801512:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801516:	74 3d                	je     801555 <ltostr+0xe2>
		start = 1 ;
  801518:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80151f:	eb 34                	jmp    801555 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801521:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801524:	8b 45 0c             	mov    0xc(%ebp),%eax
  801527:	01 d0                	add    %edx,%eax
  801529:	8a 00                	mov    (%eax),%al
  80152b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80152e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801531:	8b 45 0c             	mov    0xc(%ebp),%eax
  801534:	01 c2                	add    %eax,%edx
  801536:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801539:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153c:	01 c8                	add    %ecx,%eax
  80153e:	8a 00                	mov    (%eax),%al
  801540:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801542:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801545:	8b 45 0c             	mov    0xc(%ebp),%eax
  801548:	01 c2                	add    %eax,%edx
  80154a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80154d:	88 02                	mov    %al,(%edx)
		start++ ;
  80154f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801552:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801555:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801558:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80155b:	7c c4                	jl     801521 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80155d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801560:	8b 45 0c             	mov    0xc(%ebp),%eax
  801563:	01 d0                	add    %edx,%eax
  801565:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801568:	90                   	nop
  801569:	c9                   	leave  
  80156a:	c3                   	ret    

0080156b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80156b:	55                   	push   %ebp
  80156c:	89 e5                	mov    %esp,%ebp
  80156e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801571:	ff 75 08             	pushl  0x8(%ebp)
  801574:	e8 54 fa ff ff       	call   800fcd <strlen>
  801579:	83 c4 04             	add    $0x4,%esp
  80157c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80157f:	ff 75 0c             	pushl  0xc(%ebp)
  801582:	e8 46 fa ff ff       	call   800fcd <strlen>
  801587:	83 c4 04             	add    $0x4,%esp
  80158a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80158d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801594:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80159b:	eb 17                	jmp    8015b4 <strcconcat+0x49>
		final[s] = str1[s] ;
  80159d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a3:	01 c2                	add    %eax,%edx
  8015a5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ab:	01 c8                	add    %ecx,%eax
  8015ad:	8a 00                	mov    (%eax),%al
  8015af:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015b1:	ff 45 fc             	incl   -0x4(%ebp)
  8015b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015b7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015ba:	7c e1                	jl     80159d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015bc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015c3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015ca:	eb 1f                	jmp    8015eb <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015cf:	8d 50 01             	lea    0x1(%eax),%edx
  8015d2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015d5:	89 c2                	mov    %eax,%edx
  8015d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015da:	01 c2                	add    %eax,%edx
  8015dc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e2:	01 c8                	add    %ecx,%eax
  8015e4:	8a 00                	mov    (%eax),%al
  8015e6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8015e8:	ff 45 f8             	incl   -0x8(%ebp)
  8015eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ee:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015f1:	7c d9                	jl     8015cc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8015f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f9:	01 d0                	add    %edx,%eax
  8015fb:	c6 00 00             	movb   $0x0,(%eax)
}
  8015fe:	90                   	nop
  8015ff:	c9                   	leave  
  801600:	c3                   	ret    

00801601 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801601:	55                   	push   %ebp
  801602:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801604:	8b 45 14             	mov    0x14(%ebp),%eax
  801607:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80160d:	8b 45 14             	mov    0x14(%ebp),%eax
  801610:	8b 00                	mov    (%eax),%eax
  801612:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801619:	8b 45 10             	mov    0x10(%ebp),%eax
  80161c:	01 d0                	add    %edx,%eax
  80161e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801624:	eb 0c                	jmp    801632 <strsplit+0x31>
			*string++ = 0;
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	8d 50 01             	lea    0x1(%eax),%edx
  80162c:	89 55 08             	mov    %edx,0x8(%ebp)
  80162f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	8a 00                	mov    (%eax),%al
  801637:	84 c0                	test   %al,%al
  801639:	74 18                	je     801653 <strsplit+0x52>
  80163b:	8b 45 08             	mov    0x8(%ebp),%eax
  80163e:	8a 00                	mov    (%eax),%al
  801640:	0f be c0             	movsbl %al,%eax
  801643:	50                   	push   %eax
  801644:	ff 75 0c             	pushl  0xc(%ebp)
  801647:	e8 13 fb ff ff       	call   80115f <strchr>
  80164c:	83 c4 08             	add    $0x8,%esp
  80164f:	85 c0                	test   %eax,%eax
  801651:	75 d3                	jne    801626 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	8a 00                	mov    (%eax),%al
  801658:	84 c0                	test   %al,%al
  80165a:	74 5a                	je     8016b6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80165c:	8b 45 14             	mov    0x14(%ebp),%eax
  80165f:	8b 00                	mov    (%eax),%eax
  801661:	83 f8 0f             	cmp    $0xf,%eax
  801664:	75 07                	jne    80166d <strsplit+0x6c>
		{
			return 0;
  801666:	b8 00 00 00 00       	mov    $0x0,%eax
  80166b:	eb 66                	jmp    8016d3 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80166d:	8b 45 14             	mov    0x14(%ebp),%eax
  801670:	8b 00                	mov    (%eax),%eax
  801672:	8d 48 01             	lea    0x1(%eax),%ecx
  801675:	8b 55 14             	mov    0x14(%ebp),%edx
  801678:	89 0a                	mov    %ecx,(%edx)
  80167a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801681:	8b 45 10             	mov    0x10(%ebp),%eax
  801684:	01 c2                	add    %eax,%edx
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80168b:	eb 03                	jmp    801690 <strsplit+0x8f>
			string++;
  80168d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	8a 00                	mov    (%eax),%al
  801695:	84 c0                	test   %al,%al
  801697:	74 8b                	je     801624 <strsplit+0x23>
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
  80169c:	8a 00                	mov    (%eax),%al
  80169e:	0f be c0             	movsbl %al,%eax
  8016a1:	50                   	push   %eax
  8016a2:	ff 75 0c             	pushl  0xc(%ebp)
  8016a5:	e8 b5 fa ff ff       	call   80115f <strchr>
  8016aa:	83 c4 08             	add    $0x8,%esp
  8016ad:	85 c0                	test   %eax,%eax
  8016af:	74 dc                	je     80168d <strsplit+0x8c>
			string++;
	}
  8016b1:	e9 6e ff ff ff       	jmp    801624 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016b6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ba:	8b 00                	mov    (%eax),%eax
  8016bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c6:	01 d0                	add    %edx,%eax
  8016c8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016ce:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016d3:	c9                   	leave  
  8016d4:	c3                   	ret    

008016d5 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
  8016d8:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  8016db:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  8016e2:	76 0a                	jbe    8016ee <malloc+0x19>
		return NULL;
  8016e4:	b8 00 00 00 00       	mov    $0x0,%eax
  8016e9:	e9 ad 02 00 00       	jmp    80199b <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  8016ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f1:	c1 e8 0c             	shr    $0xc,%eax
  8016f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  8016f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fa:	25 ff 0f 00 00       	and    $0xfff,%eax
  8016ff:	85 c0                	test   %eax,%eax
  801701:	74 03                	je     801706 <malloc+0x31>
		num++;
  801703:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801706:	a1 28 30 80 00       	mov    0x803028,%eax
  80170b:	85 c0                	test   %eax,%eax
  80170d:	75 71                	jne    801780 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  80170f:	a1 04 30 80 00       	mov    0x803004,%eax
  801714:	83 ec 08             	sub    $0x8,%esp
  801717:	ff 75 08             	pushl  0x8(%ebp)
  80171a:	50                   	push   %eax
  80171b:	e8 ba 05 00 00       	call   801cda <sys_allocateMem>
  801720:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801723:	a1 04 30 80 00       	mov    0x803004,%eax
  801728:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  80172b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80172e:	c1 e0 0c             	shl    $0xc,%eax
  801731:	89 c2                	mov    %eax,%edx
  801733:	a1 04 30 80 00       	mov    0x803004,%eax
  801738:	01 d0                	add    %edx,%eax
  80173a:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  80173f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801744:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801747:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  80174e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801753:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801756:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  80175d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801762:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801769:	01 00 00 00 
		sizeofarray++;
  80176d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801772:	40                   	inc    %eax
  801773:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  801778:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80177b:	e9 1b 02 00 00       	jmp    80199b <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801780:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801787:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  80178e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801795:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  80179c:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  8017a3:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8017aa:	eb 72                	jmp    80181e <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  8017ac:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8017af:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8017b6:	85 c0                	test   %eax,%eax
  8017b8:	75 12                	jne    8017cc <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  8017ba:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8017bd:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8017c4:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  8017c7:	ff 45 dc             	incl   -0x24(%ebp)
  8017ca:	eb 4f                	jmp    80181b <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  8017cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017cf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8017d2:	7d 39                	jge    80180d <malloc+0x138>
  8017d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017d7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8017da:	7c 31                	jl     80180d <malloc+0x138>
					{
						min=count;
  8017dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017df:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  8017e2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8017e5:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8017ec:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017ef:	c1 e2 0c             	shl    $0xc,%edx
  8017f2:	29 d0                	sub    %edx,%eax
  8017f4:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  8017f7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8017fa:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8017fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801800:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801807:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80180a:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  80180d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801814:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  80181b:	ff 45 d4             	incl   -0x2c(%ebp)
  80181e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801823:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801826:	7c 84                	jl     8017ac <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801828:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  80182c:	0f 85 e3 00 00 00    	jne    801915 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801832:	83 ec 08             	sub    $0x8,%esp
  801835:	ff 75 08             	pushl  0x8(%ebp)
  801838:	ff 75 e0             	pushl  -0x20(%ebp)
  80183b:	e8 9a 04 00 00       	call   801cda <sys_allocateMem>
  801840:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801843:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801848:	40                   	inc    %eax
  801849:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  80184e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801853:	48                   	dec    %eax
  801854:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801857:	eb 42                	jmp    80189b <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801859:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80185c:	48                   	dec    %eax
  80185d:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801864:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801867:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  80186e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801871:	48                   	dec    %eax
  801872:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801879:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80187c:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801883:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801886:	48                   	dec    %eax
  801887:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  80188e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801891:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801898:	ff 4d d0             	decl   -0x30(%ebp)
  80189b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80189e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8018a1:	7f b6                	jg     801859 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  8018a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018a6:	40                   	inc    %eax
  8018a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  8018aa:	8b 55 08             	mov    0x8(%ebp),%edx
  8018ad:	01 ca                	add    %ecx,%edx
  8018af:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  8018b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018b9:	8d 50 01             	lea    0x1(%eax),%edx
  8018bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018bf:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  8018c6:	2b 45 f4             	sub    -0xc(%ebp),%eax
  8018c9:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  8018d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018d3:	40                   	inc    %eax
  8018d4:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  8018db:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  8018df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018e5:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  8018ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018ef:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8018f2:	eb 11                	jmp    801905 <malloc+0x230>
				{
					changed[index] = 1;
  8018f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018f7:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8018fe:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801902:	ff 45 cc             	incl   -0x34(%ebp)
  801905:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801908:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80190b:	7c e7                	jl     8018f4 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  80190d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801910:	e9 86 00 00 00       	jmp    80199b <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801915:	a1 04 30 80 00       	mov    0x803004,%eax
  80191a:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  80191f:	29 c2                	sub    %eax,%edx
  801921:	89 d0                	mov    %edx,%eax
  801923:	3b 45 08             	cmp    0x8(%ebp),%eax
  801926:	73 07                	jae    80192f <malloc+0x25a>
						return NULL;
  801928:	b8 00 00 00 00       	mov    $0x0,%eax
  80192d:	eb 6c                	jmp    80199b <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  80192f:	a1 04 30 80 00       	mov    0x803004,%eax
  801934:	83 ec 08             	sub    $0x8,%esp
  801937:	ff 75 08             	pushl  0x8(%ebp)
  80193a:	50                   	push   %eax
  80193b:	e8 9a 03 00 00       	call   801cda <sys_allocateMem>
  801940:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801943:	a1 04 30 80 00       	mov    0x803004,%eax
  801948:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  80194b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80194e:	c1 e0 0c             	shl    $0xc,%eax
  801951:	89 c2                	mov    %eax,%edx
  801953:	a1 04 30 80 00       	mov    0x803004,%eax
  801958:	01 d0                	add    %edx,%eax
  80195a:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  80195f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801964:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801967:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  80196e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801973:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801976:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  80197d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801982:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801989:	01 00 00 00 
					sizeofarray++;
  80198d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801992:	40                   	inc    %eax
  801993:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  801998:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  80199b:	c9                   	leave  
  80199c:	c3                   	ret    

0080199d <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80199d:	55                   	push   %ebp
  80199e:	89 e5                	mov    %esp,%ebp
  8019a0:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  8019a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8019b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8019b7:	eb 30                	jmp    8019e9 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  8019b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019bc:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8019c3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8019c6:	75 1e                	jne    8019e6 <free+0x49>
  8019c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019cb:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8019d2:	83 f8 01             	cmp    $0x1,%eax
  8019d5:	75 0f                	jne    8019e6 <free+0x49>
			is_found = 1;
  8019d7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  8019de:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  8019e4:	eb 0d                	jmp    8019f3 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8019e6:	ff 45 ec             	incl   -0x14(%ebp)
  8019e9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019ee:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8019f1:	7c c6                	jl     8019b9 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  8019f3:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8019f7:	75 3a                	jne    801a33 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  8019f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019fc:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801a03:	c1 e0 0c             	shl    $0xc,%eax
  801a06:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801a09:	83 ec 08             	sub    $0x8,%esp
  801a0c:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a0f:	ff 75 e8             	pushl  -0x18(%ebp)
  801a12:	e8 a7 02 00 00       	call   801cbe <sys_freeMem>
  801a17:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801a1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a1d:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801a24:	00 00 00 00 
		changes++;
  801a28:	a1 28 30 80 00       	mov    0x803028,%eax
  801a2d:	40                   	inc    %eax
  801a2e:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  801a33:	90                   	nop
  801a34:	c9                   	leave  
  801a35:	c3                   	ret    

00801a36 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
  801a39:	83 ec 18             	sub    $0x18,%esp
  801a3c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a3f:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a42:	83 ec 04             	sub    $0x4,%esp
  801a45:	68 90 2d 80 00       	push   $0x802d90
  801a4a:	68 b6 00 00 00       	push   $0xb6
  801a4f:	68 b3 2d 80 00       	push   $0x802db3
  801a54:	e8 50 ec ff ff       	call   8006a9 <_panic>

00801a59 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801a59:	55                   	push   %ebp
  801a5a:	89 e5                	mov    %esp,%ebp
  801a5c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a5f:	83 ec 04             	sub    $0x4,%esp
  801a62:	68 90 2d 80 00       	push   $0x802d90
  801a67:	68 bb 00 00 00       	push   $0xbb
  801a6c:	68 b3 2d 80 00       	push   $0x802db3
  801a71:	e8 33 ec ff ff       	call   8006a9 <_panic>

00801a76 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801a76:	55                   	push   %ebp
  801a77:	89 e5                	mov    %esp,%ebp
  801a79:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a7c:	83 ec 04             	sub    $0x4,%esp
  801a7f:	68 90 2d 80 00       	push   $0x802d90
  801a84:	68 c0 00 00 00       	push   $0xc0
  801a89:	68 b3 2d 80 00       	push   $0x802db3
  801a8e:	e8 16 ec ff ff       	call   8006a9 <_panic>

00801a93 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801a93:	55                   	push   %ebp
  801a94:	89 e5                	mov    %esp,%ebp
  801a96:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a99:	83 ec 04             	sub    $0x4,%esp
  801a9c:	68 90 2d 80 00       	push   $0x802d90
  801aa1:	68 c4 00 00 00       	push   $0xc4
  801aa6:	68 b3 2d 80 00       	push   $0x802db3
  801aab:	e8 f9 eb ff ff       	call   8006a9 <_panic>

00801ab0 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801ab0:	55                   	push   %ebp
  801ab1:	89 e5                	mov    %esp,%ebp
  801ab3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ab6:	83 ec 04             	sub    $0x4,%esp
  801ab9:	68 90 2d 80 00       	push   $0x802d90
  801abe:	68 c9 00 00 00       	push   $0xc9
  801ac3:	68 b3 2d 80 00       	push   $0x802db3
  801ac8:	e8 dc eb ff ff       	call   8006a9 <_panic>

00801acd <shrink>:
}
void shrink(uint32 newSize) {
  801acd:	55                   	push   %ebp
  801ace:	89 e5                	mov    %esp,%ebp
  801ad0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ad3:	83 ec 04             	sub    $0x4,%esp
  801ad6:	68 90 2d 80 00       	push   $0x802d90
  801adb:	68 cc 00 00 00       	push   $0xcc
  801ae0:	68 b3 2d 80 00       	push   $0x802db3
  801ae5:	e8 bf eb ff ff       	call   8006a9 <_panic>

00801aea <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
  801aed:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801af0:	83 ec 04             	sub    $0x4,%esp
  801af3:	68 90 2d 80 00       	push   $0x802d90
  801af8:	68 d0 00 00 00       	push   $0xd0
  801afd:	68 b3 2d 80 00       	push   $0x802db3
  801b02:	e8 a2 eb ff ff       	call   8006a9 <_panic>

00801b07 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b07:	55                   	push   %ebp
  801b08:	89 e5                	mov    %esp,%ebp
  801b0a:	57                   	push   %edi
  801b0b:	56                   	push   %esi
  801b0c:	53                   	push   %ebx
  801b0d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b10:	8b 45 08             	mov    0x8(%ebp),%eax
  801b13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b16:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b19:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b1c:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b1f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b22:	cd 30                	int    $0x30
  801b24:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b27:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b2a:	83 c4 10             	add    $0x10,%esp
  801b2d:	5b                   	pop    %ebx
  801b2e:	5e                   	pop    %esi
  801b2f:	5f                   	pop    %edi
  801b30:	5d                   	pop    %ebp
  801b31:	c3                   	ret    

00801b32 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b32:	55                   	push   %ebp
  801b33:	89 e5                	mov    %esp,%ebp
  801b35:	83 ec 04             	sub    $0x4,%esp
  801b38:	8b 45 10             	mov    0x10(%ebp),%eax
  801b3b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b3e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b42:	8b 45 08             	mov    0x8(%ebp),%eax
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	52                   	push   %edx
  801b4a:	ff 75 0c             	pushl  0xc(%ebp)
  801b4d:	50                   	push   %eax
  801b4e:	6a 00                	push   $0x0
  801b50:	e8 b2 ff ff ff       	call   801b07 <syscall>
  801b55:	83 c4 18             	add    $0x18,%esp
}
  801b58:	90                   	nop
  801b59:	c9                   	leave  
  801b5a:	c3                   	ret    

00801b5b <sys_cgetc>:

int
sys_cgetc(void)
{
  801b5b:	55                   	push   %ebp
  801b5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	6a 01                	push   $0x1
  801b6a:	e8 98 ff ff ff       	call   801b07 <syscall>
  801b6f:	83 c4 18             	add    $0x18,%esp
}
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b77:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	50                   	push   %eax
  801b83:	6a 05                	push   $0x5
  801b85:	e8 7d ff ff ff       	call   801b07 <syscall>
  801b8a:	83 c4 18             	add    $0x18,%esp
}
  801b8d:	c9                   	leave  
  801b8e:	c3                   	ret    

00801b8f <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b8f:	55                   	push   %ebp
  801b90:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 02                	push   $0x2
  801b9e:	e8 64 ff ff ff       	call   801b07 <syscall>
  801ba3:	83 c4 18             	add    $0x18,%esp
}
  801ba6:	c9                   	leave  
  801ba7:	c3                   	ret    

00801ba8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ba8:	55                   	push   %ebp
  801ba9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 03                	push   $0x3
  801bb7:	e8 4b ff ff ff       	call   801b07 <syscall>
  801bbc:	83 c4 18             	add    $0x18,%esp
}
  801bbf:	c9                   	leave  
  801bc0:	c3                   	ret    

00801bc1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801bc1:	55                   	push   %ebp
  801bc2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 04                	push   $0x4
  801bd0:	e8 32 ff ff ff       	call   801b07 <syscall>
  801bd5:	83 c4 18             	add    $0x18,%esp
}
  801bd8:	c9                   	leave  
  801bd9:	c3                   	ret    

00801bda <sys_env_exit>:


void sys_env_exit(void)
{
  801bda:	55                   	push   %ebp
  801bdb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 06                	push   $0x6
  801be9:	e8 19 ff ff ff       	call   801b07 <syscall>
  801bee:	83 c4 18             	add    $0x18,%esp
}
  801bf1:	90                   	nop
  801bf2:	c9                   	leave  
  801bf3:	c3                   	ret    

00801bf4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801bf4:	55                   	push   %ebp
  801bf5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bf7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	52                   	push   %edx
  801c04:	50                   	push   %eax
  801c05:	6a 07                	push   $0x7
  801c07:	e8 fb fe ff ff       	call   801b07 <syscall>
  801c0c:	83 c4 18             	add    $0x18,%esp
}
  801c0f:	c9                   	leave  
  801c10:	c3                   	ret    

00801c11 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c11:	55                   	push   %ebp
  801c12:	89 e5                	mov    %esp,%ebp
  801c14:	56                   	push   %esi
  801c15:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c16:	8b 75 18             	mov    0x18(%ebp),%esi
  801c19:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c1c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c22:	8b 45 08             	mov    0x8(%ebp),%eax
  801c25:	56                   	push   %esi
  801c26:	53                   	push   %ebx
  801c27:	51                   	push   %ecx
  801c28:	52                   	push   %edx
  801c29:	50                   	push   %eax
  801c2a:	6a 08                	push   $0x8
  801c2c:	e8 d6 fe ff ff       	call   801b07 <syscall>
  801c31:	83 c4 18             	add    $0x18,%esp
}
  801c34:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c37:	5b                   	pop    %ebx
  801c38:	5e                   	pop    %esi
  801c39:	5d                   	pop    %ebp
  801c3a:	c3                   	ret    

00801c3b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c3b:	55                   	push   %ebp
  801c3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c41:	8b 45 08             	mov    0x8(%ebp),%eax
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	52                   	push   %edx
  801c4b:	50                   	push   %eax
  801c4c:	6a 09                	push   $0x9
  801c4e:	e8 b4 fe ff ff       	call   801b07 <syscall>
  801c53:	83 c4 18             	add    $0x18,%esp
}
  801c56:	c9                   	leave  
  801c57:	c3                   	ret    

00801c58 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c58:	55                   	push   %ebp
  801c59:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	6a 00                	push   $0x0
  801c61:	ff 75 0c             	pushl  0xc(%ebp)
  801c64:	ff 75 08             	pushl  0x8(%ebp)
  801c67:	6a 0a                	push   $0xa
  801c69:	e8 99 fe ff ff       	call   801b07 <syscall>
  801c6e:	83 c4 18             	add    $0x18,%esp
}
  801c71:	c9                   	leave  
  801c72:	c3                   	ret    

00801c73 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c73:	55                   	push   %ebp
  801c74:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 0b                	push   $0xb
  801c82:	e8 80 fe ff ff       	call   801b07 <syscall>
  801c87:	83 c4 18             	add    $0x18,%esp
}
  801c8a:	c9                   	leave  
  801c8b:	c3                   	ret    

00801c8c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c8c:	55                   	push   %ebp
  801c8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 0c                	push   $0xc
  801c9b:	e8 67 fe ff ff       	call   801b07 <syscall>
  801ca0:	83 c4 18             	add    $0x18,%esp
}
  801ca3:	c9                   	leave  
  801ca4:	c3                   	ret    

00801ca5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ca5:	55                   	push   %ebp
  801ca6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 0d                	push   $0xd
  801cb4:	e8 4e fe ff ff       	call   801b07 <syscall>
  801cb9:	83 c4 18             	add    $0x18,%esp
}
  801cbc:	c9                   	leave  
  801cbd:	c3                   	ret    

00801cbe <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801cbe:	55                   	push   %ebp
  801cbf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	ff 75 0c             	pushl  0xc(%ebp)
  801cca:	ff 75 08             	pushl  0x8(%ebp)
  801ccd:	6a 11                	push   $0x11
  801ccf:	e8 33 fe ff ff       	call   801b07 <syscall>
  801cd4:	83 c4 18             	add    $0x18,%esp
	return;
  801cd7:	90                   	nop
}
  801cd8:	c9                   	leave  
  801cd9:	c3                   	ret    

00801cda <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801cda:	55                   	push   %ebp
  801cdb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	ff 75 0c             	pushl  0xc(%ebp)
  801ce6:	ff 75 08             	pushl  0x8(%ebp)
  801ce9:	6a 12                	push   $0x12
  801ceb:	e8 17 fe ff ff       	call   801b07 <syscall>
  801cf0:	83 c4 18             	add    $0x18,%esp
	return ;
  801cf3:	90                   	nop
}
  801cf4:	c9                   	leave  
  801cf5:	c3                   	ret    

00801cf6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801cf6:	55                   	push   %ebp
  801cf7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 0e                	push   $0xe
  801d05:	e8 fd fd ff ff       	call   801b07 <syscall>
  801d0a:	83 c4 18             	add    $0x18,%esp
}
  801d0d:	c9                   	leave  
  801d0e:	c3                   	ret    

00801d0f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d0f:	55                   	push   %ebp
  801d10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	ff 75 08             	pushl  0x8(%ebp)
  801d1d:	6a 0f                	push   $0xf
  801d1f:	e8 e3 fd ff ff       	call   801b07 <syscall>
  801d24:	83 c4 18             	add    $0x18,%esp
}
  801d27:	c9                   	leave  
  801d28:	c3                   	ret    

00801d29 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d29:	55                   	push   %ebp
  801d2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	6a 10                	push   $0x10
  801d38:	e8 ca fd ff ff       	call   801b07 <syscall>
  801d3d:	83 c4 18             	add    $0x18,%esp
}
  801d40:	90                   	nop
  801d41:	c9                   	leave  
  801d42:	c3                   	ret    

00801d43 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d43:	55                   	push   %ebp
  801d44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 14                	push   $0x14
  801d52:	e8 b0 fd ff ff       	call   801b07 <syscall>
  801d57:	83 c4 18             	add    $0x18,%esp
}
  801d5a:	90                   	nop
  801d5b:	c9                   	leave  
  801d5c:	c3                   	ret    

00801d5d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d5d:	55                   	push   %ebp
  801d5e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d60:	6a 00                	push   $0x0
  801d62:	6a 00                	push   $0x0
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 15                	push   $0x15
  801d6c:	e8 96 fd ff ff       	call   801b07 <syscall>
  801d71:	83 c4 18             	add    $0x18,%esp
}
  801d74:	90                   	nop
  801d75:	c9                   	leave  
  801d76:	c3                   	ret    

00801d77 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d77:	55                   	push   %ebp
  801d78:	89 e5                	mov    %esp,%ebp
  801d7a:	83 ec 04             	sub    $0x4,%esp
  801d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d80:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d83:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 00                	push   $0x0
  801d8d:	6a 00                	push   $0x0
  801d8f:	50                   	push   %eax
  801d90:	6a 16                	push   $0x16
  801d92:	e8 70 fd ff ff       	call   801b07 <syscall>
  801d97:	83 c4 18             	add    $0x18,%esp
}
  801d9a:	90                   	nop
  801d9b:	c9                   	leave  
  801d9c:	c3                   	ret    

00801d9d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d9d:	55                   	push   %ebp
  801d9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 17                	push   $0x17
  801dac:	e8 56 fd ff ff       	call   801b07 <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
}
  801db4:	90                   	nop
  801db5:	c9                   	leave  
  801db6:	c3                   	ret    

00801db7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801db7:	55                   	push   %ebp
  801db8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801dba:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	ff 75 0c             	pushl  0xc(%ebp)
  801dc6:	50                   	push   %eax
  801dc7:	6a 18                	push   $0x18
  801dc9:	e8 39 fd ff ff       	call   801b07 <syscall>
  801dce:	83 c4 18             	add    $0x18,%esp
}
  801dd1:	c9                   	leave  
  801dd2:	c3                   	ret    

00801dd3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801dd3:	55                   	push   %ebp
  801dd4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	52                   	push   %edx
  801de3:	50                   	push   %eax
  801de4:	6a 1b                	push   $0x1b
  801de6:	e8 1c fd ff ff       	call   801b07 <syscall>
  801deb:	83 c4 18             	add    $0x18,%esp
}
  801dee:	c9                   	leave  
  801def:	c3                   	ret    

00801df0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801df0:	55                   	push   %ebp
  801df1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801df3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801df6:	8b 45 08             	mov    0x8(%ebp),%eax
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	52                   	push   %edx
  801e00:	50                   	push   %eax
  801e01:	6a 19                	push   $0x19
  801e03:	e8 ff fc ff ff       	call   801b07 <syscall>
  801e08:	83 c4 18             	add    $0x18,%esp
}
  801e0b:	90                   	nop
  801e0c:	c9                   	leave  
  801e0d:	c3                   	ret    

00801e0e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e0e:	55                   	push   %ebp
  801e0f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e11:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e14:	8b 45 08             	mov    0x8(%ebp),%eax
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	52                   	push   %edx
  801e1e:	50                   	push   %eax
  801e1f:	6a 1a                	push   $0x1a
  801e21:	e8 e1 fc ff ff       	call   801b07 <syscall>
  801e26:	83 c4 18             	add    $0x18,%esp
}
  801e29:	90                   	nop
  801e2a:	c9                   	leave  
  801e2b:	c3                   	ret    

00801e2c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e2c:	55                   	push   %ebp
  801e2d:	89 e5                	mov    %esp,%ebp
  801e2f:	83 ec 04             	sub    $0x4,%esp
  801e32:	8b 45 10             	mov    0x10(%ebp),%eax
  801e35:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e38:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e3b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e42:	6a 00                	push   $0x0
  801e44:	51                   	push   %ecx
  801e45:	52                   	push   %edx
  801e46:	ff 75 0c             	pushl  0xc(%ebp)
  801e49:	50                   	push   %eax
  801e4a:	6a 1c                	push   $0x1c
  801e4c:	e8 b6 fc ff ff       	call   801b07 <syscall>
  801e51:	83 c4 18             	add    $0x18,%esp
}
  801e54:	c9                   	leave  
  801e55:	c3                   	ret    

00801e56 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e56:	55                   	push   %ebp
  801e57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e59:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	52                   	push   %edx
  801e66:	50                   	push   %eax
  801e67:	6a 1d                	push   $0x1d
  801e69:	e8 99 fc ff ff       	call   801b07 <syscall>
  801e6e:	83 c4 18             	add    $0x18,%esp
}
  801e71:	c9                   	leave  
  801e72:	c3                   	ret    

00801e73 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e73:	55                   	push   %ebp
  801e74:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e76:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e79:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7f:	6a 00                	push   $0x0
  801e81:	6a 00                	push   $0x0
  801e83:	51                   	push   %ecx
  801e84:	52                   	push   %edx
  801e85:	50                   	push   %eax
  801e86:	6a 1e                	push   $0x1e
  801e88:	e8 7a fc ff ff       	call   801b07 <syscall>
  801e8d:	83 c4 18             	add    $0x18,%esp
}
  801e90:	c9                   	leave  
  801e91:	c3                   	ret    

00801e92 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e92:	55                   	push   %ebp
  801e93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e98:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	52                   	push   %edx
  801ea2:	50                   	push   %eax
  801ea3:	6a 1f                	push   $0x1f
  801ea5:	e8 5d fc ff ff       	call   801b07 <syscall>
  801eaa:	83 c4 18             	add    $0x18,%esp
}
  801ead:	c9                   	leave  
  801eae:	c3                   	ret    

00801eaf <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801eaf:	55                   	push   %ebp
  801eb0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801eb2:	6a 00                	push   $0x0
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 20                	push   $0x20
  801ebe:	e8 44 fc ff ff       	call   801b07 <syscall>
  801ec3:	83 c4 18             	add    $0x18,%esp
}
  801ec6:	c9                   	leave  
  801ec7:	c3                   	ret    

00801ec8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ec8:	55                   	push   %ebp
  801ec9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ece:	6a 00                	push   $0x0
  801ed0:	ff 75 14             	pushl  0x14(%ebp)
  801ed3:	ff 75 10             	pushl  0x10(%ebp)
  801ed6:	ff 75 0c             	pushl  0xc(%ebp)
  801ed9:	50                   	push   %eax
  801eda:	6a 21                	push   $0x21
  801edc:	e8 26 fc ff ff       	call   801b07 <syscall>
  801ee1:	83 c4 18             	add    $0x18,%esp
}
  801ee4:	c9                   	leave  
  801ee5:	c3                   	ret    

00801ee6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ee6:	55                   	push   %ebp
  801ee7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	50                   	push   %eax
  801ef5:	6a 22                	push   $0x22
  801ef7:	e8 0b fc ff ff       	call   801b07 <syscall>
  801efc:	83 c4 18             	add    $0x18,%esp
}
  801eff:	90                   	nop
  801f00:	c9                   	leave  
  801f01:	c3                   	ret    

00801f02 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f02:	55                   	push   %ebp
  801f03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f05:	8b 45 08             	mov    0x8(%ebp),%eax
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	50                   	push   %eax
  801f11:	6a 23                	push   $0x23
  801f13:	e8 ef fb ff ff       	call   801b07 <syscall>
  801f18:	83 c4 18             	add    $0x18,%esp
}
  801f1b:	90                   	nop
  801f1c:	c9                   	leave  
  801f1d:	c3                   	ret    

00801f1e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f1e:	55                   	push   %ebp
  801f1f:	89 e5                	mov    %esp,%ebp
  801f21:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f24:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f27:	8d 50 04             	lea    0x4(%eax),%edx
  801f2a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	52                   	push   %edx
  801f34:	50                   	push   %eax
  801f35:	6a 24                	push   $0x24
  801f37:	e8 cb fb ff ff       	call   801b07 <syscall>
  801f3c:	83 c4 18             	add    $0x18,%esp
	return result;
  801f3f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f42:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f45:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f48:	89 01                	mov    %eax,(%ecx)
  801f4a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f50:	c9                   	leave  
  801f51:	c2 04 00             	ret    $0x4

00801f54 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f54:	55                   	push   %ebp
  801f55:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	ff 75 10             	pushl  0x10(%ebp)
  801f5e:	ff 75 0c             	pushl  0xc(%ebp)
  801f61:	ff 75 08             	pushl  0x8(%ebp)
  801f64:	6a 13                	push   $0x13
  801f66:	e8 9c fb ff ff       	call   801b07 <syscall>
  801f6b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f6e:	90                   	nop
}
  801f6f:	c9                   	leave  
  801f70:	c3                   	ret    

00801f71 <sys_rcr2>:
uint32 sys_rcr2()
{
  801f71:	55                   	push   %ebp
  801f72:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 25                	push   $0x25
  801f80:	e8 82 fb ff ff       	call   801b07 <syscall>
  801f85:	83 c4 18             	add    $0x18,%esp
}
  801f88:	c9                   	leave  
  801f89:	c3                   	ret    

00801f8a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f8a:	55                   	push   %ebp
  801f8b:	89 e5                	mov    %esp,%ebp
  801f8d:	83 ec 04             	sub    $0x4,%esp
  801f90:	8b 45 08             	mov    0x8(%ebp),%eax
  801f93:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f96:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	50                   	push   %eax
  801fa3:	6a 26                	push   $0x26
  801fa5:	e8 5d fb ff ff       	call   801b07 <syscall>
  801faa:	83 c4 18             	add    $0x18,%esp
	return ;
  801fad:	90                   	nop
}
  801fae:	c9                   	leave  
  801faf:	c3                   	ret    

00801fb0 <rsttst>:
void rsttst()
{
  801fb0:	55                   	push   %ebp
  801fb1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 28                	push   $0x28
  801fbf:	e8 43 fb ff ff       	call   801b07 <syscall>
  801fc4:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc7:	90                   	nop
}
  801fc8:	c9                   	leave  
  801fc9:	c3                   	ret    

00801fca <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801fca:	55                   	push   %ebp
  801fcb:	89 e5                	mov    %esp,%ebp
  801fcd:	83 ec 04             	sub    $0x4,%esp
  801fd0:	8b 45 14             	mov    0x14(%ebp),%eax
  801fd3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801fd6:	8b 55 18             	mov    0x18(%ebp),%edx
  801fd9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fdd:	52                   	push   %edx
  801fde:	50                   	push   %eax
  801fdf:	ff 75 10             	pushl  0x10(%ebp)
  801fe2:	ff 75 0c             	pushl  0xc(%ebp)
  801fe5:	ff 75 08             	pushl  0x8(%ebp)
  801fe8:	6a 27                	push   $0x27
  801fea:	e8 18 fb ff ff       	call   801b07 <syscall>
  801fef:	83 c4 18             	add    $0x18,%esp
	return ;
  801ff2:	90                   	nop
}
  801ff3:	c9                   	leave  
  801ff4:	c3                   	ret    

00801ff5 <chktst>:
void chktst(uint32 n)
{
  801ff5:	55                   	push   %ebp
  801ff6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 00                	push   $0x0
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 00                	push   $0x0
  802000:	ff 75 08             	pushl  0x8(%ebp)
  802003:	6a 29                	push   $0x29
  802005:	e8 fd fa ff ff       	call   801b07 <syscall>
  80200a:	83 c4 18             	add    $0x18,%esp
	return ;
  80200d:	90                   	nop
}
  80200e:	c9                   	leave  
  80200f:	c3                   	ret    

00802010 <inctst>:

void inctst()
{
  802010:	55                   	push   %ebp
  802011:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	6a 2a                	push   $0x2a
  80201f:	e8 e3 fa ff ff       	call   801b07 <syscall>
  802024:	83 c4 18             	add    $0x18,%esp
	return ;
  802027:	90                   	nop
}
  802028:	c9                   	leave  
  802029:	c3                   	ret    

0080202a <gettst>:
uint32 gettst()
{
  80202a:	55                   	push   %ebp
  80202b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	6a 00                	push   $0x0
  802037:	6a 2b                	push   $0x2b
  802039:	e8 c9 fa ff ff       	call   801b07 <syscall>
  80203e:	83 c4 18             	add    $0x18,%esp
}
  802041:	c9                   	leave  
  802042:	c3                   	ret    

00802043 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802043:	55                   	push   %ebp
  802044:	89 e5                	mov    %esp,%ebp
  802046:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	6a 2c                	push   $0x2c
  802055:	e8 ad fa ff ff       	call   801b07 <syscall>
  80205a:	83 c4 18             	add    $0x18,%esp
  80205d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802060:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802064:	75 07                	jne    80206d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802066:	b8 01 00 00 00       	mov    $0x1,%eax
  80206b:	eb 05                	jmp    802072 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80206d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802072:	c9                   	leave  
  802073:	c3                   	ret    

00802074 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802074:	55                   	push   %ebp
  802075:	89 e5                	mov    %esp,%ebp
  802077:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80207a:	6a 00                	push   $0x0
  80207c:	6a 00                	push   $0x0
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 2c                	push   $0x2c
  802086:	e8 7c fa ff ff       	call   801b07 <syscall>
  80208b:	83 c4 18             	add    $0x18,%esp
  80208e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802091:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802095:	75 07                	jne    80209e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802097:	b8 01 00 00 00       	mov    $0x1,%eax
  80209c:	eb 05                	jmp    8020a3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80209e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020a3:	c9                   	leave  
  8020a4:	c3                   	ret    

008020a5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8020a5:	55                   	push   %ebp
  8020a6:	89 e5                	mov    %esp,%ebp
  8020a8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 2c                	push   $0x2c
  8020b7:	e8 4b fa ff ff       	call   801b07 <syscall>
  8020bc:	83 c4 18             	add    $0x18,%esp
  8020bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8020c2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8020c6:	75 07                	jne    8020cf <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8020c8:	b8 01 00 00 00       	mov    $0x1,%eax
  8020cd:	eb 05                	jmp    8020d4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8020cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020d4:	c9                   	leave  
  8020d5:	c3                   	ret    

008020d6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8020d6:	55                   	push   %ebp
  8020d7:	89 e5                	mov    %esp,%ebp
  8020d9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 00                	push   $0x0
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 2c                	push   $0x2c
  8020e8:	e8 1a fa ff ff       	call   801b07 <syscall>
  8020ed:	83 c4 18             	add    $0x18,%esp
  8020f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8020f3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8020f7:	75 07                	jne    802100 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8020f9:	b8 01 00 00 00       	mov    $0x1,%eax
  8020fe:	eb 05                	jmp    802105 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802100:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802105:	c9                   	leave  
  802106:	c3                   	ret    

00802107 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802107:	55                   	push   %ebp
  802108:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80210a:	6a 00                	push   $0x0
  80210c:	6a 00                	push   $0x0
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	ff 75 08             	pushl  0x8(%ebp)
  802115:	6a 2d                	push   $0x2d
  802117:	e8 eb f9 ff ff       	call   801b07 <syscall>
  80211c:	83 c4 18             	add    $0x18,%esp
	return ;
  80211f:	90                   	nop
}
  802120:	c9                   	leave  
  802121:	c3                   	ret    

00802122 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802122:	55                   	push   %ebp
  802123:	89 e5                	mov    %esp,%ebp
  802125:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802126:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802129:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80212c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80212f:	8b 45 08             	mov    0x8(%ebp),%eax
  802132:	6a 00                	push   $0x0
  802134:	53                   	push   %ebx
  802135:	51                   	push   %ecx
  802136:	52                   	push   %edx
  802137:	50                   	push   %eax
  802138:	6a 2e                	push   $0x2e
  80213a:	e8 c8 f9 ff ff       	call   801b07 <syscall>
  80213f:	83 c4 18             	add    $0x18,%esp
}
  802142:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802145:	c9                   	leave  
  802146:	c3                   	ret    

00802147 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802147:	55                   	push   %ebp
  802148:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80214a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80214d:	8b 45 08             	mov    0x8(%ebp),%eax
  802150:	6a 00                	push   $0x0
  802152:	6a 00                	push   $0x0
  802154:	6a 00                	push   $0x0
  802156:	52                   	push   %edx
  802157:	50                   	push   %eax
  802158:	6a 2f                	push   $0x2f
  80215a:	e8 a8 f9 ff ff       	call   801b07 <syscall>
  80215f:	83 c4 18             	add    $0x18,%esp
}
  802162:	c9                   	leave  
  802163:	c3                   	ret    

00802164 <__udivdi3>:
  802164:	55                   	push   %ebp
  802165:	57                   	push   %edi
  802166:	56                   	push   %esi
  802167:	53                   	push   %ebx
  802168:	83 ec 1c             	sub    $0x1c,%esp
  80216b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80216f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802173:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802177:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80217b:	89 ca                	mov    %ecx,%edx
  80217d:	89 f8                	mov    %edi,%eax
  80217f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802183:	85 f6                	test   %esi,%esi
  802185:	75 2d                	jne    8021b4 <__udivdi3+0x50>
  802187:	39 cf                	cmp    %ecx,%edi
  802189:	77 65                	ja     8021f0 <__udivdi3+0x8c>
  80218b:	89 fd                	mov    %edi,%ebp
  80218d:	85 ff                	test   %edi,%edi
  80218f:	75 0b                	jne    80219c <__udivdi3+0x38>
  802191:	b8 01 00 00 00       	mov    $0x1,%eax
  802196:	31 d2                	xor    %edx,%edx
  802198:	f7 f7                	div    %edi
  80219a:	89 c5                	mov    %eax,%ebp
  80219c:	31 d2                	xor    %edx,%edx
  80219e:	89 c8                	mov    %ecx,%eax
  8021a0:	f7 f5                	div    %ebp
  8021a2:	89 c1                	mov    %eax,%ecx
  8021a4:	89 d8                	mov    %ebx,%eax
  8021a6:	f7 f5                	div    %ebp
  8021a8:	89 cf                	mov    %ecx,%edi
  8021aa:	89 fa                	mov    %edi,%edx
  8021ac:	83 c4 1c             	add    $0x1c,%esp
  8021af:	5b                   	pop    %ebx
  8021b0:	5e                   	pop    %esi
  8021b1:	5f                   	pop    %edi
  8021b2:	5d                   	pop    %ebp
  8021b3:	c3                   	ret    
  8021b4:	39 ce                	cmp    %ecx,%esi
  8021b6:	77 28                	ja     8021e0 <__udivdi3+0x7c>
  8021b8:	0f bd fe             	bsr    %esi,%edi
  8021bb:	83 f7 1f             	xor    $0x1f,%edi
  8021be:	75 40                	jne    802200 <__udivdi3+0x9c>
  8021c0:	39 ce                	cmp    %ecx,%esi
  8021c2:	72 0a                	jb     8021ce <__udivdi3+0x6a>
  8021c4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8021c8:	0f 87 9e 00 00 00    	ja     80226c <__udivdi3+0x108>
  8021ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8021d3:	89 fa                	mov    %edi,%edx
  8021d5:	83 c4 1c             	add    $0x1c,%esp
  8021d8:	5b                   	pop    %ebx
  8021d9:	5e                   	pop    %esi
  8021da:	5f                   	pop    %edi
  8021db:	5d                   	pop    %ebp
  8021dc:	c3                   	ret    
  8021dd:	8d 76 00             	lea    0x0(%esi),%esi
  8021e0:	31 ff                	xor    %edi,%edi
  8021e2:	31 c0                	xor    %eax,%eax
  8021e4:	89 fa                	mov    %edi,%edx
  8021e6:	83 c4 1c             	add    $0x1c,%esp
  8021e9:	5b                   	pop    %ebx
  8021ea:	5e                   	pop    %esi
  8021eb:	5f                   	pop    %edi
  8021ec:	5d                   	pop    %ebp
  8021ed:	c3                   	ret    
  8021ee:	66 90                	xchg   %ax,%ax
  8021f0:	89 d8                	mov    %ebx,%eax
  8021f2:	f7 f7                	div    %edi
  8021f4:	31 ff                	xor    %edi,%edi
  8021f6:	89 fa                	mov    %edi,%edx
  8021f8:	83 c4 1c             	add    $0x1c,%esp
  8021fb:	5b                   	pop    %ebx
  8021fc:	5e                   	pop    %esi
  8021fd:	5f                   	pop    %edi
  8021fe:	5d                   	pop    %ebp
  8021ff:	c3                   	ret    
  802200:	bd 20 00 00 00       	mov    $0x20,%ebp
  802205:	89 eb                	mov    %ebp,%ebx
  802207:	29 fb                	sub    %edi,%ebx
  802209:	89 f9                	mov    %edi,%ecx
  80220b:	d3 e6                	shl    %cl,%esi
  80220d:	89 c5                	mov    %eax,%ebp
  80220f:	88 d9                	mov    %bl,%cl
  802211:	d3 ed                	shr    %cl,%ebp
  802213:	89 e9                	mov    %ebp,%ecx
  802215:	09 f1                	or     %esi,%ecx
  802217:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80221b:	89 f9                	mov    %edi,%ecx
  80221d:	d3 e0                	shl    %cl,%eax
  80221f:	89 c5                	mov    %eax,%ebp
  802221:	89 d6                	mov    %edx,%esi
  802223:	88 d9                	mov    %bl,%cl
  802225:	d3 ee                	shr    %cl,%esi
  802227:	89 f9                	mov    %edi,%ecx
  802229:	d3 e2                	shl    %cl,%edx
  80222b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80222f:	88 d9                	mov    %bl,%cl
  802231:	d3 e8                	shr    %cl,%eax
  802233:	09 c2                	or     %eax,%edx
  802235:	89 d0                	mov    %edx,%eax
  802237:	89 f2                	mov    %esi,%edx
  802239:	f7 74 24 0c          	divl   0xc(%esp)
  80223d:	89 d6                	mov    %edx,%esi
  80223f:	89 c3                	mov    %eax,%ebx
  802241:	f7 e5                	mul    %ebp
  802243:	39 d6                	cmp    %edx,%esi
  802245:	72 19                	jb     802260 <__udivdi3+0xfc>
  802247:	74 0b                	je     802254 <__udivdi3+0xf0>
  802249:	89 d8                	mov    %ebx,%eax
  80224b:	31 ff                	xor    %edi,%edi
  80224d:	e9 58 ff ff ff       	jmp    8021aa <__udivdi3+0x46>
  802252:	66 90                	xchg   %ax,%ax
  802254:	8b 54 24 08          	mov    0x8(%esp),%edx
  802258:	89 f9                	mov    %edi,%ecx
  80225a:	d3 e2                	shl    %cl,%edx
  80225c:	39 c2                	cmp    %eax,%edx
  80225e:	73 e9                	jae    802249 <__udivdi3+0xe5>
  802260:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802263:	31 ff                	xor    %edi,%edi
  802265:	e9 40 ff ff ff       	jmp    8021aa <__udivdi3+0x46>
  80226a:	66 90                	xchg   %ax,%ax
  80226c:	31 c0                	xor    %eax,%eax
  80226e:	e9 37 ff ff ff       	jmp    8021aa <__udivdi3+0x46>
  802273:	90                   	nop

00802274 <__umoddi3>:
  802274:	55                   	push   %ebp
  802275:	57                   	push   %edi
  802276:	56                   	push   %esi
  802277:	53                   	push   %ebx
  802278:	83 ec 1c             	sub    $0x1c,%esp
  80227b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80227f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802283:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802287:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80228b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80228f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802293:	89 f3                	mov    %esi,%ebx
  802295:	89 fa                	mov    %edi,%edx
  802297:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80229b:	89 34 24             	mov    %esi,(%esp)
  80229e:	85 c0                	test   %eax,%eax
  8022a0:	75 1a                	jne    8022bc <__umoddi3+0x48>
  8022a2:	39 f7                	cmp    %esi,%edi
  8022a4:	0f 86 a2 00 00 00    	jbe    80234c <__umoddi3+0xd8>
  8022aa:	89 c8                	mov    %ecx,%eax
  8022ac:	89 f2                	mov    %esi,%edx
  8022ae:	f7 f7                	div    %edi
  8022b0:	89 d0                	mov    %edx,%eax
  8022b2:	31 d2                	xor    %edx,%edx
  8022b4:	83 c4 1c             	add    $0x1c,%esp
  8022b7:	5b                   	pop    %ebx
  8022b8:	5e                   	pop    %esi
  8022b9:	5f                   	pop    %edi
  8022ba:	5d                   	pop    %ebp
  8022bb:	c3                   	ret    
  8022bc:	39 f0                	cmp    %esi,%eax
  8022be:	0f 87 ac 00 00 00    	ja     802370 <__umoddi3+0xfc>
  8022c4:	0f bd e8             	bsr    %eax,%ebp
  8022c7:	83 f5 1f             	xor    $0x1f,%ebp
  8022ca:	0f 84 ac 00 00 00    	je     80237c <__umoddi3+0x108>
  8022d0:	bf 20 00 00 00       	mov    $0x20,%edi
  8022d5:	29 ef                	sub    %ebp,%edi
  8022d7:	89 fe                	mov    %edi,%esi
  8022d9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8022dd:	89 e9                	mov    %ebp,%ecx
  8022df:	d3 e0                	shl    %cl,%eax
  8022e1:	89 d7                	mov    %edx,%edi
  8022e3:	89 f1                	mov    %esi,%ecx
  8022e5:	d3 ef                	shr    %cl,%edi
  8022e7:	09 c7                	or     %eax,%edi
  8022e9:	89 e9                	mov    %ebp,%ecx
  8022eb:	d3 e2                	shl    %cl,%edx
  8022ed:	89 14 24             	mov    %edx,(%esp)
  8022f0:	89 d8                	mov    %ebx,%eax
  8022f2:	d3 e0                	shl    %cl,%eax
  8022f4:	89 c2                	mov    %eax,%edx
  8022f6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022fa:	d3 e0                	shl    %cl,%eax
  8022fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  802300:	8b 44 24 08          	mov    0x8(%esp),%eax
  802304:	89 f1                	mov    %esi,%ecx
  802306:	d3 e8                	shr    %cl,%eax
  802308:	09 d0                	or     %edx,%eax
  80230a:	d3 eb                	shr    %cl,%ebx
  80230c:	89 da                	mov    %ebx,%edx
  80230e:	f7 f7                	div    %edi
  802310:	89 d3                	mov    %edx,%ebx
  802312:	f7 24 24             	mull   (%esp)
  802315:	89 c6                	mov    %eax,%esi
  802317:	89 d1                	mov    %edx,%ecx
  802319:	39 d3                	cmp    %edx,%ebx
  80231b:	0f 82 87 00 00 00    	jb     8023a8 <__umoddi3+0x134>
  802321:	0f 84 91 00 00 00    	je     8023b8 <__umoddi3+0x144>
  802327:	8b 54 24 04          	mov    0x4(%esp),%edx
  80232b:	29 f2                	sub    %esi,%edx
  80232d:	19 cb                	sbb    %ecx,%ebx
  80232f:	89 d8                	mov    %ebx,%eax
  802331:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802335:	d3 e0                	shl    %cl,%eax
  802337:	89 e9                	mov    %ebp,%ecx
  802339:	d3 ea                	shr    %cl,%edx
  80233b:	09 d0                	or     %edx,%eax
  80233d:	89 e9                	mov    %ebp,%ecx
  80233f:	d3 eb                	shr    %cl,%ebx
  802341:	89 da                	mov    %ebx,%edx
  802343:	83 c4 1c             	add    $0x1c,%esp
  802346:	5b                   	pop    %ebx
  802347:	5e                   	pop    %esi
  802348:	5f                   	pop    %edi
  802349:	5d                   	pop    %ebp
  80234a:	c3                   	ret    
  80234b:	90                   	nop
  80234c:	89 fd                	mov    %edi,%ebp
  80234e:	85 ff                	test   %edi,%edi
  802350:	75 0b                	jne    80235d <__umoddi3+0xe9>
  802352:	b8 01 00 00 00       	mov    $0x1,%eax
  802357:	31 d2                	xor    %edx,%edx
  802359:	f7 f7                	div    %edi
  80235b:	89 c5                	mov    %eax,%ebp
  80235d:	89 f0                	mov    %esi,%eax
  80235f:	31 d2                	xor    %edx,%edx
  802361:	f7 f5                	div    %ebp
  802363:	89 c8                	mov    %ecx,%eax
  802365:	f7 f5                	div    %ebp
  802367:	89 d0                	mov    %edx,%eax
  802369:	e9 44 ff ff ff       	jmp    8022b2 <__umoddi3+0x3e>
  80236e:	66 90                	xchg   %ax,%ax
  802370:	89 c8                	mov    %ecx,%eax
  802372:	89 f2                	mov    %esi,%edx
  802374:	83 c4 1c             	add    $0x1c,%esp
  802377:	5b                   	pop    %ebx
  802378:	5e                   	pop    %esi
  802379:	5f                   	pop    %edi
  80237a:	5d                   	pop    %ebp
  80237b:	c3                   	ret    
  80237c:	3b 04 24             	cmp    (%esp),%eax
  80237f:	72 06                	jb     802387 <__umoddi3+0x113>
  802381:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802385:	77 0f                	ja     802396 <__umoddi3+0x122>
  802387:	89 f2                	mov    %esi,%edx
  802389:	29 f9                	sub    %edi,%ecx
  80238b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80238f:	89 14 24             	mov    %edx,(%esp)
  802392:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802396:	8b 44 24 04          	mov    0x4(%esp),%eax
  80239a:	8b 14 24             	mov    (%esp),%edx
  80239d:	83 c4 1c             	add    $0x1c,%esp
  8023a0:	5b                   	pop    %ebx
  8023a1:	5e                   	pop    %esi
  8023a2:	5f                   	pop    %edi
  8023a3:	5d                   	pop    %ebp
  8023a4:	c3                   	ret    
  8023a5:	8d 76 00             	lea    0x0(%esi),%esi
  8023a8:	2b 04 24             	sub    (%esp),%eax
  8023ab:	19 fa                	sbb    %edi,%edx
  8023ad:	89 d1                	mov    %edx,%ecx
  8023af:	89 c6                	mov    %eax,%esi
  8023b1:	e9 71 ff ff ff       	jmp    802327 <__umoddi3+0xb3>
  8023b6:	66 90                	xchg   %ax,%ax
  8023b8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023bc:	72 ea                	jb     8023a8 <__umoddi3+0x134>
  8023be:	89 d9                	mov    %ebx,%ecx
  8023c0:	e9 62 ff ff ff       	jmp    802327 <__umoddi3+0xb3>
