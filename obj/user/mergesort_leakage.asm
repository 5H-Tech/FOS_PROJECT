
obj/user/mergesort_leakage:     file format elf32-i386


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
  800031:	e8 65 07 00 00       	call   80079b <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_disable_interrupt();
  800041:	e8 51 20 00 00       	call   802097 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 20 27 80 00       	push   $0x802720
  80004e:	e8 2f 0b 00 00       	call   800b82 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 22 27 80 00       	push   $0x802722
  80005e:	e8 1f 0b 00 00       	call   800b82 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 38 27 80 00       	push   $0x802738
  80006e:	e8 0f 0b 00 00       	call   800b82 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 22 27 80 00       	push   $0x802722
  80007e:	e8 ff 0a 00 00       	call   800b82 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 20 27 80 00       	push   $0x802720
  80008e:	e8 ef 0a 00 00       	call   800b82 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 50 27 80 00       	push   $0x802750
  8000a5:	e8 5a 11 00 00       	call   801204 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 aa 16 00 00       	call   80176a <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 3d 1a 00 00       	call   801b12 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 70 27 80 00       	push   $0x802770
  8000e3:	e8 9a 0a 00 00       	call   800b82 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 92 27 80 00       	push   $0x802792
  8000f3:	e8 8a 0a 00 00       	call   800b82 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 a0 27 80 00       	push   $0x8027a0
  800103:	e8 7a 0a 00 00       	call   800b82 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 af 27 80 00       	push   $0x8027af
  800113:	e8 6a 0a 00 00       	call   800b82 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 bf 27 80 00       	push   $0x8027bf
  800123:	e8 5a 0a 00 00       	call   800b82 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 13 06 00 00       	call   800743 <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 bb 05 00 00       	call   8006fb <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 ae 05 00 00       	call   8006fb <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 4a 1f 00 00       	call   8020b1 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80016b:	83 f8 62             	cmp    $0x62,%eax
  80016e:	74 1d                	je     80018d <_main+0x155>
  800170:	83 f8 63             	cmp    $0x63,%eax
  800173:	74 2b                	je     8001a0 <_main+0x168>
  800175:	83 f8 61             	cmp    $0x61,%eax
  800178:	75 39                	jne    8001b3 <_main+0x17b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 f0             	pushl  -0x10(%ebp)
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	e8 e6 01 00 00       	call   80036e <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 04 02 00 00       	call   80039f <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 26 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 13 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	6a 01                	push   $0x1
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 d2 02 00 00       	call   8004a6 <MSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d7:	e8 bb 1e 00 00       	call   802097 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 c8 27 80 00       	push   $0x8027c8
  8001e4:	e8 99 09 00 00       	call   800b82 <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 c0 1e 00 00       	call   8020b1 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f1:	83 ec 08             	sub    $0x8,%esp
  8001f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001fa:	e8 c5 00 00 00       	call   8002c4 <CheckSorted>
  8001ff:	83 c4 10             	add    $0x10,%esp
  800202:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800205:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800209:	75 14                	jne    80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 fc 27 80 00       	push   $0x8027fc
  800213:	6a 4a                	push   $0x4a
  800215:	68 1e 28 80 00       	push   $0x80281e
  80021a:	e8 c1 06 00 00       	call   8008e0 <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 73 1e 00 00       	call   802097 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 38 28 80 00       	push   $0x802838
  80022c:	e8 51 09 00 00       	call   800b82 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 6c 28 80 00       	push   $0x80286c
  80023c:	e8 41 09 00 00       	call   800b82 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 a0 28 80 00       	push   $0x8028a0
  80024c:	e8 31 09 00 00       	call   800b82 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 58 1e 00 00       	call   8020b1 <sys_enable_interrupt>
		}

		//free(Elements) ;

		sys_disable_interrupt();
  800259:	e8 39 1e 00 00       	call   802097 <sys_disable_interrupt>
			Chose = 0 ;
  80025e:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800262:	eb 42                	jmp    8002a6 <_main+0x26e>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800264:	83 ec 0c             	sub    $0xc,%esp
  800267:	68 d2 28 80 00       	push   $0x8028d2
  80026c:	e8 11 09 00 00       	call   800b82 <cprintf>
  800271:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800274:	e8 ca 04 00 00       	call   800743 <getchar>
  800279:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80027c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	50                   	push   %eax
  800284:	e8 72 04 00 00       	call   8006fb <cputchar>
  800289:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	6a 0a                	push   $0xa
  800291:	e8 65 04 00 00       	call   8006fb <cputchar>
  800296:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	6a 0a                	push   $0xa
  80029e:	e8 58 04 00 00       	call   8006fb <cputchar>
  8002a3:	83 c4 10             	add    $0x10,%esp

		//free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a6:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002aa:	74 06                	je     8002b2 <_main+0x27a>
  8002ac:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002b0:	75 b2                	jne    800264 <_main+0x22c>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b2:	e8 fa 1d 00 00       	call   8020b1 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002b7:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002bb:	0f 84 80 fd ff ff    	je     800041 <_main+0x9>

}
  8002c1:	90                   	nop
  8002c2:	c9                   	leave  
  8002c3:	c3                   	ret    

008002c4 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002c4:	55                   	push   %ebp
  8002c5:	89 e5                	mov    %esp,%ebp
  8002c7:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002d8:	eb 33                	jmp    80030d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 d0                	add    %edx,%eax
  8002e9:	8b 10                	mov    (%eax),%edx
  8002eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002ee:	40                   	inc    %eax
  8002ef:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 c8                	add    %ecx,%eax
  8002fb:	8b 00                	mov    (%eax),%eax
  8002fd:	39 c2                	cmp    %eax,%edx
  8002ff:	7e 09                	jle    80030a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800301:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800308:	eb 0c                	jmp    800316 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80030a:	ff 45 f8             	incl   -0x8(%ebp)
  80030d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800310:	48                   	dec    %eax
  800311:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800314:	7f c4                	jg     8002da <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800316:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800319:	c9                   	leave  
  80031a:	c3                   	ret    

0080031b <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80031b:	55                   	push   %ebp
  80031c:	89 e5                	mov    %esp,%ebp
  80031e:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800321:	8b 45 0c             	mov    0xc(%ebp),%eax
  800324:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032b:	8b 45 08             	mov    0x8(%ebp),%eax
  80032e:	01 d0                	add    %edx,%eax
  800330:	8b 00                	mov    (%eax),%eax
  800332:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800335:	8b 45 0c             	mov    0xc(%ebp),%eax
  800338:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033f:	8b 45 08             	mov    0x8(%ebp),%eax
  800342:	01 c2                	add    %eax,%edx
  800344:	8b 45 10             	mov    0x10(%ebp),%eax
  800347:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034e:	8b 45 08             	mov    0x8(%ebp),%eax
  800351:	01 c8                	add    %ecx,%eax
  800353:	8b 00                	mov    (%eax),%eax
  800355:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800357:	8b 45 10             	mov    0x10(%ebp),%eax
  80035a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800361:	8b 45 08             	mov    0x8(%ebp),%eax
  800364:	01 c2                	add    %eax,%edx
  800366:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800369:	89 02                	mov    %eax,(%edx)
}
  80036b:	90                   	nop
  80036c:	c9                   	leave  
  80036d:	c3                   	ret    

0080036e <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80036e:	55                   	push   %ebp
  80036f:	89 e5                	mov    %esp,%ebp
  800371:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800374:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80037b:	eb 17                	jmp    800394 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80037d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800380:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800387:	8b 45 08             	mov    0x8(%ebp),%eax
  80038a:	01 c2                	add    %eax,%edx
  80038c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800391:	ff 45 fc             	incl   -0x4(%ebp)
  800394:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800397:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80039a:	7c e1                	jl     80037d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80039c:	90                   	nop
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ac:	eb 1b                	jmp    8003c9 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	01 c2                	add    %eax,%edx
  8003bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c0:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003c3:	48                   	dec    %eax
  8003c4:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003c6:	ff 45 fc             	incl   -0x4(%ebp)
  8003c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003cc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003cf:	7c dd                	jl     8003ae <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003d1:	90                   	nop
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003da:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003dd:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003e2:	f7 e9                	imul   %ecx
  8003e4:	c1 f9 1f             	sar    $0x1f,%ecx
  8003e7:	89 d0                	mov    %edx,%eax
  8003e9:	29 c8                	sub    %ecx,%eax
  8003eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003f5:	eb 1e                	jmp    800415 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8003f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800407:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040a:	99                   	cltd   
  80040b:	f7 7d f8             	idivl  -0x8(%ebp)
  80040e:	89 d0                	mov    %edx,%eax
  800410:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800412:	ff 45 fc             	incl   -0x4(%ebp)
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041b:	7c da                	jl     8003f7 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800426:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80042d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800434:	eb 42                	jmp    800478 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800436:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800439:	99                   	cltd   
  80043a:	f7 7d f0             	idivl  -0x10(%ebp)
  80043d:	89 d0                	mov    %edx,%eax
  80043f:	85 c0                	test   %eax,%eax
  800441:	75 10                	jne    800453 <PrintElements+0x33>
			cprintf("\n");
  800443:	83 ec 0c             	sub    $0xc,%esp
  800446:	68 20 27 80 00       	push   $0x802720
  80044b:	e8 32 07 00 00       	call   800b82 <cprintf>
  800450:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800453:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 d0                	add    %edx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	83 ec 08             	sub    $0x8,%esp
  800467:	50                   	push   %eax
  800468:	68 f0 28 80 00       	push   $0x8028f0
  80046d:	e8 10 07 00 00       	call   800b82 <cprintf>
  800472:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800475:	ff 45 f4             	incl   -0xc(%ebp)
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	48                   	dec    %eax
  80047c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80047f:	7f b5                	jg     800436 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800481:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800484:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	01 d0                	add    %edx,%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	83 ec 08             	sub    $0x8,%esp
  800495:	50                   	push   %eax
  800496:	68 f5 28 80 00       	push   $0x8028f5
  80049b:	e8 e2 06 00 00       	call   800b82 <cprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp

}
  8004a3:	90                   	nop
  8004a4:	c9                   	leave  
  8004a5:	c3                   	ret    

008004a6 <MSort>:


void MSort(int* A, int p, int r)
{
  8004a6:	55                   	push   %ebp
  8004a7:	89 e5                	mov    %esp,%ebp
  8004a9:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004af:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004b2:	7d 54                	jge    800508 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ba:	01 d0                	add    %edx,%eax
  8004bc:	89 c2                	mov    %eax,%edx
  8004be:	c1 ea 1f             	shr    $0x1f,%edx
  8004c1:	01 d0                	add    %edx,%eax
  8004c3:	d1 f8                	sar    %eax
  8004c5:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004c8:	83 ec 04             	sub    $0x4,%esp
  8004cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ce:	ff 75 0c             	pushl  0xc(%ebp)
  8004d1:	ff 75 08             	pushl  0x8(%ebp)
  8004d4:	e8 cd ff ff ff       	call   8004a6 <MSort>
  8004d9:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004df:	40                   	inc    %eax
  8004e0:	83 ec 04             	sub    $0x4,%esp
  8004e3:	ff 75 10             	pushl  0x10(%ebp)
  8004e6:	50                   	push   %eax
  8004e7:	ff 75 08             	pushl  0x8(%ebp)
  8004ea:	e8 b7 ff ff ff       	call   8004a6 <MSort>
  8004ef:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004f2:	ff 75 10             	pushl  0x10(%ebp)
  8004f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f8:	ff 75 0c             	pushl  0xc(%ebp)
  8004fb:	ff 75 08             	pushl  0x8(%ebp)
  8004fe:	e8 08 00 00 00       	call   80050b <Merge>
  800503:	83 c4 10             	add    $0x10,%esp
  800506:	eb 01                	jmp    800509 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800508:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800511:	8b 45 10             	mov    0x10(%ebp),%eax
  800514:	2b 45 0c             	sub    0xc(%ebp),%eax
  800517:	40                   	inc    %eax
  800518:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80051b:	8b 45 14             	mov    0x14(%ebp),%eax
  80051e:	2b 45 10             	sub    0x10(%ebp),%eax
  800521:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800524:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80052b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800532:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800535:	c1 e0 02             	shl    $0x2,%eax
  800538:	83 ec 0c             	sub    $0xc,%esp
  80053b:	50                   	push   %eax
  80053c:	e8 d1 15 00 00       	call   801b12 <malloc>
  800541:	83 c4 10             	add    $0x10,%esp
  800544:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800547:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054a:	c1 e0 02             	shl    $0x2,%eax
  80054d:	83 ec 0c             	sub    $0xc,%esp
  800550:	50                   	push   %eax
  800551:	e8 bc 15 00 00       	call   801b12 <malloc>
  800556:	83 c4 10             	add    $0x10,%esp
  800559:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80055c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800563:	eb 2f                	jmp    800594 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800565:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800568:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800572:	01 c2                	add    %eax,%edx
  800574:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800577:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80057a:	01 c8                	add    %ecx,%eax
  80057c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800581:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800588:	8b 45 08             	mov    0x8(%ebp),%eax
  80058b:	01 c8                	add    %ecx,%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800591:	ff 45 ec             	incl   -0x14(%ebp)
  800594:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800597:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80059a:	7c c9                	jl     800565 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80059c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005a3:	eb 2a                	jmp    8005cf <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005b2:	01 c2                	add    %eax,%edx
  8005b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ba:	01 c8                	add    %ecx,%eax
  8005bc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c6:	01 c8                	add    %ecx,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005cc:	ff 45 e8             	incl   -0x18(%ebp)
  8005cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d2:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005d5:	7c ce                	jl     8005a5 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005dd:	e9 0a 01 00 00       	jmp    8006ec <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005e8:	0f 8d 95 00 00 00    	jge    800683 <Merge+0x178>
  8005ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f1:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005f4:	0f 8d 89 00 00 00    	jge    800683 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800604:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800607:	01 d0                	add    %edx,%eax
  800609:	8b 10                	mov    (%eax),%edx
  80060b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80060e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800615:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800618:	01 c8                	add    %ecx,%eax
  80061a:	8b 00                	mov    (%eax),%eax
  80061c:	39 c2                	cmp    %eax,%edx
  80061e:	7d 33                	jge    800653 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800623:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800628:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80062f:	8b 45 08             	mov    0x8(%ebp),%eax
  800632:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800635:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800638:	8d 50 01             	lea    0x1(%eax),%edx
  80063b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80063e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800645:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80064e:	e9 96 00 00 00       	jmp    8006e9 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800653:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800656:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80065b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800662:	8b 45 08             	mov    0x8(%ebp),%eax
  800665:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80066b:	8d 50 01             	lea    0x1(%eax),%edx
  80066e:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800671:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800678:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80067b:	01 d0                	add    %edx,%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800681:	eb 66                	jmp    8006e9 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800683:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800686:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800689:	7d 30                	jge    8006bb <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  80068b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80068e:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800693:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006a3:	8d 50 01             	lea    0x1(%eax),%edx
  8006a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006a9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006b3:	01 d0                	add    %edx,%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	89 01                	mov    %eax,(%ecx)
  8006b9:	eb 2e                	jmp    8006e9 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006be:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d3:	8d 50 01             	lea    0x1(%eax),%edx
  8006d6:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e3:	01 d0                	add    %edx,%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ef:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006f2:	0f 8e ea fe ff ff    	jle    8005e2 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  8006f8:	90                   	nop
  8006f9:	c9                   	leave  
  8006fa:	c3                   	ret    

008006fb <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8006fb:	55                   	push   %ebp
  8006fc:	89 e5                	mov    %esp,%ebp
  8006fe:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800701:	8b 45 08             	mov    0x8(%ebp),%eax
  800704:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800707:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80070b:	83 ec 0c             	sub    $0xc,%esp
  80070e:	50                   	push   %eax
  80070f:	e8 b7 19 00 00       	call   8020cb <sys_cputc>
  800714:	83 c4 10             	add    $0x10,%esp
}
  800717:	90                   	nop
  800718:	c9                   	leave  
  800719:	c3                   	ret    

0080071a <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80071a:	55                   	push   %ebp
  80071b:	89 e5                	mov    %esp,%ebp
  80071d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800720:	e8 72 19 00 00       	call   802097 <sys_disable_interrupt>
	char c = ch;
  800725:	8b 45 08             	mov    0x8(%ebp),%eax
  800728:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80072b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80072f:	83 ec 0c             	sub    $0xc,%esp
  800732:	50                   	push   %eax
  800733:	e8 93 19 00 00       	call   8020cb <sys_cputc>
  800738:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80073b:	e8 71 19 00 00       	call   8020b1 <sys_enable_interrupt>
}
  800740:	90                   	nop
  800741:	c9                   	leave  
  800742:	c3                   	ret    

00800743 <getchar>:

int
getchar(void)
{
  800743:	55                   	push   %ebp
  800744:	89 e5                	mov    %esp,%ebp
  800746:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800749:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800750:	eb 08                	jmp    80075a <getchar+0x17>
	{
		c = sys_cgetc();
  800752:	e8 58 17 00 00       	call   801eaf <sys_cgetc>
  800757:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80075a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80075e:	74 f2                	je     800752 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800760:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800763:	c9                   	leave  
  800764:	c3                   	ret    

00800765 <atomic_getchar>:

int
atomic_getchar(void)
{
  800765:	55                   	push   %ebp
  800766:	89 e5                	mov    %esp,%ebp
  800768:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80076b:	e8 27 19 00 00       	call   802097 <sys_disable_interrupt>
	int c=0;
  800770:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800777:	eb 08                	jmp    800781 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800779:	e8 31 17 00 00       	call   801eaf <sys_cgetc>
  80077e:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800781:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800785:	74 f2                	je     800779 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800787:	e8 25 19 00 00       	call   8020b1 <sys_enable_interrupt>
	return c;
  80078c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80078f:	c9                   	leave  
  800790:	c3                   	ret    

00800791 <iscons>:

int iscons(int fdnum)
{
  800791:	55                   	push   %ebp
  800792:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800794:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800799:	5d                   	pop    %ebp
  80079a:	c3                   	ret    

0080079b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80079b:	55                   	push   %ebp
  80079c:	89 e5                	mov    %esp,%ebp
  80079e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007a1:	e8 56 17 00 00       	call   801efc <sys_getenvindex>
  8007a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ac:	89 d0                	mov    %edx,%eax
  8007ae:	c1 e0 03             	shl    $0x3,%eax
  8007b1:	01 d0                	add    %edx,%eax
  8007b3:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007ba:	01 c8                	add    %ecx,%eax
  8007bc:	01 c0                	add    %eax,%eax
  8007be:	01 d0                	add    %edx,%eax
  8007c0:	01 c0                	add    %eax,%eax
  8007c2:	01 d0                	add    %edx,%eax
  8007c4:	89 c2                	mov    %eax,%edx
  8007c6:	c1 e2 05             	shl    $0x5,%edx
  8007c9:	29 c2                	sub    %eax,%edx
  8007cb:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8007d2:	89 c2                	mov    %eax,%edx
  8007d4:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8007da:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007df:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e4:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8007ea:	84 c0                	test   %al,%al
  8007ec:	74 0f                	je     8007fd <libmain+0x62>
		binaryname = myEnv->prog_name;
  8007ee:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f3:	05 40 3c 01 00       	add    $0x13c40,%eax
  8007f8:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800801:	7e 0a                	jle    80080d <libmain+0x72>
		binaryname = argv[0];
  800803:	8b 45 0c             	mov    0xc(%ebp),%eax
  800806:	8b 00                	mov    (%eax),%eax
  800808:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80080d:	83 ec 08             	sub    $0x8,%esp
  800810:	ff 75 0c             	pushl  0xc(%ebp)
  800813:	ff 75 08             	pushl  0x8(%ebp)
  800816:	e8 1d f8 ff ff       	call   800038 <_main>
  80081b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80081e:	e8 74 18 00 00       	call   802097 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800823:	83 ec 0c             	sub    $0xc,%esp
  800826:	68 14 29 80 00       	push   $0x802914
  80082b:	e8 52 03 00 00       	call   800b82 <cprintf>
  800830:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800833:	a1 24 30 80 00       	mov    0x803024,%eax
  800838:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80083e:	a1 24 30 80 00       	mov    0x803024,%eax
  800843:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800849:	83 ec 04             	sub    $0x4,%esp
  80084c:	52                   	push   %edx
  80084d:	50                   	push   %eax
  80084e:	68 3c 29 80 00       	push   $0x80293c
  800853:	e8 2a 03 00 00       	call   800b82 <cprintf>
  800858:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80085b:	a1 24 30 80 00       	mov    0x803024,%eax
  800860:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800866:	a1 24 30 80 00       	mov    0x803024,%eax
  80086b:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800871:	83 ec 04             	sub    $0x4,%esp
  800874:	52                   	push   %edx
  800875:	50                   	push   %eax
  800876:	68 64 29 80 00       	push   $0x802964
  80087b:	e8 02 03 00 00       	call   800b82 <cprintf>
  800880:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800883:	a1 24 30 80 00       	mov    0x803024,%eax
  800888:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80088e:	83 ec 08             	sub    $0x8,%esp
  800891:	50                   	push   %eax
  800892:	68 a5 29 80 00       	push   $0x8029a5
  800897:	e8 e6 02 00 00       	call   800b82 <cprintf>
  80089c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80089f:	83 ec 0c             	sub    $0xc,%esp
  8008a2:	68 14 29 80 00       	push   $0x802914
  8008a7:	e8 d6 02 00 00       	call   800b82 <cprintf>
  8008ac:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008af:	e8 fd 17 00 00       	call   8020b1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008b4:	e8 19 00 00 00       	call   8008d2 <exit>
}
  8008b9:	90                   	nop
  8008ba:	c9                   	leave  
  8008bb:	c3                   	ret    

008008bc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008bc:	55                   	push   %ebp
  8008bd:	89 e5                	mov    %esp,%ebp
  8008bf:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008c2:	83 ec 0c             	sub    $0xc,%esp
  8008c5:	6a 00                	push   $0x0
  8008c7:	e8 fc 15 00 00       	call   801ec8 <sys_env_destroy>
  8008cc:	83 c4 10             	add    $0x10,%esp
}
  8008cf:	90                   	nop
  8008d0:	c9                   	leave  
  8008d1:	c3                   	ret    

008008d2 <exit>:

void
exit(void)
{
  8008d2:	55                   	push   %ebp
  8008d3:	89 e5                	mov    %esp,%ebp
  8008d5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008d8:	e8 51 16 00 00       	call   801f2e <sys_env_exit>
}
  8008dd:	90                   	nop
  8008de:	c9                   	leave  
  8008df:	c3                   	ret    

008008e0 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008e0:	55                   	push   %ebp
  8008e1:	89 e5                	mov    %esp,%ebp
  8008e3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008e6:	8d 45 10             	lea    0x10(%ebp),%eax
  8008e9:	83 c0 04             	add    $0x4,%eax
  8008ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008ef:	a1 18 31 80 00       	mov    0x803118,%eax
  8008f4:	85 c0                	test   %eax,%eax
  8008f6:	74 16                	je     80090e <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008f8:	a1 18 31 80 00       	mov    0x803118,%eax
  8008fd:	83 ec 08             	sub    $0x8,%esp
  800900:	50                   	push   %eax
  800901:	68 bc 29 80 00       	push   $0x8029bc
  800906:	e8 77 02 00 00       	call   800b82 <cprintf>
  80090b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80090e:	a1 00 30 80 00       	mov    0x803000,%eax
  800913:	ff 75 0c             	pushl  0xc(%ebp)
  800916:	ff 75 08             	pushl  0x8(%ebp)
  800919:	50                   	push   %eax
  80091a:	68 c1 29 80 00       	push   $0x8029c1
  80091f:	e8 5e 02 00 00       	call   800b82 <cprintf>
  800924:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800927:	8b 45 10             	mov    0x10(%ebp),%eax
  80092a:	83 ec 08             	sub    $0x8,%esp
  80092d:	ff 75 f4             	pushl  -0xc(%ebp)
  800930:	50                   	push   %eax
  800931:	e8 e1 01 00 00       	call   800b17 <vcprintf>
  800936:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800939:	83 ec 08             	sub    $0x8,%esp
  80093c:	6a 00                	push   $0x0
  80093e:	68 dd 29 80 00       	push   $0x8029dd
  800943:	e8 cf 01 00 00       	call   800b17 <vcprintf>
  800948:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80094b:	e8 82 ff ff ff       	call   8008d2 <exit>

	// should not return here
	while (1) ;
  800950:	eb fe                	jmp    800950 <_panic+0x70>

00800952 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800952:	55                   	push   %ebp
  800953:	89 e5                	mov    %esp,%ebp
  800955:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800958:	a1 24 30 80 00       	mov    0x803024,%eax
  80095d:	8b 50 74             	mov    0x74(%eax),%edx
  800960:	8b 45 0c             	mov    0xc(%ebp),%eax
  800963:	39 c2                	cmp    %eax,%edx
  800965:	74 14                	je     80097b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800967:	83 ec 04             	sub    $0x4,%esp
  80096a:	68 e0 29 80 00       	push   $0x8029e0
  80096f:	6a 26                	push   $0x26
  800971:	68 2c 2a 80 00       	push   $0x802a2c
  800976:	e8 65 ff ff ff       	call   8008e0 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80097b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800982:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800989:	e9 b6 00 00 00       	jmp    800a44 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80098e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800991:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800998:	8b 45 08             	mov    0x8(%ebp),%eax
  80099b:	01 d0                	add    %edx,%eax
  80099d:	8b 00                	mov    (%eax),%eax
  80099f:	85 c0                	test   %eax,%eax
  8009a1:	75 08                	jne    8009ab <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009a3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009a6:	e9 96 00 00 00       	jmp    800a41 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8009ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009b2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009b9:	eb 5d                	jmp    800a18 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009bb:	a1 24 30 80 00       	mov    0x803024,%eax
  8009c0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009c6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009c9:	c1 e2 04             	shl    $0x4,%edx
  8009cc:	01 d0                	add    %edx,%eax
  8009ce:	8a 40 04             	mov    0x4(%eax),%al
  8009d1:	84 c0                	test   %al,%al
  8009d3:	75 40                	jne    800a15 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009d5:	a1 24 30 80 00       	mov    0x803024,%eax
  8009da:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009e0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009e3:	c1 e2 04             	shl    $0x4,%edx
  8009e6:	01 d0                	add    %edx,%eax
  8009e8:	8b 00                	mov    (%eax),%eax
  8009ea:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009ed:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009f5:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009fa:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	01 c8                	add    %ecx,%eax
  800a06:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a08:	39 c2                	cmp    %eax,%edx
  800a0a:	75 09                	jne    800a15 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800a0c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a13:	eb 12                	jmp    800a27 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a15:	ff 45 e8             	incl   -0x18(%ebp)
  800a18:	a1 24 30 80 00       	mov    0x803024,%eax
  800a1d:	8b 50 74             	mov    0x74(%eax),%edx
  800a20:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a23:	39 c2                	cmp    %eax,%edx
  800a25:	77 94                	ja     8009bb <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a27:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a2b:	75 14                	jne    800a41 <CheckWSWithoutLastIndex+0xef>
			panic(
  800a2d:	83 ec 04             	sub    $0x4,%esp
  800a30:	68 38 2a 80 00       	push   $0x802a38
  800a35:	6a 3a                	push   $0x3a
  800a37:	68 2c 2a 80 00       	push   $0x802a2c
  800a3c:	e8 9f fe ff ff       	call   8008e0 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a41:	ff 45 f0             	incl   -0x10(%ebp)
  800a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a47:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a4a:	0f 8c 3e ff ff ff    	jl     80098e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a50:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a57:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a5e:	eb 20                	jmp    800a80 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a60:	a1 24 30 80 00       	mov    0x803024,%eax
  800a65:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a6b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a6e:	c1 e2 04             	shl    $0x4,%edx
  800a71:	01 d0                	add    %edx,%eax
  800a73:	8a 40 04             	mov    0x4(%eax),%al
  800a76:	3c 01                	cmp    $0x1,%al
  800a78:	75 03                	jne    800a7d <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800a7a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a7d:	ff 45 e0             	incl   -0x20(%ebp)
  800a80:	a1 24 30 80 00       	mov    0x803024,%eax
  800a85:	8b 50 74             	mov    0x74(%eax),%edx
  800a88:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a8b:	39 c2                	cmp    %eax,%edx
  800a8d:	77 d1                	ja     800a60 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a92:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a95:	74 14                	je     800aab <CheckWSWithoutLastIndex+0x159>
		panic(
  800a97:	83 ec 04             	sub    $0x4,%esp
  800a9a:	68 8c 2a 80 00       	push   $0x802a8c
  800a9f:	6a 44                	push   $0x44
  800aa1:	68 2c 2a 80 00       	push   $0x802a2c
  800aa6:	e8 35 fe ff ff       	call   8008e0 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800aab:	90                   	nop
  800aac:	c9                   	leave  
  800aad:	c3                   	ret    

00800aae <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800aae:	55                   	push   %ebp
  800aaf:	89 e5                	mov    %esp,%ebp
  800ab1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab7:	8b 00                	mov    (%eax),%eax
  800ab9:	8d 48 01             	lea    0x1(%eax),%ecx
  800abc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800abf:	89 0a                	mov    %ecx,(%edx)
  800ac1:	8b 55 08             	mov    0x8(%ebp),%edx
  800ac4:	88 d1                	mov    %dl,%cl
  800ac6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800acd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad0:	8b 00                	mov    (%eax),%eax
  800ad2:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ad7:	75 2c                	jne    800b05 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ad9:	a0 28 30 80 00       	mov    0x803028,%al
  800ade:	0f b6 c0             	movzbl %al,%eax
  800ae1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae4:	8b 12                	mov    (%edx),%edx
  800ae6:	89 d1                	mov    %edx,%ecx
  800ae8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aeb:	83 c2 08             	add    $0x8,%edx
  800aee:	83 ec 04             	sub    $0x4,%esp
  800af1:	50                   	push   %eax
  800af2:	51                   	push   %ecx
  800af3:	52                   	push   %edx
  800af4:	e8 8d 13 00 00       	call   801e86 <sys_cputs>
  800af9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800afc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b08:	8b 40 04             	mov    0x4(%eax),%eax
  800b0b:	8d 50 01             	lea    0x1(%eax),%edx
  800b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b11:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b14:	90                   	nop
  800b15:	c9                   	leave  
  800b16:	c3                   	ret    

00800b17 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b17:	55                   	push   %ebp
  800b18:	89 e5                	mov    %esp,%ebp
  800b1a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b20:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b27:	00 00 00 
	b.cnt = 0;
  800b2a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b31:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b34:	ff 75 0c             	pushl  0xc(%ebp)
  800b37:	ff 75 08             	pushl  0x8(%ebp)
  800b3a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b40:	50                   	push   %eax
  800b41:	68 ae 0a 80 00       	push   $0x800aae
  800b46:	e8 11 02 00 00       	call   800d5c <vprintfmt>
  800b4b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b4e:	a0 28 30 80 00       	mov    0x803028,%al
  800b53:	0f b6 c0             	movzbl %al,%eax
  800b56:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b5c:	83 ec 04             	sub    $0x4,%esp
  800b5f:	50                   	push   %eax
  800b60:	52                   	push   %edx
  800b61:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b67:	83 c0 08             	add    $0x8,%eax
  800b6a:	50                   	push   %eax
  800b6b:	e8 16 13 00 00       	call   801e86 <sys_cputs>
  800b70:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b73:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b7a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b80:	c9                   	leave  
  800b81:	c3                   	ret    

00800b82 <cprintf>:

int cprintf(const char *fmt, ...) {
  800b82:	55                   	push   %ebp
  800b83:	89 e5                	mov    %esp,%ebp
  800b85:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b88:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b8f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b92:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	83 ec 08             	sub    $0x8,%esp
  800b9b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b9e:	50                   	push   %eax
  800b9f:	e8 73 ff ff ff       	call   800b17 <vcprintf>
  800ba4:	83 c4 10             	add    $0x10,%esp
  800ba7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800baa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bad:	c9                   	leave  
  800bae:	c3                   	ret    

00800baf <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800baf:	55                   	push   %ebp
  800bb0:	89 e5                	mov    %esp,%ebp
  800bb2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bb5:	e8 dd 14 00 00       	call   802097 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bba:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	83 ec 08             	sub    $0x8,%esp
  800bc6:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc9:	50                   	push   %eax
  800bca:	e8 48 ff ff ff       	call   800b17 <vcprintf>
  800bcf:	83 c4 10             	add    $0x10,%esp
  800bd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bd5:	e8 d7 14 00 00       	call   8020b1 <sys_enable_interrupt>
	return cnt;
  800bda:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bdd:	c9                   	leave  
  800bde:	c3                   	ret    

00800bdf <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bdf:	55                   	push   %ebp
  800be0:	89 e5                	mov    %esp,%ebp
  800be2:	53                   	push   %ebx
  800be3:	83 ec 14             	sub    $0x14,%esp
  800be6:	8b 45 10             	mov    0x10(%ebp),%eax
  800be9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bec:	8b 45 14             	mov    0x14(%ebp),%eax
  800bef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bf2:	8b 45 18             	mov    0x18(%ebp),%eax
  800bf5:	ba 00 00 00 00       	mov    $0x0,%edx
  800bfa:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bfd:	77 55                	ja     800c54 <printnum+0x75>
  800bff:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c02:	72 05                	jb     800c09 <printnum+0x2a>
  800c04:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c07:	77 4b                	ja     800c54 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c09:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c0c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c0f:	8b 45 18             	mov    0x18(%ebp),%eax
  800c12:	ba 00 00 00 00       	mov    $0x0,%edx
  800c17:	52                   	push   %edx
  800c18:	50                   	push   %eax
  800c19:	ff 75 f4             	pushl  -0xc(%ebp)
  800c1c:	ff 75 f0             	pushl  -0x10(%ebp)
  800c1f:	e8 94 18 00 00       	call   8024b8 <__udivdi3>
  800c24:	83 c4 10             	add    $0x10,%esp
  800c27:	83 ec 04             	sub    $0x4,%esp
  800c2a:	ff 75 20             	pushl  0x20(%ebp)
  800c2d:	53                   	push   %ebx
  800c2e:	ff 75 18             	pushl  0x18(%ebp)
  800c31:	52                   	push   %edx
  800c32:	50                   	push   %eax
  800c33:	ff 75 0c             	pushl  0xc(%ebp)
  800c36:	ff 75 08             	pushl  0x8(%ebp)
  800c39:	e8 a1 ff ff ff       	call   800bdf <printnum>
  800c3e:	83 c4 20             	add    $0x20,%esp
  800c41:	eb 1a                	jmp    800c5d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c43:	83 ec 08             	sub    $0x8,%esp
  800c46:	ff 75 0c             	pushl  0xc(%ebp)
  800c49:	ff 75 20             	pushl  0x20(%ebp)
  800c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4f:	ff d0                	call   *%eax
  800c51:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c54:	ff 4d 1c             	decl   0x1c(%ebp)
  800c57:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c5b:	7f e6                	jg     800c43 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c5d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c60:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c6b:	53                   	push   %ebx
  800c6c:	51                   	push   %ecx
  800c6d:	52                   	push   %edx
  800c6e:	50                   	push   %eax
  800c6f:	e8 54 19 00 00       	call   8025c8 <__umoddi3>
  800c74:	83 c4 10             	add    $0x10,%esp
  800c77:	05 f4 2c 80 00       	add    $0x802cf4,%eax
  800c7c:	8a 00                	mov    (%eax),%al
  800c7e:	0f be c0             	movsbl %al,%eax
  800c81:	83 ec 08             	sub    $0x8,%esp
  800c84:	ff 75 0c             	pushl  0xc(%ebp)
  800c87:	50                   	push   %eax
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8b:	ff d0                	call   *%eax
  800c8d:	83 c4 10             	add    $0x10,%esp
}
  800c90:	90                   	nop
  800c91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c94:	c9                   	leave  
  800c95:	c3                   	ret    

00800c96 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c96:	55                   	push   %ebp
  800c97:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c99:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c9d:	7e 1c                	jle    800cbb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	8b 00                	mov    (%eax),%eax
  800ca4:	8d 50 08             	lea    0x8(%eax),%edx
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	89 10                	mov    %edx,(%eax)
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	8b 00                	mov    (%eax),%eax
  800cb1:	83 e8 08             	sub    $0x8,%eax
  800cb4:	8b 50 04             	mov    0x4(%eax),%edx
  800cb7:	8b 00                	mov    (%eax),%eax
  800cb9:	eb 40                	jmp    800cfb <getuint+0x65>
	else if (lflag)
  800cbb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cbf:	74 1e                	je     800cdf <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	8b 00                	mov    (%eax),%eax
  800cc6:	8d 50 04             	lea    0x4(%eax),%edx
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	89 10                	mov    %edx,(%eax)
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	8b 00                	mov    (%eax),%eax
  800cd3:	83 e8 04             	sub    $0x4,%eax
  800cd6:	8b 00                	mov    (%eax),%eax
  800cd8:	ba 00 00 00 00       	mov    $0x0,%edx
  800cdd:	eb 1c                	jmp    800cfb <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	8b 00                	mov    (%eax),%eax
  800ce4:	8d 50 04             	lea    0x4(%eax),%edx
  800ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cea:	89 10                	mov    %edx,(%eax)
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	8b 00                	mov    (%eax),%eax
  800cf1:	83 e8 04             	sub    $0x4,%eax
  800cf4:	8b 00                	mov    (%eax),%eax
  800cf6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cfb:	5d                   	pop    %ebp
  800cfc:	c3                   	ret    

00800cfd <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d00:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d04:	7e 1c                	jle    800d22 <getint+0x25>
		return va_arg(*ap, long long);
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8b 00                	mov    (%eax),%eax
  800d0b:	8d 50 08             	lea    0x8(%eax),%edx
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	89 10                	mov    %edx,(%eax)
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8b 00                	mov    (%eax),%eax
  800d18:	83 e8 08             	sub    $0x8,%eax
  800d1b:	8b 50 04             	mov    0x4(%eax),%edx
  800d1e:	8b 00                	mov    (%eax),%eax
  800d20:	eb 38                	jmp    800d5a <getint+0x5d>
	else if (lflag)
  800d22:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d26:	74 1a                	je     800d42 <getint+0x45>
		return va_arg(*ap, long);
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8b 00                	mov    (%eax),%eax
  800d2d:	8d 50 04             	lea    0x4(%eax),%edx
  800d30:	8b 45 08             	mov    0x8(%ebp),%eax
  800d33:	89 10                	mov    %edx,(%eax)
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8b 00                	mov    (%eax),%eax
  800d3a:	83 e8 04             	sub    $0x4,%eax
  800d3d:	8b 00                	mov    (%eax),%eax
  800d3f:	99                   	cltd   
  800d40:	eb 18                	jmp    800d5a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	8b 00                	mov    (%eax),%eax
  800d47:	8d 50 04             	lea    0x4(%eax),%edx
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	89 10                	mov    %edx,(%eax)
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8b 00                	mov    (%eax),%eax
  800d54:	83 e8 04             	sub    $0x4,%eax
  800d57:	8b 00                	mov    (%eax),%eax
  800d59:	99                   	cltd   
}
  800d5a:	5d                   	pop    %ebp
  800d5b:	c3                   	ret    

00800d5c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d5c:	55                   	push   %ebp
  800d5d:	89 e5                	mov    %esp,%ebp
  800d5f:	56                   	push   %esi
  800d60:	53                   	push   %ebx
  800d61:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d64:	eb 17                	jmp    800d7d <vprintfmt+0x21>
			if (ch == '\0')
  800d66:	85 db                	test   %ebx,%ebx
  800d68:	0f 84 af 03 00 00    	je     80111d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d6e:	83 ec 08             	sub    $0x8,%esp
  800d71:	ff 75 0c             	pushl  0xc(%ebp)
  800d74:	53                   	push   %ebx
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	ff d0                	call   *%eax
  800d7a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d80:	8d 50 01             	lea    0x1(%eax),%edx
  800d83:	89 55 10             	mov    %edx,0x10(%ebp)
  800d86:	8a 00                	mov    (%eax),%al
  800d88:	0f b6 d8             	movzbl %al,%ebx
  800d8b:	83 fb 25             	cmp    $0x25,%ebx
  800d8e:	75 d6                	jne    800d66 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d90:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d94:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d9b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800da2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800da9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800db0:	8b 45 10             	mov    0x10(%ebp),%eax
  800db3:	8d 50 01             	lea    0x1(%eax),%edx
  800db6:	89 55 10             	mov    %edx,0x10(%ebp)
  800db9:	8a 00                	mov    (%eax),%al
  800dbb:	0f b6 d8             	movzbl %al,%ebx
  800dbe:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dc1:	83 f8 55             	cmp    $0x55,%eax
  800dc4:	0f 87 2b 03 00 00    	ja     8010f5 <vprintfmt+0x399>
  800dca:	8b 04 85 18 2d 80 00 	mov    0x802d18(,%eax,4),%eax
  800dd1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dd3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dd7:	eb d7                	jmp    800db0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dd9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ddd:	eb d1                	jmp    800db0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ddf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800de6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800de9:	89 d0                	mov    %edx,%eax
  800deb:	c1 e0 02             	shl    $0x2,%eax
  800dee:	01 d0                	add    %edx,%eax
  800df0:	01 c0                	add    %eax,%eax
  800df2:	01 d8                	add    %ebx,%eax
  800df4:	83 e8 30             	sub    $0x30,%eax
  800df7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800dfa:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfd:	8a 00                	mov    (%eax),%al
  800dff:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e02:	83 fb 2f             	cmp    $0x2f,%ebx
  800e05:	7e 3e                	jle    800e45 <vprintfmt+0xe9>
  800e07:	83 fb 39             	cmp    $0x39,%ebx
  800e0a:	7f 39                	jg     800e45 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e0c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e0f:	eb d5                	jmp    800de6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e11:	8b 45 14             	mov    0x14(%ebp),%eax
  800e14:	83 c0 04             	add    $0x4,%eax
  800e17:	89 45 14             	mov    %eax,0x14(%ebp)
  800e1a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1d:	83 e8 04             	sub    $0x4,%eax
  800e20:	8b 00                	mov    (%eax),%eax
  800e22:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e25:	eb 1f                	jmp    800e46 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e27:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e2b:	79 83                	jns    800db0 <vprintfmt+0x54>
				width = 0;
  800e2d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e34:	e9 77 ff ff ff       	jmp    800db0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e39:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e40:	e9 6b ff ff ff       	jmp    800db0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e45:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e46:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4a:	0f 89 60 ff ff ff    	jns    800db0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e50:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e53:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e56:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e5d:	e9 4e ff ff ff       	jmp    800db0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e62:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e65:	e9 46 ff ff ff       	jmp    800db0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e6a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6d:	83 c0 04             	add    $0x4,%eax
  800e70:	89 45 14             	mov    %eax,0x14(%ebp)
  800e73:	8b 45 14             	mov    0x14(%ebp),%eax
  800e76:	83 e8 04             	sub    $0x4,%eax
  800e79:	8b 00                	mov    (%eax),%eax
  800e7b:	83 ec 08             	sub    $0x8,%esp
  800e7e:	ff 75 0c             	pushl  0xc(%ebp)
  800e81:	50                   	push   %eax
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	ff d0                	call   *%eax
  800e87:	83 c4 10             	add    $0x10,%esp
			break;
  800e8a:	e9 89 02 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e92:	83 c0 04             	add    $0x4,%eax
  800e95:	89 45 14             	mov    %eax,0x14(%ebp)
  800e98:	8b 45 14             	mov    0x14(%ebp),%eax
  800e9b:	83 e8 04             	sub    $0x4,%eax
  800e9e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ea0:	85 db                	test   %ebx,%ebx
  800ea2:	79 02                	jns    800ea6 <vprintfmt+0x14a>
				err = -err;
  800ea4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ea6:	83 fb 64             	cmp    $0x64,%ebx
  800ea9:	7f 0b                	jg     800eb6 <vprintfmt+0x15a>
  800eab:	8b 34 9d 60 2b 80 00 	mov    0x802b60(,%ebx,4),%esi
  800eb2:	85 f6                	test   %esi,%esi
  800eb4:	75 19                	jne    800ecf <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800eb6:	53                   	push   %ebx
  800eb7:	68 05 2d 80 00       	push   $0x802d05
  800ebc:	ff 75 0c             	pushl  0xc(%ebp)
  800ebf:	ff 75 08             	pushl  0x8(%ebp)
  800ec2:	e8 5e 02 00 00       	call   801125 <printfmt>
  800ec7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800eca:	e9 49 02 00 00       	jmp    801118 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ecf:	56                   	push   %esi
  800ed0:	68 0e 2d 80 00       	push   $0x802d0e
  800ed5:	ff 75 0c             	pushl  0xc(%ebp)
  800ed8:	ff 75 08             	pushl  0x8(%ebp)
  800edb:	e8 45 02 00 00       	call   801125 <printfmt>
  800ee0:	83 c4 10             	add    $0x10,%esp
			break;
  800ee3:	e9 30 02 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ee8:	8b 45 14             	mov    0x14(%ebp),%eax
  800eeb:	83 c0 04             	add    $0x4,%eax
  800eee:	89 45 14             	mov    %eax,0x14(%ebp)
  800ef1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef4:	83 e8 04             	sub    $0x4,%eax
  800ef7:	8b 30                	mov    (%eax),%esi
  800ef9:	85 f6                	test   %esi,%esi
  800efb:	75 05                	jne    800f02 <vprintfmt+0x1a6>
				p = "(null)";
  800efd:	be 11 2d 80 00       	mov    $0x802d11,%esi
			if (width > 0 && padc != '-')
  800f02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f06:	7e 6d                	jle    800f75 <vprintfmt+0x219>
  800f08:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f0c:	74 67                	je     800f75 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f11:	83 ec 08             	sub    $0x8,%esp
  800f14:	50                   	push   %eax
  800f15:	56                   	push   %esi
  800f16:	e8 12 05 00 00       	call   80142d <strnlen>
  800f1b:	83 c4 10             	add    $0x10,%esp
  800f1e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f21:	eb 16                	jmp    800f39 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f23:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f27:	83 ec 08             	sub    $0x8,%esp
  800f2a:	ff 75 0c             	pushl  0xc(%ebp)
  800f2d:	50                   	push   %eax
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	ff d0                	call   *%eax
  800f33:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f36:	ff 4d e4             	decl   -0x1c(%ebp)
  800f39:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f3d:	7f e4                	jg     800f23 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f3f:	eb 34                	jmp    800f75 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f41:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f45:	74 1c                	je     800f63 <vprintfmt+0x207>
  800f47:	83 fb 1f             	cmp    $0x1f,%ebx
  800f4a:	7e 05                	jle    800f51 <vprintfmt+0x1f5>
  800f4c:	83 fb 7e             	cmp    $0x7e,%ebx
  800f4f:	7e 12                	jle    800f63 <vprintfmt+0x207>
					putch('?', putdat);
  800f51:	83 ec 08             	sub    $0x8,%esp
  800f54:	ff 75 0c             	pushl  0xc(%ebp)
  800f57:	6a 3f                	push   $0x3f
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	ff d0                	call   *%eax
  800f5e:	83 c4 10             	add    $0x10,%esp
  800f61:	eb 0f                	jmp    800f72 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f63:	83 ec 08             	sub    $0x8,%esp
  800f66:	ff 75 0c             	pushl  0xc(%ebp)
  800f69:	53                   	push   %ebx
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	ff d0                	call   *%eax
  800f6f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f72:	ff 4d e4             	decl   -0x1c(%ebp)
  800f75:	89 f0                	mov    %esi,%eax
  800f77:	8d 70 01             	lea    0x1(%eax),%esi
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	0f be d8             	movsbl %al,%ebx
  800f7f:	85 db                	test   %ebx,%ebx
  800f81:	74 24                	je     800fa7 <vprintfmt+0x24b>
  800f83:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f87:	78 b8                	js     800f41 <vprintfmt+0x1e5>
  800f89:	ff 4d e0             	decl   -0x20(%ebp)
  800f8c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f90:	79 af                	jns    800f41 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f92:	eb 13                	jmp    800fa7 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f94:	83 ec 08             	sub    $0x8,%esp
  800f97:	ff 75 0c             	pushl  0xc(%ebp)
  800f9a:	6a 20                	push   $0x20
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	ff d0                	call   *%eax
  800fa1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fa4:	ff 4d e4             	decl   -0x1c(%ebp)
  800fa7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fab:	7f e7                	jg     800f94 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fad:	e9 66 01 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fb2:	83 ec 08             	sub    $0x8,%esp
  800fb5:	ff 75 e8             	pushl  -0x18(%ebp)
  800fb8:	8d 45 14             	lea    0x14(%ebp),%eax
  800fbb:	50                   	push   %eax
  800fbc:	e8 3c fd ff ff       	call   800cfd <getint>
  800fc1:	83 c4 10             	add    $0x10,%esp
  800fc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fcd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fd0:	85 d2                	test   %edx,%edx
  800fd2:	79 23                	jns    800ff7 <vprintfmt+0x29b>
				putch('-', putdat);
  800fd4:	83 ec 08             	sub    $0x8,%esp
  800fd7:	ff 75 0c             	pushl  0xc(%ebp)
  800fda:	6a 2d                	push   $0x2d
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	ff d0                	call   *%eax
  800fe1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fe4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fea:	f7 d8                	neg    %eax
  800fec:	83 d2 00             	adc    $0x0,%edx
  800fef:	f7 da                	neg    %edx
  800ff1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ff7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ffe:	e9 bc 00 00 00       	jmp    8010bf <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801003:	83 ec 08             	sub    $0x8,%esp
  801006:	ff 75 e8             	pushl  -0x18(%ebp)
  801009:	8d 45 14             	lea    0x14(%ebp),%eax
  80100c:	50                   	push   %eax
  80100d:	e8 84 fc ff ff       	call   800c96 <getuint>
  801012:	83 c4 10             	add    $0x10,%esp
  801015:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801018:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80101b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801022:	e9 98 00 00 00       	jmp    8010bf <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801027:	83 ec 08             	sub    $0x8,%esp
  80102a:	ff 75 0c             	pushl  0xc(%ebp)
  80102d:	6a 58                	push   $0x58
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	ff d0                	call   *%eax
  801034:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801037:	83 ec 08             	sub    $0x8,%esp
  80103a:	ff 75 0c             	pushl  0xc(%ebp)
  80103d:	6a 58                	push   $0x58
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	ff d0                	call   *%eax
  801044:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801047:	83 ec 08             	sub    $0x8,%esp
  80104a:	ff 75 0c             	pushl  0xc(%ebp)
  80104d:	6a 58                	push   $0x58
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	ff d0                	call   *%eax
  801054:	83 c4 10             	add    $0x10,%esp
			break;
  801057:	e9 bc 00 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80105c:	83 ec 08             	sub    $0x8,%esp
  80105f:	ff 75 0c             	pushl  0xc(%ebp)
  801062:	6a 30                	push   $0x30
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	ff d0                	call   *%eax
  801069:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80106c:	83 ec 08             	sub    $0x8,%esp
  80106f:	ff 75 0c             	pushl  0xc(%ebp)
  801072:	6a 78                	push   $0x78
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	ff d0                	call   *%eax
  801079:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80107c:	8b 45 14             	mov    0x14(%ebp),%eax
  80107f:	83 c0 04             	add    $0x4,%eax
  801082:	89 45 14             	mov    %eax,0x14(%ebp)
  801085:	8b 45 14             	mov    0x14(%ebp),%eax
  801088:	83 e8 04             	sub    $0x4,%eax
  80108b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80108d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801097:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80109e:	eb 1f                	jmp    8010bf <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010a0:	83 ec 08             	sub    $0x8,%esp
  8010a3:	ff 75 e8             	pushl  -0x18(%ebp)
  8010a6:	8d 45 14             	lea    0x14(%ebp),%eax
  8010a9:	50                   	push   %eax
  8010aa:	e8 e7 fb ff ff       	call   800c96 <getuint>
  8010af:	83 c4 10             	add    $0x10,%esp
  8010b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010b5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010b8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010bf:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010c6:	83 ec 04             	sub    $0x4,%esp
  8010c9:	52                   	push   %edx
  8010ca:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010cd:	50                   	push   %eax
  8010ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d1:	ff 75 f0             	pushl  -0x10(%ebp)
  8010d4:	ff 75 0c             	pushl  0xc(%ebp)
  8010d7:	ff 75 08             	pushl  0x8(%ebp)
  8010da:	e8 00 fb ff ff       	call   800bdf <printnum>
  8010df:	83 c4 20             	add    $0x20,%esp
			break;
  8010e2:	eb 34                	jmp    801118 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010e4:	83 ec 08             	sub    $0x8,%esp
  8010e7:	ff 75 0c             	pushl  0xc(%ebp)
  8010ea:	53                   	push   %ebx
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	ff d0                	call   *%eax
  8010f0:	83 c4 10             	add    $0x10,%esp
			break;
  8010f3:	eb 23                	jmp    801118 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010f5:	83 ec 08             	sub    $0x8,%esp
  8010f8:	ff 75 0c             	pushl  0xc(%ebp)
  8010fb:	6a 25                	push   $0x25
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	ff d0                	call   *%eax
  801102:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801105:	ff 4d 10             	decl   0x10(%ebp)
  801108:	eb 03                	jmp    80110d <vprintfmt+0x3b1>
  80110a:	ff 4d 10             	decl   0x10(%ebp)
  80110d:	8b 45 10             	mov    0x10(%ebp),%eax
  801110:	48                   	dec    %eax
  801111:	8a 00                	mov    (%eax),%al
  801113:	3c 25                	cmp    $0x25,%al
  801115:	75 f3                	jne    80110a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801117:	90                   	nop
		}
	}
  801118:	e9 47 fc ff ff       	jmp    800d64 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80111d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80111e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801121:	5b                   	pop    %ebx
  801122:	5e                   	pop    %esi
  801123:	5d                   	pop    %ebp
  801124:	c3                   	ret    

00801125 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801125:	55                   	push   %ebp
  801126:	89 e5                	mov    %esp,%ebp
  801128:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80112b:	8d 45 10             	lea    0x10(%ebp),%eax
  80112e:	83 c0 04             	add    $0x4,%eax
  801131:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801134:	8b 45 10             	mov    0x10(%ebp),%eax
  801137:	ff 75 f4             	pushl  -0xc(%ebp)
  80113a:	50                   	push   %eax
  80113b:	ff 75 0c             	pushl  0xc(%ebp)
  80113e:	ff 75 08             	pushl  0x8(%ebp)
  801141:	e8 16 fc ff ff       	call   800d5c <vprintfmt>
  801146:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801149:	90                   	nop
  80114a:	c9                   	leave  
  80114b:	c3                   	ret    

0080114c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80114c:	55                   	push   %ebp
  80114d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80114f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801152:	8b 40 08             	mov    0x8(%eax),%eax
  801155:	8d 50 01             	lea    0x1(%eax),%edx
  801158:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80115e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801161:	8b 10                	mov    (%eax),%edx
  801163:	8b 45 0c             	mov    0xc(%ebp),%eax
  801166:	8b 40 04             	mov    0x4(%eax),%eax
  801169:	39 c2                	cmp    %eax,%edx
  80116b:	73 12                	jae    80117f <sprintputch+0x33>
		*b->buf++ = ch;
  80116d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801170:	8b 00                	mov    (%eax),%eax
  801172:	8d 48 01             	lea    0x1(%eax),%ecx
  801175:	8b 55 0c             	mov    0xc(%ebp),%edx
  801178:	89 0a                	mov    %ecx,(%edx)
  80117a:	8b 55 08             	mov    0x8(%ebp),%edx
  80117d:	88 10                	mov    %dl,(%eax)
}
  80117f:	90                   	nop
  801180:	5d                   	pop    %ebp
  801181:	c3                   	ret    

00801182 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801182:	55                   	push   %ebp
  801183:	89 e5                	mov    %esp,%ebp
  801185:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80118e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801191:	8d 50 ff             	lea    -0x1(%eax),%edx
  801194:	8b 45 08             	mov    0x8(%ebp),%eax
  801197:	01 d0                	add    %edx,%eax
  801199:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80119c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011a7:	74 06                	je     8011af <vsnprintf+0x2d>
  8011a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011ad:	7f 07                	jg     8011b6 <vsnprintf+0x34>
		return -E_INVAL;
  8011af:	b8 03 00 00 00       	mov    $0x3,%eax
  8011b4:	eb 20                	jmp    8011d6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011b6:	ff 75 14             	pushl  0x14(%ebp)
  8011b9:	ff 75 10             	pushl  0x10(%ebp)
  8011bc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011bf:	50                   	push   %eax
  8011c0:	68 4c 11 80 00       	push   $0x80114c
  8011c5:	e8 92 fb ff ff       	call   800d5c <vprintfmt>
  8011ca:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011d0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011d6:	c9                   	leave  
  8011d7:	c3                   	ret    

008011d8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011d8:	55                   	push   %ebp
  8011d9:	89 e5                	mov    %esp,%ebp
  8011db:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011de:	8d 45 10             	lea    0x10(%ebp),%eax
  8011e1:	83 c0 04             	add    $0x4,%eax
  8011e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8011ed:	50                   	push   %eax
  8011ee:	ff 75 0c             	pushl  0xc(%ebp)
  8011f1:	ff 75 08             	pushl  0x8(%ebp)
  8011f4:	e8 89 ff ff ff       	call   801182 <vsnprintf>
  8011f9:	83 c4 10             	add    $0x10,%esp
  8011fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801202:	c9                   	leave  
  801203:	c3                   	ret    

00801204 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801204:	55                   	push   %ebp
  801205:	89 e5                	mov    %esp,%ebp
  801207:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80120a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80120e:	74 13                	je     801223 <readline+0x1f>
		cprintf("%s", prompt);
  801210:	83 ec 08             	sub    $0x8,%esp
  801213:	ff 75 08             	pushl  0x8(%ebp)
  801216:	68 70 2e 80 00       	push   $0x802e70
  80121b:	e8 62 f9 ff ff       	call   800b82 <cprintf>
  801220:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801223:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80122a:	83 ec 0c             	sub    $0xc,%esp
  80122d:	6a 00                	push   $0x0
  80122f:	e8 5d f5 ff ff       	call   800791 <iscons>
  801234:	83 c4 10             	add    $0x10,%esp
  801237:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80123a:	e8 04 f5 ff ff       	call   800743 <getchar>
  80123f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801242:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801246:	79 22                	jns    80126a <readline+0x66>
			if (c != -E_EOF)
  801248:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80124c:	0f 84 ad 00 00 00    	je     8012ff <readline+0xfb>
				cprintf("read error: %e\n", c);
  801252:	83 ec 08             	sub    $0x8,%esp
  801255:	ff 75 ec             	pushl  -0x14(%ebp)
  801258:	68 73 2e 80 00       	push   $0x802e73
  80125d:	e8 20 f9 ff ff       	call   800b82 <cprintf>
  801262:	83 c4 10             	add    $0x10,%esp
			return;
  801265:	e9 95 00 00 00       	jmp    8012ff <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80126a:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80126e:	7e 34                	jle    8012a4 <readline+0xa0>
  801270:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801277:	7f 2b                	jg     8012a4 <readline+0xa0>
			if (echoing)
  801279:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80127d:	74 0e                	je     80128d <readline+0x89>
				cputchar(c);
  80127f:	83 ec 0c             	sub    $0xc,%esp
  801282:	ff 75 ec             	pushl  -0x14(%ebp)
  801285:	e8 71 f4 ff ff       	call   8006fb <cputchar>
  80128a:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80128d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801290:	8d 50 01             	lea    0x1(%eax),%edx
  801293:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801296:	89 c2                	mov    %eax,%edx
  801298:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129b:	01 d0                	add    %edx,%eax
  80129d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a0:	88 10                	mov    %dl,(%eax)
  8012a2:	eb 56                	jmp    8012fa <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012a4:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012a8:	75 1f                	jne    8012c9 <readline+0xc5>
  8012aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012ae:	7e 19                	jle    8012c9 <readline+0xc5>
			if (echoing)
  8012b0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012b4:	74 0e                	je     8012c4 <readline+0xc0>
				cputchar(c);
  8012b6:	83 ec 0c             	sub    $0xc,%esp
  8012b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8012bc:	e8 3a f4 ff ff       	call   8006fb <cputchar>
  8012c1:	83 c4 10             	add    $0x10,%esp

			i--;
  8012c4:	ff 4d f4             	decl   -0xc(%ebp)
  8012c7:	eb 31                	jmp    8012fa <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012c9:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012cd:	74 0a                	je     8012d9 <readline+0xd5>
  8012cf:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012d3:	0f 85 61 ff ff ff    	jne    80123a <readline+0x36>
			if (echoing)
  8012d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012dd:	74 0e                	je     8012ed <readline+0xe9>
				cputchar(c);
  8012df:	83 ec 0c             	sub    $0xc,%esp
  8012e2:	ff 75 ec             	pushl  -0x14(%ebp)
  8012e5:	e8 11 f4 ff ff       	call   8006fb <cputchar>
  8012ea:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f3:	01 d0                	add    %edx,%eax
  8012f5:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8012f8:	eb 06                	jmp    801300 <readline+0xfc>
		}
	}
  8012fa:	e9 3b ff ff ff       	jmp    80123a <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8012ff:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
  801305:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801308:	e8 8a 0d 00 00       	call   802097 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80130d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801311:	74 13                	je     801326 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801313:	83 ec 08             	sub    $0x8,%esp
  801316:	ff 75 08             	pushl  0x8(%ebp)
  801319:	68 70 2e 80 00       	push   $0x802e70
  80131e:	e8 5f f8 ff ff       	call   800b82 <cprintf>
  801323:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801326:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80132d:	83 ec 0c             	sub    $0xc,%esp
  801330:	6a 00                	push   $0x0
  801332:	e8 5a f4 ff ff       	call   800791 <iscons>
  801337:	83 c4 10             	add    $0x10,%esp
  80133a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80133d:	e8 01 f4 ff ff       	call   800743 <getchar>
  801342:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801345:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801349:	79 23                	jns    80136e <atomic_readline+0x6c>
			if (c != -E_EOF)
  80134b:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80134f:	74 13                	je     801364 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801351:	83 ec 08             	sub    $0x8,%esp
  801354:	ff 75 ec             	pushl  -0x14(%ebp)
  801357:	68 73 2e 80 00       	push   $0x802e73
  80135c:	e8 21 f8 ff ff       	call   800b82 <cprintf>
  801361:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801364:	e8 48 0d 00 00       	call   8020b1 <sys_enable_interrupt>
			return;
  801369:	e9 9a 00 00 00       	jmp    801408 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80136e:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801372:	7e 34                	jle    8013a8 <atomic_readline+0xa6>
  801374:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80137b:	7f 2b                	jg     8013a8 <atomic_readline+0xa6>
			if (echoing)
  80137d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801381:	74 0e                	je     801391 <atomic_readline+0x8f>
				cputchar(c);
  801383:	83 ec 0c             	sub    $0xc,%esp
  801386:	ff 75 ec             	pushl  -0x14(%ebp)
  801389:	e8 6d f3 ff ff       	call   8006fb <cputchar>
  80138e:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801391:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801394:	8d 50 01             	lea    0x1(%eax),%edx
  801397:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80139a:	89 c2                	mov    %eax,%edx
  80139c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139f:	01 d0                	add    %edx,%eax
  8013a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013a4:	88 10                	mov    %dl,(%eax)
  8013a6:	eb 5b                	jmp    801403 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013a8:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013ac:	75 1f                	jne    8013cd <atomic_readline+0xcb>
  8013ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013b2:	7e 19                	jle    8013cd <atomic_readline+0xcb>
			if (echoing)
  8013b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013b8:	74 0e                	je     8013c8 <atomic_readline+0xc6>
				cputchar(c);
  8013ba:	83 ec 0c             	sub    $0xc,%esp
  8013bd:	ff 75 ec             	pushl  -0x14(%ebp)
  8013c0:	e8 36 f3 ff ff       	call   8006fb <cputchar>
  8013c5:	83 c4 10             	add    $0x10,%esp
			i--;
  8013c8:	ff 4d f4             	decl   -0xc(%ebp)
  8013cb:	eb 36                	jmp    801403 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013cd:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013d1:	74 0a                	je     8013dd <atomic_readline+0xdb>
  8013d3:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013d7:	0f 85 60 ff ff ff    	jne    80133d <atomic_readline+0x3b>
			if (echoing)
  8013dd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013e1:	74 0e                	je     8013f1 <atomic_readline+0xef>
				cputchar(c);
  8013e3:	83 ec 0c             	sub    $0xc,%esp
  8013e6:	ff 75 ec             	pushl  -0x14(%ebp)
  8013e9:	e8 0d f3 ff ff       	call   8006fb <cputchar>
  8013ee:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8013f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f7:	01 d0                	add    %edx,%eax
  8013f9:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8013fc:	e8 b0 0c 00 00       	call   8020b1 <sys_enable_interrupt>
			return;
  801401:	eb 05                	jmp    801408 <atomic_readline+0x106>
		}
	}
  801403:	e9 35 ff ff ff       	jmp    80133d <atomic_readline+0x3b>
}
  801408:	c9                   	leave  
  801409:	c3                   	ret    

0080140a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80140a:	55                   	push   %ebp
  80140b:	89 e5                	mov    %esp,%ebp
  80140d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801410:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801417:	eb 06                	jmp    80141f <strlen+0x15>
		n++;
  801419:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80141c:	ff 45 08             	incl   0x8(%ebp)
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	84 c0                	test   %al,%al
  801426:	75 f1                	jne    801419 <strlen+0xf>
		n++;
	return n;
  801428:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80142b:	c9                   	leave  
  80142c:	c3                   	ret    

0080142d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
  801430:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801433:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80143a:	eb 09                	jmp    801445 <strnlen+0x18>
		n++;
  80143c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80143f:	ff 45 08             	incl   0x8(%ebp)
  801442:	ff 4d 0c             	decl   0xc(%ebp)
  801445:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801449:	74 09                	je     801454 <strnlen+0x27>
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	84 c0                	test   %al,%al
  801452:	75 e8                	jne    80143c <strnlen+0xf>
		n++;
	return n;
  801454:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801457:	c9                   	leave  
  801458:	c3                   	ret    

00801459 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801459:	55                   	push   %ebp
  80145a:	89 e5                	mov    %esp,%ebp
  80145c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801465:	90                   	nop
  801466:	8b 45 08             	mov    0x8(%ebp),%eax
  801469:	8d 50 01             	lea    0x1(%eax),%edx
  80146c:	89 55 08             	mov    %edx,0x8(%ebp)
  80146f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801472:	8d 4a 01             	lea    0x1(%edx),%ecx
  801475:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801478:	8a 12                	mov    (%edx),%dl
  80147a:	88 10                	mov    %dl,(%eax)
  80147c:	8a 00                	mov    (%eax),%al
  80147e:	84 c0                	test   %al,%al
  801480:	75 e4                	jne    801466 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801482:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801485:	c9                   	leave  
  801486:	c3                   	ret    

00801487 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
  80148a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801493:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80149a:	eb 1f                	jmp    8014bb <strncpy+0x34>
		*dst++ = *src;
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	8d 50 01             	lea    0x1(%eax),%edx
  8014a2:	89 55 08             	mov    %edx,0x8(%ebp)
  8014a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014a8:	8a 12                	mov    (%edx),%dl
  8014aa:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014af:	8a 00                	mov    (%eax),%al
  8014b1:	84 c0                	test   %al,%al
  8014b3:	74 03                	je     8014b8 <strncpy+0x31>
			src++;
  8014b5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014b8:	ff 45 fc             	incl   -0x4(%ebp)
  8014bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014be:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014c1:	72 d9                	jb     80149c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014d4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014d8:	74 30                	je     80150a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014da:	eb 16                	jmp    8014f2 <strlcpy+0x2a>
			*dst++ = *src++;
  8014dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014df:	8d 50 01             	lea    0x1(%eax),%edx
  8014e2:	89 55 08             	mov    %edx,0x8(%ebp)
  8014e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014eb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014ee:	8a 12                	mov    (%edx),%dl
  8014f0:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014f2:	ff 4d 10             	decl   0x10(%ebp)
  8014f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014f9:	74 09                	je     801504 <strlcpy+0x3c>
  8014fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fe:	8a 00                	mov    (%eax),%al
  801500:	84 c0                	test   %al,%al
  801502:	75 d8                	jne    8014dc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801504:	8b 45 08             	mov    0x8(%ebp),%eax
  801507:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80150a:	8b 55 08             	mov    0x8(%ebp),%edx
  80150d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801510:	29 c2                	sub    %eax,%edx
  801512:	89 d0                	mov    %edx,%eax
}
  801514:	c9                   	leave  
  801515:	c3                   	ret    

00801516 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801516:	55                   	push   %ebp
  801517:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801519:	eb 06                	jmp    801521 <strcmp+0xb>
		p++, q++;
  80151b:	ff 45 08             	incl   0x8(%ebp)
  80151e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801521:	8b 45 08             	mov    0x8(%ebp),%eax
  801524:	8a 00                	mov    (%eax),%al
  801526:	84 c0                	test   %al,%al
  801528:	74 0e                	je     801538 <strcmp+0x22>
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	8a 10                	mov    (%eax),%dl
  80152f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801532:	8a 00                	mov    (%eax),%al
  801534:	38 c2                	cmp    %al,%dl
  801536:	74 e3                	je     80151b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	8a 00                	mov    (%eax),%al
  80153d:	0f b6 d0             	movzbl %al,%edx
  801540:	8b 45 0c             	mov    0xc(%ebp),%eax
  801543:	8a 00                	mov    (%eax),%al
  801545:	0f b6 c0             	movzbl %al,%eax
  801548:	29 c2                	sub    %eax,%edx
  80154a:	89 d0                	mov    %edx,%eax
}
  80154c:	5d                   	pop    %ebp
  80154d:	c3                   	ret    

0080154e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801551:	eb 09                	jmp    80155c <strncmp+0xe>
		n--, p++, q++;
  801553:	ff 4d 10             	decl   0x10(%ebp)
  801556:	ff 45 08             	incl   0x8(%ebp)
  801559:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80155c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801560:	74 17                	je     801579 <strncmp+0x2b>
  801562:	8b 45 08             	mov    0x8(%ebp),%eax
  801565:	8a 00                	mov    (%eax),%al
  801567:	84 c0                	test   %al,%al
  801569:	74 0e                	je     801579 <strncmp+0x2b>
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	8a 10                	mov    (%eax),%dl
  801570:	8b 45 0c             	mov    0xc(%ebp),%eax
  801573:	8a 00                	mov    (%eax),%al
  801575:	38 c2                	cmp    %al,%dl
  801577:	74 da                	je     801553 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801579:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80157d:	75 07                	jne    801586 <strncmp+0x38>
		return 0;
  80157f:	b8 00 00 00 00       	mov    $0x0,%eax
  801584:	eb 14                	jmp    80159a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801586:	8b 45 08             	mov    0x8(%ebp),%eax
  801589:	8a 00                	mov    (%eax),%al
  80158b:	0f b6 d0             	movzbl %al,%edx
  80158e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801591:	8a 00                	mov    (%eax),%al
  801593:	0f b6 c0             	movzbl %al,%eax
  801596:	29 c2                	sub    %eax,%edx
  801598:	89 d0                	mov    %edx,%eax
}
  80159a:	5d                   	pop    %ebp
  80159b:	c3                   	ret    

0080159c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80159c:	55                   	push   %ebp
  80159d:	89 e5                	mov    %esp,%ebp
  80159f:	83 ec 04             	sub    $0x4,%esp
  8015a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015a8:	eb 12                	jmp    8015bc <strchr+0x20>
		if (*s == c)
  8015aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ad:	8a 00                	mov    (%eax),%al
  8015af:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015b2:	75 05                	jne    8015b9 <strchr+0x1d>
			return (char *) s;
  8015b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b7:	eb 11                	jmp    8015ca <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015b9:	ff 45 08             	incl   0x8(%ebp)
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	8a 00                	mov    (%eax),%al
  8015c1:	84 c0                	test   %al,%al
  8015c3:	75 e5                	jne    8015aa <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
  8015cf:	83 ec 04             	sub    $0x4,%esp
  8015d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015d8:	eb 0d                	jmp    8015e7 <strfind+0x1b>
		if (*s == c)
  8015da:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dd:	8a 00                	mov    (%eax),%al
  8015df:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015e2:	74 0e                	je     8015f2 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015e4:	ff 45 08             	incl   0x8(%ebp)
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	8a 00                	mov    (%eax),%al
  8015ec:	84 c0                	test   %al,%al
  8015ee:	75 ea                	jne    8015da <strfind+0xe>
  8015f0:	eb 01                	jmp    8015f3 <strfind+0x27>
		if (*s == c)
			break;
  8015f2:	90                   	nop
	return (char *) s;
  8015f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015f6:	c9                   	leave  
  8015f7:	c3                   	ret    

008015f8 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8015f8:	55                   	push   %ebp
  8015f9:	89 e5                	mov    %esp,%ebp
  8015fb:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801601:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801604:	8b 45 10             	mov    0x10(%ebp),%eax
  801607:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80160a:	eb 0e                	jmp    80161a <memset+0x22>
		*p++ = c;
  80160c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80160f:	8d 50 01             	lea    0x1(%eax),%edx
  801612:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801615:	8b 55 0c             	mov    0xc(%ebp),%edx
  801618:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80161a:	ff 4d f8             	decl   -0x8(%ebp)
  80161d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801621:	79 e9                	jns    80160c <memset+0x14>
		*p++ = c;

	return v;
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
  80162b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80162e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801631:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801634:	8b 45 08             	mov    0x8(%ebp),%eax
  801637:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80163a:	eb 16                	jmp    801652 <memcpy+0x2a>
		*d++ = *s++;
  80163c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80163f:	8d 50 01             	lea    0x1(%eax),%edx
  801642:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801645:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801648:	8d 4a 01             	lea    0x1(%edx),%ecx
  80164b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80164e:	8a 12                	mov    (%edx),%dl
  801650:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801652:	8b 45 10             	mov    0x10(%ebp),%eax
  801655:	8d 50 ff             	lea    -0x1(%eax),%edx
  801658:	89 55 10             	mov    %edx,0x10(%ebp)
  80165b:	85 c0                	test   %eax,%eax
  80165d:	75 dd                	jne    80163c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801662:	c9                   	leave  
  801663:	c3                   	ret    

00801664 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801664:	55                   	push   %ebp
  801665:	89 e5                	mov    %esp,%ebp
  801667:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80166a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80166d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801676:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801679:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80167c:	73 50                	jae    8016ce <memmove+0x6a>
  80167e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801681:	8b 45 10             	mov    0x10(%ebp),%eax
  801684:	01 d0                	add    %edx,%eax
  801686:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801689:	76 43                	jbe    8016ce <memmove+0x6a>
		s += n;
  80168b:	8b 45 10             	mov    0x10(%ebp),%eax
  80168e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801691:	8b 45 10             	mov    0x10(%ebp),%eax
  801694:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801697:	eb 10                	jmp    8016a9 <memmove+0x45>
			*--d = *--s;
  801699:	ff 4d f8             	decl   -0x8(%ebp)
  80169c:	ff 4d fc             	decl   -0x4(%ebp)
  80169f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a2:	8a 10                	mov    (%eax),%dl
  8016a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a7:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ac:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016af:	89 55 10             	mov    %edx,0x10(%ebp)
  8016b2:	85 c0                	test   %eax,%eax
  8016b4:	75 e3                	jne    801699 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016b6:	eb 23                	jmp    8016db <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016bb:	8d 50 01             	lea    0x1(%eax),%edx
  8016be:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016c4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016c7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016ca:	8a 12                	mov    (%edx),%dl
  8016cc:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8016d7:	85 c0                	test   %eax,%eax
  8016d9:	75 dd                	jne    8016b8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016de:	c9                   	leave  
  8016df:	c3                   	ret    

008016e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016e0:	55                   	push   %ebp
  8016e1:	89 e5                	mov    %esp,%ebp
  8016e3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ef:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016f2:	eb 2a                	jmp    80171e <memcmp+0x3e>
		if (*s1 != *s2)
  8016f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016f7:	8a 10                	mov    (%eax),%dl
  8016f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016fc:	8a 00                	mov    (%eax),%al
  8016fe:	38 c2                	cmp    %al,%dl
  801700:	74 16                	je     801718 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801702:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801705:	8a 00                	mov    (%eax),%al
  801707:	0f b6 d0             	movzbl %al,%edx
  80170a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80170d:	8a 00                	mov    (%eax),%al
  80170f:	0f b6 c0             	movzbl %al,%eax
  801712:	29 c2                	sub    %eax,%edx
  801714:	89 d0                	mov    %edx,%eax
  801716:	eb 18                	jmp    801730 <memcmp+0x50>
		s1++, s2++;
  801718:	ff 45 fc             	incl   -0x4(%ebp)
  80171b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80171e:	8b 45 10             	mov    0x10(%ebp),%eax
  801721:	8d 50 ff             	lea    -0x1(%eax),%edx
  801724:	89 55 10             	mov    %edx,0x10(%ebp)
  801727:	85 c0                	test   %eax,%eax
  801729:	75 c9                	jne    8016f4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80172b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801730:	c9                   	leave  
  801731:	c3                   	ret    

00801732 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801732:	55                   	push   %ebp
  801733:	89 e5                	mov    %esp,%ebp
  801735:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801738:	8b 55 08             	mov    0x8(%ebp),%edx
  80173b:	8b 45 10             	mov    0x10(%ebp),%eax
  80173e:	01 d0                	add    %edx,%eax
  801740:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801743:	eb 15                	jmp    80175a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801745:	8b 45 08             	mov    0x8(%ebp),%eax
  801748:	8a 00                	mov    (%eax),%al
  80174a:	0f b6 d0             	movzbl %al,%edx
  80174d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801750:	0f b6 c0             	movzbl %al,%eax
  801753:	39 c2                	cmp    %eax,%edx
  801755:	74 0d                	je     801764 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801757:	ff 45 08             	incl   0x8(%ebp)
  80175a:	8b 45 08             	mov    0x8(%ebp),%eax
  80175d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801760:	72 e3                	jb     801745 <memfind+0x13>
  801762:	eb 01                	jmp    801765 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801764:	90                   	nop
	return (void *) s;
  801765:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801770:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801777:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80177e:	eb 03                	jmp    801783 <strtol+0x19>
		s++;
  801780:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801783:	8b 45 08             	mov    0x8(%ebp),%eax
  801786:	8a 00                	mov    (%eax),%al
  801788:	3c 20                	cmp    $0x20,%al
  80178a:	74 f4                	je     801780 <strtol+0x16>
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	8a 00                	mov    (%eax),%al
  801791:	3c 09                	cmp    $0x9,%al
  801793:	74 eb                	je     801780 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801795:	8b 45 08             	mov    0x8(%ebp),%eax
  801798:	8a 00                	mov    (%eax),%al
  80179a:	3c 2b                	cmp    $0x2b,%al
  80179c:	75 05                	jne    8017a3 <strtol+0x39>
		s++;
  80179e:	ff 45 08             	incl   0x8(%ebp)
  8017a1:	eb 13                	jmp    8017b6 <strtol+0x4c>
	else if (*s == '-')
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	8a 00                	mov    (%eax),%al
  8017a8:	3c 2d                	cmp    $0x2d,%al
  8017aa:	75 0a                	jne    8017b6 <strtol+0x4c>
		s++, neg = 1;
  8017ac:	ff 45 08             	incl   0x8(%ebp)
  8017af:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017b6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017ba:	74 06                	je     8017c2 <strtol+0x58>
  8017bc:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017c0:	75 20                	jne    8017e2 <strtol+0x78>
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	8a 00                	mov    (%eax),%al
  8017c7:	3c 30                	cmp    $0x30,%al
  8017c9:	75 17                	jne    8017e2 <strtol+0x78>
  8017cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ce:	40                   	inc    %eax
  8017cf:	8a 00                	mov    (%eax),%al
  8017d1:	3c 78                	cmp    $0x78,%al
  8017d3:	75 0d                	jne    8017e2 <strtol+0x78>
		s += 2, base = 16;
  8017d5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017d9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017e0:	eb 28                	jmp    80180a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017e6:	75 15                	jne    8017fd <strtol+0x93>
  8017e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017eb:	8a 00                	mov    (%eax),%al
  8017ed:	3c 30                	cmp    $0x30,%al
  8017ef:	75 0c                	jne    8017fd <strtol+0x93>
		s++, base = 8;
  8017f1:	ff 45 08             	incl   0x8(%ebp)
  8017f4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017fb:	eb 0d                	jmp    80180a <strtol+0xa0>
	else if (base == 0)
  8017fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801801:	75 07                	jne    80180a <strtol+0xa0>
		base = 10;
  801803:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80180a:	8b 45 08             	mov    0x8(%ebp),%eax
  80180d:	8a 00                	mov    (%eax),%al
  80180f:	3c 2f                	cmp    $0x2f,%al
  801811:	7e 19                	jle    80182c <strtol+0xc2>
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	8a 00                	mov    (%eax),%al
  801818:	3c 39                	cmp    $0x39,%al
  80181a:	7f 10                	jg     80182c <strtol+0xc2>
			dig = *s - '0';
  80181c:	8b 45 08             	mov    0x8(%ebp),%eax
  80181f:	8a 00                	mov    (%eax),%al
  801821:	0f be c0             	movsbl %al,%eax
  801824:	83 e8 30             	sub    $0x30,%eax
  801827:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80182a:	eb 42                	jmp    80186e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
  80182f:	8a 00                	mov    (%eax),%al
  801831:	3c 60                	cmp    $0x60,%al
  801833:	7e 19                	jle    80184e <strtol+0xe4>
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	8a 00                	mov    (%eax),%al
  80183a:	3c 7a                	cmp    $0x7a,%al
  80183c:	7f 10                	jg     80184e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	8a 00                	mov    (%eax),%al
  801843:	0f be c0             	movsbl %al,%eax
  801846:	83 e8 57             	sub    $0x57,%eax
  801849:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80184c:	eb 20                	jmp    80186e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80184e:	8b 45 08             	mov    0x8(%ebp),%eax
  801851:	8a 00                	mov    (%eax),%al
  801853:	3c 40                	cmp    $0x40,%al
  801855:	7e 39                	jle    801890 <strtol+0x126>
  801857:	8b 45 08             	mov    0x8(%ebp),%eax
  80185a:	8a 00                	mov    (%eax),%al
  80185c:	3c 5a                	cmp    $0x5a,%al
  80185e:	7f 30                	jg     801890 <strtol+0x126>
			dig = *s - 'A' + 10;
  801860:	8b 45 08             	mov    0x8(%ebp),%eax
  801863:	8a 00                	mov    (%eax),%al
  801865:	0f be c0             	movsbl %al,%eax
  801868:	83 e8 37             	sub    $0x37,%eax
  80186b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80186e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801871:	3b 45 10             	cmp    0x10(%ebp),%eax
  801874:	7d 19                	jge    80188f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801876:	ff 45 08             	incl   0x8(%ebp)
  801879:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187c:	0f af 45 10          	imul   0x10(%ebp),%eax
  801880:	89 c2                	mov    %eax,%edx
  801882:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801885:	01 d0                	add    %edx,%eax
  801887:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80188a:	e9 7b ff ff ff       	jmp    80180a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80188f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801890:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801894:	74 08                	je     80189e <strtol+0x134>
		*endptr = (char *) s;
  801896:	8b 45 0c             	mov    0xc(%ebp),%eax
  801899:	8b 55 08             	mov    0x8(%ebp),%edx
  80189c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80189e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018a2:	74 07                	je     8018ab <strtol+0x141>
  8018a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018a7:	f7 d8                	neg    %eax
  8018a9:	eb 03                	jmp    8018ae <strtol+0x144>
  8018ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <ltostr>:

void
ltostr(long value, char *str)
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
  8018b3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018bd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018c4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018c8:	79 13                	jns    8018dd <ltostr+0x2d>
	{
		neg = 1;
  8018ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018d7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018da:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018e5:	99                   	cltd   
  8018e6:	f7 f9                	idiv   %ecx
  8018e8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ee:	8d 50 01             	lea    0x1(%eax),%edx
  8018f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018f4:	89 c2                	mov    %eax,%edx
  8018f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f9:	01 d0                	add    %edx,%eax
  8018fb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018fe:	83 c2 30             	add    $0x30,%edx
  801901:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801903:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801906:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80190b:	f7 e9                	imul   %ecx
  80190d:	c1 fa 02             	sar    $0x2,%edx
  801910:	89 c8                	mov    %ecx,%eax
  801912:	c1 f8 1f             	sar    $0x1f,%eax
  801915:	29 c2                	sub    %eax,%edx
  801917:	89 d0                	mov    %edx,%eax
  801919:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80191c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80191f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801924:	f7 e9                	imul   %ecx
  801926:	c1 fa 02             	sar    $0x2,%edx
  801929:	89 c8                	mov    %ecx,%eax
  80192b:	c1 f8 1f             	sar    $0x1f,%eax
  80192e:	29 c2                	sub    %eax,%edx
  801930:	89 d0                	mov    %edx,%eax
  801932:	c1 e0 02             	shl    $0x2,%eax
  801935:	01 d0                	add    %edx,%eax
  801937:	01 c0                	add    %eax,%eax
  801939:	29 c1                	sub    %eax,%ecx
  80193b:	89 ca                	mov    %ecx,%edx
  80193d:	85 d2                	test   %edx,%edx
  80193f:	75 9c                	jne    8018dd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801941:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801948:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80194b:	48                   	dec    %eax
  80194c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80194f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801953:	74 3d                	je     801992 <ltostr+0xe2>
		start = 1 ;
  801955:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80195c:	eb 34                	jmp    801992 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80195e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801961:	8b 45 0c             	mov    0xc(%ebp),%eax
  801964:	01 d0                	add    %edx,%eax
  801966:	8a 00                	mov    (%eax),%al
  801968:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80196b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80196e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801971:	01 c2                	add    %eax,%edx
  801973:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801976:	8b 45 0c             	mov    0xc(%ebp),%eax
  801979:	01 c8                	add    %ecx,%eax
  80197b:	8a 00                	mov    (%eax),%al
  80197d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80197f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801982:	8b 45 0c             	mov    0xc(%ebp),%eax
  801985:	01 c2                	add    %eax,%edx
  801987:	8a 45 eb             	mov    -0x15(%ebp),%al
  80198a:	88 02                	mov    %al,(%edx)
		start++ ;
  80198c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80198f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801992:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801995:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801998:	7c c4                	jl     80195e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80199a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80199d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a0:	01 d0                	add    %edx,%eax
  8019a2:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019a5:	90                   	nop
  8019a6:	c9                   	leave  
  8019a7:	c3                   	ret    

008019a8 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019a8:	55                   	push   %ebp
  8019a9:	89 e5                	mov    %esp,%ebp
  8019ab:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019ae:	ff 75 08             	pushl  0x8(%ebp)
  8019b1:	e8 54 fa ff ff       	call   80140a <strlen>
  8019b6:	83 c4 04             	add    $0x4,%esp
  8019b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019bc:	ff 75 0c             	pushl  0xc(%ebp)
  8019bf:	e8 46 fa ff ff       	call   80140a <strlen>
  8019c4:	83 c4 04             	add    $0x4,%esp
  8019c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019d8:	eb 17                	jmp    8019f1 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019da:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e0:	01 c2                	add    %eax,%edx
  8019e2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	01 c8                	add    %ecx,%eax
  8019ea:	8a 00                	mov    (%eax),%al
  8019ec:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019ee:	ff 45 fc             	incl   -0x4(%ebp)
  8019f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019f4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019f7:	7c e1                	jl     8019da <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019f9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a00:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a07:	eb 1f                	jmp    801a28 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a0c:	8d 50 01             	lea    0x1(%eax),%edx
  801a0f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a12:	89 c2                	mov    %eax,%edx
  801a14:	8b 45 10             	mov    0x10(%ebp),%eax
  801a17:	01 c2                	add    %eax,%edx
  801a19:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a1f:	01 c8                	add    %ecx,%eax
  801a21:	8a 00                	mov    (%eax),%al
  801a23:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a25:	ff 45 f8             	incl   -0x8(%ebp)
  801a28:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a2b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a2e:	7c d9                	jl     801a09 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a30:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a33:	8b 45 10             	mov    0x10(%ebp),%eax
  801a36:	01 d0                	add    %edx,%eax
  801a38:	c6 00 00             	movb   $0x0,(%eax)
}
  801a3b:	90                   	nop
  801a3c:	c9                   	leave  
  801a3d:	c3                   	ret    

00801a3e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a3e:	55                   	push   %ebp
  801a3f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a41:	8b 45 14             	mov    0x14(%ebp),%eax
  801a44:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a4a:	8b 45 14             	mov    0x14(%ebp),%eax
  801a4d:	8b 00                	mov    (%eax),%eax
  801a4f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a56:	8b 45 10             	mov    0x10(%ebp),%eax
  801a59:	01 d0                	add    %edx,%eax
  801a5b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a61:	eb 0c                	jmp    801a6f <strsplit+0x31>
			*string++ = 0;
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	8d 50 01             	lea    0x1(%eax),%edx
  801a69:	89 55 08             	mov    %edx,0x8(%ebp)
  801a6c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a72:	8a 00                	mov    (%eax),%al
  801a74:	84 c0                	test   %al,%al
  801a76:	74 18                	je     801a90 <strsplit+0x52>
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	8a 00                	mov    (%eax),%al
  801a7d:	0f be c0             	movsbl %al,%eax
  801a80:	50                   	push   %eax
  801a81:	ff 75 0c             	pushl  0xc(%ebp)
  801a84:	e8 13 fb ff ff       	call   80159c <strchr>
  801a89:	83 c4 08             	add    $0x8,%esp
  801a8c:	85 c0                	test   %eax,%eax
  801a8e:	75 d3                	jne    801a63 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a90:	8b 45 08             	mov    0x8(%ebp),%eax
  801a93:	8a 00                	mov    (%eax),%al
  801a95:	84 c0                	test   %al,%al
  801a97:	74 5a                	je     801af3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a99:	8b 45 14             	mov    0x14(%ebp),%eax
  801a9c:	8b 00                	mov    (%eax),%eax
  801a9e:	83 f8 0f             	cmp    $0xf,%eax
  801aa1:	75 07                	jne    801aaa <strsplit+0x6c>
		{
			return 0;
  801aa3:	b8 00 00 00 00       	mov    $0x0,%eax
  801aa8:	eb 66                	jmp    801b10 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801aaa:	8b 45 14             	mov    0x14(%ebp),%eax
  801aad:	8b 00                	mov    (%eax),%eax
  801aaf:	8d 48 01             	lea    0x1(%eax),%ecx
  801ab2:	8b 55 14             	mov    0x14(%ebp),%edx
  801ab5:	89 0a                	mov    %ecx,(%edx)
  801ab7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801abe:	8b 45 10             	mov    0x10(%ebp),%eax
  801ac1:	01 c2                	add    %eax,%edx
  801ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ac8:	eb 03                	jmp    801acd <strsplit+0x8f>
			string++;
  801aca:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801acd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad0:	8a 00                	mov    (%eax),%al
  801ad2:	84 c0                	test   %al,%al
  801ad4:	74 8b                	je     801a61 <strsplit+0x23>
  801ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad9:	8a 00                	mov    (%eax),%al
  801adb:	0f be c0             	movsbl %al,%eax
  801ade:	50                   	push   %eax
  801adf:	ff 75 0c             	pushl  0xc(%ebp)
  801ae2:	e8 b5 fa ff ff       	call   80159c <strchr>
  801ae7:	83 c4 08             	add    $0x8,%esp
  801aea:	85 c0                	test   %eax,%eax
  801aec:	74 dc                	je     801aca <strsplit+0x8c>
			string++;
	}
  801aee:	e9 6e ff ff ff       	jmp    801a61 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801af3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801af4:	8b 45 14             	mov    0x14(%ebp),%eax
  801af7:	8b 00                	mov    (%eax),%eax
  801af9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b00:	8b 45 10             	mov    0x10(%ebp),%eax
  801b03:	01 d0                	add    %edx,%eax
  801b05:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b0b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b10:	c9                   	leave  
  801b11:	c3                   	ret    

00801b12 <malloc>:
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size) {
  801b12:	55                   	push   %ebp
  801b13:	89 e5                	mov    %esp,%ebp
  801b15:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801b18:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1b:	c1 e8 0c             	shr    $0xc,%eax
  801b1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	//sizeofarray++;
	if (size % PAGE_SIZE != 0)
  801b21:	8b 45 08             	mov    0x8(%ebp),%eax
  801b24:	25 ff 0f 00 00       	and    $0xfff,%eax
  801b29:	85 c0                	test   %eax,%eax
  801b2b:	74 03                	je     801b30 <malloc+0x1e>
		num++;
  801b2d:	ff 45 f4             	incl   -0xc(%ebp)
//		addresses[sizeofarray] = last_addres;
//		changed[sizeofarray] = 1;
//		sizeofarray++;
//		return (void*) return_addres;
	//} else {
	if (changes == 0) {
  801b30:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b35:	85 c0                	test   %eax,%eax
  801b37:	75 71                	jne    801baa <malloc+0x98>
		sys_allocateMem(last_addres, size);
  801b39:	a1 04 30 80 00       	mov    0x803004,%eax
  801b3e:	83 ec 08             	sub    $0x8,%esp
  801b41:	ff 75 08             	pushl  0x8(%ebp)
  801b44:	50                   	push   %eax
  801b45:	e8 e4 04 00 00       	call   80202e <sys_allocateMem>
  801b4a:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801b4d:	a1 04 30 80 00       	mov    0x803004,%eax
  801b52:	89 45 d8             	mov    %eax,-0x28(%ebp)
		last_addres += num * PAGE_SIZE;
  801b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b58:	c1 e0 0c             	shl    $0xc,%eax
  801b5b:	89 c2                	mov    %eax,%edx
  801b5d:	a1 04 30 80 00       	mov    0x803004,%eax
  801b62:	01 d0                	add    %edx,%eax
  801b64:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  801b69:	a1 30 30 80 00       	mov    0x803030,%eax
  801b6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b71:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801b78:	a1 30 30 80 00       	mov    0x803030,%eax
  801b7d:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801b80:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  801b87:	a1 30 30 80 00       	mov    0x803030,%eax
  801b8c:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801b93:	01 00 00 00 
		sizeofarray++;
  801b97:	a1 30 30 80 00       	mov    0x803030,%eax
  801b9c:	40                   	inc    %eax
  801b9d:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) return_addres;
  801ba2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801ba5:	e9 f7 00 00 00       	jmp    801ca1 <malloc+0x18f>
	} else {
		int count = 0;
  801baa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 1000;
  801bb1:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
		int index = -1;
  801bb8:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  801bbf:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801bc6:	eb 7c                	jmp    801c44 <malloc+0x132>
		{
			uint32 *pg = NULL;
  801bc8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
			for (int j = 0; j < sizeofarray; j++) {
  801bcf:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801bd6:	eb 1a                	jmp    801bf2 <malloc+0xe0>
				if (addresses[j] == i) {
  801bd8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801bdb:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801be2:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801be5:	75 08                	jne    801bef <malloc+0xdd>
					index = j;
  801be7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801bea:	89 45 e8             	mov    %eax,-0x18(%ebp)
					break;
  801bed:	eb 0d                	jmp    801bfc <malloc+0xea>
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
		{
			uint32 *pg = NULL;
			for (int j = 0; j < sizeofarray; j++) {
  801bef:	ff 45 dc             	incl   -0x24(%ebp)
  801bf2:	a1 30 30 80 00       	mov    0x803030,%eax
  801bf7:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801bfa:	7c dc                	jl     801bd8 <malloc+0xc6>
					index = j;
					break;
				}
			}

			if (index == -1) {
  801bfc:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801c00:	75 05                	jne    801c07 <malloc+0xf5>
				count++;
  801c02:	ff 45 f0             	incl   -0x10(%ebp)
  801c05:	eb 36                	jmp    801c3d <malloc+0x12b>
			} else {
				if (changed[index] == 0) {
  801c07:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c0a:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c11:	85 c0                	test   %eax,%eax
  801c13:	75 05                	jne    801c1a <malloc+0x108>
					count++;
  801c15:	ff 45 f0             	incl   -0x10(%ebp)
  801c18:	eb 23                	jmp    801c3d <malloc+0x12b>
				} else {
					if (count < min && count >= num) {
  801c1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c1d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801c20:	7d 14                	jge    801c36 <malloc+0x124>
  801c22:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c25:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c28:	7c 0c                	jl     801c36 <malloc+0x124>
						min = count;
  801c2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c2d:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss = i;
  801c30:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c33:	89 45 e4             	mov    %eax,-0x1c(%ebp)
					}
					count = 0;
  801c36:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	} else {
		int count = 0;
		int min = 1000;
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  801c3d:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801c44:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801c4b:	0f 86 77 ff ff ff    	jbe    801bc8 <malloc+0xb6>

			}

		}

		sys_allocateMem(min_addresss, size);
  801c51:	83 ec 08             	sub    $0x8,%esp
  801c54:	ff 75 08             	pushl  0x8(%ebp)
  801c57:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c5a:	e8 cf 03 00 00       	call   80202e <sys_allocateMem>
  801c5f:	83 c4 10             	add    $0x10,%esp
		numOfPages[sizeofarray] = num;
  801c62:	a1 30 30 80 00       	mov    0x803030,%eax
  801c67:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c6a:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = last_addres;
  801c71:	a1 30 30 80 00       	mov    0x803030,%eax
  801c76:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801c7c:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  801c83:	a1 30 30 80 00       	mov    0x803030,%eax
  801c88:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801c8f:	01 00 00 00 
		sizeofarray++;
  801c93:	a1 30 30 80 00       	mov    0x803030,%eax
  801c98:	40                   	inc    %eax
  801c99:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) min_addresss;
  801c9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801ca1:	c9                   	leave  
  801ca2:	c3                   	ret    

00801ca3 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801ca3:	55                   	push   %ebp
  801ca4:	89 e5                	mov    %esp,%ebp
  801ca6:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cac:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801caf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801cb6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801cbd:	eb 30                	jmp    801cef <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801cbf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801cc2:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801cc9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801ccc:	75 1e                	jne    801cec <free+0x49>
  801cce:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801cd1:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801cd8:	83 f8 01             	cmp    $0x1,%eax
  801cdb:	75 0f                	jne    801cec <free+0x49>
			is_found = 1;
  801cdd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801ce4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ce7:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801cea:	eb 0d                	jmp    801cf9 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801cec:	ff 45 ec             	incl   -0x14(%ebp)
  801cef:	a1 30 30 80 00       	mov    0x803030,%eax
  801cf4:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801cf7:	7c c6                	jl     801cbf <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801cf9:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801cfd:	75 4f                	jne    801d4e <free+0xab>
		size = numOfPages[index] * PAGE_SIZE;
  801cff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d02:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801d09:	c1 e0 0c             	shl    $0xc,%eax
  801d0c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801d0f:	83 ec 08             	sub    $0x8,%esp
  801d12:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d15:	68 84 2e 80 00       	push   $0x802e84
  801d1a:	e8 63 ee ff ff       	call   800b82 <cprintf>
  801d1f:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801d22:	83 ec 08             	sub    $0x8,%esp
  801d25:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d28:	ff 75 e8             	pushl  -0x18(%ebp)
  801d2b:	e8 e2 02 00 00       	call   802012 <sys_freeMem>
  801d30:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801d33:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d36:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801d3d:	00 00 00 00 
		changes++;
  801d41:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801d46:	40                   	inc    %eax
  801d47:	a3 2c 30 80 00       	mov    %eax,0x80302c
		sys_freeMem(va, size);
		changed[index] = 0;
	}

	//refer to the project presentation and documentation for details
}
  801d4c:	eb 39                	jmp    801d87 <free+0xe4>
		cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	} else {
		size = 513 * PAGE_SIZE;
  801d4e:	c7 45 e4 00 10 20 00 	movl   $0x201000,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801d55:	83 ec 08             	sub    $0x8,%esp
  801d58:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d5b:	68 84 2e 80 00       	push   $0x802e84
  801d60:	e8 1d ee ff ff       	call   800b82 <cprintf>
  801d65:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801d68:	83 ec 08             	sub    $0x8,%esp
  801d6b:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d6e:	ff 75 e8             	pushl  -0x18(%ebp)
  801d71:	e8 9c 02 00 00       	call   802012 <sys_freeMem>
  801d76:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801d79:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d7c:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801d83:	00 00 00 00 
	}

	//refer to the project presentation and documentation for details
}
  801d87:	90                   	nop
  801d88:	c9                   	leave  
  801d89:	c3                   	ret    

00801d8a <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801d8a:	55                   	push   %ebp
  801d8b:	89 e5                	mov    %esp,%ebp
  801d8d:	83 ec 18             	sub    $0x18,%esp
  801d90:	8b 45 10             	mov    0x10(%ebp),%eax
  801d93:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801d96:	83 ec 04             	sub    $0x4,%esp
  801d99:	68 a4 2e 80 00       	push   $0x802ea4
  801d9e:	68 9d 00 00 00       	push   $0x9d
  801da3:	68 c7 2e 80 00       	push   $0x802ec7
  801da8:	e8 33 eb ff ff       	call   8008e0 <_panic>

00801dad <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801dad:	55                   	push   %ebp
  801dae:	89 e5                	mov    %esp,%ebp
  801db0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801db3:	83 ec 04             	sub    $0x4,%esp
  801db6:	68 a4 2e 80 00       	push   $0x802ea4
  801dbb:	68 a2 00 00 00       	push   $0xa2
  801dc0:	68 c7 2e 80 00       	push   $0x802ec7
  801dc5:	e8 16 eb ff ff       	call   8008e0 <_panic>

00801dca <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801dca:	55                   	push   %ebp
  801dcb:	89 e5                	mov    %esp,%ebp
  801dcd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dd0:	83 ec 04             	sub    $0x4,%esp
  801dd3:	68 a4 2e 80 00       	push   $0x802ea4
  801dd8:	68 a7 00 00 00       	push   $0xa7
  801ddd:	68 c7 2e 80 00       	push   $0x802ec7
  801de2:	e8 f9 ea ff ff       	call   8008e0 <_panic>

00801de7 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801de7:	55                   	push   %ebp
  801de8:	89 e5                	mov    %esp,%ebp
  801dea:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ded:	83 ec 04             	sub    $0x4,%esp
  801df0:	68 a4 2e 80 00       	push   $0x802ea4
  801df5:	68 ab 00 00 00       	push   $0xab
  801dfa:	68 c7 2e 80 00       	push   $0x802ec7
  801dff:	e8 dc ea ff ff       	call   8008e0 <_panic>

00801e04 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801e04:	55                   	push   %ebp
  801e05:	89 e5                	mov    %esp,%ebp
  801e07:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e0a:	83 ec 04             	sub    $0x4,%esp
  801e0d:	68 a4 2e 80 00       	push   $0x802ea4
  801e12:	68 b0 00 00 00       	push   $0xb0
  801e17:	68 c7 2e 80 00       	push   $0x802ec7
  801e1c:	e8 bf ea ff ff       	call   8008e0 <_panic>

00801e21 <shrink>:
}
void shrink(uint32 newSize) {
  801e21:	55                   	push   %ebp
  801e22:	89 e5                	mov    %esp,%ebp
  801e24:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e27:	83 ec 04             	sub    $0x4,%esp
  801e2a:	68 a4 2e 80 00       	push   $0x802ea4
  801e2f:	68 b3 00 00 00       	push   $0xb3
  801e34:	68 c7 2e 80 00       	push   $0x802ec7
  801e39:	e8 a2 ea ff ff       	call   8008e0 <_panic>

00801e3e <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801e3e:	55                   	push   %ebp
  801e3f:	89 e5                	mov    %esp,%ebp
  801e41:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e44:	83 ec 04             	sub    $0x4,%esp
  801e47:	68 a4 2e 80 00       	push   $0x802ea4
  801e4c:	68 b7 00 00 00       	push   $0xb7
  801e51:	68 c7 2e 80 00       	push   $0x802ec7
  801e56:	e8 85 ea ff ff       	call   8008e0 <_panic>

00801e5b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e5b:	55                   	push   %ebp
  801e5c:	89 e5                	mov    %esp,%ebp
  801e5e:	57                   	push   %edi
  801e5f:	56                   	push   %esi
  801e60:	53                   	push   %ebx
  801e61:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e64:	8b 45 08             	mov    0x8(%ebp),%eax
  801e67:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e6a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e6d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e70:	8b 7d 18             	mov    0x18(%ebp),%edi
  801e73:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801e76:	cd 30                	int    $0x30
  801e78:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801e7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e7e:	83 c4 10             	add    $0x10,%esp
  801e81:	5b                   	pop    %ebx
  801e82:	5e                   	pop    %esi
  801e83:	5f                   	pop    %edi
  801e84:	5d                   	pop    %ebp
  801e85:	c3                   	ret    

00801e86 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801e86:	55                   	push   %ebp
  801e87:	89 e5                	mov    %esp,%ebp
  801e89:	83 ec 04             	sub    $0x4,%esp
  801e8c:	8b 45 10             	mov    0x10(%ebp),%eax
  801e8f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801e92:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e96:	8b 45 08             	mov    0x8(%ebp),%eax
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	52                   	push   %edx
  801e9e:	ff 75 0c             	pushl  0xc(%ebp)
  801ea1:	50                   	push   %eax
  801ea2:	6a 00                	push   $0x0
  801ea4:	e8 b2 ff ff ff       	call   801e5b <syscall>
  801ea9:	83 c4 18             	add    $0x18,%esp
}
  801eac:	90                   	nop
  801ead:	c9                   	leave  
  801eae:	c3                   	ret    

00801eaf <sys_cgetc>:

int
sys_cgetc(void)
{
  801eaf:	55                   	push   %ebp
  801eb0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801eb2:	6a 00                	push   $0x0
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 01                	push   $0x1
  801ebe:	e8 98 ff ff ff       	call   801e5b <syscall>
  801ec3:	83 c4 18             	add    $0x18,%esp
}
  801ec6:	c9                   	leave  
  801ec7:	c3                   	ret    

00801ec8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ec8:	55                   	push   %ebp
  801ec9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ece:	6a 00                	push   $0x0
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 00                	push   $0x0
  801ed6:	50                   	push   %eax
  801ed7:	6a 05                	push   $0x5
  801ed9:	e8 7d ff ff ff       	call   801e5b <syscall>
  801ede:	83 c4 18             	add    $0x18,%esp
}
  801ee1:	c9                   	leave  
  801ee2:	c3                   	ret    

00801ee3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ee3:	55                   	push   %ebp
  801ee4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 02                	push   $0x2
  801ef2:	e8 64 ff ff ff       	call   801e5b <syscall>
  801ef7:	83 c4 18             	add    $0x18,%esp
}
  801efa:	c9                   	leave  
  801efb:	c3                   	ret    

00801efc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801efc:	55                   	push   %ebp
  801efd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	6a 00                	push   $0x0
  801f05:	6a 00                	push   $0x0
  801f07:	6a 00                	push   $0x0
  801f09:	6a 03                	push   $0x3
  801f0b:	e8 4b ff ff ff       	call   801e5b <syscall>
  801f10:	83 c4 18             	add    $0x18,%esp
}
  801f13:	c9                   	leave  
  801f14:	c3                   	ret    

00801f15 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f15:	55                   	push   %ebp
  801f16:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	6a 04                	push   $0x4
  801f24:	e8 32 ff ff ff       	call   801e5b <syscall>
  801f29:	83 c4 18             	add    $0x18,%esp
}
  801f2c:	c9                   	leave  
  801f2d:	c3                   	ret    

00801f2e <sys_env_exit>:


void sys_env_exit(void)
{
  801f2e:	55                   	push   %ebp
  801f2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 06                	push   $0x6
  801f3d:	e8 19 ff ff ff       	call   801e5b <syscall>
  801f42:	83 c4 18             	add    $0x18,%esp
}
  801f45:	90                   	nop
  801f46:	c9                   	leave  
  801f47:	c3                   	ret    

00801f48 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801f48:	55                   	push   %ebp
  801f49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801f4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	52                   	push   %edx
  801f58:	50                   	push   %eax
  801f59:	6a 07                	push   $0x7
  801f5b:	e8 fb fe ff ff       	call   801e5b <syscall>
  801f60:	83 c4 18             	add    $0x18,%esp
}
  801f63:	c9                   	leave  
  801f64:	c3                   	ret    

00801f65 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f65:	55                   	push   %ebp
  801f66:	89 e5                	mov    %esp,%ebp
  801f68:	56                   	push   %esi
  801f69:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801f6a:	8b 75 18             	mov    0x18(%ebp),%esi
  801f6d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f70:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f76:	8b 45 08             	mov    0x8(%ebp),%eax
  801f79:	56                   	push   %esi
  801f7a:	53                   	push   %ebx
  801f7b:	51                   	push   %ecx
  801f7c:	52                   	push   %edx
  801f7d:	50                   	push   %eax
  801f7e:	6a 08                	push   $0x8
  801f80:	e8 d6 fe ff ff       	call   801e5b <syscall>
  801f85:	83 c4 18             	add    $0x18,%esp
}
  801f88:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f8b:	5b                   	pop    %ebx
  801f8c:	5e                   	pop    %esi
  801f8d:	5d                   	pop    %ebp
  801f8e:	c3                   	ret    

00801f8f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801f8f:	55                   	push   %ebp
  801f90:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801f92:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f95:	8b 45 08             	mov    0x8(%ebp),%eax
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	52                   	push   %edx
  801f9f:	50                   	push   %eax
  801fa0:	6a 09                	push   $0x9
  801fa2:	e8 b4 fe ff ff       	call   801e5b <syscall>
  801fa7:	83 c4 18             	add    $0x18,%esp
}
  801faa:	c9                   	leave  
  801fab:	c3                   	ret    

00801fac <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801fac:	55                   	push   %ebp
  801fad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801faf:	6a 00                	push   $0x0
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	ff 75 0c             	pushl  0xc(%ebp)
  801fb8:	ff 75 08             	pushl  0x8(%ebp)
  801fbb:	6a 0a                	push   $0xa
  801fbd:	e8 99 fe ff ff       	call   801e5b <syscall>
  801fc2:	83 c4 18             	add    $0x18,%esp
}
  801fc5:	c9                   	leave  
  801fc6:	c3                   	ret    

00801fc7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801fc7:	55                   	push   %ebp
  801fc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 0b                	push   $0xb
  801fd6:	e8 80 fe ff ff       	call   801e5b <syscall>
  801fdb:	83 c4 18             	add    $0x18,%esp
}
  801fde:	c9                   	leave  
  801fdf:	c3                   	ret    

00801fe0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801fe0:	55                   	push   %ebp
  801fe1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 00                	push   $0x0
  801fed:	6a 0c                	push   $0xc
  801fef:	e8 67 fe ff ff       	call   801e5b <syscall>
  801ff4:	83 c4 18             	add    $0x18,%esp
}
  801ff7:	c9                   	leave  
  801ff8:	c3                   	ret    

00801ff9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ff9:	55                   	push   %ebp
  801ffa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 0d                	push   $0xd
  802008:	e8 4e fe ff ff       	call   801e5b <syscall>
  80200d:	83 c4 18             	add    $0x18,%esp
}
  802010:	c9                   	leave  
  802011:	c3                   	ret    

00802012 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802012:	55                   	push   %ebp
  802013:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	ff 75 0c             	pushl  0xc(%ebp)
  80201e:	ff 75 08             	pushl  0x8(%ebp)
  802021:	6a 11                	push   $0x11
  802023:	e8 33 fe ff ff       	call   801e5b <syscall>
  802028:	83 c4 18             	add    $0x18,%esp
	return;
  80202b:	90                   	nop
}
  80202c:	c9                   	leave  
  80202d:	c3                   	ret    

0080202e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80202e:	55                   	push   %ebp
  80202f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	6a 00                	push   $0x0
  802037:	ff 75 0c             	pushl  0xc(%ebp)
  80203a:	ff 75 08             	pushl  0x8(%ebp)
  80203d:	6a 12                	push   $0x12
  80203f:	e8 17 fe ff ff       	call   801e5b <syscall>
  802044:	83 c4 18             	add    $0x18,%esp
	return ;
  802047:	90                   	nop
}
  802048:	c9                   	leave  
  802049:	c3                   	ret    

0080204a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80204a:	55                   	push   %ebp
  80204b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	6a 00                	push   $0x0
  802055:	6a 00                	push   $0x0
  802057:	6a 0e                	push   $0xe
  802059:	e8 fd fd ff ff       	call   801e5b <syscall>
  80205e:	83 c4 18             	add    $0x18,%esp
}
  802061:	c9                   	leave  
  802062:	c3                   	ret    

00802063 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802063:	55                   	push   %ebp
  802064:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	ff 75 08             	pushl  0x8(%ebp)
  802071:	6a 0f                	push   $0xf
  802073:	e8 e3 fd ff ff       	call   801e5b <syscall>
  802078:	83 c4 18             	add    $0x18,%esp
}
  80207b:	c9                   	leave  
  80207c:	c3                   	ret    

0080207d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80207d:	55                   	push   %ebp
  80207e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 10                	push   $0x10
  80208c:	e8 ca fd ff ff       	call   801e5b <syscall>
  802091:	83 c4 18             	add    $0x18,%esp
}
  802094:	90                   	nop
  802095:	c9                   	leave  
  802096:	c3                   	ret    

00802097 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802097:	55                   	push   %ebp
  802098:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 14                	push   $0x14
  8020a6:	e8 b0 fd ff ff       	call   801e5b <syscall>
  8020ab:	83 c4 18             	add    $0x18,%esp
}
  8020ae:	90                   	nop
  8020af:	c9                   	leave  
  8020b0:	c3                   	ret    

008020b1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8020b1:	55                   	push   %ebp
  8020b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 15                	push   $0x15
  8020c0:	e8 96 fd ff ff       	call   801e5b <syscall>
  8020c5:	83 c4 18             	add    $0x18,%esp
}
  8020c8:	90                   	nop
  8020c9:	c9                   	leave  
  8020ca:	c3                   	ret    

008020cb <sys_cputc>:


void
sys_cputc(const char c)
{
  8020cb:	55                   	push   %ebp
  8020cc:	89 e5                	mov    %esp,%ebp
  8020ce:	83 ec 04             	sub    $0x4,%esp
  8020d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8020d7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	50                   	push   %eax
  8020e4:	6a 16                	push   $0x16
  8020e6:	e8 70 fd ff ff       	call   801e5b <syscall>
  8020eb:	83 c4 18             	add    $0x18,%esp
}
  8020ee:	90                   	nop
  8020ef:	c9                   	leave  
  8020f0:	c3                   	ret    

008020f1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8020f1:	55                   	push   %ebp
  8020f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 00                	push   $0x0
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 17                	push   $0x17
  802100:	e8 56 fd ff ff       	call   801e5b <syscall>
  802105:	83 c4 18             	add    $0x18,%esp
}
  802108:	90                   	nop
  802109:	c9                   	leave  
  80210a:	c3                   	ret    

0080210b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80210b:	55                   	push   %ebp
  80210c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80210e:	8b 45 08             	mov    0x8(%ebp),%eax
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	ff 75 0c             	pushl  0xc(%ebp)
  80211a:	50                   	push   %eax
  80211b:	6a 18                	push   $0x18
  80211d:	e8 39 fd ff ff       	call   801e5b <syscall>
  802122:	83 c4 18             	add    $0x18,%esp
}
  802125:	c9                   	leave  
  802126:	c3                   	ret    

00802127 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802127:	55                   	push   %ebp
  802128:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80212a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80212d:	8b 45 08             	mov    0x8(%ebp),%eax
  802130:	6a 00                	push   $0x0
  802132:	6a 00                	push   $0x0
  802134:	6a 00                	push   $0x0
  802136:	52                   	push   %edx
  802137:	50                   	push   %eax
  802138:	6a 1b                	push   $0x1b
  80213a:	e8 1c fd ff ff       	call   801e5b <syscall>
  80213f:	83 c4 18             	add    $0x18,%esp
}
  802142:	c9                   	leave  
  802143:	c3                   	ret    

00802144 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802144:	55                   	push   %ebp
  802145:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802147:	8b 55 0c             	mov    0xc(%ebp),%edx
  80214a:	8b 45 08             	mov    0x8(%ebp),%eax
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	52                   	push   %edx
  802154:	50                   	push   %eax
  802155:	6a 19                	push   $0x19
  802157:	e8 ff fc ff ff       	call   801e5b <syscall>
  80215c:	83 c4 18             	add    $0x18,%esp
}
  80215f:	90                   	nop
  802160:	c9                   	leave  
  802161:	c3                   	ret    

00802162 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802162:	55                   	push   %ebp
  802163:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802165:	8b 55 0c             	mov    0xc(%ebp),%edx
  802168:	8b 45 08             	mov    0x8(%ebp),%eax
  80216b:	6a 00                	push   $0x0
  80216d:	6a 00                	push   $0x0
  80216f:	6a 00                	push   $0x0
  802171:	52                   	push   %edx
  802172:	50                   	push   %eax
  802173:	6a 1a                	push   $0x1a
  802175:	e8 e1 fc ff ff       	call   801e5b <syscall>
  80217a:	83 c4 18             	add    $0x18,%esp
}
  80217d:	90                   	nop
  80217e:	c9                   	leave  
  80217f:	c3                   	ret    

00802180 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802180:	55                   	push   %ebp
  802181:	89 e5                	mov    %esp,%ebp
  802183:	83 ec 04             	sub    $0x4,%esp
  802186:	8b 45 10             	mov    0x10(%ebp),%eax
  802189:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80218c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80218f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802193:	8b 45 08             	mov    0x8(%ebp),%eax
  802196:	6a 00                	push   $0x0
  802198:	51                   	push   %ecx
  802199:	52                   	push   %edx
  80219a:	ff 75 0c             	pushl  0xc(%ebp)
  80219d:	50                   	push   %eax
  80219e:	6a 1c                	push   $0x1c
  8021a0:	e8 b6 fc ff ff       	call   801e5b <syscall>
  8021a5:	83 c4 18             	add    $0x18,%esp
}
  8021a8:	c9                   	leave  
  8021a9:	c3                   	ret    

008021aa <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8021aa:	55                   	push   %ebp
  8021ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8021ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 00                	push   $0x0
  8021b7:	6a 00                	push   $0x0
  8021b9:	52                   	push   %edx
  8021ba:	50                   	push   %eax
  8021bb:	6a 1d                	push   $0x1d
  8021bd:	e8 99 fc ff ff       	call   801e5b <syscall>
  8021c2:	83 c4 18             	add    $0x18,%esp
}
  8021c5:	c9                   	leave  
  8021c6:	c3                   	ret    

008021c7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8021c7:	55                   	push   %ebp
  8021c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8021ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d3:	6a 00                	push   $0x0
  8021d5:	6a 00                	push   $0x0
  8021d7:	51                   	push   %ecx
  8021d8:	52                   	push   %edx
  8021d9:	50                   	push   %eax
  8021da:	6a 1e                	push   $0x1e
  8021dc:	e8 7a fc ff ff       	call   801e5b <syscall>
  8021e1:	83 c4 18             	add    $0x18,%esp
}
  8021e4:	c9                   	leave  
  8021e5:	c3                   	ret    

008021e6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8021e6:	55                   	push   %ebp
  8021e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8021e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ef:	6a 00                	push   $0x0
  8021f1:	6a 00                	push   $0x0
  8021f3:	6a 00                	push   $0x0
  8021f5:	52                   	push   %edx
  8021f6:	50                   	push   %eax
  8021f7:	6a 1f                	push   $0x1f
  8021f9:	e8 5d fc ff ff       	call   801e5b <syscall>
  8021fe:	83 c4 18             	add    $0x18,%esp
}
  802201:	c9                   	leave  
  802202:	c3                   	ret    

00802203 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802203:	55                   	push   %ebp
  802204:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802206:	6a 00                	push   $0x0
  802208:	6a 00                	push   $0x0
  80220a:	6a 00                	push   $0x0
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	6a 20                	push   $0x20
  802212:	e8 44 fc ff ff       	call   801e5b <syscall>
  802217:	83 c4 18             	add    $0x18,%esp
}
  80221a:	c9                   	leave  
  80221b:	c3                   	ret    

0080221c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80221c:	55                   	push   %ebp
  80221d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80221f:	8b 45 08             	mov    0x8(%ebp),%eax
  802222:	6a 00                	push   $0x0
  802224:	ff 75 14             	pushl  0x14(%ebp)
  802227:	ff 75 10             	pushl  0x10(%ebp)
  80222a:	ff 75 0c             	pushl  0xc(%ebp)
  80222d:	50                   	push   %eax
  80222e:	6a 21                	push   $0x21
  802230:	e8 26 fc ff ff       	call   801e5b <syscall>
  802235:	83 c4 18             	add    $0x18,%esp
}
  802238:	c9                   	leave  
  802239:	c3                   	ret    

0080223a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80223a:	55                   	push   %ebp
  80223b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80223d:	8b 45 08             	mov    0x8(%ebp),%eax
  802240:	6a 00                	push   $0x0
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	50                   	push   %eax
  802249:	6a 22                	push   $0x22
  80224b:	e8 0b fc ff ff       	call   801e5b <syscall>
  802250:	83 c4 18             	add    $0x18,%esp
}
  802253:	90                   	nop
  802254:	c9                   	leave  
  802255:	c3                   	ret    

00802256 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802256:	55                   	push   %ebp
  802257:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802259:	8b 45 08             	mov    0x8(%ebp),%eax
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	6a 00                	push   $0x0
  802262:	6a 00                	push   $0x0
  802264:	50                   	push   %eax
  802265:	6a 23                	push   $0x23
  802267:	e8 ef fb ff ff       	call   801e5b <syscall>
  80226c:	83 c4 18             	add    $0x18,%esp
}
  80226f:	90                   	nop
  802270:	c9                   	leave  
  802271:	c3                   	ret    

00802272 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802272:	55                   	push   %ebp
  802273:	89 e5                	mov    %esp,%ebp
  802275:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802278:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80227b:	8d 50 04             	lea    0x4(%eax),%edx
  80227e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	6a 00                	push   $0x0
  802287:	52                   	push   %edx
  802288:	50                   	push   %eax
  802289:	6a 24                	push   $0x24
  80228b:	e8 cb fb ff ff       	call   801e5b <syscall>
  802290:	83 c4 18             	add    $0x18,%esp
	return result;
  802293:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802296:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802299:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80229c:	89 01                	mov    %eax,(%ecx)
  80229e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8022a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a4:	c9                   	leave  
  8022a5:	c2 04 00             	ret    $0x4

008022a8 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8022a8:	55                   	push   %ebp
  8022a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8022ab:	6a 00                	push   $0x0
  8022ad:	6a 00                	push   $0x0
  8022af:	ff 75 10             	pushl  0x10(%ebp)
  8022b2:	ff 75 0c             	pushl  0xc(%ebp)
  8022b5:	ff 75 08             	pushl  0x8(%ebp)
  8022b8:	6a 13                	push   $0x13
  8022ba:	e8 9c fb ff ff       	call   801e5b <syscall>
  8022bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8022c2:	90                   	nop
}
  8022c3:	c9                   	leave  
  8022c4:	c3                   	ret    

008022c5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8022c5:	55                   	push   %ebp
  8022c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 00                	push   $0x0
  8022cc:	6a 00                	push   $0x0
  8022ce:	6a 00                	push   $0x0
  8022d0:	6a 00                	push   $0x0
  8022d2:	6a 25                	push   $0x25
  8022d4:	e8 82 fb ff ff       	call   801e5b <syscall>
  8022d9:	83 c4 18             	add    $0x18,%esp
}
  8022dc:	c9                   	leave  
  8022dd:	c3                   	ret    

008022de <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8022de:	55                   	push   %ebp
  8022df:	89 e5                	mov    %esp,%ebp
  8022e1:	83 ec 04             	sub    $0x4,%esp
  8022e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8022ea:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8022ee:	6a 00                	push   $0x0
  8022f0:	6a 00                	push   $0x0
  8022f2:	6a 00                	push   $0x0
  8022f4:	6a 00                	push   $0x0
  8022f6:	50                   	push   %eax
  8022f7:	6a 26                	push   $0x26
  8022f9:	e8 5d fb ff ff       	call   801e5b <syscall>
  8022fe:	83 c4 18             	add    $0x18,%esp
	return ;
  802301:	90                   	nop
}
  802302:	c9                   	leave  
  802303:	c3                   	ret    

00802304 <rsttst>:
void rsttst()
{
  802304:	55                   	push   %ebp
  802305:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802307:	6a 00                	push   $0x0
  802309:	6a 00                	push   $0x0
  80230b:	6a 00                	push   $0x0
  80230d:	6a 00                	push   $0x0
  80230f:	6a 00                	push   $0x0
  802311:	6a 28                	push   $0x28
  802313:	e8 43 fb ff ff       	call   801e5b <syscall>
  802318:	83 c4 18             	add    $0x18,%esp
	return ;
  80231b:	90                   	nop
}
  80231c:	c9                   	leave  
  80231d:	c3                   	ret    

0080231e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80231e:	55                   	push   %ebp
  80231f:	89 e5                	mov    %esp,%ebp
  802321:	83 ec 04             	sub    $0x4,%esp
  802324:	8b 45 14             	mov    0x14(%ebp),%eax
  802327:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80232a:	8b 55 18             	mov    0x18(%ebp),%edx
  80232d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802331:	52                   	push   %edx
  802332:	50                   	push   %eax
  802333:	ff 75 10             	pushl  0x10(%ebp)
  802336:	ff 75 0c             	pushl  0xc(%ebp)
  802339:	ff 75 08             	pushl  0x8(%ebp)
  80233c:	6a 27                	push   $0x27
  80233e:	e8 18 fb ff ff       	call   801e5b <syscall>
  802343:	83 c4 18             	add    $0x18,%esp
	return ;
  802346:	90                   	nop
}
  802347:	c9                   	leave  
  802348:	c3                   	ret    

00802349 <chktst>:
void chktst(uint32 n)
{
  802349:	55                   	push   %ebp
  80234a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80234c:	6a 00                	push   $0x0
  80234e:	6a 00                	push   $0x0
  802350:	6a 00                	push   $0x0
  802352:	6a 00                	push   $0x0
  802354:	ff 75 08             	pushl  0x8(%ebp)
  802357:	6a 29                	push   $0x29
  802359:	e8 fd fa ff ff       	call   801e5b <syscall>
  80235e:	83 c4 18             	add    $0x18,%esp
	return ;
  802361:	90                   	nop
}
  802362:	c9                   	leave  
  802363:	c3                   	ret    

00802364 <inctst>:

void inctst()
{
  802364:	55                   	push   %ebp
  802365:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802367:	6a 00                	push   $0x0
  802369:	6a 00                	push   $0x0
  80236b:	6a 00                	push   $0x0
  80236d:	6a 00                	push   $0x0
  80236f:	6a 00                	push   $0x0
  802371:	6a 2a                	push   $0x2a
  802373:	e8 e3 fa ff ff       	call   801e5b <syscall>
  802378:	83 c4 18             	add    $0x18,%esp
	return ;
  80237b:	90                   	nop
}
  80237c:	c9                   	leave  
  80237d:	c3                   	ret    

0080237e <gettst>:
uint32 gettst()
{
  80237e:	55                   	push   %ebp
  80237f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802381:	6a 00                	push   $0x0
  802383:	6a 00                	push   $0x0
  802385:	6a 00                	push   $0x0
  802387:	6a 00                	push   $0x0
  802389:	6a 00                	push   $0x0
  80238b:	6a 2b                	push   $0x2b
  80238d:	e8 c9 fa ff ff       	call   801e5b <syscall>
  802392:	83 c4 18             	add    $0x18,%esp
}
  802395:	c9                   	leave  
  802396:	c3                   	ret    

00802397 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802397:	55                   	push   %ebp
  802398:	89 e5                	mov    %esp,%ebp
  80239a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80239d:	6a 00                	push   $0x0
  80239f:	6a 00                	push   $0x0
  8023a1:	6a 00                	push   $0x0
  8023a3:	6a 00                	push   $0x0
  8023a5:	6a 00                	push   $0x0
  8023a7:	6a 2c                	push   $0x2c
  8023a9:	e8 ad fa ff ff       	call   801e5b <syscall>
  8023ae:	83 c4 18             	add    $0x18,%esp
  8023b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8023b4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8023b8:	75 07                	jne    8023c1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8023ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8023bf:	eb 05                	jmp    8023c6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8023c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023c6:	c9                   	leave  
  8023c7:	c3                   	ret    

008023c8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8023c8:	55                   	push   %ebp
  8023c9:	89 e5                	mov    %esp,%ebp
  8023cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023ce:	6a 00                	push   $0x0
  8023d0:	6a 00                	push   $0x0
  8023d2:	6a 00                	push   $0x0
  8023d4:	6a 00                	push   $0x0
  8023d6:	6a 00                	push   $0x0
  8023d8:	6a 2c                	push   $0x2c
  8023da:	e8 7c fa ff ff       	call   801e5b <syscall>
  8023df:	83 c4 18             	add    $0x18,%esp
  8023e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8023e5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8023e9:	75 07                	jne    8023f2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8023eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8023f0:	eb 05                	jmp    8023f7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8023f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023f7:	c9                   	leave  
  8023f8:	c3                   	ret    

008023f9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8023f9:	55                   	push   %ebp
  8023fa:	89 e5                	mov    %esp,%ebp
  8023fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023ff:	6a 00                	push   $0x0
  802401:	6a 00                	push   $0x0
  802403:	6a 00                	push   $0x0
  802405:	6a 00                	push   $0x0
  802407:	6a 00                	push   $0x0
  802409:	6a 2c                	push   $0x2c
  80240b:	e8 4b fa ff ff       	call   801e5b <syscall>
  802410:	83 c4 18             	add    $0x18,%esp
  802413:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802416:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80241a:	75 07                	jne    802423 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80241c:	b8 01 00 00 00       	mov    $0x1,%eax
  802421:	eb 05                	jmp    802428 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802423:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802428:	c9                   	leave  
  802429:	c3                   	ret    

0080242a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80242a:	55                   	push   %ebp
  80242b:	89 e5                	mov    %esp,%ebp
  80242d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802430:	6a 00                	push   $0x0
  802432:	6a 00                	push   $0x0
  802434:	6a 00                	push   $0x0
  802436:	6a 00                	push   $0x0
  802438:	6a 00                	push   $0x0
  80243a:	6a 2c                	push   $0x2c
  80243c:	e8 1a fa ff ff       	call   801e5b <syscall>
  802441:	83 c4 18             	add    $0x18,%esp
  802444:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802447:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80244b:	75 07                	jne    802454 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80244d:	b8 01 00 00 00       	mov    $0x1,%eax
  802452:	eb 05                	jmp    802459 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802454:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802459:	c9                   	leave  
  80245a:	c3                   	ret    

0080245b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80245b:	55                   	push   %ebp
  80245c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80245e:	6a 00                	push   $0x0
  802460:	6a 00                	push   $0x0
  802462:	6a 00                	push   $0x0
  802464:	6a 00                	push   $0x0
  802466:	ff 75 08             	pushl  0x8(%ebp)
  802469:	6a 2d                	push   $0x2d
  80246b:	e8 eb f9 ff ff       	call   801e5b <syscall>
  802470:	83 c4 18             	add    $0x18,%esp
	return ;
  802473:	90                   	nop
}
  802474:	c9                   	leave  
  802475:	c3                   	ret    

00802476 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802476:	55                   	push   %ebp
  802477:	89 e5                	mov    %esp,%ebp
  802479:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80247a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80247d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802480:	8b 55 0c             	mov    0xc(%ebp),%edx
  802483:	8b 45 08             	mov    0x8(%ebp),%eax
  802486:	6a 00                	push   $0x0
  802488:	53                   	push   %ebx
  802489:	51                   	push   %ecx
  80248a:	52                   	push   %edx
  80248b:	50                   	push   %eax
  80248c:	6a 2e                	push   $0x2e
  80248e:	e8 c8 f9 ff ff       	call   801e5b <syscall>
  802493:	83 c4 18             	add    $0x18,%esp
}
  802496:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802499:	c9                   	leave  
  80249a:	c3                   	ret    

0080249b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80249b:	55                   	push   %ebp
  80249c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80249e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8024a4:	6a 00                	push   $0x0
  8024a6:	6a 00                	push   $0x0
  8024a8:	6a 00                	push   $0x0
  8024aa:	52                   	push   %edx
  8024ab:	50                   	push   %eax
  8024ac:	6a 2f                	push   $0x2f
  8024ae:	e8 a8 f9 ff ff       	call   801e5b <syscall>
  8024b3:	83 c4 18             	add    $0x18,%esp
}
  8024b6:	c9                   	leave  
  8024b7:	c3                   	ret    

008024b8 <__udivdi3>:
  8024b8:	55                   	push   %ebp
  8024b9:	57                   	push   %edi
  8024ba:	56                   	push   %esi
  8024bb:	53                   	push   %ebx
  8024bc:	83 ec 1c             	sub    $0x1c,%esp
  8024bf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8024c3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8024c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8024cf:	89 ca                	mov    %ecx,%edx
  8024d1:	89 f8                	mov    %edi,%eax
  8024d3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8024d7:	85 f6                	test   %esi,%esi
  8024d9:	75 2d                	jne    802508 <__udivdi3+0x50>
  8024db:	39 cf                	cmp    %ecx,%edi
  8024dd:	77 65                	ja     802544 <__udivdi3+0x8c>
  8024df:	89 fd                	mov    %edi,%ebp
  8024e1:	85 ff                	test   %edi,%edi
  8024e3:	75 0b                	jne    8024f0 <__udivdi3+0x38>
  8024e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8024ea:	31 d2                	xor    %edx,%edx
  8024ec:	f7 f7                	div    %edi
  8024ee:	89 c5                	mov    %eax,%ebp
  8024f0:	31 d2                	xor    %edx,%edx
  8024f2:	89 c8                	mov    %ecx,%eax
  8024f4:	f7 f5                	div    %ebp
  8024f6:	89 c1                	mov    %eax,%ecx
  8024f8:	89 d8                	mov    %ebx,%eax
  8024fa:	f7 f5                	div    %ebp
  8024fc:	89 cf                	mov    %ecx,%edi
  8024fe:	89 fa                	mov    %edi,%edx
  802500:	83 c4 1c             	add    $0x1c,%esp
  802503:	5b                   	pop    %ebx
  802504:	5e                   	pop    %esi
  802505:	5f                   	pop    %edi
  802506:	5d                   	pop    %ebp
  802507:	c3                   	ret    
  802508:	39 ce                	cmp    %ecx,%esi
  80250a:	77 28                	ja     802534 <__udivdi3+0x7c>
  80250c:	0f bd fe             	bsr    %esi,%edi
  80250f:	83 f7 1f             	xor    $0x1f,%edi
  802512:	75 40                	jne    802554 <__udivdi3+0x9c>
  802514:	39 ce                	cmp    %ecx,%esi
  802516:	72 0a                	jb     802522 <__udivdi3+0x6a>
  802518:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80251c:	0f 87 9e 00 00 00    	ja     8025c0 <__udivdi3+0x108>
  802522:	b8 01 00 00 00       	mov    $0x1,%eax
  802527:	89 fa                	mov    %edi,%edx
  802529:	83 c4 1c             	add    $0x1c,%esp
  80252c:	5b                   	pop    %ebx
  80252d:	5e                   	pop    %esi
  80252e:	5f                   	pop    %edi
  80252f:	5d                   	pop    %ebp
  802530:	c3                   	ret    
  802531:	8d 76 00             	lea    0x0(%esi),%esi
  802534:	31 ff                	xor    %edi,%edi
  802536:	31 c0                	xor    %eax,%eax
  802538:	89 fa                	mov    %edi,%edx
  80253a:	83 c4 1c             	add    $0x1c,%esp
  80253d:	5b                   	pop    %ebx
  80253e:	5e                   	pop    %esi
  80253f:	5f                   	pop    %edi
  802540:	5d                   	pop    %ebp
  802541:	c3                   	ret    
  802542:	66 90                	xchg   %ax,%ax
  802544:	89 d8                	mov    %ebx,%eax
  802546:	f7 f7                	div    %edi
  802548:	31 ff                	xor    %edi,%edi
  80254a:	89 fa                	mov    %edi,%edx
  80254c:	83 c4 1c             	add    $0x1c,%esp
  80254f:	5b                   	pop    %ebx
  802550:	5e                   	pop    %esi
  802551:	5f                   	pop    %edi
  802552:	5d                   	pop    %ebp
  802553:	c3                   	ret    
  802554:	bd 20 00 00 00       	mov    $0x20,%ebp
  802559:	89 eb                	mov    %ebp,%ebx
  80255b:	29 fb                	sub    %edi,%ebx
  80255d:	89 f9                	mov    %edi,%ecx
  80255f:	d3 e6                	shl    %cl,%esi
  802561:	89 c5                	mov    %eax,%ebp
  802563:	88 d9                	mov    %bl,%cl
  802565:	d3 ed                	shr    %cl,%ebp
  802567:	89 e9                	mov    %ebp,%ecx
  802569:	09 f1                	or     %esi,%ecx
  80256b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80256f:	89 f9                	mov    %edi,%ecx
  802571:	d3 e0                	shl    %cl,%eax
  802573:	89 c5                	mov    %eax,%ebp
  802575:	89 d6                	mov    %edx,%esi
  802577:	88 d9                	mov    %bl,%cl
  802579:	d3 ee                	shr    %cl,%esi
  80257b:	89 f9                	mov    %edi,%ecx
  80257d:	d3 e2                	shl    %cl,%edx
  80257f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802583:	88 d9                	mov    %bl,%cl
  802585:	d3 e8                	shr    %cl,%eax
  802587:	09 c2                	or     %eax,%edx
  802589:	89 d0                	mov    %edx,%eax
  80258b:	89 f2                	mov    %esi,%edx
  80258d:	f7 74 24 0c          	divl   0xc(%esp)
  802591:	89 d6                	mov    %edx,%esi
  802593:	89 c3                	mov    %eax,%ebx
  802595:	f7 e5                	mul    %ebp
  802597:	39 d6                	cmp    %edx,%esi
  802599:	72 19                	jb     8025b4 <__udivdi3+0xfc>
  80259b:	74 0b                	je     8025a8 <__udivdi3+0xf0>
  80259d:	89 d8                	mov    %ebx,%eax
  80259f:	31 ff                	xor    %edi,%edi
  8025a1:	e9 58 ff ff ff       	jmp    8024fe <__udivdi3+0x46>
  8025a6:	66 90                	xchg   %ax,%ax
  8025a8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8025ac:	89 f9                	mov    %edi,%ecx
  8025ae:	d3 e2                	shl    %cl,%edx
  8025b0:	39 c2                	cmp    %eax,%edx
  8025b2:	73 e9                	jae    80259d <__udivdi3+0xe5>
  8025b4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8025b7:	31 ff                	xor    %edi,%edi
  8025b9:	e9 40 ff ff ff       	jmp    8024fe <__udivdi3+0x46>
  8025be:	66 90                	xchg   %ax,%ax
  8025c0:	31 c0                	xor    %eax,%eax
  8025c2:	e9 37 ff ff ff       	jmp    8024fe <__udivdi3+0x46>
  8025c7:	90                   	nop

008025c8 <__umoddi3>:
  8025c8:	55                   	push   %ebp
  8025c9:	57                   	push   %edi
  8025ca:	56                   	push   %esi
  8025cb:	53                   	push   %ebx
  8025cc:	83 ec 1c             	sub    $0x1c,%esp
  8025cf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8025d3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8025d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025db:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8025df:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8025e3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8025e7:	89 f3                	mov    %esi,%ebx
  8025e9:	89 fa                	mov    %edi,%edx
  8025eb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025ef:	89 34 24             	mov    %esi,(%esp)
  8025f2:	85 c0                	test   %eax,%eax
  8025f4:	75 1a                	jne    802610 <__umoddi3+0x48>
  8025f6:	39 f7                	cmp    %esi,%edi
  8025f8:	0f 86 a2 00 00 00    	jbe    8026a0 <__umoddi3+0xd8>
  8025fe:	89 c8                	mov    %ecx,%eax
  802600:	89 f2                	mov    %esi,%edx
  802602:	f7 f7                	div    %edi
  802604:	89 d0                	mov    %edx,%eax
  802606:	31 d2                	xor    %edx,%edx
  802608:	83 c4 1c             	add    $0x1c,%esp
  80260b:	5b                   	pop    %ebx
  80260c:	5e                   	pop    %esi
  80260d:	5f                   	pop    %edi
  80260e:	5d                   	pop    %ebp
  80260f:	c3                   	ret    
  802610:	39 f0                	cmp    %esi,%eax
  802612:	0f 87 ac 00 00 00    	ja     8026c4 <__umoddi3+0xfc>
  802618:	0f bd e8             	bsr    %eax,%ebp
  80261b:	83 f5 1f             	xor    $0x1f,%ebp
  80261e:	0f 84 ac 00 00 00    	je     8026d0 <__umoddi3+0x108>
  802624:	bf 20 00 00 00       	mov    $0x20,%edi
  802629:	29 ef                	sub    %ebp,%edi
  80262b:	89 fe                	mov    %edi,%esi
  80262d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802631:	89 e9                	mov    %ebp,%ecx
  802633:	d3 e0                	shl    %cl,%eax
  802635:	89 d7                	mov    %edx,%edi
  802637:	89 f1                	mov    %esi,%ecx
  802639:	d3 ef                	shr    %cl,%edi
  80263b:	09 c7                	or     %eax,%edi
  80263d:	89 e9                	mov    %ebp,%ecx
  80263f:	d3 e2                	shl    %cl,%edx
  802641:	89 14 24             	mov    %edx,(%esp)
  802644:	89 d8                	mov    %ebx,%eax
  802646:	d3 e0                	shl    %cl,%eax
  802648:	89 c2                	mov    %eax,%edx
  80264a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80264e:	d3 e0                	shl    %cl,%eax
  802650:	89 44 24 04          	mov    %eax,0x4(%esp)
  802654:	8b 44 24 08          	mov    0x8(%esp),%eax
  802658:	89 f1                	mov    %esi,%ecx
  80265a:	d3 e8                	shr    %cl,%eax
  80265c:	09 d0                	or     %edx,%eax
  80265e:	d3 eb                	shr    %cl,%ebx
  802660:	89 da                	mov    %ebx,%edx
  802662:	f7 f7                	div    %edi
  802664:	89 d3                	mov    %edx,%ebx
  802666:	f7 24 24             	mull   (%esp)
  802669:	89 c6                	mov    %eax,%esi
  80266b:	89 d1                	mov    %edx,%ecx
  80266d:	39 d3                	cmp    %edx,%ebx
  80266f:	0f 82 87 00 00 00    	jb     8026fc <__umoddi3+0x134>
  802675:	0f 84 91 00 00 00    	je     80270c <__umoddi3+0x144>
  80267b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80267f:	29 f2                	sub    %esi,%edx
  802681:	19 cb                	sbb    %ecx,%ebx
  802683:	89 d8                	mov    %ebx,%eax
  802685:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802689:	d3 e0                	shl    %cl,%eax
  80268b:	89 e9                	mov    %ebp,%ecx
  80268d:	d3 ea                	shr    %cl,%edx
  80268f:	09 d0                	or     %edx,%eax
  802691:	89 e9                	mov    %ebp,%ecx
  802693:	d3 eb                	shr    %cl,%ebx
  802695:	89 da                	mov    %ebx,%edx
  802697:	83 c4 1c             	add    $0x1c,%esp
  80269a:	5b                   	pop    %ebx
  80269b:	5e                   	pop    %esi
  80269c:	5f                   	pop    %edi
  80269d:	5d                   	pop    %ebp
  80269e:	c3                   	ret    
  80269f:	90                   	nop
  8026a0:	89 fd                	mov    %edi,%ebp
  8026a2:	85 ff                	test   %edi,%edi
  8026a4:	75 0b                	jne    8026b1 <__umoddi3+0xe9>
  8026a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8026ab:	31 d2                	xor    %edx,%edx
  8026ad:	f7 f7                	div    %edi
  8026af:	89 c5                	mov    %eax,%ebp
  8026b1:	89 f0                	mov    %esi,%eax
  8026b3:	31 d2                	xor    %edx,%edx
  8026b5:	f7 f5                	div    %ebp
  8026b7:	89 c8                	mov    %ecx,%eax
  8026b9:	f7 f5                	div    %ebp
  8026bb:	89 d0                	mov    %edx,%eax
  8026bd:	e9 44 ff ff ff       	jmp    802606 <__umoddi3+0x3e>
  8026c2:	66 90                	xchg   %ax,%ax
  8026c4:	89 c8                	mov    %ecx,%eax
  8026c6:	89 f2                	mov    %esi,%edx
  8026c8:	83 c4 1c             	add    $0x1c,%esp
  8026cb:	5b                   	pop    %ebx
  8026cc:	5e                   	pop    %esi
  8026cd:	5f                   	pop    %edi
  8026ce:	5d                   	pop    %ebp
  8026cf:	c3                   	ret    
  8026d0:	3b 04 24             	cmp    (%esp),%eax
  8026d3:	72 06                	jb     8026db <__umoddi3+0x113>
  8026d5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8026d9:	77 0f                	ja     8026ea <__umoddi3+0x122>
  8026db:	89 f2                	mov    %esi,%edx
  8026dd:	29 f9                	sub    %edi,%ecx
  8026df:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8026e3:	89 14 24             	mov    %edx,(%esp)
  8026e6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8026ea:	8b 44 24 04          	mov    0x4(%esp),%eax
  8026ee:	8b 14 24             	mov    (%esp),%edx
  8026f1:	83 c4 1c             	add    $0x1c,%esp
  8026f4:	5b                   	pop    %ebx
  8026f5:	5e                   	pop    %esi
  8026f6:	5f                   	pop    %edi
  8026f7:	5d                   	pop    %ebp
  8026f8:	c3                   	ret    
  8026f9:	8d 76 00             	lea    0x0(%esi),%esi
  8026fc:	2b 04 24             	sub    (%esp),%eax
  8026ff:	19 fa                	sbb    %edi,%edx
  802701:	89 d1                	mov    %edx,%ecx
  802703:	89 c6                	mov    %eax,%esi
  802705:	e9 71 ff ff ff       	jmp    80267b <__umoddi3+0xb3>
  80270a:	66 90                	xchg   %ax,%ax
  80270c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802710:	72 ea                	jb     8026fc <__umoddi3+0x134>
  802712:	89 d9                	mov    %ebx,%ecx
  802714:	e9 62 ff ff ff       	jmp    80267b <__umoddi3+0xb3>
