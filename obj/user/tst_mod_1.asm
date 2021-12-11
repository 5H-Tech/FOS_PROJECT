
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
  80003f:	e8 4a 18 00 00       	call   80188e <sys_getenvid>
  800044:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cprintf("envID = %d\n",envID);
  800047:	83 ec 08             	sub    $0x8,%esp
  80004a:	ff 75 f4             	pushl  -0xc(%ebp)
  80004d:	68 e0 20 80 00       	push   $0x8020e0
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
  80009c:	e8 54 19 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
  8000a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int freeFrames = sys_calculate_free_frames() ;
  8000a4:	e8 c9 18 00 00       	call   801972 <sys_calculate_free_frames>
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
  8000ca:	68 ec 20 80 00       	push   $0x8020ec
  8000cf:	68 0a 21 80 00       	push   $0x80210a
  8000d4:	6a 1a                	push   $0x1a
  8000d6:	68 1f 21 80 00       	push   $0x80211f
  8000db:	e8 0a 06 00 00       	call   8006ea <_panic>
		//		cprintf("Allocated frames = %d\n", (freeFrames - sys_calculate_free_frames())) ;
		assert((freeFrames - sys_calculate_free_frames()) == (/*1 +*/ 1 + 2 * Mega / PAGE_SIZE));
  8000e0:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8000e3:	e8 8a 18 00 00       	call   801972 <sys_calculate_free_frames>
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
  800102:	68 30 21 80 00       	push   $0x802130
  800107:	68 0a 21 80 00       	push   $0x80210a
  80010c:	6a 1c                	push   $0x1c
  80010e:	68 1f 21 80 00       	push   $0x80211f
  800113:	e8 d2 05 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  800118:	e8 d8 18 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
  80011d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800120:	74 16                	je     800138 <_main+0x100>
  800122:	68 7c 21 80 00       	push   $0x80217c
  800127:	68 0a 21 80 00       	push   $0x80210a
  80012c:	6a 1d                	push   $0x1d
  80012e:	68 1f 21 80 00       	push   $0x80211f
  800133:	e8 b2 05 00 00       	call   8006ea <_panic>
		//assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 2 * Mega / PAGE_SIZE);

		freeFrames = sys_calculate_free_frames() ;
  800138:	e8 35 18 00 00       	call   801972 <sys_calculate_free_frames>
  80013d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800140:	e8 b0 18 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
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
  800169:	68 b8 21 80 00       	push   $0x8021b8
  80016e:	68 0a 21 80 00       	push   $0x80210a
  800173:	6a 22                	push   $0x22
  800175:	68 1f 21 80 00       	push   $0x80211f
  80017a:	e8 6b 05 00 00       	call   8006ea <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (2 * Mega / PAGE_SIZE));
  80017f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800182:	e8 eb 17 00 00       	call   801972 <sys_calculate_free_frames>
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
  8001a0:	68 ec 21 80 00       	push   $0x8021ec
  8001a5:	68 0a 21 80 00       	push   $0x80210a
  8001aa:	6a 23                	push   $0x23
  8001ac:	68 1f 21 80 00       	push   $0x80211f
  8001b1:	e8 34 05 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  8001b6:	e8 3a 18 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
  8001bb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8001be:	74 16                	je     8001d6 <_main+0x19e>
  8001c0:	68 7c 21 80 00       	push   $0x80217c
  8001c5:	68 0a 21 80 00       	push   $0x80210a
  8001ca:	6a 24                	push   $0x24
  8001cc:	68 1f 21 80 00       	push   $0x80211f
  8001d1:	e8 14 05 00 00       	call   8006ea <_panic>
		//assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 2 * Mega / PAGE_SIZE);

		freeFrames = sys_calculate_free_frames() ;
  8001d6:	e8 97 17 00 00       	call   801972 <sys_calculate_free_frames>
  8001db:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001de:	e8 12 18 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
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
  80020c:	68 34 22 80 00       	push   $0x802234
  800211:	68 0a 21 80 00       	push   $0x80210a
  800216:	6a 29                	push   $0x29
  800218:	68 1f 21 80 00       	push   $0x80211f
  80021d:	e8 c8 04 00 00       	call   8006ea <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (/*1 +*/1 + 3 * Mega / PAGE_SIZE));
  800222:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800225:	e8 48 17 00 00       	call   801972 <sys_calculate_free_frames>
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
  800248:	68 68 22 80 00       	push   $0x802268
  80024d:	68 0a 21 80 00       	push   $0x80210a
  800252:	6a 2a                	push   $0x2a
  800254:	68 1f 21 80 00       	push   $0x80211f
  800259:	e8 8c 04 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  80025e:	e8 92 17 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
  800263:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800266:	74 16                	je     80027e <_main+0x246>
  800268:	68 7c 21 80 00       	push   $0x80217c
  80026d:	68 0a 21 80 00       	push   $0x80210a
  800272:	6a 2b                	push   $0x2b
  800274:	68 1f 21 80 00       	push   $0x80211f
  800279:	e8 6c 04 00 00       	call   8006ea <_panic>
		//assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 3 * Mega / PAGE_SIZE);

		freeFrames = sys_calculate_free_frames() ;
  80027e:	e8 ef 16 00 00       	call   801972 <sys_calculate_free_frames>
  800283:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800286:	e8 6a 17 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
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
  8002b7:	68 b4 22 80 00       	push   $0x8022b4
  8002bc:	68 0a 21 80 00       	push   $0x80210a
  8002c1:	6a 30                	push   $0x30
  8002c3:	68 1f 21 80 00       	push   $0x80211f
  8002c8:	e8 1d 04 00 00       	call   8006ea <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (1));
  8002cd:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8002d0:	e8 9d 16 00 00       	call   801972 <sys_calculate_free_frames>
  8002d5:	29 c3                	sub    %eax,%ebx
  8002d7:	89 d8                	mov    %ebx,%eax
  8002d9:	83 f8 01             	cmp    $0x1,%eax
  8002dc:	74 16                	je     8002f4 <_main+0x2bc>
  8002de:	68 e8 22 80 00       	push   $0x8022e8
  8002e3:	68 0a 21 80 00       	push   $0x80210a
  8002e8:	6a 31                	push   $0x31
  8002ea:	68 1f 21 80 00       	push   $0x80211f
  8002ef:	e8 f6 03 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  8002f4:	e8 fc 16 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
  8002f9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8002fc:	74 16                	je     800314 <_main+0x2dc>
  8002fe:	68 7c 21 80 00       	push   $0x80217c
  800303:	68 0a 21 80 00       	push   $0x80210a
  800308:	6a 32                	push   $0x32
  80030a:	68 1f 21 80 00       	push   $0x80211f
  80030f:	e8 d6 03 00 00       	call   8006ea <_panic>
		//assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 1);

		freeFrames = sys_calculate_free_frames() ;
  800314:	e8 59 16 00 00       	call   801972 <sys_calculate_free_frames>
  800319:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80031c:	e8 d4 16 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
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
  800357:	68 1c 23 80 00       	push   $0x80231c
  80035c:	68 0a 21 80 00       	push   $0x80210a
  800361:	6a 37                	push   $0x37
  800363:	68 1f 21 80 00       	push   $0x80211f
  800368:	e8 7d 03 00 00       	call   8006ea <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (1));
  80036d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800370:	e8 fd 15 00 00       	call   801972 <sys_calculate_free_frames>
  800375:	29 c3                	sub    %eax,%ebx
  800377:	89 d8                	mov    %ebx,%eax
  800379:	83 f8 01             	cmp    $0x1,%eax
  80037c:	74 16                	je     800394 <_main+0x35c>
  80037e:	68 e8 22 80 00       	push   $0x8022e8
  800383:	68 0a 21 80 00       	push   $0x80210a
  800388:	6a 38                	push   $0x38
  80038a:	68 1f 21 80 00       	push   $0x80211f
  80038f:	e8 56 03 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  800394:	e8 5c 16 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
  800399:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80039c:	74 16                	je     8003b4 <_main+0x37c>
  80039e:	68 7c 21 80 00       	push   $0x80217c
  8003a3:	68 0a 21 80 00       	push   $0x80210a
  8003a8:	6a 39                	push   $0x39
  8003aa:	68 1f 21 80 00       	push   $0x80211f
  8003af:	e8 36 03 00 00       	call   8006ea <_panic>
		//assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 1);

		freeFrames = sys_calculate_free_frames() ;
  8003b4:	e8 b9 15 00 00       	call   801972 <sys_calculate_free_frames>
  8003b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003bc:	e8 34 16 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
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
  8003ff:	68 58 23 80 00       	push   $0x802358
  800404:	68 0a 21 80 00       	push   $0x80210a
  800409:	6a 3e                	push   $0x3e
  80040b:	68 1f 21 80 00       	push   $0x80211f
  800410:	e8 d5 02 00 00       	call   8006ea <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (2));
  800415:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800418:	e8 55 15 00 00       	call   801972 <sys_calculate_free_frames>
  80041d:	29 c3                	sub    %eax,%ebx
  80041f:	89 d8                	mov    %ebx,%eax
  800421:	83 f8 02             	cmp    $0x2,%eax
  800424:	74 16                	je     80043c <_main+0x404>
  800426:	68 94 23 80 00       	push   $0x802394
  80042b:	68 0a 21 80 00       	push   $0x80210a
  800430:	6a 3f                	push   $0x3f
  800432:	68 1f 21 80 00       	push   $0x80211f
  800437:	e8 ae 02 00 00       	call   8006ea <_panic>
		assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  80043c:	e8 b4 15 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
  800441:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800444:	74 16                	je     80045c <_main+0x424>
  800446:	68 7c 21 80 00       	push   $0x80217c
  80044b:	68 0a 21 80 00       	push   $0x80210a
  800450:	6a 40                	push   $0x40
  800452:	68 1f 21 80 00       	push   $0x80211f
  800457:	e8 8e 02 00 00       	call   8006ea <_panic>
	}

	///====================


	int freeFrames = sys_calculate_free_frames() ;
  80045c:	e8 11 15 00 00       	call   801972 <sys_calculate_free_frames>
  800461:	89 45 d8             	mov    %eax,-0x28(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800464:	e8 8c 15 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
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
  80054b:	e8 22 14 00 00       	call   801972 <sys_calculate_free_frames>
  800550:	89 c2                	mov    %eax,%edx
  800552:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800555:	39 c2                	cmp    %eax,%edx
  800557:	74 16                	je     80056f <_main+0x537>
  800559:	68 c8 23 80 00       	push   $0x8023c8
  80055e:	68 0a 21 80 00       	push   $0x80210a
  800563:	6a 56                	push   $0x56
  800565:	68 1f 21 80 00       	push   $0x80211f
  80056a:	e8 7b 01 00 00       	call   8006ea <_panic>
	assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 0);
  80056f:	e8 81 14 00 00       	call   8019f5 <sys_pf_calculate_allocated_pages>
  800574:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
  800577:	74 16                	je     80058f <_main+0x557>
  800579:	68 7c 21 80 00       	push   $0x80217c
  80057e:	68 0a 21 80 00       	push   $0x80210a
  800583:	6a 57                	push   $0x57
  800585:	68 1f 21 80 00       	push   $0x80211f
  80058a:	e8 5b 01 00 00       	call   8006ea <_panic>

	cprintf("Congratulations!! your modification is completed successfully.\n");
  80058f:	83 ec 0c             	sub    $0xc,%esp
  800592:	68 f8 23 80 00       	push   $0x8023f8
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
  8005ab:	e8 f7 12 00 00       	call   8018a7 <sys_getenvindex>
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
  800628:	e8 15 14 00 00       	call   801a42 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80062d:	83 ec 0c             	sub    $0xc,%esp
  800630:	68 50 24 80 00       	push   $0x802450
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
  800658:	68 78 24 80 00       	push   $0x802478
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
  800680:	68 a0 24 80 00       	push   $0x8024a0
  800685:	e8 02 03 00 00       	call   80098c <cprintf>
  80068a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80068d:	a1 20 30 80 00       	mov    0x803020,%eax
  800692:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800698:	83 ec 08             	sub    $0x8,%esp
  80069b:	50                   	push   %eax
  80069c:	68 e1 24 80 00       	push   $0x8024e1
  8006a1:	e8 e6 02 00 00       	call   80098c <cprintf>
  8006a6:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006a9:	83 ec 0c             	sub    $0xc,%esp
  8006ac:	68 50 24 80 00       	push   $0x802450
  8006b1:	e8 d6 02 00 00       	call   80098c <cprintf>
  8006b6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006b9:	e8 9e 13 00 00       	call   801a5c <sys_enable_interrupt>

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
  8006d1:	e8 9d 11 00 00       	call   801873 <sys_env_destroy>
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
  8006e2:	e8 f2 11 00 00       	call   8018d9 <sys_env_exit>
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
  80070b:	68 f8 24 80 00       	push   $0x8024f8
  800710:	e8 77 02 00 00       	call   80098c <cprintf>
  800715:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800718:	a1 00 30 80 00       	mov    0x803000,%eax
  80071d:	ff 75 0c             	pushl  0xc(%ebp)
  800720:	ff 75 08             	pushl  0x8(%ebp)
  800723:	50                   	push   %eax
  800724:	68 fd 24 80 00       	push   $0x8024fd
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
  800748:	68 19 25 80 00       	push   $0x802519
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
  800774:	68 1c 25 80 00       	push   $0x80251c
  800779:	6a 26                	push   $0x26
  80077b:	68 68 25 80 00       	push   $0x802568
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
  80083a:	68 74 25 80 00       	push   $0x802574
  80083f:	6a 3a                	push   $0x3a
  800841:	68 68 25 80 00       	push   $0x802568
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
  8008a4:	68 c8 25 80 00       	push   $0x8025c8
  8008a9:	6a 44                	push   $0x44
  8008ab:	68 68 25 80 00       	push   $0x802568
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
  8008fe:	e8 2e 0f 00 00       	call   801831 <sys_cputs>
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
  800975:	e8 b7 0e 00 00       	call   801831 <sys_cputs>
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
  8009bf:	e8 7e 10 00 00       	call   801a42 <sys_disable_interrupt>
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
  8009df:	e8 78 10 00 00       	call   801a5c <sys_enable_interrupt>
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
  800a29:	e8 36 14 00 00       	call   801e64 <__udivdi3>
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
  800a79:	e8 f6 14 00 00       	call   801f74 <__umoddi3>
  800a7e:	83 c4 10             	add    $0x10,%esp
  800a81:	05 34 28 80 00       	add    $0x802834,%eax
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
  800bd4:	8b 04 85 58 28 80 00 	mov    0x802858(,%eax,4),%eax
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
  800cb5:	8b 34 9d a0 26 80 00 	mov    0x8026a0(,%ebx,4),%esi
  800cbc:	85 f6                	test   %esi,%esi
  800cbe:	75 19                	jne    800cd9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cc0:	53                   	push   %ebx
  800cc1:	68 45 28 80 00       	push   $0x802845
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
  800cda:	68 4e 28 80 00       	push   $0x80284e
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
  800d07:	be 51 28 80 00       	mov    $0x802851,%esi
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

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801716:	55                   	push   %ebp
  801717:	89 e5                	mov    %esp,%ebp
  801719:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  80171c:	83 ec 04             	sub    $0x4,%esp
  80171f:	68 b0 29 80 00       	push   $0x8029b0
  801724:	6a 16                	push   $0x16
  801726:	68 d5 29 80 00       	push   $0x8029d5
  80172b:	e8 ba ef ff ff       	call   8006ea <_panic>

00801730 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
  801733:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801736:	83 ec 04             	sub    $0x4,%esp
  801739:	68 e4 29 80 00       	push   $0x8029e4
  80173e:	6a 2e                	push   $0x2e
  801740:	68 d5 29 80 00       	push   $0x8029d5
  801745:	e8 a0 ef ff ff       	call   8006ea <_panic>

0080174a <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80174a:	55                   	push   %ebp
  80174b:	89 e5                	mov    %esp,%ebp
  80174d:	83 ec 18             	sub    $0x18,%esp
  801750:	8b 45 10             	mov    0x10(%ebp),%eax
  801753:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801756:	83 ec 04             	sub    $0x4,%esp
  801759:	68 08 2a 80 00       	push   $0x802a08
  80175e:	6a 3b                	push   $0x3b
  801760:	68 d5 29 80 00       	push   $0x8029d5
  801765:	e8 80 ef ff ff       	call   8006ea <_panic>

0080176a <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801770:	83 ec 04             	sub    $0x4,%esp
  801773:	68 08 2a 80 00       	push   $0x802a08
  801778:	6a 41                	push   $0x41
  80177a:	68 d5 29 80 00       	push   $0x8029d5
  80177f:	e8 66 ef ff ff       	call   8006ea <_panic>

00801784 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801784:	55                   	push   %ebp
  801785:	89 e5                	mov    %esp,%ebp
  801787:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80178a:	83 ec 04             	sub    $0x4,%esp
  80178d:	68 08 2a 80 00       	push   $0x802a08
  801792:	6a 47                	push   $0x47
  801794:	68 d5 29 80 00       	push   $0x8029d5
  801799:	e8 4c ef ff ff       	call   8006ea <_panic>

0080179e <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80179e:	55                   	push   %ebp
  80179f:	89 e5                	mov    %esp,%ebp
  8017a1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017a4:	83 ec 04             	sub    $0x4,%esp
  8017a7:	68 08 2a 80 00       	push   $0x802a08
  8017ac:	6a 4c                	push   $0x4c
  8017ae:	68 d5 29 80 00       	push   $0x8029d5
  8017b3:	e8 32 ef ff ff       	call   8006ea <_panic>

008017b8 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
  8017bb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017be:	83 ec 04             	sub    $0x4,%esp
  8017c1:	68 08 2a 80 00       	push   $0x802a08
  8017c6:	6a 52                	push   $0x52
  8017c8:	68 d5 29 80 00       	push   $0x8029d5
  8017cd:	e8 18 ef ff ff       	call   8006ea <_panic>

008017d2 <shrink>:
}
void shrink(uint32 newSize)
{
  8017d2:	55                   	push   %ebp
  8017d3:	89 e5                	mov    %esp,%ebp
  8017d5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017d8:	83 ec 04             	sub    $0x4,%esp
  8017db:	68 08 2a 80 00       	push   $0x802a08
  8017e0:	6a 56                	push   $0x56
  8017e2:	68 d5 29 80 00       	push   $0x8029d5
  8017e7:	e8 fe ee ff ff       	call   8006ea <_panic>

008017ec <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8017ec:	55                   	push   %ebp
  8017ed:	89 e5                	mov    %esp,%ebp
  8017ef:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017f2:	83 ec 04             	sub    $0x4,%esp
  8017f5:	68 08 2a 80 00       	push   $0x802a08
  8017fa:	6a 5b                	push   $0x5b
  8017fc:	68 d5 29 80 00       	push   $0x8029d5
  801801:	e8 e4 ee ff ff       	call   8006ea <_panic>

00801806 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801806:	55                   	push   %ebp
  801807:	89 e5                	mov    %esp,%ebp
  801809:	57                   	push   %edi
  80180a:	56                   	push   %esi
  80180b:	53                   	push   %ebx
  80180c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80180f:	8b 45 08             	mov    0x8(%ebp),%eax
  801812:	8b 55 0c             	mov    0xc(%ebp),%edx
  801815:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801818:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80181b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80181e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801821:	cd 30                	int    $0x30
  801823:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801826:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801829:	83 c4 10             	add    $0x10,%esp
  80182c:	5b                   	pop    %ebx
  80182d:	5e                   	pop    %esi
  80182e:	5f                   	pop    %edi
  80182f:	5d                   	pop    %ebp
  801830:	c3                   	ret    

00801831 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801831:	55                   	push   %ebp
  801832:	89 e5                	mov    %esp,%ebp
  801834:	83 ec 04             	sub    $0x4,%esp
  801837:	8b 45 10             	mov    0x10(%ebp),%eax
  80183a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80183d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801841:	8b 45 08             	mov    0x8(%ebp),%eax
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	52                   	push   %edx
  801849:	ff 75 0c             	pushl  0xc(%ebp)
  80184c:	50                   	push   %eax
  80184d:	6a 00                	push   $0x0
  80184f:	e8 b2 ff ff ff       	call   801806 <syscall>
  801854:	83 c4 18             	add    $0x18,%esp
}
  801857:	90                   	nop
  801858:	c9                   	leave  
  801859:	c3                   	ret    

0080185a <sys_cgetc>:

int
sys_cgetc(void)
{
  80185a:	55                   	push   %ebp
  80185b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 01                	push   $0x1
  801869:	e8 98 ff ff ff       	call   801806 <syscall>
  80186e:	83 c4 18             	add    $0x18,%esp
}
  801871:	c9                   	leave  
  801872:	c3                   	ret    

00801873 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801876:	8b 45 08             	mov    0x8(%ebp),%eax
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	50                   	push   %eax
  801882:	6a 05                	push   $0x5
  801884:	e8 7d ff ff ff       	call   801806 <syscall>
  801889:	83 c4 18             	add    $0x18,%esp
}
  80188c:	c9                   	leave  
  80188d:	c3                   	ret    

0080188e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80188e:	55                   	push   %ebp
  80188f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 02                	push   $0x2
  80189d:	e8 64 ff ff ff       	call   801806 <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 03                	push   $0x3
  8018b6:	e8 4b ff ff ff       	call   801806 <syscall>
  8018bb:	83 c4 18             	add    $0x18,%esp
}
  8018be:	c9                   	leave  
  8018bf:	c3                   	ret    

008018c0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018c0:	55                   	push   %ebp
  8018c1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 04                	push   $0x4
  8018cf:	e8 32 ff ff ff       	call   801806 <syscall>
  8018d4:	83 c4 18             	add    $0x18,%esp
}
  8018d7:	c9                   	leave  
  8018d8:	c3                   	ret    

008018d9 <sys_env_exit>:


void sys_env_exit(void)
{
  8018d9:	55                   	push   %ebp
  8018da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 06                	push   $0x6
  8018e8:	e8 19 ff ff ff       	call   801806 <syscall>
  8018ed:	83 c4 18             	add    $0x18,%esp
}
  8018f0:	90                   	nop
  8018f1:	c9                   	leave  
  8018f2:	c3                   	ret    

008018f3 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8018f3:	55                   	push   %ebp
  8018f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8018f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	52                   	push   %edx
  801903:	50                   	push   %eax
  801904:	6a 07                	push   $0x7
  801906:	e8 fb fe ff ff       	call   801806 <syscall>
  80190b:	83 c4 18             	add    $0x18,%esp
}
  80190e:	c9                   	leave  
  80190f:	c3                   	ret    

00801910 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801910:	55                   	push   %ebp
  801911:	89 e5                	mov    %esp,%ebp
  801913:	56                   	push   %esi
  801914:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801915:	8b 75 18             	mov    0x18(%ebp),%esi
  801918:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80191b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80191e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801921:	8b 45 08             	mov    0x8(%ebp),%eax
  801924:	56                   	push   %esi
  801925:	53                   	push   %ebx
  801926:	51                   	push   %ecx
  801927:	52                   	push   %edx
  801928:	50                   	push   %eax
  801929:	6a 08                	push   $0x8
  80192b:	e8 d6 fe ff ff       	call   801806 <syscall>
  801930:	83 c4 18             	add    $0x18,%esp
}
  801933:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801936:	5b                   	pop    %ebx
  801937:	5e                   	pop    %esi
  801938:	5d                   	pop    %ebp
  801939:	c3                   	ret    

0080193a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80193a:	55                   	push   %ebp
  80193b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80193d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801940:	8b 45 08             	mov    0x8(%ebp),%eax
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	52                   	push   %edx
  80194a:	50                   	push   %eax
  80194b:	6a 09                	push   $0x9
  80194d:	e8 b4 fe ff ff       	call   801806 <syscall>
  801952:	83 c4 18             	add    $0x18,%esp
}
  801955:	c9                   	leave  
  801956:	c3                   	ret    

00801957 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801957:	55                   	push   %ebp
  801958:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	ff 75 0c             	pushl  0xc(%ebp)
  801963:	ff 75 08             	pushl  0x8(%ebp)
  801966:	6a 0a                	push   $0xa
  801968:	e8 99 fe ff ff       	call   801806 <syscall>
  80196d:	83 c4 18             	add    $0x18,%esp
}
  801970:	c9                   	leave  
  801971:	c3                   	ret    

00801972 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801972:	55                   	push   %ebp
  801973:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 0b                	push   $0xb
  801981:	e8 80 fe ff ff       	call   801806 <syscall>
  801986:	83 c4 18             	add    $0x18,%esp
}
  801989:	c9                   	leave  
  80198a:	c3                   	ret    

0080198b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80198b:	55                   	push   %ebp
  80198c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 0c                	push   $0xc
  80199a:	e8 67 fe ff ff       	call   801806 <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
}
  8019a2:	c9                   	leave  
  8019a3:	c3                   	ret    

008019a4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8019a4:	55                   	push   %ebp
  8019a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 0d                	push   $0xd
  8019b3:	e8 4e fe ff ff       	call   801806 <syscall>
  8019b8:	83 c4 18             	add    $0x18,%esp
}
  8019bb:	c9                   	leave  
  8019bc:	c3                   	ret    

008019bd <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019bd:	55                   	push   %ebp
  8019be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	ff 75 0c             	pushl  0xc(%ebp)
  8019c9:	ff 75 08             	pushl  0x8(%ebp)
  8019cc:	6a 11                	push   $0x11
  8019ce:	e8 33 fe ff ff       	call   801806 <syscall>
  8019d3:	83 c4 18             	add    $0x18,%esp
	return;
  8019d6:	90                   	nop
}
  8019d7:	c9                   	leave  
  8019d8:	c3                   	ret    

008019d9 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8019d9:	55                   	push   %ebp
  8019da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	ff 75 0c             	pushl  0xc(%ebp)
  8019e5:	ff 75 08             	pushl  0x8(%ebp)
  8019e8:	6a 12                	push   $0x12
  8019ea:	e8 17 fe ff ff       	call   801806 <syscall>
  8019ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f2:	90                   	nop
}
  8019f3:	c9                   	leave  
  8019f4:	c3                   	ret    

008019f5 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8019f5:	55                   	push   %ebp
  8019f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 0e                	push   $0xe
  801a04:	e8 fd fd ff ff       	call   801806 <syscall>
  801a09:	83 c4 18             	add    $0x18,%esp
}
  801a0c:	c9                   	leave  
  801a0d:	c3                   	ret    

00801a0e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a0e:	55                   	push   %ebp
  801a0f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	ff 75 08             	pushl  0x8(%ebp)
  801a1c:	6a 0f                	push   $0xf
  801a1e:	e8 e3 fd ff ff       	call   801806 <syscall>
  801a23:	83 c4 18             	add    $0x18,%esp
}
  801a26:	c9                   	leave  
  801a27:	c3                   	ret    

00801a28 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a28:	55                   	push   %ebp
  801a29:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 00                	push   $0x0
  801a35:	6a 10                	push   $0x10
  801a37:	e8 ca fd ff ff       	call   801806 <syscall>
  801a3c:	83 c4 18             	add    $0x18,%esp
}
  801a3f:	90                   	nop
  801a40:	c9                   	leave  
  801a41:	c3                   	ret    

00801a42 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 14                	push   $0x14
  801a51:	e8 b0 fd ff ff       	call   801806 <syscall>
  801a56:	83 c4 18             	add    $0x18,%esp
}
  801a59:	90                   	nop
  801a5a:	c9                   	leave  
  801a5b:	c3                   	ret    

00801a5c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a5c:	55                   	push   %ebp
  801a5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 15                	push   $0x15
  801a6b:	e8 96 fd ff ff       	call   801806 <syscall>
  801a70:	83 c4 18             	add    $0x18,%esp
}
  801a73:	90                   	nop
  801a74:	c9                   	leave  
  801a75:	c3                   	ret    

00801a76 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a76:	55                   	push   %ebp
  801a77:	89 e5                	mov    %esp,%ebp
  801a79:	83 ec 04             	sub    $0x4,%esp
  801a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a82:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	50                   	push   %eax
  801a8f:	6a 16                	push   $0x16
  801a91:	e8 70 fd ff ff       	call   801806 <syscall>
  801a96:	83 c4 18             	add    $0x18,%esp
}
  801a99:	90                   	nop
  801a9a:	c9                   	leave  
  801a9b:	c3                   	ret    

00801a9c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 17                	push   $0x17
  801aab:	e8 56 fd ff ff       	call   801806 <syscall>
  801ab0:	83 c4 18             	add    $0x18,%esp
}
  801ab3:	90                   	nop
  801ab4:	c9                   	leave  
  801ab5:	c3                   	ret    

00801ab6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ab6:	55                   	push   %ebp
  801ab7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	ff 75 0c             	pushl  0xc(%ebp)
  801ac5:	50                   	push   %eax
  801ac6:	6a 18                	push   $0x18
  801ac8:	e8 39 fd ff ff       	call   801806 <syscall>
  801acd:	83 c4 18             	add    $0x18,%esp
}
  801ad0:	c9                   	leave  
  801ad1:	c3                   	ret    

00801ad2 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ad2:	55                   	push   %ebp
  801ad3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ad5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	52                   	push   %edx
  801ae2:	50                   	push   %eax
  801ae3:	6a 1b                	push   $0x1b
  801ae5:	e8 1c fd ff ff       	call   801806 <syscall>
  801aea:	83 c4 18             	add    $0x18,%esp
}
  801aed:	c9                   	leave  
  801aee:	c3                   	ret    

00801aef <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801aef:	55                   	push   %ebp
  801af0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801af2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af5:	8b 45 08             	mov    0x8(%ebp),%eax
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	52                   	push   %edx
  801aff:	50                   	push   %eax
  801b00:	6a 19                	push   $0x19
  801b02:	e8 ff fc ff ff       	call   801806 <syscall>
  801b07:	83 c4 18             	add    $0x18,%esp
}
  801b0a:	90                   	nop
  801b0b:	c9                   	leave  
  801b0c:	c3                   	ret    

00801b0d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b0d:	55                   	push   %ebp
  801b0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b10:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b13:	8b 45 08             	mov    0x8(%ebp),%eax
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	52                   	push   %edx
  801b1d:	50                   	push   %eax
  801b1e:	6a 1a                	push   $0x1a
  801b20:	e8 e1 fc ff ff       	call   801806 <syscall>
  801b25:	83 c4 18             	add    $0x18,%esp
}
  801b28:	90                   	nop
  801b29:	c9                   	leave  
  801b2a:	c3                   	ret    

00801b2b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
  801b2e:	83 ec 04             	sub    $0x4,%esp
  801b31:	8b 45 10             	mov    0x10(%ebp),%eax
  801b34:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b37:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b3a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b41:	6a 00                	push   $0x0
  801b43:	51                   	push   %ecx
  801b44:	52                   	push   %edx
  801b45:	ff 75 0c             	pushl  0xc(%ebp)
  801b48:	50                   	push   %eax
  801b49:	6a 1c                	push   $0x1c
  801b4b:	e8 b6 fc ff ff       	call   801806 <syscall>
  801b50:	83 c4 18             	add    $0x18,%esp
}
  801b53:	c9                   	leave  
  801b54:	c3                   	ret    

00801b55 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b55:	55                   	push   %ebp
  801b56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b58:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	52                   	push   %edx
  801b65:	50                   	push   %eax
  801b66:	6a 1d                	push   $0x1d
  801b68:	e8 99 fc ff ff       	call   801806 <syscall>
  801b6d:	83 c4 18             	add    $0x18,%esp
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b75:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b78:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	51                   	push   %ecx
  801b83:	52                   	push   %edx
  801b84:	50                   	push   %eax
  801b85:	6a 1e                	push   $0x1e
  801b87:	e8 7a fc ff ff       	call   801806 <syscall>
  801b8c:	83 c4 18             	add    $0x18,%esp
}
  801b8f:	c9                   	leave  
  801b90:	c3                   	ret    

00801b91 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b91:	55                   	push   %ebp
  801b92:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b94:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b97:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	52                   	push   %edx
  801ba1:	50                   	push   %eax
  801ba2:	6a 1f                	push   $0x1f
  801ba4:	e8 5d fc ff ff       	call   801806 <syscall>
  801ba9:	83 c4 18             	add    $0x18,%esp
}
  801bac:	c9                   	leave  
  801bad:	c3                   	ret    

00801bae <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801bae:	55                   	push   %ebp
  801baf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 20                	push   $0x20
  801bbd:	e8 44 fc ff ff       	call   801806 <syscall>
  801bc2:	83 c4 18             	add    $0x18,%esp
}
  801bc5:	c9                   	leave  
  801bc6:	c3                   	ret    

00801bc7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801bc7:	55                   	push   %ebp
  801bc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801bca:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcd:	6a 00                	push   $0x0
  801bcf:	ff 75 14             	pushl  0x14(%ebp)
  801bd2:	ff 75 10             	pushl  0x10(%ebp)
  801bd5:	ff 75 0c             	pushl  0xc(%ebp)
  801bd8:	50                   	push   %eax
  801bd9:	6a 21                	push   $0x21
  801bdb:	e8 26 fc ff ff       	call   801806 <syscall>
  801be0:	83 c4 18             	add    $0x18,%esp
}
  801be3:	c9                   	leave  
  801be4:	c3                   	ret    

00801be5 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801be5:	55                   	push   %ebp
  801be6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801be8:	8b 45 08             	mov    0x8(%ebp),%eax
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	50                   	push   %eax
  801bf4:	6a 22                	push   $0x22
  801bf6:	e8 0b fc ff ff       	call   801806 <syscall>
  801bfb:	83 c4 18             	add    $0x18,%esp
}
  801bfe:	90                   	nop
  801bff:	c9                   	leave  
  801c00:	c3                   	ret    

00801c01 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c01:	55                   	push   %ebp
  801c02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c04:	8b 45 08             	mov    0x8(%ebp),%eax
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 00                	push   $0x0
  801c0f:	50                   	push   %eax
  801c10:	6a 23                	push   $0x23
  801c12:	e8 ef fb ff ff       	call   801806 <syscall>
  801c17:	83 c4 18             	add    $0x18,%esp
}
  801c1a:	90                   	nop
  801c1b:	c9                   	leave  
  801c1c:	c3                   	ret    

00801c1d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c1d:	55                   	push   %ebp
  801c1e:	89 e5                	mov    %esp,%ebp
  801c20:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c23:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c26:	8d 50 04             	lea    0x4(%eax),%edx
  801c29:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	52                   	push   %edx
  801c33:	50                   	push   %eax
  801c34:	6a 24                	push   $0x24
  801c36:	e8 cb fb ff ff       	call   801806 <syscall>
  801c3b:	83 c4 18             	add    $0x18,%esp
	return result;
  801c3e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c41:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c44:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c47:	89 01                	mov    %eax,(%ecx)
  801c49:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4f:	c9                   	leave  
  801c50:	c2 04 00             	ret    $0x4

00801c53 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c53:	55                   	push   %ebp
  801c54:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	ff 75 10             	pushl  0x10(%ebp)
  801c5d:	ff 75 0c             	pushl  0xc(%ebp)
  801c60:	ff 75 08             	pushl  0x8(%ebp)
  801c63:	6a 13                	push   $0x13
  801c65:	e8 9c fb ff ff       	call   801806 <syscall>
  801c6a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c6d:	90                   	nop
}
  801c6e:	c9                   	leave  
  801c6f:	c3                   	ret    

00801c70 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c70:	55                   	push   %ebp
  801c71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 25                	push   $0x25
  801c7f:	e8 82 fb ff ff       	call   801806 <syscall>
  801c84:	83 c4 18             	add    $0x18,%esp
}
  801c87:	c9                   	leave  
  801c88:	c3                   	ret    

00801c89 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c89:	55                   	push   %ebp
  801c8a:	89 e5                	mov    %esp,%ebp
  801c8c:	83 ec 04             	sub    $0x4,%esp
  801c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c92:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c95:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 00                	push   $0x0
  801c9f:	6a 00                	push   $0x0
  801ca1:	50                   	push   %eax
  801ca2:	6a 26                	push   $0x26
  801ca4:	e8 5d fb ff ff       	call   801806 <syscall>
  801ca9:	83 c4 18             	add    $0x18,%esp
	return ;
  801cac:	90                   	nop
}
  801cad:	c9                   	leave  
  801cae:	c3                   	ret    

00801caf <rsttst>:
void rsttst()
{
  801caf:	55                   	push   %ebp
  801cb0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 28                	push   $0x28
  801cbe:	e8 43 fb ff ff       	call   801806 <syscall>
  801cc3:	83 c4 18             	add    $0x18,%esp
	return ;
  801cc6:	90                   	nop
}
  801cc7:	c9                   	leave  
  801cc8:	c3                   	ret    

00801cc9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801cc9:	55                   	push   %ebp
  801cca:	89 e5                	mov    %esp,%ebp
  801ccc:	83 ec 04             	sub    $0x4,%esp
  801ccf:	8b 45 14             	mov    0x14(%ebp),%eax
  801cd2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801cd5:	8b 55 18             	mov    0x18(%ebp),%edx
  801cd8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cdc:	52                   	push   %edx
  801cdd:	50                   	push   %eax
  801cde:	ff 75 10             	pushl  0x10(%ebp)
  801ce1:	ff 75 0c             	pushl  0xc(%ebp)
  801ce4:	ff 75 08             	pushl  0x8(%ebp)
  801ce7:	6a 27                	push   $0x27
  801ce9:	e8 18 fb ff ff       	call   801806 <syscall>
  801cee:	83 c4 18             	add    $0x18,%esp
	return ;
  801cf1:	90                   	nop
}
  801cf2:	c9                   	leave  
  801cf3:	c3                   	ret    

00801cf4 <chktst>:
void chktst(uint32 n)
{
  801cf4:	55                   	push   %ebp
  801cf5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	ff 75 08             	pushl  0x8(%ebp)
  801d02:	6a 29                	push   $0x29
  801d04:	e8 fd fa ff ff       	call   801806 <syscall>
  801d09:	83 c4 18             	add    $0x18,%esp
	return ;
  801d0c:	90                   	nop
}
  801d0d:	c9                   	leave  
  801d0e:	c3                   	ret    

00801d0f <inctst>:

void inctst()
{
  801d0f:	55                   	push   %ebp
  801d10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 2a                	push   $0x2a
  801d1e:	e8 e3 fa ff ff       	call   801806 <syscall>
  801d23:	83 c4 18             	add    $0x18,%esp
	return ;
  801d26:	90                   	nop
}
  801d27:	c9                   	leave  
  801d28:	c3                   	ret    

00801d29 <gettst>:
uint32 gettst()
{
  801d29:	55                   	push   %ebp
  801d2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	6a 2b                	push   $0x2b
  801d38:	e8 c9 fa ff ff       	call   801806 <syscall>
  801d3d:	83 c4 18             	add    $0x18,%esp
}
  801d40:	c9                   	leave  
  801d41:	c3                   	ret    

00801d42 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d42:	55                   	push   %ebp
  801d43:	89 e5                	mov    %esp,%ebp
  801d45:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	6a 2c                	push   $0x2c
  801d54:	e8 ad fa ff ff       	call   801806 <syscall>
  801d59:	83 c4 18             	add    $0x18,%esp
  801d5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d5f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d63:	75 07                	jne    801d6c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d65:	b8 01 00 00 00       	mov    $0x1,%eax
  801d6a:	eb 05                	jmp    801d71 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d6c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d71:	c9                   	leave  
  801d72:	c3                   	ret    

00801d73 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d73:	55                   	push   %ebp
  801d74:	89 e5                	mov    %esp,%ebp
  801d76:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 2c                	push   $0x2c
  801d85:	e8 7c fa ff ff       	call   801806 <syscall>
  801d8a:	83 c4 18             	add    $0x18,%esp
  801d8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d90:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d94:	75 07                	jne    801d9d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d96:	b8 01 00 00 00       	mov    $0x1,%eax
  801d9b:	eb 05                	jmp    801da2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801da2:	c9                   	leave  
  801da3:	c3                   	ret    

00801da4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801da4:	55                   	push   %ebp
  801da5:	89 e5                	mov    %esp,%ebp
  801da7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	6a 00                	push   $0x0
  801db4:	6a 2c                	push   $0x2c
  801db6:	e8 4b fa ff ff       	call   801806 <syscall>
  801dbb:	83 c4 18             	add    $0x18,%esp
  801dbe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801dc1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801dc5:	75 07                	jne    801dce <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801dc7:	b8 01 00 00 00       	mov    $0x1,%eax
  801dcc:	eb 05                	jmp    801dd3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801dce:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dd3:	c9                   	leave  
  801dd4:	c3                   	ret    

00801dd5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801dd5:	55                   	push   %ebp
  801dd6:	89 e5                	mov    %esp,%ebp
  801dd8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	6a 00                	push   $0x0
  801de5:	6a 2c                	push   $0x2c
  801de7:	e8 1a fa ff ff       	call   801806 <syscall>
  801dec:	83 c4 18             	add    $0x18,%esp
  801def:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801df2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801df6:	75 07                	jne    801dff <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801df8:	b8 01 00 00 00       	mov    $0x1,%eax
  801dfd:	eb 05                	jmp    801e04 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801dff:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e04:	c9                   	leave  
  801e05:	c3                   	ret    

00801e06 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e06:	55                   	push   %ebp
  801e07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	ff 75 08             	pushl  0x8(%ebp)
  801e14:	6a 2d                	push   $0x2d
  801e16:	e8 eb f9 ff ff       	call   801806 <syscall>
  801e1b:	83 c4 18             	add    $0x18,%esp
	return ;
  801e1e:	90                   	nop
}
  801e1f:	c9                   	leave  
  801e20:	c3                   	ret    

00801e21 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e21:	55                   	push   %ebp
  801e22:	89 e5                	mov    %esp,%ebp
  801e24:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e25:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e28:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e31:	6a 00                	push   $0x0
  801e33:	53                   	push   %ebx
  801e34:	51                   	push   %ecx
  801e35:	52                   	push   %edx
  801e36:	50                   	push   %eax
  801e37:	6a 2e                	push   $0x2e
  801e39:	e8 c8 f9 ff ff       	call   801806 <syscall>
  801e3e:	83 c4 18             	add    $0x18,%esp
}
  801e41:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801e44:	c9                   	leave  
  801e45:	c3                   	ret    

00801e46 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801e46:	55                   	push   %ebp
  801e47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801e49:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	52                   	push   %edx
  801e56:	50                   	push   %eax
  801e57:	6a 2f                	push   $0x2f
  801e59:	e8 a8 f9 ff ff       	call   801806 <syscall>
  801e5e:	83 c4 18             	add    $0x18,%esp
}
  801e61:	c9                   	leave  
  801e62:	c3                   	ret    
  801e63:	90                   	nop

00801e64 <__udivdi3>:
  801e64:	55                   	push   %ebp
  801e65:	57                   	push   %edi
  801e66:	56                   	push   %esi
  801e67:	53                   	push   %ebx
  801e68:	83 ec 1c             	sub    $0x1c,%esp
  801e6b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e6f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e73:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e77:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e7b:	89 ca                	mov    %ecx,%edx
  801e7d:	89 f8                	mov    %edi,%eax
  801e7f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e83:	85 f6                	test   %esi,%esi
  801e85:	75 2d                	jne    801eb4 <__udivdi3+0x50>
  801e87:	39 cf                	cmp    %ecx,%edi
  801e89:	77 65                	ja     801ef0 <__udivdi3+0x8c>
  801e8b:	89 fd                	mov    %edi,%ebp
  801e8d:	85 ff                	test   %edi,%edi
  801e8f:	75 0b                	jne    801e9c <__udivdi3+0x38>
  801e91:	b8 01 00 00 00       	mov    $0x1,%eax
  801e96:	31 d2                	xor    %edx,%edx
  801e98:	f7 f7                	div    %edi
  801e9a:	89 c5                	mov    %eax,%ebp
  801e9c:	31 d2                	xor    %edx,%edx
  801e9e:	89 c8                	mov    %ecx,%eax
  801ea0:	f7 f5                	div    %ebp
  801ea2:	89 c1                	mov    %eax,%ecx
  801ea4:	89 d8                	mov    %ebx,%eax
  801ea6:	f7 f5                	div    %ebp
  801ea8:	89 cf                	mov    %ecx,%edi
  801eaa:	89 fa                	mov    %edi,%edx
  801eac:	83 c4 1c             	add    $0x1c,%esp
  801eaf:	5b                   	pop    %ebx
  801eb0:	5e                   	pop    %esi
  801eb1:	5f                   	pop    %edi
  801eb2:	5d                   	pop    %ebp
  801eb3:	c3                   	ret    
  801eb4:	39 ce                	cmp    %ecx,%esi
  801eb6:	77 28                	ja     801ee0 <__udivdi3+0x7c>
  801eb8:	0f bd fe             	bsr    %esi,%edi
  801ebb:	83 f7 1f             	xor    $0x1f,%edi
  801ebe:	75 40                	jne    801f00 <__udivdi3+0x9c>
  801ec0:	39 ce                	cmp    %ecx,%esi
  801ec2:	72 0a                	jb     801ece <__udivdi3+0x6a>
  801ec4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ec8:	0f 87 9e 00 00 00    	ja     801f6c <__udivdi3+0x108>
  801ece:	b8 01 00 00 00       	mov    $0x1,%eax
  801ed3:	89 fa                	mov    %edi,%edx
  801ed5:	83 c4 1c             	add    $0x1c,%esp
  801ed8:	5b                   	pop    %ebx
  801ed9:	5e                   	pop    %esi
  801eda:	5f                   	pop    %edi
  801edb:	5d                   	pop    %ebp
  801edc:	c3                   	ret    
  801edd:	8d 76 00             	lea    0x0(%esi),%esi
  801ee0:	31 ff                	xor    %edi,%edi
  801ee2:	31 c0                	xor    %eax,%eax
  801ee4:	89 fa                	mov    %edi,%edx
  801ee6:	83 c4 1c             	add    $0x1c,%esp
  801ee9:	5b                   	pop    %ebx
  801eea:	5e                   	pop    %esi
  801eeb:	5f                   	pop    %edi
  801eec:	5d                   	pop    %ebp
  801eed:	c3                   	ret    
  801eee:	66 90                	xchg   %ax,%ax
  801ef0:	89 d8                	mov    %ebx,%eax
  801ef2:	f7 f7                	div    %edi
  801ef4:	31 ff                	xor    %edi,%edi
  801ef6:	89 fa                	mov    %edi,%edx
  801ef8:	83 c4 1c             	add    $0x1c,%esp
  801efb:	5b                   	pop    %ebx
  801efc:	5e                   	pop    %esi
  801efd:	5f                   	pop    %edi
  801efe:	5d                   	pop    %ebp
  801eff:	c3                   	ret    
  801f00:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f05:	89 eb                	mov    %ebp,%ebx
  801f07:	29 fb                	sub    %edi,%ebx
  801f09:	89 f9                	mov    %edi,%ecx
  801f0b:	d3 e6                	shl    %cl,%esi
  801f0d:	89 c5                	mov    %eax,%ebp
  801f0f:	88 d9                	mov    %bl,%cl
  801f11:	d3 ed                	shr    %cl,%ebp
  801f13:	89 e9                	mov    %ebp,%ecx
  801f15:	09 f1                	or     %esi,%ecx
  801f17:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f1b:	89 f9                	mov    %edi,%ecx
  801f1d:	d3 e0                	shl    %cl,%eax
  801f1f:	89 c5                	mov    %eax,%ebp
  801f21:	89 d6                	mov    %edx,%esi
  801f23:	88 d9                	mov    %bl,%cl
  801f25:	d3 ee                	shr    %cl,%esi
  801f27:	89 f9                	mov    %edi,%ecx
  801f29:	d3 e2                	shl    %cl,%edx
  801f2b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f2f:	88 d9                	mov    %bl,%cl
  801f31:	d3 e8                	shr    %cl,%eax
  801f33:	09 c2                	or     %eax,%edx
  801f35:	89 d0                	mov    %edx,%eax
  801f37:	89 f2                	mov    %esi,%edx
  801f39:	f7 74 24 0c          	divl   0xc(%esp)
  801f3d:	89 d6                	mov    %edx,%esi
  801f3f:	89 c3                	mov    %eax,%ebx
  801f41:	f7 e5                	mul    %ebp
  801f43:	39 d6                	cmp    %edx,%esi
  801f45:	72 19                	jb     801f60 <__udivdi3+0xfc>
  801f47:	74 0b                	je     801f54 <__udivdi3+0xf0>
  801f49:	89 d8                	mov    %ebx,%eax
  801f4b:	31 ff                	xor    %edi,%edi
  801f4d:	e9 58 ff ff ff       	jmp    801eaa <__udivdi3+0x46>
  801f52:	66 90                	xchg   %ax,%ax
  801f54:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f58:	89 f9                	mov    %edi,%ecx
  801f5a:	d3 e2                	shl    %cl,%edx
  801f5c:	39 c2                	cmp    %eax,%edx
  801f5e:	73 e9                	jae    801f49 <__udivdi3+0xe5>
  801f60:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f63:	31 ff                	xor    %edi,%edi
  801f65:	e9 40 ff ff ff       	jmp    801eaa <__udivdi3+0x46>
  801f6a:	66 90                	xchg   %ax,%ax
  801f6c:	31 c0                	xor    %eax,%eax
  801f6e:	e9 37 ff ff ff       	jmp    801eaa <__udivdi3+0x46>
  801f73:	90                   	nop

00801f74 <__umoddi3>:
  801f74:	55                   	push   %ebp
  801f75:	57                   	push   %edi
  801f76:	56                   	push   %esi
  801f77:	53                   	push   %ebx
  801f78:	83 ec 1c             	sub    $0x1c,%esp
  801f7b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f7f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f83:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f87:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f8b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f8f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f93:	89 f3                	mov    %esi,%ebx
  801f95:	89 fa                	mov    %edi,%edx
  801f97:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f9b:	89 34 24             	mov    %esi,(%esp)
  801f9e:	85 c0                	test   %eax,%eax
  801fa0:	75 1a                	jne    801fbc <__umoddi3+0x48>
  801fa2:	39 f7                	cmp    %esi,%edi
  801fa4:	0f 86 a2 00 00 00    	jbe    80204c <__umoddi3+0xd8>
  801faa:	89 c8                	mov    %ecx,%eax
  801fac:	89 f2                	mov    %esi,%edx
  801fae:	f7 f7                	div    %edi
  801fb0:	89 d0                	mov    %edx,%eax
  801fb2:	31 d2                	xor    %edx,%edx
  801fb4:	83 c4 1c             	add    $0x1c,%esp
  801fb7:	5b                   	pop    %ebx
  801fb8:	5e                   	pop    %esi
  801fb9:	5f                   	pop    %edi
  801fba:	5d                   	pop    %ebp
  801fbb:	c3                   	ret    
  801fbc:	39 f0                	cmp    %esi,%eax
  801fbe:	0f 87 ac 00 00 00    	ja     802070 <__umoddi3+0xfc>
  801fc4:	0f bd e8             	bsr    %eax,%ebp
  801fc7:	83 f5 1f             	xor    $0x1f,%ebp
  801fca:	0f 84 ac 00 00 00    	je     80207c <__umoddi3+0x108>
  801fd0:	bf 20 00 00 00       	mov    $0x20,%edi
  801fd5:	29 ef                	sub    %ebp,%edi
  801fd7:	89 fe                	mov    %edi,%esi
  801fd9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801fdd:	89 e9                	mov    %ebp,%ecx
  801fdf:	d3 e0                	shl    %cl,%eax
  801fe1:	89 d7                	mov    %edx,%edi
  801fe3:	89 f1                	mov    %esi,%ecx
  801fe5:	d3 ef                	shr    %cl,%edi
  801fe7:	09 c7                	or     %eax,%edi
  801fe9:	89 e9                	mov    %ebp,%ecx
  801feb:	d3 e2                	shl    %cl,%edx
  801fed:	89 14 24             	mov    %edx,(%esp)
  801ff0:	89 d8                	mov    %ebx,%eax
  801ff2:	d3 e0                	shl    %cl,%eax
  801ff4:	89 c2                	mov    %eax,%edx
  801ff6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ffa:	d3 e0                	shl    %cl,%eax
  801ffc:	89 44 24 04          	mov    %eax,0x4(%esp)
  802000:	8b 44 24 08          	mov    0x8(%esp),%eax
  802004:	89 f1                	mov    %esi,%ecx
  802006:	d3 e8                	shr    %cl,%eax
  802008:	09 d0                	or     %edx,%eax
  80200a:	d3 eb                	shr    %cl,%ebx
  80200c:	89 da                	mov    %ebx,%edx
  80200e:	f7 f7                	div    %edi
  802010:	89 d3                	mov    %edx,%ebx
  802012:	f7 24 24             	mull   (%esp)
  802015:	89 c6                	mov    %eax,%esi
  802017:	89 d1                	mov    %edx,%ecx
  802019:	39 d3                	cmp    %edx,%ebx
  80201b:	0f 82 87 00 00 00    	jb     8020a8 <__umoddi3+0x134>
  802021:	0f 84 91 00 00 00    	je     8020b8 <__umoddi3+0x144>
  802027:	8b 54 24 04          	mov    0x4(%esp),%edx
  80202b:	29 f2                	sub    %esi,%edx
  80202d:	19 cb                	sbb    %ecx,%ebx
  80202f:	89 d8                	mov    %ebx,%eax
  802031:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802035:	d3 e0                	shl    %cl,%eax
  802037:	89 e9                	mov    %ebp,%ecx
  802039:	d3 ea                	shr    %cl,%edx
  80203b:	09 d0                	or     %edx,%eax
  80203d:	89 e9                	mov    %ebp,%ecx
  80203f:	d3 eb                	shr    %cl,%ebx
  802041:	89 da                	mov    %ebx,%edx
  802043:	83 c4 1c             	add    $0x1c,%esp
  802046:	5b                   	pop    %ebx
  802047:	5e                   	pop    %esi
  802048:	5f                   	pop    %edi
  802049:	5d                   	pop    %ebp
  80204a:	c3                   	ret    
  80204b:	90                   	nop
  80204c:	89 fd                	mov    %edi,%ebp
  80204e:	85 ff                	test   %edi,%edi
  802050:	75 0b                	jne    80205d <__umoddi3+0xe9>
  802052:	b8 01 00 00 00       	mov    $0x1,%eax
  802057:	31 d2                	xor    %edx,%edx
  802059:	f7 f7                	div    %edi
  80205b:	89 c5                	mov    %eax,%ebp
  80205d:	89 f0                	mov    %esi,%eax
  80205f:	31 d2                	xor    %edx,%edx
  802061:	f7 f5                	div    %ebp
  802063:	89 c8                	mov    %ecx,%eax
  802065:	f7 f5                	div    %ebp
  802067:	89 d0                	mov    %edx,%eax
  802069:	e9 44 ff ff ff       	jmp    801fb2 <__umoddi3+0x3e>
  80206e:	66 90                	xchg   %ax,%ax
  802070:	89 c8                	mov    %ecx,%eax
  802072:	89 f2                	mov    %esi,%edx
  802074:	83 c4 1c             	add    $0x1c,%esp
  802077:	5b                   	pop    %ebx
  802078:	5e                   	pop    %esi
  802079:	5f                   	pop    %edi
  80207a:	5d                   	pop    %ebp
  80207b:	c3                   	ret    
  80207c:	3b 04 24             	cmp    (%esp),%eax
  80207f:	72 06                	jb     802087 <__umoddi3+0x113>
  802081:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802085:	77 0f                	ja     802096 <__umoddi3+0x122>
  802087:	89 f2                	mov    %esi,%edx
  802089:	29 f9                	sub    %edi,%ecx
  80208b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80208f:	89 14 24             	mov    %edx,(%esp)
  802092:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802096:	8b 44 24 04          	mov    0x4(%esp),%eax
  80209a:	8b 14 24             	mov    (%esp),%edx
  80209d:	83 c4 1c             	add    $0x1c,%esp
  8020a0:	5b                   	pop    %ebx
  8020a1:	5e                   	pop    %esi
  8020a2:	5f                   	pop    %edi
  8020a3:	5d                   	pop    %ebp
  8020a4:	c3                   	ret    
  8020a5:	8d 76 00             	lea    0x0(%esi),%esi
  8020a8:	2b 04 24             	sub    (%esp),%eax
  8020ab:	19 fa                	sbb    %edi,%edx
  8020ad:	89 d1                	mov    %edx,%ecx
  8020af:	89 c6                	mov    %eax,%esi
  8020b1:	e9 71 ff ff ff       	jmp    802027 <__umoddi3+0xb3>
  8020b6:	66 90                	xchg   %ax,%ax
  8020b8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8020bc:	72 ea                	jb     8020a8 <__umoddi3+0x134>
  8020be:	89 d9                	mov    %ebx,%ecx
  8020c0:	e9 62 ff ff ff       	jmp    802027 <__umoddi3+0xb3>
