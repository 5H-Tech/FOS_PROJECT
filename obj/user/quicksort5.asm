
obj/user/quicksort5:     file format elf32-i386


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
  800031:	e8 96 06 00 00       	call   8006cc <libmain>
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
  80003c:	81 ec c4 63 00 00    	sub    $0x63c4,%esp
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[25500] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int envID = sys_getenvid();
  800049:	e8 c6 1d 00 00       	call   801e14 <sys_getenvid>
  80004e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_createSemaphore("1", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 60 26 80 00       	push   $0x802660
  80005b:	e8 dc 1f 00 00       	call   80203c <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 90 1e 00 00       	call   801ef8 <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 a2 1e 00 00       	call   801f11 <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();
		sys_waitSemaphore(envID, "1");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 60 26 80 00       	push   $0x802660
  80007f:	ff 75 e8             	pushl  -0x18(%ebp)
  800082:	e8 ee 1f 00 00       	call   802075 <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 64 26 80 00       	push   $0x802664
  800099:	e8 97 10 00 00       	call   801135 <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 e7 15 00 00       	call   80169b <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 7a 19 00 00       	call   801a43 <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 84 26 80 00       	push   $0x802684
  8000d7:	e8 d7 09 00 00       	call   800ab3 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 a7 26 80 00       	push   $0x8026a7
  8000e7:	e8 c7 09 00 00       	call   800ab3 <cprintf>
  8000ec:	83 c4 10             	add    $0x10,%esp
		int ii, j = 0 ;
  8000ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (ii = 0 ; ii < 100000; ii++)
  8000f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000fd:	eb 09                	jmp    800108 <_main+0xd0>
		{
			j+= ii;
  8000ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800102:	01 45 ec             	add    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
		cprintf("a) Ascending\n") ;
		int ii, j = 0 ;
		for (ii = 0 ; ii < 100000; ii++)
  800105:	ff 45 f0             	incl   -0x10(%ebp)
  800108:	81 7d f0 9f 86 01 00 	cmpl   $0x1869f,-0x10(%ebp)
  80010f:	7e ee                	jle    8000ff <_main+0xc7>
		{
			j+= ii;
		}
		cprintf("b) Descending\n") ;
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	68 b5 26 80 00       	push   $0x8026b5
  800119:	e8 95 09 00 00       	call   800ab3 <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 c4 26 80 00       	push   $0x8026c4
  800129:	e8 85 09 00 00       	call   800ab3 <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	68 d4 26 80 00       	push   $0x8026d4
  800139:	e8 75 09 00 00       	call   800ab3 <cprintf>
  80013e:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800141:	e8 2e 05 00 00       	call   800674 <getchar>
  800146:	88 45 db             	mov    %al,-0x25(%ebp)
			cputchar(Chose);
  800149:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80014d:	83 ec 0c             	sub    $0xc,%esp
  800150:	50                   	push   %eax
  800151:	e8 d6 04 00 00       	call   80062c <cputchar>
  800156:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800159:	83 ec 0c             	sub    $0xc,%esp
  80015c:	6a 0a                	push   $0xa
  80015e:	e8 c9 04 00 00       	call   80062c <cputchar>
  800163:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800166:	80 7d db 61          	cmpb   $0x61,-0x25(%ebp)
  80016a:	74 0c                	je     800178 <_main+0x140>
  80016c:	80 7d db 62          	cmpb   $0x62,-0x25(%ebp)
  800170:	74 06                	je     800178 <_main+0x140>
  800172:	80 7d db 63          	cmpb   $0x63,-0x25(%ebp)
  800176:	75 b9                	jne    800131 <_main+0xf9>
		sys_signalSemaphore(envID, "1");
  800178:	83 ec 08             	sub    $0x8,%esp
  80017b:	68 60 26 80 00       	push   $0x802660
  800180:	ff 75 e8             	pushl  -0x18(%ebp)
  800183:	e8 0b 1f 00 00       	call   802093 <sys_signalSemaphore>
  800188:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  80018b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80018f:	83 f8 62             	cmp    $0x62,%eax
  800192:	74 1d                	je     8001b1 <_main+0x179>
  800194:	83 f8 63             	cmp    $0x63,%eax
  800197:	74 2b                	je     8001c4 <_main+0x18c>
  800199:	83 f8 61             	cmp    $0x61,%eax
  80019c:	75 39                	jne    8001d7 <_main+0x19f>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80019e:	83 ec 08             	sub    $0x8,%esp
  8001a1:	ff 75 e0             	pushl  -0x20(%ebp)
  8001a4:	ff 75 dc             	pushl  -0x24(%ebp)
  8001a7:	e8 48 03 00 00       	call   8004f4 <InitializeAscending>
  8001ac:	83 c4 10             	add    $0x10,%esp
			break ;
  8001af:	eb 37                	jmp    8001e8 <_main+0x1b0>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b1:	83 ec 08             	sub    $0x8,%esp
  8001b4:	ff 75 e0             	pushl  -0x20(%ebp)
  8001b7:	ff 75 dc             	pushl  -0x24(%ebp)
  8001ba:	e8 66 03 00 00       	call   800525 <InitializeDescending>
  8001bf:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c2:	eb 24                	jmp    8001e8 <_main+0x1b0>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ca:	ff 75 dc             	pushl  -0x24(%ebp)
  8001cd:	e8 88 03 00 00       	call   80055a <InitializeSemiRandom>
  8001d2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d5:	eb 11                	jmp    8001e8 <_main+0x1b0>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 e0             	pushl  -0x20(%ebp)
  8001dd:	ff 75 dc             	pushl  -0x24(%ebp)
  8001e0:	e8 75 03 00 00       	call   80055a <InitializeSemiRandom>
  8001e5:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001e8:	83 ec 08             	sub    $0x8,%esp
  8001eb:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ee:	ff 75 dc             	pushl  -0x24(%ebp)
  8001f1:	e8 43 01 00 00       	call   800339 <QuickSort>
  8001f6:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f9:	83 ec 08             	sub    $0x8,%esp
  8001fc:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ff:	ff 75 dc             	pushl  -0x24(%ebp)
  800202:	e8 43 02 00 00       	call   80044a <CheckSorted>
  800207:	83 c4 10             	add    $0x10,%esp
  80020a:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80020d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  800211:	75 14                	jne    800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 e0 26 80 00       	push   $0x8026e0
  80021b:	6a 4f                	push   $0x4f
  80021d:	68 02 27 80 00       	push   $0x802702
  800222:	e8 ea 05 00 00       	call   800811 <_panic>
		else
		{
			sys_waitSemaphore(envID, "1");
  800227:	83 ec 08             	sub    $0x8,%esp
  80022a:	68 60 26 80 00       	push   $0x802660
  80022f:	ff 75 e8             	pushl  -0x18(%ebp)
  800232:	e8 3e 1e 00 00       	call   802075 <sys_waitSemaphore>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 14 27 80 00       	push   $0x802714
  800242:	e8 6c 08 00 00       	call   800ab3 <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 48 27 80 00       	push   $0x802748
  800252:	e8 5c 08 00 00       	call   800ab3 <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80025a:	83 ec 0c             	sub    $0xc,%esp
  80025d:	68 7c 27 80 00       	push   $0x80277c
  800262:	e8 4c 08 00 00       	call   800ab3 <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "1");
  80026a:	83 ec 08             	sub    $0x8,%esp
  80026d:	68 60 26 80 00       	push   $0x802660
  800272:	ff 75 e8             	pushl  -0x18(%ebp)
  800275:	e8 19 1e 00 00       	call   802093 <sys_signalSemaphore>
  80027a:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_waitSemaphore(envID, "1");
  80027d:	83 ec 08             	sub    $0x8,%esp
  800280:	68 60 26 80 00       	push   $0x802660
  800285:	ff 75 e8             	pushl  -0x18(%ebp)
  800288:	e8 e8 1d 00 00       	call   802075 <sys_waitSemaphore>
  80028d:	83 c4 10             	add    $0x10,%esp
		cprintf("Freeing the Heap...\n\n") ;
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	68 ae 27 80 00       	push   $0x8027ae
  800298:	e8 16 08 00 00       	call   800ab3 <cprintf>
  80029d:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID, "1");
  8002a0:	83 ec 08             	sub    $0x8,%esp
  8002a3:	68 60 26 80 00       	push   $0x802660
  8002a8:	ff 75 e8             	pushl  -0x18(%ebp)
  8002ab:	e8 e3 1d 00 00       	call   802093 <sys_signalSemaphore>
  8002b0:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  8002b3:	83 ec 0c             	sub    $0xc,%esp
  8002b6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002b9:	e8 16 19 00 00       	call   801bd4 <free>
  8002be:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "1");
  8002c1:	83 ec 08             	sub    $0x8,%esp
  8002c4:	68 60 26 80 00       	push   $0x802660
  8002c9:	ff 75 e8             	pushl  -0x18(%ebp)
  8002cc:	e8 a4 1d 00 00       	call   802075 <sys_waitSemaphore>
  8002d1:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  8002d4:	83 ec 0c             	sub    $0xc,%esp
  8002d7:	68 c4 27 80 00       	push   $0x8027c4
  8002dc:	e8 d2 07 00 00       	call   800ab3 <cprintf>
  8002e1:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  8002e4:	e8 8b 03 00 00       	call   800674 <getchar>
  8002e9:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  8002ec:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8002f0:	83 ec 0c             	sub    $0xc,%esp
  8002f3:	50                   	push   %eax
  8002f4:	e8 33 03 00 00       	call   80062c <cputchar>
  8002f9:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002fc:	83 ec 0c             	sub    $0xc,%esp
  8002ff:	6a 0a                	push   $0xa
  800301:	e8 26 03 00 00       	call   80062c <cputchar>
  800306:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800309:	83 ec 0c             	sub    $0xc,%esp
  80030c:	6a 0a                	push   $0xa
  80030e:	e8 19 03 00 00       	call   80062c <cputchar>
  800313:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID, "1");
  800316:	83 ec 08             	sub    $0x8,%esp
  800319:	68 60 26 80 00       	push   $0x802660
  80031e:	ff 75 e8             	pushl  -0x18(%ebp)
  800321:	e8 6d 1d 00 00       	call   802093 <sys_signalSemaphore>
  800326:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  800329:	80 7d db 79          	cmpb   $0x79,-0x25(%ebp)
  80032d:	0f 84 30 fd ff ff    	je     800063 <_main+0x2b>

}
  800333:	90                   	nop
  800334:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800337:	c9                   	leave  
  800338:	c3                   	ret    

00800339 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  800339:	55                   	push   %ebp
  80033a:	89 e5                	mov    %esp,%ebp
  80033c:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80033f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800342:	48                   	dec    %eax
  800343:	50                   	push   %eax
  800344:	6a 00                	push   $0x0
  800346:	ff 75 0c             	pushl  0xc(%ebp)
  800349:	ff 75 08             	pushl  0x8(%ebp)
  80034c:	e8 06 00 00 00       	call   800357 <QSort>
  800351:	83 c4 10             	add    $0x10,%esp
}
  800354:	90                   	nop
  800355:	c9                   	leave  
  800356:	c3                   	ret    

00800357 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800357:	55                   	push   %ebp
  800358:	89 e5                	mov    %esp,%ebp
  80035a:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80035d:	8b 45 10             	mov    0x10(%ebp),%eax
  800360:	3b 45 14             	cmp    0x14(%ebp),%eax
  800363:	0f 8d de 00 00 00    	jge    800447 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800369:	8b 45 10             	mov    0x10(%ebp),%eax
  80036c:	40                   	inc    %eax
  80036d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800370:	8b 45 14             	mov    0x14(%ebp),%eax
  800373:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800376:	e9 80 00 00 00       	jmp    8003fb <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  80037b:	ff 45 f4             	incl   -0xc(%ebp)
  80037e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800381:	3b 45 14             	cmp    0x14(%ebp),%eax
  800384:	7f 2b                	jg     8003b1 <QSort+0x5a>
  800386:	8b 45 10             	mov    0x10(%ebp),%eax
  800389:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800390:	8b 45 08             	mov    0x8(%ebp),%eax
  800393:	01 d0                	add    %edx,%eax
  800395:	8b 10                	mov    (%eax),%edx
  800397:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80039a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	01 c8                	add    %ecx,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	39 c2                	cmp    %eax,%edx
  8003aa:	7d cf                	jge    80037b <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8003ac:	eb 03                	jmp    8003b1 <QSort+0x5a>
  8003ae:	ff 4d f0             	decl   -0x10(%ebp)
  8003b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8003b7:	7e 26                	jle    8003df <QSort+0x88>
  8003b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8003bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c6:	01 d0                	add    %edx,%eax
  8003c8:	8b 10                	mov    (%eax),%edx
  8003ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d7:	01 c8                	add    %ecx,%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	39 c2                	cmp    %eax,%edx
  8003dd:	7e cf                	jle    8003ae <QSort+0x57>

		if (i <= j)
  8003df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003e5:	7f 14                	jg     8003fb <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8003e7:	83 ec 04             	sub    $0x4,%esp
  8003ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8003ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8003f0:	ff 75 08             	pushl  0x8(%ebp)
  8003f3:	e8 a9 00 00 00       	call   8004a1 <Swap>
  8003f8:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800401:	0f 8e 77 ff ff ff    	jle    80037e <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800407:	83 ec 04             	sub    $0x4,%esp
  80040a:	ff 75 f0             	pushl  -0x10(%ebp)
  80040d:	ff 75 10             	pushl  0x10(%ebp)
  800410:	ff 75 08             	pushl  0x8(%ebp)
  800413:	e8 89 00 00 00       	call   8004a1 <Swap>
  800418:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80041b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80041e:	48                   	dec    %eax
  80041f:	50                   	push   %eax
  800420:	ff 75 10             	pushl  0x10(%ebp)
  800423:	ff 75 0c             	pushl  0xc(%ebp)
  800426:	ff 75 08             	pushl  0x8(%ebp)
  800429:	e8 29 ff ff ff       	call   800357 <QSort>
  80042e:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800431:	ff 75 14             	pushl  0x14(%ebp)
  800434:	ff 75 f4             	pushl  -0xc(%ebp)
  800437:	ff 75 0c             	pushl  0xc(%ebp)
  80043a:	ff 75 08             	pushl  0x8(%ebp)
  80043d:	e8 15 ff ff ff       	call   800357 <QSort>
  800442:	83 c4 10             	add    $0x10,%esp
  800445:	eb 01                	jmp    800448 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800447:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800448:	c9                   	leave  
  800449:	c3                   	ret    

0080044a <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80044a:	55                   	push   %ebp
  80044b:	89 e5                	mov    %esp,%ebp
  80044d:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800450:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800457:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80045e:	eb 33                	jmp    800493 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800460:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800463:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	01 d0                	add    %edx,%eax
  80046f:	8b 10                	mov    (%eax),%edx
  800471:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800474:	40                   	inc    %eax
  800475:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80047c:	8b 45 08             	mov    0x8(%ebp),%eax
  80047f:	01 c8                	add    %ecx,%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	39 c2                	cmp    %eax,%edx
  800485:	7e 09                	jle    800490 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800487:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80048e:	eb 0c                	jmp    80049c <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800490:	ff 45 f8             	incl   -0x8(%ebp)
  800493:	8b 45 0c             	mov    0xc(%ebp),%eax
  800496:	48                   	dec    %eax
  800497:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80049a:	7f c4                	jg     800460 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80049c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80049f:	c9                   	leave  
  8004a0:	c3                   	ret    

008004a1 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8004a1:	55                   	push   %ebp
  8004a2:	89 e5                	mov    %esp,%ebp
  8004a4:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8004a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b4:	01 d0                	add    %edx,%eax
  8004b6:	8b 00                	mov    (%eax),%eax
  8004b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c8:	01 c2                	add    %eax,%edx
  8004ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d7:	01 c8                	add    %ecx,%eax
  8004d9:	8b 00                	mov    (%eax),%eax
  8004db:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8004dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ea:	01 c2                	add    %eax,%edx
  8004ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ef:	89 02                	mov    %eax,(%edx)
}
  8004f1:	90                   	nop
  8004f2:	c9                   	leave  
  8004f3:	c3                   	ret    

008004f4 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004f4:	55                   	push   %ebp
  8004f5:	89 e5                	mov    %esp,%ebp
  8004f7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800501:	eb 17                	jmp    80051a <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800503:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800506:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	01 c2                	add    %eax,%edx
  800512:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800515:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800517:	ff 45 fc             	incl   -0x4(%ebp)
  80051a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80051d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800520:	7c e1                	jl     800503 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800522:	90                   	nop
  800523:	c9                   	leave  
  800524:	c3                   	ret    

00800525 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800525:	55                   	push   %ebp
  800526:	89 e5                	mov    %esp,%ebp
  800528:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80052b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800532:	eb 1b                	jmp    80054f <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800534:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800537:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80053e:	8b 45 08             	mov    0x8(%ebp),%eax
  800541:	01 c2                	add    %eax,%edx
  800543:	8b 45 0c             	mov    0xc(%ebp),%eax
  800546:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800549:	48                   	dec    %eax
  80054a:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80054c:	ff 45 fc             	incl   -0x4(%ebp)
  80054f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800552:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800555:	7c dd                	jl     800534 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800557:	90                   	nop
  800558:	c9                   	leave  
  800559:	c3                   	ret    

0080055a <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80055a:	55                   	push   %ebp
  80055b:	89 e5                	mov    %esp,%ebp
  80055d:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800560:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800563:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800568:	f7 e9                	imul   %ecx
  80056a:	c1 f9 1f             	sar    $0x1f,%ecx
  80056d:	89 d0                	mov    %edx,%eax
  80056f:	29 c8                	sub    %ecx,%eax
  800571:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800574:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80057b:	eb 1e                	jmp    80059b <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80057d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800580:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800587:	8b 45 08             	mov    0x8(%ebp),%eax
  80058a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80058d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800590:	99                   	cltd   
  800591:	f7 7d f8             	idivl  -0x8(%ebp)
  800594:	89 d0                	mov    %edx,%eax
  800596:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800598:	ff 45 fc             	incl   -0x4(%ebp)
  80059b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80059e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005a1:	7c da                	jl     80057d <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8005a3:	90                   	nop
  8005a4:	c9                   	leave  
  8005a5:	c3                   	ret    

008005a6 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8005a6:	55                   	push   %ebp
  8005a7:	89 e5                	mov    %esp,%ebp
  8005a9:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8005ac:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005ba:	eb 42                	jmp    8005fe <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8005bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005bf:	99                   	cltd   
  8005c0:	f7 7d f0             	idivl  -0x10(%ebp)
  8005c3:	89 d0                	mov    %edx,%eax
  8005c5:	85 c0                	test   %eax,%eax
  8005c7:	75 10                	jne    8005d9 <PrintElements+0x33>
			cprintf("\n");
  8005c9:	83 ec 0c             	sub    $0xc,%esp
  8005cc:	68 e2 27 80 00       	push   $0x8027e2
  8005d1:	e8 dd 04 00 00       	call   800ab3 <cprintf>
  8005d6:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8005d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e6:	01 d0                	add    %edx,%eax
  8005e8:	8b 00                	mov    (%eax),%eax
  8005ea:	83 ec 08             	sub    $0x8,%esp
  8005ed:	50                   	push   %eax
  8005ee:	68 e4 27 80 00       	push   $0x8027e4
  8005f3:	e8 bb 04 00 00       	call   800ab3 <cprintf>
  8005f8:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005fb:	ff 45 f4             	incl   -0xc(%ebp)
  8005fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800601:	48                   	dec    %eax
  800602:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800605:	7f b5                	jg     8005bc <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800607:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800611:	8b 45 08             	mov    0x8(%ebp),%eax
  800614:	01 d0                	add    %edx,%eax
  800616:	8b 00                	mov    (%eax),%eax
  800618:	83 ec 08             	sub    $0x8,%esp
  80061b:	50                   	push   %eax
  80061c:	68 e9 27 80 00       	push   $0x8027e9
  800621:	e8 8d 04 00 00       	call   800ab3 <cprintf>
  800626:	83 c4 10             	add    $0x10,%esp

}
  800629:	90                   	nop
  80062a:	c9                   	leave  
  80062b:	c3                   	ret    

0080062c <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80062c:	55                   	push   %ebp
  80062d:	89 e5                	mov    %esp,%ebp
  80062f:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800638:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80063c:	83 ec 0c             	sub    $0xc,%esp
  80063f:	50                   	push   %eax
  800640:	e8 b7 19 00 00       	call   801ffc <sys_cputc>
  800645:	83 c4 10             	add    $0x10,%esp
}
  800648:	90                   	nop
  800649:	c9                   	leave  
  80064a:	c3                   	ret    

0080064b <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80064b:	55                   	push   %ebp
  80064c:	89 e5                	mov    %esp,%ebp
  80064e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800651:	e8 72 19 00 00       	call   801fc8 <sys_disable_interrupt>
	char c = ch;
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80065c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800660:	83 ec 0c             	sub    $0xc,%esp
  800663:	50                   	push   %eax
  800664:	e8 93 19 00 00       	call   801ffc <sys_cputc>
  800669:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80066c:	e8 71 19 00 00       	call   801fe2 <sys_enable_interrupt>
}
  800671:	90                   	nop
  800672:	c9                   	leave  
  800673:	c3                   	ret    

00800674 <getchar>:

int
getchar(void)
{
  800674:	55                   	push   %ebp
  800675:	89 e5                	mov    %esp,%ebp
  800677:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80067a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800681:	eb 08                	jmp    80068b <getchar+0x17>
	{
		c = sys_cgetc();
  800683:	e8 58 17 00 00       	call   801de0 <sys_cgetc>
  800688:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80068b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80068f:	74 f2                	je     800683 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800691:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800694:	c9                   	leave  
  800695:	c3                   	ret    

00800696 <atomic_getchar>:

int
atomic_getchar(void)
{
  800696:	55                   	push   %ebp
  800697:	89 e5                	mov    %esp,%ebp
  800699:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80069c:	e8 27 19 00 00       	call   801fc8 <sys_disable_interrupt>
	int c=0;
  8006a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8006a8:	eb 08                	jmp    8006b2 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8006aa:	e8 31 17 00 00       	call   801de0 <sys_cgetc>
  8006af:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8006b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8006b6:	74 f2                	je     8006aa <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8006b8:	e8 25 19 00 00       	call   801fe2 <sys_enable_interrupt>
	return c;
  8006bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8006c0:	c9                   	leave  
  8006c1:	c3                   	ret    

008006c2 <iscons>:

int iscons(int fdnum)
{
  8006c2:	55                   	push   %ebp
  8006c3:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8006c5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8006ca:	5d                   	pop    %ebp
  8006cb:	c3                   	ret    

008006cc <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006cc:	55                   	push   %ebp
  8006cd:	89 e5                	mov    %esp,%ebp
  8006cf:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006d2:	e8 56 17 00 00       	call   801e2d <sys_getenvindex>
  8006d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006dd:	89 d0                	mov    %edx,%eax
  8006df:	c1 e0 03             	shl    $0x3,%eax
  8006e2:	01 d0                	add    %edx,%eax
  8006e4:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8006eb:	01 c8                	add    %ecx,%eax
  8006ed:	01 c0                	add    %eax,%eax
  8006ef:	01 d0                	add    %edx,%eax
  8006f1:	01 c0                	add    %eax,%eax
  8006f3:	01 d0                	add    %edx,%eax
  8006f5:	89 c2                	mov    %eax,%edx
  8006f7:	c1 e2 05             	shl    $0x5,%edx
  8006fa:	29 c2                	sub    %eax,%edx
  8006fc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800703:	89 c2                	mov    %eax,%edx
  800705:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80070b:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800710:	a1 24 30 80 00       	mov    0x803024,%eax
  800715:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80071b:	84 c0                	test   %al,%al
  80071d:	74 0f                	je     80072e <libmain+0x62>
		binaryname = myEnv->prog_name;
  80071f:	a1 24 30 80 00       	mov    0x803024,%eax
  800724:	05 40 3c 01 00       	add    $0x13c40,%eax
  800729:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80072e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800732:	7e 0a                	jle    80073e <libmain+0x72>
		binaryname = argv[0];
  800734:	8b 45 0c             	mov    0xc(%ebp),%eax
  800737:	8b 00                	mov    (%eax),%eax
  800739:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80073e:	83 ec 08             	sub    $0x8,%esp
  800741:	ff 75 0c             	pushl  0xc(%ebp)
  800744:	ff 75 08             	pushl  0x8(%ebp)
  800747:	e8 ec f8 ff ff       	call   800038 <_main>
  80074c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80074f:	e8 74 18 00 00       	call   801fc8 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800754:	83 ec 0c             	sub    $0xc,%esp
  800757:	68 08 28 80 00       	push   $0x802808
  80075c:	e8 52 03 00 00       	call   800ab3 <cprintf>
  800761:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800764:	a1 24 30 80 00       	mov    0x803024,%eax
  800769:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80076f:	a1 24 30 80 00       	mov    0x803024,%eax
  800774:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80077a:	83 ec 04             	sub    $0x4,%esp
  80077d:	52                   	push   %edx
  80077e:	50                   	push   %eax
  80077f:	68 30 28 80 00       	push   $0x802830
  800784:	e8 2a 03 00 00       	call   800ab3 <cprintf>
  800789:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80078c:	a1 24 30 80 00       	mov    0x803024,%eax
  800791:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800797:	a1 24 30 80 00       	mov    0x803024,%eax
  80079c:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8007a2:	83 ec 04             	sub    $0x4,%esp
  8007a5:	52                   	push   %edx
  8007a6:	50                   	push   %eax
  8007a7:	68 58 28 80 00       	push   $0x802858
  8007ac:	e8 02 03 00 00       	call   800ab3 <cprintf>
  8007b1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8007b4:	a1 24 30 80 00       	mov    0x803024,%eax
  8007b9:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8007bf:	83 ec 08             	sub    $0x8,%esp
  8007c2:	50                   	push   %eax
  8007c3:	68 99 28 80 00       	push   $0x802899
  8007c8:	e8 e6 02 00 00       	call   800ab3 <cprintf>
  8007cd:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8007d0:	83 ec 0c             	sub    $0xc,%esp
  8007d3:	68 08 28 80 00       	push   $0x802808
  8007d8:	e8 d6 02 00 00       	call   800ab3 <cprintf>
  8007dd:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007e0:	e8 fd 17 00 00       	call   801fe2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007e5:	e8 19 00 00 00       	call   800803 <exit>
}
  8007ea:	90                   	nop
  8007eb:	c9                   	leave  
  8007ec:	c3                   	ret    

008007ed <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007ed:	55                   	push   %ebp
  8007ee:	89 e5                	mov    %esp,%ebp
  8007f0:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007f3:	83 ec 0c             	sub    $0xc,%esp
  8007f6:	6a 00                	push   $0x0
  8007f8:	e8 fc 15 00 00       	call   801df9 <sys_env_destroy>
  8007fd:	83 c4 10             	add    $0x10,%esp
}
  800800:	90                   	nop
  800801:	c9                   	leave  
  800802:	c3                   	ret    

00800803 <exit>:

void
exit(void)
{
  800803:	55                   	push   %ebp
  800804:	89 e5                	mov    %esp,%ebp
  800806:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800809:	e8 51 16 00 00       	call   801e5f <sys_env_exit>
}
  80080e:	90                   	nop
  80080f:	c9                   	leave  
  800810:	c3                   	ret    

00800811 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800811:	55                   	push   %ebp
  800812:	89 e5                	mov    %esp,%ebp
  800814:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800817:	8d 45 10             	lea    0x10(%ebp),%eax
  80081a:	83 c0 04             	add    $0x4,%eax
  80081d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800820:	a1 18 31 80 00       	mov    0x803118,%eax
  800825:	85 c0                	test   %eax,%eax
  800827:	74 16                	je     80083f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800829:	a1 18 31 80 00       	mov    0x803118,%eax
  80082e:	83 ec 08             	sub    $0x8,%esp
  800831:	50                   	push   %eax
  800832:	68 b0 28 80 00       	push   $0x8028b0
  800837:	e8 77 02 00 00       	call   800ab3 <cprintf>
  80083c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80083f:	a1 00 30 80 00       	mov    0x803000,%eax
  800844:	ff 75 0c             	pushl  0xc(%ebp)
  800847:	ff 75 08             	pushl  0x8(%ebp)
  80084a:	50                   	push   %eax
  80084b:	68 b5 28 80 00       	push   $0x8028b5
  800850:	e8 5e 02 00 00       	call   800ab3 <cprintf>
  800855:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800858:	8b 45 10             	mov    0x10(%ebp),%eax
  80085b:	83 ec 08             	sub    $0x8,%esp
  80085e:	ff 75 f4             	pushl  -0xc(%ebp)
  800861:	50                   	push   %eax
  800862:	e8 e1 01 00 00       	call   800a48 <vcprintf>
  800867:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80086a:	83 ec 08             	sub    $0x8,%esp
  80086d:	6a 00                	push   $0x0
  80086f:	68 d1 28 80 00       	push   $0x8028d1
  800874:	e8 cf 01 00 00       	call   800a48 <vcprintf>
  800879:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80087c:	e8 82 ff ff ff       	call   800803 <exit>

	// should not return here
	while (1) ;
  800881:	eb fe                	jmp    800881 <_panic+0x70>

00800883 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800883:	55                   	push   %ebp
  800884:	89 e5                	mov    %esp,%ebp
  800886:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800889:	a1 24 30 80 00       	mov    0x803024,%eax
  80088e:	8b 50 74             	mov    0x74(%eax),%edx
  800891:	8b 45 0c             	mov    0xc(%ebp),%eax
  800894:	39 c2                	cmp    %eax,%edx
  800896:	74 14                	je     8008ac <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800898:	83 ec 04             	sub    $0x4,%esp
  80089b:	68 d4 28 80 00       	push   $0x8028d4
  8008a0:	6a 26                	push   $0x26
  8008a2:	68 20 29 80 00       	push   $0x802920
  8008a7:	e8 65 ff ff ff       	call   800811 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008ba:	e9 b6 00 00 00       	jmp    800975 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8008bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cc:	01 d0                	add    %edx,%eax
  8008ce:	8b 00                	mov    (%eax),%eax
  8008d0:	85 c0                	test   %eax,%eax
  8008d2:	75 08                	jne    8008dc <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008d4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008d7:	e9 96 00 00 00       	jmp    800972 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8008dc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008e3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008ea:	eb 5d                	jmp    800949 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008ec:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008f7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008fa:	c1 e2 04             	shl    $0x4,%edx
  8008fd:	01 d0                	add    %edx,%eax
  8008ff:	8a 40 04             	mov    0x4(%eax),%al
  800902:	84 c0                	test   %al,%al
  800904:	75 40                	jne    800946 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800906:	a1 24 30 80 00       	mov    0x803024,%eax
  80090b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800911:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800914:	c1 e2 04             	shl    $0x4,%edx
  800917:	01 d0                	add    %edx,%eax
  800919:	8b 00                	mov    (%eax),%eax
  80091b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80091e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800921:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800926:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800928:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80092b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800932:	8b 45 08             	mov    0x8(%ebp),%eax
  800935:	01 c8                	add    %ecx,%eax
  800937:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800939:	39 c2                	cmp    %eax,%edx
  80093b:	75 09                	jne    800946 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80093d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800944:	eb 12                	jmp    800958 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800946:	ff 45 e8             	incl   -0x18(%ebp)
  800949:	a1 24 30 80 00       	mov    0x803024,%eax
  80094e:	8b 50 74             	mov    0x74(%eax),%edx
  800951:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800954:	39 c2                	cmp    %eax,%edx
  800956:	77 94                	ja     8008ec <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800958:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80095c:	75 14                	jne    800972 <CheckWSWithoutLastIndex+0xef>
			panic(
  80095e:	83 ec 04             	sub    $0x4,%esp
  800961:	68 2c 29 80 00       	push   $0x80292c
  800966:	6a 3a                	push   $0x3a
  800968:	68 20 29 80 00       	push   $0x802920
  80096d:	e8 9f fe ff ff       	call   800811 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800972:	ff 45 f0             	incl   -0x10(%ebp)
  800975:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800978:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80097b:	0f 8c 3e ff ff ff    	jl     8008bf <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800981:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800988:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80098f:	eb 20                	jmp    8009b1 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800991:	a1 24 30 80 00       	mov    0x803024,%eax
  800996:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80099c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80099f:	c1 e2 04             	shl    $0x4,%edx
  8009a2:	01 d0                	add    %edx,%eax
  8009a4:	8a 40 04             	mov    0x4(%eax),%al
  8009a7:	3c 01                	cmp    $0x1,%al
  8009a9:	75 03                	jne    8009ae <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8009ab:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009ae:	ff 45 e0             	incl   -0x20(%ebp)
  8009b1:	a1 24 30 80 00       	mov    0x803024,%eax
  8009b6:	8b 50 74             	mov    0x74(%eax),%edx
  8009b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009bc:	39 c2                	cmp    %eax,%edx
  8009be:	77 d1                	ja     800991 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009c3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009c6:	74 14                	je     8009dc <CheckWSWithoutLastIndex+0x159>
		panic(
  8009c8:	83 ec 04             	sub    $0x4,%esp
  8009cb:	68 80 29 80 00       	push   $0x802980
  8009d0:	6a 44                	push   $0x44
  8009d2:	68 20 29 80 00       	push   $0x802920
  8009d7:	e8 35 fe ff ff       	call   800811 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009dc:	90                   	nop
  8009dd:	c9                   	leave  
  8009de:	c3                   	ret    

008009df <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009df:	55                   	push   %ebp
  8009e0:	89 e5                	mov    %esp,%ebp
  8009e2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e8:	8b 00                	mov    (%eax),%eax
  8009ea:	8d 48 01             	lea    0x1(%eax),%ecx
  8009ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f0:	89 0a                	mov    %ecx,(%edx)
  8009f2:	8b 55 08             	mov    0x8(%ebp),%edx
  8009f5:	88 d1                	mov    %dl,%cl
  8009f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009fa:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a01:	8b 00                	mov    (%eax),%eax
  800a03:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a08:	75 2c                	jne    800a36 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a0a:	a0 28 30 80 00       	mov    0x803028,%al
  800a0f:	0f b6 c0             	movzbl %al,%eax
  800a12:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a15:	8b 12                	mov    (%edx),%edx
  800a17:	89 d1                	mov    %edx,%ecx
  800a19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1c:	83 c2 08             	add    $0x8,%edx
  800a1f:	83 ec 04             	sub    $0x4,%esp
  800a22:	50                   	push   %eax
  800a23:	51                   	push   %ecx
  800a24:	52                   	push   %edx
  800a25:	e8 8d 13 00 00       	call   801db7 <sys_cputs>
  800a2a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a30:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a39:	8b 40 04             	mov    0x4(%eax),%eax
  800a3c:	8d 50 01             	lea    0x1(%eax),%edx
  800a3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a42:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a45:	90                   	nop
  800a46:	c9                   	leave  
  800a47:	c3                   	ret    

00800a48 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a48:	55                   	push   %ebp
  800a49:	89 e5                	mov    %esp,%ebp
  800a4b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a51:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a58:	00 00 00 
	b.cnt = 0;
  800a5b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a62:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a65:	ff 75 0c             	pushl  0xc(%ebp)
  800a68:	ff 75 08             	pushl  0x8(%ebp)
  800a6b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a71:	50                   	push   %eax
  800a72:	68 df 09 80 00       	push   $0x8009df
  800a77:	e8 11 02 00 00       	call   800c8d <vprintfmt>
  800a7c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a7f:	a0 28 30 80 00       	mov    0x803028,%al
  800a84:	0f b6 c0             	movzbl %al,%eax
  800a87:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a8d:	83 ec 04             	sub    $0x4,%esp
  800a90:	50                   	push   %eax
  800a91:	52                   	push   %edx
  800a92:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a98:	83 c0 08             	add    $0x8,%eax
  800a9b:	50                   	push   %eax
  800a9c:	e8 16 13 00 00       	call   801db7 <sys_cputs>
  800aa1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800aa4:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800aab:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800ab1:	c9                   	leave  
  800ab2:	c3                   	ret    

00800ab3 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ab3:	55                   	push   %ebp
  800ab4:	89 e5                	mov    %esp,%ebp
  800ab6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ab9:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800ac0:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ac3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	83 ec 08             	sub    $0x8,%esp
  800acc:	ff 75 f4             	pushl  -0xc(%ebp)
  800acf:	50                   	push   %eax
  800ad0:	e8 73 ff ff ff       	call   800a48 <vcprintf>
  800ad5:	83 c4 10             	add    $0x10,%esp
  800ad8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800adb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ade:	c9                   	leave  
  800adf:	c3                   	ret    

00800ae0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ae0:	55                   	push   %ebp
  800ae1:	89 e5                	mov    %esp,%ebp
  800ae3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ae6:	e8 dd 14 00 00       	call   801fc8 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800aeb:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	83 ec 08             	sub    $0x8,%esp
  800af7:	ff 75 f4             	pushl  -0xc(%ebp)
  800afa:	50                   	push   %eax
  800afb:	e8 48 ff ff ff       	call   800a48 <vcprintf>
  800b00:	83 c4 10             	add    $0x10,%esp
  800b03:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b06:	e8 d7 14 00 00       	call   801fe2 <sys_enable_interrupt>
	return cnt;
  800b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b0e:	c9                   	leave  
  800b0f:	c3                   	ret    

00800b10 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b10:	55                   	push   %ebp
  800b11:	89 e5                	mov    %esp,%ebp
  800b13:	53                   	push   %ebx
  800b14:	83 ec 14             	sub    $0x14,%esp
  800b17:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b20:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b23:	8b 45 18             	mov    0x18(%ebp),%eax
  800b26:	ba 00 00 00 00       	mov    $0x0,%edx
  800b2b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b2e:	77 55                	ja     800b85 <printnum+0x75>
  800b30:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b33:	72 05                	jb     800b3a <printnum+0x2a>
  800b35:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b38:	77 4b                	ja     800b85 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b3a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b3d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b40:	8b 45 18             	mov    0x18(%ebp),%eax
  800b43:	ba 00 00 00 00       	mov    $0x0,%edx
  800b48:	52                   	push   %edx
  800b49:	50                   	push   %eax
  800b4a:	ff 75 f4             	pushl  -0xc(%ebp)
  800b4d:	ff 75 f0             	pushl  -0x10(%ebp)
  800b50:	e8 97 18 00 00       	call   8023ec <__udivdi3>
  800b55:	83 c4 10             	add    $0x10,%esp
  800b58:	83 ec 04             	sub    $0x4,%esp
  800b5b:	ff 75 20             	pushl  0x20(%ebp)
  800b5e:	53                   	push   %ebx
  800b5f:	ff 75 18             	pushl  0x18(%ebp)
  800b62:	52                   	push   %edx
  800b63:	50                   	push   %eax
  800b64:	ff 75 0c             	pushl  0xc(%ebp)
  800b67:	ff 75 08             	pushl  0x8(%ebp)
  800b6a:	e8 a1 ff ff ff       	call   800b10 <printnum>
  800b6f:	83 c4 20             	add    $0x20,%esp
  800b72:	eb 1a                	jmp    800b8e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b74:	83 ec 08             	sub    $0x8,%esp
  800b77:	ff 75 0c             	pushl  0xc(%ebp)
  800b7a:	ff 75 20             	pushl  0x20(%ebp)
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	ff d0                	call   *%eax
  800b82:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b85:	ff 4d 1c             	decl   0x1c(%ebp)
  800b88:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b8c:	7f e6                	jg     800b74 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b8e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b91:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b96:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b99:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b9c:	53                   	push   %ebx
  800b9d:	51                   	push   %ecx
  800b9e:	52                   	push   %edx
  800b9f:	50                   	push   %eax
  800ba0:	e8 57 19 00 00       	call   8024fc <__umoddi3>
  800ba5:	83 c4 10             	add    $0x10,%esp
  800ba8:	05 f4 2b 80 00       	add    $0x802bf4,%eax
  800bad:	8a 00                	mov    (%eax),%al
  800baf:	0f be c0             	movsbl %al,%eax
  800bb2:	83 ec 08             	sub    $0x8,%esp
  800bb5:	ff 75 0c             	pushl  0xc(%ebp)
  800bb8:	50                   	push   %eax
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	ff d0                	call   *%eax
  800bbe:	83 c4 10             	add    $0x10,%esp
}
  800bc1:	90                   	nop
  800bc2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bc5:	c9                   	leave  
  800bc6:	c3                   	ret    

00800bc7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800bc7:	55                   	push   %ebp
  800bc8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bca:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bce:	7e 1c                	jle    800bec <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	8b 00                	mov    (%eax),%eax
  800bd5:	8d 50 08             	lea    0x8(%eax),%edx
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	89 10                	mov    %edx,(%eax)
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	8b 00                	mov    (%eax),%eax
  800be2:	83 e8 08             	sub    $0x8,%eax
  800be5:	8b 50 04             	mov    0x4(%eax),%edx
  800be8:	8b 00                	mov    (%eax),%eax
  800bea:	eb 40                	jmp    800c2c <getuint+0x65>
	else if (lflag)
  800bec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bf0:	74 1e                	je     800c10 <getuint+0x49>
		return va_arg(*ap, unsigned long);
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
  800c0e:	eb 1c                	jmp    800c2c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	8b 00                	mov    (%eax),%eax
  800c15:	8d 50 04             	lea    0x4(%eax),%edx
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	89 10                	mov    %edx,(%eax)
  800c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c20:	8b 00                	mov    (%eax),%eax
  800c22:	83 e8 04             	sub    $0x4,%eax
  800c25:	8b 00                	mov    (%eax),%eax
  800c27:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c2c:	5d                   	pop    %ebp
  800c2d:	c3                   	ret    

00800c2e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c2e:	55                   	push   %ebp
  800c2f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c31:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c35:	7e 1c                	jle    800c53 <getint+0x25>
		return va_arg(*ap, long long);
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	8b 00                	mov    (%eax),%eax
  800c3c:	8d 50 08             	lea    0x8(%eax),%edx
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	89 10                	mov    %edx,(%eax)
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	8b 00                	mov    (%eax),%eax
  800c49:	83 e8 08             	sub    $0x8,%eax
  800c4c:	8b 50 04             	mov    0x4(%eax),%edx
  800c4f:	8b 00                	mov    (%eax),%eax
  800c51:	eb 38                	jmp    800c8b <getint+0x5d>
	else if (lflag)
  800c53:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c57:	74 1a                	je     800c73 <getint+0x45>
		return va_arg(*ap, long);
  800c59:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5c:	8b 00                	mov    (%eax),%eax
  800c5e:	8d 50 04             	lea    0x4(%eax),%edx
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	89 10                	mov    %edx,(%eax)
  800c66:	8b 45 08             	mov    0x8(%ebp),%eax
  800c69:	8b 00                	mov    (%eax),%eax
  800c6b:	83 e8 04             	sub    $0x4,%eax
  800c6e:	8b 00                	mov    (%eax),%eax
  800c70:	99                   	cltd   
  800c71:	eb 18                	jmp    800c8b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	8b 00                	mov    (%eax),%eax
  800c78:	8d 50 04             	lea    0x4(%eax),%edx
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	89 10                	mov    %edx,(%eax)
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	8b 00                	mov    (%eax),%eax
  800c85:	83 e8 04             	sub    $0x4,%eax
  800c88:	8b 00                	mov    (%eax),%eax
  800c8a:	99                   	cltd   
}
  800c8b:	5d                   	pop    %ebp
  800c8c:	c3                   	ret    

00800c8d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c8d:	55                   	push   %ebp
  800c8e:	89 e5                	mov    %esp,%ebp
  800c90:	56                   	push   %esi
  800c91:	53                   	push   %ebx
  800c92:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c95:	eb 17                	jmp    800cae <vprintfmt+0x21>
			if (ch == '\0')
  800c97:	85 db                	test   %ebx,%ebx
  800c99:	0f 84 af 03 00 00    	je     80104e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c9f:	83 ec 08             	sub    $0x8,%esp
  800ca2:	ff 75 0c             	pushl  0xc(%ebp)
  800ca5:	53                   	push   %ebx
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	ff d0                	call   *%eax
  800cab:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800cae:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb1:	8d 50 01             	lea    0x1(%eax),%edx
  800cb4:	89 55 10             	mov    %edx,0x10(%ebp)
  800cb7:	8a 00                	mov    (%eax),%al
  800cb9:	0f b6 d8             	movzbl %al,%ebx
  800cbc:	83 fb 25             	cmp    $0x25,%ebx
  800cbf:	75 d6                	jne    800c97 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800cc1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800cc5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ccc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cd3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cda:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ce1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce4:	8d 50 01             	lea    0x1(%eax),%edx
  800ce7:	89 55 10             	mov    %edx,0x10(%ebp)
  800cea:	8a 00                	mov    (%eax),%al
  800cec:	0f b6 d8             	movzbl %al,%ebx
  800cef:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800cf2:	83 f8 55             	cmp    $0x55,%eax
  800cf5:	0f 87 2b 03 00 00    	ja     801026 <vprintfmt+0x399>
  800cfb:	8b 04 85 18 2c 80 00 	mov    0x802c18(,%eax,4),%eax
  800d02:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d04:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d08:	eb d7                	jmp    800ce1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d0a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d0e:	eb d1                	jmp    800ce1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d10:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d17:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d1a:	89 d0                	mov    %edx,%eax
  800d1c:	c1 e0 02             	shl    $0x2,%eax
  800d1f:	01 d0                	add    %edx,%eax
  800d21:	01 c0                	add    %eax,%eax
  800d23:	01 d8                	add    %ebx,%eax
  800d25:	83 e8 30             	sub    $0x30,%eax
  800d28:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2e:	8a 00                	mov    (%eax),%al
  800d30:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d33:	83 fb 2f             	cmp    $0x2f,%ebx
  800d36:	7e 3e                	jle    800d76 <vprintfmt+0xe9>
  800d38:	83 fb 39             	cmp    $0x39,%ebx
  800d3b:	7f 39                	jg     800d76 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d3d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d40:	eb d5                	jmp    800d17 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d42:	8b 45 14             	mov    0x14(%ebp),%eax
  800d45:	83 c0 04             	add    $0x4,%eax
  800d48:	89 45 14             	mov    %eax,0x14(%ebp)
  800d4b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4e:	83 e8 04             	sub    $0x4,%eax
  800d51:	8b 00                	mov    (%eax),%eax
  800d53:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d56:	eb 1f                	jmp    800d77 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d58:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d5c:	79 83                	jns    800ce1 <vprintfmt+0x54>
				width = 0;
  800d5e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d65:	e9 77 ff ff ff       	jmp    800ce1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d6a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d71:	e9 6b ff ff ff       	jmp    800ce1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d76:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d77:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d7b:	0f 89 60 ff ff ff    	jns    800ce1 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d81:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d84:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d87:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d8e:	e9 4e ff ff ff       	jmp    800ce1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d93:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d96:	e9 46 ff ff ff       	jmp    800ce1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9e:	83 c0 04             	add    $0x4,%eax
  800da1:	89 45 14             	mov    %eax,0x14(%ebp)
  800da4:	8b 45 14             	mov    0x14(%ebp),%eax
  800da7:	83 e8 04             	sub    $0x4,%eax
  800daa:	8b 00                	mov    (%eax),%eax
  800dac:	83 ec 08             	sub    $0x8,%esp
  800daf:	ff 75 0c             	pushl  0xc(%ebp)
  800db2:	50                   	push   %eax
  800db3:	8b 45 08             	mov    0x8(%ebp),%eax
  800db6:	ff d0                	call   *%eax
  800db8:	83 c4 10             	add    $0x10,%esp
			break;
  800dbb:	e9 89 02 00 00       	jmp    801049 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800dc0:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc3:	83 c0 04             	add    $0x4,%eax
  800dc6:	89 45 14             	mov    %eax,0x14(%ebp)
  800dc9:	8b 45 14             	mov    0x14(%ebp),%eax
  800dcc:	83 e8 04             	sub    $0x4,%eax
  800dcf:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dd1:	85 db                	test   %ebx,%ebx
  800dd3:	79 02                	jns    800dd7 <vprintfmt+0x14a>
				err = -err;
  800dd5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800dd7:	83 fb 64             	cmp    $0x64,%ebx
  800dda:	7f 0b                	jg     800de7 <vprintfmt+0x15a>
  800ddc:	8b 34 9d 60 2a 80 00 	mov    0x802a60(,%ebx,4),%esi
  800de3:	85 f6                	test   %esi,%esi
  800de5:	75 19                	jne    800e00 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800de7:	53                   	push   %ebx
  800de8:	68 05 2c 80 00       	push   $0x802c05
  800ded:	ff 75 0c             	pushl  0xc(%ebp)
  800df0:	ff 75 08             	pushl  0x8(%ebp)
  800df3:	e8 5e 02 00 00       	call   801056 <printfmt>
  800df8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800dfb:	e9 49 02 00 00       	jmp    801049 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e00:	56                   	push   %esi
  800e01:	68 0e 2c 80 00       	push   $0x802c0e
  800e06:	ff 75 0c             	pushl  0xc(%ebp)
  800e09:	ff 75 08             	pushl  0x8(%ebp)
  800e0c:	e8 45 02 00 00       	call   801056 <printfmt>
  800e11:	83 c4 10             	add    $0x10,%esp
			break;
  800e14:	e9 30 02 00 00       	jmp    801049 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e19:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1c:	83 c0 04             	add    $0x4,%eax
  800e1f:	89 45 14             	mov    %eax,0x14(%ebp)
  800e22:	8b 45 14             	mov    0x14(%ebp),%eax
  800e25:	83 e8 04             	sub    $0x4,%eax
  800e28:	8b 30                	mov    (%eax),%esi
  800e2a:	85 f6                	test   %esi,%esi
  800e2c:	75 05                	jne    800e33 <vprintfmt+0x1a6>
				p = "(null)";
  800e2e:	be 11 2c 80 00       	mov    $0x802c11,%esi
			if (width > 0 && padc != '-')
  800e33:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e37:	7e 6d                	jle    800ea6 <vprintfmt+0x219>
  800e39:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e3d:	74 67                	je     800ea6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e3f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e42:	83 ec 08             	sub    $0x8,%esp
  800e45:	50                   	push   %eax
  800e46:	56                   	push   %esi
  800e47:	e8 12 05 00 00       	call   80135e <strnlen>
  800e4c:	83 c4 10             	add    $0x10,%esp
  800e4f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e52:	eb 16                	jmp    800e6a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e54:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e58:	83 ec 08             	sub    $0x8,%esp
  800e5b:	ff 75 0c             	pushl  0xc(%ebp)
  800e5e:	50                   	push   %eax
  800e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e62:	ff d0                	call   *%eax
  800e64:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e67:	ff 4d e4             	decl   -0x1c(%ebp)
  800e6a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e6e:	7f e4                	jg     800e54 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e70:	eb 34                	jmp    800ea6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e72:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e76:	74 1c                	je     800e94 <vprintfmt+0x207>
  800e78:	83 fb 1f             	cmp    $0x1f,%ebx
  800e7b:	7e 05                	jle    800e82 <vprintfmt+0x1f5>
  800e7d:	83 fb 7e             	cmp    $0x7e,%ebx
  800e80:	7e 12                	jle    800e94 <vprintfmt+0x207>
					putch('?', putdat);
  800e82:	83 ec 08             	sub    $0x8,%esp
  800e85:	ff 75 0c             	pushl  0xc(%ebp)
  800e88:	6a 3f                	push   $0x3f
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	ff d0                	call   *%eax
  800e8f:	83 c4 10             	add    $0x10,%esp
  800e92:	eb 0f                	jmp    800ea3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e94:	83 ec 08             	sub    $0x8,%esp
  800e97:	ff 75 0c             	pushl  0xc(%ebp)
  800e9a:	53                   	push   %ebx
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	ff d0                	call   *%eax
  800ea0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ea3:	ff 4d e4             	decl   -0x1c(%ebp)
  800ea6:	89 f0                	mov    %esi,%eax
  800ea8:	8d 70 01             	lea    0x1(%eax),%esi
  800eab:	8a 00                	mov    (%eax),%al
  800ead:	0f be d8             	movsbl %al,%ebx
  800eb0:	85 db                	test   %ebx,%ebx
  800eb2:	74 24                	je     800ed8 <vprintfmt+0x24b>
  800eb4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eb8:	78 b8                	js     800e72 <vprintfmt+0x1e5>
  800eba:	ff 4d e0             	decl   -0x20(%ebp)
  800ebd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ec1:	79 af                	jns    800e72 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ec3:	eb 13                	jmp    800ed8 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ec5:	83 ec 08             	sub    $0x8,%esp
  800ec8:	ff 75 0c             	pushl  0xc(%ebp)
  800ecb:	6a 20                	push   $0x20
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	ff d0                	call   *%eax
  800ed2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ed5:	ff 4d e4             	decl   -0x1c(%ebp)
  800ed8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800edc:	7f e7                	jg     800ec5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ede:	e9 66 01 00 00       	jmp    801049 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ee3:	83 ec 08             	sub    $0x8,%esp
  800ee6:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee9:	8d 45 14             	lea    0x14(%ebp),%eax
  800eec:	50                   	push   %eax
  800eed:	e8 3c fd ff ff       	call   800c2e <getint>
  800ef2:	83 c4 10             	add    $0x10,%esp
  800ef5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800efb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800efe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f01:	85 d2                	test   %edx,%edx
  800f03:	79 23                	jns    800f28 <vprintfmt+0x29b>
				putch('-', putdat);
  800f05:	83 ec 08             	sub    $0x8,%esp
  800f08:	ff 75 0c             	pushl  0xc(%ebp)
  800f0b:	6a 2d                	push   $0x2d
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	ff d0                	call   *%eax
  800f12:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f15:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f18:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f1b:	f7 d8                	neg    %eax
  800f1d:	83 d2 00             	adc    $0x0,%edx
  800f20:	f7 da                	neg    %edx
  800f22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f25:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f28:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f2f:	e9 bc 00 00 00       	jmp    800ff0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f34:	83 ec 08             	sub    $0x8,%esp
  800f37:	ff 75 e8             	pushl  -0x18(%ebp)
  800f3a:	8d 45 14             	lea    0x14(%ebp),%eax
  800f3d:	50                   	push   %eax
  800f3e:	e8 84 fc ff ff       	call   800bc7 <getuint>
  800f43:	83 c4 10             	add    $0x10,%esp
  800f46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f49:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f4c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f53:	e9 98 00 00 00       	jmp    800ff0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f58:	83 ec 08             	sub    $0x8,%esp
  800f5b:	ff 75 0c             	pushl  0xc(%ebp)
  800f5e:	6a 58                	push   $0x58
  800f60:	8b 45 08             	mov    0x8(%ebp),%eax
  800f63:	ff d0                	call   *%eax
  800f65:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f68:	83 ec 08             	sub    $0x8,%esp
  800f6b:	ff 75 0c             	pushl  0xc(%ebp)
  800f6e:	6a 58                	push   $0x58
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	ff d0                	call   *%eax
  800f75:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f78:	83 ec 08             	sub    $0x8,%esp
  800f7b:	ff 75 0c             	pushl  0xc(%ebp)
  800f7e:	6a 58                	push   $0x58
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	ff d0                	call   *%eax
  800f85:	83 c4 10             	add    $0x10,%esp
			break;
  800f88:	e9 bc 00 00 00       	jmp    801049 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f8d:	83 ec 08             	sub    $0x8,%esp
  800f90:	ff 75 0c             	pushl  0xc(%ebp)
  800f93:	6a 30                	push   $0x30
  800f95:	8b 45 08             	mov    0x8(%ebp),%eax
  800f98:	ff d0                	call   *%eax
  800f9a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f9d:	83 ec 08             	sub    $0x8,%esp
  800fa0:	ff 75 0c             	pushl  0xc(%ebp)
  800fa3:	6a 78                	push   $0x78
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	ff d0                	call   *%eax
  800faa:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fad:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb0:	83 c0 04             	add    $0x4,%eax
  800fb3:	89 45 14             	mov    %eax,0x14(%ebp)
  800fb6:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb9:	83 e8 04             	sub    $0x4,%eax
  800fbc:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fc8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fcf:	eb 1f                	jmp    800ff0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fd1:	83 ec 08             	sub    $0x8,%esp
  800fd4:	ff 75 e8             	pushl  -0x18(%ebp)
  800fd7:	8d 45 14             	lea    0x14(%ebp),%eax
  800fda:	50                   	push   %eax
  800fdb:	e8 e7 fb ff ff       	call   800bc7 <getuint>
  800fe0:	83 c4 10             	add    $0x10,%esp
  800fe3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fe9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ff0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ff4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ff7:	83 ec 04             	sub    $0x4,%esp
  800ffa:	52                   	push   %edx
  800ffb:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ffe:	50                   	push   %eax
  800fff:	ff 75 f4             	pushl  -0xc(%ebp)
  801002:	ff 75 f0             	pushl  -0x10(%ebp)
  801005:	ff 75 0c             	pushl  0xc(%ebp)
  801008:	ff 75 08             	pushl  0x8(%ebp)
  80100b:	e8 00 fb ff ff       	call   800b10 <printnum>
  801010:	83 c4 20             	add    $0x20,%esp
			break;
  801013:	eb 34                	jmp    801049 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801015:	83 ec 08             	sub    $0x8,%esp
  801018:	ff 75 0c             	pushl  0xc(%ebp)
  80101b:	53                   	push   %ebx
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
  80101f:	ff d0                	call   *%eax
  801021:	83 c4 10             	add    $0x10,%esp
			break;
  801024:	eb 23                	jmp    801049 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801026:	83 ec 08             	sub    $0x8,%esp
  801029:	ff 75 0c             	pushl  0xc(%ebp)
  80102c:	6a 25                	push   $0x25
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	ff d0                	call   *%eax
  801033:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801036:	ff 4d 10             	decl   0x10(%ebp)
  801039:	eb 03                	jmp    80103e <vprintfmt+0x3b1>
  80103b:	ff 4d 10             	decl   0x10(%ebp)
  80103e:	8b 45 10             	mov    0x10(%ebp),%eax
  801041:	48                   	dec    %eax
  801042:	8a 00                	mov    (%eax),%al
  801044:	3c 25                	cmp    $0x25,%al
  801046:	75 f3                	jne    80103b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801048:	90                   	nop
		}
	}
  801049:	e9 47 fc ff ff       	jmp    800c95 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80104e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80104f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801052:	5b                   	pop    %ebx
  801053:	5e                   	pop    %esi
  801054:	5d                   	pop    %ebp
  801055:	c3                   	ret    

00801056 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801056:	55                   	push   %ebp
  801057:	89 e5                	mov    %esp,%ebp
  801059:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80105c:	8d 45 10             	lea    0x10(%ebp),%eax
  80105f:	83 c0 04             	add    $0x4,%eax
  801062:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801065:	8b 45 10             	mov    0x10(%ebp),%eax
  801068:	ff 75 f4             	pushl  -0xc(%ebp)
  80106b:	50                   	push   %eax
  80106c:	ff 75 0c             	pushl  0xc(%ebp)
  80106f:	ff 75 08             	pushl  0x8(%ebp)
  801072:	e8 16 fc ff ff       	call   800c8d <vprintfmt>
  801077:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80107a:	90                   	nop
  80107b:	c9                   	leave  
  80107c:	c3                   	ret    

0080107d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801080:	8b 45 0c             	mov    0xc(%ebp),%eax
  801083:	8b 40 08             	mov    0x8(%eax),%eax
  801086:	8d 50 01             	lea    0x1(%eax),%edx
  801089:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80108f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801092:	8b 10                	mov    (%eax),%edx
  801094:	8b 45 0c             	mov    0xc(%ebp),%eax
  801097:	8b 40 04             	mov    0x4(%eax),%eax
  80109a:	39 c2                	cmp    %eax,%edx
  80109c:	73 12                	jae    8010b0 <sprintputch+0x33>
		*b->buf++ = ch;
  80109e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a1:	8b 00                	mov    (%eax),%eax
  8010a3:	8d 48 01             	lea    0x1(%eax),%ecx
  8010a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a9:	89 0a                	mov    %ecx,(%edx)
  8010ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8010ae:	88 10                	mov    %dl,(%eax)
}
  8010b0:	90                   	nop
  8010b1:	5d                   	pop    %ebp
  8010b2:	c3                   	ret    

008010b3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010b3:	55                   	push   %ebp
  8010b4:	89 e5                	mov    %esp,%ebp
  8010b6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c8:	01 d0                	add    %edx,%eax
  8010ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010d8:	74 06                	je     8010e0 <vsnprintf+0x2d>
  8010da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010de:	7f 07                	jg     8010e7 <vsnprintf+0x34>
		return -E_INVAL;
  8010e0:	b8 03 00 00 00       	mov    $0x3,%eax
  8010e5:	eb 20                	jmp    801107 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010e7:	ff 75 14             	pushl  0x14(%ebp)
  8010ea:	ff 75 10             	pushl  0x10(%ebp)
  8010ed:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010f0:	50                   	push   %eax
  8010f1:	68 7d 10 80 00       	push   $0x80107d
  8010f6:	e8 92 fb ff ff       	call   800c8d <vprintfmt>
  8010fb:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801101:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801104:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801107:	c9                   	leave  
  801108:	c3                   	ret    

00801109 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801109:	55                   	push   %ebp
  80110a:	89 e5                	mov    %esp,%ebp
  80110c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80110f:	8d 45 10             	lea    0x10(%ebp),%eax
  801112:	83 c0 04             	add    $0x4,%eax
  801115:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801118:	8b 45 10             	mov    0x10(%ebp),%eax
  80111b:	ff 75 f4             	pushl  -0xc(%ebp)
  80111e:	50                   	push   %eax
  80111f:	ff 75 0c             	pushl  0xc(%ebp)
  801122:	ff 75 08             	pushl  0x8(%ebp)
  801125:	e8 89 ff ff ff       	call   8010b3 <vsnprintf>
  80112a:	83 c4 10             	add    $0x10,%esp
  80112d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801130:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801133:	c9                   	leave  
  801134:	c3                   	ret    

00801135 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801135:	55                   	push   %ebp
  801136:	89 e5                	mov    %esp,%ebp
  801138:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80113b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80113f:	74 13                	je     801154 <readline+0x1f>
		cprintf("%s", prompt);
  801141:	83 ec 08             	sub    $0x8,%esp
  801144:	ff 75 08             	pushl  0x8(%ebp)
  801147:	68 70 2d 80 00       	push   $0x802d70
  80114c:	e8 62 f9 ff ff       	call   800ab3 <cprintf>
  801151:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801154:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80115b:	83 ec 0c             	sub    $0xc,%esp
  80115e:	6a 00                	push   $0x0
  801160:	e8 5d f5 ff ff       	call   8006c2 <iscons>
  801165:	83 c4 10             	add    $0x10,%esp
  801168:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80116b:	e8 04 f5 ff ff       	call   800674 <getchar>
  801170:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801173:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801177:	79 22                	jns    80119b <readline+0x66>
			if (c != -E_EOF)
  801179:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80117d:	0f 84 ad 00 00 00    	je     801230 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801183:	83 ec 08             	sub    $0x8,%esp
  801186:	ff 75 ec             	pushl  -0x14(%ebp)
  801189:	68 73 2d 80 00       	push   $0x802d73
  80118e:	e8 20 f9 ff ff       	call   800ab3 <cprintf>
  801193:	83 c4 10             	add    $0x10,%esp
			return;
  801196:	e9 95 00 00 00       	jmp    801230 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80119b:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80119f:	7e 34                	jle    8011d5 <readline+0xa0>
  8011a1:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011a8:	7f 2b                	jg     8011d5 <readline+0xa0>
			if (echoing)
  8011aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011ae:	74 0e                	je     8011be <readline+0x89>
				cputchar(c);
  8011b0:	83 ec 0c             	sub    $0xc,%esp
  8011b3:	ff 75 ec             	pushl  -0x14(%ebp)
  8011b6:	e8 71 f4 ff ff       	call   80062c <cputchar>
  8011bb:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011c1:	8d 50 01             	lea    0x1(%eax),%edx
  8011c4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011c7:	89 c2                	mov    %eax,%edx
  8011c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cc:	01 d0                	add    %edx,%eax
  8011ce:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011d1:	88 10                	mov    %dl,(%eax)
  8011d3:	eb 56                	jmp    80122b <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8011d5:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011d9:	75 1f                	jne    8011fa <readline+0xc5>
  8011db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011df:	7e 19                	jle    8011fa <readline+0xc5>
			if (echoing)
  8011e1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011e5:	74 0e                	je     8011f5 <readline+0xc0>
				cputchar(c);
  8011e7:	83 ec 0c             	sub    $0xc,%esp
  8011ea:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ed:	e8 3a f4 ff ff       	call   80062c <cputchar>
  8011f2:	83 c4 10             	add    $0x10,%esp

			i--;
  8011f5:	ff 4d f4             	decl   -0xc(%ebp)
  8011f8:	eb 31                	jmp    80122b <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011fa:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011fe:	74 0a                	je     80120a <readline+0xd5>
  801200:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801204:	0f 85 61 ff ff ff    	jne    80116b <readline+0x36>
			if (echoing)
  80120a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80120e:	74 0e                	je     80121e <readline+0xe9>
				cputchar(c);
  801210:	83 ec 0c             	sub    $0xc,%esp
  801213:	ff 75 ec             	pushl  -0x14(%ebp)
  801216:	e8 11 f4 ff ff       	call   80062c <cputchar>
  80121b:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80121e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801221:	8b 45 0c             	mov    0xc(%ebp),%eax
  801224:	01 d0                	add    %edx,%eax
  801226:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801229:	eb 06                	jmp    801231 <readline+0xfc>
		}
	}
  80122b:	e9 3b ff ff ff       	jmp    80116b <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801230:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801231:	c9                   	leave  
  801232:	c3                   	ret    

00801233 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801233:	55                   	push   %ebp
  801234:	89 e5                	mov    %esp,%ebp
  801236:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801239:	e8 8a 0d 00 00       	call   801fc8 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80123e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801242:	74 13                	je     801257 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801244:	83 ec 08             	sub    $0x8,%esp
  801247:	ff 75 08             	pushl  0x8(%ebp)
  80124a:	68 70 2d 80 00       	push   $0x802d70
  80124f:	e8 5f f8 ff ff       	call   800ab3 <cprintf>
  801254:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801257:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80125e:	83 ec 0c             	sub    $0xc,%esp
  801261:	6a 00                	push   $0x0
  801263:	e8 5a f4 ff ff       	call   8006c2 <iscons>
  801268:	83 c4 10             	add    $0x10,%esp
  80126b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80126e:	e8 01 f4 ff ff       	call   800674 <getchar>
  801273:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801276:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80127a:	79 23                	jns    80129f <atomic_readline+0x6c>
			if (c != -E_EOF)
  80127c:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801280:	74 13                	je     801295 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801282:	83 ec 08             	sub    $0x8,%esp
  801285:	ff 75 ec             	pushl  -0x14(%ebp)
  801288:	68 73 2d 80 00       	push   $0x802d73
  80128d:	e8 21 f8 ff ff       	call   800ab3 <cprintf>
  801292:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801295:	e8 48 0d 00 00       	call   801fe2 <sys_enable_interrupt>
			return;
  80129a:	e9 9a 00 00 00       	jmp    801339 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80129f:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8012a3:	7e 34                	jle    8012d9 <atomic_readline+0xa6>
  8012a5:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8012ac:	7f 2b                	jg     8012d9 <atomic_readline+0xa6>
			if (echoing)
  8012ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012b2:	74 0e                	je     8012c2 <atomic_readline+0x8f>
				cputchar(c);
  8012b4:	83 ec 0c             	sub    $0xc,%esp
  8012b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8012ba:	e8 6d f3 ff ff       	call   80062c <cputchar>
  8012bf:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c5:	8d 50 01             	lea    0x1(%eax),%edx
  8012c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012cb:	89 c2                	mov    %eax,%edx
  8012cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d0:	01 d0                	add    %edx,%eax
  8012d2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012d5:	88 10                	mov    %dl,(%eax)
  8012d7:	eb 5b                	jmp    801334 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8012d9:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012dd:	75 1f                	jne    8012fe <atomic_readline+0xcb>
  8012df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012e3:	7e 19                	jle    8012fe <atomic_readline+0xcb>
			if (echoing)
  8012e5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012e9:	74 0e                	je     8012f9 <atomic_readline+0xc6>
				cputchar(c);
  8012eb:	83 ec 0c             	sub    $0xc,%esp
  8012ee:	ff 75 ec             	pushl  -0x14(%ebp)
  8012f1:	e8 36 f3 ff ff       	call   80062c <cputchar>
  8012f6:	83 c4 10             	add    $0x10,%esp
			i--;
  8012f9:	ff 4d f4             	decl   -0xc(%ebp)
  8012fc:	eb 36                	jmp    801334 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012fe:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801302:	74 0a                	je     80130e <atomic_readline+0xdb>
  801304:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801308:	0f 85 60 ff ff ff    	jne    80126e <atomic_readline+0x3b>
			if (echoing)
  80130e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801312:	74 0e                	je     801322 <atomic_readline+0xef>
				cputchar(c);
  801314:	83 ec 0c             	sub    $0xc,%esp
  801317:	ff 75 ec             	pushl  -0x14(%ebp)
  80131a:	e8 0d f3 ff ff       	call   80062c <cputchar>
  80131f:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801322:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801325:	8b 45 0c             	mov    0xc(%ebp),%eax
  801328:	01 d0                	add    %edx,%eax
  80132a:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80132d:	e8 b0 0c 00 00       	call   801fe2 <sys_enable_interrupt>
			return;
  801332:	eb 05                	jmp    801339 <atomic_readline+0x106>
		}
	}
  801334:	e9 35 ff ff ff       	jmp    80126e <atomic_readline+0x3b>
}
  801339:	c9                   	leave  
  80133a:	c3                   	ret    

0080133b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80133b:	55                   	push   %ebp
  80133c:	89 e5                	mov    %esp,%ebp
  80133e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801341:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801348:	eb 06                	jmp    801350 <strlen+0x15>
		n++;
  80134a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80134d:	ff 45 08             	incl   0x8(%ebp)
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	8a 00                	mov    (%eax),%al
  801355:	84 c0                	test   %al,%al
  801357:	75 f1                	jne    80134a <strlen+0xf>
		n++;
	return n;
  801359:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80135c:	c9                   	leave  
  80135d:	c3                   	ret    

0080135e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80135e:	55                   	push   %ebp
  80135f:	89 e5                	mov    %esp,%ebp
  801361:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801364:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80136b:	eb 09                	jmp    801376 <strnlen+0x18>
		n++;
  80136d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801370:	ff 45 08             	incl   0x8(%ebp)
  801373:	ff 4d 0c             	decl   0xc(%ebp)
  801376:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80137a:	74 09                	je     801385 <strnlen+0x27>
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	84 c0                	test   %al,%al
  801383:	75 e8                	jne    80136d <strnlen+0xf>
		n++;
	return n;
  801385:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801388:	c9                   	leave  
  801389:	c3                   	ret    

0080138a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80138a:	55                   	push   %ebp
  80138b:	89 e5                	mov    %esp,%ebp
  80138d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801396:	90                   	nop
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	8d 50 01             	lea    0x1(%eax),%edx
  80139d:	89 55 08             	mov    %edx,0x8(%ebp)
  8013a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013a6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013a9:	8a 12                	mov    (%edx),%dl
  8013ab:	88 10                	mov    %dl,(%eax)
  8013ad:	8a 00                	mov    (%eax),%al
  8013af:	84 c0                	test   %al,%al
  8013b1:	75 e4                	jne    801397 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013b6:	c9                   	leave  
  8013b7:	c3                   	ret    

008013b8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013b8:	55                   	push   %ebp
  8013b9:	89 e5                	mov    %esp,%ebp
  8013bb:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013cb:	eb 1f                	jmp    8013ec <strncpy+0x34>
		*dst++ = *src;
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	8d 50 01             	lea    0x1(%eax),%edx
  8013d3:	89 55 08             	mov    %edx,0x8(%ebp)
  8013d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d9:	8a 12                	mov    (%edx),%dl
  8013db:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e0:	8a 00                	mov    (%eax),%al
  8013e2:	84 c0                	test   %al,%al
  8013e4:	74 03                	je     8013e9 <strncpy+0x31>
			src++;
  8013e6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013e9:	ff 45 fc             	incl   -0x4(%ebp)
  8013ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ef:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013f2:	72 d9                	jb     8013cd <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013f7:	c9                   	leave  
  8013f8:	c3                   	ret    

008013f9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013f9:	55                   	push   %ebp
  8013fa:	89 e5                	mov    %esp,%ebp
  8013fc:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801405:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801409:	74 30                	je     80143b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80140b:	eb 16                	jmp    801423 <strlcpy+0x2a>
			*dst++ = *src++;
  80140d:	8b 45 08             	mov    0x8(%ebp),%eax
  801410:	8d 50 01             	lea    0x1(%eax),%edx
  801413:	89 55 08             	mov    %edx,0x8(%ebp)
  801416:	8b 55 0c             	mov    0xc(%ebp),%edx
  801419:	8d 4a 01             	lea    0x1(%edx),%ecx
  80141c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80141f:	8a 12                	mov    (%edx),%dl
  801421:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801423:	ff 4d 10             	decl   0x10(%ebp)
  801426:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80142a:	74 09                	je     801435 <strlcpy+0x3c>
  80142c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142f:	8a 00                	mov    (%eax),%al
  801431:	84 c0                	test   %al,%al
  801433:	75 d8                	jne    80140d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80143b:	8b 55 08             	mov    0x8(%ebp),%edx
  80143e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801441:	29 c2                	sub    %eax,%edx
  801443:	89 d0                	mov    %edx,%eax
}
  801445:	c9                   	leave  
  801446:	c3                   	ret    

00801447 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801447:	55                   	push   %ebp
  801448:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80144a:	eb 06                	jmp    801452 <strcmp+0xb>
		p++, q++;
  80144c:	ff 45 08             	incl   0x8(%ebp)
  80144f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
  801455:	8a 00                	mov    (%eax),%al
  801457:	84 c0                	test   %al,%al
  801459:	74 0e                	je     801469 <strcmp+0x22>
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
  80145e:	8a 10                	mov    (%eax),%dl
  801460:	8b 45 0c             	mov    0xc(%ebp),%eax
  801463:	8a 00                	mov    (%eax),%al
  801465:	38 c2                	cmp    %al,%dl
  801467:	74 e3                	je     80144c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801469:	8b 45 08             	mov    0x8(%ebp),%eax
  80146c:	8a 00                	mov    (%eax),%al
  80146e:	0f b6 d0             	movzbl %al,%edx
  801471:	8b 45 0c             	mov    0xc(%ebp),%eax
  801474:	8a 00                	mov    (%eax),%al
  801476:	0f b6 c0             	movzbl %al,%eax
  801479:	29 c2                	sub    %eax,%edx
  80147b:	89 d0                	mov    %edx,%eax
}
  80147d:	5d                   	pop    %ebp
  80147e:	c3                   	ret    

0080147f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80147f:	55                   	push   %ebp
  801480:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801482:	eb 09                	jmp    80148d <strncmp+0xe>
		n--, p++, q++;
  801484:	ff 4d 10             	decl   0x10(%ebp)
  801487:	ff 45 08             	incl   0x8(%ebp)
  80148a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80148d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801491:	74 17                	je     8014aa <strncmp+0x2b>
  801493:	8b 45 08             	mov    0x8(%ebp),%eax
  801496:	8a 00                	mov    (%eax),%al
  801498:	84 c0                	test   %al,%al
  80149a:	74 0e                	je     8014aa <strncmp+0x2b>
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	8a 10                	mov    (%eax),%dl
  8014a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a4:	8a 00                	mov    (%eax),%al
  8014a6:	38 c2                	cmp    %al,%dl
  8014a8:	74 da                	je     801484 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ae:	75 07                	jne    8014b7 <strncmp+0x38>
		return 0;
  8014b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8014b5:	eb 14                	jmp    8014cb <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ba:	8a 00                	mov    (%eax),%al
  8014bc:	0f b6 d0             	movzbl %al,%edx
  8014bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c2:	8a 00                	mov    (%eax),%al
  8014c4:	0f b6 c0             	movzbl %al,%eax
  8014c7:	29 c2                	sub    %eax,%edx
  8014c9:	89 d0                	mov    %edx,%eax
}
  8014cb:	5d                   	pop    %ebp
  8014cc:	c3                   	ret    

008014cd <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
  8014d0:	83 ec 04             	sub    $0x4,%esp
  8014d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014d9:	eb 12                	jmp    8014ed <strchr+0x20>
		if (*s == c)
  8014db:	8b 45 08             	mov    0x8(%ebp),%eax
  8014de:	8a 00                	mov    (%eax),%al
  8014e0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014e3:	75 05                	jne    8014ea <strchr+0x1d>
			return (char *) s;
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	eb 11                	jmp    8014fb <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014ea:	ff 45 08             	incl   0x8(%ebp)
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f0:	8a 00                	mov    (%eax),%al
  8014f2:	84 c0                	test   %al,%al
  8014f4:	75 e5                	jne    8014db <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014f6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014fb:	c9                   	leave  
  8014fc:	c3                   	ret    

008014fd <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014fd:	55                   	push   %ebp
  8014fe:	89 e5                	mov    %esp,%ebp
  801500:	83 ec 04             	sub    $0x4,%esp
  801503:	8b 45 0c             	mov    0xc(%ebp),%eax
  801506:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801509:	eb 0d                	jmp    801518 <strfind+0x1b>
		if (*s == c)
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	8a 00                	mov    (%eax),%al
  801510:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801513:	74 0e                	je     801523 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801515:	ff 45 08             	incl   0x8(%ebp)
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
  80151b:	8a 00                	mov    (%eax),%al
  80151d:	84 c0                	test   %al,%al
  80151f:	75 ea                	jne    80150b <strfind+0xe>
  801521:	eb 01                	jmp    801524 <strfind+0x27>
		if (*s == c)
			break;
  801523:	90                   	nop
	return (char *) s;
  801524:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
  80152c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801535:	8b 45 10             	mov    0x10(%ebp),%eax
  801538:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80153b:	eb 0e                	jmp    80154b <memset+0x22>
		*p++ = c;
  80153d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801540:	8d 50 01             	lea    0x1(%eax),%edx
  801543:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801546:	8b 55 0c             	mov    0xc(%ebp),%edx
  801549:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80154b:	ff 4d f8             	decl   -0x8(%ebp)
  80154e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801552:	79 e9                	jns    80153d <memset+0x14>
		*p++ = c;

	return v;
  801554:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801557:	c9                   	leave  
  801558:	c3                   	ret    

00801559 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801559:	55                   	push   %ebp
  80155a:	89 e5                	mov    %esp,%ebp
  80155c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80155f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801562:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801565:	8b 45 08             	mov    0x8(%ebp),%eax
  801568:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80156b:	eb 16                	jmp    801583 <memcpy+0x2a>
		*d++ = *s++;
  80156d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801570:	8d 50 01             	lea    0x1(%eax),%edx
  801573:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801576:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801579:	8d 4a 01             	lea    0x1(%edx),%ecx
  80157c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80157f:	8a 12                	mov    (%edx),%dl
  801581:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801583:	8b 45 10             	mov    0x10(%ebp),%eax
  801586:	8d 50 ff             	lea    -0x1(%eax),%edx
  801589:	89 55 10             	mov    %edx,0x10(%ebp)
  80158c:	85 c0                	test   %eax,%eax
  80158e:	75 dd                	jne    80156d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801590:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801593:	c9                   	leave  
  801594:	c3                   	ret    

00801595 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801595:	55                   	push   %ebp
  801596:	89 e5                	mov    %esp,%ebp
  801598:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80159b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8015a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015ad:	73 50                	jae    8015ff <memmove+0x6a>
  8015af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b5:	01 d0                	add    %edx,%eax
  8015b7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015ba:	76 43                	jbe    8015ff <memmove+0x6a>
		s += n;
  8015bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bf:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015c8:	eb 10                	jmp    8015da <memmove+0x45>
			*--d = *--s;
  8015ca:	ff 4d f8             	decl   -0x8(%ebp)
  8015cd:	ff 4d fc             	decl   -0x4(%ebp)
  8015d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d3:	8a 10                	mov    (%eax),%dl
  8015d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015da:	8b 45 10             	mov    0x10(%ebp),%eax
  8015dd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015e0:	89 55 10             	mov    %edx,0x10(%ebp)
  8015e3:	85 c0                	test   %eax,%eax
  8015e5:	75 e3                	jne    8015ca <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015e7:	eb 23                	jmp    80160c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ec:	8d 50 01             	lea    0x1(%eax),%edx
  8015ef:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015f8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015fb:	8a 12                	mov    (%edx),%dl
  8015fd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801602:	8d 50 ff             	lea    -0x1(%eax),%edx
  801605:	89 55 10             	mov    %edx,0x10(%ebp)
  801608:	85 c0                	test   %eax,%eax
  80160a:	75 dd                	jne    8015e9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80160f:	c9                   	leave  
  801610:	c3                   	ret    

00801611 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
  801614:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80161d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801620:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801623:	eb 2a                	jmp    80164f <memcmp+0x3e>
		if (*s1 != *s2)
  801625:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801628:	8a 10                	mov    (%eax),%dl
  80162a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80162d:	8a 00                	mov    (%eax),%al
  80162f:	38 c2                	cmp    %al,%dl
  801631:	74 16                	je     801649 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801633:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801636:	8a 00                	mov    (%eax),%al
  801638:	0f b6 d0             	movzbl %al,%edx
  80163b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80163e:	8a 00                	mov    (%eax),%al
  801640:	0f b6 c0             	movzbl %al,%eax
  801643:	29 c2                	sub    %eax,%edx
  801645:	89 d0                	mov    %edx,%eax
  801647:	eb 18                	jmp    801661 <memcmp+0x50>
		s1++, s2++;
  801649:	ff 45 fc             	incl   -0x4(%ebp)
  80164c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80164f:	8b 45 10             	mov    0x10(%ebp),%eax
  801652:	8d 50 ff             	lea    -0x1(%eax),%edx
  801655:	89 55 10             	mov    %edx,0x10(%ebp)
  801658:	85 c0                	test   %eax,%eax
  80165a:	75 c9                	jne    801625 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80165c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801661:	c9                   	leave  
  801662:	c3                   	ret    

00801663 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
  801666:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801669:	8b 55 08             	mov    0x8(%ebp),%edx
  80166c:	8b 45 10             	mov    0x10(%ebp),%eax
  80166f:	01 d0                	add    %edx,%eax
  801671:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801674:	eb 15                	jmp    80168b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	8a 00                	mov    (%eax),%al
  80167b:	0f b6 d0             	movzbl %al,%edx
  80167e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801681:	0f b6 c0             	movzbl %al,%eax
  801684:	39 c2                	cmp    %eax,%edx
  801686:	74 0d                	je     801695 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801688:	ff 45 08             	incl   0x8(%ebp)
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801691:	72 e3                	jb     801676 <memfind+0x13>
  801693:	eb 01                	jmp    801696 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801695:	90                   	nop
	return (void *) s;
  801696:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
  80169e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8016a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016af:	eb 03                	jmp    8016b4 <strtol+0x19>
		s++;
  8016b1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	8a 00                	mov    (%eax),%al
  8016b9:	3c 20                	cmp    $0x20,%al
  8016bb:	74 f4                	je     8016b1 <strtol+0x16>
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	8a 00                	mov    (%eax),%al
  8016c2:	3c 09                	cmp    $0x9,%al
  8016c4:	74 eb                	je     8016b1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c9:	8a 00                	mov    (%eax),%al
  8016cb:	3c 2b                	cmp    $0x2b,%al
  8016cd:	75 05                	jne    8016d4 <strtol+0x39>
		s++;
  8016cf:	ff 45 08             	incl   0x8(%ebp)
  8016d2:	eb 13                	jmp    8016e7 <strtol+0x4c>
	else if (*s == '-')
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	8a 00                	mov    (%eax),%al
  8016d9:	3c 2d                	cmp    $0x2d,%al
  8016db:	75 0a                	jne    8016e7 <strtol+0x4c>
		s++, neg = 1;
  8016dd:	ff 45 08             	incl   0x8(%ebp)
  8016e0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016eb:	74 06                	je     8016f3 <strtol+0x58>
  8016ed:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016f1:	75 20                	jne    801713 <strtol+0x78>
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	8a 00                	mov    (%eax),%al
  8016f8:	3c 30                	cmp    $0x30,%al
  8016fa:	75 17                	jne    801713 <strtol+0x78>
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	40                   	inc    %eax
  801700:	8a 00                	mov    (%eax),%al
  801702:	3c 78                	cmp    $0x78,%al
  801704:	75 0d                	jne    801713 <strtol+0x78>
		s += 2, base = 16;
  801706:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80170a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801711:	eb 28                	jmp    80173b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801713:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801717:	75 15                	jne    80172e <strtol+0x93>
  801719:	8b 45 08             	mov    0x8(%ebp),%eax
  80171c:	8a 00                	mov    (%eax),%al
  80171e:	3c 30                	cmp    $0x30,%al
  801720:	75 0c                	jne    80172e <strtol+0x93>
		s++, base = 8;
  801722:	ff 45 08             	incl   0x8(%ebp)
  801725:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80172c:	eb 0d                	jmp    80173b <strtol+0xa0>
	else if (base == 0)
  80172e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801732:	75 07                	jne    80173b <strtol+0xa0>
		base = 10;
  801734:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80173b:	8b 45 08             	mov    0x8(%ebp),%eax
  80173e:	8a 00                	mov    (%eax),%al
  801740:	3c 2f                	cmp    $0x2f,%al
  801742:	7e 19                	jle    80175d <strtol+0xc2>
  801744:	8b 45 08             	mov    0x8(%ebp),%eax
  801747:	8a 00                	mov    (%eax),%al
  801749:	3c 39                	cmp    $0x39,%al
  80174b:	7f 10                	jg     80175d <strtol+0xc2>
			dig = *s - '0';
  80174d:	8b 45 08             	mov    0x8(%ebp),%eax
  801750:	8a 00                	mov    (%eax),%al
  801752:	0f be c0             	movsbl %al,%eax
  801755:	83 e8 30             	sub    $0x30,%eax
  801758:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80175b:	eb 42                	jmp    80179f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80175d:	8b 45 08             	mov    0x8(%ebp),%eax
  801760:	8a 00                	mov    (%eax),%al
  801762:	3c 60                	cmp    $0x60,%al
  801764:	7e 19                	jle    80177f <strtol+0xe4>
  801766:	8b 45 08             	mov    0x8(%ebp),%eax
  801769:	8a 00                	mov    (%eax),%al
  80176b:	3c 7a                	cmp    $0x7a,%al
  80176d:	7f 10                	jg     80177f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80176f:	8b 45 08             	mov    0x8(%ebp),%eax
  801772:	8a 00                	mov    (%eax),%al
  801774:	0f be c0             	movsbl %al,%eax
  801777:	83 e8 57             	sub    $0x57,%eax
  80177a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80177d:	eb 20                	jmp    80179f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
  801782:	8a 00                	mov    (%eax),%al
  801784:	3c 40                	cmp    $0x40,%al
  801786:	7e 39                	jle    8017c1 <strtol+0x126>
  801788:	8b 45 08             	mov    0x8(%ebp),%eax
  80178b:	8a 00                	mov    (%eax),%al
  80178d:	3c 5a                	cmp    $0x5a,%al
  80178f:	7f 30                	jg     8017c1 <strtol+0x126>
			dig = *s - 'A' + 10;
  801791:	8b 45 08             	mov    0x8(%ebp),%eax
  801794:	8a 00                	mov    (%eax),%al
  801796:	0f be c0             	movsbl %al,%eax
  801799:	83 e8 37             	sub    $0x37,%eax
  80179c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80179f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017a2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8017a5:	7d 19                	jge    8017c0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8017a7:	ff 45 08             	incl   0x8(%ebp)
  8017aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ad:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017b1:	89 c2                	mov    %eax,%edx
  8017b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017b6:	01 d0                	add    %edx,%eax
  8017b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017bb:	e9 7b ff ff ff       	jmp    80173b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017c0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017c5:	74 08                	je     8017cf <strtol+0x134>
		*endptr = (char *) s;
  8017c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8017cd:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017d3:	74 07                	je     8017dc <strtol+0x141>
  8017d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d8:	f7 d8                	neg    %eax
  8017da:	eb 03                	jmp    8017df <strtol+0x144>
  8017dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <ltostr>:

void
ltostr(long value, char *str)
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
  8017e4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017f9:	79 13                	jns    80180e <ltostr+0x2d>
	{
		neg = 1;
  8017fb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801802:	8b 45 0c             	mov    0xc(%ebp),%eax
  801805:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801808:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80180b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80180e:	8b 45 08             	mov    0x8(%ebp),%eax
  801811:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801816:	99                   	cltd   
  801817:	f7 f9                	idiv   %ecx
  801819:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80181c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80181f:	8d 50 01             	lea    0x1(%eax),%edx
  801822:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801825:	89 c2                	mov    %eax,%edx
  801827:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182a:	01 d0                	add    %edx,%eax
  80182c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80182f:	83 c2 30             	add    $0x30,%edx
  801832:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801834:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801837:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80183c:	f7 e9                	imul   %ecx
  80183e:	c1 fa 02             	sar    $0x2,%edx
  801841:	89 c8                	mov    %ecx,%eax
  801843:	c1 f8 1f             	sar    $0x1f,%eax
  801846:	29 c2                	sub    %eax,%edx
  801848:	89 d0                	mov    %edx,%eax
  80184a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80184d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801850:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801855:	f7 e9                	imul   %ecx
  801857:	c1 fa 02             	sar    $0x2,%edx
  80185a:	89 c8                	mov    %ecx,%eax
  80185c:	c1 f8 1f             	sar    $0x1f,%eax
  80185f:	29 c2                	sub    %eax,%edx
  801861:	89 d0                	mov    %edx,%eax
  801863:	c1 e0 02             	shl    $0x2,%eax
  801866:	01 d0                	add    %edx,%eax
  801868:	01 c0                	add    %eax,%eax
  80186a:	29 c1                	sub    %eax,%ecx
  80186c:	89 ca                	mov    %ecx,%edx
  80186e:	85 d2                	test   %edx,%edx
  801870:	75 9c                	jne    80180e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801872:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801879:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187c:	48                   	dec    %eax
  80187d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801880:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801884:	74 3d                	je     8018c3 <ltostr+0xe2>
		start = 1 ;
  801886:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80188d:	eb 34                	jmp    8018c3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80188f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801892:	8b 45 0c             	mov    0xc(%ebp),%eax
  801895:	01 d0                	add    %edx,%eax
  801897:	8a 00                	mov    (%eax),%al
  801899:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80189c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80189f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a2:	01 c2                	add    %eax,%edx
  8018a4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8018a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018aa:	01 c8                	add    %ecx,%eax
  8018ac:	8a 00                	mov    (%eax),%al
  8018ae:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018b0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b6:	01 c2                	add    %eax,%edx
  8018b8:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018bb:	88 02                	mov    %al,(%edx)
		start++ ;
  8018bd:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018c0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018c9:	7c c4                	jl     80188f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018cb:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d1:	01 d0                	add    %edx,%eax
  8018d3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018d6:	90                   	nop
  8018d7:	c9                   	leave  
  8018d8:	c3                   	ret    

008018d9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018d9:	55                   	push   %ebp
  8018da:	89 e5                	mov    %esp,%ebp
  8018dc:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018df:	ff 75 08             	pushl  0x8(%ebp)
  8018e2:	e8 54 fa ff ff       	call   80133b <strlen>
  8018e7:	83 c4 04             	add    $0x4,%esp
  8018ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018ed:	ff 75 0c             	pushl  0xc(%ebp)
  8018f0:	e8 46 fa ff ff       	call   80133b <strlen>
  8018f5:	83 c4 04             	add    $0x4,%esp
  8018f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801902:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801909:	eb 17                	jmp    801922 <strcconcat+0x49>
		final[s] = str1[s] ;
  80190b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80190e:	8b 45 10             	mov    0x10(%ebp),%eax
  801911:	01 c2                	add    %eax,%edx
  801913:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801916:	8b 45 08             	mov    0x8(%ebp),%eax
  801919:	01 c8                	add    %ecx,%eax
  80191b:	8a 00                	mov    (%eax),%al
  80191d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80191f:	ff 45 fc             	incl   -0x4(%ebp)
  801922:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801925:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801928:	7c e1                	jl     80190b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80192a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801931:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801938:	eb 1f                	jmp    801959 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80193a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80193d:	8d 50 01             	lea    0x1(%eax),%edx
  801940:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801943:	89 c2                	mov    %eax,%edx
  801945:	8b 45 10             	mov    0x10(%ebp),%eax
  801948:	01 c2                	add    %eax,%edx
  80194a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80194d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801950:	01 c8                	add    %ecx,%eax
  801952:	8a 00                	mov    (%eax),%al
  801954:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801956:	ff 45 f8             	incl   -0x8(%ebp)
  801959:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80195f:	7c d9                	jl     80193a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801961:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801964:	8b 45 10             	mov    0x10(%ebp),%eax
  801967:	01 d0                	add    %edx,%eax
  801969:	c6 00 00             	movb   $0x0,(%eax)
}
  80196c:	90                   	nop
  80196d:	c9                   	leave  
  80196e:	c3                   	ret    

0080196f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801972:	8b 45 14             	mov    0x14(%ebp),%eax
  801975:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80197b:	8b 45 14             	mov    0x14(%ebp),%eax
  80197e:	8b 00                	mov    (%eax),%eax
  801980:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801987:	8b 45 10             	mov    0x10(%ebp),%eax
  80198a:	01 d0                	add    %edx,%eax
  80198c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801992:	eb 0c                	jmp    8019a0 <strsplit+0x31>
			*string++ = 0;
  801994:	8b 45 08             	mov    0x8(%ebp),%eax
  801997:	8d 50 01             	lea    0x1(%eax),%edx
  80199a:	89 55 08             	mov    %edx,0x8(%ebp)
  80199d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8019a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a3:	8a 00                	mov    (%eax),%al
  8019a5:	84 c0                	test   %al,%al
  8019a7:	74 18                	je     8019c1 <strsplit+0x52>
  8019a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ac:	8a 00                	mov    (%eax),%al
  8019ae:	0f be c0             	movsbl %al,%eax
  8019b1:	50                   	push   %eax
  8019b2:	ff 75 0c             	pushl  0xc(%ebp)
  8019b5:	e8 13 fb ff ff       	call   8014cd <strchr>
  8019ba:	83 c4 08             	add    $0x8,%esp
  8019bd:	85 c0                	test   %eax,%eax
  8019bf:	75 d3                	jne    801994 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	8a 00                	mov    (%eax),%al
  8019c6:	84 c0                	test   %al,%al
  8019c8:	74 5a                	je     801a24 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8019ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8019cd:	8b 00                	mov    (%eax),%eax
  8019cf:	83 f8 0f             	cmp    $0xf,%eax
  8019d2:	75 07                	jne    8019db <strsplit+0x6c>
		{
			return 0;
  8019d4:	b8 00 00 00 00       	mov    $0x0,%eax
  8019d9:	eb 66                	jmp    801a41 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019db:	8b 45 14             	mov    0x14(%ebp),%eax
  8019de:	8b 00                	mov    (%eax),%eax
  8019e0:	8d 48 01             	lea    0x1(%eax),%ecx
  8019e3:	8b 55 14             	mov    0x14(%ebp),%edx
  8019e6:	89 0a                	mov    %ecx,(%edx)
  8019e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f2:	01 c2                	add    %eax,%edx
  8019f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019f9:	eb 03                	jmp    8019fe <strsplit+0x8f>
			string++;
  8019fb:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801a01:	8a 00                	mov    (%eax),%al
  801a03:	84 c0                	test   %al,%al
  801a05:	74 8b                	je     801992 <strsplit+0x23>
  801a07:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0a:	8a 00                	mov    (%eax),%al
  801a0c:	0f be c0             	movsbl %al,%eax
  801a0f:	50                   	push   %eax
  801a10:	ff 75 0c             	pushl  0xc(%ebp)
  801a13:	e8 b5 fa ff ff       	call   8014cd <strchr>
  801a18:	83 c4 08             	add    $0x8,%esp
  801a1b:	85 c0                	test   %eax,%eax
  801a1d:	74 dc                	je     8019fb <strsplit+0x8c>
			string++;
	}
  801a1f:	e9 6e ff ff ff       	jmp    801992 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a24:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a25:	8b 45 14             	mov    0x14(%ebp),%eax
  801a28:	8b 00                	mov    (%eax),%eax
  801a2a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a31:	8b 45 10             	mov    0x10(%ebp),%eax
  801a34:	01 d0                	add    %edx,%eax
  801a36:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a3c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a41:	c9                   	leave  
  801a42:	c3                   	ret    

00801a43 <malloc>:
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size) {
  801a43:	55                   	push   %ebp
  801a44:	89 e5                	mov    %esp,%ebp
  801a46:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801a49:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4c:	c1 e8 0c             	shr    $0xc,%eax
  801a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	//sizeofarray++;
	if (size % PAGE_SIZE != 0)
  801a52:	8b 45 08             	mov    0x8(%ebp),%eax
  801a55:	25 ff 0f 00 00       	and    $0xfff,%eax
  801a5a:	85 c0                	test   %eax,%eax
  801a5c:	74 03                	je     801a61 <malloc+0x1e>
		num++;
  801a5e:	ff 45 f4             	incl   -0xc(%ebp)
//		addresses[sizeofarray] = last_addres;
//		changed[sizeofarray] = 1;
//		sizeofarray++;
//		return (void*) return_addres;
	//} else {
	if (changes == 0) {
  801a61:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a66:	85 c0                	test   %eax,%eax
  801a68:	75 71                	jne    801adb <malloc+0x98>
		sys_allocateMem(last_addres, size);
  801a6a:	a1 04 30 80 00       	mov    0x803004,%eax
  801a6f:	83 ec 08             	sub    $0x8,%esp
  801a72:	ff 75 08             	pushl  0x8(%ebp)
  801a75:	50                   	push   %eax
  801a76:	e8 e4 04 00 00       	call   801f5f <sys_allocateMem>
  801a7b:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801a7e:	a1 04 30 80 00       	mov    0x803004,%eax
  801a83:	89 45 d8             	mov    %eax,-0x28(%ebp)
		last_addres += num * PAGE_SIZE;
  801a86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a89:	c1 e0 0c             	shl    $0xc,%eax
  801a8c:	89 c2                	mov    %eax,%edx
  801a8e:	a1 04 30 80 00       	mov    0x803004,%eax
  801a93:	01 d0                	add    %edx,%eax
  801a95:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801a9a:	a1 30 30 80 00       	mov    0x803030,%eax
  801a9f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801aa2:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801aa9:	a1 30 30 80 00       	mov    0x803030,%eax
  801aae:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801ab1:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  801ab8:	a1 30 30 80 00       	mov    0x803030,%eax
  801abd:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801ac4:	01 00 00 00 
		sizeofarray++;
  801ac8:	a1 30 30 80 00       	mov    0x803030,%eax
  801acd:	40                   	inc    %eax
  801ace:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) return_addres;
  801ad3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801ad6:	e9 f7 00 00 00       	jmp    801bd2 <malloc+0x18f>
	} else {
		int count = 0;
  801adb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 1000;
  801ae2:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
		int index = -1;
  801ae9:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  801af0:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801af7:	eb 7c                	jmp    801b75 <malloc+0x132>
		{
			uint32 *pg = NULL;
  801af9:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
			for (int j = 0; j < sizeofarray; j++) {
  801b00:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801b07:	eb 1a                	jmp    801b23 <malloc+0xe0>
				if (addresses[j] == i) {
  801b09:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b0c:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b13:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801b16:	75 08                	jne    801b20 <malloc+0xdd>
					index = j;
  801b18:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b1b:	89 45 e8             	mov    %eax,-0x18(%ebp)
					break;
  801b1e:	eb 0d                	jmp    801b2d <malloc+0xea>
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
		{
			uint32 *pg = NULL;
			for (int j = 0; j < sizeofarray; j++) {
  801b20:	ff 45 dc             	incl   -0x24(%ebp)
  801b23:	a1 30 30 80 00       	mov    0x803030,%eax
  801b28:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801b2b:	7c dc                	jl     801b09 <malloc+0xc6>
					index = j;
					break;
				}
			}

			if (index == -1) {
  801b2d:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801b31:	75 05                	jne    801b38 <malloc+0xf5>
				count++;
  801b33:	ff 45 f0             	incl   -0x10(%ebp)
  801b36:	eb 36                	jmp    801b6e <malloc+0x12b>
			} else {
				if (changed[index] == 0) {
  801b38:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b3b:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801b42:	85 c0                	test   %eax,%eax
  801b44:	75 05                	jne    801b4b <malloc+0x108>
					count++;
  801b46:	ff 45 f0             	incl   -0x10(%ebp)
  801b49:	eb 23                	jmp    801b6e <malloc+0x12b>
				} else {
					if (count < min && count >= num) {
  801b4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b4e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801b51:	7d 14                	jge    801b67 <malloc+0x124>
  801b53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b56:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b59:	7c 0c                	jl     801b67 <malloc+0x124>
						min = count;
  801b5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b5e:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss = i;
  801b61:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b64:	89 45 e4             	mov    %eax,-0x1c(%ebp)
					}
					count = 0;
  801b67:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	} else {
		int count = 0;
		int min = 1000;
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  801b6e:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801b75:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801b7c:	0f 86 77 ff ff ff    	jbe    801af9 <malloc+0xb6>

			}

		}

		sys_allocateMem(min_addresss, size);
  801b82:	83 ec 08             	sub    $0x8,%esp
  801b85:	ff 75 08             	pushl  0x8(%ebp)
  801b88:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b8b:	e8 cf 03 00 00       	call   801f5f <sys_allocateMem>
  801b90:	83 c4 10             	add    $0x10,%esp
		numOfPages[sizeofarray] = num;
  801b93:	a1 30 30 80 00       	mov    0x803030,%eax
  801b98:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b9b:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = last_addres;
  801ba2:	a1 30 30 80 00       	mov    0x803030,%eax
  801ba7:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801bad:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  801bb4:	a1 30 30 80 00       	mov    0x803030,%eax
  801bb9:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801bc0:	01 00 00 00 
		sizeofarray++;
  801bc4:	a1 30 30 80 00       	mov    0x803030,%eax
  801bc9:	40                   	inc    %eax
  801bca:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) min_addresss;
  801bcf:	8b 45 e4             	mov    -0x1c(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801bd2:	c9                   	leave  
  801bd3:	c3                   	ret    

00801bd4 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
  801bd7:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801bda:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdd:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801be0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801be7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801bee:	eb 30                	jmp    801c20 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801bf0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bf3:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801bfa:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801bfd:	75 1e                	jne    801c1d <free+0x49>
  801bff:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c02:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c09:	83 f8 01             	cmp    $0x1,%eax
  801c0c:	75 0f                	jne    801c1d <free+0x49>
			is_found = 1;
  801c0e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801c15:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c18:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801c1b:	eb 0d                	jmp    801c2a <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801c1d:	ff 45 ec             	incl   -0x14(%ebp)
  801c20:	a1 30 30 80 00       	mov    0x803030,%eax
  801c25:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801c28:	7c c6                	jl     801bf0 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801c2a:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801c2e:	75 4f                	jne    801c7f <free+0xab>
		size = numOfPages[index] * PAGE_SIZE;
  801c30:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c33:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801c3a:	c1 e0 0c             	shl    $0xc,%eax
  801c3d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801c40:	83 ec 08             	sub    $0x8,%esp
  801c43:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c46:	68 84 2d 80 00       	push   $0x802d84
  801c4b:	e8 63 ee ff ff       	call   800ab3 <cprintf>
  801c50:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801c53:	83 ec 08             	sub    $0x8,%esp
  801c56:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c59:	ff 75 e8             	pushl  -0x18(%ebp)
  801c5c:	e8 e2 02 00 00       	call   801f43 <sys_freeMem>
  801c61:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801c64:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c67:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801c6e:	00 00 00 00 
		changes++;
  801c72:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c77:	40                   	inc    %eax
  801c78:	a3 2c 30 80 00       	mov    %eax,0x80302c
		sys_freeMem(va, size);
		changed[index] = 0;
	}

	//refer to the project presentation and documentation for details
}
  801c7d:	eb 39                	jmp    801cb8 <free+0xe4>
		cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	} else {
		size = 513 * PAGE_SIZE;
  801c7f:	c7 45 e4 00 10 20 00 	movl   $0x201000,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801c86:	83 ec 08             	sub    $0x8,%esp
  801c89:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c8c:	68 84 2d 80 00       	push   $0x802d84
  801c91:	e8 1d ee ff ff       	call   800ab3 <cprintf>
  801c96:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801c99:	83 ec 08             	sub    $0x8,%esp
  801c9c:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c9f:	ff 75 e8             	pushl  -0x18(%ebp)
  801ca2:	e8 9c 02 00 00       	call   801f43 <sys_freeMem>
  801ca7:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801caa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cad:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801cb4:	00 00 00 00 
	}

	//refer to the project presentation and documentation for details
}
  801cb8:	90                   	nop
  801cb9:	c9                   	leave  
  801cba:	c3                   	ret    

00801cbb <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801cbb:	55                   	push   %ebp
  801cbc:	89 e5                	mov    %esp,%ebp
  801cbe:	83 ec 18             	sub    $0x18,%esp
  801cc1:	8b 45 10             	mov    0x10(%ebp),%eax
  801cc4:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801cc7:	83 ec 04             	sub    $0x4,%esp
  801cca:	68 a4 2d 80 00       	push   $0x802da4
  801ccf:	68 9d 00 00 00       	push   $0x9d
  801cd4:	68 c7 2d 80 00       	push   $0x802dc7
  801cd9:	e8 33 eb ff ff       	call   800811 <_panic>

00801cde <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801cde:	55                   	push   %ebp
  801cdf:	89 e5                	mov    %esp,%ebp
  801ce1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ce4:	83 ec 04             	sub    $0x4,%esp
  801ce7:	68 a4 2d 80 00       	push   $0x802da4
  801cec:	68 a2 00 00 00       	push   $0xa2
  801cf1:	68 c7 2d 80 00       	push   $0x802dc7
  801cf6:	e8 16 eb ff ff       	call   800811 <_panic>

00801cfb <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801cfb:	55                   	push   %ebp
  801cfc:	89 e5                	mov    %esp,%ebp
  801cfe:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d01:	83 ec 04             	sub    $0x4,%esp
  801d04:	68 a4 2d 80 00       	push   $0x802da4
  801d09:	68 a7 00 00 00       	push   $0xa7
  801d0e:	68 c7 2d 80 00       	push   $0x802dc7
  801d13:	e8 f9 ea ff ff       	call   800811 <_panic>

00801d18 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801d18:	55                   	push   %ebp
  801d19:	89 e5                	mov    %esp,%ebp
  801d1b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d1e:	83 ec 04             	sub    $0x4,%esp
  801d21:	68 a4 2d 80 00       	push   $0x802da4
  801d26:	68 ab 00 00 00       	push   $0xab
  801d2b:	68 c7 2d 80 00       	push   $0x802dc7
  801d30:	e8 dc ea ff ff       	call   800811 <_panic>

00801d35 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801d35:	55                   	push   %ebp
  801d36:	89 e5                	mov    %esp,%ebp
  801d38:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d3b:	83 ec 04             	sub    $0x4,%esp
  801d3e:	68 a4 2d 80 00       	push   $0x802da4
  801d43:	68 b0 00 00 00       	push   $0xb0
  801d48:	68 c7 2d 80 00       	push   $0x802dc7
  801d4d:	e8 bf ea ff ff       	call   800811 <_panic>

00801d52 <shrink>:
}
void shrink(uint32 newSize) {
  801d52:	55                   	push   %ebp
  801d53:	89 e5                	mov    %esp,%ebp
  801d55:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d58:	83 ec 04             	sub    $0x4,%esp
  801d5b:	68 a4 2d 80 00       	push   $0x802da4
  801d60:	68 b3 00 00 00       	push   $0xb3
  801d65:	68 c7 2d 80 00       	push   $0x802dc7
  801d6a:	e8 a2 ea ff ff       	call   800811 <_panic>

00801d6f <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801d6f:	55                   	push   %ebp
  801d70:	89 e5                	mov    %esp,%ebp
  801d72:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d75:	83 ec 04             	sub    $0x4,%esp
  801d78:	68 a4 2d 80 00       	push   $0x802da4
  801d7d:	68 b7 00 00 00       	push   $0xb7
  801d82:	68 c7 2d 80 00       	push   $0x802dc7
  801d87:	e8 85 ea ff ff       	call   800811 <_panic>

00801d8c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d8c:	55                   	push   %ebp
  801d8d:	89 e5                	mov    %esp,%ebp
  801d8f:	57                   	push   %edi
  801d90:	56                   	push   %esi
  801d91:	53                   	push   %ebx
  801d92:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d95:	8b 45 08             	mov    0x8(%ebp),%eax
  801d98:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d9e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801da1:	8b 7d 18             	mov    0x18(%ebp),%edi
  801da4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801da7:	cd 30                	int    $0x30
  801da9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801dac:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801daf:	83 c4 10             	add    $0x10,%esp
  801db2:	5b                   	pop    %ebx
  801db3:	5e                   	pop    %esi
  801db4:	5f                   	pop    %edi
  801db5:	5d                   	pop    %ebp
  801db6:	c3                   	ret    

00801db7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801db7:	55                   	push   %ebp
  801db8:	89 e5                	mov    %esp,%ebp
  801dba:	83 ec 04             	sub    $0x4,%esp
  801dbd:	8b 45 10             	mov    0x10(%ebp),%eax
  801dc0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801dc3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	52                   	push   %edx
  801dcf:	ff 75 0c             	pushl  0xc(%ebp)
  801dd2:	50                   	push   %eax
  801dd3:	6a 00                	push   $0x0
  801dd5:	e8 b2 ff ff ff       	call   801d8c <syscall>
  801dda:	83 c4 18             	add    $0x18,%esp
}
  801ddd:	90                   	nop
  801dde:	c9                   	leave  
  801ddf:	c3                   	ret    

00801de0 <sys_cgetc>:

int
sys_cgetc(void)
{
  801de0:	55                   	push   %ebp
  801de1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	6a 01                	push   $0x1
  801def:	e8 98 ff ff ff       	call   801d8c <syscall>
  801df4:	83 c4 18             	add    $0x18,%esp
}
  801df7:	c9                   	leave  
  801df8:	c3                   	ret    

00801df9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801df9:	55                   	push   %ebp
  801dfa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	50                   	push   %eax
  801e08:	6a 05                	push   $0x5
  801e0a:	e8 7d ff ff ff       	call   801d8c <syscall>
  801e0f:	83 c4 18             	add    $0x18,%esp
}
  801e12:	c9                   	leave  
  801e13:	c3                   	ret    

00801e14 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e14:	55                   	push   %ebp
  801e15:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 02                	push   $0x2
  801e23:	e8 64 ff ff ff       	call   801d8c <syscall>
  801e28:	83 c4 18             	add    $0x18,%esp
}
  801e2b:	c9                   	leave  
  801e2c:	c3                   	ret    

00801e2d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e2d:	55                   	push   %ebp
  801e2e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 03                	push   $0x3
  801e3c:	e8 4b ff ff ff       	call   801d8c <syscall>
  801e41:	83 c4 18             	add    $0x18,%esp
}
  801e44:	c9                   	leave  
  801e45:	c3                   	ret    

00801e46 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e46:	55                   	push   %ebp
  801e47:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 04                	push   $0x4
  801e55:	e8 32 ff ff ff       	call   801d8c <syscall>
  801e5a:	83 c4 18             	add    $0x18,%esp
}
  801e5d:	c9                   	leave  
  801e5e:	c3                   	ret    

00801e5f <sys_env_exit>:


void sys_env_exit(void)
{
  801e5f:	55                   	push   %ebp
  801e60:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	6a 00                	push   $0x0
  801e6c:	6a 06                	push   $0x6
  801e6e:	e8 19 ff ff ff       	call   801d8c <syscall>
  801e73:	83 c4 18             	add    $0x18,%esp
}
  801e76:	90                   	nop
  801e77:	c9                   	leave  
  801e78:	c3                   	ret    

00801e79 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e79:	55                   	push   %ebp
  801e7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	6a 00                	push   $0x0
  801e88:	52                   	push   %edx
  801e89:	50                   	push   %eax
  801e8a:	6a 07                	push   $0x7
  801e8c:	e8 fb fe ff ff       	call   801d8c <syscall>
  801e91:	83 c4 18             	add    $0x18,%esp
}
  801e94:	c9                   	leave  
  801e95:	c3                   	ret    

00801e96 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e96:	55                   	push   %ebp
  801e97:	89 e5                	mov    %esp,%ebp
  801e99:	56                   	push   %esi
  801e9a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e9b:	8b 75 18             	mov    0x18(%ebp),%esi
  801e9e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ea1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ea4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eaa:	56                   	push   %esi
  801eab:	53                   	push   %ebx
  801eac:	51                   	push   %ecx
  801ead:	52                   	push   %edx
  801eae:	50                   	push   %eax
  801eaf:	6a 08                	push   $0x8
  801eb1:	e8 d6 fe ff ff       	call   801d8c <syscall>
  801eb6:	83 c4 18             	add    $0x18,%esp
}
  801eb9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ebc:	5b                   	pop    %ebx
  801ebd:	5e                   	pop    %esi
  801ebe:	5d                   	pop    %ebp
  801ebf:	c3                   	ret    

00801ec0 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ec0:	55                   	push   %ebp
  801ec1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ec3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	52                   	push   %edx
  801ed0:	50                   	push   %eax
  801ed1:	6a 09                	push   $0x9
  801ed3:	e8 b4 fe ff ff       	call   801d8c <syscall>
  801ed8:	83 c4 18             	add    $0x18,%esp
}
  801edb:	c9                   	leave  
  801edc:	c3                   	ret    

00801edd <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801edd:	55                   	push   %ebp
  801ede:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	ff 75 0c             	pushl  0xc(%ebp)
  801ee9:	ff 75 08             	pushl  0x8(%ebp)
  801eec:	6a 0a                	push   $0xa
  801eee:	e8 99 fe ff ff       	call   801d8c <syscall>
  801ef3:	83 c4 18             	add    $0x18,%esp
}
  801ef6:	c9                   	leave  
  801ef7:	c3                   	ret    

00801ef8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ef8:	55                   	push   %ebp
  801ef9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	6a 00                	push   $0x0
  801f05:	6a 0b                	push   $0xb
  801f07:	e8 80 fe ff ff       	call   801d8c <syscall>
  801f0c:	83 c4 18             	add    $0x18,%esp
}
  801f0f:	c9                   	leave  
  801f10:	c3                   	ret    

00801f11 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 0c                	push   $0xc
  801f20:	e8 67 fe ff ff       	call   801d8c <syscall>
  801f25:	83 c4 18             	add    $0x18,%esp
}
  801f28:	c9                   	leave  
  801f29:	c3                   	ret    

00801f2a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f2a:	55                   	push   %ebp
  801f2b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 0d                	push   $0xd
  801f39:	e8 4e fe ff ff       	call   801d8c <syscall>
  801f3e:	83 c4 18             	add    $0x18,%esp
}
  801f41:	c9                   	leave  
  801f42:	c3                   	ret    

00801f43 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f43:	55                   	push   %ebp
  801f44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 00                	push   $0x0
  801f4c:	ff 75 0c             	pushl  0xc(%ebp)
  801f4f:	ff 75 08             	pushl  0x8(%ebp)
  801f52:	6a 11                	push   $0x11
  801f54:	e8 33 fe ff ff       	call   801d8c <syscall>
  801f59:	83 c4 18             	add    $0x18,%esp
	return;
  801f5c:	90                   	nop
}
  801f5d:	c9                   	leave  
  801f5e:	c3                   	ret    

00801f5f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f5f:	55                   	push   %ebp
  801f60:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	ff 75 0c             	pushl  0xc(%ebp)
  801f6b:	ff 75 08             	pushl  0x8(%ebp)
  801f6e:	6a 12                	push   $0x12
  801f70:	e8 17 fe ff ff       	call   801d8c <syscall>
  801f75:	83 c4 18             	add    $0x18,%esp
	return ;
  801f78:	90                   	nop
}
  801f79:	c9                   	leave  
  801f7a:	c3                   	ret    

00801f7b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f7b:	55                   	push   %ebp
  801f7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	6a 0e                	push   $0xe
  801f8a:	e8 fd fd ff ff       	call   801d8c <syscall>
  801f8f:	83 c4 18             	add    $0x18,%esp
}
  801f92:	c9                   	leave  
  801f93:	c3                   	ret    

00801f94 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f94:	55                   	push   %ebp
  801f95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f97:	6a 00                	push   $0x0
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	ff 75 08             	pushl  0x8(%ebp)
  801fa2:	6a 0f                	push   $0xf
  801fa4:	e8 e3 fd ff ff       	call   801d8c <syscall>
  801fa9:	83 c4 18             	add    $0x18,%esp
}
  801fac:	c9                   	leave  
  801fad:	c3                   	ret    

00801fae <sys_scarce_memory>:

void sys_scarce_memory()
{
  801fae:	55                   	push   %ebp
  801faf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 10                	push   $0x10
  801fbd:	e8 ca fd ff ff       	call   801d8c <syscall>
  801fc2:	83 c4 18             	add    $0x18,%esp
}
  801fc5:	90                   	nop
  801fc6:	c9                   	leave  
  801fc7:	c3                   	ret    

00801fc8 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801fc8:	55                   	push   %ebp
  801fc9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 14                	push   $0x14
  801fd7:	e8 b0 fd ff ff       	call   801d8c <syscall>
  801fdc:	83 c4 18             	add    $0x18,%esp
}
  801fdf:	90                   	nop
  801fe0:	c9                   	leave  
  801fe1:	c3                   	ret    

00801fe2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801fe2:	55                   	push   %ebp
  801fe3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 00                	push   $0x0
  801fed:	6a 00                	push   $0x0
  801fef:	6a 15                	push   $0x15
  801ff1:	e8 96 fd ff ff       	call   801d8c <syscall>
  801ff6:	83 c4 18             	add    $0x18,%esp
}
  801ff9:	90                   	nop
  801ffa:	c9                   	leave  
  801ffb:	c3                   	ret    

00801ffc <sys_cputc>:


void
sys_cputc(const char c)
{
  801ffc:	55                   	push   %ebp
  801ffd:	89 e5                	mov    %esp,%ebp
  801fff:	83 ec 04             	sub    $0x4,%esp
  802002:	8b 45 08             	mov    0x8(%ebp),%eax
  802005:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802008:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	50                   	push   %eax
  802015:	6a 16                	push   $0x16
  802017:	e8 70 fd ff ff       	call   801d8c <syscall>
  80201c:	83 c4 18             	add    $0x18,%esp
}
  80201f:	90                   	nop
  802020:	c9                   	leave  
  802021:	c3                   	ret    

00802022 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802022:	55                   	push   %ebp
  802023:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802025:	6a 00                	push   $0x0
  802027:	6a 00                	push   $0x0
  802029:	6a 00                	push   $0x0
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	6a 17                	push   $0x17
  802031:	e8 56 fd ff ff       	call   801d8c <syscall>
  802036:	83 c4 18             	add    $0x18,%esp
}
  802039:	90                   	nop
  80203a:	c9                   	leave  
  80203b:	c3                   	ret    

0080203c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80203c:	55                   	push   %ebp
  80203d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80203f:	8b 45 08             	mov    0x8(%ebp),%eax
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	ff 75 0c             	pushl  0xc(%ebp)
  80204b:	50                   	push   %eax
  80204c:	6a 18                	push   $0x18
  80204e:	e8 39 fd ff ff       	call   801d8c <syscall>
  802053:	83 c4 18             	add    $0x18,%esp
}
  802056:	c9                   	leave  
  802057:	c3                   	ret    

00802058 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802058:	55                   	push   %ebp
  802059:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80205b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80205e:	8b 45 08             	mov    0x8(%ebp),%eax
  802061:	6a 00                	push   $0x0
  802063:	6a 00                	push   $0x0
  802065:	6a 00                	push   $0x0
  802067:	52                   	push   %edx
  802068:	50                   	push   %eax
  802069:	6a 1b                	push   $0x1b
  80206b:	e8 1c fd ff ff       	call   801d8c <syscall>
  802070:	83 c4 18             	add    $0x18,%esp
}
  802073:	c9                   	leave  
  802074:	c3                   	ret    

00802075 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802075:	55                   	push   %ebp
  802076:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802078:	8b 55 0c             	mov    0xc(%ebp),%edx
  80207b:	8b 45 08             	mov    0x8(%ebp),%eax
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	52                   	push   %edx
  802085:	50                   	push   %eax
  802086:	6a 19                	push   $0x19
  802088:	e8 ff fc ff ff       	call   801d8c <syscall>
  80208d:	83 c4 18             	add    $0x18,%esp
}
  802090:	90                   	nop
  802091:	c9                   	leave  
  802092:	c3                   	ret    

00802093 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802093:	55                   	push   %ebp
  802094:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802096:	8b 55 0c             	mov    0xc(%ebp),%edx
  802099:	8b 45 08             	mov    0x8(%ebp),%eax
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	52                   	push   %edx
  8020a3:	50                   	push   %eax
  8020a4:	6a 1a                	push   $0x1a
  8020a6:	e8 e1 fc ff ff       	call   801d8c <syscall>
  8020ab:	83 c4 18             	add    $0x18,%esp
}
  8020ae:	90                   	nop
  8020af:	c9                   	leave  
  8020b0:	c3                   	ret    

008020b1 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8020b1:	55                   	push   %ebp
  8020b2:	89 e5                	mov    %esp,%ebp
  8020b4:	83 ec 04             	sub    $0x4,%esp
  8020b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8020ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8020bd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8020c0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c7:	6a 00                	push   $0x0
  8020c9:	51                   	push   %ecx
  8020ca:	52                   	push   %edx
  8020cb:	ff 75 0c             	pushl  0xc(%ebp)
  8020ce:	50                   	push   %eax
  8020cf:	6a 1c                	push   $0x1c
  8020d1:	e8 b6 fc ff ff       	call   801d8c <syscall>
  8020d6:	83 c4 18             	add    $0x18,%esp
}
  8020d9:	c9                   	leave  
  8020da:	c3                   	ret    

008020db <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8020db:	55                   	push   %ebp
  8020dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8020de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 00                	push   $0x0
  8020ea:	52                   	push   %edx
  8020eb:	50                   	push   %eax
  8020ec:	6a 1d                	push   $0x1d
  8020ee:	e8 99 fc ff ff       	call   801d8c <syscall>
  8020f3:	83 c4 18             	add    $0x18,%esp
}
  8020f6:	c9                   	leave  
  8020f7:	c3                   	ret    

008020f8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8020f8:	55                   	push   %ebp
  8020f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8020fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  802101:	8b 45 08             	mov    0x8(%ebp),%eax
  802104:	6a 00                	push   $0x0
  802106:	6a 00                	push   $0x0
  802108:	51                   	push   %ecx
  802109:	52                   	push   %edx
  80210a:	50                   	push   %eax
  80210b:	6a 1e                	push   $0x1e
  80210d:	e8 7a fc ff ff       	call   801d8c <syscall>
  802112:	83 c4 18             	add    $0x18,%esp
}
  802115:	c9                   	leave  
  802116:	c3                   	ret    

00802117 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802117:	55                   	push   %ebp
  802118:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80211a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80211d:	8b 45 08             	mov    0x8(%ebp),%eax
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	52                   	push   %edx
  802127:	50                   	push   %eax
  802128:	6a 1f                	push   $0x1f
  80212a:	e8 5d fc ff ff       	call   801d8c <syscall>
  80212f:	83 c4 18             	add    $0x18,%esp
}
  802132:	c9                   	leave  
  802133:	c3                   	ret    

00802134 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802134:	55                   	push   %ebp
  802135:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802137:	6a 00                	push   $0x0
  802139:	6a 00                	push   $0x0
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	6a 20                	push   $0x20
  802143:	e8 44 fc ff ff       	call   801d8c <syscall>
  802148:	83 c4 18             	add    $0x18,%esp
}
  80214b:	c9                   	leave  
  80214c:	c3                   	ret    

0080214d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80214d:	55                   	push   %ebp
  80214e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802150:	8b 45 08             	mov    0x8(%ebp),%eax
  802153:	6a 00                	push   $0x0
  802155:	ff 75 14             	pushl  0x14(%ebp)
  802158:	ff 75 10             	pushl  0x10(%ebp)
  80215b:	ff 75 0c             	pushl  0xc(%ebp)
  80215e:	50                   	push   %eax
  80215f:	6a 21                	push   $0x21
  802161:	e8 26 fc ff ff       	call   801d8c <syscall>
  802166:	83 c4 18             	add    $0x18,%esp
}
  802169:	c9                   	leave  
  80216a:	c3                   	ret    

0080216b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80216b:	55                   	push   %ebp
  80216c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80216e:	8b 45 08             	mov    0x8(%ebp),%eax
  802171:	6a 00                	push   $0x0
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	6a 00                	push   $0x0
  802179:	50                   	push   %eax
  80217a:	6a 22                	push   $0x22
  80217c:	e8 0b fc ff ff       	call   801d8c <syscall>
  802181:	83 c4 18             	add    $0x18,%esp
}
  802184:	90                   	nop
  802185:	c9                   	leave  
  802186:	c3                   	ret    

00802187 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802187:	55                   	push   %ebp
  802188:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80218a:	8b 45 08             	mov    0x8(%ebp),%eax
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	6a 00                	push   $0x0
  802195:	50                   	push   %eax
  802196:	6a 23                	push   $0x23
  802198:	e8 ef fb ff ff       	call   801d8c <syscall>
  80219d:	83 c4 18             	add    $0x18,%esp
}
  8021a0:	90                   	nop
  8021a1:	c9                   	leave  
  8021a2:	c3                   	ret    

008021a3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8021a3:	55                   	push   %ebp
  8021a4:	89 e5                	mov    %esp,%ebp
  8021a6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8021a9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021ac:	8d 50 04             	lea    0x4(%eax),%edx
  8021af:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	52                   	push   %edx
  8021b9:	50                   	push   %eax
  8021ba:	6a 24                	push   $0x24
  8021bc:	e8 cb fb ff ff       	call   801d8c <syscall>
  8021c1:	83 c4 18             	add    $0x18,%esp
	return result;
  8021c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8021c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021cd:	89 01                	mov    %eax,(%ecx)
  8021cf:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8021d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d5:	c9                   	leave  
  8021d6:	c2 04 00             	ret    $0x4

008021d9 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8021d9:	55                   	push   %ebp
  8021da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 00                	push   $0x0
  8021e0:	ff 75 10             	pushl  0x10(%ebp)
  8021e3:	ff 75 0c             	pushl  0xc(%ebp)
  8021e6:	ff 75 08             	pushl  0x8(%ebp)
  8021e9:	6a 13                	push   $0x13
  8021eb:	e8 9c fb ff ff       	call   801d8c <syscall>
  8021f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8021f3:	90                   	nop
}
  8021f4:	c9                   	leave  
  8021f5:	c3                   	ret    

008021f6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8021f6:	55                   	push   %ebp
  8021f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021f9:	6a 00                	push   $0x0
  8021fb:	6a 00                	push   $0x0
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	6a 00                	push   $0x0
  802203:	6a 25                	push   $0x25
  802205:	e8 82 fb ff ff       	call   801d8c <syscall>
  80220a:	83 c4 18             	add    $0x18,%esp
}
  80220d:	c9                   	leave  
  80220e:	c3                   	ret    

0080220f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80220f:	55                   	push   %ebp
  802210:	89 e5                	mov    %esp,%ebp
  802212:	83 ec 04             	sub    $0x4,%esp
  802215:	8b 45 08             	mov    0x8(%ebp),%eax
  802218:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80221b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80221f:	6a 00                	push   $0x0
  802221:	6a 00                	push   $0x0
  802223:	6a 00                	push   $0x0
  802225:	6a 00                	push   $0x0
  802227:	50                   	push   %eax
  802228:	6a 26                	push   $0x26
  80222a:	e8 5d fb ff ff       	call   801d8c <syscall>
  80222f:	83 c4 18             	add    $0x18,%esp
	return ;
  802232:	90                   	nop
}
  802233:	c9                   	leave  
  802234:	c3                   	ret    

00802235 <rsttst>:
void rsttst()
{
  802235:	55                   	push   %ebp
  802236:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802238:	6a 00                	push   $0x0
  80223a:	6a 00                	push   $0x0
  80223c:	6a 00                	push   $0x0
  80223e:	6a 00                	push   $0x0
  802240:	6a 00                	push   $0x0
  802242:	6a 28                	push   $0x28
  802244:	e8 43 fb ff ff       	call   801d8c <syscall>
  802249:	83 c4 18             	add    $0x18,%esp
	return ;
  80224c:	90                   	nop
}
  80224d:	c9                   	leave  
  80224e:	c3                   	ret    

0080224f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80224f:	55                   	push   %ebp
  802250:	89 e5                	mov    %esp,%ebp
  802252:	83 ec 04             	sub    $0x4,%esp
  802255:	8b 45 14             	mov    0x14(%ebp),%eax
  802258:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80225b:	8b 55 18             	mov    0x18(%ebp),%edx
  80225e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802262:	52                   	push   %edx
  802263:	50                   	push   %eax
  802264:	ff 75 10             	pushl  0x10(%ebp)
  802267:	ff 75 0c             	pushl  0xc(%ebp)
  80226a:	ff 75 08             	pushl  0x8(%ebp)
  80226d:	6a 27                	push   $0x27
  80226f:	e8 18 fb ff ff       	call   801d8c <syscall>
  802274:	83 c4 18             	add    $0x18,%esp
	return ;
  802277:	90                   	nop
}
  802278:	c9                   	leave  
  802279:	c3                   	ret    

0080227a <chktst>:
void chktst(uint32 n)
{
  80227a:	55                   	push   %ebp
  80227b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80227d:	6a 00                	push   $0x0
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	ff 75 08             	pushl  0x8(%ebp)
  802288:	6a 29                	push   $0x29
  80228a:	e8 fd fa ff ff       	call   801d8c <syscall>
  80228f:	83 c4 18             	add    $0x18,%esp
	return ;
  802292:	90                   	nop
}
  802293:	c9                   	leave  
  802294:	c3                   	ret    

00802295 <inctst>:

void inctst()
{
  802295:	55                   	push   %ebp
  802296:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802298:	6a 00                	push   $0x0
  80229a:	6a 00                	push   $0x0
  80229c:	6a 00                	push   $0x0
  80229e:	6a 00                	push   $0x0
  8022a0:	6a 00                	push   $0x0
  8022a2:	6a 2a                	push   $0x2a
  8022a4:	e8 e3 fa ff ff       	call   801d8c <syscall>
  8022a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8022ac:	90                   	nop
}
  8022ad:	c9                   	leave  
  8022ae:	c3                   	ret    

008022af <gettst>:
uint32 gettst()
{
  8022af:	55                   	push   %ebp
  8022b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8022b2:	6a 00                	push   $0x0
  8022b4:	6a 00                	push   $0x0
  8022b6:	6a 00                	push   $0x0
  8022b8:	6a 00                	push   $0x0
  8022ba:	6a 00                	push   $0x0
  8022bc:	6a 2b                	push   $0x2b
  8022be:	e8 c9 fa ff ff       	call   801d8c <syscall>
  8022c3:	83 c4 18             	add    $0x18,%esp
}
  8022c6:	c9                   	leave  
  8022c7:	c3                   	ret    

008022c8 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8022c8:	55                   	push   %ebp
  8022c9:	89 e5                	mov    %esp,%ebp
  8022cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022ce:	6a 00                	push   $0x0
  8022d0:	6a 00                	push   $0x0
  8022d2:	6a 00                	push   $0x0
  8022d4:	6a 00                	push   $0x0
  8022d6:	6a 00                	push   $0x0
  8022d8:	6a 2c                	push   $0x2c
  8022da:	e8 ad fa ff ff       	call   801d8c <syscall>
  8022df:	83 c4 18             	add    $0x18,%esp
  8022e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8022e5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8022e9:	75 07                	jne    8022f2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8022eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8022f0:	eb 05                	jmp    8022f7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8022f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022f7:	c9                   	leave  
  8022f8:	c3                   	ret    

008022f9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8022f9:	55                   	push   %ebp
  8022fa:	89 e5                	mov    %esp,%ebp
  8022fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	6a 00                	push   $0x0
  802305:	6a 00                	push   $0x0
  802307:	6a 00                	push   $0x0
  802309:	6a 2c                	push   $0x2c
  80230b:	e8 7c fa ff ff       	call   801d8c <syscall>
  802310:	83 c4 18             	add    $0x18,%esp
  802313:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802316:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80231a:	75 07                	jne    802323 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80231c:	b8 01 00 00 00       	mov    $0x1,%eax
  802321:	eb 05                	jmp    802328 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802323:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802328:	c9                   	leave  
  802329:	c3                   	ret    

0080232a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80232a:	55                   	push   %ebp
  80232b:	89 e5                	mov    %esp,%ebp
  80232d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802330:	6a 00                	push   $0x0
  802332:	6a 00                	push   $0x0
  802334:	6a 00                	push   $0x0
  802336:	6a 00                	push   $0x0
  802338:	6a 00                	push   $0x0
  80233a:	6a 2c                	push   $0x2c
  80233c:	e8 4b fa ff ff       	call   801d8c <syscall>
  802341:	83 c4 18             	add    $0x18,%esp
  802344:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802347:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80234b:	75 07                	jne    802354 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80234d:	b8 01 00 00 00       	mov    $0x1,%eax
  802352:	eb 05                	jmp    802359 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802354:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802359:	c9                   	leave  
  80235a:	c3                   	ret    

0080235b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80235b:	55                   	push   %ebp
  80235c:	89 e5                	mov    %esp,%ebp
  80235e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802361:	6a 00                	push   $0x0
  802363:	6a 00                	push   $0x0
  802365:	6a 00                	push   $0x0
  802367:	6a 00                	push   $0x0
  802369:	6a 00                	push   $0x0
  80236b:	6a 2c                	push   $0x2c
  80236d:	e8 1a fa ff ff       	call   801d8c <syscall>
  802372:	83 c4 18             	add    $0x18,%esp
  802375:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802378:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80237c:	75 07                	jne    802385 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80237e:	b8 01 00 00 00       	mov    $0x1,%eax
  802383:	eb 05                	jmp    80238a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802385:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80238a:	c9                   	leave  
  80238b:	c3                   	ret    

0080238c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80238c:	55                   	push   %ebp
  80238d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80238f:	6a 00                	push   $0x0
  802391:	6a 00                	push   $0x0
  802393:	6a 00                	push   $0x0
  802395:	6a 00                	push   $0x0
  802397:	ff 75 08             	pushl  0x8(%ebp)
  80239a:	6a 2d                	push   $0x2d
  80239c:	e8 eb f9 ff ff       	call   801d8c <syscall>
  8023a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8023a4:	90                   	nop
}
  8023a5:	c9                   	leave  
  8023a6:	c3                   	ret    

008023a7 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8023a7:	55                   	push   %ebp
  8023a8:	89 e5                	mov    %esp,%ebp
  8023aa:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8023ab:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8023ae:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8023b7:	6a 00                	push   $0x0
  8023b9:	53                   	push   %ebx
  8023ba:	51                   	push   %ecx
  8023bb:	52                   	push   %edx
  8023bc:	50                   	push   %eax
  8023bd:	6a 2e                	push   $0x2e
  8023bf:	e8 c8 f9 ff ff       	call   801d8c <syscall>
  8023c4:	83 c4 18             	add    $0x18,%esp
}
  8023c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8023ca:	c9                   	leave  
  8023cb:	c3                   	ret    

008023cc <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8023cc:	55                   	push   %ebp
  8023cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8023cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8023d5:	6a 00                	push   $0x0
  8023d7:	6a 00                	push   $0x0
  8023d9:	6a 00                	push   $0x0
  8023db:	52                   	push   %edx
  8023dc:	50                   	push   %eax
  8023dd:	6a 2f                	push   $0x2f
  8023df:	e8 a8 f9 ff ff       	call   801d8c <syscall>
  8023e4:	83 c4 18             	add    $0x18,%esp
}
  8023e7:	c9                   	leave  
  8023e8:	c3                   	ret    
  8023e9:	66 90                	xchg   %ax,%ax
  8023eb:	90                   	nop

008023ec <__udivdi3>:
  8023ec:	55                   	push   %ebp
  8023ed:	57                   	push   %edi
  8023ee:	56                   	push   %esi
  8023ef:	53                   	push   %ebx
  8023f0:	83 ec 1c             	sub    $0x1c,%esp
  8023f3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023f7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023ff:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802403:	89 ca                	mov    %ecx,%edx
  802405:	89 f8                	mov    %edi,%eax
  802407:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80240b:	85 f6                	test   %esi,%esi
  80240d:	75 2d                	jne    80243c <__udivdi3+0x50>
  80240f:	39 cf                	cmp    %ecx,%edi
  802411:	77 65                	ja     802478 <__udivdi3+0x8c>
  802413:	89 fd                	mov    %edi,%ebp
  802415:	85 ff                	test   %edi,%edi
  802417:	75 0b                	jne    802424 <__udivdi3+0x38>
  802419:	b8 01 00 00 00       	mov    $0x1,%eax
  80241e:	31 d2                	xor    %edx,%edx
  802420:	f7 f7                	div    %edi
  802422:	89 c5                	mov    %eax,%ebp
  802424:	31 d2                	xor    %edx,%edx
  802426:	89 c8                	mov    %ecx,%eax
  802428:	f7 f5                	div    %ebp
  80242a:	89 c1                	mov    %eax,%ecx
  80242c:	89 d8                	mov    %ebx,%eax
  80242e:	f7 f5                	div    %ebp
  802430:	89 cf                	mov    %ecx,%edi
  802432:	89 fa                	mov    %edi,%edx
  802434:	83 c4 1c             	add    $0x1c,%esp
  802437:	5b                   	pop    %ebx
  802438:	5e                   	pop    %esi
  802439:	5f                   	pop    %edi
  80243a:	5d                   	pop    %ebp
  80243b:	c3                   	ret    
  80243c:	39 ce                	cmp    %ecx,%esi
  80243e:	77 28                	ja     802468 <__udivdi3+0x7c>
  802440:	0f bd fe             	bsr    %esi,%edi
  802443:	83 f7 1f             	xor    $0x1f,%edi
  802446:	75 40                	jne    802488 <__udivdi3+0x9c>
  802448:	39 ce                	cmp    %ecx,%esi
  80244a:	72 0a                	jb     802456 <__udivdi3+0x6a>
  80244c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802450:	0f 87 9e 00 00 00    	ja     8024f4 <__udivdi3+0x108>
  802456:	b8 01 00 00 00       	mov    $0x1,%eax
  80245b:	89 fa                	mov    %edi,%edx
  80245d:	83 c4 1c             	add    $0x1c,%esp
  802460:	5b                   	pop    %ebx
  802461:	5e                   	pop    %esi
  802462:	5f                   	pop    %edi
  802463:	5d                   	pop    %ebp
  802464:	c3                   	ret    
  802465:	8d 76 00             	lea    0x0(%esi),%esi
  802468:	31 ff                	xor    %edi,%edi
  80246a:	31 c0                	xor    %eax,%eax
  80246c:	89 fa                	mov    %edi,%edx
  80246e:	83 c4 1c             	add    $0x1c,%esp
  802471:	5b                   	pop    %ebx
  802472:	5e                   	pop    %esi
  802473:	5f                   	pop    %edi
  802474:	5d                   	pop    %ebp
  802475:	c3                   	ret    
  802476:	66 90                	xchg   %ax,%ax
  802478:	89 d8                	mov    %ebx,%eax
  80247a:	f7 f7                	div    %edi
  80247c:	31 ff                	xor    %edi,%edi
  80247e:	89 fa                	mov    %edi,%edx
  802480:	83 c4 1c             	add    $0x1c,%esp
  802483:	5b                   	pop    %ebx
  802484:	5e                   	pop    %esi
  802485:	5f                   	pop    %edi
  802486:	5d                   	pop    %ebp
  802487:	c3                   	ret    
  802488:	bd 20 00 00 00       	mov    $0x20,%ebp
  80248d:	89 eb                	mov    %ebp,%ebx
  80248f:	29 fb                	sub    %edi,%ebx
  802491:	89 f9                	mov    %edi,%ecx
  802493:	d3 e6                	shl    %cl,%esi
  802495:	89 c5                	mov    %eax,%ebp
  802497:	88 d9                	mov    %bl,%cl
  802499:	d3 ed                	shr    %cl,%ebp
  80249b:	89 e9                	mov    %ebp,%ecx
  80249d:	09 f1                	or     %esi,%ecx
  80249f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8024a3:	89 f9                	mov    %edi,%ecx
  8024a5:	d3 e0                	shl    %cl,%eax
  8024a7:	89 c5                	mov    %eax,%ebp
  8024a9:	89 d6                	mov    %edx,%esi
  8024ab:	88 d9                	mov    %bl,%cl
  8024ad:	d3 ee                	shr    %cl,%esi
  8024af:	89 f9                	mov    %edi,%ecx
  8024b1:	d3 e2                	shl    %cl,%edx
  8024b3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024b7:	88 d9                	mov    %bl,%cl
  8024b9:	d3 e8                	shr    %cl,%eax
  8024bb:	09 c2                	or     %eax,%edx
  8024bd:	89 d0                	mov    %edx,%eax
  8024bf:	89 f2                	mov    %esi,%edx
  8024c1:	f7 74 24 0c          	divl   0xc(%esp)
  8024c5:	89 d6                	mov    %edx,%esi
  8024c7:	89 c3                	mov    %eax,%ebx
  8024c9:	f7 e5                	mul    %ebp
  8024cb:	39 d6                	cmp    %edx,%esi
  8024cd:	72 19                	jb     8024e8 <__udivdi3+0xfc>
  8024cf:	74 0b                	je     8024dc <__udivdi3+0xf0>
  8024d1:	89 d8                	mov    %ebx,%eax
  8024d3:	31 ff                	xor    %edi,%edi
  8024d5:	e9 58 ff ff ff       	jmp    802432 <__udivdi3+0x46>
  8024da:	66 90                	xchg   %ax,%ax
  8024dc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024e0:	89 f9                	mov    %edi,%ecx
  8024e2:	d3 e2                	shl    %cl,%edx
  8024e4:	39 c2                	cmp    %eax,%edx
  8024e6:	73 e9                	jae    8024d1 <__udivdi3+0xe5>
  8024e8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024eb:	31 ff                	xor    %edi,%edi
  8024ed:	e9 40 ff ff ff       	jmp    802432 <__udivdi3+0x46>
  8024f2:	66 90                	xchg   %ax,%ax
  8024f4:	31 c0                	xor    %eax,%eax
  8024f6:	e9 37 ff ff ff       	jmp    802432 <__udivdi3+0x46>
  8024fb:	90                   	nop

008024fc <__umoddi3>:
  8024fc:	55                   	push   %ebp
  8024fd:	57                   	push   %edi
  8024fe:	56                   	push   %esi
  8024ff:	53                   	push   %ebx
  802500:	83 ec 1c             	sub    $0x1c,%esp
  802503:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802507:	8b 74 24 34          	mov    0x34(%esp),%esi
  80250b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80250f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802513:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802517:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80251b:	89 f3                	mov    %esi,%ebx
  80251d:	89 fa                	mov    %edi,%edx
  80251f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802523:	89 34 24             	mov    %esi,(%esp)
  802526:	85 c0                	test   %eax,%eax
  802528:	75 1a                	jne    802544 <__umoddi3+0x48>
  80252a:	39 f7                	cmp    %esi,%edi
  80252c:	0f 86 a2 00 00 00    	jbe    8025d4 <__umoddi3+0xd8>
  802532:	89 c8                	mov    %ecx,%eax
  802534:	89 f2                	mov    %esi,%edx
  802536:	f7 f7                	div    %edi
  802538:	89 d0                	mov    %edx,%eax
  80253a:	31 d2                	xor    %edx,%edx
  80253c:	83 c4 1c             	add    $0x1c,%esp
  80253f:	5b                   	pop    %ebx
  802540:	5e                   	pop    %esi
  802541:	5f                   	pop    %edi
  802542:	5d                   	pop    %ebp
  802543:	c3                   	ret    
  802544:	39 f0                	cmp    %esi,%eax
  802546:	0f 87 ac 00 00 00    	ja     8025f8 <__umoddi3+0xfc>
  80254c:	0f bd e8             	bsr    %eax,%ebp
  80254f:	83 f5 1f             	xor    $0x1f,%ebp
  802552:	0f 84 ac 00 00 00    	je     802604 <__umoddi3+0x108>
  802558:	bf 20 00 00 00       	mov    $0x20,%edi
  80255d:	29 ef                	sub    %ebp,%edi
  80255f:	89 fe                	mov    %edi,%esi
  802561:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802565:	89 e9                	mov    %ebp,%ecx
  802567:	d3 e0                	shl    %cl,%eax
  802569:	89 d7                	mov    %edx,%edi
  80256b:	89 f1                	mov    %esi,%ecx
  80256d:	d3 ef                	shr    %cl,%edi
  80256f:	09 c7                	or     %eax,%edi
  802571:	89 e9                	mov    %ebp,%ecx
  802573:	d3 e2                	shl    %cl,%edx
  802575:	89 14 24             	mov    %edx,(%esp)
  802578:	89 d8                	mov    %ebx,%eax
  80257a:	d3 e0                	shl    %cl,%eax
  80257c:	89 c2                	mov    %eax,%edx
  80257e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802582:	d3 e0                	shl    %cl,%eax
  802584:	89 44 24 04          	mov    %eax,0x4(%esp)
  802588:	8b 44 24 08          	mov    0x8(%esp),%eax
  80258c:	89 f1                	mov    %esi,%ecx
  80258e:	d3 e8                	shr    %cl,%eax
  802590:	09 d0                	or     %edx,%eax
  802592:	d3 eb                	shr    %cl,%ebx
  802594:	89 da                	mov    %ebx,%edx
  802596:	f7 f7                	div    %edi
  802598:	89 d3                	mov    %edx,%ebx
  80259a:	f7 24 24             	mull   (%esp)
  80259d:	89 c6                	mov    %eax,%esi
  80259f:	89 d1                	mov    %edx,%ecx
  8025a1:	39 d3                	cmp    %edx,%ebx
  8025a3:	0f 82 87 00 00 00    	jb     802630 <__umoddi3+0x134>
  8025a9:	0f 84 91 00 00 00    	je     802640 <__umoddi3+0x144>
  8025af:	8b 54 24 04          	mov    0x4(%esp),%edx
  8025b3:	29 f2                	sub    %esi,%edx
  8025b5:	19 cb                	sbb    %ecx,%ebx
  8025b7:	89 d8                	mov    %ebx,%eax
  8025b9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8025bd:	d3 e0                	shl    %cl,%eax
  8025bf:	89 e9                	mov    %ebp,%ecx
  8025c1:	d3 ea                	shr    %cl,%edx
  8025c3:	09 d0                	or     %edx,%eax
  8025c5:	89 e9                	mov    %ebp,%ecx
  8025c7:	d3 eb                	shr    %cl,%ebx
  8025c9:	89 da                	mov    %ebx,%edx
  8025cb:	83 c4 1c             	add    $0x1c,%esp
  8025ce:	5b                   	pop    %ebx
  8025cf:	5e                   	pop    %esi
  8025d0:	5f                   	pop    %edi
  8025d1:	5d                   	pop    %ebp
  8025d2:	c3                   	ret    
  8025d3:	90                   	nop
  8025d4:	89 fd                	mov    %edi,%ebp
  8025d6:	85 ff                	test   %edi,%edi
  8025d8:	75 0b                	jne    8025e5 <__umoddi3+0xe9>
  8025da:	b8 01 00 00 00       	mov    $0x1,%eax
  8025df:	31 d2                	xor    %edx,%edx
  8025e1:	f7 f7                	div    %edi
  8025e3:	89 c5                	mov    %eax,%ebp
  8025e5:	89 f0                	mov    %esi,%eax
  8025e7:	31 d2                	xor    %edx,%edx
  8025e9:	f7 f5                	div    %ebp
  8025eb:	89 c8                	mov    %ecx,%eax
  8025ed:	f7 f5                	div    %ebp
  8025ef:	89 d0                	mov    %edx,%eax
  8025f1:	e9 44 ff ff ff       	jmp    80253a <__umoddi3+0x3e>
  8025f6:	66 90                	xchg   %ax,%ax
  8025f8:	89 c8                	mov    %ecx,%eax
  8025fa:	89 f2                	mov    %esi,%edx
  8025fc:	83 c4 1c             	add    $0x1c,%esp
  8025ff:	5b                   	pop    %ebx
  802600:	5e                   	pop    %esi
  802601:	5f                   	pop    %edi
  802602:	5d                   	pop    %ebp
  802603:	c3                   	ret    
  802604:	3b 04 24             	cmp    (%esp),%eax
  802607:	72 06                	jb     80260f <__umoddi3+0x113>
  802609:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80260d:	77 0f                	ja     80261e <__umoddi3+0x122>
  80260f:	89 f2                	mov    %esi,%edx
  802611:	29 f9                	sub    %edi,%ecx
  802613:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802617:	89 14 24             	mov    %edx,(%esp)
  80261a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80261e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802622:	8b 14 24             	mov    (%esp),%edx
  802625:	83 c4 1c             	add    $0x1c,%esp
  802628:	5b                   	pop    %ebx
  802629:	5e                   	pop    %esi
  80262a:	5f                   	pop    %edi
  80262b:	5d                   	pop    %ebp
  80262c:	c3                   	ret    
  80262d:	8d 76 00             	lea    0x0(%esi),%esi
  802630:	2b 04 24             	sub    (%esp),%eax
  802633:	19 fa                	sbb    %edi,%edx
  802635:	89 d1                	mov    %edx,%ecx
  802637:	89 c6                	mov    %eax,%esi
  802639:	e9 71 ff ff ff       	jmp    8025af <__umoddi3+0xb3>
  80263e:	66 90                	xchg   %ax,%ax
  802640:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802644:	72 ea                	jb     802630 <__umoddi3+0x134>
  802646:	89 d9                	mov    %ebx,%ecx
  802648:	e9 62 ff ff ff       	jmp    8025af <__umoddi3+0xb3>
