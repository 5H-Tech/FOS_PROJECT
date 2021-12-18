
obj/user/quicksort_semaphore:     file format elf32-i386


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
  800031:	e8 94 06 00 00       	call   8006ca <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);
uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 24 01 00 00    	sub    $0x124,%esp
	int envID = sys_getenvid();
  800042:	e8 69 1d 00 00       	call   801db0 <sys_getenvid>
  800047:	89 45 f0             	mov    %eax,-0x10(%ebp)
	char Chose ;
	char Line[255] ;
	int Iteration = 0 ;
  80004a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	sys_createSemaphore("IO.CS", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 00 26 80 00       	push   $0x802600
  80005b:	e8 78 1f 00 00       	call   801fd8 <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 2c 1e 00 00       	call   801e94 <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 3e 1e 00 00       	call   801ead <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 ec             	mov    %eax,-0x14(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();

		sys_waitSemaphore(envID, "IO.CS");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 00 26 80 00       	push   $0x802600
  80007f:	ff 75 f0             	pushl  -0x10(%ebp)
  800082:	e8 8a 1f 00 00       	call   802011 <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
			readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 dd fe ff ff    	lea    -0x123(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 08 26 80 00       	push   $0x802608
  800099:	e8 95 10 00 00       	call   801133 <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 dd fe ff ff    	lea    -0x123(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 e5 15 00 00       	call   801699 <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 78 19 00 00       	call   801a41 <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 28 26 80 00       	push   $0x802628
  8000d7:	e8 d5 09 00 00       	call   800ab1 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 4b 26 80 00       	push   $0x80264b
  8000e7:	e8 c5 09 00 00       	call   800ab1 <cprintf>
  8000ec:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	68 59 26 80 00       	push   $0x802659
  8000f7:	e8 b5 09 00 00       	call   800ab1 <cprintf>
  8000fc:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	68 68 26 80 00       	push   $0x802668
  800107:	e8 a5 09 00 00       	call   800ab1 <cprintf>
  80010c:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  80010f:	83 ec 0c             	sub    $0xc,%esp
  800112:	68 78 26 80 00       	push   $0x802678
  800117:	e8 95 09 00 00       	call   800ab1 <cprintf>
  80011c:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  80011f:	e8 4e 05 00 00       	call   800672 <getchar>
  800124:	88 45 e3             	mov    %al,-0x1d(%ebp)
				cputchar(Chose);
  800127:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80012b:	83 ec 0c             	sub    $0xc,%esp
  80012e:	50                   	push   %eax
  80012f:	e8 f6 04 00 00       	call   80062a <cputchar>
  800134:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	6a 0a                	push   $0xa
  80013c:	e8 e9 04 00 00       	call   80062a <cputchar>
  800141:	83 c4 10             	add    $0x10,%esp
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800144:	80 7d e3 61          	cmpb   $0x61,-0x1d(%ebp)
  800148:	74 0c                	je     800156 <_main+0x11e>
  80014a:	80 7d e3 62          	cmpb   $0x62,-0x1d(%ebp)
  80014e:	74 06                	je     800156 <_main+0x11e>
  800150:	80 7d e3 63          	cmpb   $0x63,-0x1d(%ebp)
  800154:	75 b9                	jne    80010f <_main+0xd7>

		sys_signalSemaphore(envID, "IO.CS");
  800156:	83 ec 08             	sub    $0x8,%esp
  800159:	68 00 26 80 00       	push   $0x802600
  80015e:	ff 75 f0             	pushl  -0x10(%ebp)
  800161:	e8 c9 1e 00 00       	call   80202f <sys_signalSemaphore>
  800166:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800169:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  80016d:	83 f8 62             	cmp    $0x62,%eax
  800170:	74 1d                	je     80018f <_main+0x157>
  800172:	83 f8 63             	cmp    $0x63,%eax
  800175:	74 2b                	je     8001a2 <_main+0x16a>
  800177:	83 f8 61             	cmp    $0x61,%eax
  80017a:	75 39                	jne    8001b5 <_main+0x17d>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017c:	83 ec 08             	sub    $0x8,%esp
  80017f:	ff 75 e8             	pushl  -0x18(%ebp)
  800182:	ff 75 e4             	pushl  -0x1c(%ebp)
  800185:	e8 3a 03 00 00       	call   8004c4 <InitializeAscending>
  80018a:	83 c4 10             	add    $0x10,%esp
			break ;
  80018d:	eb 37                	jmp    8001c6 <_main+0x18e>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018f:	83 ec 08             	sub    $0x8,%esp
  800192:	ff 75 e8             	pushl  -0x18(%ebp)
  800195:	ff 75 e4             	pushl  -0x1c(%ebp)
  800198:	e8 58 03 00 00       	call   8004f5 <InitializeDescending>
  80019d:	83 c4 10             	add    $0x10,%esp
			break ;
  8001a0:	eb 24                	jmp    8001c6 <_main+0x18e>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a2:	83 ec 08             	sub    $0x8,%esp
  8001a5:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001ab:	e8 7a 03 00 00       	call   80052a <InitializeSemiRandom>
  8001b0:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b3:	eb 11                	jmp    8001c6 <_main+0x18e>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b5:	83 ec 08             	sub    $0x8,%esp
  8001b8:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001be:	e8 67 03 00 00       	call   80052a <InitializeSemiRandom>
  8001c3:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c6:	83 ec 08             	sub    $0x8,%esp
  8001c9:	ff 75 e8             	pushl  -0x18(%ebp)
  8001cc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001cf:	e8 35 01 00 00       	call   800309 <QuickSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 e8             	pushl  -0x18(%ebp)
  8001dd:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001e0:	e8 35 02 00 00       	call   80041a <CheckSorted>
  8001e5:	83 c4 10             	add    $0x10,%esp
  8001e8:	89 45 dc             	mov    %eax,-0x24(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001eb:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001ef:	75 14                	jne    800205 <_main+0x1cd>
  8001f1:	83 ec 04             	sub    $0x4,%esp
  8001f4:	68 84 26 80 00       	push   $0x802684
  8001f9:	6a 4a                	push   $0x4a
  8001fb:	68 a6 26 80 00       	push   $0x8026a6
  800200:	e8 0a 06 00 00       	call   80080f <_panic>
		else
		{
			sys_waitSemaphore(envID, "IO.CS");
  800205:	83 ec 08             	sub    $0x8,%esp
  800208:	68 00 26 80 00       	push   $0x802600
  80020d:	ff 75 f0             	pushl  -0x10(%ebp)
  800210:	e8 fc 1d 00 00       	call   802011 <sys_waitSemaphore>
  800215:	83 c4 10             	add    $0x10,%esp
				cprintf("\n===============================================\n") ;
  800218:	83 ec 0c             	sub    $0xc,%esp
  80021b:	68 c4 26 80 00       	push   $0x8026c4
  800220:	e8 8c 08 00 00       	call   800ab1 <cprintf>
  800225:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  800228:	83 ec 0c             	sub    $0xc,%esp
  80022b:	68 f8 26 80 00       	push   $0x8026f8
  800230:	e8 7c 08 00 00       	call   800ab1 <cprintf>
  800235:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  800238:	83 ec 0c             	sub    $0xc,%esp
  80023b:	68 2c 27 80 00       	push   $0x80272c
  800240:	e8 6c 08 00 00       	call   800ab1 <cprintf>
  800245:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "IO.CS");
  800248:	83 ec 08             	sub    $0x8,%esp
  80024b:	68 00 26 80 00       	push   $0x802600
  800250:	ff 75 f0             	pushl  -0x10(%ebp)
  800253:	e8 d7 1d 00 00       	call   80202f <sys_signalSemaphore>
  800258:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_waitSemaphore(envID, "IO.CS");
  80025b:	83 ec 08             	sub    $0x8,%esp
  80025e:	68 00 26 80 00       	push   $0x802600
  800263:	ff 75 f0             	pushl  -0x10(%ebp)
  800266:	e8 a6 1d 00 00       	call   802011 <sys_waitSemaphore>
  80026b:	83 c4 10             	add    $0x10,%esp
			cprintf("Freeing the Heap...\n\n") ;
  80026e:	83 ec 0c             	sub    $0xc,%esp
  800271:	68 5e 27 80 00       	push   $0x80275e
  800276:	e8 36 08 00 00       	call   800ab1 <cprintf>
  80027b:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "IO.CS");
  80027e:	83 ec 08             	sub    $0x8,%esp
  800281:	68 00 26 80 00       	push   $0x802600
  800286:	ff 75 f0             	pushl  -0x10(%ebp)
  800289:	e8 a1 1d 00 00       	call   80202f <sys_signalSemaphore>
  80028e:	83 c4 10             	add    $0x10,%esp

		//freeHeap() ;

		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "IO.CS");
  800291:	83 ec 08             	sub    $0x8,%esp
  800294:	68 00 26 80 00       	push   $0x802600
  800299:	ff 75 f0             	pushl  -0x10(%ebp)
  80029c:	e8 70 1d 00 00       	call   802011 <sys_waitSemaphore>
  8002a1:	83 c4 10             	add    $0x10,%esp
			cprintf("Do you want to repeat (y/n): ") ;
  8002a4:	83 ec 0c             	sub    $0xc,%esp
  8002a7:	68 74 27 80 00       	push   $0x802774
  8002ac:	e8 00 08 00 00       	call   800ab1 <cprintf>
  8002b1:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8002b4:	e8 b9 03 00 00       	call   800672 <getchar>
  8002b9:	88 45 e3             	mov    %al,-0x1d(%ebp)
			cputchar(Chose);
  8002bc:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  8002c0:	83 ec 0c             	sub    $0xc,%esp
  8002c3:	50                   	push   %eax
  8002c4:	e8 61 03 00 00       	call   80062a <cputchar>
  8002c9:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002cc:	83 ec 0c             	sub    $0xc,%esp
  8002cf:	6a 0a                	push   $0xa
  8002d1:	e8 54 03 00 00       	call   80062a <cputchar>
  8002d6:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002d9:	83 ec 0c             	sub    $0xc,%esp
  8002dc:	6a 0a                	push   $0xa
  8002de:	e8 47 03 00 00       	call   80062a <cputchar>
  8002e3:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID, "IO.CS");
  8002e6:	83 ec 08             	sub    $0x8,%esp
  8002e9:	68 00 26 80 00       	push   $0x802600
  8002ee:	ff 75 f0             	pushl  -0x10(%ebp)
  8002f1:	e8 39 1d 00 00       	call   80202f <sys_signalSemaphore>
  8002f6:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  8002f9:	80 7d e3 79          	cmpb   $0x79,-0x1d(%ebp)
  8002fd:	0f 84 60 fd ff ff    	je     800063 <_main+0x2b>

}
  800303:	90                   	nop
  800304:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800307:	c9                   	leave  
  800308:	c3                   	ret    

00800309 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  800309:	55                   	push   %ebp
  80030a:	89 e5                	mov    %esp,%ebp
  80030c:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80030f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800312:	48                   	dec    %eax
  800313:	50                   	push   %eax
  800314:	6a 00                	push   $0x0
  800316:	ff 75 0c             	pushl  0xc(%ebp)
  800319:	ff 75 08             	pushl  0x8(%ebp)
  80031c:	e8 06 00 00 00       	call   800327 <QSort>
  800321:	83 c4 10             	add    $0x10,%esp
}
  800324:	90                   	nop
  800325:	c9                   	leave  
  800326:	c3                   	ret    

00800327 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800327:	55                   	push   %ebp
  800328:	89 e5                	mov    %esp,%ebp
  80032a:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80032d:	8b 45 10             	mov    0x10(%ebp),%eax
  800330:	3b 45 14             	cmp    0x14(%ebp),%eax
  800333:	0f 8d de 00 00 00    	jge    800417 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800339:	8b 45 10             	mov    0x10(%ebp),%eax
  80033c:	40                   	inc    %eax
  80033d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800340:	8b 45 14             	mov    0x14(%ebp),%eax
  800343:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800346:	e9 80 00 00 00       	jmp    8003cb <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  80034b:	ff 45 f4             	incl   -0xc(%ebp)
  80034e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800351:	3b 45 14             	cmp    0x14(%ebp),%eax
  800354:	7f 2b                	jg     800381 <QSort+0x5a>
  800356:	8b 45 10             	mov    0x10(%ebp),%eax
  800359:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800360:	8b 45 08             	mov    0x8(%ebp),%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	8b 10                	mov    (%eax),%edx
  800367:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80036a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800371:	8b 45 08             	mov    0x8(%ebp),%eax
  800374:	01 c8                	add    %ecx,%eax
  800376:	8b 00                	mov    (%eax),%eax
  800378:	39 c2                	cmp    %eax,%edx
  80037a:	7d cf                	jge    80034b <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  80037c:	eb 03                	jmp    800381 <QSort+0x5a>
  80037e:	ff 4d f0             	decl   -0x10(%ebp)
  800381:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800384:	3b 45 10             	cmp    0x10(%ebp),%eax
  800387:	7e 26                	jle    8003af <QSort+0x88>
  800389:	8b 45 10             	mov    0x10(%ebp),%eax
  80038c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800393:	8b 45 08             	mov    0x8(%ebp),%eax
  800396:	01 d0                	add    %edx,%eax
  800398:	8b 10                	mov    (%eax),%edx
  80039a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80039d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a7:	01 c8                	add    %ecx,%eax
  8003a9:	8b 00                	mov    (%eax),%eax
  8003ab:	39 c2                	cmp    %eax,%edx
  8003ad:	7e cf                	jle    80037e <QSort+0x57>

		if (i <= j)
  8003af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003b2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003b5:	7f 14                	jg     8003cb <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8003b7:	83 ec 04             	sub    $0x4,%esp
  8003ba:	ff 75 f0             	pushl  -0x10(%ebp)
  8003bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c0:	ff 75 08             	pushl  0x8(%ebp)
  8003c3:	e8 a9 00 00 00       	call   800471 <Swap>
  8003c8:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003d1:	0f 8e 77 ff ff ff    	jle    80034e <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  8003d7:	83 ec 04             	sub    $0x4,%esp
  8003da:	ff 75 f0             	pushl  -0x10(%ebp)
  8003dd:	ff 75 10             	pushl  0x10(%ebp)
  8003e0:	ff 75 08             	pushl  0x8(%ebp)
  8003e3:	e8 89 00 00 00       	call   800471 <Swap>
  8003e8:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ee:	48                   	dec    %eax
  8003ef:	50                   	push   %eax
  8003f0:	ff 75 10             	pushl  0x10(%ebp)
  8003f3:	ff 75 0c             	pushl  0xc(%ebp)
  8003f6:	ff 75 08             	pushl  0x8(%ebp)
  8003f9:	e8 29 ff ff ff       	call   800327 <QSort>
  8003fe:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800401:	ff 75 14             	pushl  0x14(%ebp)
  800404:	ff 75 f4             	pushl  -0xc(%ebp)
  800407:	ff 75 0c             	pushl  0xc(%ebp)
  80040a:	ff 75 08             	pushl  0x8(%ebp)
  80040d:	e8 15 ff ff ff       	call   800327 <QSort>
  800412:	83 c4 10             	add    $0x10,%esp
  800415:	eb 01                	jmp    800418 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800417:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800418:	c9                   	leave  
  800419:	c3                   	ret    

0080041a <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80041a:	55                   	push   %ebp
  80041b:	89 e5                	mov    %esp,%ebp
  80041d:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800420:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800427:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80042e:	eb 33                	jmp    800463 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800430:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800433:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	01 d0                	add    %edx,%eax
  80043f:	8b 10                	mov    (%eax),%edx
  800441:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800444:	40                   	inc    %eax
  800445:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	01 c8                	add    %ecx,%eax
  800451:	8b 00                	mov    (%eax),%eax
  800453:	39 c2                	cmp    %eax,%edx
  800455:	7e 09                	jle    800460 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800457:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80045e:	eb 0c                	jmp    80046c <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800460:	ff 45 f8             	incl   -0x8(%ebp)
  800463:	8b 45 0c             	mov    0xc(%ebp),%eax
  800466:	48                   	dec    %eax
  800467:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80046a:	7f c4                	jg     800430 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80046c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80046f:	c9                   	leave  
  800470:	c3                   	ret    

00800471 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800471:	55                   	push   %ebp
  800472:	89 e5                	mov    %esp,%ebp
  800474:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800477:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800481:	8b 45 08             	mov    0x8(%ebp),%eax
  800484:	01 d0                	add    %edx,%eax
  800486:	8b 00                	mov    (%eax),%eax
  800488:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  80048b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80048e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800495:	8b 45 08             	mov    0x8(%ebp),%eax
  800498:	01 c2                	add    %eax,%edx
  80049a:	8b 45 10             	mov    0x10(%ebp),%eax
  80049d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a7:	01 c8                	add    %ecx,%eax
  8004a9:	8b 00                	mov    (%eax),%eax
  8004ab:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8004ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ba:	01 c2                	add    %eax,%edx
  8004bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004bf:	89 02                	mov    %eax,(%edx)
}
  8004c1:	90                   	nop
  8004c2:	c9                   	leave  
  8004c3:	c3                   	ret    

008004c4 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004c4:	55                   	push   %ebp
  8004c5:	89 e5                	mov    %esp,%ebp
  8004c7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004d1:	eb 17                	jmp    8004ea <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8004d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e0:	01 c2                	add    %eax,%edx
  8004e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e5:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004e7:	ff 45 fc             	incl   -0x4(%ebp)
  8004ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ed:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004f0:	7c e1                	jl     8004d3 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004f2:	90                   	nop
  8004f3:	c9                   	leave  
  8004f4:	c3                   	ret    

008004f5 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004f5:	55                   	push   %ebp
  8004f6:	89 e5                	mov    %esp,%ebp
  8004f8:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800502:	eb 1b                	jmp    80051f <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800504:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800507:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050e:	8b 45 08             	mov    0x8(%ebp),%eax
  800511:	01 c2                	add    %eax,%edx
  800513:	8b 45 0c             	mov    0xc(%ebp),%eax
  800516:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800519:	48                   	dec    %eax
  80051a:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80051c:	ff 45 fc             	incl   -0x4(%ebp)
  80051f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800522:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800525:	7c dd                	jl     800504 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800527:	90                   	nop
  800528:	c9                   	leave  
  800529:	c3                   	ret    

0080052a <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80052a:	55                   	push   %ebp
  80052b:	89 e5                	mov    %esp,%ebp
  80052d:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800530:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800533:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800538:	f7 e9                	imul   %ecx
  80053a:	c1 f9 1f             	sar    $0x1f,%ecx
  80053d:	89 d0                	mov    %edx,%eax
  80053f:	29 c8                	sub    %ecx,%eax
  800541:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800544:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80054b:	eb 1e                	jmp    80056b <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80054d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800550:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800557:	8b 45 08             	mov    0x8(%ebp),%eax
  80055a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80055d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800560:	99                   	cltd   
  800561:	f7 7d f8             	idivl  -0x8(%ebp)
  800564:	89 d0                	mov    %edx,%eax
  800566:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800568:	ff 45 fc             	incl   -0x4(%ebp)
  80056b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80056e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800571:	7c da                	jl     80054d <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  800573:	90                   	nop
  800574:	c9                   	leave  
  800575:	c3                   	ret    

00800576 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800576:	55                   	push   %ebp
  800577:	89 e5                	mov    %esp,%ebp
  800579:	83 ec 18             	sub    $0x18,%esp
	int envID = sys_getenvid();
  80057c:	e8 2f 18 00 00       	call   801db0 <sys_getenvid>
  800581:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_waitSemaphore(envID, "IO.CS");
  800584:	83 ec 08             	sub    $0x8,%esp
  800587:	68 00 26 80 00       	push   $0x802600
  80058c:	ff 75 f0             	pushl  -0x10(%ebp)
  80058f:	e8 7d 1a 00 00       	call   802011 <sys_waitSemaphore>
  800594:	83 c4 10             	add    $0x10,%esp
		int i ;
		int NumsPerLine = 20 ;
  800597:	c7 45 ec 14 00 00 00 	movl   $0x14,-0x14(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  80059e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005a5:	eb 42                	jmp    8005e9 <PrintElements+0x73>
		{
			if (i%NumsPerLine == 0)
  8005a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005aa:	99                   	cltd   
  8005ab:	f7 7d ec             	idivl  -0x14(%ebp)
  8005ae:	89 d0                	mov    %edx,%eax
  8005b0:	85 c0                	test   %eax,%eax
  8005b2:	75 10                	jne    8005c4 <PrintElements+0x4e>
				cprintf("\n");
  8005b4:	83 ec 0c             	sub    $0xc,%esp
  8005b7:	68 92 27 80 00       	push   $0x802792
  8005bc:	e8 f0 04 00 00       	call   800ab1 <cprintf>
  8005c1:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  8005c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d1:	01 d0                	add    %edx,%eax
  8005d3:	8b 00                	mov    (%eax),%eax
  8005d5:	83 ec 08             	sub    $0x8,%esp
  8005d8:	50                   	push   %eax
  8005d9:	68 94 27 80 00       	push   $0x802794
  8005de:	e8 ce 04 00 00       	call   800ab1 <cprintf>
  8005e3:	83 c4 10             	add    $0x10,%esp
{
	int envID = sys_getenvid();
	sys_waitSemaphore(envID, "IO.CS");
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8005e6:	ff 45 f4             	incl   -0xc(%ebp)
  8005e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ec:	48                   	dec    %eax
  8005ed:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005f0:	7f b5                	jg     8005a7 <PrintElements+0x31>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  8005f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ff:	01 d0                	add    %edx,%eax
  800601:	8b 00                	mov    (%eax),%eax
  800603:	83 ec 08             	sub    $0x8,%esp
  800606:	50                   	push   %eax
  800607:	68 99 27 80 00       	push   $0x802799
  80060c:	e8 a0 04 00 00       	call   800ab1 <cprintf>
  800611:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(envID, "IO.CS");
  800614:	83 ec 08             	sub    $0x8,%esp
  800617:	68 00 26 80 00       	push   $0x802600
  80061c:	ff 75 f0             	pushl  -0x10(%ebp)
  80061f:	e8 0b 1a 00 00       	call   80202f <sys_signalSemaphore>
  800624:	83 c4 10             	add    $0x10,%esp
}
  800627:	90                   	nop
  800628:	c9                   	leave  
  800629:	c3                   	ret    

0080062a <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80062a:	55                   	push   %ebp
  80062b:	89 e5                	mov    %esp,%ebp
  80062d:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800630:	8b 45 08             	mov    0x8(%ebp),%eax
  800633:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800636:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80063a:	83 ec 0c             	sub    $0xc,%esp
  80063d:	50                   	push   %eax
  80063e:	e8 55 19 00 00       	call   801f98 <sys_cputc>
  800643:	83 c4 10             	add    $0x10,%esp
}
  800646:	90                   	nop
  800647:	c9                   	leave  
  800648:	c3                   	ret    

00800649 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800649:	55                   	push   %ebp
  80064a:	89 e5                	mov    %esp,%ebp
  80064c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80064f:	e8 10 19 00 00       	call   801f64 <sys_disable_interrupt>
	char c = ch;
  800654:	8b 45 08             	mov    0x8(%ebp),%eax
  800657:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80065a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80065e:	83 ec 0c             	sub    $0xc,%esp
  800661:	50                   	push   %eax
  800662:	e8 31 19 00 00       	call   801f98 <sys_cputc>
  800667:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80066a:	e8 0f 19 00 00       	call   801f7e <sys_enable_interrupt>
}
  80066f:	90                   	nop
  800670:	c9                   	leave  
  800671:	c3                   	ret    

00800672 <getchar>:

int
getchar(void)
{
  800672:	55                   	push   %ebp
  800673:	89 e5                	mov    %esp,%ebp
  800675:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800678:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80067f:	eb 08                	jmp    800689 <getchar+0x17>
	{
		c = sys_cgetc();
  800681:	e8 f6 16 00 00       	call   801d7c <sys_cgetc>
  800686:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800689:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80068d:	74 f2                	je     800681 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80068f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800692:	c9                   	leave  
  800693:	c3                   	ret    

00800694 <atomic_getchar>:

int
atomic_getchar(void)
{
  800694:	55                   	push   %ebp
  800695:	89 e5                	mov    %esp,%ebp
  800697:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80069a:	e8 c5 18 00 00       	call   801f64 <sys_disable_interrupt>
	int c=0;
  80069f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8006a6:	eb 08                	jmp    8006b0 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8006a8:	e8 cf 16 00 00       	call   801d7c <sys_cgetc>
  8006ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8006b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8006b4:	74 f2                	je     8006a8 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8006b6:	e8 c3 18 00 00       	call   801f7e <sys_enable_interrupt>
	return c;
  8006bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8006be:	c9                   	leave  
  8006bf:	c3                   	ret    

008006c0 <iscons>:

int iscons(int fdnum)
{
  8006c0:	55                   	push   %ebp
  8006c1:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8006c3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8006c8:	5d                   	pop    %ebp
  8006c9:	c3                   	ret    

008006ca <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006ca:	55                   	push   %ebp
  8006cb:	89 e5                	mov    %esp,%ebp
  8006cd:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006d0:	e8 f4 16 00 00       	call   801dc9 <sys_getenvindex>
  8006d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006db:	89 d0                	mov    %edx,%eax
  8006dd:	c1 e0 03             	shl    $0x3,%eax
  8006e0:	01 d0                	add    %edx,%eax
  8006e2:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8006e9:	01 c8                	add    %ecx,%eax
  8006eb:	01 c0                	add    %eax,%eax
  8006ed:	01 d0                	add    %edx,%eax
  8006ef:	01 c0                	add    %eax,%eax
  8006f1:	01 d0                	add    %edx,%eax
  8006f3:	89 c2                	mov    %eax,%edx
  8006f5:	c1 e2 05             	shl    $0x5,%edx
  8006f8:	29 c2                	sub    %eax,%edx
  8006fa:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800701:	89 c2                	mov    %eax,%edx
  800703:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800709:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80070e:	a1 24 30 80 00       	mov    0x803024,%eax
  800713:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800719:	84 c0                	test   %al,%al
  80071b:	74 0f                	je     80072c <libmain+0x62>
		binaryname = myEnv->prog_name;
  80071d:	a1 24 30 80 00       	mov    0x803024,%eax
  800722:	05 40 3c 01 00       	add    $0x13c40,%eax
  800727:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80072c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800730:	7e 0a                	jle    80073c <libmain+0x72>
		binaryname = argv[0];
  800732:	8b 45 0c             	mov    0xc(%ebp),%eax
  800735:	8b 00                	mov    (%eax),%eax
  800737:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80073c:	83 ec 08             	sub    $0x8,%esp
  80073f:	ff 75 0c             	pushl  0xc(%ebp)
  800742:	ff 75 08             	pushl  0x8(%ebp)
  800745:	e8 ee f8 ff ff       	call   800038 <_main>
  80074a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80074d:	e8 12 18 00 00       	call   801f64 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800752:	83 ec 0c             	sub    $0xc,%esp
  800755:	68 b8 27 80 00       	push   $0x8027b8
  80075a:	e8 52 03 00 00       	call   800ab1 <cprintf>
  80075f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800762:	a1 24 30 80 00       	mov    0x803024,%eax
  800767:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80076d:	a1 24 30 80 00       	mov    0x803024,%eax
  800772:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800778:	83 ec 04             	sub    $0x4,%esp
  80077b:	52                   	push   %edx
  80077c:	50                   	push   %eax
  80077d:	68 e0 27 80 00       	push   $0x8027e0
  800782:	e8 2a 03 00 00       	call   800ab1 <cprintf>
  800787:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80078a:	a1 24 30 80 00       	mov    0x803024,%eax
  80078f:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800795:	a1 24 30 80 00       	mov    0x803024,%eax
  80079a:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8007a0:	83 ec 04             	sub    $0x4,%esp
  8007a3:	52                   	push   %edx
  8007a4:	50                   	push   %eax
  8007a5:	68 08 28 80 00       	push   $0x802808
  8007aa:	e8 02 03 00 00       	call   800ab1 <cprintf>
  8007af:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8007b2:	a1 24 30 80 00       	mov    0x803024,%eax
  8007b7:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8007bd:	83 ec 08             	sub    $0x8,%esp
  8007c0:	50                   	push   %eax
  8007c1:	68 49 28 80 00       	push   $0x802849
  8007c6:	e8 e6 02 00 00       	call   800ab1 <cprintf>
  8007cb:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8007ce:	83 ec 0c             	sub    $0xc,%esp
  8007d1:	68 b8 27 80 00       	push   $0x8027b8
  8007d6:	e8 d6 02 00 00       	call   800ab1 <cprintf>
  8007db:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007de:	e8 9b 17 00 00       	call   801f7e <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007e3:	e8 19 00 00 00       	call   800801 <exit>
}
  8007e8:	90                   	nop
  8007e9:	c9                   	leave  
  8007ea:	c3                   	ret    

008007eb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007eb:	55                   	push   %ebp
  8007ec:	89 e5                	mov    %esp,%ebp
  8007ee:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007f1:	83 ec 0c             	sub    $0xc,%esp
  8007f4:	6a 00                	push   $0x0
  8007f6:	e8 9a 15 00 00       	call   801d95 <sys_env_destroy>
  8007fb:	83 c4 10             	add    $0x10,%esp
}
  8007fe:	90                   	nop
  8007ff:	c9                   	leave  
  800800:	c3                   	ret    

00800801 <exit>:

void
exit(void)
{
  800801:	55                   	push   %ebp
  800802:	89 e5                	mov    %esp,%ebp
  800804:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800807:	e8 ef 15 00 00       	call   801dfb <sys_env_exit>
}
  80080c:	90                   	nop
  80080d:	c9                   	leave  
  80080e:	c3                   	ret    

0080080f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80080f:	55                   	push   %ebp
  800810:	89 e5                	mov    %esp,%ebp
  800812:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800815:	8d 45 10             	lea    0x10(%ebp),%eax
  800818:	83 c0 04             	add    $0x4,%eax
  80081b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80081e:	a1 18 31 80 00       	mov    0x803118,%eax
  800823:	85 c0                	test   %eax,%eax
  800825:	74 16                	je     80083d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800827:	a1 18 31 80 00       	mov    0x803118,%eax
  80082c:	83 ec 08             	sub    $0x8,%esp
  80082f:	50                   	push   %eax
  800830:	68 60 28 80 00       	push   $0x802860
  800835:	e8 77 02 00 00       	call   800ab1 <cprintf>
  80083a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80083d:	a1 00 30 80 00       	mov    0x803000,%eax
  800842:	ff 75 0c             	pushl  0xc(%ebp)
  800845:	ff 75 08             	pushl  0x8(%ebp)
  800848:	50                   	push   %eax
  800849:	68 65 28 80 00       	push   $0x802865
  80084e:	e8 5e 02 00 00       	call   800ab1 <cprintf>
  800853:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800856:	8b 45 10             	mov    0x10(%ebp),%eax
  800859:	83 ec 08             	sub    $0x8,%esp
  80085c:	ff 75 f4             	pushl  -0xc(%ebp)
  80085f:	50                   	push   %eax
  800860:	e8 e1 01 00 00       	call   800a46 <vcprintf>
  800865:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800868:	83 ec 08             	sub    $0x8,%esp
  80086b:	6a 00                	push   $0x0
  80086d:	68 81 28 80 00       	push   $0x802881
  800872:	e8 cf 01 00 00       	call   800a46 <vcprintf>
  800877:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80087a:	e8 82 ff ff ff       	call   800801 <exit>

	// should not return here
	while (1) ;
  80087f:	eb fe                	jmp    80087f <_panic+0x70>

00800881 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800881:	55                   	push   %ebp
  800882:	89 e5                	mov    %esp,%ebp
  800884:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800887:	a1 24 30 80 00       	mov    0x803024,%eax
  80088c:	8b 50 74             	mov    0x74(%eax),%edx
  80088f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800892:	39 c2                	cmp    %eax,%edx
  800894:	74 14                	je     8008aa <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800896:	83 ec 04             	sub    $0x4,%esp
  800899:	68 84 28 80 00       	push   $0x802884
  80089e:	6a 26                	push   $0x26
  8008a0:	68 d0 28 80 00       	push   $0x8028d0
  8008a5:	e8 65 ff ff ff       	call   80080f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008b8:	e9 b6 00 00 00       	jmp    800973 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8008bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ca:	01 d0                	add    %edx,%eax
  8008cc:	8b 00                	mov    (%eax),%eax
  8008ce:	85 c0                	test   %eax,%eax
  8008d0:	75 08                	jne    8008da <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008d2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008d5:	e9 96 00 00 00       	jmp    800970 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8008da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008e1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008e8:	eb 5d                	jmp    800947 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008ea:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ef:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008f5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008f8:	c1 e2 04             	shl    $0x4,%edx
  8008fb:	01 d0                	add    %edx,%eax
  8008fd:	8a 40 04             	mov    0x4(%eax),%al
  800900:	84 c0                	test   %al,%al
  800902:	75 40                	jne    800944 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800904:	a1 24 30 80 00       	mov    0x803024,%eax
  800909:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80090f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800912:	c1 e2 04             	shl    $0x4,%edx
  800915:	01 d0                	add    %edx,%eax
  800917:	8b 00                	mov    (%eax),%eax
  800919:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80091c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80091f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800924:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800926:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800929:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800930:	8b 45 08             	mov    0x8(%ebp),%eax
  800933:	01 c8                	add    %ecx,%eax
  800935:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800937:	39 c2                	cmp    %eax,%edx
  800939:	75 09                	jne    800944 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80093b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800942:	eb 12                	jmp    800956 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800944:	ff 45 e8             	incl   -0x18(%ebp)
  800947:	a1 24 30 80 00       	mov    0x803024,%eax
  80094c:	8b 50 74             	mov    0x74(%eax),%edx
  80094f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800952:	39 c2                	cmp    %eax,%edx
  800954:	77 94                	ja     8008ea <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800956:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80095a:	75 14                	jne    800970 <CheckWSWithoutLastIndex+0xef>
			panic(
  80095c:	83 ec 04             	sub    $0x4,%esp
  80095f:	68 dc 28 80 00       	push   $0x8028dc
  800964:	6a 3a                	push   $0x3a
  800966:	68 d0 28 80 00       	push   $0x8028d0
  80096b:	e8 9f fe ff ff       	call   80080f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800970:	ff 45 f0             	incl   -0x10(%ebp)
  800973:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800976:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800979:	0f 8c 3e ff ff ff    	jl     8008bd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80097f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800986:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80098d:	eb 20                	jmp    8009af <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80098f:	a1 24 30 80 00       	mov    0x803024,%eax
  800994:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80099a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80099d:	c1 e2 04             	shl    $0x4,%edx
  8009a0:	01 d0                	add    %edx,%eax
  8009a2:	8a 40 04             	mov    0x4(%eax),%al
  8009a5:	3c 01                	cmp    $0x1,%al
  8009a7:	75 03                	jne    8009ac <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8009a9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009ac:	ff 45 e0             	incl   -0x20(%ebp)
  8009af:	a1 24 30 80 00       	mov    0x803024,%eax
  8009b4:	8b 50 74             	mov    0x74(%eax),%edx
  8009b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009ba:	39 c2                	cmp    %eax,%edx
  8009bc:	77 d1                	ja     80098f <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009c1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009c4:	74 14                	je     8009da <CheckWSWithoutLastIndex+0x159>
		panic(
  8009c6:	83 ec 04             	sub    $0x4,%esp
  8009c9:	68 30 29 80 00       	push   $0x802930
  8009ce:	6a 44                	push   $0x44
  8009d0:	68 d0 28 80 00       	push   $0x8028d0
  8009d5:	e8 35 fe ff ff       	call   80080f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009da:	90                   	nop
  8009db:	c9                   	leave  
  8009dc:	c3                   	ret    

008009dd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009dd:	55                   	push   %ebp
  8009de:	89 e5                	mov    %esp,%ebp
  8009e0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e6:	8b 00                	mov    (%eax),%eax
  8009e8:	8d 48 01             	lea    0x1(%eax),%ecx
  8009eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ee:	89 0a                	mov    %ecx,(%edx)
  8009f0:	8b 55 08             	mov    0x8(%ebp),%edx
  8009f3:	88 d1                	mov    %dl,%cl
  8009f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f8:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ff:	8b 00                	mov    (%eax),%eax
  800a01:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a06:	75 2c                	jne    800a34 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a08:	a0 28 30 80 00       	mov    0x803028,%al
  800a0d:	0f b6 c0             	movzbl %al,%eax
  800a10:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a13:	8b 12                	mov    (%edx),%edx
  800a15:	89 d1                	mov    %edx,%ecx
  800a17:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1a:	83 c2 08             	add    $0x8,%edx
  800a1d:	83 ec 04             	sub    $0x4,%esp
  800a20:	50                   	push   %eax
  800a21:	51                   	push   %ecx
  800a22:	52                   	push   %edx
  800a23:	e8 2b 13 00 00       	call   801d53 <sys_cputs>
  800a28:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a37:	8b 40 04             	mov    0x4(%eax),%eax
  800a3a:	8d 50 01             	lea    0x1(%eax),%edx
  800a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a40:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a43:	90                   	nop
  800a44:	c9                   	leave  
  800a45:	c3                   	ret    

00800a46 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a46:	55                   	push   %ebp
  800a47:	89 e5                	mov    %esp,%ebp
  800a49:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a4f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a56:	00 00 00 
	b.cnt = 0;
  800a59:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a60:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a63:	ff 75 0c             	pushl  0xc(%ebp)
  800a66:	ff 75 08             	pushl  0x8(%ebp)
  800a69:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a6f:	50                   	push   %eax
  800a70:	68 dd 09 80 00       	push   $0x8009dd
  800a75:	e8 11 02 00 00       	call   800c8b <vprintfmt>
  800a7a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a7d:	a0 28 30 80 00       	mov    0x803028,%al
  800a82:	0f b6 c0             	movzbl %al,%eax
  800a85:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a8b:	83 ec 04             	sub    $0x4,%esp
  800a8e:	50                   	push   %eax
  800a8f:	52                   	push   %edx
  800a90:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a96:	83 c0 08             	add    $0x8,%eax
  800a99:	50                   	push   %eax
  800a9a:	e8 b4 12 00 00       	call   801d53 <sys_cputs>
  800a9f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800aa2:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800aa9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800aaf:	c9                   	leave  
  800ab0:	c3                   	ret    

00800ab1 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ab1:	55                   	push   %ebp
  800ab2:	89 e5                	mov    %esp,%ebp
  800ab4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ab7:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800abe:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ac1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac7:	83 ec 08             	sub    $0x8,%esp
  800aca:	ff 75 f4             	pushl  -0xc(%ebp)
  800acd:	50                   	push   %eax
  800ace:	e8 73 ff ff ff       	call   800a46 <vcprintf>
  800ad3:	83 c4 10             	add    $0x10,%esp
  800ad6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ad9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800adc:	c9                   	leave  
  800add:	c3                   	ret    

00800ade <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ade:	55                   	push   %ebp
  800adf:	89 e5                	mov    %esp,%ebp
  800ae1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ae4:	e8 7b 14 00 00       	call   801f64 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800ae9:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aef:	8b 45 08             	mov    0x8(%ebp),%eax
  800af2:	83 ec 08             	sub    $0x8,%esp
  800af5:	ff 75 f4             	pushl  -0xc(%ebp)
  800af8:	50                   	push   %eax
  800af9:	e8 48 ff ff ff       	call   800a46 <vcprintf>
  800afe:	83 c4 10             	add    $0x10,%esp
  800b01:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b04:	e8 75 14 00 00       	call   801f7e <sys_enable_interrupt>
	return cnt;
  800b09:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b0c:	c9                   	leave  
  800b0d:	c3                   	ret    

00800b0e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b0e:	55                   	push   %ebp
  800b0f:	89 e5                	mov    %esp,%ebp
  800b11:	53                   	push   %ebx
  800b12:	83 ec 14             	sub    $0x14,%esp
  800b15:	8b 45 10             	mov    0x10(%ebp),%eax
  800b18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1b:	8b 45 14             	mov    0x14(%ebp),%eax
  800b1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b21:	8b 45 18             	mov    0x18(%ebp),%eax
  800b24:	ba 00 00 00 00       	mov    $0x0,%edx
  800b29:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b2c:	77 55                	ja     800b83 <printnum+0x75>
  800b2e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b31:	72 05                	jb     800b38 <printnum+0x2a>
  800b33:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b36:	77 4b                	ja     800b83 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b38:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b3b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b3e:	8b 45 18             	mov    0x18(%ebp),%eax
  800b41:	ba 00 00 00 00       	mov    $0x0,%edx
  800b46:	52                   	push   %edx
  800b47:	50                   	push   %eax
  800b48:	ff 75 f4             	pushl  -0xc(%ebp)
  800b4b:	ff 75 f0             	pushl  -0x10(%ebp)
  800b4e:	e8 35 18 00 00       	call   802388 <__udivdi3>
  800b53:	83 c4 10             	add    $0x10,%esp
  800b56:	83 ec 04             	sub    $0x4,%esp
  800b59:	ff 75 20             	pushl  0x20(%ebp)
  800b5c:	53                   	push   %ebx
  800b5d:	ff 75 18             	pushl  0x18(%ebp)
  800b60:	52                   	push   %edx
  800b61:	50                   	push   %eax
  800b62:	ff 75 0c             	pushl  0xc(%ebp)
  800b65:	ff 75 08             	pushl  0x8(%ebp)
  800b68:	e8 a1 ff ff ff       	call   800b0e <printnum>
  800b6d:	83 c4 20             	add    $0x20,%esp
  800b70:	eb 1a                	jmp    800b8c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b72:	83 ec 08             	sub    $0x8,%esp
  800b75:	ff 75 0c             	pushl  0xc(%ebp)
  800b78:	ff 75 20             	pushl  0x20(%ebp)
  800b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7e:	ff d0                	call   *%eax
  800b80:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b83:	ff 4d 1c             	decl   0x1c(%ebp)
  800b86:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b8a:	7f e6                	jg     800b72 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b8c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b8f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b94:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b97:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b9a:	53                   	push   %ebx
  800b9b:	51                   	push   %ecx
  800b9c:	52                   	push   %edx
  800b9d:	50                   	push   %eax
  800b9e:	e8 f5 18 00 00       	call   802498 <__umoddi3>
  800ba3:	83 c4 10             	add    $0x10,%esp
  800ba6:	05 94 2b 80 00       	add    $0x802b94,%eax
  800bab:	8a 00                	mov    (%eax),%al
  800bad:	0f be c0             	movsbl %al,%eax
  800bb0:	83 ec 08             	sub    $0x8,%esp
  800bb3:	ff 75 0c             	pushl  0xc(%ebp)
  800bb6:	50                   	push   %eax
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	ff d0                	call   *%eax
  800bbc:	83 c4 10             	add    $0x10,%esp
}
  800bbf:	90                   	nop
  800bc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bc3:	c9                   	leave  
  800bc4:	c3                   	ret    

00800bc5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800bc5:	55                   	push   %ebp
  800bc6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bc8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bcc:	7e 1c                	jle    800bea <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bce:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd1:	8b 00                	mov    (%eax),%eax
  800bd3:	8d 50 08             	lea    0x8(%eax),%edx
  800bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd9:	89 10                	mov    %edx,(%eax)
  800bdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bde:	8b 00                	mov    (%eax),%eax
  800be0:	83 e8 08             	sub    $0x8,%eax
  800be3:	8b 50 04             	mov    0x4(%eax),%edx
  800be6:	8b 00                	mov    (%eax),%eax
  800be8:	eb 40                	jmp    800c2a <getuint+0x65>
	else if (lflag)
  800bea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bee:	74 1e                	je     800c0e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf3:	8b 00                	mov    (%eax),%eax
  800bf5:	8d 50 04             	lea    0x4(%eax),%edx
  800bf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfb:	89 10                	mov    %edx,(%eax)
  800bfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800c00:	8b 00                	mov    (%eax),%eax
  800c02:	83 e8 04             	sub    $0x4,%eax
  800c05:	8b 00                	mov    (%eax),%eax
  800c07:	ba 00 00 00 00       	mov    $0x0,%edx
  800c0c:	eb 1c                	jmp    800c2a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c11:	8b 00                	mov    (%eax),%eax
  800c13:	8d 50 04             	lea    0x4(%eax),%edx
  800c16:	8b 45 08             	mov    0x8(%ebp),%eax
  800c19:	89 10                	mov    %edx,(%eax)
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	8b 00                	mov    (%eax),%eax
  800c20:	83 e8 04             	sub    $0x4,%eax
  800c23:	8b 00                	mov    (%eax),%eax
  800c25:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c2a:	5d                   	pop    %ebp
  800c2b:	c3                   	ret    

00800c2c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c2c:	55                   	push   %ebp
  800c2d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c2f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c33:	7e 1c                	jle    800c51 <getint+0x25>
		return va_arg(*ap, long long);
  800c35:	8b 45 08             	mov    0x8(%ebp),%eax
  800c38:	8b 00                	mov    (%eax),%eax
  800c3a:	8d 50 08             	lea    0x8(%eax),%edx
  800c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c40:	89 10                	mov    %edx,(%eax)
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	8b 00                	mov    (%eax),%eax
  800c47:	83 e8 08             	sub    $0x8,%eax
  800c4a:	8b 50 04             	mov    0x4(%eax),%edx
  800c4d:	8b 00                	mov    (%eax),%eax
  800c4f:	eb 38                	jmp    800c89 <getint+0x5d>
	else if (lflag)
  800c51:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c55:	74 1a                	je     800c71 <getint+0x45>
		return va_arg(*ap, long);
  800c57:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5a:	8b 00                	mov    (%eax),%eax
  800c5c:	8d 50 04             	lea    0x4(%eax),%edx
  800c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c62:	89 10                	mov    %edx,(%eax)
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	8b 00                	mov    (%eax),%eax
  800c69:	83 e8 04             	sub    $0x4,%eax
  800c6c:	8b 00                	mov    (%eax),%eax
  800c6e:	99                   	cltd   
  800c6f:	eb 18                	jmp    800c89 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c71:	8b 45 08             	mov    0x8(%ebp),%eax
  800c74:	8b 00                	mov    (%eax),%eax
  800c76:	8d 50 04             	lea    0x4(%eax),%edx
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	89 10                	mov    %edx,(%eax)
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	8b 00                	mov    (%eax),%eax
  800c83:	83 e8 04             	sub    $0x4,%eax
  800c86:	8b 00                	mov    (%eax),%eax
  800c88:	99                   	cltd   
}
  800c89:	5d                   	pop    %ebp
  800c8a:	c3                   	ret    

00800c8b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c8b:	55                   	push   %ebp
  800c8c:	89 e5                	mov    %esp,%ebp
  800c8e:	56                   	push   %esi
  800c8f:	53                   	push   %ebx
  800c90:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c93:	eb 17                	jmp    800cac <vprintfmt+0x21>
			if (ch == '\0')
  800c95:	85 db                	test   %ebx,%ebx
  800c97:	0f 84 af 03 00 00    	je     80104c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c9d:	83 ec 08             	sub    $0x8,%esp
  800ca0:	ff 75 0c             	pushl  0xc(%ebp)
  800ca3:	53                   	push   %ebx
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	ff d0                	call   *%eax
  800ca9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800cac:	8b 45 10             	mov    0x10(%ebp),%eax
  800caf:	8d 50 01             	lea    0x1(%eax),%edx
  800cb2:	89 55 10             	mov    %edx,0x10(%ebp)
  800cb5:	8a 00                	mov    (%eax),%al
  800cb7:	0f b6 d8             	movzbl %al,%ebx
  800cba:	83 fb 25             	cmp    $0x25,%ebx
  800cbd:	75 d6                	jne    800c95 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800cbf:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800cc3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800cca:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cd1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cd8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800cdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce2:	8d 50 01             	lea    0x1(%eax),%edx
  800ce5:	89 55 10             	mov    %edx,0x10(%ebp)
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	0f b6 d8             	movzbl %al,%ebx
  800ced:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800cf0:	83 f8 55             	cmp    $0x55,%eax
  800cf3:	0f 87 2b 03 00 00    	ja     801024 <vprintfmt+0x399>
  800cf9:	8b 04 85 b8 2b 80 00 	mov    0x802bb8(,%eax,4),%eax
  800d00:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d02:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d06:	eb d7                	jmp    800cdf <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d08:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d0c:	eb d1                	jmp    800cdf <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d0e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d15:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d18:	89 d0                	mov    %edx,%eax
  800d1a:	c1 e0 02             	shl    $0x2,%eax
  800d1d:	01 d0                	add    %edx,%eax
  800d1f:	01 c0                	add    %eax,%eax
  800d21:	01 d8                	add    %ebx,%eax
  800d23:	83 e8 30             	sub    $0x30,%eax
  800d26:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d29:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d31:	83 fb 2f             	cmp    $0x2f,%ebx
  800d34:	7e 3e                	jle    800d74 <vprintfmt+0xe9>
  800d36:	83 fb 39             	cmp    $0x39,%ebx
  800d39:	7f 39                	jg     800d74 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d3b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d3e:	eb d5                	jmp    800d15 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d40:	8b 45 14             	mov    0x14(%ebp),%eax
  800d43:	83 c0 04             	add    $0x4,%eax
  800d46:	89 45 14             	mov    %eax,0x14(%ebp)
  800d49:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4c:	83 e8 04             	sub    $0x4,%eax
  800d4f:	8b 00                	mov    (%eax),%eax
  800d51:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d54:	eb 1f                	jmp    800d75 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d56:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d5a:	79 83                	jns    800cdf <vprintfmt+0x54>
				width = 0;
  800d5c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d63:	e9 77 ff ff ff       	jmp    800cdf <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d68:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d6f:	e9 6b ff ff ff       	jmp    800cdf <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d74:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d75:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d79:	0f 89 60 ff ff ff    	jns    800cdf <vprintfmt+0x54>
				width = precision, precision = -1;
  800d7f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d82:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d85:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d8c:	e9 4e ff ff ff       	jmp    800cdf <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d91:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d94:	e9 46 ff ff ff       	jmp    800cdf <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d99:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9c:	83 c0 04             	add    $0x4,%eax
  800d9f:	89 45 14             	mov    %eax,0x14(%ebp)
  800da2:	8b 45 14             	mov    0x14(%ebp),%eax
  800da5:	83 e8 04             	sub    $0x4,%eax
  800da8:	8b 00                	mov    (%eax),%eax
  800daa:	83 ec 08             	sub    $0x8,%esp
  800dad:	ff 75 0c             	pushl  0xc(%ebp)
  800db0:	50                   	push   %eax
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
  800db4:	ff d0                	call   *%eax
  800db6:	83 c4 10             	add    $0x10,%esp
			break;
  800db9:	e9 89 02 00 00       	jmp    801047 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800dbe:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc1:	83 c0 04             	add    $0x4,%eax
  800dc4:	89 45 14             	mov    %eax,0x14(%ebp)
  800dc7:	8b 45 14             	mov    0x14(%ebp),%eax
  800dca:	83 e8 04             	sub    $0x4,%eax
  800dcd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dcf:	85 db                	test   %ebx,%ebx
  800dd1:	79 02                	jns    800dd5 <vprintfmt+0x14a>
				err = -err;
  800dd3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800dd5:	83 fb 64             	cmp    $0x64,%ebx
  800dd8:	7f 0b                	jg     800de5 <vprintfmt+0x15a>
  800dda:	8b 34 9d 00 2a 80 00 	mov    0x802a00(,%ebx,4),%esi
  800de1:	85 f6                	test   %esi,%esi
  800de3:	75 19                	jne    800dfe <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800de5:	53                   	push   %ebx
  800de6:	68 a5 2b 80 00       	push   $0x802ba5
  800deb:	ff 75 0c             	pushl  0xc(%ebp)
  800dee:	ff 75 08             	pushl  0x8(%ebp)
  800df1:	e8 5e 02 00 00       	call   801054 <printfmt>
  800df6:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800df9:	e9 49 02 00 00       	jmp    801047 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800dfe:	56                   	push   %esi
  800dff:	68 ae 2b 80 00       	push   $0x802bae
  800e04:	ff 75 0c             	pushl  0xc(%ebp)
  800e07:	ff 75 08             	pushl  0x8(%ebp)
  800e0a:	e8 45 02 00 00       	call   801054 <printfmt>
  800e0f:	83 c4 10             	add    $0x10,%esp
			break;
  800e12:	e9 30 02 00 00       	jmp    801047 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e17:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1a:	83 c0 04             	add    $0x4,%eax
  800e1d:	89 45 14             	mov    %eax,0x14(%ebp)
  800e20:	8b 45 14             	mov    0x14(%ebp),%eax
  800e23:	83 e8 04             	sub    $0x4,%eax
  800e26:	8b 30                	mov    (%eax),%esi
  800e28:	85 f6                	test   %esi,%esi
  800e2a:	75 05                	jne    800e31 <vprintfmt+0x1a6>
				p = "(null)";
  800e2c:	be b1 2b 80 00       	mov    $0x802bb1,%esi
			if (width > 0 && padc != '-')
  800e31:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e35:	7e 6d                	jle    800ea4 <vprintfmt+0x219>
  800e37:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e3b:	74 67                	je     800ea4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e3d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e40:	83 ec 08             	sub    $0x8,%esp
  800e43:	50                   	push   %eax
  800e44:	56                   	push   %esi
  800e45:	e8 12 05 00 00       	call   80135c <strnlen>
  800e4a:	83 c4 10             	add    $0x10,%esp
  800e4d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e50:	eb 16                	jmp    800e68 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e52:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e56:	83 ec 08             	sub    $0x8,%esp
  800e59:	ff 75 0c             	pushl  0xc(%ebp)
  800e5c:	50                   	push   %eax
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	ff d0                	call   *%eax
  800e62:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e65:	ff 4d e4             	decl   -0x1c(%ebp)
  800e68:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e6c:	7f e4                	jg     800e52 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e6e:	eb 34                	jmp    800ea4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e70:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e74:	74 1c                	je     800e92 <vprintfmt+0x207>
  800e76:	83 fb 1f             	cmp    $0x1f,%ebx
  800e79:	7e 05                	jle    800e80 <vprintfmt+0x1f5>
  800e7b:	83 fb 7e             	cmp    $0x7e,%ebx
  800e7e:	7e 12                	jle    800e92 <vprintfmt+0x207>
					putch('?', putdat);
  800e80:	83 ec 08             	sub    $0x8,%esp
  800e83:	ff 75 0c             	pushl  0xc(%ebp)
  800e86:	6a 3f                	push   $0x3f
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	ff d0                	call   *%eax
  800e8d:	83 c4 10             	add    $0x10,%esp
  800e90:	eb 0f                	jmp    800ea1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e92:	83 ec 08             	sub    $0x8,%esp
  800e95:	ff 75 0c             	pushl  0xc(%ebp)
  800e98:	53                   	push   %ebx
  800e99:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9c:	ff d0                	call   *%eax
  800e9e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ea1:	ff 4d e4             	decl   -0x1c(%ebp)
  800ea4:	89 f0                	mov    %esi,%eax
  800ea6:	8d 70 01             	lea    0x1(%eax),%esi
  800ea9:	8a 00                	mov    (%eax),%al
  800eab:	0f be d8             	movsbl %al,%ebx
  800eae:	85 db                	test   %ebx,%ebx
  800eb0:	74 24                	je     800ed6 <vprintfmt+0x24b>
  800eb2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eb6:	78 b8                	js     800e70 <vprintfmt+0x1e5>
  800eb8:	ff 4d e0             	decl   -0x20(%ebp)
  800ebb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ebf:	79 af                	jns    800e70 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ec1:	eb 13                	jmp    800ed6 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ec3:	83 ec 08             	sub    $0x8,%esp
  800ec6:	ff 75 0c             	pushl  0xc(%ebp)
  800ec9:	6a 20                	push   $0x20
  800ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ece:	ff d0                	call   *%eax
  800ed0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ed3:	ff 4d e4             	decl   -0x1c(%ebp)
  800ed6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800eda:	7f e7                	jg     800ec3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800edc:	e9 66 01 00 00       	jmp    801047 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ee1:	83 ec 08             	sub    $0x8,%esp
  800ee4:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee7:	8d 45 14             	lea    0x14(%ebp),%eax
  800eea:	50                   	push   %eax
  800eeb:	e8 3c fd ff ff       	call   800c2c <getint>
  800ef0:	83 c4 10             	add    $0x10,%esp
  800ef3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ef9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800efc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eff:	85 d2                	test   %edx,%edx
  800f01:	79 23                	jns    800f26 <vprintfmt+0x29b>
				putch('-', putdat);
  800f03:	83 ec 08             	sub    $0x8,%esp
  800f06:	ff 75 0c             	pushl  0xc(%ebp)
  800f09:	6a 2d                	push   $0x2d
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	ff d0                	call   *%eax
  800f10:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f16:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f19:	f7 d8                	neg    %eax
  800f1b:	83 d2 00             	adc    $0x0,%edx
  800f1e:	f7 da                	neg    %edx
  800f20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f23:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f26:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f2d:	e9 bc 00 00 00       	jmp    800fee <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f32:	83 ec 08             	sub    $0x8,%esp
  800f35:	ff 75 e8             	pushl  -0x18(%ebp)
  800f38:	8d 45 14             	lea    0x14(%ebp),%eax
  800f3b:	50                   	push   %eax
  800f3c:	e8 84 fc ff ff       	call   800bc5 <getuint>
  800f41:	83 c4 10             	add    $0x10,%esp
  800f44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f47:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f4a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f51:	e9 98 00 00 00       	jmp    800fee <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f56:	83 ec 08             	sub    $0x8,%esp
  800f59:	ff 75 0c             	pushl  0xc(%ebp)
  800f5c:	6a 58                	push   $0x58
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	ff d0                	call   *%eax
  800f63:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f66:	83 ec 08             	sub    $0x8,%esp
  800f69:	ff 75 0c             	pushl  0xc(%ebp)
  800f6c:	6a 58                	push   $0x58
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	ff d0                	call   *%eax
  800f73:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f76:	83 ec 08             	sub    $0x8,%esp
  800f79:	ff 75 0c             	pushl  0xc(%ebp)
  800f7c:	6a 58                	push   $0x58
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f81:	ff d0                	call   *%eax
  800f83:	83 c4 10             	add    $0x10,%esp
			break;
  800f86:	e9 bc 00 00 00       	jmp    801047 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f8b:	83 ec 08             	sub    $0x8,%esp
  800f8e:	ff 75 0c             	pushl  0xc(%ebp)
  800f91:	6a 30                	push   $0x30
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	ff d0                	call   *%eax
  800f98:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f9b:	83 ec 08             	sub    $0x8,%esp
  800f9e:	ff 75 0c             	pushl  0xc(%ebp)
  800fa1:	6a 78                	push   $0x78
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	ff d0                	call   *%eax
  800fa8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fab:	8b 45 14             	mov    0x14(%ebp),%eax
  800fae:	83 c0 04             	add    $0x4,%eax
  800fb1:	89 45 14             	mov    %eax,0x14(%ebp)
  800fb4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb7:	83 e8 04             	sub    $0x4,%eax
  800fba:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fbf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fc6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fcd:	eb 1f                	jmp    800fee <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fcf:	83 ec 08             	sub    $0x8,%esp
  800fd2:	ff 75 e8             	pushl  -0x18(%ebp)
  800fd5:	8d 45 14             	lea    0x14(%ebp),%eax
  800fd8:	50                   	push   %eax
  800fd9:	e8 e7 fb ff ff       	call   800bc5 <getuint>
  800fde:	83 c4 10             	add    $0x10,%esp
  800fe1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fe7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800fee:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ff2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ff5:	83 ec 04             	sub    $0x4,%esp
  800ff8:	52                   	push   %edx
  800ff9:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ffc:	50                   	push   %eax
  800ffd:	ff 75 f4             	pushl  -0xc(%ebp)
  801000:	ff 75 f0             	pushl  -0x10(%ebp)
  801003:	ff 75 0c             	pushl  0xc(%ebp)
  801006:	ff 75 08             	pushl  0x8(%ebp)
  801009:	e8 00 fb ff ff       	call   800b0e <printnum>
  80100e:	83 c4 20             	add    $0x20,%esp
			break;
  801011:	eb 34                	jmp    801047 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801013:	83 ec 08             	sub    $0x8,%esp
  801016:	ff 75 0c             	pushl  0xc(%ebp)
  801019:	53                   	push   %ebx
  80101a:	8b 45 08             	mov    0x8(%ebp),%eax
  80101d:	ff d0                	call   *%eax
  80101f:	83 c4 10             	add    $0x10,%esp
			break;
  801022:	eb 23                	jmp    801047 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801024:	83 ec 08             	sub    $0x8,%esp
  801027:	ff 75 0c             	pushl  0xc(%ebp)
  80102a:	6a 25                	push   $0x25
  80102c:	8b 45 08             	mov    0x8(%ebp),%eax
  80102f:	ff d0                	call   *%eax
  801031:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801034:	ff 4d 10             	decl   0x10(%ebp)
  801037:	eb 03                	jmp    80103c <vprintfmt+0x3b1>
  801039:	ff 4d 10             	decl   0x10(%ebp)
  80103c:	8b 45 10             	mov    0x10(%ebp),%eax
  80103f:	48                   	dec    %eax
  801040:	8a 00                	mov    (%eax),%al
  801042:	3c 25                	cmp    $0x25,%al
  801044:	75 f3                	jne    801039 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801046:	90                   	nop
		}
	}
  801047:	e9 47 fc ff ff       	jmp    800c93 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80104c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80104d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801050:	5b                   	pop    %ebx
  801051:	5e                   	pop    %esi
  801052:	5d                   	pop    %ebp
  801053:	c3                   	ret    

00801054 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801054:	55                   	push   %ebp
  801055:	89 e5                	mov    %esp,%ebp
  801057:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80105a:	8d 45 10             	lea    0x10(%ebp),%eax
  80105d:	83 c0 04             	add    $0x4,%eax
  801060:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801063:	8b 45 10             	mov    0x10(%ebp),%eax
  801066:	ff 75 f4             	pushl  -0xc(%ebp)
  801069:	50                   	push   %eax
  80106a:	ff 75 0c             	pushl  0xc(%ebp)
  80106d:	ff 75 08             	pushl  0x8(%ebp)
  801070:	e8 16 fc ff ff       	call   800c8b <vprintfmt>
  801075:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801078:	90                   	nop
  801079:	c9                   	leave  
  80107a:	c3                   	ret    

0080107b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80107b:	55                   	push   %ebp
  80107c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80107e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801081:	8b 40 08             	mov    0x8(%eax),%eax
  801084:	8d 50 01             	lea    0x1(%eax),%edx
  801087:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80108d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801090:	8b 10                	mov    (%eax),%edx
  801092:	8b 45 0c             	mov    0xc(%ebp),%eax
  801095:	8b 40 04             	mov    0x4(%eax),%eax
  801098:	39 c2                	cmp    %eax,%edx
  80109a:	73 12                	jae    8010ae <sprintputch+0x33>
		*b->buf++ = ch;
  80109c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109f:	8b 00                	mov    (%eax),%eax
  8010a1:	8d 48 01             	lea    0x1(%eax),%ecx
  8010a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a7:	89 0a                	mov    %ecx,(%edx)
  8010a9:	8b 55 08             	mov    0x8(%ebp),%edx
  8010ac:	88 10                	mov    %dl,(%eax)
}
  8010ae:	90                   	nop
  8010af:	5d                   	pop    %ebp
  8010b0:	c3                   	ret    

008010b1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010b1:	55                   	push   %ebp
  8010b2:	89 e5                	mov    %esp,%ebp
  8010b4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c6:	01 d0                	add    %edx,%eax
  8010c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010d2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010d6:	74 06                	je     8010de <vsnprintf+0x2d>
  8010d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010dc:	7f 07                	jg     8010e5 <vsnprintf+0x34>
		return -E_INVAL;
  8010de:	b8 03 00 00 00       	mov    $0x3,%eax
  8010e3:	eb 20                	jmp    801105 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010e5:	ff 75 14             	pushl  0x14(%ebp)
  8010e8:	ff 75 10             	pushl  0x10(%ebp)
  8010eb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010ee:	50                   	push   %eax
  8010ef:	68 7b 10 80 00       	push   $0x80107b
  8010f4:	e8 92 fb ff ff       	call   800c8b <vprintfmt>
  8010f9:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010ff:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801102:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801105:	c9                   	leave  
  801106:	c3                   	ret    

00801107 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801107:	55                   	push   %ebp
  801108:	89 e5                	mov    %esp,%ebp
  80110a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80110d:	8d 45 10             	lea    0x10(%ebp),%eax
  801110:	83 c0 04             	add    $0x4,%eax
  801113:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801116:	8b 45 10             	mov    0x10(%ebp),%eax
  801119:	ff 75 f4             	pushl  -0xc(%ebp)
  80111c:	50                   	push   %eax
  80111d:	ff 75 0c             	pushl  0xc(%ebp)
  801120:	ff 75 08             	pushl  0x8(%ebp)
  801123:	e8 89 ff ff ff       	call   8010b1 <vsnprintf>
  801128:	83 c4 10             	add    $0x10,%esp
  80112b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80112e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801131:	c9                   	leave  
  801132:	c3                   	ret    

00801133 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801133:	55                   	push   %ebp
  801134:	89 e5                	mov    %esp,%ebp
  801136:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801139:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80113d:	74 13                	je     801152 <readline+0x1f>
		cprintf("%s", prompt);
  80113f:	83 ec 08             	sub    $0x8,%esp
  801142:	ff 75 08             	pushl  0x8(%ebp)
  801145:	68 10 2d 80 00       	push   $0x802d10
  80114a:	e8 62 f9 ff ff       	call   800ab1 <cprintf>
  80114f:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801152:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801159:	83 ec 0c             	sub    $0xc,%esp
  80115c:	6a 00                	push   $0x0
  80115e:	e8 5d f5 ff ff       	call   8006c0 <iscons>
  801163:	83 c4 10             	add    $0x10,%esp
  801166:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801169:	e8 04 f5 ff ff       	call   800672 <getchar>
  80116e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801171:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801175:	79 22                	jns    801199 <readline+0x66>
			if (c != -E_EOF)
  801177:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80117b:	0f 84 ad 00 00 00    	je     80122e <readline+0xfb>
				cprintf("read error: %e\n", c);
  801181:	83 ec 08             	sub    $0x8,%esp
  801184:	ff 75 ec             	pushl  -0x14(%ebp)
  801187:	68 13 2d 80 00       	push   $0x802d13
  80118c:	e8 20 f9 ff ff       	call   800ab1 <cprintf>
  801191:	83 c4 10             	add    $0x10,%esp
			return;
  801194:	e9 95 00 00 00       	jmp    80122e <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801199:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80119d:	7e 34                	jle    8011d3 <readline+0xa0>
  80119f:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011a6:	7f 2b                	jg     8011d3 <readline+0xa0>
			if (echoing)
  8011a8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011ac:	74 0e                	je     8011bc <readline+0x89>
				cputchar(c);
  8011ae:	83 ec 0c             	sub    $0xc,%esp
  8011b1:	ff 75 ec             	pushl  -0x14(%ebp)
  8011b4:	e8 71 f4 ff ff       	call   80062a <cputchar>
  8011b9:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011bf:	8d 50 01             	lea    0x1(%eax),%edx
  8011c2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011c5:	89 c2                	mov    %eax,%edx
  8011c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ca:	01 d0                	add    %edx,%eax
  8011cc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011cf:	88 10                	mov    %dl,(%eax)
  8011d1:	eb 56                	jmp    801229 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8011d3:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011d7:	75 1f                	jne    8011f8 <readline+0xc5>
  8011d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011dd:	7e 19                	jle    8011f8 <readline+0xc5>
			if (echoing)
  8011df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011e3:	74 0e                	je     8011f3 <readline+0xc0>
				cputchar(c);
  8011e5:	83 ec 0c             	sub    $0xc,%esp
  8011e8:	ff 75 ec             	pushl  -0x14(%ebp)
  8011eb:	e8 3a f4 ff ff       	call   80062a <cputchar>
  8011f0:	83 c4 10             	add    $0x10,%esp

			i--;
  8011f3:	ff 4d f4             	decl   -0xc(%ebp)
  8011f6:	eb 31                	jmp    801229 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011f8:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011fc:	74 0a                	je     801208 <readline+0xd5>
  8011fe:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801202:	0f 85 61 ff ff ff    	jne    801169 <readline+0x36>
			if (echoing)
  801208:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80120c:	74 0e                	je     80121c <readline+0xe9>
				cputchar(c);
  80120e:	83 ec 0c             	sub    $0xc,%esp
  801211:	ff 75 ec             	pushl  -0x14(%ebp)
  801214:	e8 11 f4 ff ff       	call   80062a <cputchar>
  801219:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80121c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80121f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801222:	01 d0                	add    %edx,%eax
  801224:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801227:	eb 06                	jmp    80122f <readline+0xfc>
		}
	}
  801229:	e9 3b ff ff ff       	jmp    801169 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80122e:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80122f:	c9                   	leave  
  801230:	c3                   	ret    

00801231 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801231:	55                   	push   %ebp
  801232:	89 e5                	mov    %esp,%ebp
  801234:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801237:	e8 28 0d 00 00       	call   801f64 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80123c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801240:	74 13                	je     801255 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801242:	83 ec 08             	sub    $0x8,%esp
  801245:	ff 75 08             	pushl  0x8(%ebp)
  801248:	68 10 2d 80 00       	push   $0x802d10
  80124d:	e8 5f f8 ff ff       	call   800ab1 <cprintf>
  801252:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801255:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80125c:	83 ec 0c             	sub    $0xc,%esp
  80125f:	6a 00                	push   $0x0
  801261:	e8 5a f4 ff ff       	call   8006c0 <iscons>
  801266:	83 c4 10             	add    $0x10,%esp
  801269:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80126c:	e8 01 f4 ff ff       	call   800672 <getchar>
  801271:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801274:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801278:	79 23                	jns    80129d <atomic_readline+0x6c>
			if (c != -E_EOF)
  80127a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80127e:	74 13                	je     801293 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801280:	83 ec 08             	sub    $0x8,%esp
  801283:	ff 75 ec             	pushl  -0x14(%ebp)
  801286:	68 13 2d 80 00       	push   $0x802d13
  80128b:	e8 21 f8 ff ff       	call   800ab1 <cprintf>
  801290:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801293:	e8 e6 0c 00 00       	call   801f7e <sys_enable_interrupt>
			return;
  801298:	e9 9a 00 00 00       	jmp    801337 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80129d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8012a1:	7e 34                	jle    8012d7 <atomic_readline+0xa6>
  8012a3:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8012aa:	7f 2b                	jg     8012d7 <atomic_readline+0xa6>
			if (echoing)
  8012ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012b0:	74 0e                	je     8012c0 <atomic_readline+0x8f>
				cputchar(c);
  8012b2:	83 ec 0c             	sub    $0xc,%esp
  8012b5:	ff 75 ec             	pushl  -0x14(%ebp)
  8012b8:	e8 6d f3 ff ff       	call   80062a <cputchar>
  8012bd:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c3:	8d 50 01             	lea    0x1(%eax),%edx
  8012c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012c9:	89 c2                	mov    %eax,%edx
  8012cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ce:	01 d0                	add    %edx,%eax
  8012d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012d3:	88 10                	mov    %dl,(%eax)
  8012d5:	eb 5b                	jmp    801332 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8012d7:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012db:	75 1f                	jne    8012fc <atomic_readline+0xcb>
  8012dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012e1:	7e 19                	jle    8012fc <atomic_readline+0xcb>
			if (echoing)
  8012e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012e7:	74 0e                	je     8012f7 <atomic_readline+0xc6>
				cputchar(c);
  8012e9:	83 ec 0c             	sub    $0xc,%esp
  8012ec:	ff 75 ec             	pushl  -0x14(%ebp)
  8012ef:	e8 36 f3 ff ff       	call   80062a <cputchar>
  8012f4:	83 c4 10             	add    $0x10,%esp
			i--;
  8012f7:	ff 4d f4             	decl   -0xc(%ebp)
  8012fa:	eb 36                	jmp    801332 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012fc:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801300:	74 0a                	je     80130c <atomic_readline+0xdb>
  801302:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801306:	0f 85 60 ff ff ff    	jne    80126c <atomic_readline+0x3b>
			if (echoing)
  80130c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801310:	74 0e                	je     801320 <atomic_readline+0xef>
				cputchar(c);
  801312:	83 ec 0c             	sub    $0xc,%esp
  801315:	ff 75 ec             	pushl  -0x14(%ebp)
  801318:	e8 0d f3 ff ff       	call   80062a <cputchar>
  80131d:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801320:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801323:	8b 45 0c             	mov    0xc(%ebp),%eax
  801326:	01 d0                	add    %edx,%eax
  801328:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80132b:	e8 4e 0c 00 00       	call   801f7e <sys_enable_interrupt>
			return;
  801330:	eb 05                	jmp    801337 <atomic_readline+0x106>
		}
	}
  801332:	e9 35 ff ff ff       	jmp    80126c <atomic_readline+0x3b>
}
  801337:	c9                   	leave  
  801338:	c3                   	ret    

00801339 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801339:	55                   	push   %ebp
  80133a:	89 e5                	mov    %esp,%ebp
  80133c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80133f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801346:	eb 06                	jmp    80134e <strlen+0x15>
		n++;
  801348:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80134b:	ff 45 08             	incl   0x8(%ebp)
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	8a 00                	mov    (%eax),%al
  801353:	84 c0                	test   %al,%al
  801355:	75 f1                	jne    801348 <strlen+0xf>
		n++;
	return n;
  801357:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80135a:	c9                   	leave  
  80135b:	c3                   	ret    

0080135c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80135c:	55                   	push   %ebp
  80135d:	89 e5                	mov    %esp,%ebp
  80135f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801362:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801369:	eb 09                	jmp    801374 <strnlen+0x18>
		n++;
  80136b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80136e:	ff 45 08             	incl   0x8(%ebp)
  801371:	ff 4d 0c             	decl   0xc(%ebp)
  801374:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801378:	74 09                	je     801383 <strnlen+0x27>
  80137a:	8b 45 08             	mov    0x8(%ebp),%eax
  80137d:	8a 00                	mov    (%eax),%al
  80137f:	84 c0                	test   %al,%al
  801381:	75 e8                	jne    80136b <strnlen+0xf>
		n++;
	return n;
  801383:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801386:	c9                   	leave  
  801387:	c3                   	ret    

00801388 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801388:	55                   	push   %ebp
  801389:	89 e5                	mov    %esp,%ebp
  80138b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801394:	90                   	nop
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	8d 50 01             	lea    0x1(%eax),%edx
  80139b:	89 55 08             	mov    %edx,0x8(%ebp)
  80139e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013a4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013a7:	8a 12                	mov    (%edx),%dl
  8013a9:	88 10                	mov    %dl,(%eax)
  8013ab:	8a 00                	mov    (%eax),%al
  8013ad:	84 c0                	test   %al,%al
  8013af:	75 e4                	jne    801395 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013b4:	c9                   	leave  
  8013b5:	c3                   	ret    

008013b6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013b6:	55                   	push   %ebp
  8013b7:	89 e5                	mov    %esp,%ebp
  8013b9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013c9:	eb 1f                	jmp    8013ea <strncpy+0x34>
		*dst++ = *src;
  8013cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ce:	8d 50 01             	lea    0x1(%eax),%edx
  8013d1:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d7:	8a 12                	mov    (%edx),%dl
  8013d9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013de:	8a 00                	mov    (%eax),%al
  8013e0:	84 c0                	test   %al,%al
  8013e2:	74 03                	je     8013e7 <strncpy+0x31>
			src++;
  8013e4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013e7:	ff 45 fc             	incl   -0x4(%ebp)
  8013ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ed:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013f0:	72 d9                	jb     8013cb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013f5:	c9                   	leave  
  8013f6:	c3                   	ret    

008013f7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013f7:	55                   	push   %ebp
  8013f8:	89 e5                	mov    %esp,%ebp
  8013fa:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801403:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801407:	74 30                	je     801439 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801409:	eb 16                	jmp    801421 <strlcpy+0x2a>
			*dst++ = *src++;
  80140b:	8b 45 08             	mov    0x8(%ebp),%eax
  80140e:	8d 50 01             	lea    0x1(%eax),%edx
  801411:	89 55 08             	mov    %edx,0x8(%ebp)
  801414:	8b 55 0c             	mov    0xc(%ebp),%edx
  801417:	8d 4a 01             	lea    0x1(%edx),%ecx
  80141a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80141d:	8a 12                	mov    (%edx),%dl
  80141f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801421:	ff 4d 10             	decl   0x10(%ebp)
  801424:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801428:	74 09                	je     801433 <strlcpy+0x3c>
  80142a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142d:	8a 00                	mov    (%eax),%al
  80142f:	84 c0                	test   %al,%al
  801431:	75 d8                	jne    80140b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801439:	8b 55 08             	mov    0x8(%ebp),%edx
  80143c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80143f:	29 c2                	sub    %eax,%edx
  801441:	89 d0                	mov    %edx,%eax
}
  801443:	c9                   	leave  
  801444:	c3                   	ret    

00801445 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801445:	55                   	push   %ebp
  801446:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801448:	eb 06                	jmp    801450 <strcmp+0xb>
		p++, q++;
  80144a:	ff 45 08             	incl   0x8(%ebp)
  80144d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8a 00                	mov    (%eax),%al
  801455:	84 c0                	test   %al,%al
  801457:	74 0e                	je     801467 <strcmp+0x22>
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
  80145c:	8a 10                	mov    (%eax),%dl
  80145e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801461:	8a 00                	mov    (%eax),%al
  801463:	38 c2                	cmp    %al,%dl
  801465:	74 e3                	je     80144a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801467:	8b 45 08             	mov    0x8(%ebp),%eax
  80146a:	8a 00                	mov    (%eax),%al
  80146c:	0f b6 d0             	movzbl %al,%edx
  80146f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801472:	8a 00                	mov    (%eax),%al
  801474:	0f b6 c0             	movzbl %al,%eax
  801477:	29 c2                	sub    %eax,%edx
  801479:	89 d0                	mov    %edx,%eax
}
  80147b:	5d                   	pop    %ebp
  80147c:	c3                   	ret    

0080147d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801480:	eb 09                	jmp    80148b <strncmp+0xe>
		n--, p++, q++;
  801482:	ff 4d 10             	decl   0x10(%ebp)
  801485:	ff 45 08             	incl   0x8(%ebp)
  801488:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80148b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80148f:	74 17                	je     8014a8 <strncmp+0x2b>
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
  801494:	8a 00                	mov    (%eax),%al
  801496:	84 c0                	test   %al,%al
  801498:	74 0e                	je     8014a8 <strncmp+0x2b>
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	8a 10                	mov    (%eax),%dl
  80149f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a2:	8a 00                	mov    (%eax),%al
  8014a4:	38 c2                	cmp    %al,%dl
  8014a6:	74 da                	je     801482 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014a8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ac:	75 07                	jne    8014b5 <strncmp+0x38>
		return 0;
  8014ae:	b8 00 00 00 00       	mov    $0x0,%eax
  8014b3:	eb 14                	jmp    8014c9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b8:	8a 00                	mov    (%eax),%al
  8014ba:	0f b6 d0             	movzbl %al,%edx
  8014bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c0:	8a 00                	mov    (%eax),%al
  8014c2:	0f b6 c0             	movzbl %al,%eax
  8014c5:	29 c2                	sub    %eax,%edx
  8014c7:	89 d0                	mov    %edx,%eax
}
  8014c9:	5d                   	pop    %ebp
  8014ca:	c3                   	ret    

008014cb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
  8014ce:	83 ec 04             	sub    $0x4,%esp
  8014d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014d7:	eb 12                	jmp    8014eb <strchr+0x20>
		if (*s == c)
  8014d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dc:	8a 00                	mov    (%eax),%al
  8014de:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014e1:	75 05                	jne    8014e8 <strchr+0x1d>
			return (char *) s;
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	eb 11                	jmp    8014f9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014e8:	ff 45 08             	incl   0x8(%ebp)
  8014eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ee:	8a 00                	mov    (%eax),%al
  8014f0:	84 c0                	test   %al,%al
  8014f2:	75 e5                	jne    8014d9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
  8014fe:	83 ec 04             	sub    $0x4,%esp
  801501:	8b 45 0c             	mov    0xc(%ebp),%eax
  801504:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801507:	eb 0d                	jmp    801516 <strfind+0x1b>
		if (*s == c)
  801509:	8b 45 08             	mov    0x8(%ebp),%eax
  80150c:	8a 00                	mov    (%eax),%al
  80150e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801511:	74 0e                	je     801521 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801513:	ff 45 08             	incl   0x8(%ebp)
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
  801519:	8a 00                	mov    (%eax),%al
  80151b:	84 c0                	test   %al,%al
  80151d:	75 ea                	jne    801509 <strfind+0xe>
  80151f:	eb 01                	jmp    801522 <strfind+0x27>
		if (*s == c)
			break;
  801521:	90                   	nop
	return (char *) s;
  801522:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801525:	c9                   	leave  
  801526:	c3                   	ret    

00801527 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801527:	55                   	push   %ebp
  801528:	89 e5                	mov    %esp,%ebp
  80152a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801533:	8b 45 10             	mov    0x10(%ebp),%eax
  801536:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801539:	eb 0e                	jmp    801549 <memset+0x22>
		*p++ = c;
  80153b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153e:	8d 50 01             	lea    0x1(%eax),%edx
  801541:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801544:	8b 55 0c             	mov    0xc(%ebp),%edx
  801547:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801549:	ff 4d f8             	decl   -0x8(%ebp)
  80154c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801550:	79 e9                	jns    80153b <memset+0x14>
		*p++ = c;

	return v;
  801552:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801555:	c9                   	leave  
  801556:	c3                   	ret    

00801557 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801557:	55                   	push   %ebp
  801558:	89 e5                	mov    %esp,%ebp
  80155a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80155d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801560:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801563:	8b 45 08             	mov    0x8(%ebp),%eax
  801566:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801569:	eb 16                	jmp    801581 <memcpy+0x2a>
		*d++ = *s++;
  80156b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80156e:	8d 50 01             	lea    0x1(%eax),%edx
  801571:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801574:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801577:	8d 4a 01             	lea    0x1(%edx),%ecx
  80157a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80157d:	8a 12                	mov    (%edx),%dl
  80157f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801581:	8b 45 10             	mov    0x10(%ebp),%eax
  801584:	8d 50 ff             	lea    -0x1(%eax),%edx
  801587:	89 55 10             	mov    %edx,0x10(%ebp)
  80158a:	85 c0                	test   %eax,%eax
  80158c:	75 dd                	jne    80156b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80158e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801591:	c9                   	leave  
  801592:	c3                   	ret    

00801593 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801593:	55                   	push   %ebp
  801594:	89 e5                	mov    %esp,%ebp
  801596:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801599:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80159f:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8015a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015ab:	73 50                	jae    8015fd <memmove+0x6a>
  8015ad:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b3:	01 d0                	add    %edx,%eax
  8015b5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015b8:	76 43                	jbe    8015fd <memmove+0x6a>
		s += n;
  8015ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bd:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015c6:	eb 10                	jmp    8015d8 <memmove+0x45>
			*--d = *--s;
  8015c8:	ff 4d f8             	decl   -0x8(%ebp)
  8015cb:	ff 4d fc             	decl   -0x4(%ebp)
  8015ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d1:	8a 10                	mov    (%eax),%dl
  8015d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8015db:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015de:	89 55 10             	mov    %edx,0x10(%ebp)
  8015e1:	85 c0                	test   %eax,%eax
  8015e3:	75 e3                	jne    8015c8 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015e5:	eb 23                	jmp    80160a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ea:	8d 50 01             	lea    0x1(%eax),%edx
  8015ed:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015f6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015f9:	8a 12                	mov    (%edx),%dl
  8015fb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801600:	8d 50 ff             	lea    -0x1(%eax),%edx
  801603:	89 55 10             	mov    %edx,0x10(%ebp)
  801606:	85 c0                	test   %eax,%eax
  801608:	75 dd                	jne    8015e7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80160a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
  801612:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
  801618:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80161b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801621:	eb 2a                	jmp    80164d <memcmp+0x3e>
		if (*s1 != *s2)
  801623:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801626:	8a 10                	mov    (%eax),%dl
  801628:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	38 c2                	cmp    %al,%dl
  80162f:	74 16                	je     801647 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801631:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801634:	8a 00                	mov    (%eax),%al
  801636:	0f b6 d0             	movzbl %al,%edx
  801639:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80163c:	8a 00                	mov    (%eax),%al
  80163e:	0f b6 c0             	movzbl %al,%eax
  801641:	29 c2                	sub    %eax,%edx
  801643:	89 d0                	mov    %edx,%eax
  801645:	eb 18                	jmp    80165f <memcmp+0x50>
		s1++, s2++;
  801647:	ff 45 fc             	incl   -0x4(%ebp)
  80164a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80164d:	8b 45 10             	mov    0x10(%ebp),%eax
  801650:	8d 50 ff             	lea    -0x1(%eax),%edx
  801653:	89 55 10             	mov    %edx,0x10(%ebp)
  801656:	85 c0                	test   %eax,%eax
  801658:	75 c9                	jne    801623 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80165a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80165f:	c9                   	leave  
  801660:	c3                   	ret    

00801661 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801661:	55                   	push   %ebp
  801662:	89 e5                	mov    %esp,%ebp
  801664:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801667:	8b 55 08             	mov    0x8(%ebp),%edx
  80166a:	8b 45 10             	mov    0x10(%ebp),%eax
  80166d:	01 d0                	add    %edx,%eax
  80166f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801672:	eb 15                	jmp    801689 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801674:	8b 45 08             	mov    0x8(%ebp),%eax
  801677:	8a 00                	mov    (%eax),%al
  801679:	0f b6 d0             	movzbl %al,%edx
  80167c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80167f:	0f b6 c0             	movzbl %al,%eax
  801682:	39 c2                	cmp    %eax,%edx
  801684:	74 0d                	je     801693 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801686:	ff 45 08             	incl   0x8(%ebp)
  801689:	8b 45 08             	mov    0x8(%ebp),%eax
  80168c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80168f:	72 e3                	jb     801674 <memfind+0x13>
  801691:	eb 01                	jmp    801694 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801693:	90                   	nop
	return (void *) s;
  801694:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801697:	c9                   	leave  
  801698:	c3                   	ret    

00801699 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801699:	55                   	push   %ebp
  80169a:	89 e5                	mov    %esp,%ebp
  80169c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80169f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016a6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016ad:	eb 03                	jmp    8016b2 <strtol+0x19>
		s++;
  8016af:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	3c 20                	cmp    $0x20,%al
  8016b9:	74 f4                	je     8016af <strtol+0x16>
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	8a 00                	mov    (%eax),%al
  8016c0:	3c 09                	cmp    $0x9,%al
  8016c2:	74 eb                	je     8016af <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	8a 00                	mov    (%eax),%al
  8016c9:	3c 2b                	cmp    $0x2b,%al
  8016cb:	75 05                	jne    8016d2 <strtol+0x39>
		s++;
  8016cd:	ff 45 08             	incl   0x8(%ebp)
  8016d0:	eb 13                	jmp    8016e5 <strtol+0x4c>
	else if (*s == '-')
  8016d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d5:	8a 00                	mov    (%eax),%al
  8016d7:	3c 2d                	cmp    $0x2d,%al
  8016d9:	75 0a                	jne    8016e5 <strtol+0x4c>
		s++, neg = 1;
  8016db:	ff 45 08             	incl   0x8(%ebp)
  8016de:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016e9:	74 06                	je     8016f1 <strtol+0x58>
  8016eb:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016ef:	75 20                	jne    801711 <strtol+0x78>
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	8a 00                	mov    (%eax),%al
  8016f6:	3c 30                	cmp    $0x30,%al
  8016f8:	75 17                	jne    801711 <strtol+0x78>
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	40                   	inc    %eax
  8016fe:	8a 00                	mov    (%eax),%al
  801700:	3c 78                	cmp    $0x78,%al
  801702:	75 0d                	jne    801711 <strtol+0x78>
		s += 2, base = 16;
  801704:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801708:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80170f:	eb 28                	jmp    801739 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801711:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801715:	75 15                	jne    80172c <strtol+0x93>
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	8a 00                	mov    (%eax),%al
  80171c:	3c 30                	cmp    $0x30,%al
  80171e:	75 0c                	jne    80172c <strtol+0x93>
		s++, base = 8;
  801720:	ff 45 08             	incl   0x8(%ebp)
  801723:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80172a:	eb 0d                	jmp    801739 <strtol+0xa0>
	else if (base == 0)
  80172c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801730:	75 07                	jne    801739 <strtol+0xa0>
		base = 10;
  801732:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801739:	8b 45 08             	mov    0x8(%ebp),%eax
  80173c:	8a 00                	mov    (%eax),%al
  80173e:	3c 2f                	cmp    $0x2f,%al
  801740:	7e 19                	jle    80175b <strtol+0xc2>
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	8a 00                	mov    (%eax),%al
  801747:	3c 39                	cmp    $0x39,%al
  801749:	7f 10                	jg     80175b <strtol+0xc2>
			dig = *s - '0';
  80174b:	8b 45 08             	mov    0x8(%ebp),%eax
  80174e:	8a 00                	mov    (%eax),%al
  801750:	0f be c0             	movsbl %al,%eax
  801753:	83 e8 30             	sub    $0x30,%eax
  801756:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801759:	eb 42                	jmp    80179d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80175b:	8b 45 08             	mov    0x8(%ebp),%eax
  80175e:	8a 00                	mov    (%eax),%al
  801760:	3c 60                	cmp    $0x60,%al
  801762:	7e 19                	jle    80177d <strtol+0xe4>
  801764:	8b 45 08             	mov    0x8(%ebp),%eax
  801767:	8a 00                	mov    (%eax),%al
  801769:	3c 7a                	cmp    $0x7a,%al
  80176b:	7f 10                	jg     80177d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	8a 00                	mov    (%eax),%al
  801772:	0f be c0             	movsbl %al,%eax
  801775:	83 e8 57             	sub    $0x57,%eax
  801778:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80177b:	eb 20                	jmp    80179d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80177d:	8b 45 08             	mov    0x8(%ebp),%eax
  801780:	8a 00                	mov    (%eax),%al
  801782:	3c 40                	cmp    $0x40,%al
  801784:	7e 39                	jle    8017bf <strtol+0x126>
  801786:	8b 45 08             	mov    0x8(%ebp),%eax
  801789:	8a 00                	mov    (%eax),%al
  80178b:	3c 5a                	cmp    $0x5a,%al
  80178d:	7f 30                	jg     8017bf <strtol+0x126>
			dig = *s - 'A' + 10;
  80178f:	8b 45 08             	mov    0x8(%ebp),%eax
  801792:	8a 00                	mov    (%eax),%al
  801794:	0f be c0             	movsbl %al,%eax
  801797:	83 e8 37             	sub    $0x37,%eax
  80179a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80179d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017a0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8017a3:	7d 19                	jge    8017be <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8017a5:	ff 45 08             	incl   0x8(%ebp)
  8017a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ab:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017af:	89 c2                	mov    %eax,%edx
  8017b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017b4:	01 d0                	add    %edx,%eax
  8017b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017b9:	e9 7b ff ff ff       	jmp    801739 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017be:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017c3:	74 08                	je     8017cd <strtol+0x134>
		*endptr = (char *) s;
  8017c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c8:	8b 55 08             	mov    0x8(%ebp),%edx
  8017cb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017d1:	74 07                	je     8017da <strtol+0x141>
  8017d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d6:	f7 d8                	neg    %eax
  8017d8:	eb 03                	jmp    8017dd <strtol+0x144>
  8017da:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017dd:	c9                   	leave  
  8017de:	c3                   	ret    

008017df <ltostr>:

void
ltostr(long value, char *str)
{
  8017df:	55                   	push   %ebp
  8017e0:	89 e5                	mov    %esp,%ebp
  8017e2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017f3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017f7:	79 13                	jns    80180c <ltostr+0x2d>
	{
		neg = 1;
  8017f9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801800:	8b 45 0c             	mov    0xc(%ebp),%eax
  801803:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801806:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801809:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80180c:	8b 45 08             	mov    0x8(%ebp),%eax
  80180f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801814:	99                   	cltd   
  801815:	f7 f9                	idiv   %ecx
  801817:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80181a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80181d:	8d 50 01             	lea    0x1(%eax),%edx
  801820:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801823:	89 c2                	mov    %eax,%edx
  801825:	8b 45 0c             	mov    0xc(%ebp),%eax
  801828:	01 d0                	add    %edx,%eax
  80182a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80182d:	83 c2 30             	add    $0x30,%edx
  801830:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801832:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801835:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80183a:	f7 e9                	imul   %ecx
  80183c:	c1 fa 02             	sar    $0x2,%edx
  80183f:	89 c8                	mov    %ecx,%eax
  801841:	c1 f8 1f             	sar    $0x1f,%eax
  801844:	29 c2                	sub    %eax,%edx
  801846:	89 d0                	mov    %edx,%eax
  801848:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80184b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80184e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801853:	f7 e9                	imul   %ecx
  801855:	c1 fa 02             	sar    $0x2,%edx
  801858:	89 c8                	mov    %ecx,%eax
  80185a:	c1 f8 1f             	sar    $0x1f,%eax
  80185d:	29 c2                	sub    %eax,%edx
  80185f:	89 d0                	mov    %edx,%eax
  801861:	c1 e0 02             	shl    $0x2,%eax
  801864:	01 d0                	add    %edx,%eax
  801866:	01 c0                	add    %eax,%eax
  801868:	29 c1                	sub    %eax,%ecx
  80186a:	89 ca                	mov    %ecx,%edx
  80186c:	85 d2                	test   %edx,%edx
  80186e:	75 9c                	jne    80180c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801870:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801877:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187a:	48                   	dec    %eax
  80187b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80187e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801882:	74 3d                	je     8018c1 <ltostr+0xe2>
		start = 1 ;
  801884:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80188b:	eb 34                	jmp    8018c1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80188d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801890:	8b 45 0c             	mov    0xc(%ebp),%eax
  801893:	01 d0                	add    %edx,%eax
  801895:	8a 00                	mov    (%eax),%al
  801897:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80189a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80189d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a0:	01 c2                	add    %eax,%edx
  8018a2:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8018a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a8:	01 c8                	add    %ecx,%eax
  8018aa:	8a 00                	mov    (%eax),%al
  8018ac:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018ae:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b4:	01 c2                	add    %eax,%edx
  8018b6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018b9:	88 02                	mov    %al,(%edx)
		start++ ;
  8018bb:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018be:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018c7:	7c c4                	jl     80188d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018c9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018cf:	01 d0                	add    %edx,%eax
  8018d1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018d4:	90                   	nop
  8018d5:	c9                   	leave  
  8018d6:	c3                   	ret    

008018d7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018d7:	55                   	push   %ebp
  8018d8:	89 e5                	mov    %esp,%ebp
  8018da:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018dd:	ff 75 08             	pushl  0x8(%ebp)
  8018e0:	e8 54 fa ff ff       	call   801339 <strlen>
  8018e5:	83 c4 04             	add    $0x4,%esp
  8018e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018eb:	ff 75 0c             	pushl  0xc(%ebp)
  8018ee:	e8 46 fa ff ff       	call   801339 <strlen>
  8018f3:	83 c4 04             	add    $0x4,%esp
  8018f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801900:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801907:	eb 17                	jmp    801920 <strcconcat+0x49>
		final[s] = str1[s] ;
  801909:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80190c:	8b 45 10             	mov    0x10(%ebp),%eax
  80190f:	01 c2                	add    %eax,%edx
  801911:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801914:	8b 45 08             	mov    0x8(%ebp),%eax
  801917:	01 c8                	add    %ecx,%eax
  801919:	8a 00                	mov    (%eax),%al
  80191b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80191d:	ff 45 fc             	incl   -0x4(%ebp)
  801920:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801923:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801926:	7c e1                	jl     801909 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801928:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80192f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801936:	eb 1f                	jmp    801957 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801938:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80193b:	8d 50 01             	lea    0x1(%eax),%edx
  80193e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801941:	89 c2                	mov    %eax,%edx
  801943:	8b 45 10             	mov    0x10(%ebp),%eax
  801946:	01 c2                	add    %eax,%edx
  801948:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80194b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194e:	01 c8                	add    %ecx,%eax
  801950:	8a 00                	mov    (%eax),%al
  801952:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801954:	ff 45 f8             	incl   -0x8(%ebp)
  801957:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80195d:	7c d9                	jl     801938 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80195f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801962:	8b 45 10             	mov    0x10(%ebp),%eax
  801965:	01 d0                	add    %edx,%eax
  801967:	c6 00 00             	movb   $0x0,(%eax)
}
  80196a:	90                   	nop
  80196b:	c9                   	leave  
  80196c:	c3                   	ret    

0080196d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80196d:	55                   	push   %ebp
  80196e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801970:	8b 45 14             	mov    0x14(%ebp),%eax
  801973:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801979:	8b 45 14             	mov    0x14(%ebp),%eax
  80197c:	8b 00                	mov    (%eax),%eax
  80197e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801985:	8b 45 10             	mov    0x10(%ebp),%eax
  801988:	01 d0                	add    %edx,%eax
  80198a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801990:	eb 0c                	jmp    80199e <strsplit+0x31>
			*string++ = 0;
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	8d 50 01             	lea    0x1(%eax),%edx
  801998:	89 55 08             	mov    %edx,0x8(%ebp)
  80199b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80199e:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a1:	8a 00                	mov    (%eax),%al
  8019a3:	84 c0                	test   %al,%al
  8019a5:	74 18                	je     8019bf <strsplit+0x52>
  8019a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019aa:	8a 00                	mov    (%eax),%al
  8019ac:	0f be c0             	movsbl %al,%eax
  8019af:	50                   	push   %eax
  8019b0:	ff 75 0c             	pushl  0xc(%ebp)
  8019b3:	e8 13 fb ff ff       	call   8014cb <strchr>
  8019b8:	83 c4 08             	add    $0x8,%esp
  8019bb:	85 c0                	test   %eax,%eax
  8019bd:	75 d3                	jne    801992 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8019bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c2:	8a 00                	mov    (%eax),%al
  8019c4:	84 c0                	test   %al,%al
  8019c6:	74 5a                	je     801a22 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8019c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8019cb:	8b 00                	mov    (%eax),%eax
  8019cd:	83 f8 0f             	cmp    $0xf,%eax
  8019d0:	75 07                	jne    8019d9 <strsplit+0x6c>
		{
			return 0;
  8019d2:	b8 00 00 00 00       	mov    $0x0,%eax
  8019d7:	eb 66                	jmp    801a3f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8019dc:	8b 00                	mov    (%eax),%eax
  8019de:	8d 48 01             	lea    0x1(%eax),%ecx
  8019e1:	8b 55 14             	mov    0x14(%ebp),%edx
  8019e4:	89 0a                	mov    %ecx,(%edx)
  8019e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f0:	01 c2                	add    %eax,%edx
  8019f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019f7:	eb 03                	jmp    8019fc <strsplit+0x8f>
			string++;
  8019f9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ff:	8a 00                	mov    (%eax),%al
  801a01:	84 c0                	test   %al,%al
  801a03:	74 8b                	je     801990 <strsplit+0x23>
  801a05:	8b 45 08             	mov    0x8(%ebp),%eax
  801a08:	8a 00                	mov    (%eax),%al
  801a0a:	0f be c0             	movsbl %al,%eax
  801a0d:	50                   	push   %eax
  801a0e:	ff 75 0c             	pushl  0xc(%ebp)
  801a11:	e8 b5 fa ff ff       	call   8014cb <strchr>
  801a16:	83 c4 08             	add    $0x8,%esp
  801a19:	85 c0                	test   %eax,%eax
  801a1b:	74 dc                	je     8019f9 <strsplit+0x8c>
			string++;
	}
  801a1d:	e9 6e ff ff ff       	jmp    801990 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a22:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a23:	8b 45 14             	mov    0x14(%ebp),%eax
  801a26:	8b 00                	mov    (%eax),%eax
  801a28:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a2f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a32:	01 d0                	add    %edx,%eax
  801a34:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a3a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
  801a44:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801a47:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4a:	c1 e8 0c             	shr    $0xc,%eax
  801a4d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801a50:	8b 45 08             	mov    0x8(%ebp),%eax
  801a53:	25 ff 0f 00 00       	and    $0xfff,%eax
  801a58:	85 c0                	test   %eax,%eax
  801a5a:	74 03                	je     801a5f <malloc+0x1e>
			num++;
  801a5c:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801a5f:	a1 04 30 80 00       	mov    0x803004,%eax
  801a64:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801a69:	75 73                	jne    801ade <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801a6b:	83 ec 08             	sub    $0x8,%esp
  801a6e:	ff 75 08             	pushl  0x8(%ebp)
  801a71:	68 00 00 00 80       	push   $0x80000000
  801a76:	e8 80 04 00 00       	call   801efb <sys_allocateMem>
  801a7b:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801a7e:	a1 04 30 80 00       	mov    0x803004,%eax
  801a83:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801a86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a89:	c1 e0 0c             	shl    $0xc,%eax
  801a8c:	89 c2                	mov    %eax,%edx
  801a8e:	a1 04 30 80 00       	mov    0x803004,%eax
  801a93:	01 d0                	add    %edx,%eax
  801a95:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801a9a:	a1 30 30 80 00       	mov    0x803030,%eax
  801a9f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801aa2:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801aa9:	a1 30 30 80 00       	mov    0x803030,%eax
  801aae:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801ab4:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801abb:	a1 30 30 80 00       	mov    0x803030,%eax
  801ac0:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801ac7:	01 00 00 00 
			sizeofarray++;
  801acb:	a1 30 30 80 00       	mov    0x803030,%eax
  801ad0:	40                   	inc    %eax
  801ad1:	a3 30 30 80 00       	mov    %eax,0x803030
			return (void*)return_addres;
  801ad6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801ad9:	e9 71 01 00 00       	jmp    801c4f <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801ade:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801ae3:	85 c0                	test   %eax,%eax
  801ae5:	75 71                	jne    801b58 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801ae7:	a1 04 30 80 00       	mov    0x803004,%eax
  801aec:	83 ec 08             	sub    $0x8,%esp
  801aef:	ff 75 08             	pushl  0x8(%ebp)
  801af2:	50                   	push   %eax
  801af3:	e8 03 04 00 00       	call   801efb <sys_allocateMem>
  801af8:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801afb:	a1 04 30 80 00       	mov    0x803004,%eax
  801b00:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b06:	c1 e0 0c             	shl    $0xc,%eax
  801b09:	89 c2                	mov    %eax,%edx
  801b0b:	a1 04 30 80 00       	mov    0x803004,%eax
  801b10:	01 d0                	add    %edx,%eax
  801b12:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801b17:	a1 30 30 80 00       	mov    0x803030,%eax
  801b1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b1f:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801b26:	a1 30 30 80 00       	mov    0x803030,%eax
  801b2b:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801b2e:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801b35:	a1 30 30 80 00       	mov    0x803030,%eax
  801b3a:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801b41:	01 00 00 00 
				sizeofarray++;
  801b45:	a1 30 30 80 00       	mov    0x803030,%eax
  801b4a:	40                   	inc    %eax
  801b4b:	a3 30 30 80 00       	mov    %eax,0x803030
				return (void*)return_addres;
  801b50:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801b53:	e9 f7 00 00 00       	jmp    801c4f <malloc+0x20e>
			}
			else{
				int count=0;
  801b58:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801b5f:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801b66:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801b6d:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801b74:	eb 7c                	jmp    801bf2 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801b76:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801b7d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801b84:	eb 1a                	jmp    801ba0 <malloc+0x15f>
					{
						if(addresses[j]==i)
  801b86:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b89:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b90:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801b93:	75 08                	jne    801b9d <malloc+0x15c>
						{
							index=j;
  801b95:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b98:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801b9b:	eb 0d                	jmp    801baa <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801b9d:	ff 45 dc             	incl   -0x24(%ebp)
  801ba0:	a1 30 30 80 00       	mov    0x803030,%eax
  801ba5:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801ba8:	7c dc                	jl     801b86 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801baa:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801bae:	75 05                	jne    801bb5 <malloc+0x174>
					{
						count++;
  801bb0:	ff 45 f0             	incl   -0x10(%ebp)
  801bb3:	eb 36                	jmp    801beb <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801bb5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801bb8:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  801bbf:	85 c0                	test   %eax,%eax
  801bc1:	75 05                	jne    801bc8 <malloc+0x187>
						{
							count++;
  801bc3:	ff 45 f0             	incl   -0x10(%ebp)
  801bc6:	eb 23                	jmp    801beb <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801bc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bcb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801bce:	7d 14                	jge    801be4 <malloc+0x1a3>
  801bd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bd3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801bd6:	7c 0c                	jl     801be4 <malloc+0x1a3>
							{
								min=count;
  801bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bdb:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801bde:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801be1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801be4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801beb:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801bf2:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801bf9:	0f 86 77 ff ff ff    	jbe    801b76 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801bff:	83 ec 08             	sub    $0x8,%esp
  801c02:	ff 75 08             	pushl  0x8(%ebp)
  801c05:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c08:	e8 ee 02 00 00       	call   801efb <sys_allocateMem>
  801c0d:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801c10:	a1 30 30 80 00       	mov    0x803030,%eax
  801c15:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c18:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801c1f:	a1 30 30 80 00       	mov    0x803030,%eax
  801c24:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801c2a:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801c31:	a1 30 30 80 00       	mov    0x803030,%eax
  801c36:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801c3d:	01 00 00 00 
				sizeofarray++;
  801c41:	a1 30 30 80 00       	mov    0x803030,%eax
  801c46:	40                   	inc    %eax
  801c47:	a3 30 30 80 00       	mov    %eax,0x803030
				return(void*) min_addresss;
  801c4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801c4f:	c9                   	leave  
  801c50:	c3                   	ret    

00801c51 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801c51:	55                   	push   %ebp
  801c52:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  801c54:	90                   	nop
  801c55:	5d                   	pop    %ebp
  801c56:	c3                   	ret    

00801c57 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c57:	55                   	push   %ebp
  801c58:	89 e5                	mov    %esp,%ebp
  801c5a:	83 ec 18             	sub    $0x18,%esp
  801c5d:	8b 45 10             	mov    0x10(%ebp),%eax
  801c60:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801c63:	83 ec 04             	sub    $0x4,%esp
  801c66:	68 24 2d 80 00       	push   $0x802d24
  801c6b:	68 8d 00 00 00       	push   $0x8d
  801c70:	68 47 2d 80 00       	push   $0x802d47
  801c75:	e8 95 eb ff ff       	call   80080f <_panic>

00801c7a <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c7a:	55                   	push   %ebp
  801c7b:	89 e5                	mov    %esp,%ebp
  801c7d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c80:	83 ec 04             	sub    $0x4,%esp
  801c83:	68 24 2d 80 00       	push   $0x802d24
  801c88:	68 93 00 00 00       	push   $0x93
  801c8d:	68 47 2d 80 00       	push   $0x802d47
  801c92:	e8 78 eb ff ff       	call   80080f <_panic>

00801c97 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801c97:	55                   	push   %ebp
  801c98:	89 e5                	mov    %esp,%ebp
  801c9a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c9d:	83 ec 04             	sub    $0x4,%esp
  801ca0:	68 24 2d 80 00       	push   $0x802d24
  801ca5:	68 99 00 00 00       	push   $0x99
  801caa:	68 47 2d 80 00       	push   $0x802d47
  801caf:	e8 5b eb ff ff       	call   80080f <_panic>

00801cb4 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801cb4:	55                   	push   %ebp
  801cb5:	89 e5                	mov    %esp,%ebp
  801cb7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cba:	83 ec 04             	sub    $0x4,%esp
  801cbd:	68 24 2d 80 00       	push   $0x802d24
  801cc2:	68 9e 00 00 00       	push   $0x9e
  801cc7:	68 47 2d 80 00       	push   $0x802d47
  801ccc:	e8 3e eb ff ff       	call   80080f <_panic>

00801cd1 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801cd1:	55                   	push   %ebp
  801cd2:	89 e5                	mov    %esp,%ebp
  801cd4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cd7:	83 ec 04             	sub    $0x4,%esp
  801cda:	68 24 2d 80 00       	push   $0x802d24
  801cdf:	68 a4 00 00 00       	push   $0xa4
  801ce4:	68 47 2d 80 00       	push   $0x802d47
  801ce9:	e8 21 eb ff ff       	call   80080f <_panic>

00801cee <shrink>:
}
void shrink(uint32 newSize)
{
  801cee:	55                   	push   %ebp
  801cef:	89 e5                	mov    %esp,%ebp
  801cf1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cf4:	83 ec 04             	sub    $0x4,%esp
  801cf7:	68 24 2d 80 00       	push   $0x802d24
  801cfc:	68 a8 00 00 00       	push   $0xa8
  801d01:	68 47 2d 80 00       	push   $0x802d47
  801d06:	e8 04 eb ff ff       	call   80080f <_panic>

00801d0b <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801d0b:	55                   	push   %ebp
  801d0c:	89 e5                	mov    %esp,%ebp
  801d0e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d11:	83 ec 04             	sub    $0x4,%esp
  801d14:	68 24 2d 80 00       	push   $0x802d24
  801d19:	68 ad 00 00 00       	push   $0xad
  801d1e:	68 47 2d 80 00       	push   $0x802d47
  801d23:	e8 e7 ea ff ff       	call   80080f <_panic>

00801d28 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d28:	55                   	push   %ebp
  801d29:	89 e5                	mov    %esp,%ebp
  801d2b:	57                   	push   %edi
  801d2c:	56                   	push   %esi
  801d2d:	53                   	push   %ebx
  801d2e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d31:	8b 45 08             	mov    0x8(%ebp),%eax
  801d34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d37:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d3a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d3d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d40:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d43:	cd 30                	int    $0x30
  801d45:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d48:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d4b:	83 c4 10             	add    $0x10,%esp
  801d4e:	5b                   	pop    %ebx
  801d4f:	5e                   	pop    %esi
  801d50:	5f                   	pop    %edi
  801d51:	5d                   	pop    %ebp
  801d52:	c3                   	ret    

00801d53 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d53:	55                   	push   %ebp
  801d54:	89 e5                	mov    %esp,%ebp
  801d56:	83 ec 04             	sub    $0x4,%esp
  801d59:	8b 45 10             	mov    0x10(%ebp),%eax
  801d5c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d5f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d63:	8b 45 08             	mov    0x8(%ebp),%eax
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	52                   	push   %edx
  801d6b:	ff 75 0c             	pushl  0xc(%ebp)
  801d6e:	50                   	push   %eax
  801d6f:	6a 00                	push   $0x0
  801d71:	e8 b2 ff ff ff       	call   801d28 <syscall>
  801d76:	83 c4 18             	add    $0x18,%esp
}
  801d79:	90                   	nop
  801d7a:	c9                   	leave  
  801d7b:	c3                   	ret    

00801d7c <sys_cgetc>:

int
sys_cgetc(void)
{
  801d7c:	55                   	push   %ebp
  801d7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 01                	push   $0x1
  801d8b:	e8 98 ff ff ff       	call   801d28 <syscall>
  801d90:	83 c4 18             	add    $0x18,%esp
}
  801d93:	c9                   	leave  
  801d94:	c3                   	ret    

00801d95 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d95:	55                   	push   %ebp
  801d96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d98:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	50                   	push   %eax
  801da4:	6a 05                	push   $0x5
  801da6:	e8 7d ff ff ff       	call   801d28 <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
}
  801dae:	c9                   	leave  
  801daf:	c3                   	ret    

00801db0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801db0:	55                   	push   %ebp
  801db1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 02                	push   $0x2
  801dbf:	e8 64 ff ff ff       	call   801d28 <syscall>
  801dc4:	83 c4 18             	add    $0x18,%esp
}
  801dc7:	c9                   	leave  
  801dc8:	c3                   	ret    

00801dc9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801dc9:	55                   	push   %ebp
  801dca:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 03                	push   $0x3
  801dd8:	e8 4b ff ff ff       	call   801d28 <syscall>
  801ddd:	83 c4 18             	add    $0x18,%esp
}
  801de0:	c9                   	leave  
  801de1:	c3                   	ret    

00801de2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801de2:	55                   	push   %ebp
  801de3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	6a 00                	push   $0x0
  801def:	6a 04                	push   $0x4
  801df1:	e8 32 ff ff ff       	call   801d28 <syscall>
  801df6:	83 c4 18             	add    $0x18,%esp
}
  801df9:	c9                   	leave  
  801dfa:	c3                   	ret    

00801dfb <sys_env_exit>:


void sys_env_exit(void)
{
  801dfb:	55                   	push   %ebp
  801dfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 00                	push   $0x0
  801e08:	6a 06                	push   $0x6
  801e0a:	e8 19 ff ff ff       	call   801d28 <syscall>
  801e0f:	83 c4 18             	add    $0x18,%esp
}
  801e12:	90                   	nop
  801e13:	c9                   	leave  
  801e14:	c3                   	ret    

00801e15 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e15:	55                   	push   %ebp
  801e16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e18:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	52                   	push   %edx
  801e25:	50                   	push   %eax
  801e26:	6a 07                	push   $0x7
  801e28:	e8 fb fe ff ff       	call   801d28 <syscall>
  801e2d:	83 c4 18             	add    $0x18,%esp
}
  801e30:	c9                   	leave  
  801e31:	c3                   	ret    

00801e32 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e32:	55                   	push   %ebp
  801e33:	89 e5                	mov    %esp,%ebp
  801e35:	56                   	push   %esi
  801e36:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e37:	8b 75 18             	mov    0x18(%ebp),%esi
  801e3a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e3d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e40:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e43:	8b 45 08             	mov    0x8(%ebp),%eax
  801e46:	56                   	push   %esi
  801e47:	53                   	push   %ebx
  801e48:	51                   	push   %ecx
  801e49:	52                   	push   %edx
  801e4a:	50                   	push   %eax
  801e4b:	6a 08                	push   $0x8
  801e4d:	e8 d6 fe ff ff       	call   801d28 <syscall>
  801e52:	83 c4 18             	add    $0x18,%esp
}
  801e55:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e58:	5b                   	pop    %ebx
  801e59:	5e                   	pop    %esi
  801e5a:	5d                   	pop    %ebp
  801e5b:	c3                   	ret    

00801e5c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e5c:	55                   	push   %ebp
  801e5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e62:	8b 45 08             	mov    0x8(%ebp),%eax
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	52                   	push   %edx
  801e6c:	50                   	push   %eax
  801e6d:	6a 09                	push   $0x9
  801e6f:	e8 b4 fe ff ff       	call   801d28 <syscall>
  801e74:	83 c4 18             	add    $0x18,%esp
}
  801e77:	c9                   	leave  
  801e78:	c3                   	ret    

00801e79 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e79:	55                   	push   %ebp
  801e7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	ff 75 0c             	pushl  0xc(%ebp)
  801e85:	ff 75 08             	pushl  0x8(%ebp)
  801e88:	6a 0a                	push   $0xa
  801e8a:	e8 99 fe ff ff       	call   801d28 <syscall>
  801e8f:	83 c4 18             	add    $0x18,%esp
}
  801e92:	c9                   	leave  
  801e93:	c3                   	ret    

00801e94 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e94:	55                   	push   %ebp
  801e95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 0b                	push   $0xb
  801ea3:	e8 80 fe ff ff       	call   801d28 <syscall>
  801ea8:	83 c4 18             	add    $0x18,%esp
}
  801eab:	c9                   	leave  
  801eac:	c3                   	ret    

00801ead <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ead:	55                   	push   %ebp
  801eae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 0c                	push   $0xc
  801ebc:	e8 67 fe ff ff       	call   801d28 <syscall>
  801ec1:	83 c4 18             	add    $0x18,%esp
}
  801ec4:	c9                   	leave  
  801ec5:	c3                   	ret    

00801ec6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ec6:	55                   	push   %ebp
  801ec7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 0d                	push   $0xd
  801ed5:	e8 4e fe ff ff       	call   801d28 <syscall>
  801eda:	83 c4 18             	add    $0x18,%esp
}
  801edd:	c9                   	leave  
  801ede:	c3                   	ret    

00801edf <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801edf:	55                   	push   %ebp
  801ee0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	ff 75 0c             	pushl  0xc(%ebp)
  801eeb:	ff 75 08             	pushl  0x8(%ebp)
  801eee:	6a 11                	push   $0x11
  801ef0:	e8 33 fe ff ff       	call   801d28 <syscall>
  801ef5:	83 c4 18             	add    $0x18,%esp
	return;
  801ef8:	90                   	nop
}
  801ef9:	c9                   	leave  
  801efa:	c3                   	ret    

00801efb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801efb:	55                   	push   %ebp
  801efc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	ff 75 0c             	pushl  0xc(%ebp)
  801f07:	ff 75 08             	pushl  0x8(%ebp)
  801f0a:	6a 12                	push   $0x12
  801f0c:	e8 17 fe ff ff       	call   801d28 <syscall>
  801f11:	83 c4 18             	add    $0x18,%esp
	return ;
  801f14:	90                   	nop
}
  801f15:	c9                   	leave  
  801f16:	c3                   	ret    

00801f17 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f17:	55                   	push   %ebp
  801f18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	6a 0e                	push   $0xe
  801f26:	e8 fd fd ff ff       	call   801d28 <syscall>
  801f2b:	83 c4 18             	add    $0x18,%esp
}
  801f2e:	c9                   	leave  
  801f2f:	c3                   	ret    

00801f30 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f30:	55                   	push   %ebp
  801f31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	ff 75 08             	pushl  0x8(%ebp)
  801f3e:	6a 0f                	push   $0xf
  801f40:	e8 e3 fd ff ff       	call   801d28 <syscall>
  801f45:	83 c4 18             	add    $0x18,%esp
}
  801f48:	c9                   	leave  
  801f49:	c3                   	ret    

00801f4a <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f4a:	55                   	push   %ebp
  801f4b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	6a 10                	push   $0x10
  801f59:	e8 ca fd ff ff       	call   801d28 <syscall>
  801f5e:	83 c4 18             	add    $0x18,%esp
}
  801f61:	90                   	nop
  801f62:	c9                   	leave  
  801f63:	c3                   	ret    

00801f64 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f64:	55                   	push   %ebp
  801f65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 14                	push   $0x14
  801f73:	e8 b0 fd ff ff       	call   801d28 <syscall>
  801f78:	83 c4 18             	add    $0x18,%esp
}
  801f7b:	90                   	nop
  801f7c:	c9                   	leave  
  801f7d:	c3                   	ret    

00801f7e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f7e:	55                   	push   %ebp
  801f7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f81:	6a 00                	push   $0x0
  801f83:	6a 00                	push   $0x0
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 15                	push   $0x15
  801f8d:	e8 96 fd ff ff       	call   801d28 <syscall>
  801f92:	83 c4 18             	add    $0x18,%esp
}
  801f95:	90                   	nop
  801f96:	c9                   	leave  
  801f97:	c3                   	ret    

00801f98 <sys_cputc>:


void
sys_cputc(const char c)
{
  801f98:	55                   	push   %ebp
  801f99:	89 e5                	mov    %esp,%ebp
  801f9b:	83 ec 04             	sub    $0x4,%esp
  801f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801fa4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	50                   	push   %eax
  801fb1:	6a 16                	push   $0x16
  801fb3:	e8 70 fd ff ff       	call   801d28 <syscall>
  801fb8:	83 c4 18             	add    $0x18,%esp
}
  801fbb:	90                   	nop
  801fbc:	c9                   	leave  
  801fbd:	c3                   	ret    

00801fbe <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801fbe:	55                   	push   %ebp
  801fbf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 17                	push   $0x17
  801fcd:	e8 56 fd ff ff       	call   801d28 <syscall>
  801fd2:	83 c4 18             	add    $0x18,%esp
}
  801fd5:	90                   	nop
  801fd6:	c9                   	leave  
  801fd7:	c3                   	ret    

00801fd8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801fd8:	55                   	push   %ebp
  801fd9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 00                	push   $0x0
  801fe4:	ff 75 0c             	pushl  0xc(%ebp)
  801fe7:	50                   	push   %eax
  801fe8:	6a 18                	push   $0x18
  801fea:	e8 39 fd ff ff       	call   801d28 <syscall>
  801fef:	83 c4 18             	add    $0x18,%esp
}
  801ff2:	c9                   	leave  
  801ff3:	c3                   	ret    

00801ff4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ff4:	55                   	push   %ebp
  801ff5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ff7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	52                   	push   %edx
  802004:	50                   	push   %eax
  802005:	6a 1b                	push   $0x1b
  802007:	e8 1c fd ff ff       	call   801d28 <syscall>
  80200c:	83 c4 18             	add    $0x18,%esp
}
  80200f:	c9                   	leave  
  802010:	c3                   	ret    

00802011 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802011:	55                   	push   %ebp
  802012:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802014:	8b 55 0c             	mov    0xc(%ebp),%edx
  802017:	8b 45 08             	mov    0x8(%ebp),%eax
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	52                   	push   %edx
  802021:	50                   	push   %eax
  802022:	6a 19                	push   $0x19
  802024:	e8 ff fc ff ff       	call   801d28 <syscall>
  802029:	83 c4 18             	add    $0x18,%esp
}
  80202c:	90                   	nop
  80202d:	c9                   	leave  
  80202e:	c3                   	ret    

0080202f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80202f:	55                   	push   %ebp
  802030:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802032:	8b 55 0c             	mov    0xc(%ebp),%edx
  802035:	8b 45 08             	mov    0x8(%ebp),%eax
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	52                   	push   %edx
  80203f:	50                   	push   %eax
  802040:	6a 1a                	push   $0x1a
  802042:	e8 e1 fc ff ff       	call   801d28 <syscall>
  802047:	83 c4 18             	add    $0x18,%esp
}
  80204a:	90                   	nop
  80204b:	c9                   	leave  
  80204c:	c3                   	ret    

0080204d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80204d:	55                   	push   %ebp
  80204e:	89 e5                	mov    %esp,%ebp
  802050:	83 ec 04             	sub    $0x4,%esp
  802053:	8b 45 10             	mov    0x10(%ebp),%eax
  802056:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802059:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80205c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802060:	8b 45 08             	mov    0x8(%ebp),%eax
  802063:	6a 00                	push   $0x0
  802065:	51                   	push   %ecx
  802066:	52                   	push   %edx
  802067:	ff 75 0c             	pushl  0xc(%ebp)
  80206a:	50                   	push   %eax
  80206b:	6a 1c                	push   $0x1c
  80206d:	e8 b6 fc ff ff       	call   801d28 <syscall>
  802072:	83 c4 18             	add    $0x18,%esp
}
  802075:	c9                   	leave  
  802076:	c3                   	ret    

00802077 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802077:	55                   	push   %ebp
  802078:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80207a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80207d:	8b 45 08             	mov    0x8(%ebp),%eax
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	52                   	push   %edx
  802087:	50                   	push   %eax
  802088:	6a 1d                	push   $0x1d
  80208a:	e8 99 fc ff ff       	call   801d28 <syscall>
  80208f:	83 c4 18             	add    $0x18,%esp
}
  802092:	c9                   	leave  
  802093:	c3                   	ret    

00802094 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802094:	55                   	push   %ebp
  802095:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802097:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80209a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80209d:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	51                   	push   %ecx
  8020a5:	52                   	push   %edx
  8020a6:	50                   	push   %eax
  8020a7:	6a 1e                	push   $0x1e
  8020a9:	e8 7a fc ff ff       	call   801d28 <syscall>
  8020ae:	83 c4 18             	add    $0x18,%esp
}
  8020b1:	c9                   	leave  
  8020b2:	c3                   	ret    

008020b3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8020b3:	55                   	push   %ebp
  8020b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8020b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 00                	push   $0x0
  8020c2:	52                   	push   %edx
  8020c3:	50                   	push   %eax
  8020c4:	6a 1f                	push   $0x1f
  8020c6:	e8 5d fc ff ff       	call   801d28 <syscall>
  8020cb:	83 c4 18             	add    $0x18,%esp
}
  8020ce:	c9                   	leave  
  8020cf:	c3                   	ret    

008020d0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8020d0:	55                   	push   %ebp
  8020d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 00                	push   $0x0
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 20                	push   $0x20
  8020df:	e8 44 fc ff ff       	call   801d28 <syscall>
  8020e4:	83 c4 18             	add    $0x18,%esp
}
  8020e7:	c9                   	leave  
  8020e8:	c3                   	ret    

008020e9 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8020e9:	55                   	push   %ebp
  8020ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8020ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ef:	6a 00                	push   $0x0
  8020f1:	ff 75 14             	pushl  0x14(%ebp)
  8020f4:	ff 75 10             	pushl  0x10(%ebp)
  8020f7:	ff 75 0c             	pushl  0xc(%ebp)
  8020fa:	50                   	push   %eax
  8020fb:	6a 21                	push   $0x21
  8020fd:	e8 26 fc ff ff       	call   801d28 <syscall>
  802102:	83 c4 18             	add    $0x18,%esp
}
  802105:	c9                   	leave  
  802106:	c3                   	ret    

00802107 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802107:	55                   	push   %ebp
  802108:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80210a:	8b 45 08             	mov    0x8(%ebp),%eax
  80210d:	6a 00                	push   $0x0
  80210f:	6a 00                	push   $0x0
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	50                   	push   %eax
  802116:	6a 22                	push   $0x22
  802118:	e8 0b fc ff ff       	call   801d28 <syscall>
  80211d:	83 c4 18             	add    $0x18,%esp
}
  802120:	90                   	nop
  802121:	c9                   	leave  
  802122:	c3                   	ret    

00802123 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802123:	55                   	push   %ebp
  802124:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802126:	8b 45 08             	mov    0x8(%ebp),%eax
  802129:	6a 00                	push   $0x0
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	50                   	push   %eax
  802132:	6a 23                	push   $0x23
  802134:	e8 ef fb ff ff       	call   801d28 <syscall>
  802139:	83 c4 18             	add    $0x18,%esp
}
  80213c:	90                   	nop
  80213d:	c9                   	leave  
  80213e:	c3                   	ret    

0080213f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80213f:	55                   	push   %ebp
  802140:	89 e5                	mov    %esp,%ebp
  802142:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802145:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802148:	8d 50 04             	lea    0x4(%eax),%edx
  80214b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80214e:	6a 00                	push   $0x0
  802150:	6a 00                	push   $0x0
  802152:	6a 00                	push   $0x0
  802154:	52                   	push   %edx
  802155:	50                   	push   %eax
  802156:	6a 24                	push   $0x24
  802158:	e8 cb fb ff ff       	call   801d28 <syscall>
  80215d:	83 c4 18             	add    $0x18,%esp
	return result;
  802160:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802163:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802166:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802169:	89 01                	mov    %eax,(%ecx)
  80216b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80216e:	8b 45 08             	mov    0x8(%ebp),%eax
  802171:	c9                   	leave  
  802172:	c2 04 00             	ret    $0x4

00802175 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802175:	55                   	push   %ebp
  802176:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	ff 75 10             	pushl  0x10(%ebp)
  80217f:	ff 75 0c             	pushl  0xc(%ebp)
  802182:	ff 75 08             	pushl  0x8(%ebp)
  802185:	6a 13                	push   $0x13
  802187:	e8 9c fb ff ff       	call   801d28 <syscall>
  80218c:	83 c4 18             	add    $0x18,%esp
	return ;
  80218f:	90                   	nop
}
  802190:	c9                   	leave  
  802191:	c3                   	ret    

00802192 <sys_rcr2>:
uint32 sys_rcr2()
{
  802192:	55                   	push   %ebp
  802193:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802195:	6a 00                	push   $0x0
  802197:	6a 00                	push   $0x0
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	6a 25                	push   $0x25
  8021a1:	e8 82 fb ff ff       	call   801d28 <syscall>
  8021a6:	83 c4 18             	add    $0x18,%esp
}
  8021a9:	c9                   	leave  
  8021aa:	c3                   	ret    

008021ab <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8021ab:	55                   	push   %ebp
  8021ac:	89 e5                	mov    %esp,%ebp
  8021ae:	83 ec 04             	sub    $0x4,%esp
  8021b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8021b7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8021bb:	6a 00                	push   $0x0
  8021bd:	6a 00                	push   $0x0
  8021bf:	6a 00                	push   $0x0
  8021c1:	6a 00                	push   $0x0
  8021c3:	50                   	push   %eax
  8021c4:	6a 26                	push   $0x26
  8021c6:	e8 5d fb ff ff       	call   801d28 <syscall>
  8021cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8021ce:	90                   	nop
}
  8021cf:	c9                   	leave  
  8021d0:	c3                   	ret    

008021d1 <rsttst>:
void rsttst()
{
  8021d1:	55                   	push   %ebp
  8021d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 00                	push   $0x0
  8021da:	6a 00                	push   $0x0
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 28                	push   $0x28
  8021e0:	e8 43 fb ff ff       	call   801d28 <syscall>
  8021e5:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e8:	90                   	nop
}
  8021e9:	c9                   	leave  
  8021ea:	c3                   	ret    

008021eb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8021eb:	55                   	push   %ebp
  8021ec:	89 e5                	mov    %esp,%ebp
  8021ee:	83 ec 04             	sub    $0x4,%esp
  8021f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8021f4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8021f7:	8b 55 18             	mov    0x18(%ebp),%edx
  8021fa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021fe:	52                   	push   %edx
  8021ff:	50                   	push   %eax
  802200:	ff 75 10             	pushl  0x10(%ebp)
  802203:	ff 75 0c             	pushl  0xc(%ebp)
  802206:	ff 75 08             	pushl  0x8(%ebp)
  802209:	6a 27                	push   $0x27
  80220b:	e8 18 fb ff ff       	call   801d28 <syscall>
  802210:	83 c4 18             	add    $0x18,%esp
	return ;
  802213:	90                   	nop
}
  802214:	c9                   	leave  
  802215:	c3                   	ret    

00802216 <chktst>:
void chktst(uint32 n)
{
  802216:	55                   	push   %ebp
  802217:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802219:	6a 00                	push   $0x0
  80221b:	6a 00                	push   $0x0
  80221d:	6a 00                	push   $0x0
  80221f:	6a 00                	push   $0x0
  802221:	ff 75 08             	pushl  0x8(%ebp)
  802224:	6a 29                	push   $0x29
  802226:	e8 fd fa ff ff       	call   801d28 <syscall>
  80222b:	83 c4 18             	add    $0x18,%esp
	return ;
  80222e:	90                   	nop
}
  80222f:	c9                   	leave  
  802230:	c3                   	ret    

00802231 <inctst>:

void inctst()
{
  802231:	55                   	push   %ebp
  802232:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802234:	6a 00                	push   $0x0
  802236:	6a 00                	push   $0x0
  802238:	6a 00                	push   $0x0
  80223a:	6a 00                	push   $0x0
  80223c:	6a 00                	push   $0x0
  80223e:	6a 2a                	push   $0x2a
  802240:	e8 e3 fa ff ff       	call   801d28 <syscall>
  802245:	83 c4 18             	add    $0x18,%esp
	return ;
  802248:	90                   	nop
}
  802249:	c9                   	leave  
  80224a:	c3                   	ret    

0080224b <gettst>:
uint32 gettst()
{
  80224b:	55                   	push   %ebp
  80224c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80224e:	6a 00                	push   $0x0
  802250:	6a 00                	push   $0x0
  802252:	6a 00                	push   $0x0
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 2b                	push   $0x2b
  80225a:	e8 c9 fa ff ff       	call   801d28 <syscall>
  80225f:	83 c4 18             	add    $0x18,%esp
}
  802262:	c9                   	leave  
  802263:	c3                   	ret    

00802264 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802264:	55                   	push   %ebp
  802265:	89 e5                	mov    %esp,%ebp
  802267:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80226a:	6a 00                	push   $0x0
  80226c:	6a 00                	push   $0x0
  80226e:	6a 00                	push   $0x0
  802270:	6a 00                	push   $0x0
  802272:	6a 00                	push   $0x0
  802274:	6a 2c                	push   $0x2c
  802276:	e8 ad fa ff ff       	call   801d28 <syscall>
  80227b:	83 c4 18             	add    $0x18,%esp
  80227e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802281:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802285:	75 07                	jne    80228e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802287:	b8 01 00 00 00       	mov    $0x1,%eax
  80228c:	eb 05                	jmp    802293 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80228e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802293:	c9                   	leave  
  802294:	c3                   	ret    

00802295 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802295:	55                   	push   %ebp
  802296:	89 e5                	mov    %esp,%ebp
  802298:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80229b:	6a 00                	push   $0x0
  80229d:	6a 00                	push   $0x0
  80229f:	6a 00                	push   $0x0
  8022a1:	6a 00                	push   $0x0
  8022a3:	6a 00                	push   $0x0
  8022a5:	6a 2c                	push   $0x2c
  8022a7:	e8 7c fa ff ff       	call   801d28 <syscall>
  8022ac:	83 c4 18             	add    $0x18,%esp
  8022af:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8022b2:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8022b6:	75 07                	jne    8022bf <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8022b8:	b8 01 00 00 00       	mov    $0x1,%eax
  8022bd:	eb 05                	jmp    8022c4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8022bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022c4:	c9                   	leave  
  8022c5:	c3                   	ret    

008022c6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8022c6:	55                   	push   %ebp
  8022c7:	89 e5                	mov    %esp,%ebp
  8022c9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022cc:	6a 00                	push   $0x0
  8022ce:	6a 00                	push   $0x0
  8022d0:	6a 00                	push   $0x0
  8022d2:	6a 00                	push   $0x0
  8022d4:	6a 00                	push   $0x0
  8022d6:	6a 2c                	push   $0x2c
  8022d8:	e8 4b fa ff ff       	call   801d28 <syscall>
  8022dd:	83 c4 18             	add    $0x18,%esp
  8022e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8022e3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8022e7:	75 07                	jne    8022f0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8022e9:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ee:	eb 05                	jmp    8022f5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8022f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022f5:	c9                   	leave  
  8022f6:	c3                   	ret    

008022f7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8022f7:	55                   	push   %ebp
  8022f8:	89 e5                	mov    %esp,%ebp
  8022fa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	6a 00                	push   $0x0
  802305:	6a 00                	push   $0x0
  802307:	6a 2c                	push   $0x2c
  802309:	e8 1a fa ff ff       	call   801d28 <syscall>
  80230e:	83 c4 18             	add    $0x18,%esp
  802311:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802314:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802318:	75 07                	jne    802321 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80231a:	b8 01 00 00 00       	mov    $0x1,%eax
  80231f:	eb 05                	jmp    802326 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802321:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802326:	c9                   	leave  
  802327:	c3                   	ret    

00802328 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802328:	55                   	push   %ebp
  802329:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80232b:	6a 00                	push   $0x0
  80232d:	6a 00                	push   $0x0
  80232f:	6a 00                	push   $0x0
  802331:	6a 00                	push   $0x0
  802333:	ff 75 08             	pushl  0x8(%ebp)
  802336:	6a 2d                	push   $0x2d
  802338:	e8 eb f9 ff ff       	call   801d28 <syscall>
  80233d:	83 c4 18             	add    $0x18,%esp
	return ;
  802340:	90                   	nop
}
  802341:	c9                   	leave  
  802342:	c3                   	ret    

00802343 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802343:	55                   	push   %ebp
  802344:	89 e5                	mov    %esp,%ebp
  802346:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802347:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80234a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80234d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802350:	8b 45 08             	mov    0x8(%ebp),%eax
  802353:	6a 00                	push   $0x0
  802355:	53                   	push   %ebx
  802356:	51                   	push   %ecx
  802357:	52                   	push   %edx
  802358:	50                   	push   %eax
  802359:	6a 2e                	push   $0x2e
  80235b:	e8 c8 f9 ff ff       	call   801d28 <syscall>
  802360:	83 c4 18             	add    $0x18,%esp
}
  802363:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802366:	c9                   	leave  
  802367:	c3                   	ret    

00802368 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802368:	55                   	push   %ebp
  802369:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80236b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80236e:	8b 45 08             	mov    0x8(%ebp),%eax
  802371:	6a 00                	push   $0x0
  802373:	6a 00                	push   $0x0
  802375:	6a 00                	push   $0x0
  802377:	52                   	push   %edx
  802378:	50                   	push   %eax
  802379:	6a 2f                	push   $0x2f
  80237b:	e8 a8 f9 ff ff       	call   801d28 <syscall>
  802380:	83 c4 18             	add    $0x18,%esp
}
  802383:	c9                   	leave  
  802384:	c3                   	ret    
  802385:	66 90                	xchg   %ax,%ax
  802387:	90                   	nop

00802388 <__udivdi3>:
  802388:	55                   	push   %ebp
  802389:	57                   	push   %edi
  80238a:	56                   	push   %esi
  80238b:	53                   	push   %ebx
  80238c:	83 ec 1c             	sub    $0x1c,%esp
  80238f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802393:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802397:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80239b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80239f:	89 ca                	mov    %ecx,%edx
  8023a1:	89 f8                	mov    %edi,%eax
  8023a3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023a7:	85 f6                	test   %esi,%esi
  8023a9:	75 2d                	jne    8023d8 <__udivdi3+0x50>
  8023ab:	39 cf                	cmp    %ecx,%edi
  8023ad:	77 65                	ja     802414 <__udivdi3+0x8c>
  8023af:	89 fd                	mov    %edi,%ebp
  8023b1:	85 ff                	test   %edi,%edi
  8023b3:	75 0b                	jne    8023c0 <__udivdi3+0x38>
  8023b5:	b8 01 00 00 00       	mov    $0x1,%eax
  8023ba:	31 d2                	xor    %edx,%edx
  8023bc:	f7 f7                	div    %edi
  8023be:	89 c5                	mov    %eax,%ebp
  8023c0:	31 d2                	xor    %edx,%edx
  8023c2:	89 c8                	mov    %ecx,%eax
  8023c4:	f7 f5                	div    %ebp
  8023c6:	89 c1                	mov    %eax,%ecx
  8023c8:	89 d8                	mov    %ebx,%eax
  8023ca:	f7 f5                	div    %ebp
  8023cc:	89 cf                	mov    %ecx,%edi
  8023ce:	89 fa                	mov    %edi,%edx
  8023d0:	83 c4 1c             	add    $0x1c,%esp
  8023d3:	5b                   	pop    %ebx
  8023d4:	5e                   	pop    %esi
  8023d5:	5f                   	pop    %edi
  8023d6:	5d                   	pop    %ebp
  8023d7:	c3                   	ret    
  8023d8:	39 ce                	cmp    %ecx,%esi
  8023da:	77 28                	ja     802404 <__udivdi3+0x7c>
  8023dc:	0f bd fe             	bsr    %esi,%edi
  8023df:	83 f7 1f             	xor    $0x1f,%edi
  8023e2:	75 40                	jne    802424 <__udivdi3+0x9c>
  8023e4:	39 ce                	cmp    %ecx,%esi
  8023e6:	72 0a                	jb     8023f2 <__udivdi3+0x6a>
  8023e8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8023ec:	0f 87 9e 00 00 00    	ja     802490 <__udivdi3+0x108>
  8023f2:	b8 01 00 00 00       	mov    $0x1,%eax
  8023f7:	89 fa                	mov    %edi,%edx
  8023f9:	83 c4 1c             	add    $0x1c,%esp
  8023fc:	5b                   	pop    %ebx
  8023fd:	5e                   	pop    %esi
  8023fe:	5f                   	pop    %edi
  8023ff:	5d                   	pop    %ebp
  802400:	c3                   	ret    
  802401:	8d 76 00             	lea    0x0(%esi),%esi
  802404:	31 ff                	xor    %edi,%edi
  802406:	31 c0                	xor    %eax,%eax
  802408:	89 fa                	mov    %edi,%edx
  80240a:	83 c4 1c             	add    $0x1c,%esp
  80240d:	5b                   	pop    %ebx
  80240e:	5e                   	pop    %esi
  80240f:	5f                   	pop    %edi
  802410:	5d                   	pop    %ebp
  802411:	c3                   	ret    
  802412:	66 90                	xchg   %ax,%ax
  802414:	89 d8                	mov    %ebx,%eax
  802416:	f7 f7                	div    %edi
  802418:	31 ff                	xor    %edi,%edi
  80241a:	89 fa                	mov    %edi,%edx
  80241c:	83 c4 1c             	add    $0x1c,%esp
  80241f:	5b                   	pop    %ebx
  802420:	5e                   	pop    %esi
  802421:	5f                   	pop    %edi
  802422:	5d                   	pop    %ebp
  802423:	c3                   	ret    
  802424:	bd 20 00 00 00       	mov    $0x20,%ebp
  802429:	89 eb                	mov    %ebp,%ebx
  80242b:	29 fb                	sub    %edi,%ebx
  80242d:	89 f9                	mov    %edi,%ecx
  80242f:	d3 e6                	shl    %cl,%esi
  802431:	89 c5                	mov    %eax,%ebp
  802433:	88 d9                	mov    %bl,%cl
  802435:	d3 ed                	shr    %cl,%ebp
  802437:	89 e9                	mov    %ebp,%ecx
  802439:	09 f1                	or     %esi,%ecx
  80243b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80243f:	89 f9                	mov    %edi,%ecx
  802441:	d3 e0                	shl    %cl,%eax
  802443:	89 c5                	mov    %eax,%ebp
  802445:	89 d6                	mov    %edx,%esi
  802447:	88 d9                	mov    %bl,%cl
  802449:	d3 ee                	shr    %cl,%esi
  80244b:	89 f9                	mov    %edi,%ecx
  80244d:	d3 e2                	shl    %cl,%edx
  80244f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802453:	88 d9                	mov    %bl,%cl
  802455:	d3 e8                	shr    %cl,%eax
  802457:	09 c2                	or     %eax,%edx
  802459:	89 d0                	mov    %edx,%eax
  80245b:	89 f2                	mov    %esi,%edx
  80245d:	f7 74 24 0c          	divl   0xc(%esp)
  802461:	89 d6                	mov    %edx,%esi
  802463:	89 c3                	mov    %eax,%ebx
  802465:	f7 e5                	mul    %ebp
  802467:	39 d6                	cmp    %edx,%esi
  802469:	72 19                	jb     802484 <__udivdi3+0xfc>
  80246b:	74 0b                	je     802478 <__udivdi3+0xf0>
  80246d:	89 d8                	mov    %ebx,%eax
  80246f:	31 ff                	xor    %edi,%edi
  802471:	e9 58 ff ff ff       	jmp    8023ce <__udivdi3+0x46>
  802476:	66 90                	xchg   %ax,%ax
  802478:	8b 54 24 08          	mov    0x8(%esp),%edx
  80247c:	89 f9                	mov    %edi,%ecx
  80247e:	d3 e2                	shl    %cl,%edx
  802480:	39 c2                	cmp    %eax,%edx
  802482:	73 e9                	jae    80246d <__udivdi3+0xe5>
  802484:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802487:	31 ff                	xor    %edi,%edi
  802489:	e9 40 ff ff ff       	jmp    8023ce <__udivdi3+0x46>
  80248e:	66 90                	xchg   %ax,%ax
  802490:	31 c0                	xor    %eax,%eax
  802492:	e9 37 ff ff ff       	jmp    8023ce <__udivdi3+0x46>
  802497:	90                   	nop

00802498 <__umoddi3>:
  802498:	55                   	push   %ebp
  802499:	57                   	push   %edi
  80249a:	56                   	push   %esi
  80249b:	53                   	push   %ebx
  80249c:	83 ec 1c             	sub    $0x1c,%esp
  80249f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024a3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024ab:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8024af:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8024b3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8024b7:	89 f3                	mov    %esi,%ebx
  8024b9:	89 fa                	mov    %edi,%edx
  8024bb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024bf:	89 34 24             	mov    %esi,(%esp)
  8024c2:	85 c0                	test   %eax,%eax
  8024c4:	75 1a                	jne    8024e0 <__umoddi3+0x48>
  8024c6:	39 f7                	cmp    %esi,%edi
  8024c8:	0f 86 a2 00 00 00    	jbe    802570 <__umoddi3+0xd8>
  8024ce:	89 c8                	mov    %ecx,%eax
  8024d0:	89 f2                	mov    %esi,%edx
  8024d2:	f7 f7                	div    %edi
  8024d4:	89 d0                	mov    %edx,%eax
  8024d6:	31 d2                	xor    %edx,%edx
  8024d8:	83 c4 1c             	add    $0x1c,%esp
  8024db:	5b                   	pop    %ebx
  8024dc:	5e                   	pop    %esi
  8024dd:	5f                   	pop    %edi
  8024de:	5d                   	pop    %ebp
  8024df:	c3                   	ret    
  8024e0:	39 f0                	cmp    %esi,%eax
  8024e2:	0f 87 ac 00 00 00    	ja     802594 <__umoddi3+0xfc>
  8024e8:	0f bd e8             	bsr    %eax,%ebp
  8024eb:	83 f5 1f             	xor    $0x1f,%ebp
  8024ee:	0f 84 ac 00 00 00    	je     8025a0 <__umoddi3+0x108>
  8024f4:	bf 20 00 00 00       	mov    $0x20,%edi
  8024f9:	29 ef                	sub    %ebp,%edi
  8024fb:	89 fe                	mov    %edi,%esi
  8024fd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802501:	89 e9                	mov    %ebp,%ecx
  802503:	d3 e0                	shl    %cl,%eax
  802505:	89 d7                	mov    %edx,%edi
  802507:	89 f1                	mov    %esi,%ecx
  802509:	d3 ef                	shr    %cl,%edi
  80250b:	09 c7                	or     %eax,%edi
  80250d:	89 e9                	mov    %ebp,%ecx
  80250f:	d3 e2                	shl    %cl,%edx
  802511:	89 14 24             	mov    %edx,(%esp)
  802514:	89 d8                	mov    %ebx,%eax
  802516:	d3 e0                	shl    %cl,%eax
  802518:	89 c2                	mov    %eax,%edx
  80251a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80251e:	d3 e0                	shl    %cl,%eax
  802520:	89 44 24 04          	mov    %eax,0x4(%esp)
  802524:	8b 44 24 08          	mov    0x8(%esp),%eax
  802528:	89 f1                	mov    %esi,%ecx
  80252a:	d3 e8                	shr    %cl,%eax
  80252c:	09 d0                	or     %edx,%eax
  80252e:	d3 eb                	shr    %cl,%ebx
  802530:	89 da                	mov    %ebx,%edx
  802532:	f7 f7                	div    %edi
  802534:	89 d3                	mov    %edx,%ebx
  802536:	f7 24 24             	mull   (%esp)
  802539:	89 c6                	mov    %eax,%esi
  80253b:	89 d1                	mov    %edx,%ecx
  80253d:	39 d3                	cmp    %edx,%ebx
  80253f:	0f 82 87 00 00 00    	jb     8025cc <__umoddi3+0x134>
  802545:	0f 84 91 00 00 00    	je     8025dc <__umoddi3+0x144>
  80254b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80254f:	29 f2                	sub    %esi,%edx
  802551:	19 cb                	sbb    %ecx,%ebx
  802553:	89 d8                	mov    %ebx,%eax
  802555:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802559:	d3 e0                	shl    %cl,%eax
  80255b:	89 e9                	mov    %ebp,%ecx
  80255d:	d3 ea                	shr    %cl,%edx
  80255f:	09 d0                	or     %edx,%eax
  802561:	89 e9                	mov    %ebp,%ecx
  802563:	d3 eb                	shr    %cl,%ebx
  802565:	89 da                	mov    %ebx,%edx
  802567:	83 c4 1c             	add    $0x1c,%esp
  80256a:	5b                   	pop    %ebx
  80256b:	5e                   	pop    %esi
  80256c:	5f                   	pop    %edi
  80256d:	5d                   	pop    %ebp
  80256e:	c3                   	ret    
  80256f:	90                   	nop
  802570:	89 fd                	mov    %edi,%ebp
  802572:	85 ff                	test   %edi,%edi
  802574:	75 0b                	jne    802581 <__umoddi3+0xe9>
  802576:	b8 01 00 00 00       	mov    $0x1,%eax
  80257b:	31 d2                	xor    %edx,%edx
  80257d:	f7 f7                	div    %edi
  80257f:	89 c5                	mov    %eax,%ebp
  802581:	89 f0                	mov    %esi,%eax
  802583:	31 d2                	xor    %edx,%edx
  802585:	f7 f5                	div    %ebp
  802587:	89 c8                	mov    %ecx,%eax
  802589:	f7 f5                	div    %ebp
  80258b:	89 d0                	mov    %edx,%eax
  80258d:	e9 44 ff ff ff       	jmp    8024d6 <__umoddi3+0x3e>
  802592:	66 90                	xchg   %ax,%ax
  802594:	89 c8                	mov    %ecx,%eax
  802596:	89 f2                	mov    %esi,%edx
  802598:	83 c4 1c             	add    $0x1c,%esp
  80259b:	5b                   	pop    %ebx
  80259c:	5e                   	pop    %esi
  80259d:	5f                   	pop    %edi
  80259e:	5d                   	pop    %ebp
  80259f:	c3                   	ret    
  8025a0:	3b 04 24             	cmp    (%esp),%eax
  8025a3:	72 06                	jb     8025ab <__umoddi3+0x113>
  8025a5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025a9:	77 0f                	ja     8025ba <__umoddi3+0x122>
  8025ab:	89 f2                	mov    %esi,%edx
  8025ad:	29 f9                	sub    %edi,%ecx
  8025af:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8025b3:	89 14 24             	mov    %edx,(%esp)
  8025b6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025ba:	8b 44 24 04          	mov    0x4(%esp),%eax
  8025be:	8b 14 24             	mov    (%esp),%edx
  8025c1:	83 c4 1c             	add    $0x1c,%esp
  8025c4:	5b                   	pop    %ebx
  8025c5:	5e                   	pop    %esi
  8025c6:	5f                   	pop    %edi
  8025c7:	5d                   	pop    %ebp
  8025c8:	c3                   	ret    
  8025c9:	8d 76 00             	lea    0x0(%esi),%esi
  8025cc:	2b 04 24             	sub    (%esp),%eax
  8025cf:	19 fa                	sbb    %edi,%edx
  8025d1:	89 d1                	mov    %edx,%ecx
  8025d3:	89 c6                	mov    %eax,%esi
  8025d5:	e9 71 ff ff ff       	jmp    80254b <__umoddi3+0xb3>
  8025da:	66 90                	xchg   %ax,%ax
  8025dc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8025e0:	72 ea                	jb     8025cc <__umoddi3+0x134>
  8025e2:	89 d9                	mov    %ebx,%ecx
  8025e4:	e9 62 ff ff ff       	jmp    80254b <__umoddi3+0xb3>
