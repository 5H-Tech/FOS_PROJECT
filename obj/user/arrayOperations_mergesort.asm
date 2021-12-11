
obj/user/arrayOperations_mergesort:     file format elf32-i386


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
  800031:	e8 3d 04 00 00       	call   800473 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

//int *Left;
//int *Right;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int32 parentenvID = sys_getparentenvid();
  80003e:	e8 7d 15 00 00       	call   8015c0 <sys_getparentenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int ret;
	/*[1] GET SHARED VARs*/
	//Get the shared array & its size
	int *numOfElements = NULL;
  800046:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int *sharedArray = NULL;
  80004d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	sharedArray = sget(parentenvID, "arr") ;
  800054:	83 ec 08             	sub    $0x8,%esp
  800057:	68 a0 1f 80 00       	push   $0x801fa0
  80005c:	ff 75 f0             	pushl  -0x10(%ebp)
  80005f:	e8 06 14 00 00       	call   80146a <sget>
  800064:	83 c4 10             	add    $0x10,%esp
  800067:	89 45 e8             	mov    %eax,-0x18(%ebp)
	numOfElements = sget(parentenvID, "arrSize") ;
  80006a:	83 ec 08             	sub    $0x8,%esp
  80006d:	68 a4 1f 80 00       	push   $0x801fa4
  800072:	ff 75 f0             	pushl  -0x10(%ebp)
  800075:	e8 f0 13 00 00       	call   80146a <sget>
  80007a:	83 c4 10             	add    $0x10,%esp
  80007d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	//PrintElements(sharedArray, *numOfElements);

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800080:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	finishedCount = sget(parentenvID, "finishedCount") ;
  800087:	83 ec 08             	sub    $0x8,%esp
  80008a:	68 ac 1f 80 00       	push   $0x801fac
  80008f:	ff 75 f0             	pushl  -0x10(%ebp)
  800092:	e8 d3 13 00 00       	call   80146a <sget>
  800097:	83 c4 10             	add    $0x10,%esp
  80009a:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("mergesortedArr", sizeof(int) * *numOfElements, 0) ;
  80009d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000a0:	8b 00                	mov    (%eax),%eax
  8000a2:	c1 e0 02             	shl    $0x2,%eax
  8000a5:	83 ec 04             	sub    $0x4,%esp
  8000a8:	6a 00                	push   $0x0
  8000aa:	50                   	push   %eax
  8000ab:	68 ba 1f 80 00       	push   $0x801fba
  8000b0:	e8 95 13 00 00       	call   80144a <smalloc>
  8000b5:	83 c4 10             	add    $0x10,%esp
  8000b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000c2:	eb 25                	jmp    8000e9 <_main+0xb1>
	{
		sortedArray[i] = sharedArray[i];
  8000c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000d1:	01 c2                	add    %eax,%edx
  8000d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000d6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e0:	01 c8                	add    %ecx,%eax
  8000e2:	8b 00                	mov    (%eax),%eax
  8000e4:	89 02                	mov    %eax,(%edx)
	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("mergesortedArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000e6:	ff 45 f4             	incl   -0xc(%ebp)
  8000e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f1:	7f d1                	jg     8000c4 <_main+0x8c>
	}
//	//Create two temps array for "left" & "right"
//	Left = smalloc("mergesortLeftArr", sizeof(int) * (*numOfElements), 1) ;
//	Right = smalloc("mergesortRightArr", sizeof(int) * (*numOfElements), 1) ;

	MSort(sortedArray, 1, *numOfElements);
  8000f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000f6:	8b 00                	mov    (%eax),%eax
  8000f8:	83 ec 04             	sub    $0x4,%esp
  8000fb:	50                   	push   %eax
  8000fc:	6a 01                	push   $0x1
  8000fe:	ff 75 e0             	pushl  -0x20(%ebp)
  800101:	e8 fc 00 00 00       	call   800202 <MSort>
  800106:	83 c4 10             	add    $0x10,%esp
	cprintf("Merge sort is Finished!!!!\n") ;
  800109:	83 ec 0c             	sub    $0xc,%esp
  80010c:	68 c9 1f 80 00       	push   $0x801fc9
  800111:	e8 76 05 00 00       	call   80068c <cprintf>
  800116:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	(*finishedCount)++ ;
  800119:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80011c:	8b 00                	mov    (%eax),%eax
  80011e:	8d 50 01             	lea    0x1(%eax),%edx
  800121:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800124:	89 10                	mov    %edx,(%eax)

}
  800126:	90                   	nop
  800127:	c9                   	leave  
  800128:	c3                   	ret    

00800129 <Swap>:

void Swap(int *Elements, int First, int Second)
{
  800129:	55                   	push   %ebp
  80012a:	89 e5                	mov    %esp,%ebp
  80012c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80012f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800132:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800139:	8b 45 08             	mov    0x8(%ebp),%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	8b 00                	mov    (%eax),%eax
  800140:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800143:	8b 45 0c             	mov    0xc(%ebp),%eax
  800146:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80014d:	8b 45 08             	mov    0x8(%ebp),%eax
  800150:	01 c2                	add    %eax,%edx
  800152:	8b 45 10             	mov    0x10(%ebp),%eax
  800155:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80015c:	8b 45 08             	mov    0x8(%ebp),%eax
  80015f:	01 c8                	add    %ecx,%eax
  800161:	8b 00                	mov    (%eax),%eax
  800163:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800165:	8b 45 10             	mov    0x10(%ebp),%eax
  800168:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80016f:	8b 45 08             	mov    0x8(%ebp),%eax
  800172:	01 c2                	add    %eax,%edx
  800174:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800177:	89 02                	mov    %eax,(%edx)
}
  800179:	90                   	nop
  80017a:	c9                   	leave  
  80017b:	c3                   	ret    

0080017c <PrintElements>:


void PrintElements(int *Elements, int NumOfElements)
{
  80017c:	55                   	push   %ebp
  80017d:	89 e5                	mov    %esp,%ebp
  80017f:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800182:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800189:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800190:	eb 42                	jmp    8001d4 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800192:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800195:	99                   	cltd   
  800196:	f7 7d f0             	idivl  -0x10(%ebp)
  800199:	89 d0                	mov    %edx,%eax
  80019b:	85 c0                	test   %eax,%eax
  80019d:	75 10                	jne    8001af <PrintElements+0x33>
			cprintf("\n");
  80019f:	83 ec 0c             	sub    $0xc,%esp
  8001a2:	68 e5 1f 80 00       	push   $0x801fe5
  8001a7:	e8 e0 04 00 00       	call   80068c <cprintf>
  8001ac:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8001af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8001bc:	01 d0                	add    %edx,%eax
  8001be:	8b 00                	mov    (%eax),%eax
  8001c0:	83 ec 08             	sub    $0x8,%esp
  8001c3:	50                   	push   %eax
  8001c4:	68 e7 1f 80 00       	push   $0x801fe7
  8001c9:	e8 be 04 00 00       	call   80068c <cprintf>
  8001ce:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8001d1:	ff 45 f4             	incl   -0xc(%ebp)
  8001d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d7:	48                   	dec    %eax
  8001d8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8001db:	7f b5                	jg     800192 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8001dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8001ea:	01 d0                	add    %edx,%eax
  8001ec:	8b 00                	mov    (%eax),%eax
  8001ee:	83 ec 08             	sub    $0x8,%esp
  8001f1:	50                   	push   %eax
  8001f2:	68 ec 1f 80 00       	push   $0x801fec
  8001f7:	e8 90 04 00 00       	call   80068c <cprintf>
  8001fc:	83 c4 10             	add    $0x10,%esp

}
  8001ff:	90                   	nop
  800200:	c9                   	leave  
  800201:	c3                   	ret    

00800202 <MSort>:


void MSort(int* A, int p, int r)
{
  800202:	55                   	push   %ebp
  800203:	89 e5                	mov    %esp,%ebp
  800205:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  800208:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80020e:	7d 54                	jge    800264 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  800210:	8b 55 0c             	mov    0xc(%ebp),%edx
  800213:	8b 45 10             	mov    0x10(%ebp),%eax
  800216:	01 d0                	add    %edx,%eax
  800218:	89 c2                	mov    %eax,%edx
  80021a:	c1 ea 1f             	shr    $0x1f,%edx
  80021d:	01 d0                	add    %edx,%eax
  80021f:	d1 f8                	sar    %eax
  800221:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  800224:	83 ec 04             	sub    $0x4,%esp
  800227:	ff 75 f4             	pushl  -0xc(%ebp)
  80022a:	ff 75 0c             	pushl  0xc(%ebp)
  80022d:	ff 75 08             	pushl  0x8(%ebp)
  800230:	e8 cd ff ff ff       	call   800202 <MSort>
  800235:	83 c4 10             	add    $0x10,%esp
//	cprintf("LEFT is sorted: from %d to %d\n", p, q);

	MSort(A, q + 1, r);
  800238:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80023b:	40                   	inc    %eax
  80023c:	83 ec 04             	sub    $0x4,%esp
  80023f:	ff 75 10             	pushl  0x10(%ebp)
  800242:	50                   	push   %eax
  800243:	ff 75 08             	pushl  0x8(%ebp)
  800246:	e8 b7 ff ff ff       	call   800202 <MSort>
  80024b:	83 c4 10             	add    $0x10,%esp
//	cprintf("RIGHT is sorted: from %d to %d\n", q+1, r);

	Merge(A, p, q, r);
  80024e:	ff 75 10             	pushl  0x10(%ebp)
  800251:	ff 75 f4             	pushl  -0xc(%ebp)
  800254:	ff 75 0c             	pushl  0xc(%ebp)
  800257:	ff 75 08             	pushl  0x8(%ebp)
  80025a:	e8 08 00 00 00       	call   800267 <Merge>
  80025f:	83 c4 10             	add    $0x10,%esp
  800262:	eb 01                	jmp    800265 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800264:	90                   	nop
//	cprintf("RIGHT is sorted: from %d to %d\n", q+1, r);

	Merge(A, p, q, r);
	//cprintf("[%d %d] + [%d %d] = [%d %d]\n", p, q, q+1, r, p, r);

}
  800265:	c9                   	leave  
  800266:	c3                   	ret    

00800267 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800267:	55                   	push   %ebp
  800268:	89 e5                	mov    %esp,%ebp
  80026a:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80026d:	8b 45 10             	mov    0x10(%ebp),%eax
  800270:	2b 45 0c             	sub    0xc(%ebp),%eax
  800273:	40                   	inc    %eax
  800274:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800277:	8b 45 14             	mov    0x14(%ebp),%eax
  80027a:	2b 45 10             	sub    0x10(%ebp),%eax
  80027d:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800280:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800287:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  80028e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800291:	c1 e0 02             	shl    $0x2,%eax
  800294:	83 ec 0c             	sub    $0xc,%esp
  800297:	50                   	push   %eax
  800298:	e8 79 11 00 00       	call   801416 <malloc>
  80029d:	83 c4 10             	add    $0x10,%esp
  8002a0:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  8002a3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002a6:	c1 e0 02             	shl    $0x2,%eax
  8002a9:	83 ec 0c             	sub    $0xc,%esp
  8002ac:	50                   	push   %eax
  8002ad:	e8 64 11 00 00       	call   801416 <malloc>
  8002b2:	83 c4 10             	add    $0x10,%esp
  8002b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8002b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8002bf:	eb 2f                	jmp    8002f0 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  8002c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002cb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002ce:	01 c2                	add    %eax,%edx
  8002d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8002d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002d6:	01 c8                	add    %ecx,%eax
  8002d8:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8002dd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 c8                	add    %ecx,%eax
  8002e9:	8b 00                	mov    (%eax),%eax
  8002eb:	89 02                	mov    %eax,(%edx)
	int* Left = malloc(sizeof(int) * leftCapacity);

	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8002ed:	ff 45 ec             	incl   -0x14(%ebp)
  8002f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8002f6:	7c c9                	jl     8002c1 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8002f8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002ff:	eb 2a                	jmp    80032b <Merge+0xc4>
	{
		Right[j] = A[q + j];
  800301:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800304:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80030e:	01 c2                	add    %eax,%edx
  800310:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800313:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800316:	01 c8                	add    %ecx,%eax
  800318:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80031f:	8b 45 08             	mov    0x8(%ebp),%eax
  800322:	01 c8                	add    %ecx,%eax
  800324:	8b 00                	mov    (%eax),%eax
  800326:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  800328:	ff 45 e8             	incl   -0x18(%ebp)
  80032b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80032e:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800331:	7c ce                	jl     800301 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800333:	8b 45 0c             	mov    0xc(%ebp),%eax
  800336:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800339:	e9 0a 01 00 00       	jmp    800448 <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  80033e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800341:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800344:	0f 8d 95 00 00 00    	jge    8003df <Merge+0x178>
  80034a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80034d:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800350:	0f 8d 89 00 00 00    	jge    8003df <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800356:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800359:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800360:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	8b 10                	mov    (%eax),%edx
  800367:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80036a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800371:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800374:	01 c8                	add    %ecx,%eax
  800376:	8b 00                	mov    (%eax),%eax
  800378:	39 c2                	cmp    %eax,%edx
  80037a:	7d 33                	jge    8003af <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80037c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80037f:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800384:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80038b:	8b 45 08             	mov    0x8(%ebp),%eax
  80038e:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800391:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800394:	8d 50 01             	lea    0x1(%eax),%edx
  800397:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80039a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8003aa:	e9 96 00 00 00       	jmp    800445 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  8003af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003b2:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8003b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003be:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8003c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c7:	8d 50 01             	lea    0x1(%eax),%edx
  8003ca:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8003cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003d7:	01 d0                	add    %edx,%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8003dd:	eb 66                	jmp    800445 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  8003df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003e2:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8003e5:	7d 30                	jge    800417 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  8003e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003ea:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8003ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8003fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ff:	8d 50 01             	lea    0x1(%eax),%edx
  800402:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800405:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80040f:	01 d0                	add    %edx,%eax
  800411:	8b 00                	mov    (%eax),%eax
  800413:	89 01                	mov    %eax,(%ecx)
  800415:	eb 2e                	jmp    800445 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  800417:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80041a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80041f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80042c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80042f:	8d 50 01             	lea    0x1(%eax),%edx
  800432:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800435:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80043f:	01 d0                	add    %edx,%eax
  800441:	8b 00                	mov    (%eax),%eax
  800443:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800445:	ff 45 e4             	incl   -0x1c(%ebp)
  800448:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80044b:	3b 45 14             	cmp    0x14(%ebp),%eax
  80044e:	0f 8e ea fe ff ff    	jle    80033e <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

	free(Left);
  800454:	83 ec 0c             	sub    $0xc,%esp
  800457:	ff 75 d8             	pushl  -0x28(%ebp)
  80045a:	e8 d1 0f 00 00       	call   801430 <free>
  80045f:	83 c4 10             	add    $0x10,%esp
	free(Right);
  800462:	83 ec 0c             	sub    $0xc,%esp
  800465:	ff 75 d4             	pushl  -0x2c(%ebp)
  800468:	e8 c3 0f 00 00       	call   801430 <free>
  80046d:	83 c4 10             	add    $0x10,%esp

}
  800470:	90                   	nop
  800471:	c9                   	leave  
  800472:	c3                   	ret    

00800473 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800473:	55                   	push   %ebp
  800474:	89 e5                	mov    %esp,%ebp
  800476:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800479:	e8 29 11 00 00       	call   8015a7 <sys_getenvindex>
  80047e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800481:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800484:	89 d0                	mov    %edx,%eax
  800486:	c1 e0 03             	shl    $0x3,%eax
  800489:	01 d0                	add    %edx,%eax
  80048b:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800492:	01 c8                	add    %ecx,%eax
  800494:	01 c0                	add    %eax,%eax
  800496:	01 d0                	add    %edx,%eax
  800498:	01 c0                	add    %eax,%eax
  80049a:	01 d0                	add    %edx,%eax
  80049c:	89 c2                	mov    %eax,%edx
  80049e:	c1 e2 05             	shl    $0x5,%edx
  8004a1:	29 c2                	sub    %eax,%edx
  8004a3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8004aa:	89 c2                	mov    %eax,%edx
  8004ac:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8004b2:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8004b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8004bc:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8004c2:	84 c0                	test   %al,%al
  8004c4:	74 0f                	je     8004d5 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8004c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004cb:	05 40 3c 01 00       	add    $0x13c40,%eax
  8004d0:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8004d5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8004d9:	7e 0a                	jle    8004e5 <libmain+0x72>
		binaryname = argv[0];
  8004db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004de:	8b 00                	mov    (%eax),%eax
  8004e0:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8004e5:	83 ec 08             	sub    $0x8,%esp
  8004e8:	ff 75 0c             	pushl  0xc(%ebp)
  8004eb:	ff 75 08             	pushl  0x8(%ebp)
  8004ee:	e8 45 fb ff ff       	call   800038 <_main>
  8004f3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8004f6:	e8 47 12 00 00       	call   801742 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8004fb:	83 ec 0c             	sub    $0xc,%esp
  8004fe:	68 08 20 80 00       	push   $0x802008
  800503:	e8 84 01 00 00       	call   80068c <cprintf>
  800508:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80050b:	a1 20 30 80 00       	mov    0x803020,%eax
  800510:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800516:	a1 20 30 80 00       	mov    0x803020,%eax
  80051b:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800521:	83 ec 04             	sub    $0x4,%esp
  800524:	52                   	push   %edx
  800525:	50                   	push   %eax
  800526:	68 30 20 80 00       	push   $0x802030
  80052b:	e8 5c 01 00 00       	call   80068c <cprintf>
  800530:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800533:	a1 20 30 80 00       	mov    0x803020,%eax
  800538:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80053e:	a1 20 30 80 00       	mov    0x803020,%eax
  800543:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800549:	83 ec 04             	sub    $0x4,%esp
  80054c:	52                   	push   %edx
  80054d:	50                   	push   %eax
  80054e:	68 58 20 80 00       	push   $0x802058
  800553:	e8 34 01 00 00       	call   80068c <cprintf>
  800558:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80055b:	a1 20 30 80 00       	mov    0x803020,%eax
  800560:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800566:	83 ec 08             	sub    $0x8,%esp
  800569:	50                   	push   %eax
  80056a:	68 99 20 80 00       	push   $0x802099
  80056f:	e8 18 01 00 00       	call   80068c <cprintf>
  800574:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800577:	83 ec 0c             	sub    $0xc,%esp
  80057a:	68 08 20 80 00       	push   $0x802008
  80057f:	e8 08 01 00 00       	call   80068c <cprintf>
  800584:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800587:	e8 d0 11 00 00       	call   80175c <sys_enable_interrupt>

	// exit gracefully
	exit();
  80058c:	e8 19 00 00 00       	call   8005aa <exit>
}
  800591:	90                   	nop
  800592:	c9                   	leave  
  800593:	c3                   	ret    

00800594 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800594:	55                   	push   %ebp
  800595:	89 e5                	mov    %esp,%ebp
  800597:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80059a:	83 ec 0c             	sub    $0xc,%esp
  80059d:	6a 00                	push   $0x0
  80059f:	e8 cf 0f 00 00       	call   801573 <sys_env_destroy>
  8005a4:	83 c4 10             	add    $0x10,%esp
}
  8005a7:	90                   	nop
  8005a8:	c9                   	leave  
  8005a9:	c3                   	ret    

008005aa <exit>:

void
exit(void)
{
  8005aa:	55                   	push   %ebp
  8005ab:	89 e5                	mov    %esp,%ebp
  8005ad:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8005b0:	e8 24 10 00 00       	call   8015d9 <sys_env_exit>
}
  8005b5:	90                   	nop
  8005b6:	c9                   	leave  
  8005b7:	c3                   	ret    

008005b8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005b8:	55                   	push   %ebp
  8005b9:	89 e5                	mov    %esp,%ebp
  8005bb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005c1:	8b 00                	mov    (%eax),%eax
  8005c3:	8d 48 01             	lea    0x1(%eax),%ecx
  8005c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005c9:	89 0a                	mov    %ecx,(%edx)
  8005cb:	8b 55 08             	mov    0x8(%ebp),%edx
  8005ce:	88 d1                	mov    %dl,%cl
  8005d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005d3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005da:	8b 00                	mov    (%eax),%eax
  8005dc:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005e1:	75 2c                	jne    80060f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005e3:	a0 24 30 80 00       	mov    0x803024,%al
  8005e8:	0f b6 c0             	movzbl %al,%eax
  8005eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005ee:	8b 12                	mov    (%edx),%edx
  8005f0:	89 d1                	mov    %edx,%ecx
  8005f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005f5:	83 c2 08             	add    $0x8,%edx
  8005f8:	83 ec 04             	sub    $0x4,%esp
  8005fb:	50                   	push   %eax
  8005fc:	51                   	push   %ecx
  8005fd:	52                   	push   %edx
  8005fe:	e8 2e 0f 00 00       	call   801531 <sys_cputs>
  800603:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800606:	8b 45 0c             	mov    0xc(%ebp),%eax
  800609:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80060f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800612:	8b 40 04             	mov    0x4(%eax),%eax
  800615:	8d 50 01             	lea    0x1(%eax),%edx
  800618:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80061e:	90                   	nop
  80061f:	c9                   	leave  
  800620:	c3                   	ret    

00800621 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800621:	55                   	push   %ebp
  800622:	89 e5                	mov    %esp,%ebp
  800624:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80062a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800631:	00 00 00 
	b.cnt = 0;
  800634:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80063b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80063e:	ff 75 0c             	pushl  0xc(%ebp)
  800641:	ff 75 08             	pushl  0x8(%ebp)
  800644:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80064a:	50                   	push   %eax
  80064b:	68 b8 05 80 00       	push   $0x8005b8
  800650:	e8 11 02 00 00       	call   800866 <vprintfmt>
  800655:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800658:	a0 24 30 80 00       	mov    0x803024,%al
  80065d:	0f b6 c0             	movzbl %al,%eax
  800660:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800666:	83 ec 04             	sub    $0x4,%esp
  800669:	50                   	push   %eax
  80066a:	52                   	push   %edx
  80066b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800671:	83 c0 08             	add    $0x8,%eax
  800674:	50                   	push   %eax
  800675:	e8 b7 0e 00 00       	call   801531 <sys_cputs>
  80067a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80067d:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800684:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80068a:	c9                   	leave  
  80068b:	c3                   	ret    

0080068c <cprintf>:

int cprintf(const char *fmt, ...) {
  80068c:	55                   	push   %ebp
  80068d:	89 e5                	mov    %esp,%ebp
  80068f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800692:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800699:	8d 45 0c             	lea    0xc(%ebp),%eax
  80069c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80069f:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a2:	83 ec 08             	sub    $0x8,%esp
  8006a5:	ff 75 f4             	pushl  -0xc(%ebp)
  8006a8:	50                   	push   %eax
  8006a9:	e8 73 ff ff ff       	call   800621 <vcprintf>
  8006ae:	83 c4 10             	add    $0x10,%esp
  8006b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006b7:	c9                   	leave  
  8006b8:	c3                   	ret    

008006b9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006b9:	55                   	push   %ebp
  8006ba:	89 e5                	mov    %esp,%ebp
  8006bc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006bf:	e8 7e 10 00 00       	call   801742 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006c4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	83 ec 08             	sub    $0x8,%esp
  8006d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8006d3:	50                   	push   %eax
  8006d4:	e8 48 ff ff ff       	call   800621 <vcprintf>
  8006d9:	83 c4 10             	add    $0x10,%esp
  8006dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006df:	e8 78 10 00 00       	call   80175c <sys_enable_interrupt>
	return cnt;
  8006e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006e7:	c9                   	leave  
  8006e8:	c3                   	ret    

008006e9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006e9:	55                   	push   %ebp
  8006ea:	89 e5                	mov    %esp,%ebp
  8006ec:	53                   	push   %ebx
  8006ed:	83 ec 14             	sub    $0x14,%esp
  8006f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8006f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8006fc:	8b 45 18             	mov    0x18(%ebp),%eax
  8006ff:	ba 00 00 00 00       	mov    $0x0,%edx
  800704:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800707:	77 55                	ja     80075e <printnum+0x75>
  800709:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80070c:	72 05                	jb     800713 <printnum+0x2a>
  80070e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800711:	77 4b                	ja     80075e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800713:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800716:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800719:	8b 45 18             	mov    0x18(%ebp),%eax
  80071c:	ba 00 00 00 00       	mov    $0x0,%edx
  800721:	52                   	push   %edx
  800722:	50                   	push   %eax
  800723:	ff 75 f4             	pushl  -0xc(%ebp)
  800726:	ff 75 f0             	pushl  -0x10(%ebp)
  800729:	e8 06 16 00 00       	call   801d34 <__udivdi3>
  80072e:	83 c4 10             	add    $0x10,%esp
  800731:	83 ec 04             	sub    $0x4,%esp
  800734:	ff 75 20             	pushl  0x20(%ebp)
  800737:	53                   	push   %ebx
  800738:	ff 75 18             	pushl  0x18(%ebp)
  80073b:	52                   	push   %edx
  80073c:	50                   	push   %eax
  80073d:	ff 75 0c             	pushl  0xc(%ebp)
  800740:	ff 75 08             	pushl  0x8(%ebp)
  800743:	e8 a1 ff ff ff       	call   8006e9 <printnum>
  800748:	83 c4 20             	add    $0x20,%esp
  80074b:	eb 1a                	jmp    800767 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80074d:	83 ec 08             	sub    $0x8,%esp
  800750:	ff 75 0c             	pushl  0xc(%ebp)
  800753:	ff 75 20             	pushl  0x20(%ebp)
  800756:	8b 45 08             	mov    0x8(%ebp),%eax
  800759:	ff d0                	call   *%eax
  80075b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80075e:	ff 4d 1c             	decl   0x1c(%ebp)
  800761:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800765:	7f e6                	jg     80074d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800767:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80076a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80076f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800772:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800775:	53                   	push   %ebx
  800776:	51                   	push   %ecx
  800777:	52                   	push   %edx
  800778:	50                   	push   %eax
  800779:	e8 c6 16 00 00       	call   801e44 <__umoddi3>
  80077e:	83 c4 10             	add    $0x10,%esp
  800781:	05 d4 22 80 00       	add    $0x8022d4,%eax
  800786:	8a 00                	mov    (%eax),%al
  800788:	0f be c0             	movsbl %al,%eax
  80078b:	83 ec 08             	sub    $0x8,%esp
  80078e:	ff 75 0c             	pushl  0xc(%ebp)
  800791:	50                   	push   %eax
  800792:	8b 45 08             	mov    0x8(%ebp),%eax
  800795:	ff d0                	call   *%eax
  800797:	83 c4 10             	add    $0x10,%esp
}
  80079a:	90                   	nop
  80079b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80079e:	c9                   	leave  
  80079f:	c3                   	ret    

008007a0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007a0:	55                   	push   %ebp
  8007a1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007a3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007a7:	7e 1c                	jle    8007c5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ac:	8b 00                	mov    (%eax),%eax
  8007ae:	8d 50 08             	lea    0x8(%eax),%edx
  8007b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b4:	89 10                	mov    %edx,(%eax)
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	8b 00                	mov    (%eax),%eax
  8007bb:	83 e8 08             	sub    $0x8,%eax
  8007be:	8b 50 04             	mov    0x4(%eax),%edx
  8007c1:	8b 00                	mov    (%eax),%eax
  8007c3:	eb 40                	jmp    800805 <getuint+0x65>
	else if (lflag)
  8007c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007c9:	74 1e                	je     8007e9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ce:	8b 00                	mov    (%eax),%eax
  8007d0:	8d 50 04             	lea    0x4(%eax),%edx
  8007d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d6:	89 10                	mov    %edx,(%eax)
  8007d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007db:	8b 00                	mov    (%eax),%eax
  8007dd:	83 e8 04             	sub    $0x4,%eax
  8007e0:	8b 00                	mov    (%eax),%eax
  8007e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8007e7:	eb 1c                	jmp    800805 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ec:	8b 00                	mov    (%eax),%eax
  8007ee:	8d 50 04             	lea    0x4(%eax),%edx
  8007f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f4:	89 10                	mov    %edx,(%eax)
  8007f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f9:	8b 00                	mov    (%eax),%eax
  8007fb:	83 e8 04             	sub    $0x4,%eax
  8007fe:	8b 00                	mov    (%eax),%eax
  800800:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800805:	5d                   	pop    %ebp
  800806:	c3                   	ret    

00800807 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800807:	55                   	push   %ebp
  800808:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80080a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80080e:	7e 1c                	jle    80082c <getint+0x25>
		return va_arg(*ap, long long);
  800810:	8b 45 08             	mov    0x8(%ebp),%eax
  800813:	8b 00                	mov    (%eax),%eax
  800815:	8d 50 08             	lea    0x8(%eax),%edx
  800818:	8b 45 08             	mov    0x8(%ebp),%eax
  80081b:	89 10                	mov    %edx,(%eax)
  80081d:	8b 45 08             	mov    0x8(%ebp),%eax
  800820:	8b 00                	mov    (%eax),%eax
  800822:	83 e8 08             	sub    $0x8,%eax
  800825:	8b 50 04             	mov    0x4(%eax),%edx
  800828:	8b 00                	mov    (%eax),%eax
  80082a:	eb 38                	jmp    800864 <getint+0x5d>
	else if (lflag)
  80082c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800830:	74 1a                	je     80084c <getint+0x45>
		return va_arg(*ap, long);
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	8b 00                	mov    (%eax),%eax
  800837:	8d 50 04             	lea    0x4(%eax),%edx
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	89 10                	mov    %edx,(%eax)
  80083f:	8b 45 08             	mov    0x8(%ebp),%eax
  800842:	8b 00                	mov    (%eax),%eax
  800844:	83 e8 04             	sub    $0x4,%eax
  800847:	8b 00                	mov    (%eax),%eax
  800849:	99                   	cltd   
  80084a:	eb 18                	jmp    800864 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	8b 00                	mov    (%eax),%eax
  800851:	8d 50 04             	lea    0x4(%eax),%edx
  800854:	8b 45 08             	mov    0x8(%ebp),%eax
  800857:	89 10                	mov    %edx,(%eax)
  800859:	8b 45 08             	mov    0x8(%ebp),%eax
  80085c:	8b 00                	mov    (%eax),%eax
  80085e:	83 e8 04             	sub    $0x4,%eax
  800861:	8b 00                	mov    (%eax),%eax
  800863:	99                   	cltd   
}
  800864:	5d                   	pop    %ebp
  800865:	c3                   	ret    

00800866 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800866:	55                   	push   %ebp
  800867:	89 e5                	mov    %esp,%ebp
  800869:	56                   	push   %esi
  80086a:	53                   	push   %ebx
  80086b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80086e:	eb 17                	jmp    800887 <vprintfmt+0x21>
			if (ch == '\0')
  800870:	85 db                	test   %ebx,%ebx
  800872:	0f 84 af 03 00 00    	je     800c27 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800878:	83 ec 08             	sub    $0x8,%esp
  80087b:	ff 75 0c             	pushl  0xc(%ebp)
  80087e:	53                   	push   %ebx
  80087f:	8b 45 08             	mov    0x8(%ebp),%eax
  800882:	ff d0                	call   *%eax
  800884:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800887:	8b 45 10             	mov    0x10(%ebp),%eax
  80088a:	8d 50 01             	lea    0x1(%eax),%edx
  80088d:	89 55 10             	mov    %edx,0x10(%ebp)
  800890:	8a 00                	mov    (%eax),%al
  800892:	0f b6 d8             	movzbl %al,%ebx
  800895:	83 fb 25             	cmp    $0x25,%ebx
  800898:	75 d6                	jne    800870 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80089a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80089e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008a5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008ac:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008b3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8008bd:	8d 50 01             	lea    0x1(%eax),%edx
  8008c0:	89 55 10             	mov    %edx,0x10(%ebp)
  8008c3:	8a 00                	mov    (%eax),%al
  8008c5:	0f b6 d8             	movzbl %al,%ebx
  8008c8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008cb:	83 f8 55             	cmp    $0x55,%eax
  8008ce:	0f 87 2b 03 00 00    	ja     800bff <vprintfmt+0x399>
  8008d4:	8b 04 85 f8 22 80 00 	mov    0x8022f8(,%eax,4),%eax
  8008db:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008dd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008e1:	eb d7                	jmp    8008ba <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008e3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008e7:	eb d1                	jmp    8008ba <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008e9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8008f0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008f3:	89 d0                	mov    %edx,%eax
  8008f5:	c1 e0 02             	shl    $0x2,%eax
  8008f8:	01 d0                	add    %edx,%eax
  8008fa:	01 c0                	add    %eax,%eax
  8008fc:	01 d8                	add    %ebx,%eax
  8008fe:	83 e8 30             	sub    $0x30,%eax
  800901:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800904:	8b 45 10             	mov    0x10(%ebp),%eax
  800907:	8a 00                	mov    (%eax),%al
  800909:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80090c:	83 fb 2f             	cmp    $0x2f,%ebx
  80090f:	7e 3e                	jle    80094f <vprintfmt+0xe9>
  800911:	83 fb 39             	cmp    $0x39,%ebx
  800914:	7f 39                	jg     80094f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800916:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800919:	eb d5                	jmp    8008f0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80091b:	8b 45 14             	mov    0x14(%ebp),%eax
  80091e:	83 c0 04             	add    $0x4,%eax
  800921:	89 45 14             	mov    %eax,0x14(%ebp)
  800924:	8b 45 14             	mov    0x14(%ebp),%eax
  800927:	83 e8 04             	sub    $0x4,%eax
  80092a:	8b 00                	mov    (%eax),%eax
  80092c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80092f:	eb 1f                	jmp    800950 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800931:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800935:	79 83                	jns    8008ba <vprintfmt+0x54>
				width = 0;
  800937:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80093e:	e9 77 ff ff ff       	jmp    8008ba <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800943:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80094a:	e9 6b ff ff ff       	jmp    8008ba <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80094f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800950:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800954:	0f 89 60 ff ff ff    	jns    8008ba <vprintfmt+0x54>
				width = precision, precision = -1;
  80095a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80095d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800960:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800967:	e9 4e ff ff ff       	jmp    8008ba <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80096c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80096f:	e9 46 ff ff ff       	jmp    8008ba <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800974:	8b 45 14             	mov    0x14(%ebp),%eax
  800977:	83 c0 04             	add    $0x4,%eax
  80097a:	89 45 14             	mov    %eax,0x14(%ebp)
  80097d:	8b 45 14             	mov    0x14(%ebp),%eax
  800980:	83 e8 04             	sub    $0x4,%eax
  800983:	8b 00                	mov    (%eax),%eax
  800985:	83 ec 08             	sub    $0x8,%esp
  800988:	ff 75 0c             	pushl  0xc(%ebp)
  80098b:	50                   	push   %eax
  80098c:	8b 45 08             	mov    0x8(%ebp),%eax
  80098f:	ff d0                	call   *%eax
  800991:	83 c4 10             	add    $0x10,%esp
			break;
  800994:	e9 89 02 00 00       	jmp    800c22 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800999:	8b 45 14             	mov    0x14(%ebp),%eax
  80099c:	83 c0 04             	add    $0x4,%eax
  80099f:	89 45 14             	mov    %eax,0x14(%ebp)
  8009a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a5:	83 e8 04             	sub    $0x4,%eax
  8009a8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009aa:	85 db                	test   %ebx,%ebx
  8009ac:	79 02                	jns    8009b0 <vprintfmt+0x14a>
				err = -err;
  8009ae:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009b0:	83 fb 64             	cmp    $0x64,%ebx
  8009b3:	7f 0b                	jg     8009c0 <vprintfmt+0x15a>
  8009b5:	8b 34 9d 40 21 80 00 	mov    0x802140(,%ebx,4),%esi
  8009bc:	85 f6                	test   %esi,%esi
  8009be:	75 19                	jne    8009d9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009c0:	53                   	push   %ebx
  8009c1:	68 e5 22 80 00       	push   $0x8022e5
  8009c6:	ff 75 0c             	pushl  0xc(%ebp)
  8009c9:	ff 75 08             	pushl  0x8(%ebp)
  8009cc:	e8 5e 02 00 00       	call   800c2f <printfmt>
  8009d1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009d4:	e9 49 02 00 00       	jmp    800c22 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009d9:	56                   	push   %esi
  8009da:	68 ee 22 80 00       	push   $0x8022ee
  8009df:	ff 75 0c             	pushl  0xc(%ebp)
  8009e2:	ff 75 08             	pushl  0x8(%ebp)
  8009e5:	e8 45 02 00 00       	call   800c2f <printfmt>
  8009ea:	83 c4 10             	add    $0x10,%esp
			break;
  8009ed:	e9 30 02 00 00       	jmp    800c22 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8009f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f5:	83 c0 04             	add    $0x4,%eax
  8009f8:	89 45 14             	mov    %eax,0x14(%ebp)
  8009fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fe:	83 e8 04             	sub    $0x4,%eax
  800a01:	8b 30                	mov    (%eax),%esi
  800a03:	85 f6                	test   %esi,%esi
  800a05:	75 05                	jne    800a0c <vprintfmt+0x1a6>
				p = "(null)";
  800a07:	be f1 22 80 00       	mov    $0x8022f1,%esi
			if (width > 0 && padc != '-')
  800a0c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a10:	7e 6d                	jle    800a7f <vprintfmt+0x219>
  800a12:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a16:	74 67                	je     800a7f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a18:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a1b:	83 ec 08             	sub    $0x8,%esp
  800a1e:	50                   	push   %eax
  800a1f:	56                   	push   %esi
  800a20:	e8 0c 03 00 00       	call   800d31 <strnlen>
  800a25:	83 c4 10             	add    $0x10,%esp
  800a28:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a2b:	eb 16                	jmp    800a43 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a2d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a31:	83 ec 08             	sub    $0x8,%esp
  800a34:	ff 75 0c             	pushl  0xc(%ebp)
  800a37:	50                   	push   %eax
  800a38:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3b:	ff d0                	call   *%eax
  800a3d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a40:	ff 4d e4             	decl   -0x1c(%ebp)
  800a43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a47:	7f e4                	jg     800a2d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a49:	eb 34                	jmp    800a7f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a4b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a4f:	74 1c                	je     800a6d <vprintfmt+0x207>
  800a51:	83 fb 1f             	cmp    $0x1f,%ebx
  800a54:	7e 05                	jle    800a5b <vprintfmt+0x1f5>
  800a56:	83 fb 7e             	cmp    $0x7e,%ebx
  800a59:	7e 12                	jle    800a6d <vprintfmt+0x207>
					putch('?', putdat);
  800a5b:	83 ec 08             	sub    $0x8,%esp
  800a5e:	ff 75 0c             	pushl  0xc(%ebp)
  800a61:	6a 3f                	push   $0x3f
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	ff d0                	call   *%eax
  800a68:	83 c4 10             	add    $0x10,%esp
  800a6b:	eb 0f                	jmp    800a7c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a6d:	83 ec 08             	sub    $0x8,%esp
  800a70:	ff 75 0c             	pushl  0xc(%ebp)
  800a73:	53                   	push   %ebx
  800a74:	8b 45 08             	mov    0x8(%ebp),%eax
  800a77:	ff d0                	call   *%eax
  800a79:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a7c:	ff 4d e4             	decl   -0x1c(%ebp)
  800a7f:	89 f0                	mov    %esi,%eax
  800a81:	8d 70 01             	lea    0x1(%eax),%esi
  800a84:	8a 00                	mov    (%eax),%al
  800a86:	0f be d8             	movsbl %al,%ebx
  800a89:	85 db                	test   %ebx,%ebx
  800a8b:	74 24                	je     800ab1 <vprintfmt+0x24b>
  800a8d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a91:	78 b8                	js     800a4b <vprintfmt+0x1e5>
  800a93:	ff 4d e0             	decl   -0x20(%ebp)
  800a96:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a9a:	79 af                	jns    800a4b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a9c:	eb 13                	jmp    800ab1 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a9e:	83 ec 08             	sub    $0x8,%esp
  800aa1:	ff 75 0c             	pushl  0xc(%ebp)
  800aa4:	6a 20                	push   $0x20
  800aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa9:	ff d0                	call   *%eax
  800aab:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800aae:	ff 4d e4             	decl   -0x1c(%ebp)
  800ab1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ab5:	7f e7                	jg     800a9e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ab7:	e9 66 01 00 00       	jmp    800c22 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800abc:	83 ec 08             	sub    $0x8,%esp
  800abf:	ff 75 e8             	pushl  -0x18(%ebp)
  800ac2:	8d 45 14             	lea    0x14(%ebp),%eax
  800ac5:	50                   	push   %eax
  800ac6:	e8 3c fd ff ff       	call   800807 <getint>
  800acb:	83 c4 10             	add    $0x10,%esp
  800ace:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ad4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ad7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ada:	85 d2                	test   %edx,%edx
  800adc:	79 23                	jns    800b01 <vprintfmt+0x29b>
				putch('-', putdat);
  800ade:	83 ec 08             	sub    $0x8,%esp
  800ae1:	ff 75 0c             	pushl  0xc(%ebp)
  800ae4:	6a 2d                	push   $0x2d
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	ff d0                	call   *%eax
  800aeb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800aee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800af4:	f7 d8                	neg    %eax
  800af6:	83 d2 00             	adc    $0x0,%edx
  800af9:	f7 da                	neg    %edx
  800afb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800afe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b01:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b08:	e9 bc 00 00 00       	jmp    800bc9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b0d:	83 ec 08             	sub    $0x8,%esp
  800b10:	ff 75 e8             	pushl  -0x18(%ebp)
  800b13:	8d 45 14             	lea    0x14(%ebp),%eax
  800b16:	50                   	push   %eax
  800b17:	e8 84 fc ff ff       	call   8007a0 <getuint>
  800b1c:	83 c4 10             	add    $0x10,%esp
  800b1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b25:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b2c:	e9 98 00 00 00       	jmp    800bc9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b31:	83 ec 08             	sub    $0x8,%esp
  800b34:	ff 75 0c             	pushl  0xc(%ebp)
  800b37:	6a 58                	push   $0x58
  800b39:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3c:	ff d0                	call   *%eax
  800b3e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b41:	83 ec 08             	sub    $0x8,%esp
  800b44:	ff 75 0c             	pushl  0xc(%ebp)
  800b47:	6a 58                	push   $0x58
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4c:	ff d0                	call   *%eax
  800b4e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b51:	83 ec 08             	sub    $0x8,%esp
  800b54:	ff 75 0c             	pushl  0xc(%ebp)
  800b57:	6a 58                	push   $0x58
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	ff d0                	call   *%eax
  800b5e:	83 c4 10             	add    $0x10,%esp
			break;
  800b61:	e9 bc 00 00 00       	jmp    800c22 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b66:	83 ec 08             	sub    $0x8,%esp
  800b69:	ff 75 0c             	pushl  0xc(%ebp)
  800b6c:	6a 30                	push   $0x30
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	ff d0                	call   *%eax
  800b73:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b76:	83 ec 08             	sub    $0x8,%esp
  800b79:	ff 75 0c             	pushl  0xc(%ebp)
  800b7c:	6a 78                	push   $0x78
  800b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b81:	ff d0                	call   *%eax
  800b83:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b86:	8b 45 14             	mov    0x14(%ebp),%eax
  800b89:	83 c0 04             	add    $0x4,%eax
  800b8c:	89 45 14             	mov    %eax,0x14(%ebp)
  800b8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800b92:	83 e8 04             	sub    $0x4,%eax
  800b95:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ba1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ba8:	eb 1f                	jmp    800bc9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800baa:	83 ec 08             	sub    $0x8,%esp
  800bad:	ff 75 e8             	pushl  -0x18(%ebp)
  800bb0:	8d 45 14             	lea    0x14(%ebp),%eax
  800bb3:	50                   	push   %eax
  800bb4:	e8 e7 fb ff ff       	call   8007a0 <getuint>
  800bb9:	83 c4 10             	add    $0x10,%esp
  800bbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bbf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800bc2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bc9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bcd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bd0:	83 ec 04             	sub    $0x4,%esp
  800bd3:	52                   	push   %edx
  800bd4:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bd7:	50                   	push   %eax
  800bd8:	ff 75 f4             	pushl  -0xc(%ebp)
  800bdb:	ff 75 f0             	pushl  -0x10(%ebp)
  800bde:	ff 75 0c             	pushl  0xc(%ebp)
  800be1:	ff 75 08             	pushl  0x8(%ebp)
  800be4:	e8 00 fb ff ff       	call   8006e9 <printnum>
  800be9:	83 c4 20             	add    $0x20,%esp
			break;
  800bec:	eb 34                	jmp    800c22 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800bee:	83 ec 08             	sub    $0x8,%esp
  800bf1:	ff 75 0c             	pushl  0xc(%ebp)
  800bf4:	53                   	push   %ebx
  800bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf8:	ff d0                	call   *%eax
  800bfa:	83 c4 10             	add    $0x10,%esp
			break;
  800bfd:	eb 23                	jmp    800c22 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800bff:	83 ec 08             	sub    $0x8,%esp
  800c02:	ff 75 0c             	pushl  0xc(%ebp)
  800c05:	6a 25                	push   $0x25
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	ff d0                	call   *%eax
  800c0c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c0f:	ff 4d 10             	decl   0x10(%ebp)
  800c12:	eb 03                	jmp    800c17 <vprintfmt+0x3b1>
  800c14:	ff 4d 10             	decl   0x10(%ebp)
  800c17:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1a:	48                   	dec    %eax
  800c1b:	8a 00                	mov    (%eax),%al
  800c1d:	3c 25                	cmp    $0x25,%al
  800c1f:	75 f3                	jne    800c14 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c21:	90                   	nop
		}
	}
  800c22:	e9 47 fc ff ff       	jmp    80086e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c27:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c28:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c2b:	5b                   	pop    %ebx
  800c2c:	5e                   	pop    %esi
  800c2d:	5d                   	pop    %ebp
  800c2e:	c3                   	ret    

00800c2f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c2f:	55                   	push   %ebp
  800c30:	89 e5                	mov    %esp,%ebp
  800c32:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c35:	8d 45 10             	lea    0x10(%ebp),%eax
  800c38:	83 c0 04             	add    $0x4,%eax
  800c3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c41:	ff 75 f4             	pushl  -0xc(%ebp)
  800c44:	50                   	push   %eax
  800c45:	ff 75 0c             	pushl  0xc(%ebp)
  800c48:	ff 75 08             	pushl  0x8(%ebp)
  800c4b:	e8 16 fc ff ff       	call   800866 <vprintfmt>
  800c50:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c53:	90                   	nop
  800c54:	c9                   	leave  
  800c55:	c3                   	ret    

00800c56 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c56:	55                   	push   %ebp
  800c57:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5c:	8b 40 08             	mov    0x8(%eax),%eax
  800c5f:	8d 50 01             	lea    0x1(%eax),%edx
  800c62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c65:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6b:	8b 10                	mov    (%eax),%edx
  800c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c70:	8b 40 04             	mov    0x4(%eax),%eax
  800c73:	39 c2                	cmp    %eax,%edx
  800c75:	73 12                	jae    800c89 <sprintputch+0x33>
		*b->buf++ = ch;
  800c77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7a:	8b 00                	mov    (%eax),%eax
  800c7c:	8d 48 01             	lea    0x1(%eax),%ecx
  800c7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c82:	89 0a                	mov    %ecx,(%edx)
  800c84:	8b 55 08             	mov    0x8(%ebp),%edx
  800c87:	88 10                	mov    %dl,(%eax)
}
  800c89:	90                   	nop
  800c8a:	5d                   	pop    %ebp
  800c8b:	c3                   	ret    

00800c8c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c8c:	55                   	push   %ebp
  800c8d:	89 e5                	mov    %esp,%ebp
  800c8f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c92:	8b 45 08             	mov    0x8(%ebp),%eax
  800c95:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca1:	01 d0                	add    %edx,%eax
  800ca3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800cad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800cb1:	74 06                	je     800cb9 <vsnprintf+0x2d>
  800cb3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cb7:	7f 07                	jg     800cc0 <vsnprintf+0x34>
		return -E_INVAL;
  800cb9:	b8 03 00 00 00       	mov    $0x3,%eax
  800cbe:	eb 20                	jmp    800ce0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cc0:	ff 75 14             	pushl  0x14(%ebp)
  800cc3:	ff 75 10             	pushl  0x10(%ebp)
  800cc6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cc9:	50                   	push   %eax
  800cca:	68 56 0c 80 00       	push   $0x800c56
  800ccf:	e8 92 fb ff ff       	call   800866 <vprintfmt>
  800cd4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cda:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ce0:	c9                   	leave  
  800ce1:	c3                   	ret    

00800ce2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ce2:	55                   	push   %ebp
  800ce3:	89 e5                	mov    %esp,%ebp
  800ce5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ce8:	8d 45 10             	lea    0x10(%ebp),%eax
  800ceb:	83 c0 04             	add    $0x4,%eax
  800cee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800cf1:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf4:	ff 75 f4             	pushl  -0xc(%ebp)
  800cf7:	50                   	push   %eax
  800cf8:	ff 75 0c             	pushl  0xc(%ebp)
  800cfb:	ff 75 08             	pushl  0x8(%ebp)
  800cfe:	e8 89 ff ff ff       	call   800c8c <vsnprintf>
  800d03:	83 c4 10             	add    $0x10,%esp
  800d06:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d09:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d0c:	c9                   	leave  
  800d0d:	c3                   	ret    

00800d0e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d0e:	55                   	push   %ebp
  800d0f:	89 e5                	mov    %esp,%ebp
  800d11:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d1b:	eb 06                	jmp    800d23 <strlen+0x15>
		n++;
  800d1d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d20:	ff 45 08             	incl   0x8(%ebp)
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	84 c0                	test   %al,%al
  800d2a:	75 f1                	jne    800d1d <strlen+0xf>
		n++;
	return n;
  800d2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d2f:	c9                   	leave  
  800d30:	c3                   	ret    

00800d31 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d31:	55                   	push   %ebp
  800d32:	89 e5                	mov    %esp,%ebp
  800d34:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d3e:	eb 09                	jmp    800d49 <strnlen+0x18>
		n++;
  800d40:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d43:	ff 45 08             	incl   0x8(%ebp)
  800d46:	ff 4d 0c             	decl   0xc(%ebp)
  800d49:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d4d:	74 09                	je     800d58 <strnlen+0x27>
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	84 c0                	test   %al,%al
  800d56:	75 e8                	jne    800d40 <strnlen+0xf>
		n++;
	return n;
  800d58:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d5b:	c9                   	leave  
  800d5c:	c3                   	ret    

00800d5d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d5d:	55                   	push   %ebp
  800d5e:	89 e5                	mov    %esp,%ebp
  800d60:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d69:	90                   	nop
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	8d 50 01             	lea    0x1(%eax),%edx
  800d70:	89 55 08             	mov    %edx,0x8(%ebp)
  800d73:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d76:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d79:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d7c:	8a 12                	mov    (%edx),%dl
  800d7e:	88 10                	mov    %dl,(%eax)
  800d80:	8a 00                	mov    (%eax),%al
  800d82:	84 c0                	test   %al,%al
  800d84:	75 e4                	jne    800d6a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d86:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d89:	c9                   	leave  
  800d8a:	c3                   	ret    

00800d8b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d8b:	55                   	push   %ebp
  800d8c:	89 e5                	mov    %esp,%ebp
  800d8e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d97:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d9e:	eb 1f                	jmp    800dbf <strncpy+0x34>
		*dst++ = *src;
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8d 50 01             	lea    0x1(%eax),%edx
  800da6:	89 55 08             	mov    %edx,0x8(%ebp)
  800da9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dac:	8a 12                	mov    (%edx),%dl
  800dae:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800db0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db3:	8a 00                	mov    (%eax),%al
  800db5:	84 c0                	test   %al,%al
  800db7:	74 03                	je     800dbc <strncpy+0x31>
			src++;
  800db9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800dbc:	ff 45 fc             	incl   -0x4(%ebp)
  800dbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc2:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dc5:	72 d9                	jb     800da0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800dc7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dca:	c9                   	leave  
  800dcb:	c3                   	ret    

00800dcc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800dcc:	55                   	push   %ebp
  800dcd:	89 e5                	mov    %esp,%ebp
  800dcf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dd8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ddc:	74 30                	je     800e0e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800dde:	eb 16                	jmp    800df6 <strlcpy+0x2a>
			*dst++ = *src++;
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	8d 50 01             	lea    0x1(%eax),%edx
  800de6:	89 55 08             	mov    %edx,0x8(%ebp)
  800de9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dec:	8d 4a 01             	lea    0x1(%edx),%ecx
  800def:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800df2:	8a 12                	mov    (%edx),%dl
  800df4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800df6:	ff 4d 10             	decl   0x10(%ebp)
  800df9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dfd:	74 09                	je     800e08 <strlcpy+0x3c>
  800dff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e02:	8a 00                	mov    (%eax),%al
  800e04:	84 c0                	test   %al,%al
  800e06:	75 d8                	jne    800de0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e0e:	8b 55 08             	mov    0x8(%ebp),%edx
  800e11:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e14:	29 c2                	sub    %eax,%edx
  800e16:	89 d0                	mov    %edx,%eax
}
  800e18:	c9                   	leave  
  800e19:	c3                   	ret    

00800e1a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e1a:	55                   	push   %ebp
  800e1b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e1d:	eb 06                	jmp    800e25 <strcmp+0xb>
		p++, q++;
  800e1f:	ff 45 08             	incl   0x8(%ebp)
  800e22:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	8a 00                	mov    (%eax),%al
  800e2a:	84 c0                	test   %al,%al
  800e2c:	74 0e                	je     800e3c <strcmp+0x22>
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	8a 10                	mov    (%eax),%dl
  800e33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e36:	8a 00                	mov    (%eax),%al
  800e38:	38 c2                	cmp    %al,%dl
  800e3a:	74 e3                	je     800e1f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3f:	8a 00                	mov    (%eax),%al
  800e41:	0f b6 d0             	movzbl %al,%edx
  800e44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e47:	8a 00                	mov    (%eax),%al
  800e49:	0f b6 c0             	movzbl %al,%eax
  800e4c:	29 c2                	sub    %eax,%edx
  800e4e:	89 d0                	mov    %edx,%eax
}
  800e50:	5d                   	pop    %ebp
  800e51:	c3                   	ret    

00800e52 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e52:	55                   	push   %ebp
  800e53:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e55:	eb 09                	jmp    800e60 <strncmp+0xe>
		n--, p++, q++;
  800e57:	ff 4d 10             	decl   0x10(%ebp)
  800e5a:	ff 45 08             	incl   0x8(%ebp)
  800e5d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e60:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e64:	74 17                	je     800e7d <strncmp+0x2b>
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	8a 00                	mov    (%eax),%al
  800e6b:	84 c0                	test   %al,%al
  800e6d:	74 0e                	je     800e7d <strncmp+0x2b>
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	8a 10                	mov    (%eax),%dl
  800e74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	38 c2                	cmp    %al,%dl
  800e7b:	74 da                	je     800e57 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e7d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e81:	75 07                	jne    800e8a <strncmp+0x38>
		return 0;
  800e83:	b8 00 00 00 00       	mov    $0x0,%eax
  800e88:	eb 14                	jmp    800e9e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	0f b6 d0             	movzbl %al,%edx
  800e92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e95:	8a 00                	mov    (%eax),%al
  800e97:	0f b6 c0             	movzbl %al,%eax
  800e9a:	29 c2                	sub    %eax,%edx
  800e9c:	89 d0                	mov    %edx,%eax
}
  800e9e:	5d                   	pop    %ebp
  800e9f:	c3                   	ret    

00800ea0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ea0:	55                   	push   %ebp
  800ea1:	89 e5                	mov    %esp,%ebp
  800ea3:	83 ec 04             	sub    $0x4,%esp
  800ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800eac:	eb 12                	jmp    800ec0 <strchr+0x20>
		if (*s == c)
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eb6:	75 05                	jne    800ebd <strchr+0x1d>
			return (char *) s;
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	eb 11                	jmp    800ece <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ebd:	ff 45 08             	incl   0x8(%ebp)
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	84 c0                	test   %al,%al
  800ec7:	75 e5                	jne    800eae <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ec9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ece:	c9                   	leave  
  800ecf:	c3                   	ret    

00800ed0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ed0:	55                   	push   %ebp
  800ed1:	89 e5                	mov    %esp,%ebp
  800ed3:	83 ec 04             	sub    $0x4,%esp
  800ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800edc:	eb 0d                	jmp    800eeb <strfind+0x1b>
		if (*s == c)
  800ede:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee1:	8a 00                	mov    (%eax),%al
  800ee3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ee6:	74 0e                	je     800ef6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ee8:	ff 45 08             	incl   0x8(%ebp)
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	8a 00                	mov    (%eax),%al
  800ef0:	84 c0                	test   %al,%al
  800ef2:	75 ea                	jne    800ede <strfind+0xe>
  800ef4:	eb 01                	jmp    800ef7 <strfind+0x27>
		if (*s == c)
			break;
  800ef6:	90                   	nop
	return (char *) s;
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800efa:	c9                   	leave  
  800efb:	c3                   	ret    

00800efc <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800efc:	55                   	push   %ebp
  800efd:	89 e5                	mov    %esp,%ebp
  800eff:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f08:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f0e:	eb 0e                	jmp    800f1e <memset+0x22>
		*p++ = c;
  800f10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f13:	8d 50 01             	lea    0x1(%eax),%edx
  800f16:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f1c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f1e:	ff 4d f8             	decl   -0x8(%ebp)
  800f21:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f25:	79 e9                	jns    800f10 <memset+0x14>
		*p++ = c;

	return v;
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f2a:	c9                   	leave  
  800f2b:	c3                   	ret    

00800f2c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f2c:	55                   	push   %ebp
  800f2d:	89 e5                	mov    %esp,%ebp
  800f2f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f3e:	eb 16                	jmp    800f56 <memcpy+0x2a>
		*d++ = *s++;
  800f40:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f43:	8d 50 01             	lea    0x1(%eax),%edx
  800f46:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f49:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f4c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f4f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f52:	8a 12                	mov    (%edx),%dl
  800f54:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f56:	8b 45 10             	mov    0x10(%ebp),%eax
  800f59:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f5c:	89 55 10             	mov    %edx,0x10(%ebp)
  800f5f:	85 c0                	test   %eax,%eax
  800f61:	75 dd                	jne    800f40 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f66:	c9                   	leave  
  800f67:	c3                   	ret    

00800f68 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f68:	55                   	push   %ebp
  800f69:	89 e5                	mov    %esp,%ebp
  800f6b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f71:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f7d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f80:	73 50                	jae    800fd2 <memmove+0x6a>
  800f82:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f85:	8b 45 10             	mov    0x10(%ebp),%eax
  800f88:	01 d0                	add    %edx,%eax
  800f8a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f8d:	76 43                	jbe    800fd2 <memmove+0x6a>
		s += n;
  800f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f92:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f95:	8b 45 10             	mov    0x10(%ebp),%eax
  800f98:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f9b:	eb 10                	jmp    800fad <memmove+0x45>
			*--d = *--s;
  800f9d:	ff 4d f8             	decl   -0x8(%ebp)
  800fa0:	ff 4d fc             	decl   -0x4(%ebp)
  800fa3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa6:	8a 10                	mov    (%eax),%dl
  800fa8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fab:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fad:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb3:	89 55 10             	mov    %edx,0x10(%ebp)
  800fb6:	85 c0                	test   %eax,%eax
  800fb8:	75 e3                	jne    800f9d <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fba:	eb 23                	jmp    800fdf <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fbf:	8d 50 01             	lea    0x1(%eax),%edx
  800fc2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fc5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fc8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fcb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fce:	8a 12                	mov    (%edx),%dl
  800fd0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd8:	89 55 10             	mov    %edx,0x10(%ebp)
  800fdb:	85 c0                	test   %eax,%eax
  800fdd:	75 dd                	jne    800fbc <memmove+0x54>
			*d++ = *s++;

	return dst;
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fe2:	c9                   	leave  
  800fe3:	c3                   	ret    

00800fe4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800fe4:	55                   	push   %ebp
  800fe5:	89 e5                	mov    %esp,%ebp
  800fe7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
  800fed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff3:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ff6:	eb 2a                	jmp    801022 <memcmp+0x3e>
		if (*s1 != *s2)
  800ff8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ffb:	8a 10                	mov    (%eax),%dl
  800ffd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	38 c2                	cmp    %al,%dl
  801004:	74 16                	je     80101c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801006:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801009:	8a 00                	mov    (%eax),%al
  80100b:	0f b6 d0             	movzbl %al,%edx
  80100e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801011:	8a 00                	mov    (%eax),%al
  801013:	0f b6 c0             	movzbl %al,%eax
  801016:	29 c2                	sub    %eax,%edx
  801018:	89 d0                	mov    %edx,%eax
  80101a:	eb 18                	jmp    801034 <memcmp+0x50>
		s1++, s2++;
  80101c:	ff 45 fc             	incl   -0x4(%ebp)
  80101f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801022:	8b 45 10             	mov    0x10(%ebp),%eax
  801025:	8d 50 ff             	lea    -0x1(%eax),%edx
  801028:	89 55 10             	mov    %edx,0x10(%ebp)
  80102b:	85 c0                	test   %eax,%eax
  80102d:	75 c9                	jne    800ff8 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80102f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801034:	c9                   	leave  
  801035:	c3                   	ret    

00801036 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801036:	55                   	push   %ebp
  801037:	89 e5                	mov    %esp,%ebp
  801039:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80103c:	8b 55 08             	mov    0x8(%ebp),%edx
  80103f:	8b 45 10             	mov    0x10(%ebp),%eax
  801042:	01 d0                	add    %edx,%eax
  801044:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801047:	eb 15                	jmp    80105e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	8a 00                	mov    (%eax),%al
  80104e:	0f b6 d0             	movzbl %al,%edx
  801051:	8b 45 0c             	mov    0xc(%ebp),%eax
  801054:	0f b6 c0             	movzbl %al,%eax
  801057:	39 c2                	cmp    %eax,%edx
  801059:	74 0d                	je     801068 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80105b:	ff 45 08             	incl   0x8(%ebp)
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801064:	72 e3                	jb     801049 <memfind+0x13>
  801066:	eb 01                	jmp    801069 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801068:	90                   	nop
	return (void *) s;
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80106c:	c9                   	leave  
  80106d:	c3                   	ret    

0080106e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80106e:	55                   	push   %ebp
  80106f:	89 e5                	mov    %esp,%ebp
  801071:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801074:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80107b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801082:	eb 03                	jmp    801087 <strtol+0x19>
		s++;
  801084:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	8a 00                	mov    (%eax),%al
  80108c:	3c 20                	cmp    $0x20,%al
  80108e:	74 f4                	je     801084 <strtol+0x16>
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	8a 00                	mov    (%eax),%al
  801095:	3c 09                	cmp    $0x9,%al
  801097:	74 eb                	je     801084 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	8a 00                	mov    (%eax),%al
  80109e:	3c 2b                	cmp    $0x2b,%al
  8010a0:	75 05                	jne    8010a7 <strtol+0x39>
		s++;
  8010a2:	ff 45 08             	incl   0x8(%ebp)
  8010a5:	eb 13                	jmp    8010ba <strtol+0x4c>
	else if (*s == '-')
  8010a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010aa:	8a 00                	mov    (%eax),%al
  8010ac:	3c 2d                	cmp    $0x2d,%al
  8010ae:	75 0a                	jne    8010ba <strtol+0x4c>
		s++, neg = 1;
  8010b0:	ff 45 08             	incl   0x8(%ebp)
  8010b3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010be:	74 06                	je     8010c6 <strtol+0x58>
  8010c0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010c4:	75 20                	jne    8010e6 <strtol+0x78>
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	8a 00                	mov    (%eax),%al
  8010cb:	3c 30                	cmp    $0x30,%al
  8010cd:	75 17                	jne    8010e6 <strtol+0x78>
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	40                   	inc    %eax
  8010d3:	8a 00                	mov    (%eax),%al
  8010d5:	3c 78                	cmp    $0x78,%al
  8010d7:	75 0d                	jne    8010e6 <strtol+0x78>
		s += 2, base = 16;
  8010d9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010dd:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010e4:	eb 28                	jmp    80110e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ea:	75 15                	jne    801101 <strtol+0x93>
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	8a 00                	mov    (%eax),%al
  8010f1:	3c 30                	cmp    $0x30,%al
  8010f3:	75 0c                	jne    801101 <strtol+0x93>
		s++, base = 8;
  8010f5:	ff 45 08             	incl   0x8(%ebp)
  8010f8:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8010ff:	eb 0d                	jmp    80110e <strtol+0xa0>
	else if (base == 0)
  801101:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801105:	75 07                	jne    80110e <strtol+0xa0>
		base = 10;
  801107:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80110e:	8b 45 08             	mov    0x8(%ebp),%eax
  801111:	8a 00                	mov    (%eax),%al
  801113:	3c 2f                	cmp    $0x2f,%al
  801115:	7e 19                	jle    801130 <strtol+0xc2>
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	8a 00                	mov    (%eax),%al
  80111c:	3c 39                	cmp    $0x39,%al
  80111e:	7f 10                	jg     801130 <strtol+0xc2>
			dig = *s - '0';
  801120:	8b 45 08             	mov    0x8(%ebp),%eax
  801123:	8a 00                	mov    (%eax),%al
  801125:	0f be c0             	movsbl %al,%eax
  801128:	83 e8 30             	sub    $0x30,%eax
  80112b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80112e:	eb 42                	jmp    801172 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	8a 00                	mov    (%eax),%al
  801135:	3c 60                	cmp    $0x60,%al
  801137:	7e 19                	jle    801152 <strtol+0xe4>
  801139:	8b 45 08             	mov    0x8(%ebp),%eax
  80113c:	8a 00                	mov    (%eax),%al
  80113e:	3c 7a                	cmp    $0x7a,%al
  801140:	7f 10                	jg     801152 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801142:	8b 45 08             	mov    0x8(%ebp),%eax
  801145:	8a 00                	mov    (%eax),%al
  801147:	0f be c0             	movsbl %al,%eax
  80114a:	83 e8 57             	sub    $0x57,%eax
  80114d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801150:	eb 20                	jmp    801172 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801152:	8b 45 08             	mov    0x8(%ebp),%eax
  801155:	8a 00                	mov    (%eax),%al
  801157:	3c 40                	cmp    $0x40,%al
  801159:	7e 39                	jle    801194 <strtol+0x126>
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	8a 00                	mov    (%eax),%al
  801160:	3c 5a                	cmp    $0x5a,%al
  801162:	7f 30                	jg     801194 <strtol+0x126>
			dig = *s - 'A' + 10;
  801164:	8b 45 08             	mov    0x8(%ebp),%eax
  801167:	8a 00                	mov    (%eax),%al
  801169:	0f be c0             	movsbl %al,%eax
  80116c:	83 e8 37             	sub    $0x37,%eax
  80116f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801172:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801175:	3b 45 10             	cmp    0x10(%ebp),%eax
  801178:	7d 19                	jge    801193 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80117a:	ff 45 08             	incl   0x8(%ebp)
  80117d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801180:	0f af 45 10          	imul   0x10(%ebp),%eax
  801184:	89 c2                	mov    %eax,%edx
  801186:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801189:	01 d0                	add    %edx,%eax
  80118b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80118e:	e9 7b ff ff ff       	jmp    80110e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801193:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801194:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801198:	74 08                	je     8011a2 <strtol+0x134>
		*endptr = (char *) s;
  80119a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119d:	8b 55 08             	mov    0x8(%ebp),%edx
  8011a0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011a6:	74 07                	je     8011af <strtol+0x141>
  8011a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ab:	f7 d8                	neg    %eax
  8011ad:	eb 03                	jmp    8011b2 <strtol+0x144>
  8011af:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011b2:	c9                   	leave  
  8011b3:	c3                   	ret    

008011b4 <ltostr>:

void
ltostr(long value, char *str)
{
  8011b4:	55                   	push   %ebp
  8011b5:	89 e5                	mov    %esp,%ebp
  8011b7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011c1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011c8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011cc:	79 13                	jns    8011e1 <ltostr+0x2d>
	{
		neg = 1;
  8011ce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011db:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011de:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011e9:	99                   	cltd   
  8011ea:	f7 f9                	idiv   %ecx
  8011ec:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8011ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f2:	8d 50 01             	lea    0x1(%eax),%edx
  8011f5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011f8:	89 c2                	mov    %eax,%edx
  8011fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fd:	01 d0                	add    %edx,%eax
  8011ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801202:	83 c2 30             	add    $0x30,%edx
  801205:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801207:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80120a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80120f:	f7 e9                	imul   %ecx
  801211:	c1 fa 02             	sar    $0x2,%edx
  801214:	89 c8                	mov    %ecx,%eax
  801216:	c1 f8 1f             	sar    $0x1f,%eax
  801219:	29 c2                	sub    %eax,%edx
  80121b:	89 d0                	mov    %edx,%eax
  80121d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801220:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801223:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801228:	f7 e9                	imul   %ecx
  80122a:	c1 fa 02             	sar    $0x2,%edx
  80122d:	89 c8                	mov    %ecx,%eax
  80122f:	c1 f8 1f             	sar    $0x1f,%eax
  801232:	29 c2                	sub    %eax,%edx
  801234:	89 d0                	mov    %edx,%eax
  801236:	c1 e0 02             	shl    $0x2,%eax
  801239:	01 d0                	add    %edx,%eax
  80123b:	01 c0                	add    %eax,%eax
  80123d:	29 c1                	sub    %eax,%ecx
  80123f:	89 ca                	mov    %ecx,%edx
  801241:	85 d2                	test   %edx,%edx
  801243:	75 9c                	jne    8011e1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801245:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80124c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124f:	48                   	dec    %eax
  801250:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801253:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801257:	74 3d                	je     801296 <ltostr+0xe2>
		start = 1 ;
  801259:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801260:	eb 34                	jmp    801296 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801262:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801265:	8b 45 0c             	mov    0xc(%ebp),%eax
  801268:	01 d0                	add    %edx,%eax
  80126a:	8a 00                	mov    (%eax),%al
  80126c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80126f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801272:	8b 45 0c             	mov    0xc(%ebp),%eax
  801275:	01 c2                	add    %eax,%edx
  801277:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80127a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127d:	01 c8                	add    %ecx,%eax
  80127f:	8a 00                	mov    (%eax),%al
  801281:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801283:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801286:	8b 45 0c             	mov    0xc(%ebp),%eax
  801289:	01 c2                	add    %eax,%edx
  80128b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80128e:	88 02                	mov    %al,(%edx)
		start++ ;
  801290:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801293:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801296:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801299:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80129c:	7c c4                	jl     801262 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80129e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a4:	01 d0                	add    %edx,%eax
  8012a6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012a9:	90                   	nop
  8012aa:	c9                   	leave  
  8012ab:	c3                   	ret    

008012ac <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012ac:	55                   	push   %ebp
  8012ad:	89 e5                	mov    %esp,%ebp
  8012af:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012b2:	ff 75 08             	pushl  0x8(%ebp)
  8012b5:	e8 54 fa ff ff       	call   800d0e <strlen>
  8012ba:	83 c4 04             	add    $0x4,%esp
  8012bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012c0:	ff 75 0c             	pushl  0xc(%ebp)
  8012c3:	e8 46 fa ff ff       	call   800d0e <strlen>
  8012c8:	83 c4 04             	add    $0x4,%esp
  8012cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012dc:	eb 17                	jmp    8012f5 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012de:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e4:	01 c2                	add    %eax,%edx
  8012e6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	01 c8                	add    %ecx,%eax
  8012ee:	8a 00                	mov    (%eax),%al
  8012f0:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8012f2:	ff 45 fc             	incl   -0x4(%ebp)
  8012f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012fb:	7c e1                	jl     8012de <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8012fd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801304:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80130b:	eb 1f                	jmp    80132c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80130d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801310:	8d 50 01             	lea    0x1(%eax),%edx
  801313:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801316:	89 c2                	mov    %eax,%edx
  801318:	8b 45 10             	mov    0x10(%ebp),%eax
  80131b:	01 c2                	add    %eax,%edx
  80131d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801320:	8b 45 0c             	mov    0xc(%ebp),%eax
  801323:	01 c8                	add    %ecx,%eax
  801325:	8a 00                	mov    (%eax),%al
  801327:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801329:	ff 45 f8             	incl   -0x8(%ebp)
  80132c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80132f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801332:	7c d9                	jl     80130d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801334:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801337:	8b 45 10             	mov    0x10(%ebp),%eax
  80133a:	01 d0                	add    %edx,%eax
  80133c:	c6 00 00             	movb   $0x0,(%eax)
}
  80133f:	90                   	nop
  801340:	c9                   	leave  
  801341:	c3                   	ret    

00801342 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801342:	55                   	push   %ebp
  801343:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801345:	8b 45 14             	mov    0x14(%ebp),%eax
  801348:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80134e:	8b 45 14             	mov    0x14(%ebp),%eax
  801351:	8b 00                	mov    (%eax),%eax
  801353:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80135a:	8b 45 10             	mov    0x10(%ebp),%eax
  80135d:	01 d0                	add    %edx,%eax
  80135f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801365:	eb 0c                	jmp    801373 <strsplit+0x31>
			*string++ = 0;
  801367:	8b 45 08             	mov    0x8(%ebp),%eax
  80136a:	8d 50 01             	lea    0x1(%eax),%edx
  80136d:	89 55 08             	mov    %edx,0x8(%ebp)
  801370:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	84 c0                	test   %al,%al
  80137a:	74 18                	je     801394 <strsplit+0x52>
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	0f be c0             	movsbl %al,%eax
  801384:	50                   	push   %eax
  801385:	ff 75 0c             	pushl  0xc(%ebp)
  801388:	e8 13 fb ff ff       	call   800ea0 <strchr>
  80138d:	83 c4 08             	add    $0x8,%esp
  801390:	85 c0                	test   %eax,%eax
  801392:	75 d3                	jne    801367 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	8a 00                	mov    (%eax),%al
  801399:	84 c0                	test   %al,%al
  80139b:	74 5a                	je     8013f7 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80139d:	8b 45 14             	mov    0x14(%ebp),%eax
  8013a0:	8b 00                	mov    (%eax),%eax
  8013a2:	83 f8 0f             	cmp    $0xf,%eax
  8013a5:	75 07                	jne    8013ae <strsplit+0x6c>
		{
			return 0;
  8013a7:	b8 00 00 00 00       	mov    $0x0,%eax
  8013ac:	eb 66                	jmp    801414 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8013b1:	8b 00                	mov    (%eax),%eax
  8013b3:	8d 48 01             	lea    0x1(%eax),%ecx
  8013b6:	8b 55 14             	mov    0x14(%ebp),%edx
  8013b9:	89 0a                	mov    %ecx,(%edx)
  8013bb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c5:	01 c2                	add    %eax,%edx
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013cc:	eb 03                	jmp    8013d1 <strsplit+0x8f>
			string++;
  8013ce:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	8a 00                	mov    (%eax),%al
  8013d6:	84 c0                	test   %al,%al
  8013d8:	74 8b                	je     801365 <strsplit+0x23>
  8013da:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dd:	8a 00                	mov    (%eax),%al
  8013df:	0f be c0             	movsbl %al,%eax
  8013e2:	50                   	push   %eax
  8013e3:	ff 75 0c             	pushl  0xc(%ebp)
  8013e6:	e8 b5 fa ff ff       	call   800ea0 <strchr>
  8013eb:	83 c4 08             	add    $0x8,%esp
  8013ee:	85 c0                	test   %eax,%eax
  8013f0:	74 dc                	je     8013ce <strsplit+0x8c>
			string++;
	}
  8013f2:	e9 6e ff ff ff       	jmp    801365 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8013f7:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8013f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013fb:	8b 00                	mov    (%eax),%eax
  8013fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801404:	8b 45 10             	mov    0x10(%ebp),%eax
  801407:	01 d0                	add    %edx,%eax
  801409:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80140f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801414:	c9                   	leave  
  801415:	c3                   	ret    

00801416 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
  801419:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  80141c:	83 ec 04             	sub    $0x4,%esp
  80141f:	68 50 24 80 00       	push   $0x802450
  801424:	6a 16                	push   $0x16
  801426:	68 75 24 80 00       	push   $0x802475
  80142b:	e8 33 07 00 00       	call   801b63 <_panic>

00801430 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
  801433:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801436:	83 ec 04             	sub    $0x4,%esp
  801439:	68 84 24 80 00       	push   $0x802484
  80143e:	6a 2e                	push   $0x2e
  801440:	68 75 24 80 00       	push   $0x802475
  801445:	e8 19 07 00 00       	call   801b63 <_panic>

0080144a <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80144a:	55                   	push   %ebp
  80144b:	89 e5                	mov    %esp,%ebp
  80144d:	83 ec 18             	sub    $0x18,%esp
  801450:	8b 45 10             	mov    0x10(%ebp),%eax
  801453:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801456:	83 ec 04             	sub    $0x4,%esp
  801459:	68 a8 24 80 00       	push   $0x8024a8
  80145e:	6a 3b                	push   $0x3b
  801460:	68 75 24 80 00       	push   $0x802475
  801465:	e8 f9 06 00 00       	call   801b63 <_panic>

0080146a <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80146a:	55                   	push   %ebp
  80146b:	89 e5                	mov    %esp,%ebp
  80146d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801470:	83 ec 04             	sub    $0x4,%esp
  801473:	68 a8 24 80 00       	push   $0x8024a8
  801478:	6a 41                	push   $0x41
  80147a:	68 75 24 80 00       	push   $0x802475
  80147f:	e8 df 06 00 00       	call   801b63 <_panic>

00801484 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801484:	55                   	push   %ebp
  801485:	89 e5                	mov    %esp,%ebp
  801487:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80148a:	83 ec 04             	sub    $0x4,%esp
  80148d:	68 a8 24 80 00       	push   $0x8024a8
  801492:	6a 47                	push   $0x47
  801494:	68 75 24 80 00       	push   $0x802475
  801499:	e8 c5 06 00 00       	call   801b63 <_panic>

0080149e <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80149e:	55                   	push   %ebp
  80149f:	89 e5                	mov    %esp,%ebp
  8014a1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014a4:	83 ec 04             	sub    $0x4,%esp
  8014a7:	68 a8 24 80 00       	push   $0x8024a8
  8014ac:	6a 4c                	push   $0x4c
  8014ae:	68 75 24 80 00       	push   $0x802475
  8014b3:	e8 ab 06 00 00       	call   801b63 <_panic>

008014b8 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8014b8:	55                   	push   %ebp
  8014b9:	89 e5                	mov    %esp,%ebp
  8014bb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014be:	83 ec 04             	sub    $0x4,%esp
  8014c1:	68 a8 24 80 00       	push   $0x8024a8
  8014c6:	6a 52                	push   $0x52
  8014c8:	68 75 24 80 00       	push   $0x802475
  8014cd:	e8 91 06 00 00       	call   801b63 <_panic>

008014d2 <shrink>:
}
void shrink(uint32 newSize)
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
  8014d5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014d8:	83 ec 04             	sub    $0x4,%esp
  8014db:	68 a8 24 80 00       	push   $0x8024a8
  8014e0:	6a 56                	push   $0x56
  8014e2:	68 75 24 80 00       	push   $0x802475
  8014e7:	e8 77 06 00 00       	call   801b63 <_panic>

008014ec <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8014ec:	55                   	push   %ebp
  8014ed:	89 e5                	mov    %esp,%ebp
  8014ef:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8014f2:	83 ec 04             	sub    $0x4,%esp
  8014f5:	68 a8 24 80 00       	push   $0x8024a8
  8014fa:	6a 5b                	push   $0x5b
  8014fc:	68 75 24 80 00       	push   $0x802475
  801501:	e8 5d 06 00 00       	call   801b63 <_panic>

00801506 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
  801509:	57                   	push   %edi
  80150a:	56                   	push   %esi
  80150b:	53                   	push   %ebx
  80150c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80150f:	8b 45 08             	mov    0x8(%ebp),%eax
  801512:	8b 55 0c             	mov    0xc(%ebp),%edx
  801515:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801518:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80151b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80151e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801521:	cd 30                	int    $0x30
  801523:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801526:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801529:	83 c4 10             	add    $0x10,%esp
  80152c:	5b                   	pop    %ebx
  80152d:	5e                   	pop    %esi
  80152e:	5f                   	pop    %edi
  80152f:	5d                   	pop    %ebp
  801530:	c3                   	ret    

00801531 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801531:	55                   	push   %ebp
  801532:	89 e5                	mov    %esp,%ebp
  801534:	83 ec 04             	sub    $0x4,%esp
  801537:	8b 45 10             	mov    0x10(%ebp),%eax
  80153a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80153d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801541:	8b 45 08             	mov    0x8(%ebp),%eax
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	52                   	push   %edx
  801549:	ff 75 0c             	pushl  0xc(%ebp)
  80154c:	50                   	push   %eax
  80154d:	6a 00                	push   $0x0
  80154f:	e8 b2 ff ff ff       	call   801506 <syscall>
  801554:	83 c4 18             	add    $0x18,%esp
}
  801557:	90                   	nop
  801558:	c9                   	leave  
  801559:	c3                   	ret    

0080155a <sys_cgetc>:

int
sys_cgetc(void)
{
  80155a:	55                   	push   %ebp
  80155b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 01                	push   $0x1
  801569:	e8 98 ff ff ff       	call   801506 <syscall>
  80156e:	83 c4 18             	add    $0x18,%esp
}
  801571:	c9                   	leave  
  801572:	c3                   	ret    

00801573 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801573:	55                   	push   %ebp
  801574:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	50                   	push   %eax
  801582:	6a 05                	push   $0x5
  801584:	e8 7d ff ff ff       	call   801506 <syscall>
  801589:	83 c4 18             	add    $0x18,%esp
}
  80158c:	c9                   	leave  
  80158d:	c3                   	ret    

0080158e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80158e:	55                   	push   %ebp
  80158f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 02                	push   $0x2
  80159d:	e8 64 ff ff ff       	call   801506 <syscall>
  8015a2:	83 c4 18             	add    $0x18,%esp
}
  8015a5:	c9                   	leave  
  8015a6:	c3                   	ret    

008015a7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 03                	push   $0x3
  8015b6:	e8 4b ff ff ff       	call   801506 <syscall>
  8015bb:	83 c4 18             	add    $0x18,%esp
}
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 04                	push   $0x4
  8015cf:	e8 32 ff ff ff       	call   801506 <syscall>
  8015d4:	83 c4 18             	add    $0x18,%esp
}
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <sys_env_exit>:


void sys_env_exit(void)
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 06                	push   $0x6
  8015e8:	e8 19 ff ff ff       	call   801506 <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	90                   	nop
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	52                   	push   %edx
  801603:	50                   	push   %eax
  801604:	6a 07                	push   $0x7
  801606:	e8 fb fe ff ff       	call   801506 <syscall>
  80160b:	83 c4 18             	add    $0x18,%esp
}
  80160e:	c9                   	leave  
  80160f:	c3                   	ret    

00801610 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801610:	55                   	push   %ebp
  801611:	89 e5                	mov    %esp,%ebp
  801613:	56                   	push   %esi
  801614:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801615:	8b 75 18             	mov    0x18(%ebp),%esi
  801618:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80161b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80161e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801621:	8b 45 08             	mov    0x8(%ebp),%eax
  801624:	56                   	push   %esi
  801625:	53                   	push   %ebx
  801626:	51                   	push   %ecx
  801627:	52                   	push   %edx
  801628:	50                   	push   %eax
  801629:	6a 08                	push   $0x8
  80162b:	e8 d6 fe ff ff       	call   801506 <syscall>
  801630:	83 c4 18             	add    $0x18,%esp
}
  801633:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801636:	5b                   	pop    %ebx
  801637:	5e                   	pop    %esi
  801638:	5d                   	pop    %ebp
  801639:	c3                   	ret    

0080163a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80163d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801640:	8b 45 08             	mov    0x8(%ebp),%eax
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	52                   	push   %edx
  80164a:	50                   	push   %eax
  80164b:	6a 09                	push   $0x9
  80164d:	e8 b4 fe ff ff       	call   801506 <syscall>
  801652:	83 c4 18             	add    $0x18,%esp
}
  801655:	c9                   	leave  
  801656:	c3                   	ret    

00801657 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801657:	55                   	push   %ebp
  801658:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	ff 75 0c             	pushl  0xc(%ebp)
  801663:	ff 75 08             	pushl  0x8(%ebp)
  801666:	6a 0a                	push   $0xa
  801668:	e8 99 fe ff ff       	call   801506 <syscall>
  80166d:	83 c4 18             	add    $0x18,%esp
}
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 0b                	push   $0xb
  801681:	e8 80 fe ff ff       	call   801506 <syscall>
  801686:	83 c4 18             	add    $0x18,%esp
}
  801689:	c9                   	leave  
  80168a:	c3                   	ret    

0080168b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80168b:	55                   	push   %ebp
  80168c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 0c                	push   $0xc
  80169a:	e8 67 fe ff ff       	call   801506 <syscall>
  80169f:	83 c4 18             	add    $0x18,%esp
}
  8016a2:	c9                   	leave  
  8016a3:	c3                   	ret    

008016a4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016a4:	55                   	push   %ebp
  8016a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 0d                	push   $0xd
  8016b3:	e8 4e fe ff ff       	call   801506 <syscall>
  8016b8:	83 c4 18             	add    $0x18,%esp
}
  8016bb:	c9                   	leave  
  8016bc:	c3                   	ret    

008016bd <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016bd:	55                   	push   %ebp
  8016be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	ff 75 0c             	pushl  0xc(%ebp)
  8016c9:	ff 75 08             	pushl  0x8(%ebp)
  8016cc:	6a 11                	push   $0x11
  8016ce:	e8 33 fe ff ff       	call   801506 <syscall>
  8016d3:	83 c4 18             	add    $0x18,%esp
	return;
  8016d6:	90                   	nop
}
  8016d7:	c9                   	leave  
  8016d8:	c3                   	ret    

008016d9 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	ff 75 0c             	pushl  0xc(%ebp)
  8016e5:	ff 75 08             	pushl  0x8(%ebp)
  8016e8:	6a 12                	push   $0x12
  8016ea:	e8 17 fe ff ff       	call   801506 <syscall>
  8016ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f2:	90                   	nop
}
  8016f3:	c9                   	leave  
  8016f4:	c3                   	ret    

008016f5 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016f5:	55                   	push   %ebp
  8016f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 0e                	push   $0xe
  801704:	e8 fd fd ff ff       	call   801506 <syscall>
  801709:	83 c4 18             	add    $0x18,%esp
}
  80170c:	c9                   	leave  
  80170d:	c3                   	ret    

0080170e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 00                	push   $0x0
  801719:	ff 75 08             	pushl  0x8(%ebp)
  80171c:	6a 0f                	push   $0xf
  80171e:	e8 e3 fd ff ff       	call   801506 <syscall>
  801723:	83 c4 18             	add    $0x18,%esp
}
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 10                	push   $0x10
  801737:	e8 ca fd ff ff       	call   801506 <syscall>
  80173c:	83 c4 18             	add    $0x18,%esp
}
  80173f:	90                   	nop
  801740:	c9                   	leave  
  801741:	c3                   	ret    

00801742 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801742:	55                   	push   %ebp
  801743:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 14                	push   $0x14
  801751:	e8 b0 fd ff ff       	call   801506 <syscall>
  801756:	83 c4 18             	add    $0x18,%esp
}
  801759:	90                   	nop
  80175a:	c9                   	leave  
  80175b:	c3                   	ret    

0080175c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80175c:	55                   	push   %ebp
  80175d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 15                	push   $0x15
  80176b:	e8 96 fd ff ff       	call   801506 <syscall>
  801770:	83 c4 18             	add    $0x18,%esp
}
  801773:	90                   	nop
  801774:	c9                   	leave  
  801775:	c3                   	ret    

00801776 <sys_cputc>:


void
sys_cputc(const char c)
{
  801776:	55                   	push   %ebp
  801777:	89 e5                	mov    %esp,%ebp
  801779:	83 ec 04             	sub    $0x4,%esp
  80177c:	8b 45 08             	mov    0x8(%ebp),%eax
  80177f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801782:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	50                   	push   %eax
  80178f:	6a 16                	push   $0x16
  801791:	e8 70 fd ff ff       	call   801506 <syscall>
  801796:	83 c4 18             	add    $0x18,%esp
}
  801799:	90                   	nop
  80179a:	c9                   	leave  
  80179b:	c3                   	ret    

0080179c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80179c:	55                   	push   %ebp
  80179d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 17                	push   $0x17
  8017ab:	e8 56 fd ff ff       	call   801506 <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
}
  8017b3:	90                   	nop
  8017b4:	c9                   	leave  
  8017b5:	c3                   	ret    

008017b6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017b6:	55                   	push   %ebp
  8017b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	ff 75 0c             	pushl  0xc(%ebp)
  8017c5:	50                   	push   %eax
  8017c6:	6a 18                	push   $0x18
  8017c8:	e8 39 fd ff ff       	call   801506 <syscall>
  8017cd:	83 c4 18             	add    $0x18,%esp
}
  8017d0:	c9                   	leave  
  8017d1:	c3                   	ret    

008017d2 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8017d2:	55                   	push   %ebp
  8017d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	52                   	push   %edx
  8017e2:	50                   	push   %eax
  8017e3:	6a 1b                	push   $0x1b
  8017e5:	e8 1c fd ff ff       	call   801506 <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	52                   	push   %edx
  8017ff:	50                   	push   %eax
  801800:	6a 19                	push   $0x19
  801802:	e8 ff fc ff ff       	call   801506 <syscall>
  801807:	83 c4 18             	add    $0x18,%esp
}
  80180a:	90                   	nop
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801810:	8b 55 0c             	mov    0xc(%ebp),%edx
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	52                   	push   %edx
  80181d:	50                   	push   %eax
  80181e:	6a 1a                	push   $0x1a
  801820:	e8 e1 fc ff ff       	call   801506 <syscall>
  801825:	83 c4 18             	add    $0x18,%esp
}
  801828:	90                   	nop
  801829:	c9                   	leave  
  80182a:	c3                   	ret    

0080182b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80182b:	55                   	push   %ebp
  80182c:	89 e5                	mov    %esp,%ebp
  80182e:	83 ec 04             	sub    $0x4,%esp
  801831:	8b 45 10             	mov    0x10(%ebp),%eax
  801834:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801837:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80183a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	6a 00                	push   $0x0
  801843:	51                   	push   %ecx
  801844:	52                   	push   %edx
  801845:	ff 75 0c             	pushl  0xc(%ebp)
  801848:	50                   	push   %eax
  801849:	6a 1c                	push   $0x1c
  80184b:	e8 b6 fc ff ff       	call   801506 <syscall>
  801850:	83 c4 18             	add    $0x18,%esp
}
  801853:	c9                   	leave  
  801854:	c3                   	ret    

00801855 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801855:	55                   	push   %ebp
  801856:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801858:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185b:	8b 45 08             	mov    0x8(%ebp),%eax
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	52                   	push   %edx
  801865:	50                   	push   %eax
  801866:	6a 1d                	push   $0x1d
  801868:	e8 99 fc ff ff       	call   801506 <syscall>
  80186d:	83 c4 18             	add    $0x18,%esp
}
  801870:	c9                   	leave  
  801871:	c3                   	ret    

00801872 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801872:	55                   	push   %ebp
  801873:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801875:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801878:	8b 55 0c             	mov    0xc(%ebp),%edx
  80187b:	8b 45 08             	mov    0x8(%ebp),%eax
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	51                   	push   %ecx
  801883:	52                   	push   %edx
  801884:	50                   	push   %eax
  801885:	6a 1e                	push   $0x1e
  801887:	e8 7a fc ff ff       	call   801506 <syscall>
  80188c:	83 c4 18             	add    $0x18,%esp
}
  80188f:	c9                   	leave  
  801890:	c3                   	ret    

00801891 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801891:	55                   	push   %ebp
  801892:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801894:	8b 55 0c             	mov    0xc(%ebp),%edx
  801897:	8b 45 08             	mov    0x8(%ebp),%eax
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	52                   	push   %edx
  8018a1:	50                   	push   %eax
  8018a2:	6a 1f                	push   $0x1f
  8018a4:	e8 5d fc ff ff       	call   801506 <syscall>
  8018a9:	83 c4 18             	add    $0x18,%esp
}
  8018ac:	c9                   	leave  
  8018ad:	c3                   	ret    

008018ae <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018ae:	55                   	push   %ebp
  8018af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 20                	push   $0x20
  8018bd:	e8 44 fc ff ff       	call   801506 <syscall>
  8018c2:	83 c4 18             	add    $0x18,%esp
}
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8018ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cd:	6a 00                	push   $0x0
  8018cf:	ff 75 14             	pushl  0x14(%ebp)
  8018d2:	ff 75 10             	pushl  0x10(%ebp)
  8018d5:	ff 75 0c             	pushl  0xc(%ebp)
  8018d8:	50                   	push   %eax
  8018d9:	6a 21                	push   $0x21
  8018db:	e8 26 fc ff ff       	call   801506 <syscall>
  8018e0:	83 c4 18             	add    $0x18,%esp
}
  8018e3:	c9                   	leave  
  8018e4:	c3                   	ret    

008018e5 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8018e5:	55                   	push   %ebp
  8018e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	50                   	push   %eax
  8018f4:	6a 22                	push   $0x22
  8018f6:	e8 0b fc ff ff       	call   801506 <syscall>
  8018fb:	83 c4 18             	add    $0x18,%esp
}
  8018fe:	90                   	nop
  8018ff:	c9                   	leave  
  801900:	c3                   	ret    

00801901 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801901:	55                   	push   %ebp
  801902:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801904:	8b 45 08             	mov    0x8(%ebp),%eax
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	50                   	push   %eax
  801910:	6a 23                	push   $0x23
  801912:	e8 ef fb ff ff       	call   801506 <syscall>
  801917:	83 c4 18             	add    $0x18,%esp
}
  80191a:	90                   	nop
  80191b:	c9                   	leave  
  80191c:	c3                   	ret    

0080191d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80191d:	55                   	push   %ebp
  80191e:	89 e5                	mov    %esp,%ebp
  801920:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801923:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801926:	8d 50 04             	lea    0x4(%eax),%edx
  801929:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	52                   	push   %edx
  801933:	50                   	push   %eax
  801934:	6a 24                	push   $0x24
  801936:	e8 cb fb ff ff       	call   801506 <syscall>
  80193b:	83 c4 18             	add    $0x18,%esp
	return result;
  80193e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801941:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801944:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801947:	89 01                	mov    %eax,(%ecx)
  801949:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80194c:	8b 45 08             	mov    0x8(%ebp),%eax
  80194f:	c9                   	leave  
  801950:	c2 04 00             	ret    $0x4

00801953 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	ff 75 10             	pushl  0x10(%ebp)
  80195d:	ff 75 0c             	pushl  0xc(%ebp)
  801960:	ff 75 08             	pushl  0x8(%ebp)
  801963:	6a 13                	push   $0x13
  801965:	e8 9c fb ff ff       	call   801506 <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
	return ;
  80196d:	90                   	nop
}
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <sys_rcr2>:
uint32 sys_rcr2()
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 25                	push   $0x25
  80197f:	e8 82 fb ff ff       	call   801506 <syscall>
  801984:	83 c4 18             	add    $0x18,%esp
}
  801987:	c9                   	leave  
  801988:	c3                   	ret    

00801989 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801989:	55                   	push   %ebp
  80198a:	89 e5                	mov    %esp,%ebp
  80198c:	83 ec 04             	sub    $0x4,%esp
  80198f:	8b 45 08             	mov    0x8(%ebp),%eax
  801992:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801995:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	50                   	push   %eax
  8019a2:	6a 26                	push   $0x26
  8019a4:	e8 5d fb ff ff       	call   801506 <syscall>
  8019a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ac:	90                   	nop
}
  8019ad:	c9                   	leave  
  8019ae:	c3                   	ret    

008019af <rsttst>:
void rsttst()
{
  8019af:	55                   	push   %ebp
  8019b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 28                	push   $0x28
  8019be:	e8 43 fb ff ff       	call   801506 <syscall>
  8019c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8019c6:	90                   	nop
}
  8019c7:	c9                   	leave  
  8019c8:	c3                   	ret    

008019c9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019c9:	55                   	push   %ebp
  8019ca:	89 e5                	mov    %esp,%ebp
  8019cc:	83 ec 04             	sub    $0x4,%esp
  8019cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8019d2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019d5:	8b 55 18             	mov    0x18(%ebp),%edx
  8019d8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019dc:	52                   	push   %edx
  8019dd:	50                   	push   %eax
  8019de:	ff 75 10             	pushl  0x10(%ebp)
  8019e1:	ff 75 0c             	pushl  0xc(%ebp)
  8019e4:	ff 75 08             	pushl  0x8(%ebp)
  8019e7:	6a 27                	push   $0x27
  8019e9:	e8 18 fb ff ff       	call   801506 <syscall>
  8019ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f1:	90                   	nop
}
  8019f2:	c9                   	leave  
  8019f3:	c3                   	ret    

008019f4 <chktst>:
void chktst(uint32 n)
{
  8019f4:	55                   	push   %ebp
  8019f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	ff 75 08             	pushl  0x8(%ebp)
  801a02:	6a 29                	push   $0x29
  801a04:	e8 fd fa ff ff       	call   801506 <syscall>
  801a09:	83 c4 18             	add    $0x18,%esp
	return ;
  801a0c:	90                   	nop
}
  801a0d:	c9                   	leave  
  801a0e:	c3                   	ret    

00801a0f <inctst>:

void inctst()
{
  801a0f:	55                   	push   %ebp
  801a10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 2a                	push   $0x2a
  801a1e:	e8 e3 fa ff ff       	call   801506 <syscall>
  801a23:	83 c4 18             	add    $0x18,%esp
	return ;
  801a26:	90                   	nop
}
  801a27:	c9                   	leave  
  801a28:	c3                   	ret    

00801a29 <gettst>:
uint32 gettst()
{
  801a29:	55                   	push   %ebp
  801a2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 2b                	push   $0x2b
  801a38:	e8 c9 fa ff ff       	call   801506 <syscall>
  801a3d:	83 c4 18             	add    $0x18,%esp
}
  801a40:	c9                   	leave  
  801a41:	c3                   	ret    

00801a42 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
  801a45:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 2c                	push   $0x2c
  801a54:	e8 ad fa ff ff       	call   801506 <syscall>
  801a59:	83 c4 18             	add    $0x18,%esp
  801a5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a5f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a63:	75 07                	jne    801a6c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a65:	b8 01 00 00 00       	mov    $0x1,%eax
  801a6a:	eb 05                	jmp    801a71 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a6c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a71:	c9                   	leave  
  801a72:	c3                   	ret    

00801a73 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a73:	55                   	push   %ebp
  801a74:	89 e5                	mov    %esp,%ebp
  801a76:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	6a 2c                	push   $0x2c
  801a85:	e8 7c fa ff ff       	call   801506 <syscall>
  801a8a:	83 c4 18             	add    $0x18,%esp
  801a8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a90:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a94:	75 07                	jne    801a9d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a96:	b8 01 00 00 00       	mov    $0x1,%eax
  801a9b:	eb 05                	jmp    801aa2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aa2:	c9                   	leave  
  801aa3:	c3                   	ret    

00801aa4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801aa4:	55                   	push   %ebp
  801aa5:	89 e5                	mov    %esp,%ebp
  801aa7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 2c                	push   $0x2c
  801ab6:	e8 4b fa ff ff       	call   801506 <syscall>
  801abb:	83 c4 18             	add    $0x18,%esp
  801abe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ac1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ac5:	75 07                	jne    801ace <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ac7:	b8 01 00 00 00       	mov    $0x1,%eax
  801acc:	eb 05                	jmp    801ad3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ace:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ad3:	c9                   	leave  
  801ad4:	c3                   	ret    

00801ad5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ad5:	55                   	push   %ebp
  801ad6:	89 e5                	mov    %esp,%ebp
  801ad8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 2c                	push   $0x2c
  801ae7:	e8 1a fa ff ff       	call   801506 <syscall>
  801aec:	83 c4 18             	add    $0x18,%esp
  801aef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801af2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801af6:	75 07                	jne    801aff <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801af8:	b8 01 00 00 00       	mov    $0x1,%eax
  801afd:	eb 05                	jmp    801b04 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801aff:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b04:	c9                   	leave  
  801b05:	c3                   	ret    

00801b06 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b06:	55                   	push   %ebp
  801b07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	ff 75 08             	pushl  0x8(%ebp)
  801b14:	6a 2d                	push   $0x2d
  801b16:	e8 eb f9 ff ff       	call   801506 <syscall>
  801b1b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b1e:	90                   	nop
}
  801b1f:	c9                   	leave  
  801b20:	c3                   	ret    

00801b21 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b21:	55                   	push   %ebp
  801b22:	89 e5                	mov    %esp,%ebp
  801b24:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b25:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b28:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b31:	6a 00                	push   $0x0
  801b33:	53                   	push   %ebx
  801b34:	51                   	push   %ecx
  801b35:	52                   	push   %edx
  801b36:	50                   	push   %eax
  801b37:	6a 2e                	push   $0x2e
  801b39:	e8 c8 f9 ff ff       	call   801506 <syscall>
  801b3e:	83 c4 18             	add    $0x18,%esp
}
  801b41:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b44:	c9                   	leave  
  801b45:	c3                   	ret    

00801b46 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b46:	55                   	push   %ebp
  801b47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b49:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	52                   	push   %edx
  801b56:	50                   	push   %eax
  801b57:	6a 2f                	push   $0x2f
  801b59:	e8 a8 f9 ff ff       	call   801506 <syscall>
  801b5e:	83 c4 18             	add    $0x18,%esp
}
  801b61:	c9                   	leave  
  801b62:	c3                   	ret    

00801b63 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801b63:	55                   	push   %ebp
  801b64:	89 e5                	mov    %esp,%ebp
  801b66:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801b69:	8d 45 10             	lea    0x10(%ebp),%eax
  801b6c:	83 c0 04             	add    $0x4,%eax
  801b6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801b72:	a1 18 31 80 00       	mov    0x803118,%eax
  801b77:	85 c0                	test   %eax,%eax
  801b79:	74 16                	je     801b91 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801b7b:	a1 18 31 80 00       	mov    0x803118,%eax
  801b80:	83 ec 08             	sub    $0x8,%esp
  801b83:	50                   	push   %eax
  801b84:	68 cc 24 80 00       	push   $0x8024cc
  801b89:	e8 fe ea ff ff       	call   80068c <cprintf>
  801b8e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801b91:	a1 00 30 80 00       	mov    0x803000,%eax
  801b96:	ff 75 0c             	pushl  0xc(%ebp)
  801b99:	ff 75 08             	pushl  0x8(%ebp)
  801b9c:	50                   	push   %eax
  801b9d:	68 d1 24 80 00       	push   $0x8024d1
  801ba2:	e8 e5 ea ff ff       	call   80068c <cprintf>
  801ba7:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801baa:	8b 45 10             	mov    0x10(%ebp),%eax
  801bad:	83 ec 08             	sub    $0x8,%esp
  801bb0:	ff 75 f4             	pushl  -0xc(%ebp)
  801bb3:	50                   	push   %eax
  801bb4:	e8 68 ea ff ff       	call   800621 <vcprintf>
  801bb9:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801bbc:	83 ec 08             	sub    $0x8,%esp
  801bbf:	6a 00                	push   $0x0
  801bc1:	68 ed 24 80 00       	push   $0x8024ed
  801bc6:	e8 56 ea ff ff       	call   800621 <vcprintf>
  801bcb:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801bce:	e8 d7 e9 ff ff       	call   8005aa <exit>

	// should not return here
	while (1) ;
  801bd3:	eb fe                	jmp    801bd3 <_panic+0x70>

00801bd5 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801bd5:	55                   	push   %ebp
  801bd6:	89 e5                	mov    %esp,%ebp
  801bd8:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801bdb:	a1 20 30 80 00       	mov    0x803020,%eax
  801be0:	8b 50 74             	mov    0x74(%eax),%edx
  801be3:	8b 45 0c             	mov    0xc(%ebp),%eax
  801be6:	39 c2                	cmp    %eax,%edx
  801be8:	74 14                	je     801bfe <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801bea:	83 ec 04             	sub    $0x4,%esp
  801bed:	68 f0 24 80 00       	push   $0x8024f0
  801bf2:	6a 26                	push   $0x26
  801bf4:	68 3c 25 80 00       	push   $0x80253c
  801bf9:	e8 65 ff ff ff       	call   801b63 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801bfe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801c05:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c0c:	e9 b6 00 00 00       	jmp    801cc7 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801c11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c14:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1e:	01 d0                	add    %edx,%eax
  801c20:	8b 00                	mov    (%eax),%eax
  801c22:	85 c0                	test   %eax,%eax
  801c24:	75 08                	jne    801c2e <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801c26:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801c29:	e9 96 00 00 00       	jmp    801cc4 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801c2e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c35:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801c3c:	eb 5d                	jmp    801c9b <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801c3e:	a1 20 30 80 00       	mov    0x803020,%eax
  801c43:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801c49:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c4c:	c1 e2 04             	shl    $0x4,%edx
  801c4f:	01 d0                	add    %edx,%eax
  801c51:	8a 40 04             	mov    0x4(%eax),%al
  801c54:	84 c0                	test   %al,%al
  801c56:	75 40                	jne    801c98 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c58:	a1 20 30 80 00       	mov    0x803020,%eax
  801c5d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801c63:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c66:	c1 e2 04             	shl    $0x4,%edx
  801c69:	01 d0                	add    %edx,%eax
  801c6b:	8b 00                	mov    (%eax),%eax
  801c6d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801c70:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c73:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801c78:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801c7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c7d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801c84:	8b 45 08             	mov    0x8(%ebp),%eax
  801c87:	01 c8                	add    %ecx,%eax
  801c89:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801c8b:	39 c2                	cmp    %eax,%edx
  801c8d:	75 09                	jne    801c98 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801c8f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801c96:	eb 12                	jmp    801caa <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801c98:	ff 45 e8             	incl   -0x18(%ebp)
  801c9b:	a1 20 30 80 00       	mov    0x803020,%eax
  801ca0:	8b 50 74             	mov    0x74(%eax),%edx
  801ca3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ca6:	39 c2                	cmp    %eax,%edx
  801ca8:	77 94                	ja     801c3e <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801caa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801cae:	75 14                	jne    801cc4 <CheckWSWithoutLastIndex+0xef>
			panic(
  801cb0:	83 ec 04             	sub    $0x4,%esp
  801cb3:	68 48 25 80 00       	push   $0x802548
  801cb8:	6a 3a                	push   $0x3a
  801cba:	68 3c 25 80 00       	push   $0x80253c
  801cbf:	e8 9f fe ff ff       	call   801b63 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801cc4:	ff 45 f0             	incl   -0x10(%ebp)
  801cc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cca:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801ccd:	0f 8c 3e ff ff ff    	jl     801c11 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801cd3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801cda:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801ce1:	eb 20                	jmp    801d03 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801ce3:	a1 20 30 80 00       	mov    0x803020,%eax
  801ce8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801cee:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801cf1:	c1 e2 04             	shl    $0x4,%edx
  801cf4:	01 d0                	add    %edx,%eax
  801cf6:	8a 40 04             	mov    0x4(%eax),%al
  801cf9:	3c 01                	cmp    $0x1,%al
  801cfb:	75 03                	jne    801d00 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801cfd:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d00:	ff 45 e0             	incl   -0x20(%ebp)
  801d03:	a1 20 30 80 00       	mov    0x803020,%eax
  801d08:	8b 50 74             	mov    0x74(%eax),%edx
  801d0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d0e:	39 c2                	cmp    %eax,%edx
  801d10:	77 d1                	ja     801ce3 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801d12:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d15:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d18:	74 14                	je     801d2e <CheckWSWithoutLastIndex+0x159>
		panic(
  801d1a:	83 ec 04             	sub    $0x4,%esp
  801d1d:	68 9c 25 80 00       	push   $0x80259c
  801d22:	6a 44                	push   $0x44
  801d24:	68 3c 25 80 00       	push   $0x80253c
  801d29:	e8 35 fe ff ff       	call   801b63 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801d2e:	90                   	nop
  801d2f:	c9                   	leave  
  801d30:	c3                   	ret    
  801d31:	66 90                	xchg   %ax,%ax
  801d33:	90                   	nop

00801d34 <__udivdi3>:
  801d34:	55                   	push   %ebp
  801d35:	57                   	push   %edi
  801d36:	56                   	push   %esi
  801d37:	53                   	push   %ebx
  801d38:	83 ec 1c             	sub    $0x1c,%esp
  801d3b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d3f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d47:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d4b:	89 ca                	mov    %ecx,%edx
  801d4d:	89 f8                	mov    %edi,%eax
  801d4f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d53:	85 f6                	test   %esi,%esi
  801d55:	75 2d                	jne    801d84 <__udivdi3+0x50>
  801d57:	39 cf                	cmp    %ecx,%edi
  801d59:	77 65                	ja     801dc0 <__udivdi3+0x8c>
  801d5b:	89 fd                	mov    %edi,%ebp
  801d5d:	85 ff                	test   %edi,%edi
  801d5f:	75 0b                	jne    801d6c <__udivdi3+0x38>
  801d61:	b8 01 00 00 00       	mov    $0x1,%eax
  801d66:	31 d2                	xor    %edx,%edx
  801d68:	f7 f7                	div    %edi
  801d6a:	89 c5                	mov    %eax,%ebp
  801d6c:	31 d2                	xor    %edx,%edx
  801d6e:	89 c8                	mov    %ecx,%eax
  801d70:	f7 f5                	div    %ebp
  801d72:	89 c1                	mov    %eax,%ecx
  801d74:	89 d8                	mov    %ebx,%eax
  801d76:	f7 f5                	div    %ebp
  801d78:	89 cf                	mov    %ecx,%edi
  801d7a:	89 fa                	mov    %edi,%edx
  801d7c:	83 c4 1c             	add    $0x1c,%esp
  801d7f:	5b                   	pop    %ebx
  801d80:	5e                   	pop    %esi
  801d81:	5f                   	pop    %edi
  801d82:	5d                   	pop    %ebp
  801d83:	c3                   	ret    
  801d84:	39 ce                	cmp    %ecx,%esi
  801d86:	77 28                	ja     801db0 <__udivdi3+0x7c>
  801d88:	0f bd fe             	bsr    %esi,%edi
  801d8b:	83 f7 1f             	xor    $0x1f,%edi
  801d8e:	75 40                	jne    801dd0 <__udivdi3+0x9c>
  801d90:	39 ce                	cmp    %ecx,%esi
  801d92:	72 0a                	jb     801d9e <__udivdi3+0x6a>
  801d94:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d98:	0f 87 9e 00 00 00    	ja     801e3c <__udivdi3+0x108>
  801d9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801da3:	89 fa                	mov    %edi,%edx
  801da5:	83 c4 1c             	add    $0x1c,%esp
  801da8:	5b                   	pop    %ebx
  801da9:	5e                   	pop    %esi
  801daa:	5f                   	pop    %edi
  801dab:	5d                   	pop    %ebp
  801dac:	c3                   	ret    
  801dad:	8d 76 00             	lea    0x0(%esi),%esi
  801db0:	31 ff                	xor    %edi,%edi
  801db2:	31 c0                	xor    %eax,%eax
  801db4:	89 fa                	mov    %edi,%edx
  801db6:	83 c4 1c             	add    $0x1c,%esp
  801db9:	5b                   	pop    %ebx
  801dba:	5e                   	pop    %esi
  801dbb:	5f                   	pop    %edi
  801dbc:	5d                   	pop    %ebp
  801dbd:	c3                   	ret    
  801dbe:	66 90                	xchg   %ax,%ax
  801dc0:	89 d8                	mov    %ebx,%eax
  801dc2:	f7 f7                	div    %edi
  801dc4:	31 ff                	xor    %edi,%edi
  801dc6:	89 fa                	mov    %edi,%edx
  801dc8:	83 c4 1c             	add    $0x1c,%esp
  801dcb:	5b                   	pop    %ebx
  801dcc:	5e                   	pop    %esi
  801dcd:	5f                   	pop    %edi
  801dce:	5d                   	pop    %ebp
  801dcf:	c3                   	ret    
  801dd0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dd5:	89 eb                	mov    %ebp,%ebx
  801dd7:	29 fb                	sub    %edi,%ebx
  801dd9:	89 f9                	mov    %edi,%ecx
  801ddb:	d3 e6                	shl    %cl,%esi
  801ddd:	89 c5                	mov    %eax,%ebp
  801ddf:	88 d9                	mov    %bl,%cl
  801de1:	d3 ed                	shr    %cl,%ebp
  801de3:	89 e9                	mov    %ebp,%ecx
  801de5:	09 f1                	or     %esi,%ecx
  801de7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801deb:	89 f9                	mov    %edi,%ecx
  801ded:	d3 e0                	shl    %cl,%eax
  801def:	89 c5                	mov    %eax,%ebp
  801df1:	89 d6                	mov    %edx,%esi
  801df3:	88 d9                	mov    %bl,%cl
  801df5:	d3 ee                	shr    %cl,%esi
  801df7:	89 f9                	mov    %edi,%ecx
  801df9:	d3 e2                	shl    %cl,%edx
  801dfb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dff:	88 d9                	mov    %bl,%cl
  801e01:	d3 e8                	shr    %cl,%eax
  801e03:	09 c2                	or     %eax,%edx
  801e05:	89 d0                	mov    %edx,%eax
  801e07:	89 f2                	mov    %esi,%edx
  801e09:	f7 74 24 0c          	divl   0xc(%esp)
  801e0d:	89 d6                	mov    %edx,%esi
  801e0f:	89 c3                	mov    %eax,%ebx
  801e11:	f7 e5                	mul    %ebp
  801e13:	39 d6                	cmp    %edx,%esi
  801e15:	72 19                	jb     801e30 <__udivdi3+0xfc>
  801e17:	74 0b                	je     801e24 <__udivdi3+0xf0>
  801e19:	89 d8                	mov    %ebx,%eax
  801e1b:	31 ff                	xor    %edi,%edi
  801e1d:	e9 58 ff ff ff       	jmp    801d7a <__udivdi3+0x46>
  801e22:	66 90                	xchg   %ax,%ax
  801e24:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e28:	89 f9                	mov    %edi,%ecx
  801e2a:	d3 e2                	shl    %cl,%edx
  801e2c:	39 c2                	cmp    %eax,%edx
  801e2e:	73 e9                	jae    801e19 <__udivdi3+0xe5>
  801e30:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e33:	31 ff                	xor    %edi,%edi
  801e35:	e9 40 ff ff ff       	jmp    801d7a <__udivdi3+0x46>
  801e3a:	66 90                	xchg   %ax,%ax
  801e3c:	31 c0                	xor    %eax,%eax
  801e3e:	e9 37 ff ff ff       	jmp    801d7a <__udivdi3+0x46>
  801e43:	90                   	nop

00801e44 <__umoddi3>:
  801e44:	55                   	push   %ebp
  801e45:	57                   	push   %edi
  801e46:	56                   	push   %esi
  801e47:	53                   	push   %ebx
  801e48:	83 ec 1c             	sub    $0x1c,%esp
  801e4b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e4f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e53:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e57:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e5b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e5f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e63:	89 f3                	mov    %esi,%ebx
  801e65:	89 fa                	mov    %edi,%edx
  801e67:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e6b:	89 34 24             	mov    %esi,(%esp)
  801e6e:	85 c0                	test   %eax,%eax
  801e70:	75 1a                	jne    801e8c <__umoddi3+0x48>
  801e72:	39 f7                	cmp    %esi,%edi
  801e74:	0f 86 a2 00 00 00    	jbe    801f1c <__umoddi3+0xd8>
  801e7a:	89 c8                	mov    %ecx,%eax
  801e7c:	89 f2                	mov    %esi,%edx
  801e7e:	f7 f7                	div    %edi
  801e80:	89 d0                	mov    %edx,%eax
  801e82:	31 d2                	xor    %edx,%edx
  801e84:	83 c4 1c             	add    $0x1c,%esp
  801e87:	5b                   	pop    %ebx
  801e88:	5e                   	pop    %esi
  801e89:	5f                   	pop    %edi
  801e8a:	5d                   	pop    %ebp
  801e8b:	c3                   	ret    
  801e8c:	39 f0                	cmp    %esi,%eax
  801e8e:	0f 87 ac 00 00 00    	ja     801f40 <__umoddi3+0xfc>
  801e94:	0f bd e8             	bsr    %eax,%ebp
  801e97:	83 f5 1f             	xor    $0x1f,%ebp
  801e9a:	0f 84 ac 00 00 00    	je     801f4c <__umoddi3+0x108>
  801ea0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ea5:	29 ef                	sub    %ebp,%edi
  801ea7:	89 fe                	mov    %edi,%esi
  801ea9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ead:	89 e9                	mov    %ebp,%ecx
  801eaf:	d3 e0                	shl    %cl,%eax
  801eb1:	89 d7                	mov    %edx,%edi
  801eb3:	89 f1                	mov    %esi,%ecx
  801eb5:	d3 ef                	shr    %cl,%edi
  801eb7:	09 c7                	or     %eax,%edi
  801eb9:	89 e9                	mov    %ebp,%ecx
  801ebb:	d3 e2                	shl    %cl,%edx
  801ebd:	89 14 24             	mov    %edx,(%esp)
  801ec0:	89 d8                	mov    %ebx,%eax
  801ec2:	d3 e0                	shl    %cl,%eax
  801ec4:	89 c2                	mov    %eax,%edx
  801ec6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eca:	d3 e0                	shl    %cl,%eax
  801ecc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ed0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ed4:	89 f1                	mov    %esi,%ecx
  801ed6:	d3 e8                	shr    %cl,%eax
  801ed8:	09 d0                	or     %edx,%eax
  801eda:	d3 eb                	shr    %cl,%ebx
  801edc:	89 da                	mov    %ebx,%edx
  801ede:	f7 f7                	div    %edi
  801ee0:	89 d3                	mov    %edx,%ebx
  801ee2:	f7 24 24             	mull   (%esp)
  801ee5:	89 c6                	mov    %eax,%esi
  801ee7:	89 d1                	mov    %edx,%ecx
  801ee9:	39 d3                	cmp    %edx,%ebx
  801eeb:	0f 82 87 00 00 00    	jb     801f78 <__umoddi3+0x134>
  801ef1:	0f 84 91 00 00 00    	je     801f88 <__umoddi3+0x144>
  801ef7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801efb:	29 f2                	sub    %esi,%edx
  801efd:	19 cb                	sbb    %ecx,%ebx
  801eff:	89 d8                	mov    %ebx,%eax
  801f01:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f05:	d3 e0                	shl    %cl,%eax
  801f07:	89 e9                	mov    %ebp,%ecx
  801f09:	d3 ea                	shr    %cl,%edx
  801f0b:	09 d0                	or     %edx,%eax
  801f0d:	89 e9                	mov    %ebp,%ecx
  801f0f:	d3 eb                	shr    %cl,%ebx
  801f11:	89 da                	mov    %ebx,%edx
  801f13:	83 c4 1c             	add    $0x1c,%esp
  801f16:	5b                   	pop    %ebx
  801f17:	5e                   	pop    %esi
  801f18:	5f                   	pop    %edi
  801f19:	5d                   	pop    %ebp
  801f1a:	c3                   	ret    
  801f1b:	90                   	nop
  801f1c:	89 fd                	mov    %edi,%ebp
  801f1e:	85 ff                	test   %edi,%edi
  801f20:	75 0b                	jne    801f2d <__umoddi3+0xe9>
  801f22:	b8 01 00 00 00       	mov    $0x1,%eax
  801f27:	31 d2                	xor    %edx,%edx
  801f29:	f7 f7                	div    %edi
  801f2b:	89 c5                	mov    %eax,%ebp
  801f2d:	89 f0                	mov    %esi,%eax
  801f2f:	31 d2                	xor    %edx,%edx
  801f31:	f7 f5                	div    %ebp
  801f33:	89 c8                	mov    %ecx,%eax
  801f35:	f7 f5                	div    %ebp
  801f37:	89 d0                	mov    %edx,%eax
  801f39:	e9 44 ff ff ff       	jmp    801e82 <__umoddi3+0x3e>
  801f3e:	66 90                	xchg   %ax,%ax
  801f40:	89 c8                	mov    %ecx,%eax
  801f42:	89 f2                	mov    %esi,%edx
  801f44:	83 c4 1c             	add    $0x1c,%esp
  801f47:	5b                   	pop    %ebx
  801f48:	5e                   	pop    %esi
  801f49:	5f                   	pop    %edi
  801f4a:	5d                   	pop    %ebp
  801f4b:	c3                   	ret    
  801f4c:	3b 04 24             	cmp    (%esp),%eax
  801f4f:	72 06                	jb     801f57 <__umoddi3+0x113>
  801f51:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f55:	77 0f                	ja     801f66 <__umoddi3+0x122>
  801f57:	89 f2                	mov    %esi,%edx
  801f59:	29 f9                	sub    %edi,%ecx
  801f5b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f5f:	89 14 24             	mov    %edx,(%esp)
  801f62:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f66:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f6a:	8b 14 24             	mov    (%esp),%edx
  801f6d:	83 c4 1c             	add    $0x1c,%esp
  801f70:	5b                   	pop    %ebx
  801f71:	5e                   	pop    %esi
  801f72:	5f                   	pop    %edi
  801f73:	5d                   	pop    %ebp
  801f74:	c3                   	ret    
  801f75:	8d 76 00             	lea    0x0(%esi),%esi
  801f78:	2b 04 24             	sub    (%esp),%eax
  801f7b:	19 fa                	sbb    %edi,%edx
  801f7d:	89 d1                	mov    %edx,%ecx
  801f7f:	89 c6                	mov    %eax,%esi
  801f81:	e9 71 ff ff ff       	jmp    801ef7 <__umoddi3+0xb3>
  801f86:	66 90                	xchg   %ax,%ax
  801f88:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f8c:	72 ea                	jb     801f78 <__umoddi3+0x134>
  801f8e:	89 d9                	mov    %ebx,%ecx
  801f90:	e9 62 ff ff ff       	jmp    801ef7 <__umoddi3+0xb3>
