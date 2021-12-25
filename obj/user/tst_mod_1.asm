
obj/user/tst_mod_1:     file format elf32-i386


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
  800031:	e8 6f 05 00 00       	call   8005a5 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* MAKE SURE PAGE_WS_MAX_SIZE = 2000 */
/* *********************************************************** */
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 34             	sub    $0x34,%esp
	int envID = sys_getenvid();
  80003f:	e8 8c 1b 00 00       	call   801bd0 <sys_getenvid>
  800044:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cprintf("envID = %d\n",envID);
  800047:	83 ec 08             	sub    $0x8,%esp
  80004a:	ff 75 f4             	pushl  -0xc(%ebp)
  80004d:	68 20 24 80 00       	push   $0x802420
  800052:	e8 35 09 00 00       	call   80098c <cprintf>
  800057:	83 c4 10             	add    $0x10,%esp

	volatile struct Env* myEnv;
	myEnv = &(envs[envID]);
  80005a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80005d:	89 d0                	mov    %edx,%eax
  80005f:	c1 e0 03             	shl    $0x3,%eax
  800062:	01 d0                	add    %edx,%eax
  800064:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80006b:	01 c8                	add    %ecx,%eax
  80006d:	01 c0                	add    %eax,%eax
  80006f:	01 d0                	add    %edx,%eax
  800071:	01 c0                	add    %eax,%eax
  800073:	01 d0                	add    %edx,%eax
  800075:	89 c2                	mov    %eax,%edx
  800077:	c1 e2 05             	shl    $0x5,%edx
  80007a:	29 c2                	sub    %eax,%edx
  80007c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800083:	89 c2                	mov    %eax,%edx
  800085:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80008b:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int Mega = 1024*1024;
  80008e:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  800095:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)


	uint8 *x ;
	{
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80009c:	e8 96 1c 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  8000a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int freeFrames = sys_calculate_free_frames() ;
  8000a4:	e8 0b 1c 00 00       	call   801cb4 <sys_calculate_free_frames>
  8000a9:	89 45 e0             	mov    %eax,-0x20(%ebp)

		//allocate 2 MB in the heap

		x = malloc(2*Mega) ;
  8000ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000af:	01 c0                	add    %eax,%eax
  8000b1:	83 ec 0c             	sub    $0xc,%esp
  8000b4:	50                   	push   %eax
  8000b5:	e8 5c 16 00 00       	call   801716 <malloc>
  8000ba:	83 c4 10             	add    $0x10,%esp
  8000bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
		assert((uint32) x == USER_HEAP_START);
  8000c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000c3:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000c8:	74 16                	je     8000e0 <_main+0xa8>
  8000ca:	68 2c 24 80 00       	push   $0x80242c
  8000cf:	68 4a 24 80 00       	push   $0x80244a
  8000d4:	6a 1a                	push   $0x1a
  8000d6:	68 5f 24 80 00       	push   $0x80245f
  8000db:	e8 0a 06 00 00       	call   8006ea <_panic>
		//		cprintf("Allocated frames = %d\n", (freeFrames - sys_calculate_free_frames())) ;
		assert((freeFrames - sys_calculate_free_frames()) == (/*1 +*/ 1 + 2 * Mega / PAGE_SIZE));
  8000e0:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8000e3:	e8 cc 1b 00 00       	call   801cb4 <sys_calculate_free_frames>
  8000e8:	29 c3                	sub    %eax,%ebx
  8000ea:	89 da                	mov    %ebx,%edx
  8000ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ef:	01 c0                	add    %eax,%eax
  8000f1:	85 c0                	test   %eax,%eax
  8000f3:	79 05                	jns    8000fa <_main+0xc2>
  8000f5:	05 ff 0f 00 00       	add    $0xfff,%eax
  8000fa:	c1 f8 0c             	sar    $0xc,%eax
  8000fd:	40                   	inc    %eax
  8000fe:	39 c2                	cmp    %eax,%edx
  800100:	74 16                	je     800118 <_main+0xe0>
  800102:	68 70 24 80 00       	push   $0x802470
  800107:	68 4a 24 80 00       	push   $0x80244a
  80010c:	6a 1c                	push   $0x1c
  80010e:	68 5f 24 80 00       	push   $0x80245f
  800113:	e8 d2 05 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  800118:	e8 1a 1c 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  80011d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800120:	74 16                	je     800138 <_main+0x100>
  800122:	68 bc 24 80 00       	push   $0x8024bc
  800127:	68 4a 24 80 00       	push   $0x80244a
  80012c:	6a 1d                	push   $0x1d
  80012e:	68 5f 24 80 00       	push   $0x80245f
  800133:	e8 b2 05 00 00       	call   8006ea <_panic>
		//assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 2 * Mega / PAGE_SIZE);

		freeFrames = sys_calculate_free_frames() ;
  800138:	e8 77 1b 00 00       	call   801cb4 <sys_calculate_free_frames>
  80013d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800140:	e8 f2 1b 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  800145:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		assert((uint32)malloc(2*Mega) == USER_HEAP_START + 2*Mega) ;
  800148:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80014b:	01 c0                	add    %eax,%eax
  80014d:	83 ec 0c             	sub    $0xc,%esp
  800150:	50                   	push   %eax
  800151:	e8 c0 15 00 00       	call   801716 <malloc>
  800156:	83 c4 10             	add    $0x10,%esp
  800159:	89 c2                	mov    %eax,%edx
  80015b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80015e:	01 c0                	add    %eax,%eax
  800160:	05 00 00 00 80       	add    $0x80000000,%eax
  800165:	39 c2                	cmp    %eax,%edx
  800167:	74 16                	je     80017f <_main+0x147>
  800169:	68 f8 24 80 00       	push   $0x8024f8
  80016e:	68 4a 24 80 00       	push   $0x80244a
  800173:	6a 22                	push   $0x22
  800175:	68 5f 24 80 00       	push   $0x80245f
  80017a:	e8 6b 05 00 00       	call   8006ea <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (2 * Mega / PAGE_SIZE));
  80017f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800182:	e8 2d 1b 00 00       	call   801cb4 <sys_calculate_free_frames>
  800187:	29 c3                	sub    %eax,%ebx
  800189:	89 da                	mov    %ebx,%edx
  80018b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018e:	01 c0                	add    %eax,%eax
  800190:	85 c0                	test   %eax,%eax
  800192:	79 05                	jns    800199 <_main+0x161>
  800194:	05 ff 0f 00 00       	add    $0xfff,%eax
  800199:	c1 f8 0c             	sar    $0xc,%eax
  80019c:	39 c2                	cmp    %eax,%edx
  80019e:	74 16                	je     8001b6 <_main+0x17e>
  8001a0:	68 2c 25 80 00       	push   $0x80252c
  8001a5:	68 4a 24 80 00       	push   $0x80244a
  8001aa:	6a 23                	push   $0x23
  8001ac:	68 5f 24 80 00       	push   $0x80245f
  8001b1:	e8 34 05 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  8001b6:	e8 7c 1b 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  8001bb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8001be:	74 16                	je     8001d6 <_main+0x19e>
  8001c0:	68 bc 24 80 00       	push   $0x8024bc
  8001c5:	68 4a 24 80 00       	push   $0x80244a
  8001ca:	6a 24                	push   $0x24
  8001cc:	68 5f 24 80 00       	push   $0x80245f
  8001d1:	e8 14 05 00 00       	call   8006ea <_panic>
		//assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 2 * Mega / PAGE_SIZE);

		freeFrames = sys_calculate_free_frames() ;
  8001d6:	e8 d9 1a 00 00       	call   801cb4 <sys_calculate_free_frames>
  8001db:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001de:	e8 54 1b 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  8001e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		assert((uint32)malloc(3*Mega) == USER_HEAP_START + 4*Mega) ;
  8001e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001e9:	89 c2                	mov    %eax,%edx
  8001eb:	01 d2                	add    %edx,%edx
  8001ed:	01 d0                	add    %edx,%eax
  8001ef:	83 ec 0c             	sub    $0xc,%esp
  8001f2:	50                   	push   %eax
  8001f3:	e8 1e 15 00 00       	call   801716 <malloc>
  8001f8:	83 c4 10             	add    $0x10,%esp
  8001fb:	89 c2                	mov    %eax,%edx
  8001fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800200:	c1 e0 02             	shl    $0x2,%eax
  800203:	05 00 00 00 80       	add    $0x80000000,%eax
  800208:	39 c2                	cmp    %eax,%edx
  80020a:	74 16                	je     800222 <_main+0x1ea>
  80020c:	68 74 25 80 00       	push   $0x802574
  800211:	68 4a 24 80 00       	push   $0x80244a
  800216:	6a 29                	push   $0x29
  800218:	68 5f 24 80 00       	push   $0x80245f
  80021d:	e8 c8 04 00 00       	call   8006ea <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (/*1 +*/1 + 3 * Mega / PAGE_SIZE));
  800222:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800225:	e8 8a 1a 00 00       	call   801cb4 <sys_calculate_free_frames>
  80022a:	89 d9                	mov    %ebx,%ecx
  80022c:	29 c1                	sub    %eax,%ecx
  80022e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800231:	89 c2                	mov    %eax,%edx
  800233:	01 d2                	add    %edx,%edx
  800235:	01 d0                	add    %edx,%eax
  800237:	85 c0                	test   %eax,%eax
  800239:	79 05                	jns    800240 <_main+0x208>
  80023b:	05 ff 0f 00 00       	add    $0xfff,%eax
  800240:	c1 f8 0c             	sar    $0xc,%eax
  800243:	40                   	inc    %eax
  800244:	39 c1                	cmp    %eax,%ecx
  800246:	74 16                	je     80025e <_main+0x226>
  800248:	68 a8 25 80 00       	push   $0x8025a8
  80024d:	68 4a 24 80 00       	push   $0x80244a
  800252:	6a 2a                	push   $0x2a
  800254:	68 5f 24 80 00       	push   $0x80245f
  800259:	e8 8c 04 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  80025e:	e8 d4 1a 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  800263:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800266:	74 16                	je     80027e <_main+0x246>
  800268:	68 bc 24 80 00       	push   $0x8024bc
  80026d:	68 4a 24 80 00       	push   $0x80244a
  800272:	6a 2b                	push   $0x2b
  800274:	68 5f 24 80 00       	push   $0x80245f
  800279:	e8 6c 04 00 00       	call   8006ea <_panic>
		//assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 3 * Mega / PAGE_SIZE);

		freeFrames = sys_calculate_free_frames() ;
  80027e:	e8 31 1a 00 00       	call   801cb4 <sys_calculate_free_frames>
  800283:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800286:	e8 ac 1a 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  80028b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		assert((uint32)malloc(2*kilo) == USER_HEAP_START + 7*Mega) ;
  80028e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800291:	01 c0                	add    %eax,%eax
  800293:	83 ec 0c             	sub    $0xc,%esp
  800296:	50                   	push   %eax
  800297:	e8 7a 14 00 00       	call   801716 <malloc>
  80029c:	83 c4 10             	add    $0x10,%esp
  80029f:	89 c1                	mov    %eax,%ecx
  8002a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8002a4:	89 d0                	mov    %edx,%eax
  8002a6:	01 c0                	add    %eax,%eax
  8002a8:	01 d0                	add    %edx,%eax
  8002aa:	01 c0                	add    %eax,%eax
  8002ac:	01 d0                	add    %edx,%eax
  8002ae:	05 00 00 00 80       	add    $0x80000000,%eax
  8002b3:	39 c1                	cmp    %eax,%ecx
  8002b5:	74 16                	je     8002cd <_main+0x295>
  8002b7:	68 f4 25 80 00       	push   $0x8025f4
  8002bc:	68 4a 24 80 00       	push   $0x80244a
  8002c1:	6a 30                	push   $0x30
  8002c3:	68 5f 24 80 00       	push   $0x80245f
  8002c8:	e8 1d 04 00 00       	call   8006ea <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (1));
  8002cd:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8002d0:	e8 df 19 00 00       	call   801cb4 <sys_calculate_free_frames>
  8002d5:	29 c3                	sub    %eax,%ebx
  8002d7:	89 d8                	mov    %ebx,%eax
  8002d9:	83 f8 01             	cmp    $0x1,%eax
  8002dc:	74 16                	je     8002f4 <_main+0x2bc>
  8002de:	68 28 26 80 00       	push   $0x802628
  8002e3:	68 4a 24 80 00       	push   $0x80244a
  8002e8:	6a 31                	push   $0x31
  8002ea:	68 5f 24 80 00       	push   $0x80245f
  8002ef:	e8 f6 03 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  8002f4:	e8 3e 1a 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  8002f9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8002fc:	74 16                	je     800314 <_main+0x2dc>
  8002fe:	68 bc 24 80 00       	push   $0x8024bc
  800303:	68 4a 24 80 00       	push   $0x80244a
  800308:	6a 32                	push   $0x32
  80030a:	68 5f 24 80 00       	push   $0x80245f
  80030f:	e8 d6 03 00 00       	call   8006ea <_panic>
		//assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 1);

		freeFrames = sys_calculate_free_frames() ;
  800314:	e8 9b 19 00 00       	call   801cb4 <sys_calculate_free_frames>
  800319:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80031c:	e8 16 1a 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  800321:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		assert((uint32)malloc(2*kilo) == USER_HEAP_START + 7*Mega + 4*kilo) ;
  800324:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800327:	01 c0                	add    %eax,%eax
  800329:	83 ec 0c             	sub    $0xc,%esp
  80032c:	50                   	push   %eax
  80032d:	e8 e4 13 00 00       	call   801716 <malloc>
  800332:	83 c4 10             	add    $0x10,%esp
  800335:	89 c1                	mov    %eax,%ecx
  800337:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80033a:	89 d0                	mov    %edx,%eax
  80033c:	01 c0                	add    %eax,%eax
  80033e:	01 d0                	add    %edx,%eax
  800340:	01 c0                	add    %eax,%eax
  800342:	01 d0                	add    %edx,%eax
  800344:	89 c2                	mov    %eax,%edx
  800346:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800349:	c1 e0 02             	shl    $0x2,%eax
  80034c:	01 d0                	add    %edx,%eax
  80034e:	05 00 00 00 80       	add    $0x80000000,%eax
  800353:	39 c1                	cmp    %eax,%ecx
  800355:	74 16                	je     80036d <_main+0x335>
  800357:	68 5c 26 80 00       	push   $0x80265c
  80035c:	68 4a 24 80 00       	push   $0x80244a
  800361:	6a 37                	push   $0x37
  800363:	68 5f 24 80 00       	push   $0x80245f
  800368:	e8 7d 03 00 00       	call   8006ea <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (1));
  80036d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800370:	e8 3f 19 00 00       	call   801cb4 <sys_calculate_free_frames>
  800375:	29 c3                	sub    %eax,%ebx
  800377:	89 d8                	mov    %ebx,%eax
  800379:	83 f8 01             	cmp    $0x1,%eax
  80037c:	74 16                	je     800394 <_main+0x35c>
  80037e:	68 28 26 80 00       	push   $0x802628
  800383:	68 4a 24 80 00       	push   $0x80244a
  800388:	6a 38                	push   $0x38
  80038a:	68 5f 24 80 00       	push   $0x80245f
  80038f:	e8 56 03 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  800394:	e8 9e 19 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  800399:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80039c:	74 16                	je     8003b4 <_main+0x37c>
  80039e:	68 bc 24 80 00       	push   $0x8024bc
  8003a3:	68 4a 24 80 00       	push   $0x80244a
  8003a8:	6a 39                	push   $0x39
  8003aa:	68 5f 24 80 00       	push   $0x80245f
  8003af:	e8 36 03 00 00       	call   8006ea <_panic>
		//assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 1);

		freeFrames = sys_calculate_free_frames() ;
  8003b4:	e8 fb 18 00 00       	call   801cb4 <sys_calculate_free_frames>
  8003b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003bc:	e8 76 19 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  8003c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		assert((uint32)malloc(7*kilo) == USER_HEAP_START + 7*Mega + 8*kilo) ;
  8003c4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003c7:	89 d0                	mov    %edx,%eax
  8003c9:	01 c0                	add    %eax,%eax
  8003cb:	01 d0                	add    %edx,%eax
  8003cd:	01 c0                	add    %eax,%eax
  8003cf:	01 d0                	add    %edx,%eax
  8003d1:	83 ec 0c             	sub    $0xc,%esp
  8003d4:	50                   	push   %eax
  8003d5:	e8 3c 13 00 00       	call   801716 <malloc>
  8003da:	83 c4 10             	add    $0x10,%esp
  8003dd:	89 c1                	mov    %eax,%ecx
  8003df:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003e2:	89 d0                	mov    %edx,%eax
  8003e4:	01 c0                	add    %eax,%eax
  8003e6:	01 d0                	add    %edx,%eax
  8003e8:	01 c0                	add    %eax,%eax
  8003ea:	01 d0                	add    %edx,%eax
  8003ec:	89 c2                	mov    %eax,%edx
  8003ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003f1:	c1 e0 03             	shl    $0x3,%eax
  8003f4:	01 d0                	add    %edx,%eax
  8003f6:	05 00 00 00 80       	add    $0x80000000,%eax
  8003fb:	39 c1                	cmp    %eax,%ecx
  8003fd:	74 16                	je     800415 <_main+0x3dd>
  8003ff:	68 98 26 80 00       	push   $0x802698
  800404:	68 4a 24 80 00       	push   $0x80244a
  800409:	6a 3e                	push   $0x3e
  80040b:	68 5f 24 80 00       	push   $0x80245f
  800410:	e8 d5 02 00 00       	call   8006ea <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (2));
  800415:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800418:	e8 97 18 00 00       	call   801cb4 <sys_calculate_free_frames>
  80041d:	29 c3                	sub    %eax,%ebx
  80041f:	89 d8                	mov    %ebx,%eax
  800421:	83 f8 02             	cmp    $0x2,%eax
  800424:	74 16                	je     80043c <_main+0x404>
  800426:	68 d4 26 80 00       	push   $0x8026d4
  80042b:	68 4a 24 80 00       	push   $0x80244a
  800430:	6a 3f                	push   $0x3f
  800432:	68 5f 24 80 00       	push   $0x80245f
  800437:	e8 ae 02 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  80043c:	e8 f6 18 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  800441:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800444:	74 16                	je     80045c <_main+0x424>
  800446:	68 bc 24 80 00       	push   $0x8024bc
  80044b:	68 4a 24 80 00       	push   $0x80244a
  800450:	6a 40                	push   $0x40
  800452:	68 5f 24 80 00       	push   $0x80245f
  800457:	e8 8e 02 00 00       	call   8006ea <_panic>
	}

	///====================


	int freeFrames = sys_calculate_free_frames() ;
  80045c:	e8 53 18 00 00       	call   801cb4 <sys_calculate_free_frames>
  800461:	89 45 d8             	mov    %eax,-0x28(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800464:	e8 ce 18 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  800469:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	{
		x[0] = -1 ;
  80046c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80046f:	c6 00 ff             	movb   $0xff,(%eax)
		x[2*Mega] = -1 ;
  800472:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800475:	01 c0                	add    %eax,%eax
  800477:	89 c2                	mov    %eax,%edx
  800479:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80047c:	01 d0                	add    %edx,%eax
  80047e:	c6 00 ff             	movb   $0xff,(%eax)
		x[3*Mega] = -1 ;
  800481:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800484:	89 c2                	mov    %eax,%edx
  800486:	01 d2                	add    %edx,%edx
  800488:	01 d0                	add    %edx,%eax
  80048a:	89 c2                	mov    %eax,%edx
  80048c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80048f:	01 d0                	add    %edx,%eax
  800491:	c6 00 ff             	movb   $0xff,(%eax)
		x[4*Mega] = -1 ;
  800494:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800497:	c1 e0 02             	shl    $0x2,%eax
  80049a:	89 c2                	mov    %eax,%edx
  80049c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80049f:	01 d0                	add    %edx,%eax
  8004a1:	c6 00 ff             	movb   $0xff,(%eax)
		x[5*Mega] = -1 ;
  8004a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004a7:	89 d0                	mov    %edx,%eax
  8004a9:	c1 e0 02             	shl    $0x2,%eax
  8004ac:	01 d0                	add    %edx,%eax
  8004ae:	89 c2                	mov    %eax,%edx
  8004b0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004b3:	01 d0                	add    %edx,%eax
  8004b5:	c6 00 ff             	movb   $0xff,(%eax)
		x[6*Mega] = -1 ;
  8004b8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004bb:	89 d0                	mov    %edx,%eax
  8004bd:	01 c0                	add    %eax,%eax
  8004bf:	01 d0                	add    %edx,%eax
  8004c1:	01 c0                	add    %eax,%eax
  8004c3:	89 c2                	mov    %eax,%edx
  8004c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004c8:	01 d0                	add    %edx,%eax
  8004ca:	c6 00 ff             	movb   $0xff,(%eax)
		x[7*Mega-1] = -1 ;
  8004cd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004d0:	89 d0                	mov    %edx,%eax
  8004d2:	01 c0                	add    %eax,%eax
  8004d4:	01 d0                	add    %edx,%eax
  8004d6:	01 c0                	add    %eax,%eax
  8004d8:	01 d0                	add    %edx,%eax
  8004da:	8d 50 ff             	lea    -0x1(%eax),%edx
  8004dd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004e0:	01 d0                	add    %edx,%eax
  8004e2:	c6 00 ff             	movb   $0xff,(%eax)
		x[7*Mega+1*kilo] = -1 ;
  8004e5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004e8:	89 d0                	mov    %edx,%eax
  8004ea:	01 c0                	add    %eax,%eax
  8004ec:	01 d0                	add    %edx,%eax
  8004ee:	01 c0                	add    %eax,%eax
  8004f0:	01 c2                	add    %eax,%edx
  8004f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004f5:	01 d0                	add    %edx,%eax
  8004f7:	89 c2                	mov    %eax,%edx
  8004f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004fc:	01 d0                	add    %edx,%eax
  8004fe:	c6 00 ff             	movb   $0xff,(%eax)
		x[7*Mega+5*kilo] = -1 ;
  800501:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800504:	89 d0                	mov    %edx,%eax
  800506:	01 c0                	add    %eax,%eax
  800508:	01 d0                	add    %edx,%eax
  80050a:	01 c0                	add    %eax,%eax
  80050c:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
  80050f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800512:	89 d0                	mov    %edx,%eax
  800514:	c1 e0 02             	shl    $0x2,%eax
  800517:	01 d0                	add    %edx,%eax
  800519:	01 c8                	add    %ecx,%eax
  80051b:	89 c2                	mov    %eax,%edx
  80051d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800520:	01 d0                	add    %edx,%eax
  800522:	c6 00 ff             	movb   $0xff,(%eax)
		x[7*Mega+10*kilo] = -1 ;
  800525:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800528:	89 d0                	mov    %edx,%eax
  80052a:	01 c0                	add    %eax,%eax
  80052c:	01 d0                	add    %edx,%eax
  80052e:	01 c0                	add    %eax,%eax
  800530:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
  800533:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800536:	89 d0                	mov    %edx,%eax
  800538:	c1 e0 02             	shl    $0x2,%eax
  80053b:	01 d0                	add    %edx,%eax
  80053d:	01 c0                	add    %eax,%eax
  80053f:	01 c8                	add    %ecx,%eax
  800541:	89 c2                	mov    %eax,%edx
  800543:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800546:	01 d0                	add    %edx,%eax
  800548:	c6 00 ff             	movb   $0xff,(%eax)
	}

	assert((freeFrames - sys_calculate_free_frames()) == 0 );
  80054b:	e8 64 17 00 00       	call   801cb4 <sys_calculate_free_frames>
  800550:	89 c2                	mov    %eax,%edx
  800552:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800555:	39 c2                	cmp    %eax,%edx
  800557:	74 16                	je     80056f <_main+0x537>
  800559:	68 08 27 80 00       	push   $0x802708
  80055e:	68 4a 24 80 00       	push   $0x80244a
  800563:	6a 56                	push   $0x56
  800565:	68 5f 24 80 00       	push   $0x80245f
  80056a:	e8 7b 01 00 00       	call   8006ea <_panic>
	assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  80056f:	e8 c3 17 00 00       	call   801d37 <sys_pf_calculate_allocated_pages>
  800574:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
  800577:	74 16                	je     80058f <_main+0x557>
  800579:	68 bc 24 80 00       	push   $0x8024bc
  80057e:	68 4a 24 80 00       	push   $0x80244a
  800583:	6a 57                	push   $0x57
  800585:	68 5f 24 80 00       	push   $0x80245f
  80058a:	e8 5b 01 00 00       	call   8006ea <_panic>

	cprintf("Congratulations!! your modification is completed successfully.\n");
  80058f:	83 ec 0c             	sub    $0xc,%esp
  800592:	68 38 27 80 00       	push   $0x802738
  800597:	e8 f0 03 00 00       	call   80098c <cprintf>
  80059c:	83 c4 10             	add    $0x10,%esp

	return;
  80059f:	90                   	nop
}
  8005a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005a3:	c9                   	leave  
  8005a4:	c3                   	ret    

008005a5 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005a5:	55                   	push   %ebp
  8005a6:	89 e5                	mov    %esp,%ebp
  8005a8:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005ab:	e8 39 16 00 00       	call   801be9 <sys_getenvindex>
  8005b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005b6:	89 d0                	mov    %edx,%eax
  8005b8:	c1 e0 03             	shl    $0x3,%eax
  8005bb:	01 d0                	add    %edx,%eax
  8005bd:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005c4:	01 c8                	add    %ecx,%eax
  8005c6:	01 c0                	add    %eax,%eax
  8005c8:	01 d0                	add    %edx,%eax
  8005ca:	01 c0                	add    %eax,%eax
  8005cc:	01 d0                	add    %edx,%eax
  8005ce:	89 c2                	mov    %eax,%edx
  8005d0:	c1 e2 05             	shl    $0x5,%edx
  8005d3:	29 c2                	sub    %eax,%edx
  8005d5:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8005dc:	89 c2                	mov    %eax,%edx
  8005de:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8005e4:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ee:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8005f4:	84 c0                	test   %al,%al
  8005f6:	74 0f                	je     800607 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8005f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005fd:	05 40 3c 01 00       	add    $0x13c40,%eax
  800602:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800607:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80060b:	7e 0a                	jle    800617 <libmain+0x72>
		binaryname = argv[0];
  80060d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800610:	8b 00                	mov    (%eax),%eax
  800612:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800617:	83 ec 08             	sub    $0x8,%esp
  80061a:	ff 75 0c             	pushl  0xc(%ebp)
  80061d:	ff 75 08             	pushl  0x8(%ebp)
  800620:	e8 13 fa ff ff       	call   800038 <_main>
  800625:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800628:	e8 57 17 00 00       	call   801d84 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80062d:	83 ec 0c             	sub    $0xc,%esp
  800630:	68 90 27 80 00       	push   $0x802790
  800635:	e8 52 03 00 00       	call   80098c <cprintf>
  80063a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80063d:	a1 20 30 80 00       	mov    0x803020,%eax
  800642:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800648:	a1 20 30 80 00       	mov    0x803020,%eax
  80064d:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800653:	83 ec 04             	sub    $0x4,%esp
  800656:	52                   	push   %edx
  800657:	50                   	push   %eax
  800658:	68 b8 27 80 00       	push   $0x8027b8
  80065d:	e8 2a 03 00 00       	call   80098c <cprintf>
  800662:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800665:	a1 20 30 80 00       	mov    0x803020,%eax
  80066a:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800670:	a1 20 30 80 00       	mov    0x803020,%eax
  800675:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80067b:	83 ec 04             	sub    $0x4,%esp
  80067e:	52                   	push   %edx
  80067f:	50                   	push   %eax
  800680:	68 e0 27 80 00       	push   $0x8027e0
  800685:	e8 02 03 00 00       	call   80098c <cprintf>
  80068a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80068d:	a1 20 30 80 00       	mov    0x803020,%eax
  800692:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800698:	83 ec 08             	sub    $0x8,%esp
  80069b:	50                   	push   %eax
  80069c:	68 21 28 80 00       	push   $0x802821
  8006a1:	e8 e6 02 00 00       	call   80098c <cprintf>
  8006a6:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006a9:	83 ec 0c             	sub    $0xc,%esp
  8006ac:	68 90 27 80 00       	push   $0x802790
  8006b1:	e8 d6 02 00 00       	call   80098c <cprintf>
  8006b6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006b9:	e8 e0 16 00 00       	call   801d9e <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006be:	e8 19 00 00 00       	call   8006dc <exit>
}
  8006c3:	90                   	nop
  8006c4:	c9                   	leave  
  8006c5:	c3                   	ret    

008006c6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006c6:	55                   	push   %ebp
  8006c7:	89 e5                	mov    %esp,%ebp
  8006c9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006cc:	83 ec 0c             	sub    $0xc,%esp
  8006cf:	6a 00                	push   $0x0
  8006d1:	e8 df 14 00 00       	call   801bb5 <sys_env_destroy>
  8006d6:	83 c4 10             	add    $0x10,%esp
}
  8006d9:	90                   	nop
  8006da:	c9                   	leave  
  8006db:	c3                   	ret    

008006dc <exit>:

void
exit(void)
{
  8006dc:	55                   	push   %ebp
  8006dd:	89 e5                	mov    %esp,%ebp
  8006df:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006e2:	e8 34 15 00 00       	call   801c1b <sys_env_exit>
}
  8006e7:	90                   	nop
  8006e8:	c9                   	leave  
  8006e9:	c3                   	ret    

008006ea <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006ea:	55                   	push   %ebp
  8006eb:	89 e5                	mov    %esp,%ebp
  8006ed:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006f0:	8d 45 10             	lea    0x10(%ebp),%eax
  8006f3:	83 c0 04             	add    $0x4,%eax
  8006f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006f9:	a1 18 31 80 00       	mov    0x803118,%eax
  8006fe:	85 c0                	test   %eax,%eax
  800700:	74 16                	je     800718 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800702:	a1 18 31 80 00       	mov    0x803118,%eax
  800707:	83 ec 08             	sub    $0x8,%esp
  80070a:	50                   	push   %eax
  80070b:	68 38 28 80 00       	push   $0x802838
  800710:	e8 77 02 00 00       	call   80098c <cprintf>
  800715:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800718:	a1 00 30 80 00       	mov    0x803000,%eax
  80071d:	ff 75 0c             	pushl  0xc(%ebp)
  800720:	ff 75 08             	pushl  0x8(%ebp)
  800723:	50                   	push   %eax
  800724:	68 3d 28 80 00       	push   $0x80283d
  800729:	e8 5e 02 00 00       	call   80098c <cprintf>
  80072e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800731:	8b 45 10             	mov    0x10(%ebp),%eax
  800734:	83 ec 08             	sub    $0x8,%esp
  800737:	ff 75 f4             	pushl  -0xc(%ebp)
  80073a:	50                   	push   %eax
  80073b:	e8 e1 01 00 00       	call   800921 <vcprintf>
  800740:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800743:	83 ec 08             	sub    $0x8,%esp
  800746:	6a 00                	push   $0x0
  800748:	68 59 28 80 00       	push   $0x802859
  80074d:	e8 cf 01 00 00       	call   800921 <vcprintf>
  800752:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800755:	e8 82 ff ff ff       	call   8006dc <exit>

	// should not return here
	while (1) ;
  80075a:	eb fe                	jmp    80075a <_panic+0x70>

0080075c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80075c:	55                   	push   %ebp
  80075d:	89 e5                	mov    %esp,%ebp
  80075f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800762:	a1 20 30 80 00       	mov    0x803020,%eax
  800767:	8b 50 74             	mov    0x74(%eax),%edx
  80076a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80076d:	39 c2                	cmp    %eax,%edx
  80076f:	74 14                	je     800785 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800771:	83 ec 04             	sub    $0x4,%esp
  800774:	68 5c 28 80 00       	push   $0x80285c
  800779:	6a 26                	push   $0x26
  80077b:	68 a8 28 80 00       	push   $0x8028a8
  800780:	e8 65 ff ff ff       	call   8006ea <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800785:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80078c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800793:	e9 b6 00 00 00       	jmp    80084e <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800798:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80079b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a5:	01 d0                	add    %edx,%eax
  8007a7:	8b 00                	mov    (%eax),%eax
  8007a9:	85 c0                	test   %eax,%eax
  8007ab:	75 08                	jne    8007b5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007ad:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007b0:	e9 96 00 00 00       	jmp    80084b <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007b5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007bc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007c3:	eb 5d                	jmp    800822 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ca:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007d0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007d3:	c1 e2 04             	shl    $0x4,%edx
  8007d6:	01 d0                	add    %edx,%eax
  8007d8:	8a 40 04             	mov    0x4(%eax),%al
  8007db:	84 c0                	test   %al,%al
  8007dd:	75 40                	jne    80081f <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007df:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007ea:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ed:	c1 e2 04             	shl    $0x4,%edx
  8007f0:	01 d0                	add    %edx,%eax
  8007f2:	8b 00                	mov    (%eax),%eax
  8007f4:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007f7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007fa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007ff:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800801:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800804:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80080b:	8b 45 08             	mov    0x8(%ebp),%eax
  80080e:	01 c8                	add    %ecx,%eax
  800810:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800812:	39 c2                	cmp    %eax,%edx
  800814:	75 09                	jne    80081f <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800816:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80081d:	eb 12                	jmp    800831 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80081f:	ff 45 e8             	incl   -0x18(%ebp)
  800822:	a1 20 30 80 00       	mov    0x803020,%eax
  800827:	8b 50 74             	mov    0x74(%eax),%edx
  80082a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80082d:	39 c2                	cmp    %eax,%edx
  80082f:	77 94                	ja     8007c5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800831:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800835:	75 14                	jne    80084b <CheckWSWithoutLastIndex+0xef>
			panic(
  800837:	83 ec 04             	sub    $0x4,%esp
  80083a:	68 b4 28 80 00       	push   $0x8028b4
  80083f:	6a 3a                	push   $0x3a
  800841:	68 a8 28 80 00       	push   $0x8028a8
  800846:	e8 9f fe ff ff       	call   8006ea <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80084b:	ff 45 f0             	incl   -0x10(%ebp)
  80084e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800851:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800854:	0f 8c 3e ff ff ff    	jl     800798 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80085a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800861:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800868:	eb 20                	jmp    80088a <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80086a:	a1 20 30 80 00       	mov    0x803020,%eax
  80086f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800875:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800878:	c1 e2 04             	shl    $0x4,%edx
  80087b:	01 d0                	add    %edx,%eax
  80087d:	8a 40 04             	mov    0x4(%eax),%al
  800880:	3c 01                	cmp    $0x1,%al
  800882:	75 03                	jne    800887 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800884:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800887:	ff 45 e0             	incl   -0x20(%ebp)
  80088a:	a1 20 30 80 00       	mov    0x803020,%eax
  80088f:	8b 50 74             	mov    0x74(%eax),%edx
  800892:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800895:	39 c2                	cmp    %eax,%edx
  800897:	77 d1                	ja     80086a <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800899:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80089c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80089f:	74 14                	je     8008b5 <CheckWSWithoutLastIndex+0x159>
		panic(
  8008a1:	83 ec 04             	sub    $0x4,%esp
  8008a4:	68 08 29 80 00       	push   $0x802908
  8008a9:	6a 44                	push   $0x44
  8008ab:	68 a8 28 80 00       	push   $0x8028a8
  8008b0:	e8 35 fe ff ff       	call   8006ea <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008b5:	90                   	nop
  8008b6:	c9                   	leave  
  8008b7:	c3                   	ret    

008008b8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008b8:	55                   	push   %ebp
  8008b9:	89 e5                	mov    %esp,%ebp
  8008bb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c1:	8b 00                	mov    (%eax),%eax
  8008c3:	8d 48 01             	lea    0x1(%eax),%ecx
  8008c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c9:	89 0a                	mov    %ecx,(%edx)
  8008cb:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ce:	88 d1                	mov    %dl,%cl
  8008d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008da:	8b 00                	mov    (%eax),%eax
  8008dc:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008e1:	75 2c                	jne    80090f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008e3:	a0 24 30 80 00       	mov    0x803024,%al
  8008e8:	0f b6 c0             	movzbl %al,%eax
  8008eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ee:	8b 12                	mov    (%edx),%edx
  8008f0:	89 d1                	mov    %edx,%ecx
  8008f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f5:	83 c2 08             	add    $0x8,%edx
  8008f8:	83 ec 04             	sub    $0x4,%esp
  8008fb:	50                   	push   %eax
  8008fc:	51                   	push   %ecx
  8008fd:	52                   	push   %edx
  8008fe:	e8 70 12 00 00       	call   801b73 <sys_cputs>
  800903:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800906:	8b 45 0c             	mov    0xc(%ebp),%eax
  800909:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80090f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800912:	8b 40 04             	mov    0x4(%eax),%eax
  800915:	8d 50 01             	lea    0x1(%eax),%edx
  800918:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80091e:	90                   	nop
  80091f:	c9                   	leave  
  800920:	c3                   	ret    

00800921 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800921:	55                   	push   %ebp
  800922:	89 e5                	mov    %esp,%ebp
  800924:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80092a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800931:	00 00 00 
	b.cnt = 0;
  800934:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80093b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80093e:	ff 75 0c             	pushl  0xc(%ebp)
  800941:	ff 75 08             	pushl  0x8(%ebp)
  800944:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80094a:	50                   	push   %eax
  80094b:	68 b8 08 80 00       	push   $0x8008b8
  800950:	e8 11 02 00 00       	call   800b66 <vprintfmt>
  800955:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800958:	a0 24 30 80 00       	mov    0x803024,%al
  80095d:	0f b6 c0             	movzbl %al,%eax
  800960:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800966:	83 ec 04             	sub    $0x4,%esp
  800969:	50                   	push   %eax
  80096a:	52                   	push   %edx
  80096b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800971:	83 c0 08             	add    $0x8,%eax
  800974:	50                   	push   %eax
  800975:	e8 f9 11 00 00       	call   801b73 <sys_cputs>
  80097a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80097d:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800984:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80098a:	c9                   	leave  
  80098b:	c3                   	ret    

0080098c <cprintf>:

int cprintf(const char *fmt, ...) {
  80098c:	55                   	push   %ebp
  80098d:	89 e5                	mov    %esp,%ebp
  80098f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800992:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800999:	8d 45 0c             	lea    0xc(%ebp),%eax
  80099c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80099f:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a2:	83 ec 08             	sub    $0x8,%esp
  8009a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a8:	50                   	push   %eax
  8009a9:	e8 73 ff ff ff       	call   800921 <vcprintf>
  8009ae:	83 c4 10             	add    $0x10,%esp
  8009b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009b7:	c9                   	leave  
  8009b8:	c3                   	ret    

008009b9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009b9:	55                   	push   %ebp
  8009ba:	89 e5                	mov    %esp,%ebp
  8009bc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009bf:	e8 c0 13 00 00       	call   801d84 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009c4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cd:	83 ec 08             	sub    $0x8,%esp
  8009d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d3:	50                   	push   %eax
  8009d4:	e8 48 ff ff ff       	call   800921 <vcprintf>
  8009d9:	83 c4 10             	add    $0x10,%esp
  8009dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009df:	e8 ba 13 00 00       	call   801d9e <sys_enable_interrupt>
	return cnt;
  8009e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009e7:	c9                   	leave  
  8009e8:	c3                   	ret    

008009e9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009e9:	55                   	push   %ebp
  8009ea:	89 e5                	mov    %esp,%ebp
  8009ec:	53                   	push   %ebx
  8009ed:	83 ec 14             	sub    $0x14,%esp
  8009f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009fc:	8b 45 18             	mov    0x18(%ebp),%eax
  8009ff:	ba 00 00 00 00       	mov    $0x0,%edx
  800a04:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a07:	77 55                	ja     800a5e <printnum+0x75>
  800a09:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a0c:	72 05                	jb     800a13 <printnum+0x2a>
  800a0e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a11:	77 4b                	ja     800a5e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a13:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a16:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a19:	8b 45 18             	mov    0x18(%ebp),%eax
  800a1c:	ba 00 00 00 00       	mov    $0x0,%edx
  800a21:	52                   	push   %edx
  800a22:	50                   	push   %eax
  800a23:	ff 75 f4             	pushl  -0xc(%ebp)
  800a26:	ff 75 f0             	pushl  -0x10(%ebp)
  800a29:	e8 7a 17 00 00       	call   8021a8 <__udivdi3>
  800a2e:	83 c4 10             	add    $0x10,%esp
  800a31:	83 ec 04             	sub    $0x4,%esp
  800a34:	ff 75 20             	pushl  0x20(%ebp)
  800a37:	53                   	push   %ebx
  800a38:	ff 75 18             	pushl  0x18(%ebp)
  800a3b:	52                   	push   %edx
  800a3c:	50                   	push   %eax
  800a3d:	ff 75 0c             	pushl  0xc(%ebp)
  800a40:	ff 75 08             	pushl  0x8(%ebp)
  800a43:	e8 a1 ff ff ff       	call   8009e9 <printnum>
  800a48:	83 c4 20             	add    $0x20,%esp
  800a4b:	eb 1a                	jmp    800a67 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a4d:	83 ec 08             	sub    $0x8,%esp
  800a50:	ff 75 0c             	pushl  0xc(%ebp)
  800a53:	ff 75 20             	pushl  0x20(%ebp)
  800a56:	8b 45 08             	mov    0x8(%ebp),%eax
  800a59:	ff d0                	call   *%eax
  800a5b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a5e:	ff 4d 1c             	decl   0x1c(%ebp)
  800a61:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a65:	7f e6                	jg     800a4d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a67:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a6a:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a72:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a75:	53                   	push   %ebx
  800a76:	51                   	push   %ecx
  800a77:	52                   	push   %edx
  800a78:	50                   	push   %eax
  800a79:	e8 3a 18 00 00       	call   8022b8 <__umoddi3>
  800a7e:	83 c4 10             	add    $0x10,%esp
  800a81:	05 74 2b 80 00       	add    $0x802b74,%eax
  800a86:	8a 00                	mov    (%eax),%al
  800a88:	0f be c0             	movsbl %al,%eax
  800a8b:	83 ec 08             	sub    $0x8,%esp
  800a8e:	ff 75 0c             	pushl  0xc(%ebp)
  800a91:	50                   	push   %eax
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
  800a95:	ff d0                	call   *%eax
  800a97:	83 c4 10             	add    $0x10,%esp
}
  800a9a:	90                   	nop
  800a9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a9e:	c9                   	leave  
  800a9f:	c3                   	ret    

00800aa0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800aa0:	55                   	push   %ebp
  800aa1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800aa3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800aa7:	7e 1c                	jle    800ac5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	8b 00                	mov    (%eax),%eax
  800aae:	8d 50 08             	lea    0x8(%eax),%edx
  800ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab4:	89 10                	mov    %edx,(%eax)
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	8b 00                	mov    (%eax),%eax
  800abb:	83 e8 08             	sub    $0x8,%eax
  800abe:	8b 50 04             	mov    0x4(%eax),%edx
  800ac1:	8b 00                	mov    (%eax),%eax
  800ac3:	eb 40                	jmp    800b05 <getuint+0x65>
	else if (lflag)
  800ac5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ac9:	74 1e                	je     800ae9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	8b 00                	mov    (%eax),%eax
  800ad0:	8d 50 04             	lea    0x4(%eax),%edx
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	89 10                	mov    %edx,(%eax)
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8b 00                	mov    (%eax),%eax
  800add:	83 e8 04             	sub    $0x4,%eax
  800ae0:	8b 00                	mov    (%eax),%eax
  800ae2:	ba 00 00 00 00       	mov    $0x0,%edx
  800ae7:	eb 1c                	jmp    800b05 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aec:	8b 00                	mov    (%eax),%eax
  800aee:	8d 50 04             	lea    0x4(%eax),%edx
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	89 10                	mov    %edx,(%eax)
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	8b 00                	mov    (%eax),%eax
  800afb:	83 e8 04             	sub    $0x4,%eax
  800afe:	8b 00                	mov    (%eax),%eax
  800b00:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b05:	5d                   	pop    %ebp
  800b06:	c3                   	ret    

00800b07 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b07:	55                   	push   %ebp
  800b08:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b0a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b0e:	7e 1c                	jle    800b2c <getint+0x25>
		return va_arg(*ap, long long);
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	8b 00                	mov    (%eax),%eax
  800b15:	8d 50 08             	lea    0x8(%eax),%edx
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	89 10                	mov    %edx,(%eax)
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	8b 00                	mov    (%eax),%eax
  800b22:	83 e8 08             	sub    $0x8,%eax
  800b25:	8b 50 04             	mov    0x4(%eax),%edx
  800b28:	8b 00                	mov    (%eax),%eax
  800b2a:	eb 38                	jmp    800b64 <getint+0x5d>
	else if (lflag)
  800b2c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b30:	74 1a                	je     800b4c <getint+0x45>
		return va_arg(*ap, long);
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	8b 00                	mov    (%eax),%eax
  800b37:	8d 50 04             	lea    0x4(%eax),%edx
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3d:	89 10                	mov    %edx,(%eax)
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8b 00                	mov    (%eax),%eax
  800b44:	83 e8 04             	sub    $0x4,%eax
  800b47:	8b 00                	mov    (%eax),%eax
  800b49:	99                   	cltd   
  800b4a:	eb 18                	jmp    800b64 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	8b 00                	mov    (%eax),%eax
  800b51:	8d 50 04             	lea    0x4(%eax),%edx
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	89 10                	mov    %edx,(%eax)
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	8b 00                	mov    (%eax),%eax
  800b5e:	83 e8 04             	sub    $0x4,%eax
  800b61:	8b 00                	mov    (%eax),%eax
  800b63:	99                   	cltd   
}
  800b64:	5d                   	pop    %ebp
  800b65:	c3                   	ret    

00800b66 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b66:	55                   	push   %ebp
  800b67:	89 e5                	mov    %esp,%ebp
  800b69:	56                   	push   %esi
  800b6a:	53                   	push   %ebx
  800b6b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b6e:	eb 17                	jmp    800b87 <vprintfmt+0x21>
			if (ch == '\0')
  800b70:	85 db                	test   %ebx,%ebx
  800b72:	0f 84 af 03 00 00    	je     800f27 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b78:	83 ec 08             	sub    $0x8,%esp
  800b7b:	ff 75 0c             	pushl  0xc(%ebp)
  800b7e:	53                   	push   %ebx
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	ff d0                	call   *%eax
  800b84:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b87:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8a:	8d 50 01             	lea    0x1(%eax),%edx
  800b8d:	89 55 10             	mov    %edx,0x10(%ebp)
  800b90:	8a 00                	mov    (%eax),%al
  800b92:	0f b6 d8             	movzbl %al,%ebx
  800b95:	83 fb 25             	cmp    $0x25,%ebx
  800b98:	75 d6                	jne    800b70 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b9a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b9e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ba5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bac:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bb3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bba:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbd:	8d 50 01             	lea    0x1(%eax),%edx
  800bc0:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc3:	8a 00                	mov    (%eax),%al
  800bc5:	0f b6 d8             	movzbl %al,%ebx
  800bc8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bcb:	83 f8 55             	cmp    $0x55,%eax
  800bce:	0f 87 2b 03 00 00    	ja     800eff <vprintfmt+0x399>
  800bd4:	8b 04 85 98 2b 80 00 	mov    0x802b98(,%eax,4),%eax
  800bdb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bdd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800be1:	eb d7                	jmp    800bba <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800be3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800be7:	eb d1                	jmp    800bba <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800be9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bf0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bf3:	89 d0                	mov    %edx,%eax
  800bf5:	c1 e0 02             	shl    $0x2,%eax
  800bf8:	01 d0                	add    %edx,%eax
  800bfa:	01 c0                	add    %eax,%eax
  800bfc:	01 d8                	add    %ebx,%eax
  800bfe:	83 e8 30             	sub    $0x30,%eax
  800c01:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c04:	8b 45 10             	mov    0x10(%ebp),%eax
  800c07:	8a 00                	mov    (%eax),%al
  800c09:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c0c:	83 fb 2f             	cmp    $0x2f,%ebx
  800c0f:	7e 3e                	jle    800c4f <vprintfmt+0xe9>
  800c11:	83 fb 39             	cmp    $0x39,%ebx
  800c14:	7f 39                	jg     800c4f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c16:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c19:	eb d5                	jmp    800bf0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c1b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c1e:	83 c0 04             	add    $0x4,%eax
  800c21:	89 45 14             	mov    %eax,0x14(%ebp)
  800c24:	8b 45 14             	mov    0x14(%ebp),%eax
  800c27:	83 e8 04             	sub    $0x4,%eax
  800c2a:	8b 00                	mov    (%eax),%eax
  800c2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c2f:	eb 1f                	jmp    800c50 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c31:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c35:	79 83                	jns    800bba <vprintfmt+0x54>
				width = 0;
  800c37:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c3e:	e9 77 ff ff ff       	jmp    800bba <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c43:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c4a:	e9 6b ff ff ff       	jmp    800bba <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c4f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c54:	0f 89 60 ff ff ff    	jns    800bba <vprintfmt+0x54>
				width = precision, precision = -1;
  800c5a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c5d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c60:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c67:	e9 4e ff ff ff       	jmp    800bba <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c6c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c6f:	e9 46 ff ff ff       	jmp    800bba <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c74:	8b 45 14             	mov    0x14(%ebp),%eax
  800c77:	83 c0 04             	add    $0x4,%eax
  800c7a:	89 45 14             	mov    %eax,0x14(%ebp)
  800c7d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c80:	83 e8 04             	sub    $0x4,%eax
  800c83:	8b 00                	mov    (%eax),%eax
  800c85:	83 ec 08             	sub    $0x8,%esp
  800c88:	ff 75 0c             	pushl  0xc(%ebp)
  800c8b:	50                   	push   %eax
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8f:	ff d0                	call   *%eax
  800c91:	83 c4 10             	add    $0x10,%esp
			break;
  800c94:	e9 89 02 00 00       	jmp    800f22 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c99:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9c:	83 c0 04             	add    $0x4,%eax
  800c9f:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca5:	83 e8 04             	sub    $0x4,%eax
  800ca8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800caa:	85 db                	test   %ebx,%ebx
  800cac:	79 02                	jns    800cb0 <vprintfmt+0x14a>
				err = -err;
  800cae:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cb0:	83 fb 64             	cmp    $0x64,%ebx
  800cb3:	7f 0b                	jg     800cc0 <vprintfmt+0x15a>
  800cb5:	8b 34 9d e0 29 80 00 	mov    0x8029e0(,%ebx,4),%esi
  800cbc:	85 f6                	test   %esi,%esi
  800cbe:	75 19                	jne    800cd9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cc0:	53                   	push   %ebx
  800cc1:	68 85 2b 80 00       	push   $0x802b85
  800cc6:	ff 75 0c             	pushl  0xc(%ebp)
  800cc9:	ff 75 08             	pushl  0x8(%ebp)
  800ccc:	e8 5e 02 00 00       	call   800f2f <printfmt>
  800cd1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cd4:	e9 49 02 00 00       	jmp    800f22 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cd9:	56                   	push   %esi
  800cda:	68 8e 2b 80 00       	push   $0x802b8e
  800cdf:	ff 75 0c             	pushl  0xc(%ebp)
  800ce2:	ff 75 08             	pushl  0x8(%ebp)
  800ce5:	e8 45 02 00 00       	call   800f2f <printfmt>
  800cea:	83 c4 10             	add    $0x10,%esp
			break;
  800ced:	e9 30 02 00 00       	jmp    800f22 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cf2:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf5:	83 c0 04             	add    $0x4,%eax
  800cf8:	89 45 14             	mov    %eax,0x14(%ebp)
  800cfb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cfe:	83 e8 04             	sub    $0x4,%eax
  800d01:	8b 30                	mov    (%eax),%esi
  800d03:	85 f6                	test   %esi,%esi
  800d05:	75 05                	jne    800d0c <vprintfmt+0x1a6>
				p = "(null)";
  800d07:	be 91 2b 80 00       	mov    $0x802b91,%esi
			if (width > 0 && padc != '-')
  800d0c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d10:	7e 6d                	jle    800d7f <vprintfmt+0x219>
  800d12:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d16:	74 67                	je     800d7f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d18:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d1b:	83 ec 08             	sub    $0x8,%esp
  800d1e:	50                   	push   %eax
  800d1f:	56                   	push   %esi
  800d20:	e8 0c 03 00 00       	call   801031 <strnlen>
  800d25:	83 c4 10             	add    $0x10,%esp
  800d28:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d2b:	eb 16                	jmp    800d43 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d2d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d31:	83 ec 08             	sub    $0x8,%esp
  800d34:	ff 75 0c             	pushl  0xc(%ebp)
  800d37:	50                   	push   %eax
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	ff d0                	call   *%eax
  800d3d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d40:	ff 4d e4             	decl   -0x1c(%ebp)
  800d43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d47:	7f e4                	jg     800d2d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d49:	eb 34                	jmp    800d7f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d4b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d4f:	74 1c                	je     800d6d <vprintfmt+0x207>
  800d51:	83 fb 1f             	cmp    $0x1f,%ebx
  800d54:	7e 05                	jle    800d5b <vprintfmt+0x1f5>
  800d56:	83 fb 7e             	cmp    $0x7e,%ebx
  800d59:	7e 12                	jle    800d6d <vprintfmt+0x207>
					putch('?', putdat);
  800d5b:	83 ec 08             	sub    $0x8,%esp
  800d5e:	ff 75 0c             	pushl  0xc(%ebp)
  800d61:	6a 3f                	push   $0x3f
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	ff d0                	call   *%eax
  800d68:	83 c4 10             	add    $0x10,%esp
  800d6b:	eb 0f                	jmp    800d7c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d6d:	83 ec 08             	sub    $0x8,%esp
  800d70:	ff 75 0c             	pushl  0xc(%ebp)
  800d73:	53                   	push   %ebx
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
  800d77:	ff d0                	call   *%eax
  800d79:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d7c:	ff 4d e4             	decl   -0x1c(%ebp)
  800d7f:	89 f0                	mov    %esi,%eax
  800d81:	8d 70 01             	lea    0x1(%eax),%esi
  800d84:	8a 00                	mov    (%eax),%al
  800d86:	0f be d8             	movsbl %al,%ebx
  800d89:	85 db                	test   %ebx,%ebx
  800d8b:	74 24                	je     800db1 <vprintfmt+0x24b>
  800d8d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d91:	78 b8                	js     800d4b <vprintfmt+0x1e5>
  800d93:	ff 4d e0             	decl   -0x20(%ebp)
  800d96:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d9a:	79 af                	jns    800d4b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d9c:	eb 13                	jmp    800db1 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d9e:	83 ec 08             	sub    $0x8,%esp
  800da1:	ff 75 0c             	pushl  0xc(%ebp)
  800da4:	6a 20                	push   $0x20
  800da6:	8b 45 08             	mov    0x8(%ebp),%eax
  800da9:	ff d0                	call   *%eax
  800dab:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dae:	ff 4d e4             	decl   -0x1c(%ebp)
  800db1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800db5:	7f e7                	jg     800d9e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800db7:	e9 66 01 00 00       	jmp    800f22 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dbc:	83 ec 08             	sub    $0x8,%esp
  800dbf:	ff 75 e8             	pushl  -0x18(%ebp)
  800dc2:	8d 45 14             	lea    0x14(%ebp),%eax
  800dc5:	50                   	push   %eax
  800dc6:	e8 3c fd ff ff       	call   800b07 <getint>
  800dcb:	83 c4 10             	add    $0x10,%esp
  800dce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dd1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dd7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dda:	85 d2                	test   %edx,%edx
  800ddc:	79 23                	jns    800e01 <vprintfmt+0x29b>
				putch('-', putdat);
  800dde:	83 ec 08             	sub    $0x8,%esp
  800de1:	ff 75 0c             	pushl  0xc(%ebp)
  800de4:	6a 2d                	push   $0x2d
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	ff d0                	call   *%eax
  800deb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800df1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800df4:	f7 d8                	neg    %eax
  800df6:	83 d2 00             	adc    $0x0,%edx
  800df9:	f7 da                	neg    %edx
  800dfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dfe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e01:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e08:	e9 bc 00 00 00       	jmp    800ec9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e0d:	83 ec 08             	sub    $0x8,%esp
  800e10:	ff 75 e8             	pushl  -0x18(%ebp)
  800e13:	8d 45 14             	lea    0x14(%ebp),%eax
  800e16:	50                   	push   %eax
  800e17:	e8 84 fc ff ff       	call   800aa0 <getuint>
  800e1c:	83 c4 10             	add    $0x10,%esp
  800e1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e25:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e2c:	e9 98 00 00 00       	jmp    800ec9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e31:	83 ec 08             	sub    $0x8,%esp
  800e34:	ff 75 0c             	pushl  0xc(%ebp)
  800e37:	6a 58                	push   $0x58
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	ff d0                	call   *%eax
  800e3e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e41:	83 ec 08             	sub    $0x8,%esp
  800e44:	ff 75 0c             	pushl  0xc(%ebp)
  800e47:	6a 58                	push   $0x58
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4c:	ff d0                	call   *%eax
  800e4e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e51:	83 ec 08             	sub    $0x8,%esp
  800e54:	ff 75 0c             	pushl  0xc(%ebp)
  800e57:	6a 58                	push   $0x58
  800e59:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5c:	ff d0                	call   *%eax
  800e5e:	83 c4 10             	add    $0x10,%esp
			break;
  800e61:	e9 bc 00 00 00       	jmp    800f22 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e66:	83 ec 08             	sub    $0x8,%esp
  800e69:	ff 75 0c             	pushl  0xc(%ebp)
  800e6c:	6a 30                	push   $0x30
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	ff d0                	call   *%eax
  800e73:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e76:	83 ec 08             	sub    $0x8,%esp
  800e79:	ff 75 0c             	pushl  0xc(%ebp)
  800e7c:	6a 78                	push   $0x78
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	ff d0                	call   *%eax
  800e83:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e86:	8b 45 14             	mov    0x14(%ebp),%eax
  800e89:	83 c0 04             	add    $0x4,%eax
  800e8c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e92:	83 e8 04             	sub    $0x4,%eax
  800e95:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ea1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ea8:	eb 1f                	jmp    800ec9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800eaa:	83 ec 08             	sub    $0x8,%esp
  800ead:	ff 75 e8             	pushl  -0x18(%ebp)
  800eb0:	8d 45 14             	lea    0x14(%ebp),%eax
  800eb3:	50                   	push   %eax
  800eb4:	e8 e7 fb ff ff       	call   800aa0 <getuint>
  800eb9:	83 c4 10             	add    $0x10,%esp
  800ebc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ebf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ec2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ec9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ecd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ed0:	83 ec 04             	sub    $0x4,%esp
  800ed3:	52                   	push   %edx
  800ed4:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ed7:	50                   	push   %eax
  800ed8:	ff 75 f4             	pushl  -0xc(%ebp)
  800edb:	ff 75 f0             	pushl  -0x10(%ebp)
  800ede:	ff 75 0c             	pushl  0xc(%ebp)
  800ee1:	ff 75 08             	pushl  0x8(%ebp)
  800ee4:	e8 00 fb ff ff       	call   8009e9 <printnum>
  800ee9:	83 c4 20             	add    $0x20,%esp
			break;
  800eec:	eb 34                	jmp    800f22 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	ff 75 0c             	pushl  0xc(%ebp)
  800ef4:	53                   	push   %ebx
  800ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef8:	ff d0                	call   *%eax
  800efa:	83 c4 10             	add    $0x10,%esp
			break;
  800efd:	eb 23                	jmp    800f22 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800eff:	83 ec 08             	sub    $0x8,%esp
  800f02:	ff 75 0c             	pushl  0xc(%ebp)
  800f05:	6a 25                	push   $0x25
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	ff d0                	call   *%eax
  800f0c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f0f:	ff 4d 10             	decl   0x10(%ebp)
  800f12:	eb 03                	jmp    800f17 <vprintfmt+0x3b1>
  800f14:	ff 4d 10             	decl   0x10(%ebp)
  800f17:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1a:	48                   	dec    %eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	3c 25                	cmp    $0x25,%al
  800f1f:	75 f3                	jne    800f14 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f21:	90                   	nop
		}
	}
  800f22:	e9 47 fc ff ff       	jmp    800b6e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f27:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f28:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f2b:	5b                   	pop    %ebx
  800f2c:	5e                   	pop    %esi
  800f2d:	5d                   	pop    %ebp
  800f2e:	c3                   	ret    

00800f2f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f2f:	55                   	push   %ebp
  800f30:	89 e5                	mov    %esp,%ebp
  800f32:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f35:	8d 45 10             	lea    0x10(%ebp),%eax
  800f38:	83 c0 04             	add    $0x4,%eax
  800f3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f41:	ff 75 f4             	pushl  -0xc(%ebp)
  800f44:	50                   	push   %eax
  800f45:	ff 75 0c             	pushl  0xc(%ebp)
  800f48:	ff 75 08             	pushl  0x8(%ebp)
  800f4b:	e8 16 fc ff ff       	call   800b66 <vprintfmt>
  800f50:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f53:	90                   	nop
  800f54:	c9                   	leave  
  800f55:	c3                   	ret    

00800f56 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f56:	55                   	push   %ebp
  800f57:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5c:	8b 40 08             	mov    0x8(%eax),%eax
  800f5f:	8d 50 01             	lea    0x1(%eax),%edx
  800f62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f65:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6b:	8b 10                	mov    (%eax),%edx
  800f6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f70:	8b 40 04             	mov    0x4(%eax),%eax
  800f73:	39 c2                	cmp    %eax,%edx
  800f75:	73 12                	jae    800f89 <sprintputch+0x33>
		*b->buf++ = ch;
  800f77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7a:	8b 00                	mov    (%eax),%eax
  800f7c:	8d 48 01             	lea    0x1(%eax),%ecx
  800f7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f82:	89 0a                	mov    %ecx,(%edx)
  800f84:	8b 55 08             	mov    0x8(%ebp),%edx
  800f87:	88 10                	mov    %dl,(%eax)
}
  800f89:	90                   	nop
  800f8a:	5d                   	pop    %ebp
  800f8b:	c3                   	ret    

00800f8c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f8c:	55                   	push   %ebp
  800f8d:	89 e5                	mov    %esp,%ebp
  800f8f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	01 d0                	add    %edx,%eax
  800fa3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fa6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fb1:	74 06                	je     800fb9 <vsnprintf+0x2d>
  800fb3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fb7:	7f 07                	jg     800fc0 <vsnprintf+0x34>
		return -E_INVAL;
  800fb9:	b8 03 00 00 00       	mov    $0x3,%eax
  800fbe:	eb 20                	jmp    800fe0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fc0:	ff 75 14             	pushl  0x14(%ebp)
  800fc3:	ff 75 10             	pushl  0x10(%ebp)
  800fc6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fc9:	50                   	push   %eax
  800fca:	68 56 0f 80 00       	push   $0x800f56
  800fcf:	e8 92 fb ff ff       	call   800b66 <vprintfmt>
  800fd4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fda:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fe0:	c9                   	leave  
  800fe1:	c3                   	ret    

00800fe2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fe2:	55                   	push   %ebp
  800fe3:	89 e5                	mov    %esp,%ebp
  800fe5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fe8:	8d 45 10             	lea    0x10(%ebp),%eax
  800feb:	83 c0 04             	add    $0x4,%eax
  800fee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ff1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ff7:	50                   	push   %eax
  800ff8:	ff 75 0c             	pushl  0xc(%ebp)
  800ffb:	ff 75 08             	pushl  0x8(%ebp)
  800ffe:	e8 89 ff ff ff       	call   800f8c <vsnprintf>
  801003:	83 c4 10             	add    $0x10,%esp
  801006:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801009:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80100c:	c9                   	leave  
  80100d:	c3                   	ret    

0080100e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80100e:	55                   	push   %ebp
  80100f:	89 e5                	mov    %esp,%ebp
  801011:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801014:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80101b:	eb 06                	jmp    801023 <strlen+0x15>
		n++;
  80101d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801020:	ff 45 08             	incl   0x8(%ebp)
  801023:	8b 45 08             	mov    0x8(%ebp),%eax
  801026:	8a 00                	mov    (%eax),%al
  801028:	84 c0                	test   %al,%al
  80102a:	75 f1                	jne    80101d <strlen+0xf>
		n++;
	return n;
  80102c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80102f:	c9                   	leave  
  801030:	c3                   	ret    

00801031 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801031:	55                   	push   %ebp
  801032:	89 e5                	mov    %esp,%ebp
  801034:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801037:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80103e:	eb 09                	jmp    801049 <strnlen+0x18>
		n++;
  801040:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801043:	ff 45 08             	incl   0x8(%ebp)
  801046:	ff 4d 0c             	decl   0xc(%ebp)
  801049:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80104d:	74 09                	je     801058 <strnlen+0x27>
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	8a 00                	mov    (%eax),%al
  801054:	84 c0                	test   %al,%al
  801056:	75 e8                	jne    801040 <strnlen+0xf>
		n++;
	return n;
  801058:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80105b:	c9                   	leave  
  80105c:	c3                   	ret    

0080105d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80105d:	55                   	push   %ebp
  80105e:	89 e5                	mov    %esp,%ebp
  801060:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
  801066:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801069:	90                   	nop
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	8d 50 01             	lea    0x1(%eax),%edx
  801070:	89 55 08             	mov    %edx,0x8(%ebp)
  801073:	8b 55 0c             	mov    0xc(%ebp),%edx
  801076:	8d 4a 01             	lea    0x1(%edx),%ecx
  801079:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80107c:	8a 12                	mov    (%edx),%dl
  80107e:	88 10                	mov    %dl,(%eax)
  801080:	8a 00                	mov    (%eax),%al
  801082:	84 c0                	test   %al,%al
  801084:	75 e4                	jne    80106a <strcpy+0xd>
		/* do nothing */;
	return ret;
  801086:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801089:	c9                   	leave  
  80108a:	c3                   	ret    

0080108b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80108b:	55                   	push   %ebp
  80108c:	89 e5                	mov    %esp,%ebp
  80108e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801097:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80109e:	eb 1f                	jmp    8010bf <strncpy+0x34>
		*dst++ = *src;
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a3:	8d 50 01             	lea    0x1(%eax),%edx
  8010a6:	89 55 08             	mov    %edx,0x8(%ebp)
  8010a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ac:	8a 12                	mov    (%edx),%dl
  8010ae:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b3:	8a 00                	mov    (%eax),%al
  8010b5:	84 c0                	test   %al,%al
  8010b7:	74 03                	je     8010bc <strncpy+0x31>
			src++;
  8010b9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010bc:	ff 45 fc             	incl   -0x4(%ebp)
  8010bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010c5:	72 d9                	jb     8010a0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010ca:	c9                   	leave  
  8010cb:	c3                   	ret    

008010cc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010cc:	55                   	push   %ebp
  8010cd:	89 e5                	mov    %esp,%ebp
  8010cf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010dc:	74 30                	je     80110e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010de:	eb 16                	jmp    8010f6 <strlcpy+0x2a>
			*dst++ = *src++;
  8010e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e3:	8d 50 01             	lea    0x1(%eax),%edx
  8010e6:	89 55 08             	mov    %edx,0x8(%ebp)
  8010e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ec:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010ef:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010f2:	8a 12                	mov    (%edx),%dl
  8010f4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010f6:	ff 4d 10             	decl   0x10(%ebp)
  8010f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010fd:	74 09                	je     801108 <strlcpy+0x3c>
  8010ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801102:	8a 00                	mov    (%eax),%al
  801104:	84 c0                	test   %al,%al
  801106:	75 d8                	jne    8010e0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80110e:	8b 55 08             	mov    0x8(%ebp),%edx
  801111:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801114:	29 c2                	sub    %eax,%edx
  801116:	89 d0                	mov    %edx,%eax
}
  801118:	c9                   	leave  
  801119:	c3                   	ret    

0080111a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80111a:	55                   	push   %ebp
  80111b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80111d:	eb 06                	jmp    801125 <strcmp+0xb>
		p++, q++;
  80111f:	ff 45 08             	incl   0x8(%ebp)
  801122:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801125:	8b 45 08             	mov    0x8(%ebp),%eax
  801128:	8a 00                	mov    (%eax),%al
  80112a:	84 c0                	test   %al,%al
  80112c:	74 0e                	je     80113c <strcmp+0x22>
  80112e:	8b 45 08             	mov    0x8(%ebp),%eax
  801131:	8a 10                	mov    (%eax),%dl
  801133:	8b 45 0c             	mov    0xc(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	38 c2                	cmp    %al,%dl
  80113a:	74 e3                	je     80111f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
  80113f:	8a 00                	mov    (%eax),%al
  801141:	0f b6 d0             	movzbl %al,%edx
  801144:	8b 45 0c             	mov    0xc(%ebp),%eax
  801147:	8a 00                	mov    (%eax),%al
  801149:	0f b6 c0             	movzbl %al,%eax
  80114c:	29 c2                	sub    %eax,%edx
  80114e:	89 d0                	mov    %edx,%eax
}
  801150:	5d                   	pop    %ebp
  801151:	c3                   	ret    

00801152 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801152:	55                   	push   %ebp
  801153:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801155:	eb 09                	jmp    801160 <strncmp+0xe>
		n--, p++, q++;
  801157:	ff 4d 10             	decl   0x10(%ebp)
  80115a:	ff 45 08             	incl   0x8(%ebp)
  80115d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801160:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801164:	74 17                	je     80117d <strncmp+0x2b>
  801166:	8b 45 08             	mov    0x8(%ebp),%eax
  801169:	8a 00                	mov    (%eax),%al
  80116b:	84 c0                	test   %al,%al
  80116d:	74 0e                	je     80117d <strncmp+0x2b>
  80116f:	8b 45 08             	mov    0x8(%ebp),%eax
  801172:	8a 10                	mov    (%eax),%dl
  801174:	8b 45 0c             	mov    0xc(%ebp),%eax
  801177:	8a 00                	mov    (%eax),%al
  801179:	38 c2                	cmp    %al,%dl
  80117b:	74 da                	je     801157 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80117d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801181:	75 07                	jne    80118a <strncmp+0x38>
		return 0;
  801183:	b8 00 00 00 00       	mov    $0x0,%eax
  801188:	eb 14                	jmp    80119e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80118a:	8b 45 08             	mov    0x8(%ebp),%eax
  80118d:	8a 00                	mov    (%eax),%al
  80118f:	0f b6 d0             	movzbl %al,%edx
  801192:	8b 45 0c             	mov    0xc(%ebp),%eax
  801195:	8a 00                	mov    (%eax),%al
  801197:	0f b6 c0             	movzbl %al,%eax
  80119a:	29 c2                	sub    %eax,%edx
  80119c:	89 d0                	mov    %edx,%eax
}
  80119e:	5d                   	pop    %ebp
  80119f:	c3                   	ret    

008011a0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011a0:	55                   	push   %ebp
  8011a1:	89 e5                	mov    %esp,%ebp
  8011a3:	83 ec 04             	sub    $0x4,%esp
  8011a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011ac:	eb 12                	jmp    8011c0 <strchr+0x20>
		if (*s == c)
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	8a 00                	mov    (%eax),%al
  8011b3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011b6:	75 05                	jne    8011bd <strchr+0x1d>
			return (char *) s;
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	eb 11                	jmp    8011ce <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011bd:	ff 45 08             	incl   0x8(%ebp)
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	84 c0                	test   %al,%al
  8011c7:	75 e5                	jne    8011ae <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011ce:	c9                   	leave  
  8011cf:	c3                   	ret    

008011d0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011d0:	55                   	push   %ebp
  8011d1:	89 e5                	mov    %esp,%ebp
  8011d3:	83 ec 04             	sub    $0x4,%esp
  8011d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011dc:	eb 0d                	jmp    8011eb <strfind+0x1b>
		if (*s == c)
  8011de:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e1:	8a 00                	mov    (%eax),%al
  8011e3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011e6:	74 0e                	je     8011f6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011e8:	ff 45 08             	incl   0x8(%ebp)
  8011eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	84 c0                	test   %al,%al
  8011f2:	75 ea                	jne    8011de <strfind+0xe>
  8011f4:	eb 01                	jmp    8011f7 <strfind+0x27>
		if (*s == c)
			break;
  8011f6:	90                   	nop
	return (char *) s;
  8011f7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011fa:	c9                   	leave  
  8011fb:	c3                   	ret    

008011fc <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011fc:	55                   	push   %ebp
  8011fd:	89 e5                	mov    %esp,%ebp
  8011ff:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801208:	8b 45 10             	mov    0x10(%ebp),%eax
  80120b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80120e:	eb 0e                	jmp    80121e <memset+0x22>
		*p++ = c;
  801210:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801213:	8d 50 01             	lea    0x1(%eax),%edx
  801216:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801219:	8b 55 0c             	mov    0xc(%ebp),%edx
  80121c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80121e:	ff 4d f8             	decl   -0x8(%ebp)
  801221:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801225:	79 e9                	jns    801210 <memset+0x14>
		*p++ = c;

	return v;
  801227:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80122a:	c9                   	leave  
  80122b:	c3                   	ret    

0080122c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80122c:	55                   	push   %ebp
  80122d:	89 e5                	mov    %esp,%ebp
  80122f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801232:	8b 45 0c             	mov    0xc(%ebp),%eax
  801235:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801238:	8b 45 08             	mov    0x8(%ebp),%eax
  80123b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80123e:	eb 16                	jmp    801256 <memcpy+0x2a>
		*d++ = *s++;
  801240:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801243:	8d 50 01             	lea    0x1(%eax),%edx
  801246:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801249:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80124c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80124f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801252:	8a 12                	mov    (%edx),%dl
  801254:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801256:	8b 45 10             	mov    0x10(%ebp),%eax
  801259:	8d 50 ff             	lea    -0x1(%eax),%edx
  80125c:	89 55 10             	mov    %edx,0x10(%ebp)
  80125f:	85 c0                	test   %eax,%eax
  801261:	75 dd                	jne    801240 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801266:	c9                   	leave  
  801267:	c3                   	ret    

00801268 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801268:	55                   	push   %ebp
  801269:	89 e5                	mov    %esp,%ebp
  80126b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80126e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801271:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801274:	8b 45 08             	mov    0x8(%ebp),%eax
  801277:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80127a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80127d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801280:	73 50                	jae    8012d2 <memmove+0x6a>
  801282:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801285:	8b 45 10             	mov    0x10(%ebp),%eax
  801288:	01 d0                	add    %edx,%eax
  80128a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80128d:	76 43                	jbe    8012d2 <memmove+0x6a>
		s += n;
  80128f:	8b 45 10             	mov    0x10(%ebp),%eax
  801292:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801295:	8b 45 10             	mov    0x10(%ebp),%eax
  801298:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80129b:	eb 10                	jmp    8012ad <memmove+0x45>
			*--d = *--s;
  80129d:	ff 4d f8             	decl   -0x8(%ebp)
  8012a0:	ff 4d fc             	decl   -0x4(%ebp)
  8012a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012a6:	8a 10                	mov    (%eax),%dl
  8012a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ab:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012b3:	89 55 10             	mov    %edx,0x10(%ebp)
  8012b6:	85 c0                	test   %eax,%eax
  8012b8:	75 e3                	jne    80129d <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012ba:	eb 23                	jmp    8012df <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012bf:	8d 50 01             	lea    0x1(%eax),%edx
  8012c2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012c8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012cb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012ce:	8a 12                	mov    (%edx),%dl
  8012d0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012d8:	89 55 10             	mov    %edx,0x10(%ebp)
  8012db:	85 c0                	test   %eax,%eax
  8012dd:	75 dd                	jne    8012bc <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012df:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012e2:	c9                   	leave  
  8012e3:	c3                   	ret    

008012e4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012e4:	55                   	push   %ebp
  8012e5:	89 e5                	mov    %esp,%ebp
  8012e7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f3:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012f6:	eb 2a                	jmp    801322 <memcmp+0x3e>
		if (*s1 != *s2)
  8012f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012fb:	8a 10                	mov    (%eax),%dl
  8012fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801300:	8a 00                	mov    (%eax),%al
  801302:	38 c2                	cmp    %al,%dl
  801304:	74 16                	je     80131c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801306:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801309:	8a 00                	mov    (%eax),%al
  80130b:	0f b6 d0             	movzbl %al,%edx
  80130e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801311:	8a 00                	mov    (%eax),%al
  801313:	0f b6 c0             	movzbl %al,%eax
  801316:	29 c2                	sub    %eax,%edx
  801318:	89 d0                	mov    %edx,%eax
  80131a:	eb 18                	jmp    801334 <memcmp+0x50>
		s1++, s2++;
  80131c:	ff 45 fc             	incl   -0x4(%ebp)
  80131f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801322:	8b 45 10             	mov    0x10(%ebp),%eax
  801325:	8d 50 ff             	lea    -0x1(%eax),%edx
  801328:	89 55 10             	mov    %edx,0x10(%ebp)
  80132b:	85 c0                	test   %eax,%eax
  80132d:	75 c9                	jne    8012f8 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80132f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801334:	c9                   	leave  
  801335:	c3                   	ret    

00801336 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801336:	55                   	push   %ebp
  801337:	89 e5                	mov    %esp,%ebp
  801339:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80133c:	8b 55 08             	mov    0x8(%ebp),%edx
  80133f:	8b 45 10             	mov    0x10(%ebp),%eax
  801342:	01 d0                	add    %edx,%eax
  801344:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801347:	eb 15                	jmp    80135e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801349:	8b 45 08             	mov    0x8(%ebp),%eax
  80134c:	8a 00                	mov    (%eax),%al
  80134e:	0f b6 d0             	movzbl %al,%edx
  801351:	8b 45 0c             	mov    0xc(%ebp),%eax
  801354:	0f b6 c0             	movzbl %al,%eax
  801357:	39 c2                	cmp    %eax,%edx
  801359:	74 0d                	je     801368 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80135b:	ff 45 08             	incl   0x8(%ebp)
  80135e:	8b 45 08             	mov    0x8(%ebp),%eax
  801361:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801364:	72 e3                	jb     801349 <memfind+0x13>
  801366:	eb 01                	jmp    801369 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801368:	90                   	nop
	return (void *) s;
  801369:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80136c:	c9                   	leave  
  80136d:	c3                   	ret    

0080136e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80136e:	55                   	push   %ebp
  80136f:	89 e5                	mov    %esp,%ebp
  801371:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801374:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80137b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801382:	eb 03                	jmp    801387 <strtol+0x19>
		s++;
  801384:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	3c 20                	cmp    $0x20,%al
  80138e:	74 f4                	je     801384 <strtol+0x16>
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	8a 00                	mov    (%eax),%al
  801395:	3c 09                	cmp    $0x9,%al
  801397:	74 eb                	je     801384 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801399:	8b 45 08             	mov    0x8(%ebp),%eax
  80139c:	8a 00                	mov    (%eax),%al
  80139e:	3c 2b                	cmp    $0x2b,%al
  8013a0:	75 05                	jne    8013a7 <strtol+0x39>
		s++;
  8013a2:	ff 45 08             	incl   0x8(%ebp)
  8013a5:	eb 13                	jmp    8013ba <strtol+0x4c>
	else if (*s == '-')
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	8a 00                	mov    (%eax),%al
  8013ac:	3c 2d                	cmp    $0x2d,%al
  8013ae:	75 0a                	jne    8013ba <strtol+0x4c>
		s++, neg = 1;
  8013b0:	ff 45 08             	incl   0x8(%ebp)
  8013b3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013be:	74 06                	je     8013c6 <strtol+0x58>
  8013c0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013c4:	75 20                	jne    8013e6 <strtol+0x78>
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	3c 30                	cmp    $0x30,%al
  8013cd:	75 17                	jne    8013e6 <strtol+0x78>
  8013cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d2:	40                   	inc    %eax
  8013d3:	8a 00                	mov    (%eax),%al
  8013d5:	3c 78                	cmp    $0x78,%al
  8013d7:	75 0d                	jne    8013e6 <strtol+0x78>
		s += 2, base = 16;
  8013d9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013dd:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013e4:	eb 28                	jmp    80140e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ea:	75 15                	jne    801401 <strtol+0x93>
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	8a 00                	mov    (%eax),%al
  8013f1:	3c 30                	cmp    $0x30,%al
  8013f3:	75 0c                	jne    801401 <strtol+0x93>
		s++, base = 8;
  8013f5:	ff 45 08             	incl   0x8(%ebp)
  8013f8:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013ff:	eb 0d                	jmp    80140e <strtol+0xa0>
	else if (base == 0)
  801401:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801405:	75 07                	jne    80140e <strtol+0xa0>
		base = 10;
  801407:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	8a 00                	mov    (%eax),%al
  801413:	3c 2f                	cmp    $0x2f,%al
  801415:	7e 19                	jle    801430 <strtol+0xc2>
  801417:	8b 45 08             	mov    0x8(%ebp),%eax
  80141a:	8a 00                	mov    (%eax),%al
  80141c:	3c 39                	cmp    $0x39,%al
  80141e:	7f 10                	jg     801430 <strtol+0xc2>
			dig = *s - '0';
  801420:	8b 45 08             	mov    0x8(%ebp),%eax
  801423:	8a 00                	mov    (%eax),%al
  801425:	0f be c0             	movsbl %al,%eax
  801428:	83 e8 30             	sub    $0x30,%eax
  80142b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80142e:	eb 42                	jmp    801472 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
  801433:	8a 00                	mov    (%eax),%al
  801435:	3c 60                	cmp    $0x60,%al
  801437:	7e 19                	jle    801452 <strtol+0xe4>
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	8a 00                	mov    (%eax),%al
  80143e:	3c 7a                	cmp    $0x7a,%al
  801440:	7f 10                	jg     801452 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	8a 00                	mov    (%eax),%al
  801447:	0f be c0             	movsbl %al,%eax
  80144a:	83 e8 57             	sub    $0x57,%eax
  80144d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801450:	eb 20                	jmp    801472 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
  801455:	8a 00                	mov    (%eax),%al
  801457:	3c 40                	cmp    $0x40,%al
  801459:	7e 39                	jle    801494 <strtol+0x126>
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
  80145e:	8a 00                	mov    (%eax),%al
  801460:	3c 5a                	cmp    $0x5a,%al
  801462:	7f 30                	jg     801494 <strtol+0x126>
			dig = *s - 'A' + 10;
  801464:	8b 45 08             	mov    0x8(%ebp),%eax
  801467:	8a 00                	mov    (%eax),%al
  801469:	0f be c0             	movsbl %al,%eax
  80146c:	83 e8 37             	sub    $0x37,%eax
  80146f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801472:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801475:	3b 45 10             	cmp    0x10(%ebp),%eax
  801478:	7d 19                	jge    801493 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80147a:	ff 45 08             	incl   0x8(%ebp)
  80147d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801480:	0f af 45 10          	imul   0x10(%ebp),%eax
  801484:	89 c2                	mov    %eax,%edx
  801486:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801489:	01 d0                	add    %edx,%eax
  80148b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80148e:	e9 7b ff ff ff       	jmp    80140e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801493:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801494:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801498:	74 08                	je     8014a2 <strtol+0x134>
		*endptr = (char *) s;
  80149a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149d:	8b 55 08             	mov    0x8(%ebp),%edx
  8014a0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014a6:	74 07                	je     8014af <strtol+0x141>
  8014a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ab:	f7 d8                	neg    %eax
  8014ad:	eb 03                	jmp    8014b2 <strtol+0x144>
  8014af:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014b2:	c9                   	leave  
  8014b3:	c3                   	ret    

008014b4 <ltostr>:

void
ltostr(long value, char *str)
{
  8014b4:	55                   	push   %ebp
  8014b5:	89 e5                	mov    %esp,%ebp
  8014b7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014c1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014c8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014cc:	79 13                	jns    8014e1 <ltostr+0x2d>
	{
		neg = 1;
  8014ce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014db:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014de:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014e9:	99                   	cltd   
  8014ea:	f7 f9                	idiv   %ecx
  8014ec:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f2:	8d 50 01             	lea    0x1(%eax),%edx
  8014f5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014f8:	89 c2                	mov    %eax,%edx
  8014fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fd:	01 d0                	add    %edx,%eax
  8014ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801502:	83 c2 30             	add    $0x30,%edx
  801505:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801507:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80150a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80150f:	f7 e9                	imul   %ecx
  801511:	c1 fa 02             	sar    $0x2,%edx
  801514:	89 c8                	mov    %ecx,%eax
  801516:	c1 f8 1f             	sar    $0x1f,%eax
  801519:	29 c2                	sub    %eax,%edx
  80151b:	89 d0                	mov    %edx,%eax
  80151d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801520:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801523:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801528:	f7 e9                	imul   %ecx
  80152a:	c1 fa 02             	sar    $0x2,%edx
  80152d:	89 c8                	mov    %ecx,%eax
  80152f:	c1 f8 1f             	sar    $0x1f,%eax
  801532:	29 c2                	sub    %eax,%edx
  801534:	89 d0                	mov    %edx,%eax
  801536:	c1 e0 02             	shl    $0x2,%eax
  801539:	01 d0                	add    %edx,%eax
  80153b:	01 c0                	add    %eax,%eax
  80153d:	29 c1                	sub    %eax,%ecx
  80153f:	89 ca                	mov    %ecx,%edx
  801541:	85 d2                	test   %edx,%edx
  801543:	75 9c                	jne    8014e1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801545:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80154c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80154f:	48                   	dec    %eax
  801550:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801553:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801557:	74 3d                	je     801596 <ltostr+0xe2>
		start = 1 ;
  801559:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801560:	eb 34                	jmp    801596 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801562:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801565:	8b 45 0c             	mov    0xc(%ebp),%eax
  801568:	01 d0                	add    %edx,%eax
  80156a:	8a 00                	mov    (%eax),%al
  80156c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80156f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801572:	8b 45 0c             	mov    0xc(%ebp),%eax
  801575:	01 c2                	add    %eax,%edx
  801577:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80157a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157d:	01 c8                	add    %ecx,%eax
  80157f:	8a 00                	mov    (%eax),%al
  801581:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801583:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801586:	8b 45 0c             	mov    0xc(%ebp),%eax
  801589:	01 c2                	add    %eax,%edx
  80158b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80158e:	88 02                	mov    %al,(%edx)
		start++ ;
  801590:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801593:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801596:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801599:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80159c:	7c c4                	jl     801562 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80159e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a4:	01 d0                	add    %edx,%eax
  8015a6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015a9:	90                   	nop
  8015aa:	c9                   	leave  
  8015ab:	c3                   	ret    

008015ac <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015ac:	55                   	push   %ebp
  8015ad:	89 e5                	mov    %esp,%ebp
  8015af:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015b2:	ff 75 08             	pushl  0x8(%ebp)
  8015b5:	e8 54 fa ff ff       	call   80100e <strlen>
  8015ba:	83 c4 04             	add    $0x4,%esp
  8015bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015c0:	ff 75 0c             	pushl  0xc(%ebp)
  8015c3:	e8 46 fa ff ff       	call   80100e <strlen>
  8015c8:	83 c4 04             	add    $0x4,%esp
  8015cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015dc:	eb 17                	jmp    8015f5 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015de:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e4:	01 c2                	add    %eax,%edx
  8015e6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ec:	01 c8                	add    %ecx,%eax
  8015ee:	8a 00                	mov    (%eax),%al
  8015f0:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015f2:	ff 45 fc             	incl   -0x4(%ebp)
  8015f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015fb:	7c e1                	jl     8015de <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015fd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801604:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80160b:	eb 1f                	jmp    80162c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80160d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801610:	8d 50 01             	lea    0x1(%eax),%edx
  801613:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801616:	89 c2                	mov    %eax,%edx
  801618:	8b 45 10             	mov    0x10(%ebp),%eax
  80161b:	01 c2                	add    %eax,%edx
  80161d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801620:	8b 45 0c             	mov    0xc(%ebp),%eax
  801623:	01 c8                	add    %ecx,%eax
  801625:	8a 00                	mov    (%eax),%al
  801627:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801629:	ff 45 f8             	incl   -0x8(%ebp)
  80162c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80162f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801632:	7c d9                	jl     80160d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801634:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801637:	8b 45 10             	mov    0x10(%ebp),%eax
  80163a:	01 d0                	add    %edx,%eax
  80163c:	c6 00 00             	movb   $0x0,(%eax)
}
  80163f:	90                   	nop
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801645:	8b 45 14             	mov    0x14(%ebp),%eax
  801648:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80164e:	8b 45 14             	mov    0x14(%ebp),%eax
  801651:	8b 00                	mov    (%eax),%eax
  801653:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80165a:	8b 45 10             	mov    0x10(%ebp),%eax
  80165d:	01 d0                	add    %edx,%eax
  80165f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801665:	eb 0c                	jmp    801673 <strsplit+0x31>
			*string++ = 0;
  801667:	8b 45 08             	mov    0x8(%ebp),%eax
  80166a:	8d 50 01             	lea    0x1(%eax),%edx
  80166d:	89 55 08             	mov    %edx,0x8(%ebp)
  801670:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801673:	8b 45 08             	mov    0x8(%ebp),%eax
  801676:	8a 00                	mov    (%eax),%al
  801678:	84 c0                	test   %al,%al
  80167a:	74 18                	je     801694 <strsplit+0x52>
  80167c:	8b 45 08             	mov    0x8(%ebp),%eax
  80167f:	8a 00                	mov    (%eax),%al
  801681:	0f be c0             	movsbl %al,%eax
  801684:	50                   	push   %eax
  801685:	ff 75 0c             	pushl  0xc(%ebp)
  801688:	e8 13 fb ff ff       	call   8011a0 <strchr>
  80168d:	83 c4 08             	add    $0x8,%esp
  801690:	85 c0                	test   %eax,%eax
  801692:	75 d3                	jne    801667 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801694:	8b 45 08             	mov    0x8(%ebp),%eax
  801697:	8a 00                	mov    (%eax),%al
  801699:	84 c0                	test   %al,%al
  80169b:	74 5a                	je     8016f7 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80169d:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a0:	8b 00                	mov    (%eax),%eax
  8016a2:	83 f8 0f             	cmp    $0xf,%eax
  8016a5:	75 07                	jne    8016ae <strsplit+0x6c>
		{
			return 0;
  8016a7:	b8 00 00 00 00       	mov    $0x0,%eax
  8016ac:	eb 66                	jmp    801714 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8016b1:	8b 00                	mov    (%eax),%eax
  8016b3:	8d 48 01             	lea    0x1(%eax),%ecx
  8016b6:	8b 55 14             	mov    0x14(%ebp),%edx
  8016b9:	89 0a                	mov    %ecx,(%edx)
  8016bb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c5:	01 c2                	add    %eax,%edx
  8016c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ca:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016cc:	eb 03                	jmp    8016d1 <strsplit+0x8f>
			string++;
  8016ce:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d4:	8a 00                	mov    (%eax),%al
  8016d6:	84 c0                	test   %al,%al
  8016d8:	74 8b                	je     801665 <strsplit+0x23>
  8016da:	8b 45 08             	mov    0x8(%ebp),%eax
  8016dd:	8a 00                	mov    (%eax),%al
  8016df:	0f be c0             	movsbl %al,%eax
  8016e2:	50                   	push   %eax
  8016e3:	ff 75 0c             	pushl  0xc(%ebp)
  8016e6:	e8 b5 fa ff ff       	call   8011a0 <strchr>
  8016eb:	83 c4 08             	add    $0x8,%esp
  8016ee:	85 c0                	test   %eax,%eax
  8016f0:	74 dc                	je     8016ce <strsplit+0x8c>
			string++;
	}
  8016f2:	e9 6e ff ff ff       	jmp    801665 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016f7:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8016fb:	8b 00                	mov    (%eax),%eax
  8016fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801704:	8b 45 10             	mov    0x10(%ebp),%eax
  801707:	01 d0                	add    %edx,%eax
  801709:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80170f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801714:	c9                   	leave  
  801715:	c3                   	ret    

00801716 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801716:	55                   	push   %ebp
  801717:	89 e5                	mov    %esp,%ebp
  801719:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  80171c:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801723:	76 0a                	jbe    80172f <malloc+0x19>
		return NULL;
  801725:	b8 00 00 00 00       	mov    $0x0,%eax
  80172a:	e9 ad 02 00 00       	jmp    8019dc <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  80172f:	8b 45 08             	mov    0x8(%ebp),%eax
  801732:	c1 e8 0c             	shr    $0xc,%eax
  801735:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801738:	8b 45 08             	mov    0x8(%ebp),%eax
  80173b:	25 ff 0f 00 00       	and    $0xfff,%eax
  801740:	85 c0                	test   %eax,%eax
  801742:	74 03                	je     801747 <malloc+0x31>
		num++;
  801744:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801747:	a1 28 30 80 00       	mov    0x803028,%eax
  80174c:	85 c0                	test   %eax,%eax
  80174e:	75 71                	jne    8017c1 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801750:	a1 04 30 80 00       	mov    0x803004,%eax
  801755:	83 ec 08             	sub    $0x8,%esp
  801758:	ff 75 08             	pushl  0x8(%ebp)
  80175b:	50                   	push   %eax
  80175c:	e8 ba 05 00 00       	call   801d1b <sys_allocateMem>
  801761:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801764:	a1 04 30 80 00       	mov    0x803004,%eax
  801769:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  80176c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80176f:	c1 e0 0c             	shl    $0xc,%eax
  801772:	89 c2                	mov    %eax,%edx
  801774:	a1 04 30 80 00       	mov    0x803004,%eax
  801779:	01 d0                	add    %edx,%eax
  80177b:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801780:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801785:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801788:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  80178f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801794:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801797:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  80179e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017a3:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8017aa:	01 00 00 00 
		sizeofarray++;
  8017ae:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017b3:	40                   	inc    %eax
  8017b4:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  8017b9:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8017bc:	e9 1b 02 00 00       	jmp    8019dc <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  8017c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  8017c8:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  8017cf:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  8017d6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  8017dd:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  8017e4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8017eb:	eb 72                	jmp    80185f <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  8017ed:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8017f0:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8017f7:	85 c0                	test   %eax,%eax
  8017f9:	75 12                	jne    80180d <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  8017fb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8017fe:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801805:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801808:	ff 45 dc             	incl   -0x24(%ebp)
  80180b:	eb 4f                	jmp    80185c <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  80180d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801810:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801813:	7d 39                	jge    80184e <malloc+0x138>
  801815:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801818:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80181b:	7c 31                	jl     80184e <malloc+0x138>
					{
						min=count;
  80181d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801820:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801823:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801826:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  80182d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801830:	c1 e2 0c             	shl    $0xc,%edx
  801833:	29 d0                	sub    %edx,%eax
  801835:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801838:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80183b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80183e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801841:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801848:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80184b:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  80184e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801855:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  80185c:	ff 45 d4             	incl   -0x2c(%ebp)
  80185f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801864:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801867:	7c 84                	jl     8017ed <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801869:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  80186d:	0f 85 e3 00 00 00    	jne    801956 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801873:	83 ec 08             	sub    $0x8,%esp
  801876:	ff 75 08             	pushl  0x8(%ebp)
  801879:	ff 75 e0             	pushl  -0x20(%ebp)
  80187c:	e8 9a 04 00 00       	call   801d1b <sys_allocateMem>
  801881:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801884:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801889:	40                   	inc    %eax
  80188a:	a3 2c 30 80 00       	mov    %eax,0x80302c
				for(int i=sizeofarray-1;i>index;i--)
  80188f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801894:	48                   	dec    %eax
  801895:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801898:	eb 42                	jmp    8018dc <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  80189a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80189d:	48                   	dec    %eax
  80189e:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  8018a5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018a8:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  8018af:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018b2:	48                   	dec    %eax
  8018b3:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  8018ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018bd:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  8018c4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018c7:	48                   	dec    %eax
  8018c8:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  8018cf:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018d2:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  8018d9:	ff 4d d0             	decl   -0x30(%ebp)
  8018dc:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8018df:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8018e2:	7f b6                	jg     80189a <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  8018e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018e7:	40                   	inc    %eax
  8018e8:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  8018eb:	8b 55 08             	mov    0x8(%ebp),%edx
  8018ee:	01 ca                	add    %ecx,%edx
  8018f0:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  8018f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8018fa:	8d 50 01             	lea    0x1(%eax),%edx
  8018fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801900:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801907:	2b 45 f4             	sub    -0xc(%ebp),%eax
  80190a:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801911:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801914:	40                   	inc    %eax
  801915:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  80191c:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801920:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801923:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801926:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  80192d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801930:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801933:	eb 11                	jmp    801946 <malloc+0x230>
				{
					changed[index] = 1;
  801935:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801938:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  80193f:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801943:	ff 45 cc             	incl   -0x34(%ebp)
  801946:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801949:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80194c:	7c e7                	jl     801935 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  80194e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801951:	e9 86 00 00 00       	jmp    8019dc <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801956:	a1 04 30 80 00       	mov    0x803004,%eax
  80195b:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801960:	29 c2                	sub    %eax,%edx
  801962:	89 d0                	mov    %edx,%eax
  801964:	3b 45 08             	cmp    0x8(%ebp),%eax
  801967:	73 07                	jae    801970 <malloc+0x25a>
						return NULL;
  801969:	b8 00 00 00 00       	mov    $0x0,%eax
  80196e:	eb 6c                	jmp    8019dc <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801970:	a1 04 30 80 00       	mov    0x803004,%eax
  801975:	83 ec 08             	sub    $0x8,%esp
  801978:	ff 75 08             	pushl  0x8(%ebp)
  80197b:	50                   	push   %eax
  80197c:	e8 9a 03 00 00       	call   801d1b <sys_allocateMem>
  801981:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801984:	a1 04 30 80 00       	mov    0x803004,%eax
  801989:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  80198c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80198f:	c1 e0 0c             	shl    $0xc,%eax
  801992:	89 c2                	mov    %eax,%edx
  801994:	a1 04 30 80 00       	mov    0x803004,%eax
  801999:	01 d0                	add    %edx,%eax
  80199b:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  8019a0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019a8:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  8019af:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019b4:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8019b7:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  8019be:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019c3:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8019ca:	01 00 00 00 
					sizeofarray++;
  8019ce:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019d3:	40                   	inc    %eax
  8019d4:	a3 2c 30 80 00       	mov    %eax,0x80302c
					return (void*) return_addres;
  8019d9:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  8019dc:	c9                   	leave  
  8019dd:	c3                   	ret    

008019de <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
  8019e1:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  8019e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e7:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  8019ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  8019f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8019f8:	eb 30                	jmp    801a2a <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  8019fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019fd:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801a04:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801a07:	75 1e                	jne    801a27 <free+0x49>
  801a09:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a0c:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801a13:	83 f8 01             	cmp    $0x1,%eax
  801a16:	75 0f                	jne    801a27 <free+0x49>
			is_found = 1;
  801a18:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801a1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a22:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801a25:	eb 0d                	jmp    801a34 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801a27:	ff 45 ec             	incl   -0x14(%ebp)
  801a2a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a2f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801a32:	7c c6                	jl     8019fa <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801a34:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801a38:	75 3a                	jne    801a74 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801a3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a3d:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801a44:	c1 e0 0c             	shl    $0xc,%eax
  801a47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801a4a:	83 ec 08             	sub    $0x8,%esp
  801a4d:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a50:	ff 75 e8             	pushl  -0x18(%ebp)
  801a53:	e8 a7 02 00 00       	call   801cff <sys_freeMem>
  801a58:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801a5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a5e:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801a65:	00 00 00 00 
		changes++;
  801a69:	a1 28 30 80 00       	mov    0x803028,%eax
  801a6e:	40                   	inc    %eax
  801a6f:	a3 28 30 80 00       	mov    %eax,0x803028
	}
	//refer to the project presentation and documentation for details
}
  801a74:	90                   	nop
  801a75:	c9                   	leave  
  801a76:	c3                   	ret    

00801a77 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801a77:	55                   	push   %ebp
  801a78:	89 e5                	mov    %esp,%ebp
  801a7a:	83 ec 18             	sub    $0x18,%esp
  801a7d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a80:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a83:	83 ec 04             	sub    $0x4,%esp
  801a86:	68 f0 2c 80 00       	push   $0x802cf0
  801a8b:	68 b6 00 00 00       	push   $0xb6
  801a90:	68 13 2d 80 00       	push   $0x802d13
  801a95:	e8 50 ec ff ff       	call   8006ea <_panic>

00801a9a <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801a9a:	55                   	push   %ebp
  801a9b:	89 e5                	mov    %esp,%ebp
  801a9d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aa0:	83 ec 04             	sub    $0x4,%esp
  801aa3:	68 f0 2c 80 00       	push   $0x802cf0
  801aa8:	68 bb 00 00 00       	push   $0xbb
  801aad:	68 13 2d 80 00       	push   $0x802d13
  801ab2:	e8 33 ec ff ff       	call   8006ea <_panic>

00801ab7 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801ab7:	55                   	push   %ebp
  801ab8:	89 e5                	mov    %esp,%ebp
  801aba:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801abd:	83 ec 04             	sub    $0x4,%esp
  801ac0:	68 f0 2c 80 00       	push   $0x802cf0
  801ac5:	68 c0 00 00 00       	push   $0xc0
  801aca:	68 13 2d 80 00       	push   $0x802d13
  801acf:	e8 16 ec ff ff       	call   8006ea <_panic>

00801ad4 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801ad4:	55                   	push   %ebp
  801ad5:	89 e5                	mov    %esp,%ebp
  801ad7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ada:	83 ec 04             	sub    $0x4,%esp
  801add:	68 f0 2c 80 00       	push   $0x802cf0
  801ae2:	68 c4 00 00 00       	push   $0xc4
  801ae7:	68 13 2d 80 00       	push   $0x802d13
  801aec:	e8 f9 eb ff ff       	call   8006ea <_panic>

00801af1 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
  801af4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801af7:	83 ec 04             	sub    $0x4,%esp
  801afa:	68 f0 2c 80 00       	push   $0x802cf0
  801aff:	68 c9 00 00 00       	push   $0xc9
  801b04:	68 13 2d 80 00       	push   $0x802d13
  801b09:	e8 dc eb ff ff       	call   8006ea <_panic>

00801b0e <shrink>:
}
void shrink(uint32 newSize) {
  801b0e:	55                   	push   %ebp
  801b0f:	89 e5                	mov    %esp,%ebp
  801b11:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b14:	83 ec 04             	sub    $0x4,%esp
  801b17:	68 f0 2c 80 00       	push   $0x802cf0
  801b1c:	68 cc 00 00 00       	push   $0xcc
  801b21:	68 13 2d 80 00       	push   $0x802d13
  801b26:	e8 bf eb ff ff       	call   8006ea <_panic>

00801b2b <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
  801b2e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b31:	83 ec 04             	sub    $0x4,%esp
  801b34:	68 f0 2c 80 00       	push   $0x802cf0
  801b39:	68 d0 00 00 00       	push   $0xd0
  801b3e:	68 13 2d 80 00       	push   $0x802d13
  801b43:	e8 a2 eb ff ff       	call   8006ea <_panic>

00801b48 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b48:	55                   	push   %ebp
  801b49:	89 e5                	mov    %esp,%ebp
  801b4b:	57                   	push   %edi
  801b4c:	56                   	push   %esi
  801b4d:	53                   	push   %ebx
  801b4e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b51:	8b 45 08             	mov    0x8(%ebp),%eax
  801b54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b57:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b5a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b5d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b60:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b63:	cd 30                	int    $0x30
  801b65:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b68:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b6b:	83 c4 10             	add    $0x10,%esp
  801b6e:	5b                   	pop    %ebx
  801b6f:	5e                   	pop    %esi
  801b70:	5f                   	pop    %edi
  801b71:	5d                   	pop    %ebp
  801b72:	c3                   	ret    

00801b73 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b73:	55                   	push   %ebp
  801b74:	89 e5                	mov    %esp,%ebp
  801b76:	83 ec 04             	sub    $0x4,%esp
  801b79:	8b 45 10             	mov    0x10(%ebp),%eax
  801b7c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b7f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b83:	8b 45 08             	mov    0x8(%ebp),%eax
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	52                   	push   %edx
  801b8b:	ff 75 0c             	pushl  0xc(%ebp)
  801b8e:	50                   	push   %eax
  801b8f:	6a 00                	push   $0x0
  801b91:	e8 b2 ff ff ff       	call   801b48 <syscall>
  801b96:	83 c4 18             	add    $0x18,%esp
}
  801b99:	90                   	nop
  801b9a:	c9                   	leave  
  801b9b:	c3                   	ret    

00801b9c <sys_cgetc>:

int
sys_cgetc(void)
{
  801b9c:	55                   	push   %ebp
  801b9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 01                	push   $0x1
  801bab:	e8 98 ff ff ff       	call   801b48 <syscall>
  801bb0:	83 c4 18             	add    $0x18,%esp
}
  801bb3:	c9                   	leave  
  801bb4:	c3                   	ret    

00801bb5 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801bb5:	55                   	push   %ebp
  801bb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	50                   	push   %eax
  801bc4:	6a 05                	push   $0x5
  801bc6:	e8 7d ff ff ff       	call   801b48 <syscall>
  801bcb:	83 c4 18             	add    $0x18,%esp
}
  801bce:	c9                   	leave  
  801bcf:	c3                   	ret    

00801bd0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 02                	push   $0x2
  801bdf:	e8 64 ff ff ff       	call   801b48 <syscall>
  801be4:	83 c4 18             	add    $0x18,%esp
}
  801be7:	c9                   	leave  
  801be8:	c3                   	ret    

00801be9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801be9:	55                   	push   %ebp
  801bea:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 00                	push   $0x0
  801bf2:	6a 00                	push   $0x0
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 03                	push   $0x3
  801bf8:	e8 4b ff ff ff       	call   801b48 <syscall>
  801bfd:	83 c4 18             	add    $0x18,%esp
}
  801c00:	c9                   	leave  
  801c01:	c3                   	ret    

00801c02 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c02:	55                   	push   %ebp
  801c03:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 04                	push   $0x4
  801c11:	e8 32 ff ff ff       	call   801b48 <syscall>
  801c16:	83 c4 18             	add    $0x18,%esp
}
  801c19:	c9                   	leave  
  801c1a:	c3                   	ret    

00801c1b <sys_env_exit>:


void sys_env_exit(void)
{
  801c1b:	55                   	push   %ebp
  801c1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	6a 00                	push   $0x0
  801c24:	6a 00                	push   $0x0
  801c26:	6a 00                	push   $0x0
  801c28:	6a 06                	push   $0x6
  801c2a:	e8 19 ff ff ff       	call   801b48 <syscall>
  801c2f:	83 c4 18             	add    $0x18,%esp
}
  801c32:	90                   	nop
  801c33:	c9                   	leave  
  801c34:	c3                   	ret    

00801c35 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c35:	55                   	push   %ebp
  801c36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c38:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	52                   	push   %edx
  801c45:	50                   	push   %eax
  801c46:	6a 07                	push   $0x7
  801c48:	e8 fb fe ff ff       	call   801b48 <syscall>
  801c4d:	83 c4 18             	add    $0x18,%esp
}
  801c50:	c9                   	leave  
  801c51:	c3                   	ret    

00801c52 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c52:	55                   	push   %ebp
  801c53:	89 e5                	mov    %esp,%ebp
  801c55:	56                   	push   %esi
  801c56:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c57:	8b 75 18             	mov    0x18(%ebp),%esi
  801c5a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c5d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c63:	8b 45 08             	mov    0x8(%ebp),%eax
  801c66:	56                   	push   %esi
  801c67:	53                   	push   %ebx
  801c68:	51                   	push   %ecx
  801c69:	52                   	push   %edx
  801c6a:	50                   	push   %eax
  801c6b:	6a 08                	push   $0x8
  801c6d:	e8 d6 fe ff ff       	call   801b48 <syscall>
  801c72:	83 c4 18             	add    $0x18,%esp
}
  801c75:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c78:	5b                   	pop    %ebx
  801c79:	5e                   	pop    %esi
  801c7a:	5d                   	pop    %ebp
  801c7b:	c3                   	ret    

00801c7c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c7c:	55                   	push   %ebp
  801c7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c82:	8b 45 08             	mov    0x8(%ebp),%eax
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	52                   	push   %edx
  801c8c:	50                   	push   %eax
  801c8d:	6a 09                	push   $0x9
  801c8f:	e8 b4 fe ff ff       	call   801b48 <syscall>
  801c94:	83 c4 18             	add    $0x18,%esp
}
  801c97:	c9                   	leave  
  801c98:	c3                   	ret    

00801c99 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c99:	55                   	push   %ebp
  801c9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	ff 75 0c             	pushl  0xc(%ebp)
  801ca5:	ff 75 08             	pushl  0x8(%ebp)
  801ca8:	6a 0a                	push   $0xa
  801caa:	e8 99 fe ff ff       	call   801b48 <syscall>
  801caf:	83 c4 18             	add    $0x18,%esp
}
  801cb2:	c9                   	leave  
  801cb3:	c3                   	ret    

00801cb4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801cb4:	55                   	push   %ebp
  801cb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 0b                	push   $0xb
  801cc3:	e8 80 fe ff ff       	call   801b48 <syscall>
  801cc8:	83 c4 18             	add    $0x18,%esp
}
  801ccb:	c9                   	leave  
  801ccc:	c3                   	ret    

00801ccd <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ccd:	55                   	push   %ebp
  801cce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 0c                	push   $0xc
  801cdc:	e8 67 fe ff ff       	call   801b48 <syscall>
  801ce1:	83 c4 18             	add    $0x18,%esp
}
  801ce4:	c9                   	leave  
  801ce5:	c3                   	ret    

00801ce6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ce6:	55                   	push   %ebp
  801ce7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 0d                	push   $0xd
  801cf5:	e8 4e fe ff ff       	call   801b48 <syscall>
  801cfa:	83 c4 18             	add    $0x18,%esp
}
  801cfd:	c9                   	leave  
  801cfe:	c3                   	ret    

00801cff <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	ff 75 0c             	pushl  0xc(%ebp)
  801d0b:	ff 75 08             	pushl  0x8(%ebp)
  801d0e:	6a 11                	push   $0x11
  801d10:	e8 33 fe ff ff       	call   801b48 <syscall>
  801d15:	83 c4 18             	add    $0x18,%esp
	return;
  801d18:	90                   	nop
}
  801d19:	c9                   	leave  
  801d1a:	c3                   	ret    

00801d1b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	ff 75 0c             	pushl  0xc(%ebp)
  801d27:	ff 75 08             	pushl  0x8(%ebp)
  801d2a:	6a 12                	push   $0x12
  801d2c:	e8 17 fe ff ff       	call   801b48 <syscall>
  801d31:	83 c4 18             	add    $0x18,%esp
	return ;
  801d34:	90                   	nop
}
  801d35:	c9                   	leave  
  801d36:	c3                   	ret    

00801d37 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d37:	55                   	push   %ebp
  801d38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	6a 0e                	push   $0xe
  801d46:	e8 fd fd ff ff       	call   801b48 <syscall>
  801d4b:	83 c4 18             	add    $0x18,%esp
}
  801d4e:	c9                   	leave  
  801d4f:	c3                   	ret    

00801d50 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d50:	55                   	push   %ebp
  801d51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	ff 75 08             	pushl  0x8(%ebp)
  801d5e:	6a 0f                	push   $0xf
  801d60:	e8 e3 fd ff ff       	call   801b48 <syscall>
  801d65:	83 c4 18             	add    $0x18,%esp
}
  801d68:	c9                   	leave  
  801d69:	c3                   	ret    

00801d6a <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d6a:	55                   	push   %ebp
  801d6b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d6d:	6a 00                	push   $0x0
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 10                	push   $0x10
  801d79:	e8 ca fd ff ff       	call   801b48 <syscall>
  801d7e:	83 c4 18             	add    $0x18,%esp
}
  801d81:	90                   	nop
  801d82:	c9                   	leave  
  801d83:	c3                   	ret    

00801d84 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d84:	55                   	push   %ebp
  801d85:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 00                	push   $0x0
  801d8d:	6a 00                	push   $0x0
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 14                	push   $0x14
  801d93:	e8 b0 fd ff ff       	call   801b48 <syscall>
  801d98:	83 c4 18             	add    $0x18,%esp
}
  801d9b:	90                   	nop
  801d9c:	c9                   	leave  
  801d9d:	c3                   	ret    

00801d9e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d9e:	55                   	push   %ebp
  801d9f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	6a 00                	push   $0x0
  801dab:	6a 15                	push   $0x15
  801dad:	e8 96 fd ff ff       	call   801b48 <syscall>
  801db2:	83 c4 18             	add    $0x18,%esp
}
  801db5:	90                   	nop
  801db6:	c9                   	leave  
  801db7:	c3                   	ret    

00801db8 <sys_cputc>:


void
sys_cputc(const char c)
{
  801db8:	55                   	push   %ebp
  801db9:	89 e5                	mov    %esp,%ebp
  801dbb:	83 ec 04             	sub    $0x4,%esp
  801dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801dc4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	50                   	push   %eax
  801dd1:	6a 16                	push   $0x16
  801dd3:	e8 70 fd ff ff       	call   801b48 <syscall>
  801dd8:	83 c4 18             	add    $0x18,%esp
}
  801ddb:	90                   	nop
  801ddc:	c9                   	leave  
  801ddd:	c3                   	ret    

00801dde <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801dde:	55                   	push   %ebp
  801ddf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 17                	push   $0x17
  801ded:	e8 56 fd ff ff       	call   801b48 <syscall>
  801df2:	83 c4 18             	add    $0x18,%esp
}
  801df5:	90                   	nop
  801df6:	c9                   	leave  
  801df7:	c3                   	ret    

00801df8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801df8:	55                   	push   %ebp
  801df9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	ff 75 0c             	pushl  0xc(%ebp)
  801e07:	50                   	push   %eax
  801e08:	6a 18                	push   $0x18
  801e0a:	e8 39 fd ff ff       	call   801b48 <syscall>
  801e0f:	83 c4 18             	add    $0x18,%esp
}
  801e12:	c9                   	leave  
  801e13:	c3                   	ret    

00801e14 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e14:	55                   	push   %ebp
  801e15:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	52                   	push   %edx
  801e24:	50                   	push   %eax
  801e25:	6a 1b                	push   $0x1b
  801e27:	e8 1c fd ff ff       	call   801b48 <syscall>
  801e2c:	83 c4 18             	add    $0x18,%esp
}
  801e2f:	c9                   	leave  
  801e30:	c3                   	ret    

00801e31 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e31:	55                   	push   %ebp
  801e32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e37:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	52                   	push   %edx
  801e41:	50                   	push   %eax
  801e42:	6a 19                	push   $0x19
  801e44:	e8 ff fc ff ff       	call   801b48 <syscall>
  801e49:	83 c4 18             	add    $0x18,%esp
}
  801e4c:	90                   	nop
  801e4d:	c9                   	leave  
  801e4e:	c3                   	ret    

00801e4f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e4f:	55                   	push   %ebp
  801e50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e52:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e55:	8b 45 08             	mov    0x8(%ebp),%eax
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 00                	push   $0x0
  801e5e:	52                   	push   %edx
  801e5f:	50                   	push   %eax
  801e60:	6a 1a                	push   $0x1a
  801e62:	e8 e1 fc ff ff       	call   801b48 <syscall>
  801e67:	83 c4 18             	add    $0x18,%esp
}
  801e6a:	90                   	nop
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
  801e70:	83 ec 04             	sub    $0x4,%esp
  801e73:	8b 45 10             	mov    0x10(%ebp),%eax
  801e76:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e79:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e7c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e80:	8b 45 08             	mov    0x8(%ebp),%eax
  801e83:	6a 00                	push   $0x0
  801e85:	51                   	push   %ecx
  801e86:	52                   	push   %edx
  801e87:	ff 75 0c             	pushl  0xc(%ebp)
  801e8a:	50                   	push   %eax
  801e8b:	6a 1c                	push   $0x1c
  801e8d:	e8 b6 fc ff ff       	call   801b48 <syscall>
  801e92:	83 c4 18             	add    $0x18,%esp
}
  801e95:	c9                   	leave  
  801e96:	c3                   	ret    

00801e97 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e97:	55                   	push   %ebp
  801e98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 00                	push   $0x0
  801ea6:	52                   	push   %edx
  801ea7:	50                   	push   %eax
  801ea8:	6a 1d                	push   $0x1d
  801eaa:	e8 99 fc ff ff       	call   801b48 <syscall>
  801eaf:	83 c4 18             	add    $0x18,%esp
}
  801eb2:	c9                   	leave  
  801eb3:	c3                   	ret    

00801eb4 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801eb4:	55                   	push   %ebp
  801eb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801eb7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801eba:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ebd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	51                   	push   %ecx
  801ec5:	52                   	push   %edx
  801ec6:	50                   	push   %eax
  801ec7:	6a 1e                	push   $0x1e
  801ec9:	e8 7a fc ff ff       	call   801b48 <syscall>
  801ece:	83 c4 18             	add    $0x18,%esp
}
  801ed1:	c9                   	leave  
  801ed2:	c3                   	ret    

00801ed3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ed3:	55                   	push   %ebp
  801ed4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ed6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  801edc:	6a 00                	push   $0x0
  801ede:	6a 00                	push   $0x0
  801ee0:	6a 00                	push   $0x0
  801ee2:	52                   	push   %edx
  801ee3:	50                   	push   %eax
  801ee4:	6a 1f                	push   $0x1f
  801ee6:	e8 5d fc ff ff       	call   801b48 <syscall>
  801eeb:	83 c4 18             	add    $0x18,%esp
}
  801eee:	c9                   	leave  
  801eef:	c3                   	ret    

00801ef0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ef0:	55                   	push   %ebp
  801ef1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 20                	push   $0x20
  801eff:	e8 44 fc ff ff       	call   801b48 <syscall>
  801f04:	83 c4 18             	add    $0x18,%esp
}
  801f07:	c9                   	leave  
  801f08:	c3                   	ret    

00801f09 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f09:	55                   	push   %ebp
  801f0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0f:	6a 00                	push   $0x0
  801f11:	ff 75 14             	pushl  0x14(%ebp)
  801f14:	ff 75 10             	pushl  0x10(%ebp)
  801f17:	ff 75 0c             	pushl  0xc(%ebp)
  801f1a:	50                   	push   %eax
  801f1b:	6a 21                	push   $0x21
  801f1d:	e8 26 fc ff ff       	call   801b48 <syscall>
  801f22:	83 c4 18             	add    $0x18,%esp
}
  801f25:	c9                   	leave  
  801f26:	c3                   	ret    

00801f27 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801f27:	55                   	push   %ebp
  801f28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	50                   	push   %eax
  801f36:	6a 22                	push   $0x22
  801f38:	e8 0b fc ff ff       	call   801b48 <syscall>
  801f3d:	83 c4 18             	add    $0x18,%esp
}
  801f40:	90                   	nop
  801f41:	c9                   	leave  
  801f42:	c3                   	ret    

00801f43 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f43:	55                   	push   %ebp
  801f44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f46:	8b 45 08             	mov    0x8(%ebp),%eax
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	50                   	push   %eax
  801f52:	6a 23                	push   $0x23
  801f54:	e8 ef fb ff ff       	call   801b48 <syscall>
  801f59:	83 c4 18             	add    $0x18,%esp
}
  801f5c:	90                   	nop
  801f5d:	c9                   	leave  
  801f5e:	c3                   	ret    

00801f5f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f5f:	55                   	push   %ebp
  801f60:	89 e5                	mov    %esp,%ebp
  801f62:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f65:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f68:	8d 50 04             	lea    0x4(%eax),%edx
  801f6b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	52                   	push   %edx
  801f75:	50                   	push   %eax
  801f76:	6a 24                	push   $0x24
  801f78:	e8 cb fb ff ff       	call   801b48 <syscall>
  801f7d:	83 c4 18             	add    $0x18,%esp
	return result;
  801f80:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f83:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f86:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f89:	89 01                	mov    %eax,(%ecx)
  801f8b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f91:	c9                   	leave  
  801f92:	c2 04 00             	ret    $0x4

00801f95 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f95:	55                   	push   %ebp
  801f96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	ff 75 10             	pushl  0x10(%ebp)
  801f9f:	ff 75 0c             	pushl  0xc(%ebp)
  801fa2:	ff 75 08             	pushl  0x8(%ebp)
  801fa5:	6a 13                	push   $0x13
  801fa7:	e8 9c fb ff ff       	call   801b48 <syscall>
  801fac:	83 c4 18             	add    $0x18,%esp
	return ;
  801faf:	90                   	nop
}
  801fb0:	c9                   	leave  
  801fb1:	c3                   	ret    

00801fb2 <sys_rcr2>:
uint32 sys_rcr2()
{
  801fb2:	55                   	push   %ebp
  801fb3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 25                	push   $0x25
  801fc1:	e8 82 fb ff ff       	call   801b48 <syscall>
  801fc6:	83 c4 18             	add    $0x18,%esp
}
  801fc9:	c9                   	leave  
  801fca:	c3                   	ret    

00801fcb <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801fcb:	55                   	push   %ebp
  801fcc:	89 e5                	mov    %esp,%ebp
  801fce:	83 ec 04             	sub    $0x4,%esp
  801fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801fd7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 00                	push   $0x0
  801fe1:	6a 00                	push   $0x0
  801fe3:	50                   	push   %eax
  801fe4:	6a 26                	push   $0x26
  801fe6:	e8 5d fb ff ff       	call   801b48 <syscall>
  801feb:	83 c4 18             	add    $0x18,%esp
	return ;
  801fee:	90                   	nop
}
  801fef:	c9                   	leave  
  801ff0:	c3                   	ret    

00801ff1 <rsttst>:
void rsttst()
{
  801ff1:	55                   	push   %ebp
  801ff2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 00                	push   $0x0
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 00                	push   $0x0
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 28                	push   $0x28
  802000:	e8 43 fb ff ff       	call   801b48 <syscall>
  802005:	83 c4 18             	add    $0x18,%esp
	return ;
  802008:	90                   	nop
}
  802009:	c9                   	leave  
  80200a:	c3                   	ret    

0080200b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80200b:	55                   	push   %ebp
  80200c:	89 e5                	mov    %esp,%ebp
  80200e:	83 ec 04             	sub    $0x4,%esp
  802011:	8b 45 14             	mov    0x14(%ebp),%eax
  802014:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802017:	8b 55 18             	mov    0x18(%ebp),%edx
  80201a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80201e:	52                   	push   %edx
  80201f:	50                   	push   %eax
  802020:	ff 75 10             	pushl  0x10(%ebp)
  802023:	ff 75 0c             	pushl  0xc(%ebp)
  802026:	ff 75 08             	pushl  0x8(%ebp)
  802029:	6a 27                	push   $0x27
  80202b:	e8 18 fb ff ff       	call   801b48 <syscall>
  802030:	83 c4 18             	add    $0x18,%esp
	return ;
  802033:	90                   	nop
}
  802034:	c9                   	leave  
  802035:	c3                   	ret    

00802036 <chktst>:
void chktst(uint32 n)
{
  802036:	55                   	push   %ebp
  802037:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	ff 75 08             	pushl  0x8(%ebp)
  802044:	6a 29                	push   $0x29
  802046:	e8 fd fa ff ff       	call   801b48 <syscall>
  80204b:	83 c4 18             	add    $0x18,%esp
	return ;
  80204e:	90                   	nop
}
  80204f:	c9                   	leave  
  802050:	c3                   	ret    

00802051 <inctst>:

void inctst()
{
  802051:	55                   	push   %ebp
  802052:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802054:	6a 00                	push   $0x0
  802056:	6a 00                	push   $0x0
  802058:	6a 00                	push   $0x0
  80205a:	6a 00                	push   $0x0
  80205c:	6a 00                	push   $0x0
  80205e:	6a 2a                	push   $0x2a
  802060:	e8 e3 fa ff ff       	call   801b48 <syscall>
  802065:	83 c4 18             	add    $0x18,%esp
	return ;
  802068:	90                   	nop
}
  802069:	c9                   	leave  
  80206a:	c3                   	ret    

0080206b <gettst>:
uint32 gettst()
{
  80206b:	55                   	push   %ebp
  80206c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80206e:	6a 00                	push   $0x0
  802070:	6a 00                	push   $0x0
  802072:	6a 00                	push   $0x0
  802074:	6a 00                	push   $0x0
  802076:	6a 00                	push   $0x0
  802078:	6a 2b                	push   $0x2b
  80207a:	e8 c9 fa ff ff       	call   801b48 <syscall>
  80207f:	83 c4 18             	add    $0x18,%esp
}
  802082:	c9                   	leave  
  802083:	c3                   	ret    

00802084 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802084:	55                   	push   %ebp
  802085:	89 e5                	mov    %esp,%ebp
  802087:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80208a:	6a 00                	push   $0x0
  80208c:	6a 00                	push   $0x0
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	6a 2c                	push   $0x2c
  802096:	e8 ad fa ff ff       	call   801b48 <syscall>
  80209b:	83 c4 18             	add    $0x18,%esp
  80209e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8020a1:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8020a5:	75 07                	jne    8020ae <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8020a7:	b8 01 00 00 00       	mov    $0x1,%eax
  8020ac:	eb 05                	jmp    8020b3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8020ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020b3:	c9                   	leave  
  8020b4:	c3                   	ret    

008020b5 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8020b5:	55                   	push   %ebp
  8020b6:	89 e5                	mov    %esp,%ebp
  8020b8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 2c                	push   $0x2c
  8020c7:	e8 7c fa ff ff       	call   801b48 <syscall>
  8020cc:	83 c4 18             	add    $0x18,%esp
  8020cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8020d2:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8020d6:	75 07                	jne    8020df <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8020d8:	b8 01 00 00 00       	mov    $0x1,%eax
  8020dd:	eb 05                	jmp    8020e4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8020df:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020e4:	c9                   	leave  
  8020e5:	c3                   	ret    

008020e6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8020e6:	55                   	push   %ebp
  8020e7:	89 e5                	mov    %esp,%ebp
  8020e9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020ec:	6a 00                	push   $0x0
  8020ee:	6a 00                	push   $0x0
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 00                	push   $0x0
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 2c                	push   $0x2c
  8020f8:	e8 4b fa ff ff       	call   801b48 <syscall>
  8020fd:	83 c4 18             	add    $0x18,%esp
  802100:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802103:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802107:	75 07                	jne    802110 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802109:	b8 01 00 00 00       	mov    $0x1,%eax
  80210e:	eb 05                	jmp    802115 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802110:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802115:	c9                   	leave  
  802116:	c3                   	ret    

00802117 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802117:	55                   	push   %ebp
  802118:	89 e5                	mov    %esp,%ebp
  80211a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80211d:	6a 00                	push   $0x0
  80211f:	6a 00                	push   $0x0
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	6a 2c                	push   $0x2c
  802129:	e8 1a fa ff ff       	call   801b48 <syscall>
  80212e:	83 c4 18             	add    $0x18,%esp
  802131:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802134:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802138:	75 07                	jne    802141 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80213a:	b8 01 00 00 00       	mov    $0x1,%eax
  80213f:	eb 05                	jmp    802146 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802141:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802146:	c9                   	leave  
  802147:	c3                   	ret    

00802148 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802148:	55                   	push   %ebp
  802149:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	ff 75 08             	pushl  0x8(%ebp)
  802156:	6a 2d                	push   $0x2d
  802158:	e8 eb f9 ff ff       	call   801b48 <syscall>
  80215d:	83 c4 18             	add    $0x18,%esp
	return ;
  802160:	90                   	nop
}
  802161:	c9                   	leave  
  802162:	c3                   	ret    

00802163 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802163:	55                   	push   %ebp
  802164:	89 e5                	mov    %esp,%ebp
  802166:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802167:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80216a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80216d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802170:	8b 45 08             	mov    0x8(%ebp),%eax
  802173:	6a 00                	push   $0x0
  802175:	53                   	push   %ebx
  802176:	51                   	push   %ecx
  802177:	52                   	push   %edx
  802178:	50                   	push   %eax
  802179:	6a 2e                	push   $0x2e
  80217b:	e8 c8 f9 ff ff       	call   801b48 <syscall>
  802180:	83 c4 18             	add    $0x18,%esp
}
  802183:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802186:	c9                   	leave  
  802187:	c3                   	ret    

00802188 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802188:	55                   	push   %ebp
  802189:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80218b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80218e:	8b 45 08             	mov    0x8(%ebp),%eax
  802191:	6a 00                	push   $0x0
  802193:	6a 00                	push   $0x0
  802195:	6a 00                	push   $0x0
  802197:	52                   	push   %edx
  802198:	50                   	push   %eax
  802199:	6a 2f                	push   $0x2f
  80219b:	e8 a8 f9 ff ff       	call   801b48 <syscall>
  8021a0:	83 c4 18             	add    $0x18,%esp
}
  8021a3:	c9                   	leave  
  8021a4:	c3                   	ret    
  8021a5:	66 90                	xchg   %ax,%ax
  8021a7:	90                   	nop

008021a8 <__udivdi3>:
  8021a8:	55                   	push   %ebp
  8021a9:	57                   	push   %edi
  8021aa:	56                   	push   %esi
  8021ab:	53                   	push   %ebx
  8021ac:	83 ec 1c             	sub    $0x1c,%esp
  8021af:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021b3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021bb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021bf:	89 ca                	mov    %ecx,%edx
  8021c1:	89 f8                	mov    %edi,%eax
  8021c3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021c7:	85 f6                	test   %esi,%esi
  8021c9:	75 2d                	jne    8021f8 <__udivdi3+0x50>
  8021cb:	39 cf                	cmp    %ecx,%edi
  8021cd:	77 65                	ja     802234 <__udivdi3+0x8c>
  8021cf:	89 fd                	mov    %edi,%ebp
  8021d1:	85 ff                	test   %edi,%edi
  8021d3:	75 0b                	jne    8021e0 <__udivdi3+0x38>
  8021d5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021da:	31 d2                	xor    %edx,%edx
  8021dc:	f7 f7                	div    %edi
  8021de:	89 c5                	mov    %eax,%ebp
  8021e0:	31 d2                	xor    %edx,%edx
  8021e2:	89 c8                	mov    %ecx,%eax
  8021e4:	f7 f5                	div    %ebp
  8021e6:	89 c1                	mov    %eax,%ecx
  8021e8:	89 d8                	mov    %ebx,%eax
  8021ea:	f7 f5                	div    %ebp
  8021ec:	89 cf                	mov    %ecx,%edi
  8021ee:	89 fa                	mov    %edi,%edx
  8021f0:	83 c4 1c             	add    $0x1c,%esp
  8021f3:	5b                   	pop    %ebx
  8021f4:	5e                   	pop    %esi
  8021f5:	5f                   	pop    %edi
  8021f6:	5d                   	pop    %ebp
  8021f7:	c3                   	ret    
  8021f8:	39 ce                	cmp    %ecx,%esi
  8021fa:	77 28                	ja     802224 <__udivdi3+0x7c>
  8021fc:	0f bd fe             	bsr    %esi,%edi
  8021ff:	83 f7 1f             	xor    $0x1f,%edi
  802202:	75 40                	jne    802244 <__udivdi3+0x9c>
  802204:	39 ce                	cmp    %ecx,%esi
  802206:	72 0a                	jb     802212 <__udivdi3+0x6a>
  802208:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80220c:	0f 87 9e 00 00 00    	ja     8022b0 <__udivdi3+0x108>
  802212:	b8 01 00 00 00       	mov    $0x1,%eax
  802217:	89 fa                	mov    %edi,%edx
  802219:	83 c4 1c             	add    $0x1c,%esp
  80221c:	5b                   	pop    %ebx
  80221d:	5e                   	pop    %esi
  80221e:	5f                   	pop    %edi
  80221f:	5d                   	pop    %ebp
  802220:	c3                   	ret    
  802221:	8d 76 00             	lea    0x0(%esi),%esi
  802224:	31 ff                	xor    %edi,%edi
  802226:	31 c0                	xor    %eax,%eax
  802228:	89 fa                	mov    %edi,%edx
  80222a:	83 c4 1c             	add    $0x1c,%esp
  80222d:	5b                   	pop    %ebx
  80222e:	5e                   	pop    %esi
  80222f:	5f                   	pop    %edi
  802230:	5d                   	pop    %ebp
  802231:	c3                   	ret    
  802232:	66 90                	xchg   %ax,%ax
  802234:	89 d8                	mov    %ebx,%eax
  802236:	f7 f7                	div    %edi
  802238:	31 ff                	xor    %edi,%edi
  80223a:	89 fa                	mov    %edi,%edx
  80223c:	83 c4 1c             	add    $0x1c,%esp
  80223f:	5b                   	pop    %ebx
  802240:	5e                   	pop    %esi
  802241:	5f                   	pop    %edi
  802242:	5d                   	pop    %ebp
  802243:	c3                   	ret    
  802244:	bd 20 00 00 00       	mov    $0x20,%ebp
  802249:	89 eb                	mov    %ebp,%ebx
  80224b:	29 fb                	sub    %edi,%ebx
  80224d:	89 f9                	mov    %edi,%ecx
  80224f:	d3 e6                	shl    %cl,%esi
  802251:	89 c5                	mov    %eax,%ebp
  802253:	88 d9                	mov    %bl,%cl
  802255:	d3 ed                	shr    %cl,%ebp
  802257:	89 e9                	mov    %ebp,%ecx
  802259:	09 f1                	or     %esi,%ecx
  80225b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80225f:	89 f9                	mov    %edi,%ecx
  802261:	d3 e0                	shl    %cl,%eax
  802263:	89 c5                	mov    %eax,%ebp
  802265:	89 d6                	mov    %edx,%esi
  802267:	88 d9                	mov    %bl,%cl
  802269:	d3 ee                	shr    %cl,%esi
  80226b:	89 f9                	mov    %edi,%ecx
  80226d:	d3 e2                	shl    %cl,%edx
  80226f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802273:	88 d9                	mov    %bl,%cl
  802275:	d3 e8                	shr    %cl,%eax
  802277:	09 c2                	or     %eax,%edx
  802279:	89 d0                	mov    %edx,%eax
  80227b:	89 f2                	mov    %esi,%edx
  80227d:	f7 74 24 0c          	divl   0xc(%esp)
  802281:	89 d6                	mov    %edx,%esi
  802283:	89 c3                	mov    %eax,%ebx
  802285:	f7 e5                	mul    %ebp
  802287:	39 d6                	cmp    %edx,%esi
  802289:	72 19                	jb     8022a4 <__udivdi3+0xfc>
  80228b:	74 0b                	je     802298 <__udivdi3+0xf0>
  80228d:	89 d8                	mov    %ebx,%eax
  80228f:	31 ff                	xor    %edi,%edi
  802291:	e9 58 ff ff ff       	jmp    8021ee <__udivdi3+0x46>
  802296:	66 90                	xchg   %ax,%ax
  802298:	8b 54 24 08          	mov    0x8(%esp),%edx
  80229c:	89 f9                	mov    %edi,%ecx
  80229e:	d3 e2                	shl    %cl,%edx
  8022a0:	39 c2                	cmp    %eax,%edx
  8022a2:	73 e9                	jae    80228d <__udivdi3+0xe5>
  8022a4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022a7:	31 ff                	xor    %edi,%edi
  8022a9:	e9 40 ff ff ff       	jmp    8021ee <__udivdi3+0x46>
  8022ae:	66 90                	xchg   %ax,%ax
  8022b0:	31 c0                	xor    %eax,%eax
  8022b2:	e9 37 ff ff ff       	jmp    8021ee <__udivdi3+0x46>
  8022b7:	90                   	nop

008022b8 <__umoddi3>:
  8022b8:	55                   	push   %ebp
  8022b9:	57                   	push   %edi
  8022ba:	56                   	push   %esi
  8022bb:	53                   	push   %ebx
  8022bc:	83 ec 1c             	sub    $0x1c,%esp
  8022bf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022c3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022cb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022cf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022d3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022d7:	89 f3                	mov    %esi,%ebx
  8022d9:	89 fa                	mov    %edi,%edx
  8022db:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022df:	89 34 24             	mov    %esi,(%esp)
  8022e2:	85 c0                	test   %eax,%eax
  8022e4:	75 1a                	jne    802300 <__umoddi3+0x48>
  8022e6:	39 f7                	cmp    %esi,%edi
  8022e8:	0f 86 a2 00 00 00    	jbe    802390 <__umoddi3+0xd8>
  8022ee:	89 c8                	mov    %ecx,%eax
  8022f0:	89 f2                	mov    %esi,%edx
  8022f2:	f7 f7                	div    %edi
  8022f4:	89 d0                	mov    %edx,%eax
  8022f6:	31 d2                	xor    %edx,%edx
  8022f8:	83 c4 1c             	add    $0x1c,%esp
  8022fb:	5b                   	pop    %ebx
  8022fc:	5e                   	pop    %esi
  8022fd:	5f                   	pop    %edi
  8022fe:	5d                   	pop    %ebp
  8022ff:	c3                   	ret    
  802300:	39 f0                	cmp    %esi,%eax
  802302:	0f 87 ac 00 00 00    	ja     8023b4 <__umoddi3+0xfc>
  802308:	0f bd e8             	bsr    %eax,%ebp
  80230b:	83 f5 1f             	xor    $0x1f,%ebp
  80230e:	0f 84 ac 00 00 00    	je     8023c0 <__umoddi3+0x108>
  802314:	bf 20 00 00 00       	mov    $0x20,%edi
  802319:	29 ef                	sub    %ebp,%edi
  80231b:	89 fe                	mov    %edi,%esi
  80231d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802321:	89 e9                	mov    %ebp,%ecx
  802323:	d3 e0                	shl    %cl,%eax
  802325:	89 d7                	mov    %edx,%edi
  802327:	89 f1                	mov    %esi,%ecx
  802329:	d3 ef                	shr    %cl,%edi
  80232b:	09 c7                	or     %eax,%edi
  80232d:	89 e9                	mov    %ebp,%ecx
  80232f:	d3 e2                	shl    %cl,%edx
  802331:	89 14 24             	mov    %edx,(%esp)
  802334:	89 d8                	mov    %ebx,%eax
  802336:	d3 e0                	shl    %cl,%eax
  802338:	89 c2                	mov    %eax,%edx
  80233a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80233e:	d3 e0                	shl    %cl,%eax
  802340:	89 44 24 04          	mov    %eax,0x4(%esp)
  802344:	8b 44 24 08          	mov    0x8(%esp),%eax
  802348:	89 f1                	mov    %esi,%ecx
  80234a:	d3 e8                	shr    %cl,%eax
  80234c:	09 d0                	or     %edx,%eax
  80234e:	d3 eb                	shr    %cl,%ebx
  802350:	89 da                	mov    %ebx,%edx
  802352:	f7 f7                	div    %edi
  802354:	89 d3                	mov    %edx,%ebx
  802356:	f7 24 24             	mull   (%esp)
  802359:	89 c6                	mov    %eax,%esi
  80235b:	89 d1                	mov    %edx,%ecx
  80235d:	39 d3                	cmp    %edx,%ebx
  80235f:	0f 82 87 00 00 00    	jb     8023ec <__umoddi3+0x134>
  802365:	0f 84 91 00 00 00    	je     8023fc <__umoddi3+0x144>
  80236b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80236f:	29 f2                	sub    %esi,%edx
  802371:	19 cb                	sbb    %ecx,%ebx
  802373:	89 d8                	mov    %ebx,%eax
  802375:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802379:	d3 e0                	shl    %cl,%eax
  80237b:	89 e9                	mov    %ebp,%ecx
  80237d:	d3 ea                	shr    %cl,%edx
  80237f:	09 d0                	or     %edx,%eax
  802381:	89 e9                	mov    %ebp,%ecx
  802383:	d3 eb                	shr    %cl,%ebx
  802385:	89 da                	mov    %ebx,%edx
  802387:	83 c4 1c             	add    $0x1c,%esp
  80238a:	5b                   	pop    %ebx
  80238b:	5e                   	pop    %esi
  80238c:	5f                   	pop    %edi
  80238d:	5d                   	pop    %ebp
  80238e:	c3                   	ret    
  80238f:	90                   	nop
  802390:	89 fd                	mov    %edi,%ebp
  802392:	85 ff                	test   %edi,%edi
  802394:	75 0b                	jne    8023a1 <__umoddi3+0xe9>
  802396:	b8 01 00 00 00       	mov    $0x1,%eax
  80239b:	31 d2                	xor    %edx,%edx
  80239d:	f7 f7                	div    %edi
  80239f:	89 c5                	mov    %eax,%ebp
  8023a1:	89 f0                	mov    %esi,%eax
  8023a3:	31 d2                	xor    %edx,%edx
  8023a5:	f7 f5                	div    %ebp
  8023a7:	89 c8                	mov    %ecx,%eax
  8023a9:	f7 f5                	div    %ebp
  8023ab:	89 d0                	mov    %edx,%eax
  8023ad:	e9 44 ff ff ff       	jmp    8022f6 <__umoddi3+0x3e>
  8023b2:	66 90                	xchg   %ax,%ax
  8023b4:	89 c8                	mov    %ecx,%eax
  8023b6:	89 f2                	mov    %esi,%edx
  8023b8:	83 c4 1c             	add    $0x1c,%esp
  8023bb:	5b                   	pop    %ebx
  8023bc:	5e                   	pop    %esi
  8023bd:	5f                   	pop    %edi
  8023be:	5d                   	pop    %ebp
  8023bf:	c3                   	ret    
  8023c0:	3b 04 24             	cmp    (%esp),%eax
  8023c3:	72 06                	jb     8023cb <__umoddi3+0x113>
  8023c5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023c9:	77 0f                	ja     8023da <__umoddi3+0x122>
  8023cb:	89 f2                	mov    %esi,%edx
  8023cd:	29 f9                	sub    %edi,%ecx
  8023cf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023d3:	89 14 24             	mov    %edx,(%esp)
  8023d6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023da:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023de:	8b 14 24             	mov    (%esp),%edx
  8023e1:	83 c4 1c             	add    $0x1c,%esp
  8023e4:	5b                   	pop    %ebx
  8023e5:	5e                   	pop    %esi
  8023e6:	5f                   	pop    %edi
  8023e7:	5d                   	pop    %ebp
  8023e8:	c3                   	ret    
  8023e9:	8d 76 00             	lea    0x0(%esi),%esi
  8023ec:	2b 04 24             	sub    (%esp),%eax
  8023ef:	19 fa                	sbb    %edi,%edx
  8023f1:	89 d1                	mov    %edx,%ecx
  8023f3:	89 c6                	mov    %eax,%esi
  8023f5:	e9 71 ff ff ff       	jmp    80236b <__umoddi3+0xb3>
  8023fa:	66 90                	xchg   %ax,%ax
  8023fc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802400:	72 ea                	jb     8023ec <__umoddi3+0x134>
  802402:	89 d9                	mov    %ebx,%ecx
  802404:	e9 62 ff ff ff       	jmp    80236b <__umoddi3+0xb3>
