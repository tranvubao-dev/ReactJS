//
//  NewPlayerLandScapeViewController.m
//  NewMobileApp
//
//  Created by Bao on 18/03/2022.
//  Copyright © 2022 pioneer. All rights reserved.
//

#import "NewPlayerLandScapeViewController.h"
#import "DeckDefinition.h"
#import "DJSystemFunctionHolder.h"
#import "PlayerDef.h"
#import "ColorDef.h"
#import "SamplerPackDef.h"
#import "PlayerViewController.h"
#import "WaveLoudViewLandscape.h"
#import "DJSystemFunctionHolder.h"
#import "PlayerHotCueView.h"
#import "PlayerDelegateFunction.h"
#import "BLEViewController.h"
#import "UIAlertController+Create.h"
#import "UIViewController+Hierarchy.h"
#import "DeckButton_Common.h"
#import "DeckButton_Various.h"
#import "JogbCommonView.h"
#import "DeckButton_PerfAndCtrl.h"
#import "PerformanceHeaderView.h"
#import "PerformanceHotCueView.h"
#import "PerformanceLoopView.h"
#import "PerformanceSamplerView.h"
#import "PerformanceFxPadView.h"
#import "DeckDJSystemUpdateCUE.h"
#import "DeckDJSystemNotifyUpdateGUI.h"
#import "DeckDJSystemUpdateGUI.h"
#import "PerformanceEQView.h"
#import "PlayerStateRepository.h"
#import "DeckDJSystemNotifyChangeConnectedDevice.h"
#import "DeviceConnectedBottomButtonsViewController.h"
#import "MemoryCueView.h"
#import "CFXView.h"
#import "BeatFXView.h"
#import "SamplerDefinition.h"
#import "TrackingManager.h"
#import "HotCueEditViewController.h"
#import "LeftHotCueViewController.h"
#import "RightHotCueViewController.h"
#import "AlertManager.h"
#import "PlayerGridView.h"
#import "AlertView.h"
#import "DeviceNotifications.h"
#import "PlayerNotifications.h"
#import "SamplerViewTags.h"
#import "CommonDefinition.h"
#ifndef LEVELMETER
#import "LevelMeterView.h"
#endif

@interface NewPlayerLandScapeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *fxLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *fxRightButton;
@property (weak, nonatomic) IBOutlet UIButton *padLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *padRightButton;
@property (weak, nonatomic) IBOutlet UIButton *smartFaderMixerButton;
@property (weak, nonatomic) IBOutlet UIButton *samplerButton;
@property (strong, nonatomic) IBOutlet UILabel *trackTitleLeftLabel;
@property (strong, nonatomic) IBOutlet UILabel *trackArtistLeftLabel;
@property (strong, nonatomic) IBOutlet UILabel *trackBpmLeftLabel;
@property (strong, nonatomic) IBOutlet UILabel *trackTitleRightLabel;
@property (strong, nonatomic) IBOutlet UILabel *trackArtistRightLabel;
@property (strong, nonatomic) IBOutlet UILabel *trackBpmRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackKeyLLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackKeyRLabel;
@property (strong, nonatomic) IBOutlet UIView *bpmLeftView;
@property (strong, nonatomic) IBOutlet UIView *bpmRightView;
@property (weak, nonatomic) IBOutlet UISlider *crossFader;
@property (nonatomic) UIDeviceOrientation currentDeviceOrientation;
@property (strong, nonatomic) IBOutlet UIImageView *trackArtWorkLeftImageView;
@property (strong, nonatomic) IBOutlet UIImageView *trackArtWorkRightImageView;
@property (strong, nonatomic) IBOutlet UIView *centerBottomView;
@property (weak, nonatomic) IBOutlet UIView *sliderBottomView;
@property (weak, nonatomic) IBOutlet UILabel *timePlayingALabel;
@property (weak, nonatomic) IBOutlet UILabel *timePlayingBLabel;
@property (nonatomic, strong)UILabel* TempoBpmLabel1_;
@property (nonatomic, strong)UILabel* TempoBpmLabel2_;
@property (weak, nonatomic) IBOutlet UILabel *TempoPlaySpeedLeftLabel_;
@property (weak, nonatomic) IBOutlet UILabel *TempoPlaySpeedRightLabel_;
@property (weak, nonatomic) IBOutlet UIButton *btnSyncLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnSyncRight;
@property (weak, nonatomic) IBOutlet UIView *disconnectedBottomButtons;
@property (weak, nonatomic) IBOutlet UIButton *headphoneLeft;
@property (weak, nonatomic) IBOutlet UIButton *headphoneRight;
@property (weak, nonatomic) IBOutlet UIButton *sliderLButton;
@property (weak, nonatomic) IBOutlet UIButton *sliderRButton;
@property (weak, nonatomic) IBOutlet UIView *levelMeter;
@property (weak, nonatomic) IBOutlet UIView *tempoLButton;
@property (weak, nonatomic) IBOutlet UIView *tempoRButton;
@property IBOutlet UIButton *masterRightButton;
@property IBOutlet UIButton *masterLeftButton;
@property (weak, nonatomic) IBOutlet UIView *safeBottomPaddingArea;
@property (weak, nonatomic) IBOutlet UIView *safeLeftPaddingArea;
@property (weak, nonatomic) IBOutlet UIView *safeRightPaddingArea;

@end

static NewPlayerLandScapeViewController* sharedInstance;

@implementation NewPlayerLandScapeViewController {
    IBOutlet PlayerGridView *playerGridView;
    IBOutlet MixerLeftView      *mixerLeftView;
    IBOutlet MixerRightView     *mixerRightView;
    IBOutlet LoopLeftView       *loopLeftView;
    IBOutlet LoopRightView      *loopRightView;
    IBOutlet HotCueRightView    *cueRightView;
    IBOutlet HotCueLeftView     *cueLeftView;
    IBOutlet BeatJumpLeftView   *beatJumpLeftView;
    IBOutlet BeatJumpRightView  *beatJumpRightView;
    IBOutlet PerformancePadLeft        *performancePadLeftView;
    IBOutlet PerformancePadRight       *performancePadRightView;
    IBOutlet SamplerView                *samplerView;
    IBOutlet SamplerTableView           *samplerTableView;
    IBOutlet SelectSamplerView          *selectSamplerView;
    IBOutlet MasterTempoLeftView           *masterTempoLeftView;
    IBOutlet MasterTempoRightView          *masterTempoRightView;
    IBOutlet CFXComboboxTableView       *cfxLeftHorizontalTableView;
    IBOutlet CFXComboboxTableView       *cfxRightHorizontalTableView;
    IBOutlet CFXComboboxTableView       *cfxLeftJogTableView;
    IBOutlet CFXComboboxTableView       *cfxRightJogTableView;
    
    NSArray <NSNumber *>    *beats;
    int     nameBeatFxL;
    int     valueBeatFxL;
    BOOL    styleBeatOpenL;
    int     sliderBeatFxL;
    int     nameBeatFxR;
    int     valueBeatFxR;
    BOOL    styleBeatOpenR;
    int     sliderBeatFxR;
    
    CGFloat ModeChangeAnimationTime_;
    float zoomWaveRangeA;
    float zoomWaveRangeB;
    float zoomWaveRangeAB;
    __weak IBOutlet WaveLoudViewLandscape *deck1LoudWaveViewLandscape;
    __weak IBOutlet WaveLoudViewLandscape *deck2LoudWaveViewLandscape;
    NSMutableArray <NSNumber *> *listCueArrayRight;
    NSMutableArray <NSNumber *> *listCueArrayLeft;
    bool typeHotCueRight;
    bool typeHotCueLeft;
    unsigned short preNumerator;
    unsigned short preDenominator;
    NSTimer *StateConfirmTimer_;
    NSTimer *playingTimer_;
    int PrevPos_A;
    int PrevBackPos_A;
    int PrevPos_B;
    int PrevBackPos_B;
    NSInteger   BackPlayTime_;
    NSUInteger  PrevTempoRange1_;
    NSUInteger  PrevTempoRange2_;
    NSTimer *JogRotationTimer_;
    BOOL isJogAnimation_;
    unsigned int PrevBeatTm1_;
    unsigned int PrevBeatTm2_;
    UIView *sliderView;
    UIImage *nonCoverArtImg_;
    IBOutlet FXPanelLeft *fxPanelLeftView;
    IBOutlet FXPanelRight *fxPanelRightView;
    IBOutlet SmartFaderMixer *smartFaderMixerView;
    IBOutlet SmartFaderMixerLeft *smartFaderMixerLeftView;
    IBOutlet SmartFaderMixerRight *smartFaderMixerRightView;
    IBOutlet UIView *dropListLeftView;
    IBOutlet UIView *dropListRightView;
    UIButton *autoButton;
    UIButton *manualButton;
    NSLayoutConstraint *heightSamplerView;
    NSLayoutConstraint *heightSamplerEditView;
    MemoryCueView *_memoryCueLeftView;
    MemoryCueView *_memoryCueRightView;
    CFXView *_cfxView;
    BeatFXView *_beatFXView;
    
    IBOutlet ComboboxView *typeFxLeftCombobox;
    IBOutlet ComboboxView *typeFxRightCombobox;
    IBOutlet ComboboxView *beatFxRightCombobox;
    IBOutlet ComboboxView *beatFxLeftCombobox;
    
    IBOutlet ComboboxView *colorFxCombobox;

    CGRect _leftOpenedHotCueButtonFrame;
    CGRect _rightOpenedHotCueButtonFrame;
    
    HotCueEditViewController *_leftEditHotCueViewController;
    HotCueEditViewController *_rightEditHotCueViewController;
    
    NSTimer *colorFxTimer;
    UITextField *bpmLTextField;
    UITextField *bpmRTextField;
    UIView *OriginalLeftView;
    UIView *OriginalRightView;
    LevelMeterView *levelMeterView1_;
    LevelMeterView *levelMeterView2_;
    __weak IBOutlet UIView *levelMeter1;
    __weak IBOutlet UIView *levelMeter2;

    ComboboxView *_switchingBeatReleseFXCombobox;
    ComboboxView *_beatFxValueSelectCombobox;
    ComboboxView *_connectedBeatFXComboBox;
    NSTimer *_connectedBeatFXTimer;
    NSTimer *_connectedBeatFXBeatTimer;
    NSTimer *_connectedBeatFXModeTimer;
    BOOL _isUsingBeatFx;
}

@synthesize DisplayMode_, DJSystemFunction_, PrevPlayState1_, PrevPlayState2_, SlicerBackGroundPlaying1_, SlicerBackGroundPlaying2_, isScratching1_, isScratching2_, JogbView_, coverArtColor1_, coverArtColor2_;

@synthesize LoudView1_ = deck1LoudWaveViewLandscape;
@synthesize LoudView2_ = deck2LoudWaveViewLandscape;

+ (NewPlayerLandScapeViewController *)sharedInstance {
    @synchronized(self){
        
        if (!sharedInstance) {
            sharedInstance = [[NewPlayerLandScapeViewController alloc] init];
        }
    }
    return sharedInstance;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self supportedInterfaceOrientations];
    
    self.DJSystemFunction_ = [DJFunc getDJSystemFunction];
    [DJFunc addDelegate:(id<DJSystemFunctionDelegate>)self];
    [DJFunc addDelegate:(id<DJSystemFunctionDelegate>)PlayerDelegateFunc];
    
    nameBeatFxL     = ZeroValue;
    valueBeatFxL    = ZeroValue;
    sliderBeatFxL   = ValueSlider;
    nameBeatFxR     = ZeroValue;
    valueBeatFxR    = ZeroValue;
    sliderBeatFxR   = ValueSlider;
    
    _tempoLButton.layer.borderWidth = 1;
    _tempoLButton.layer.borderColor = kColor_BeatJumpOFF.CGColor;
    _tempoLButton.layer.cornerRadius = 3;
    _tempoRButton.layer.borderWidth = 1;
    _tempoRButton.layer.borderColor = kColor_BeatJumpOFF.CGColor;
    _tempoRButton.layer.cornerRadius = 3;
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Flag_Display_Landscape];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Flag_Display_Portrait];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Set_Up_Jog];
    
    sharedInstance = self;
    zoomWaveRangeA = 2000.0f;
    zoomWaveRangeB = 2000.0f;
    zoomWaveRangeAB = 2000.0f;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLoudWaveLoopPoint) name:UpdateLoudWaveLoopPoint object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jogAnimationOnOff:) name:kPreferenceNotificationJogAnimationChanged object:nil];
    
    // Notification of SamplerViewController
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapButtonSamplerObj:) name:kSamplerTabButtonsNotification object:nil];
    
    _PhraseArray1 = [[NSMutableArray alloc] init];
    _PhraseArray2 = [[NSMutableArray alloc] init];
    
    [self setUpTapGesture];
    
    isJogAnimation_ = JOG_ANIMATION;
    isJogAnimation_ = [[PreferenceManager sharedManager] isOnJogAnimation];
    PrevTempoRange1_ = 0;
    PrevTempoRange2_ = 0;
    DisplayMode_ = JOG;
    beats = @[@1, @4, @8, @16];
    
    [self initAllView];
    [self setupMixerLandscape];
    [self setupSongInfor];
    [self setupWaveViewLandscape];
    [self setupHotCueLandscape];
    [self setupSlider];
    
    if (!playingTimer_) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            self->playingTimer_ = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(playingTimer:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self->playingTimer_ forMode:NSRunLoopCommonModes];
        });
    }
    
    [self setupPadFx];
    
    [[DJSystemFunctionHolder sharedManager] addDelegate:self];
    
    _LoopInTime1_ = -1;
    _LoopInTime2_ = -1;
    _LoopOutTime1_ = -1;
    _LoopOutTime2_ = -1;
    
    ModeChangeAnimationTime_ = 0.0f;
    
    coverArtColor1_ = kColor_CoverArt_Magenta;
    coverArtColor2_ = kColor_CoverArt_Cyan;
    
    _LoopDict1_ = [@{@"Loop1":NSLocalizedString(@"Beat1Slash16", nil),
                     @"Loop2":NSLocalizedString(@"Beat1Slash8", nil),
                     @"Loop3":NSLocalizedString(@"Beat1Slash4", nil),
                     @"Loop4":NSLocalizedString(@"Beat1Slash2", nil),
                     @"Loop5":NSLocalizedString(@"Beat1", nil),
                     @"Loop6":NSLocalizedString(@"Beat2", nil),
                     @"Loop7":NSLocalizedString(@"Beat4", nil),
                     @"Loop8":NSLocalizedString(@"Beat8", nil)} mutableCopy];
    
    _LoopDict2_ = [@{@"Loop1":NSLocalizedString(@"Beat1Slash16", nil),
                     @"Loop2":NSLocalizedString(@"Beat1Slash8", nil),
                     @"Loop3":NSLocalizedString(@"Beat1Slash4", nil),
                     @"Loop4":NSLocalizedString(@"Beat1Slash2", nil),
                     @"Loop5":NSLocalizedString(@"Beat1", nil),
                     @"Loop6":NSLocalizedString(@"Beat2", nil),
                     @"Loop7":NSLocalizedString(@"Beat4", nil),
                     @"Loop8":NSLocalizedString(@"Beat8", nil)} mutableCopy];
    
    _FxPadDict1_ = [@{@"Fx1"    :NSLocalizedString(@"FXRoll", nil),
                      @"FxVal1" :NSLocalizedString(@"Beat1Slash2", nil),
                      @"Fx2"    :@"SWEEP",
                      @"FxVal2" :NSLocalizedString(@"Percent80", nil),
                      @"Fx3"    :NSLocalizedString(@"FXFlanger", nil),
                      @"FxVal3" :NSLocalizedString(@"Beat16Slash1", nil),
                      @"Fx4"    :@"V.BRAKE",
                      @"FxVal4" :NSLocalizedString(@"Beat3Slash4", nil),
                      @"Fx5"    :NSLocalizedString(@"FXEcho", nil),
                      @"FxVal5" :NSLocalizedString(@"Beat1Slash4", nil),
                      @"Fx6"    :NSLocalizedString(@"FXEcho", nil),
                      @"FxVal6" :NSLocalizedString(@"Beat1Slash2", nil),
                      @"Fx7"    :NSLocalizedString(@"FXReverb", nil),
                      @"FxVal7" :NSLocalizedString(@"Percent60", nil),
                      @"Fx8"    :@"R.ECHO",
                      @"FxVal8" :NSLocalizedString(@"Beat1Slash2", nil)} mutableCopy];
    
    _FxPadDict2_ = [@{@"Fx1"    :NSLocalizedString(@"FXRoll", nil),
                      @"FxVal1" :NSLocalizedString(@"Beat1Slash2", nil),
                      @"Fx2"    :@"SWEEP",
                      @"FxVal2" :NSLocalizedString(@"Percent80", nil),
                      @"Fx3"    :NSLocalizedString(@"FXFlanger", nil),
                      @"FxVal3" :NSLocalizedString(@"Beat16Slash1", nil),
                      @"Fx4"    :@"V.BRAKE",
                      @"FxVal4" :NSLocalizedString(@"Beat3Slash4", nil),
                      @"Fx5"    :NSLocalizedString(@"FXEcho", nil),
                      @"FxVal5" :NSLocalizedString(@"Beat1Slash4", nil),
                      @"Fx6"    :NSLocalizedString(@"FXEcho", nil),
                      @"FxVal6" :NSLocalizedString(@"Beat1Slash2", nil),
                      @"Fx7"    :NSLocalizedString(@"FXReverb", nil),
                      @"FxVal7" :NSLocalizedString(@"Percent60", nil),
                      @"Fx8"    :@"R.ECHO",
                      @"FxVal8" :NSLocalizedString(@"Beat1Slash2", nil)} mutableCopy];
    
    _PerformancePanelArray1_ = [[NSMutableArray alloc] init];
    _PerformancePanelArray2_ = [[NSMutableArray alloc] init];
    
    NSUInteger tm = static_cast<NSUInteger>((int) [[NSUserDefaults standardUserDefaults] integerForKey:kJogWazeZoom1]);
    _JogZoomWaveTime1_ = tm;
    tm = static_cast<NSUInteger>((int) [[NSUserDefaults standardUserDefaults] integerForKey:kJogWazeZoom2]);
    _JogZoomWaveTime2_ = tm;
    
    _DeckBtnCommon = [[DeckButton_Common alloc] init];
    _DeckBtnVarious = [[DeckButton_Various alloc] init];
    _DeckBtnGrid = [[DeckButton_Grid alloc] init];
    _DeckBtnPerfAndCtrl = [[DeckButton_PerfAndCtrl alloc] init];
    _DeckSliderCommon = [[DeckSlider_Common alloc] init];
    
    _JogWcView1_ = [[JogWcView alloc] init];
    _JogWcView1_.hidden = YES;
    _JogWcView2_ = [[JogWcView alloc] init];
    _JogWcView2_.hidden = YES;
    
    [self.view addSubview:_JogWcView1_];
    [self.view addSubview:_JogWcView2_];
    
    NSDictionary *dict = @{
        // 起動時の画面[JOG/横/縦]
        kStandaloneDisplayMode: @(JOG),
        // DDJ-200接続時の画面[JOG/横/縦]
        kWannabeDisplayMode: @(HORIZONTALWAVE),
        // 時間表示[NO/YES]
        kTimeDisplayMode1: @NO,
        kTimeDisplayMode2: @NO,
        // MasterTempo[NO/YES]
        kMasterTempoMode1: @YES,
        kMasterTempoMode2: @YES,
        // 縦拡大波形倍率[625/1250/2500/5000/10000]
        kVerticalWazeZoom1: @2500,
        kVerticalWazeZoom2: @2500,
        // 横拡大波形倍率[1125/2250/4500/9000/18000]
        kHorizontalWazeZoom1: @4500,
        kHorizontalWazeZoom2: @4500,
        // JOG拡大波形倍率[1125/2250/4500/9000/18000]
        kJogWazeZoom1: @4500,
        kJogWazeZoom2: @4500,
        // Tempo/Bpm Edit View
        kTempoBpmEditView1: @(TEMPO_EDIT),
        kTempoBpmEditView2: @(TEMPO_EDIT),
        // Performanceパネル
        // 初期チェックパネルなし
        kPerformancePanele11: @(PERFORMANCE_VIEW),
        kPerformancePanele21: @(PERFORMANCE_VIEW),
        kWannabeLoopPanele11: @(PERFORMANCE_LOOP),
        kWannabeLoopPanele21: @(PERFORMANCE_LOOP),
        // AutoLoop拍
        kLoopBeat1: NSLocalizedString(@"Beat4", nil),
        kLoopBeat2: NSLocalizedString(@"Beat4", nil),
        // Loopパネル
        kLoopPanel1: _LoopDict1_,
        kLoopPanel2: _LoopDict2_,
        // X-Yパネル[FX:ECHO/CFX:FILTER]
        kXYFX1: @0,
        kXYCFX1: @0,
        kXYFX2: @0,
        kXYCFX2: @0,
        // FX Padパネル
        kFxPad1: _FxPadDict1_,
        kFxPad2: _FxPadDict2_,
        // SamplerPack
        kSamplerPack1: @0,
        kSamplerPack2: @0,
        // SamplerVolume
        kSamplerVolume: @1.0,
        // TrimKnob
        kTrimKnob1: @0.0,
        kTrimKnob2: @0.0,
        kWeGOPRFMVOL1: @0,
        kWeGOPRFMVOL2: @0,
        kTransitionFxFilter: @"FILTER MIX",
        // WeGO PerformancePanel Trim/SamplerVol[NO:SamplerVol]
        kWeGOPRFMTrim1: @NO,
        kWeGOPRFMTrim2: @NO,
    };
    [[NSUserDefaults standardUserDefaults] registerDefaults:dict];
    
    [self setupUI];
    
    [self updateWithDeviceConnectionState];
    
    [self setupColorFxComboboxBlockTimer];
}

#pragma mark - viewDidLayoutSubviews

- (void)viewDidLayoutSubviews {
    [self resizeObject];
}

#pragma mark - viewWillAppear

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIViewController attemptRotationToDeviceOrientation];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    self.currentDeviceOrientation = [[UIDevice currentDevice] orientation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLoudWaveCurrentCueView) name:UpdateLoudWaveCurrentCueView object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLoudWaveLoopPoint) name:UpdateLoudWaveLoopPoint object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jogAnimationOnOff:) name:kPreferenceNotificationJogAnimationChanged object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trimVolumeSlider:) name:@"TrimVolumeSlider" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(samplerVolumeSlider:) name:@"SamplerVolumeSlider" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waveColorChange:) name:kPreferenceNotificationWaveColorChanged object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointSyncChange:) name:kPreferenceNotificationDeckCuePointJumpChanged object:nil];
    
    //Change loop View
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnClickedChangeLoopL) name:@"DidTapChangeLoopLeftButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnClickedChangeLoopR) name:@"DidTapChangeLoopRightButton" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openConnectedBeatFXComboBox:) name:kOpenConnectedBeatFXComboBoxNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeConnectedBeatFXComboBox:) name:kCloseConnectedBeatFXComboBoxNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openConnectedBeatFXBeatComboBox:) name:kOpenConnectedBeatFXBeatComboBoxNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeConnectedBeatFXBeatComboBox:) name:kCloseConnectedBeatFXBeatComboBoxNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openConnectedBeatFXModeComboBox:) name:kOpenConnectedBeatFXModeComboBoxNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeConnectedBeatFXModeComboBox:) name:kCloseConnectedBeatFXModeComboBoxNotification object:nil];
    
    [self setupHotCueLandscape];

    [self setupMixerLandscape];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Set_Wave_Half];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openBrowser:) name:kDeviceBrowserOpenViewNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadReleatedTracks:) name:kDeviceBrowserOpenRelatedTracksNotification object:nil];
}

- (void)deviceDidRotate:(NSNotification *)notification {
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        [self dismissViewControllerAnimated:NO completion:^{
            [self.delegatebrowser checkPushViewController];
        }];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Flag_Display_Landscape];  // Set flag wave draw
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Flag_Display_Portrait];
    }
}

#pragma mark - viewDidAppear

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [DJFunc getDJSystemFunction]->setZoomWaveWidth(PLAYER_A, static_cast<int>(self.view.frame.size.width * (float) [UIScreen mainScreen].scale));
    [DJFunc getDJSystemFunction]->setZoomWaveWidth(PLAYER_B, static_cast<int>(self.view.frame.size.width * (float) [UIScreen mainScreen].scale));
    [DJFunc getDJSystemFunction]->setZoomWaveRange(PLAYER_A, static_cast<int>(zoomWaveRangeA));
    [DJFunc getDJSystemFunction]->setZoomWaveRange(PLAYER_B, static_cast<int>(zoomWaveRangeB));
    if (!StateConfirmTimer_) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            self->StateConfirmTimer_ = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(stateConfirmTimer:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self->StateConfirmTimer_ forMode:NSRunLoopCommonModes];
        });
#ifndef CPUFUKA
        NSTimer *levelMeterTimer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(levelMeterTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:levelMeterTimer forMode:NSRunLoopCommonModes];
#endif // CPUFUKA
    }
    
    // JOGアニメーションタイマーが作動してなかったら作動
    if (!JogRotationTimer_) {
        if ([DJFunc getDJSystemFunction]->isLoaded(0) || [DJFunc getDJSystemFunction]->isLoaded(1)) {
            JogRotationTimer_ = [NSTimer timerWithTimeInterval:0.0167 target:self selector:@selector(jogRotationTimer:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:JogRotationTimer_ forMode:NSRunLoopCommonModes];
        }
    }
    if([[NSUserDefaults standardUserDefaults] boolForKey:Set_Up_Jog]) {
        [self setupJogView];
        [self setupView];
        [self setupCommonSettingView];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Set_Up_Jog];
    }
    [self setLoudWaveCurrentCueView];
    [self updatePlayHotcue: PLAYER_A];
    [self updatePlayHotcue: PLAYER_B];
    
    [self colorSetting:1];
    [self colorSetting:2];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:kOpenConnectedBeatFXComboBoxNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCloseConnectedBeatFXComboBoxNotification object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:kOpenConnectedBeatFXBeatComboBoxNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCloseConnectedBeatFXBeatComboBoxNotification object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDeviceBrowserOpenViewNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDeviceBrowserOpenRelatedTracksNotification object:nil];
}

#pragma mark - viewDidDisappear
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (StateConfirmTimer_) {
        [StateConfirmTimer_ invalidate];
        StateConfirmTimer_ = nil;
    }
}

#pragma mark - viewWillLayoutSubviews
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self updateSafeArea];
}

- (void)updateSafeArea {
    CGFloat SafeAreaInsets_Top_      = SAFE_AREA_INSETS;
    CGFloat SafeAreaInsets_Bottom_   = SAFE_AREA_INSETS;
    CGFloat SafeAreaInsets_Left_     = SAFE_AREA_INSETS;
    CGFloat SafeAreaInsets_Right_    = SAFE_AREA_INSETS;
    
    if (@available(iOS 11, *)) {
        
        UIEdgeInsets safeArea = self.view.safeAreaInsets;
        SafeAreaInsets_Top_ = safeArea.top;
        SafeAreaInsets_Bottom_ = safeArea.bottom;
        SafeAreaInsets_Left_ = safeArea.left;
        SafeAreaInsets_Right_ = safeArea.right;
        
        _safeAreaTop = SafeAreaInsets_Top_;
        _safeAreaBottom = SafeAreaInsets_Bottom_;
        _safeAreaLeft = SafeAreaInsets_Left_;
        _safeAreaRight = SafeAreaInsets_Right_;
    }
    
    _SafeArea_ = (SafeAreaInsets_Left_ > 0 || SafeAreaInsets_Top_ > 0);
    
    if ([[UIScreen mainScreen] bounds].size.width > [[UIScreen mainScreen] bounds].size.height) {
        _MainScreenSizeWidth_ = [[UIScreen mainScreen] bounds].size.width - (SafeAreaInsets_Left_ + SafeAreaInsets_Right_);
        _MainScreenSizeHeight_ = [[UIScreen mainScreen] bounds].size.height - (SafeAreaInsets_Top_ + SafeAreaInsets_Bottom_);
    } else {
        _MainScreenSizeWidth_ = [[UIScreen mainScreen] bounds].size.height - (SafeAreaInsets_Left_ + SafeAreaInsets_Right_);
        _MainScreenSizeHeight_ = [[UIScreen mainScreen] bounds].size.width - (SafeAreaInsets_Top_ + SafeAreaInsets_Bottom_);
    }
    
    _ScreenSize_ = {_MainScreenSizeWidth_, _MainScreenSizeHeight_};
}

#pragma mark - init View
- (void) initAllView {
    playerGridView      = [[PlayerGridView alloc] init];
    listCueArrayRight   = [[NSMutableArray alloc] init];
    listCueArrayLeft    = [[NSMutableArray alloc] init];
    mixerLeftView       = [[MixerLeftView alloc] init];
    mixerRightView      = [[MixerRightView alloc] init];
    loopLeftView        = [[LoopLeftView alloc] init];
    loopRightView       = [[LoopRightView alloc] init];
    cueRightView        = [[HotCueRightView alloc] init];
    cueLeftView         = [[HotCueLeftView alloc] init];
    beatJumpLeftView    = [[BeatJumpLeftView alloc] init];
    beatJumpRightView   = [[BeatJumpRightView alloc] init];
    performancePadLeftView   = [[PerformancePadLeft alloc] init];
    performancePadRightView  = [[PerformancePadRight alloc] init];
    fxPanelLeftView     = [[FXPanelLeft alloc] init];
    fxPanelRightView    = [[FXPanelRight alloc] init];
    smartFaderMixerView = [[SmartFaderMixer alloc] init];
    smartFaderMixerLeftView = [[SmartFaderMixerLeft alloc] init];
    smartFaderMixerRightView = [[SmartFaderMixerRight alloc] init];
    samplerView         =   [[SamplerView alloc] init];
    samplerTableView    = [[SamplerTableView alloc] init];
    selectSamplerView   = [[SelectSamplerView alloc] init];
    masterTempoLeftView = [[MasterTempoLeftView alloc] init];
    masterTempoRightView = [[MasterTempoRightView alloc] init];
    cfxLeftHorizontalTableView = [[CFXComboboxTableView alloc] init];
    cfxRightHorizontalTableView = [[CFXComboboxTableView alloc] init];
    cfxLeftJogTableView = [[CFXComboboxTableView alloc] init];
    cfxRightJogTableView = [[CFXComboboxTableView alloc] init];
    levelMeterView1_ = [[LevelMeterView alloc] init];
    levelMeterView2_ = [[LevelMeterView alloc] init];
}

#pragma mark - setupUI

- (void) setupUI {
    [self updateSafeArea];

    _openedLeftHotCueEditViewHotCueID = -1;
    _openedRightHotCueEditViewHotCueID = -1;
    
    _connectedBottomButtons = [[DeviceConnectedBottomButtonsViewController alloc] initWithNibName:@"DeviceConnectedBottomButtons" bundle:nil];
    _connectedBottomButtons.view.hidden = NO;
    [self.view addSubview:_connectedBottomButtons.view];
    
    _memoryCueLeftView = [[MemoryCueView alloc] initWithNibName:@"MemoryCueView" bundle:nil];
    _memoryCueLeftView.view.hidden = NO;
    _memoryCueLeftView.view.layer.borderWidth = 1.0f;
    _memoryCueLeftView.view.layer.borderColor = kColorGray.CGColor;
    [self.view addSubview:_memoryCueLeftView.view];
    
    _memoryCueLeftView.view.translatesAutoresizingMaskIntoConstraints = NO;
    [_memoryCueLeftView.view.topAnchor constraintEqualToAnchor:_tempoLButton.topAnchor constant:0.0f].active=YES;
    [_memoryCueLeftView.view.leadingAnchor constraintEqualToAnchor:_tempoLButton.trailingAnchor constant:10.0f].active = YES;
    [_memoryCueLeftView.view.bottomAnchor constraintEqualToAnchor:_tempoLButton.bottomAnchor constant:0.0f].active = YES;
    [_memoryCueLeftView.view.trailingAnchor constraintEqualToAnchor:_levelMeter.leadingAnchor constant: 0.0f].active = YES;
    
    
    _memoryCueRightView = [[MemoryCueView alloc] initWithNibName:@"MemoryCueView" bundle:nil];
    _memoryCueRightView.view.hidden = NO;
    _memoryCueRightView.view.layer.borderWidth = 1.0f;
    _memoryCueRightView.view.layer.borderColor = kColorGray.CGColor;
    [self.view addSubview:_memoryCueRightView.view];
    
    _memoryCueRightView.view.translatesAutoresizingMaskIntoConstraints = NO;
    [_memoryCueRightView.view.topAnchor constraintEqualToAnchor:_tempoRButton.topAnchor constant:0.0f].active = YES;
    [_memoryCueRightView.view.trailingAnchor constraintEqualToAnchor:_tempoRButton.leadingAnchor constant:-10.0f].active = YES;
    [_memoryCueRightView.view.leadingAnchor constraintEqualToAnchor:_levelMeter.trailingAnchor constant:0.0f].active = YES;
    [_memoryCueRightView.view.bottomAnchor constraintEqualToAnchor:_tempoLButton.bottomAnchor constant:0.0f].active = YES;
    
    _cfxView = [[CFXView alloc] init];
    [_cfxView createView];
    _cfxView.hidden = YES;
    [self.view addSubview:_cfxView];
    [_cfxView layoutIfNeeded];
    _cfxView.delegate = self;
    
    [_cfxView.trailingAnchor constraintGreaterThanOrEqualToAnchor:_baseJogView.leadingAnchor constant:10.0f].active = YES;
    
    [self setupColorFxCombobox];

    _beatFXView = [[BeatFXView alloc] init];
    [_beatFXView createView];
    _beatFXView.hidden = YES;
    [self.view addSubview:_beatFXView];
    [_beatFXView layoutIfNeeded];
//    _beatFXView.delegate = self;
    
    [_beatFXView.leadingAnchor constraintGreaterThanOrEqualToAnchor:_baseJogView.trailingAnchor constant:-10.0f].active = YES;
    
    _XyPadHold1_ = NO;
    _XyPadHold2_ = NO;
    _XyPadXval1_ = 0.0f;
    _XyPadXval2_ = 0.0f;
    _XyPadYval1_ = 0.0f;
    _XyPadYval2_ = 0.0f;
    _XyPadPointArray1_ = [[NSMutableArray alloc] init];
    _XyPadPointArray2_ = [[NSMutableArray alloc] init];
    _JogWannaBecView_ = [[JogWannaBecView alloc] init];
    _JogWannaBecView_.hidden = YES;
    _JogWannaBecView_.backgroundColor = kColor_Black;
    [self.view addSubview:_JogWannaBecView_];
    
    PerformanceHeaderView* pv11 = [[PerformanceHeaderView alloc] init];
    _PerformanceViewArray1_ = [@[pv11]mutableCopy];
    PerformanceHeaderView* pv21 = [[PerformanceHeaderView alloc] init];
    _PerformanceViewArray2_ = [@[pv21]mutableCopy];
    
    _PerformPullDownBackView_ = [[UIView alloc] initWithFrame:[UIScreen mainScreenBounds]];
    _PerformPullDownBackView_.backgroundColor = [UIColor clearColor];
    _PerformPullDownBackView_.hidden = YES;
    [self.view addSubview:_PerformPullDownBackView_];
    
    _DisplaySelectPullDownBackView_ = [[UIView alloc] initWithFrame:[UIScreen mainScreenBounds]];
    _DisplaySelectPullDownBackView_.backgroundColor = [UIColor clearColor];
    _DisplaySelectPullDownBackView_.hidden = YES;
    [self.view addSubview:_DisplaySelectPullDownBackView_];
    
    [_JogWannaBecView_ createView];
    
    [_PerformanceViewArray1_[0] createView:PERFORMANCE_LEFTTOP
                               performance:static_cast<NSUInteger>([[NSUserDefaults standardUserDefaults] integerForKey:kPerformancePanele11])];
    
    [_PerformanceViewArray2_[0] createView:PERFORMANCE_RIGHTTOP
                               performance:static_cast<NSUInteger>([[NSUserDefaults standardUserDefaults] integerForKey:kPerformancePanele21])];
    
    [self resizeObject];
}

- (void)setupColorFxCombobox {
    bool currentSmartCFXStatus = [DJFunc getDJSystemFunction] -> getSmartCFXStatus(); //1: ON - 0: OFF
    int currentSmartCFXPos = [DJFunc getDJSystemFunction] -> getSmartCFXCurrentPos();
    colorFxCombobox.delegateCombobox = self;
    colorFxCombobox = [[ComboboxView alloc] initWithData:_cfxView.cfxList scrollEnabled:NO selectHandler:^(NSInteger section, NSInteger index) {
        [DJFunc getDJSystemFunction] -> updateCfxNum(static_cast<int>(index));
        [self->_cfxView selectItem:index];
        [self->colorFxCombobox hidden:YES];
    } toggleHandler:^(BOOL open) {
        [self->_cfxView cFxComboboxHidden:open];
    }];
    colorFxCombobox.headers = _cfxView.cfxSectionList;
    [colorFxCombobox setDisabledSections:@[[NSNumber numberWithInteger:1]]]; //Disable SmartCFX interaction
    colorFxCombobox.showItemSelected = YES;
    colorFxCombobox.touchOutsideDismiss = YES;
    [self.view addSubview:colorFxCombobox];
    
    [_cfxView updateSmartCFXState:currentSmartCFXStatus];
    [colorFxCombobox setUserInteractionEnabled:!currentSmartCFXStatus];
    [colorFxCombobox setCurrentSelection:[NSIndexPath indexPathForRow: currentSmartCFXPos inSection: currentSmartCFXStatus ? 1 : 0]];
    [_cfxView selectItem:colorFxCombobox withIndex:currentSmartCFXPos];
    [colorFxCombobox hidden:YES];
}

- (void)setupColorFxComboboxBlockTimer {
    colorFxTimer = [NSTimer scheduledTimerWithTimeInterval: 2.0
                                                    target: self
                                                    selector:@selector(hideColorFxCombobox)
                                                    userInfo: nil repeats:NO];
}

#pragma mark - Connected Beat FX Combo Box

- (void)setupConnectedBeatFXComboBox {
    _isUsingBeatFx = YES;

    _connectedBeatFXComboBox = [[ComboboxView alloc] initWithData:_beatFXView.beatFXComboBoxData scrollEnabled:YES selectHandler:^(NSInteger section, NSInteger index) {
        [self->_beatFXView updateSelectedItem:index];
        [self hideConnectedBeatFXCombobox];
    } toggleHandler:^(BOOL open) {
    }];
    _connectedBeatFXComboBox.showItemSelected = YES;
    _connectedBeatFXComboBox.touchOutsideDismiss = YES;
    _connectedBeatFXComboBox.hidden = YES;
    [self.view addSubview:_connectedBeatFXComboBox];

    _beatFxValueSelectCombobox.delegateCombobox = self;
    _beatFxValueSelectCombobox = [[ComboboxView alloc] initWithData:_beatFXView.beatFXValueComboBoxData scrollEnabled:YES selectHandler:^(NSInteger section, NSInteger index) {
        [self->_beatFXView updateSelectedValue:index];
        [self hideConnectedBeatFXBeatCombobox];
    } toggleHandler:^(BOOL open) {
    }];
    _beatFxValueSelectCombobox.contentAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_beatFxValueSelectCombobox];
    [_beatFxValueSelectCombobox hidden:YES];

    //Switch BeatFX <-> ReleaseFX Combobox
    _switchingBeatReleseFXCombobox.delegateCombobox = self;
    _switchingBeatReleseFXCombobox = [[ComboboxView alloc] initWithData:@[@[NSLocalizedString(@"BeatFX", nil),NSLocalizedString(@"FXPnlChangeRFX", nil)]] scrollEnabled:NO selectHandler:^(NSInteger section, NSInteger index) {
        self->_isUsingBeatFx = index == 0;
        [self->_beatFXView changeType:self->_isUsingBeatFx];
        [self hideConnectedBeatFXModeCombobox];
        if (self->_isUsingBeatFx) {
            self->_connectedBeatFXComboBox.comboboxData = self->_beatFXView.beatFXComboBoxData;
            self->_beatFxValueSelectCombobox.comboboxData = self->_beatFXView.beatFXValueComboBoxData;
        } else {
            self->_connectedBeatFXComboBox.comboboxData = self->_beatFXView.releaseFXComboboxData;
            self->_beatFxValueSelectCombobox.comboboxData = self->_beatFXView.releaseFXValueComboboxData;
        }
        [self->_switchingBeatReleseFXCombobox hidden:YES];
        [self->_connectedBeatFXComboBox reloadCombobox];
        [self->_beatFxValueSelectCombobox reloadCombobox];
        [self resizeObject];
    } toggleHandler:^(BOOL open) {
    }];
    [self.view addSubview:_switchingBeatReleseFXCombobox];
    [_switchingBeatReleseFXCombobox hidden:YES];
    
    [self resizeObject];
}

- (void)disposeConnectedBeatFXComboBox {
    if (_connectedBeatFXComboBox) {
        [self hideConnectedBeatFXCombobox];
        [_connectedBeatFXComboBox removeFromSuperview];
        _connectedBeatFXComboBox = nil;
    }
}

- (void)openConnectedBeatFXComboBox:(NSNotification *)notification {
    [self showConnectedBeatFXCombobox];
}

- (void)closeConnectedBeatFXComboBox:(NSNotification *)notification {
    [self hideConnectedBeatFXCombobox];
}

- (void)openConnectedBeatFXBeatComboBox:(NSNotification *)notification {
    [self showConnectedBeatFXBeatCombobox];
}

- (void)closeConnectedBeatFXBeatComboBox:(NSNotification *)notification {
    [self hideConnectedBeatFXBeatCombobox];
}

- (void)openConnectedBeatFXModeComboBox:(NSNotification *)notification {
    [self showConnectedBeatFXModeComboBox];
}

- (void)closeConnectedBeatFXModeComboBox:(NSNotification *)notification {
    [self hideConnectedBeatFXModeCombobox];
}

- (void)showConnectedBeatFXCombobox {
    [_connectedBeatFXComboBox reloadData];
    _connectedBeatFXComboBox.hidden = NO;
    [self autoHideConnectedBeatFXComboBox];
    [[NSNotificationCenter defaultCenter] postNotificationName:kConnectedBeatFXComboBoxNotificationOpened object:self];
}

- (void)autoHideConnectedBeatFXComboBox {
    if (_connectedBeatFXTimer.isValid) {
        [_connectedBeatFXTimer invalidate];
        _connectedBeatFXTimer = nil;
    }
    _connectedBeatFXTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hideConnectedBeatFXCombobox) userInfo:nil repeats:NO];
}

- (void)hideConnectedBeatFXCombobox {
    _connectedBeatFXComboBox.hidden = YES;
    if (_connectedBeatFXTimer.isValid) {
        [_connectedBeatFXTimer invalidate];
        _connectedBeatFXTimer = nil;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kConnectedBeatFXComboBoxNotificationClosed object:self];
}

- (void)showConnectedBeatFXBeatCombobox {
    [_beatFxValueSelectCombobox reloadData];
    [_beatFxValueSelectCombobox hidden:NO];
    [self autoHideConnectedBeatFXBeatComboBox];
    [[NSNotificationCenter defaultCenter] postNotificationName:kConnectedBeatFXBeatComboBoxNotificationOpened object:self];
}

- (void)autoHideConnectedBeatFXBeatComboBox {
    if (_connectedBeatFXBeatTimer.isValid) {
        [_connectedBeatFXBeatTimer invalidate];
        _connectedBeatFXBeatTimer = nil;
    }
    _connectedBeatFXBeatTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hideConnectedBeatFXBeatCombobox) userInfo:nil repeats:NO];
}

- (void)hideConnectedBeatFXBeatCombobox {
    _beatFxValueSelectCombobox.hidden = YES;
    if (_connectedBeatFXBeatTimer.isValid) {
        [_connectedBeatFXBeatTimer invalidate];
        _connectedBeatFXBeatTimer = nil;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kConnectedBeatFXBeatComboBoxNotificationClosed object:self];
}

- (void)showConnectedBeatFXModeComboBox {
    [_switchingBeatReleseFXCombobox reloadData];
    [_switchingBeatReleseFXCombobox hidden:NO];
    [self autoHideConnectedBeatFXModeComboBox];
    [[NSNotificationCenter defaultCenter] postNotificationName:kConnectedBeatFXModeComboBoxNotificationOpened object:self];
}

- (void)autoHideConnectedBeatFXModeComboBox {
    if (_connectedBeatFXModeTimer.isValid) {
        [_connectedBeatFXModeTimer invalidate];
        _connectedBeatFXModeTimer = nil;
    }
    _connectedBeatFXModeTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hideConnectedBeatFXModeCombobox) userInfo:nil repeats:NO];
}

- (void)hideConnectedBeatFXModeCombobox {
    _switchingBeatReleseFXCombobox.hidden = YES;
    if (_connectedBeatFXModeTimer.isValid) {
        [_connectedBeatFXModeTimer invalidate];
        _connectedBeatFXModeTimer = nil;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kConnectedBeatFXModeComboBoxNotificationClosed object:self];
}

- (void)selectBeatFx:(int)index {
    [self showConnectedBeatFXCombobox];
    [_connectedBeatFXComboBox selectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [_beatFXView updateSelectedItem:index];
    [self autoHideConnectedBeatFXComboBox];
}

- (void)toggleBeatFx:(BOOL)isOn {
    [_beatFXView updateState:isOn];
}

- (void)toggleAutoMode:(BOOL)isAuto bpm:(double)bpm {
    [_beatFXView updateMode:isAuto bpm:bpm];
}

- (void)beatDownPressed {
    [self showConnectedBeatFXBeatCombobox];
    [_beatFXView beatUpPressed];
    [_beatFxValueSelectCombobox selectItemAtIndexPath:[NSIndexPath indexPathForRow:_beatFXView.currentBeatParamIndex inSection:0]];
    [self autoHideConnectedBeatFXBeatComboBox];
}

- (void)beatUpPressed {
    [self showConnectedBeatFXBeatCombobox];
    [_beatFXView beatDownPressed];
    [_beatFxValueSelectCombobox selectItemAtIndexPath:[NSIndexPath indexPathForRow:_beatFXView.currentBeatParamIndex inSection:0]];
    [self autoHideConnectedBeatFXBeatComboBox];
}

- (void)updateReleaseFxState:(BOOL)isOn {
    [_beatFXView updateReleaseFxState:isOn];
}

#pragma mark - DDJ_200
/**
 WeGO接続時のTrimValumeの同期
 */
- (void)trimVolumeSlider:(NSNotification*)center {
    float value = [[[center userInfo] valueForKey:@"value"] floatValue];
    NSUInteger deck = [[[center userInfo] valueForKey:@"deck"] unsignedIntegerValue];
    
    if (deck == 1) {
        [[NSUserDefaults standardUserDefaults] setFloat:value forKey:kTrimKnob1];
        
        PerformanceEQView* uv = _PerformancePanelArray1_[PERFORMANCE_EQ];
        uv.TrimKnobSlider_.value = value;
        [uv sliderColorMeter:uv.TrimKnobSlider_ slBaseView:uv.TrimKnobView_ slChangeView:uv.TrimKnobChangeView_ value:value];
        
        _PerformanceWeGoView1_.TrimVolumeSlider_.value = value;
        [_PerformanceWeGoView1_ sliderColorMeter:_PerformanceWeGoView1_.TrimVolumeSlider_
                                      slBaseView:_PerformanceWeGoView1_.TrimSliderView_
                                    slChangeView:_PerformanceWeGoView1_.TrimSliderChangeView_
                                           value:value];
    } else {
        [[NSUserDefaults standardUserDefaults] setFloat:value forKey:kTrimKnob2];
        
        PerformanceEQView* uv = _PerformancePanelArray2_[PERFORMANCE_EQ];
        uv.TrimKnobSlider_.value = value;
        [uv sliderColorMeter:uv.TrimKnobSlider_ slBaseView:uv.TrimKnobView_ slChangeView:uv.TrimKnobChangeView_ value:value];
        
        _PerformanceWeGoView2_.TrimVolumeSlider_.value = value;
        [_PerformanceWeGoView2_ sliderColorMeter:_PerformanceWeGoView2_.TrimVolumeSlider_
                                      slBaseView:_PerformanceWeGoView2_.TrimSliderView_
                                    slChangeView:_PerformanceWeGoView2_.TrimSliderChangeView_
                                           value:value];
    }
}

- (void)samplerVolumeSlider:(NSNotification*)center {
    float value = [[[center userInfo] valueForKey:@"value"] floatValue];
    //    NSUInteger deck = [[[center userInfo] valueForKey:@"deck"] unsignedIntegerValue];
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:kSamplerVolume];
    
    PerformanceSamplerView* uv = _PerformancePanelArray1_[PERFORMANCE_SAMPLER];
    uv.volume.value = value;
    [uv sliderColorMeter:uv.volume slBaseView:uv.VolumeView_ slChangeView:uv.VolumeChangeView_ value:value];
    uv = _PerformancePanelArray2_[PERFORMANCE_SAMPLER];
    uv.volume.value = value;
    [uv sliderColorMeter:uv.volume slBaseView:uv.VolumeView_ slChangeView:uv.VolumeChangeView_ value:value];
    _PerformanceWeGoView1_.VolumeSlider_.value = value;
    [_PerformanceWeGoView1_ sliderColorMeter:_PerformanceWeGoView1_.VolumeSlider_
                                  slBaseView:_PerformanceWeGoView1_.SliderView_
                                slChangeView:_PerformanceWeGoView1_.SliderChangeView_
                                       value:value];
    _PerformanceWeGoView2_.VolumeSlider_.value = value;
    [_PerformanceWeGoView2_ sliderColorMeter:_PerformanceWeGoView2_.VolumeSlider_
                                  slBaseView:_PerformanceWeGoView2_.SliderView_
                                slChangeView:_PerformanceWeGoView2_.SliderChangeView_
                                       value:value];
}

/**
 コントローラーのTempoSlider操作時に呼ばれる
 */
- (void)updateSliderPos:(int)sliderID pos:(float)newPos {
    [DeckDJSystemUpdateGUI updateSliderPos:sliderID pos:newPos];
}

- (void)colorSetting:(int)deck {
    if (deck == 1) {
        //        _PerformanceWeGoView1_.BorderView_.layer.borderColor = [coverArtColor1_ CGColor];
        _JogWbView1_.layer.borderColor = [coverArtColor1_ CGColor];
        _JogWcView1_.NormalView_.layer.borderColor = [coverArtColor1_ CGColor];
        _JogWcView1_.ShiftView_.layer.borderColor = [coverArtColor1_ CGColor];
        _JogWcView1_.HotCueView_.layer.borderColor = [coverArtColor1_ CGColor];
        _JogWcView1_.HotCueShiftView_.layer.borderColor = [coverArtColor1_ CGColor];
        
        PerformanceHeaderView* pv11 = _PerformanceViewArray1_[0];
        pv11.BorderView_.layer.borderWidth = 2.0f;
        pv11.BorderView_.layer.borderColor = [coverArtColor1_ CGColor];
        pv11.SelectPanelBorderView_.layer.borderWidth = 2.0f;
        pv11.SelectPanelBorderView_.layer.borderColor = [coverArtColor1_ CGColor];
        if (_PerformancePanelArray1_.count > PERFORMANCE_EQ) {
            PerformanceHotCueView* uv = _PerformancePanelArray1_[PERFORMANCE_EQ];
            uv.DeckLbl_.textColor = coverArtColor1_;
        }
        if (_PerformancePanelArray1_.count > PERFORMANCE_HOT_CUE) {
            PerformanceHotCueView* uv = _PerformancePanelArray1_[PERFORMANCE_HOT_CUE];
            uv.DeckLbl_.textColor = coverArtColor1_;
        }
        if (_PerformancePanelArray1_.count > PERFORMANCE_LOOP) {
            PerformanceLoopView* uv = _PerformancePanelArray1_[PERFORMANCE_LOOP];
            uv.DeckLbl_.textColor = coverArtColor1_;
        }
        //        if (_PerformancePanelArray1_.count > PERFORMANCE_FX_XY) {
        //            PerformanceHotCueView* uv = _PerformancePanelArray1_[PERFORMANCE_FX_XY];
        //            uv.DeckLbl_.textColor = coverArtColor1_;
        //        }
        if (_PerformancePanelArray1_.count > PERFORMANCE_FX_PAD) {
            PerformanceFxPadView* uv = _PerformancePanelArray1_[PERFORMANCE_FX_PAD];
            uv.DeckLbl_.textColor = coverArtColor1_;
        }
        //        if (_PerformancePanelArray1_.count > PERFORMANCE_SAMPLER) {
        //            PerformanceSamplerView* uv = _PerformancePanelArray1_[PERFORMANCE_SAMPLER];
        //            uv.DeckLbl_.textColor = coverArtColor1_;
        //        }
        //        _PerformanceWeGoView1_.DeckLbl_.textColor = coverArtColor1_;
    } else {
        //        _PerformanceWeGoView2_.BorderView_.layer.borderColor = [coverArtColor2_ CGColor];
        _JogWbView2_.layer.borderColor = [coverArtColor2_ CGColor];
        _JogWcView2_.NormalView_.layer.borderColor = [coverArtColor2_ CGColor];
        _JogWcView2_.ShiftView_.layer.borderColor = [coverArtColor2_ CGColor];
        _JogWcView2_.HotCueView_.layer.borderColor = [coverArtColor2_ CGColor];
        _JogWcView2_.HotCueShiftView_.layer.borderColor = [coverArtColor2_ CGColor];
        
        PerformanceHeaderView* pv21 = _PerformanceViewArray2_[0];
        pv21.BorderView_.layer.borderWidth = 2.0f;
        pv21.BorderView_.layer.borderColor = [coverArtColor2_ CGColor];
        pv21.SelectPanelBorderView_.layer.borderWidth = 2.0f;
        pv21.SelectPanelBorderView_.layer.borderColor = [coverArtColor2_ CGColor];
        if (_PerformancePanelArray1_.count > PERFORMANCE_EQ) {
            PerformanceHotCueView* uv = _PerformancePanelArray2_[PERFORMANCE_EQ];
            uv.DeckLbl_.textColor = coverArtColor2_;
        }
        if (_PerformancePanelArray2_.count > PERFORMANCE_HOT_CUE) {
            PerformanceHotCueView* uv = _PerformancePanelArray2_[PERFORMANCE_HOT_CUE];
            uv.DeckLbl_.textColor = coverArtColor2_;
        }
        if (_PerformancePanelArray2_.count > PERFORMANCE_LOOP) {
            PerformanceLoopView* uv = _PerformancePanelArray2_[PERFORMANCE_LOOP];
            uv.DeckLbl_.textColor = coverArtColor2_;
        }
        //        if (_PerformancePanelArray1_.count > PERFORMANCE_FX_XY) {
        //            PerformanceHotCueView* uv = _PerformancePanelArray2_[PERFORMANCE_FX_XY];
        //            uv.DeckLbl_.textColor = coverArtColor2_;
        //        }
        if (_PerformancePanelArray2_.count > PERFORMANCE_FX_PAD) {
            PerformanceFxPadView* uv = _PerformancePanelArray2_[PERFORMANCE_FX_PAD];
            uv.DeckLbl_.textColor = coverArtColor2_;
        }
        //        if (_PerformancePanelArray2_.count > PERFORMANCE_SAMPLER) {
        //            PerformanceSamplerView* uv = _PerformancePanelArray2_[PERFORMANCE_SAMPLER];
        //            uv.DeckLbl_.textColor = coverArtColor2_;
        //        }
        //        _PerformanceWeGoView2_.DeckLbl_.textColor = coverArtColor2_;
    }
}

/**
 コントローラ(DDJ-200)が接続中かを判定する
 
 @return YES:接続中 NO:未接続
 */
+ (BOOL)connectWannabe
{
    return ([PlayerStateRepository sharedInstance].connectedDeviceType == CONNECT_WannaBe);
}

#pragma mark xxx

#ifdef DESIGN_CONFIRM
- (void)ex_ConnectWeGo {
    _connectedDevice = !_WeGoConnect_ ? CONNECT_WeGO4 : NON_DEVICE;
    [_DeckBtnPerfAndCtrl closeWeGOControllerView:1];
    [_DeckBtnPerfAndCtrl closeWeGOControllerView:2];
    [_DeckBtnPerfAndCtrl performanceHidden:2];
    _WeGoConnect_ = !_WeGoConnect_;
    
    [DeckDJSystemNotifyChangeConnectedDevice deviceConnect];
}

- (void)ex_ConnectWannabe {
    _connectedDevice = !_WeGoConnect_ ? CONNECT_WannaBe : NON_DEVICE;
    [_DeckBtnPerfAndCtrl closeWeGOControllerView:1];
    [_DeckBtnPerfAndCtrl closeWeGOControllerView:2];
    [_DeckBtnPerfAndCtrl performanceHidden:2];
    _WeGoConnect_ = !_WeGoConnect_;
    
    [DeckDJSystemNotifyChangeConnectedDevice deviceConnect];
}

- (void)ex_ShiftDidPush:(UIButton *)sender {
    ex_ShiftKey_ = !ex_ShiftKey_;
    [DeckDJSystemNotifyMidi deviceShiftDidPush:ex_ShiftKey_ deck:(int)sender.tag - 1];
}

- (void)ex_HotCueDidPush:(UIButton *)sender {
    ex_HotCueKey_ = ! ex_HotCueKey_;
    [DeckDJSystemNotifyMidi deviceHotCueDidPush:ex_HotCueKey_ sampler:!ex_HotCueKey_ deck:(int)sender.tag - 1];
}
#endif

- (void)resizeObject {
    float constraint = static_cast<float>(_MainScreenSizeWidth_ * 0.016);

    ConnectDevice connectedDevice = [PlayerStateRepository sharedInstance].connectedDeviceType;
    if (connectedDevice == CONNECT_WannaBe) {
        float height = _disconnectedBottomButtons.frame.size.height;
        
        _JogWannaBecView_.frame = CGRectMake(_safeAreaLeft,
                                             self.view.frame.size.height - height - _safeAreaBottom,
                                             self.view.frame.size.width - _safeAreaLeft - _safeAreaRight,
                                             height);
        [_JogWannaBecView_ resizeObject];
        
    } else if (connectedDevice == CONNECT_EP134) {
        float height = _disconnectedBottomButtons.frame.size.height;
        
        _connectedBottomButtons.view.frame = CGRectMake(_safeAreaLeft,
                                                        self.view.frame.size.height - height - _safeAreaBottom,
                                                        self.view.frame.size.width - _safeAreaLeft - _safeAreaRight,
                                                        height);
        
        float cfxViewHeight = self.view.frame.size.height * 0.15f;
        float cfxViewWidth = self.view.frame.size.width * 120.0f / 1334.0f;
        _cfxView.frame = CGRectMake(_safeAreaLeft + constraint,
                                    _baseJogView.frame.origin.y + (_baseJogView.frame.size.height - cfxViewHeight) * 0.4,
                                    cfxViewWidth,
                                    cfxViewHeight);



        float beatFXViewHeight = self.view.frame.size.height * (_isUsingBeatFx ? 280.0f : 280.0f) / 750.0f;
        float beatFXViewWidth = self.view.frame.size.width * 120.0f / 1334.0f;
        _beatFXView.frame = CGRectMake(self.view.frame.size.width - beatFXViewWidth - _safeAreaRight - constraint,
                                       _baseJogView.frame.origin.y + (_baseJogView.frame.size.height - beatFXViewHeight) * 0.4,
                                       beatFXViewWidth,
                                       beatFXViewHeight);
        
        [_switchingBeatReleseFXCombobox setupUIWithView:_beatFXView direction:TOP];
        if (_beatFxValueSelectCombobox) {
            [_beatFxValueSelectCombobox setupUIWithView:_beatFXView direction:LEFT];
        }
        CGRect cfxComboboxFrame = CGRectMake(_cfxView.x, _baseJogView.frame.origin.y , self.view.frame.size.width * 0.15f, CGFLOAT_MIN);
        [colorFxCombobox setupUIWithFrame:cfxComboboxFrame];

        if (_connectedBeatFXComboBox) {
            CGFloat screenWidth = self.view.frame.size.width;
            CGFloat comboBoxWidth = screenWidth * 200.0f / 1334.0f;
            [_connectedBeatFXComboBox setupUIWithView:_beatFXView direction:LEFT maxVisibleItems:7 customWidth:comboBoxWidth];
        }
    }
}

- (void)hidePlayer {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)notifyDetectOtherDevice:(const NSString *)deviceName {
    if ([deviceName isEqualToString:@DEVICE_NAME_DDJWEGO4] || [deviceName isEqualToString:@DEVICE_NAME_DDJWEGO3]) {
        UIAlertController *alert = [UIAlertController alertTitle:nil message:kLSAlertUnableConnectToWeGO];
        UIAlertAction *action = [UIAlertAction actionWithTitle:kLSOk style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [UIAlertController showAlertController:alert];
    }
}

#pragma mark - Pad FX callback

- (void)notifyUpdatePadFx:(int)playerID {
    [DeckDJSystemNotifyUpdateGUI updatePadFx:playerID];
}

#pragma mark - Loop

- (void)loopStateSetting:(NSInteger)deck state:(BOOL)isActive ReDraw:(BOOL)isDraw {
    if (deck == 0) {
        //        JogaView_.ZoomTwinView_.LoopActive0_ = isActive;
        _HorizontalWaveView_.ZoomTwinViewLandscape_.LoopActive0_ = isActive;
        _VerticalWaveLeftView_.ZoomTwinViewVertical_.LoopActive0_ = isActive;
        _VerticalWaveRightView_.ZoomTwinViewVertical_.LoopActive0_ = isActive;
        
        int totalTime = DJSystemFunction_->getTotalTime((int)deck);
        int inPos = [self loudWavePositionPercent:_LoopInTime1_ totalTime:totalTime];
        int outPos = [self loudWavePositionPercent:_LoopOutTime1_ totalTime:totalTime];
        
        if (isActive) {
            if (_LoopOutTime1_ > 0) {
                BOOL isHalveEnable = _LoopOutTime1_ - _LoopInTime1_ < 7 * 2 ? NO : YES;
                BOOL isDoubleEnable = _LoopOutTime1_ >= totalTime ? NO : YES;
                if (_PerformancePanelArray1_.count > PERFORMANCE_LOOP) {
                    PerformanceLoopView* uv = _PerformancePanelArray1_[PERFORMANCE_LOOP];
                    [uv halveBtnEnabel:isHalveEnable];
                    [uv doubleBtnEnabel:isDoubleEnable];
                }
            } else {
                if (_PerformancePanelArray1_.count > PERFORMANCE_LOOP) {
                    PerformanceLoopView* uv = _PerformancePanelArray1_[PERFORMANCE_LOOP];
                    [uv halveBtnEnabel:YES];
                    [uv doubleBtnEnabel:YES];
                }
            }
        } else {
            if (_PerformancePanelArray1_.count > PERFORMANCE_LOOP) {
                PerformanceLoopView* uv = _PerformancePanelArray1_[PERFORMANCE_LOOP];
                [uv halveBtnEnabel:NO];
                [uv doubleBtnEnabel:NO];
            }
        }
        
        if (0 <= inPos && inPos <= deck1LoudWaveViewLandscape.frame.size.width) {
            if (0 <= outPos && outPos <= deck1LoudWaveViewLandscape.frame.size.width) {
                if (inPos < outPos) {
                    if (isActive) {
                        deck1LoudWaveViewLandscape.LoopView_.backgroundColor = RGBA(255, 163, 0, 0.3f);
                    } else {
                        deck1LoudWaveViewLandscape.LoopView_.backgroundColor = RGBA(255, 255, 255, 0.2f);
                    }
                    CGRect rect = deck1LoudWaveViewLandscape.LoopView_.frame;
                    rect.origin.x = inPos;
                    rect.size.width = outPos - inPos;
                    deck1LoudWaveViewLandscape.LoopView_.frame = rect;
                    deck1LoudWaveViewLandscape.LoopView_.hidden = NO;
                } else {
                    deck1LoudWaveViewLandscape.LoopView_.hidden = YES;
                }
            } else {
                deck1LoudWaveViewLandscape.LoopView_.hidden = YES;
            }
        } else {
            deck1LoudWaveViewLandscape.LoopView_.hidden = YES;
        }
    } else {
        //        _JogaView_.ZoomTwinView_.LoopActive1_ = isActive;
        _HorizontalWaveView_.ZoomTwinViewLandscape_.LoopActive1_ = isActive;
        _VerticalWaveRightView_.ZoomTwinViewVertical_.LoopActive1_ = isActive;
        _VerticalWaveLeftView_.ZoomTwinViewVertical_.LoopActive1_ = isActive;
        
        int totalTime = DJSystemFunction_->getTotalTime((int)deck);
        int inPos = [self loudWavePositionPercent:_LoopInTime2_ totalTime:totalTime];
        int outPos = [self loudWavePositionPercent:_LoopOutTime2_ totalTime:totalTime];
        
        if (isActive) {
            if (_LoopOutTime2_ > 0) {
                BOOL isHalveEnable = _LoopOutTime2_ - _LoopInTime2_ < 7 * 2 ? NO : YES;
                BOOL isDoubleEnable = _LoopOutTime2_ >= totalTime ? NO : YES;
                if (_PerformancePanelArray2_.count > PERFORMANCE_LOOP) {
                    PerformanceLoopView* uv = _PerformancePanelArray2_[PERFORMANCE_LOOP];
                    [uv halveBtnEnabel:isHalveEnable];
                    [uv doubleBtnEnabel:isDoubleEnable];
                }
            } else {
                if (_PerformancePanelArray2_.count > PERFORMANCE_LOOP) {
                    PerformanceLoopView* uv = _PerformancePanelArray2_[PERFORMANCE_LOOP];
                    [uv halveBtnEnabel:YES];
                    [uv doubleBtnEnabel:YES];
                }
            }
        } else {
            if (_PerformancePanelArray2_.count > PERFORMANCE_LOOP) {
                PerformanceLoopView* uv = _PerformancePanelArray2_[PERFORMANCE_LOOP];
                [uv halveBtnEnabel:NO];
                [uv doubleBtnEnabel:NO];
            }
        }
        
        if (0 <= inPos && inPos <= deck2LoudWaveViewLandscape.frame.size.width) {
            if (0 <= outPos && outPos <= deck2LoudWaveViewLandscape.frame.size.width) {
                if (inPos < outPos) {
                    if (isActive) {
                        deck2LoudWaveViewLandscape.LoopView_.backgroundColor = RGBA(255, 163, 0, 0.3f);
                    } else {
                        deck2LoudWaveViewLandscape.LoopView_.backgroundColor = RGBA(255, 255, 255, 0.2f);
                    }
                    CGRect rect = deck2LoudWaveViewLandscape.LoopView_.frame;
                    rect.origin.x = inPos;
                    rect.size.width = outPos - inPos;
                    deck2LoudWaveViewLandscape.LoopView_.frame = rect;
                    deck2LoudWaveViewLandscape.LoopView_.hidden = NO;
                } else {
                    deck2LoudWaveViewLandscape.LoopView_.hidden = YES;
                }
            } else {
                deck2LoudWaveViewLandscape.LoopView_.hidden = YES;
            }
        } else {
            deck2LoudWaveViewLandscape.LoopView_.hidden = YES;
        }
    }
}

- (void) setupView {
    [[DJSystemFunctionHolder sharedManager] getDJSystemFunction];
    
    //Setup UI Loop View
    [self setupPadView:loopLeftView Player:PLAYER_A];
    [self setupPadView:loopRightView Player:PLAYER_B];
    loopLeftView.delegate = self;
    loopRightView.delegate = self;
    
    //Setup UI Cue View
    [self setupPadView:cueLeftView Player:PLAYER_A];
    [self setupPadView:cueRightView Player:PLAYER_B];
    
    //Setup UI BeatJump View
    [self setupPadView:beatJumpLeftView Player:PLAYER_A];
    [self setupPadView:beatJumpRightView Player:PLAYER_B];
    beatJumpLeftView.delegate = self;
    beatJumpRightView.delegate = self;
    
    //Setup Tempo Slider
    [self createTempoSlider];
    
    [self setupPerformanceView];
    
    //Setup FXPanel
    [self setupFXPanelView];
    
    //Setup SmartFaderMixer
    [self setupSmartFaderMixerHorizontal];
    [self setupSmartFaderMixerJog];
    
    //Setup FXPanel
    [self setupSamplerView];
    
    //Setup Level Meter
    [self setupLevelMeter];
}

#pragma mark Performance View
- (void) setupPerformanceView {
    float width = static_cast<float>(_MainScreenSizeWidth_ * RatioPadWidth);
    float height = static_cast<float>(_MainScreenSizeHeight_ * RatioPadHeight);
    float constraint = static_cast<float>(_MainScreenSizeWidth_ * RatioConstraint);
    [self.view addSubview:performancePadLeftView];
    performancePadLeftView.hidden = YES;
    performancePadLeftView.translatesAutoresizingMaskIntoConstraints = NO;
    performancePadLeftView.delegate = self;
    performancePadLeftView.delegateLoopLeft = self;
    [performancePadLeftView.bottomAnchor constraintEqualToAnchor:_baseHorizontalWaveView_.bottomAnchor constant: -constraint].active = YES;
    [performancePadLeftView.leadingAnchor constraintEqualToAnchor:_padLeftButton.trailingAnchor constant: constraint].active = YES;
    [performancePadLeftView.widthAnchor constraintEqualToConstant:width].active = YES;
    [performancePadLeftView.heightAnchor constraintEqualToConstant:height].active = YES;
    
    [self.view addSubview:performancePadRightView];
    performancePadRightView.hidden = YES;
    performancePadRightView.translatesAutoresizingMaskIntoConstraints = NO;
    performancePadRightView.delegateBeatJump = self;
    performancePadRightView.delegateLoopRight = self;
    [performancePadRightView.bottomAnchor constraintEqualToAnchor:_baseHorizontalWaveView_.bottomAnchor constant: -constraint].active = YES;
    [performancePadRightView.trailingAnchor constraintEqualToAnchor:_padRightButton.leadingAnchor constant: -constraint].active = YES;
    [performancePadRightView.widthAnchor constraintEqualToConstant:width].active = YES;
    [performancePadRightView.heightAnchor constraintEqualToConstant:height].active = YES;
    performancePadLeftView.delegatePerformanceLoopLeft = self;
    performancePadRightView.delegatePerformanceLoopRight = self;
}

#pragma mark Sampler View
- (void) setupSamplerView {
    float height = _MainScreenSizeHeight_ * RatioPadHeight;
    float heightEdit = height + (height * RatioheightEditSampler);
    float constraint = _MainScreenSizeWidth_ * RatioConstraint;
    float heightTableView = _MainScreenSizeHeight_ * RatioheightTableView;
    [self.view addSubview:samplerView];
    samplerView.hidden = YES;
    samplerView.translatesAutoresizingMaskIntoConstraints = NO;
    [samplerView.bottomAnchor constraintEqualToAnchor:_baseHorizontalWaveView_.bottomAnchor constant: -constraint].active = YES;
    [samplerView.trailingAnchor constraintEqualToAnchor:_padRightButton.leadingAnchor constant: -constraint].active = YES;
    [samplerView.leadingAnchor constraintEqualToAnchor:_padLeftButton.trailingAnchor constant: constraint].active = YES;
    heightSamplerView = [samplerView.heightAnchor constraintEqualToConstant:height];
    heightSamplerView.priority = PrioritySamplerHight;
    heightSamplerView.active = YES;
    heightSamplerEditView = [samplerView.heightAnchor constraintEqualToConstant:heightEdit];
    heightSamplerEditView.priority = PrioritySamplerLow;
    heightSamplerEditView.active = YES;
    samplerView.delegateSamplerView = self;
    
    [self.view addSubview:samplerTableView];
    samplerTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [samplerTableView.bottomAnchor constraintEqualToAnchor:samplerView.styleSamplerButton.topAnchor constant: ZeroValue].active = YES;
    [samplerTableView.trailingAnchor constraintEqualToAnchor:samplerView.styleSamplerButton.trailingAnchor constant: ZeroValue].active = YES;
    [samplerTableView.leadingAnchor constraintEqualToAnchor:samplerView.styleSamplerButton.leadingAnchor constant: ZeroValue].active = YES;
    [samplerTableView.heightAnchor constraintEqualToConstant:heightTableView].active = YES;
    samplerTableView.delegateSamplerTableView = self;
    samplerTableView.hidden = YES;
    
    float heightPopupSampler = _MainScreenSizeHeight_ * RatioheightPopupSampler;
    [self.view addSubview:selectSamplerView];
    selectSamplerView.translatesAutoresizingMaskIntoConstraints = NO;
    [selectSamplerView.bottomAnchor constraintEqualToAnchor:_baseHorizontalWaveView_.bottomAnchor constant:-constraint].active = YES;
    [selectSamplerView.trailingAnchor constraintEqualToAnchor:_padRightButton.leadingAnchor constant:-constraint].active = YES;
    [selectSamplerView.leadingAnchor constraintEqualToAnchor:_padLeftButton.trailingAnchor constant:constraint].active = YES;
    [selectSamplerView.heightAnchor constraintEqualToConstant:heightPopupSampler].active = YES;
    selectSamplerView.hidden = YES;
    selectSamplerView.delegateSelectSampler = self;
    
    [self setupSampler: ZeroValue keyString:Empty];
}

#pragma mark PX Panel
- (void) setupFXPanelView {
    float width = static_cast<float>(_MainScreenSizeWidth_ * RatioPadWidth);
    float height = static_cast<float>(_MainScreenSizeHeight_ * RatioPadHeight);
    float constraint = static_cast<float>(_MainScreenSizeWidth_ * RatioConstraint);
    
    [self.view addSubview:fxPanelLeftView];
    fxPanelLeftView.delegate = self;
    fxPanelLeftView.hidden = YES;
    [_fxLeftButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
    fxPanelLeftView.translatesAutoresizingMaskIntoConstraints = NO;
    [fxPanelLeftView.bottomAnchor constraintEqualToAnchor:_baseHorizontalWaveView_.bottomAnchor constant: -constraint].active = YES;
    [fxPanelLeftView.leadingAnchor constraintEqualToAnchor:_padLeftButton.trailingAnchor constant: constraint].active = YES;
    [fxPanelLeftView.widthAnchor constraintEqualToConstant:width].active = YES;
    [fxPanelLeftView.heightAnchor constraintEqualToConstant:height].active = YES;
    [fxPanelLeftView setupUIView:width height:height];
    
    [self.view addSubview:fxPanelRightView];
    fxPanelRightView.delegate = self;
    fxPanelRightView.hidden = YES;
    [_fxRightButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
    fxPanelRightView.translatesAutoresizingMaskIntoConstraints = NO;
    [fxPanelRightView.bottomAnchor constraintEqualToAnchor:_baseHorizontalWaveView_.bottomAnchor constant: -constraint].active = YES;
    [fxPanelRightView.trailingAnchor constraintEqualToAnchor:_padRightButton.leadingAnchor constant: -constraint].active = YES;
    [fxPanelRightView.widthAnchor constraintEqualToConstant:width].active = YES;
    [fxPanelRightView.heightAnchor constraintEqualToConstant:height].active = YES;
    [fxPanelRightView setupUIView:width height:height];
    
    [self setupBeatFxCombobox];
}

- (void)setupBeatFxCombobox {
    BeatFxLeftView *beatFxLeftView = fxPanelLeftView.beatFxView;
    BeatFxRightView *beatFxRightView = fxPanelRightView.beatFxView;
    NSArray *listNameStyleFx = @[beatFxLeftView.listNameStyleFx];
    NSArray *listNameBeatFx = @[beatFxLeftView.listNameBeatFx];

    typeFxLeftCombobox.delegateCombobox = self;
    typeFxRightCombobox.delegateCombobox = self;
    beatFxRightCombobox.delegateCombobox = self;
    beatFxLeftCombobox.delegateCombobox = self;
    
    beatFxLeftCombobox = [[ComboboxView alloc]initWithData:listNameBeatFx scrollEnabled:YES selectHandler:^(NSInteger section, NSInteger index) {
        [beatFxLeftView selectLeftBeatFxWithRow:index];
        [self->beatFxLeftCombobox hidden:YES];
    } toggleHandler:^(BOOL open) {
        [beatFxLeftView beatFxComboboxHidden:open];
    }];
    
    typeFxLeftCombobox = [[ComboboxView alloc]initWithData:listNameStyleFx scrollEnabled:NO selectHandler:^(NSInteger section, NSInteger index) {
        [beatFxLeftView selectLeftBeatFxWithRow:index];
        [self->typeFxLeftCombobox hidden:YES];
    } toggleHandler:^(BOOL open) {
        [beatFxLeftView typeFxComboboxHidden:open];
    }];
    
    typeFxRightCombobox = [[ComboboxView alloc]initWithData:listNameStyleFx scrollEnabled:NO selectHandler:^(NSInteger section, NSInteger index) {
        [beatFxRightView selectRightBeatFxWithRow:index];
        [self->typeFxRightCombobox hidden:YES];
    } toggleHandler:^(BOOL open) {
        [beatFxRightView typeFxComboboxHidden:open];
    }];

    beatFxRightCombobox = [[ComboboxView alloc]initWithData:listNameBeatFx scrollEnabled:YES selectHandler:^(NSInteger section, NSInteger index) {
        [beatFxRightView selectRightBeatFxWithRow:index];
        [self->beatFxRightCombobox hidden:YES];
    } toggleHandler:^(BOOL open) {
        [beatFxRightView beatFxComboboxHidden:open];
    }];
    
    [self.view addSubview:beatFxLeftCombobox];
    [self.view addSubview:typeFxLeftCombobox];
    [self.view addSubview:typeFxRightCombobox];
    [self.view addSubview:beatFxRightCombobox];
    
    [beatFxLeftCombobox setupUIWithView:beatFxLeftView.beatFxView direction:TOP maxVisibleItems:8];
    [typeFxLeftCombobox setupUIWithView:beatFxLeftView.typeFxView direction:TOP maxVisibleItems:beatFxLeftView.listNameStyleFx.count];
    [beatFxRightCombobox setupUIWithView:beatFxRightView.beatFxView direction:TOP maxVisibleItems:8];
    [typeFxRightCombobox setupUIWithView:beatFxRightView.typeFxView direction:TOP maxVisibleItems:beatFxLeftView.listNameStyleFx.count];
    
    [beatFxLeftCombobox hidden:YES];
    [typeFxLeftCombobox hidden:YES];
    [beatFxRightCombobox hidden:YES];
    [typeFxRightCombobox hidden:YES];
}

#pragma mark SmartFader Mixer
- (void)setupSmartFaderMixerHorizontal {
    float height = _MainScreenSizeHeight_ * RatioMixerHorizontalHeight;
    float constraint = _MainScreenSizeWidth_ * RatioConstraint;
    
    [self.view addSubview:smartFaderMixerView];
    smartFaderMixerView.delegate = self;
    smartFaderMixerView.hidden = YES;
    smartFaderMixerView.translatesAutoresizingMaskIntoConstraints = NO;
    [smartFaderMixerView.bottomAnchor constraintEqualToAnchor:_baseHorizontalWaveView_.bottomAnchor constant: -constraint].active = YES;
    [smartFaderMixerView.leadingAnchor constraintEqualToAnchor:_padLeftButton.trailingAnchor constant: constraint].active = YES;
    [smartFaderMixerView.trailingAnchor constraintEqualToAnchor:_padRightButton.leadingAnchor constant: -constraint].active = YES;
    [smartFaderMixerView.heightAnchor constraintEqualToConstant:height].active = YES;
    [smartFaderMixerView setupSFUI];
    
    NSArray *listNameCFX = smartFaderMixerView.listNameCFX;
    // Left Horizontal CFX Combobox
    cfxLeftHorizontalTableView.delegateCFXCombobox = self;
    
    cfxLeftHorizontalTableView = [[CFXComboboxTableView alloc]initWithData:listNameCFX scrollEnabled:YES selectHandler:^(NSInteger index) {
        [self->smartFaderMixerView selectLeftCFXWithRow:index];
        [self->cfxLeftHorizontalTableView hidden:YES];
    } toggleHandler:^(BOOL open) {
        [self->smartFaderMixerView cfxComboboxLeftHidden:open];
    }];
    
    [self.view addSubview:cfxLeftHorizontalTableView];
    [cfxLeftHorizontalTableView setupLeftHorizontalUIWithView:smartFaderMixerView.cfxLeftHorizontalView maxVisibleItems:5];
    [cfxLeftHorizontalTableView setHidden:YES];
    
    // Right Horizontal CFX Combobox
    cfxRightHorizontalTableView.delegateCFXCombobox = self;
    cfxRightHorizontalTableView = [[CFXComboboxTableView alloc]initWithData:listNameCFX scrollEnabled:YES selectHandler:^(NSInteger index) {
        [self->smartFaderMixerView selectRightCFXWithRow:index];
        [self->cfxRightHorizontalTableView hidden:YES];
    } toggleHandler:^(BOOL open) {
        [self->smartFaderMixerView cfxComboboxRightHidden:open];
    }];
    
    [self.view addSubview:cfxRightHorizontalTableView];
    [cfxRightHorizontalTableView setupRighttHorizontalUIWithView:smartFaderMixerView.cfxRightHorizontalView maxVisibleItems:5];
    [cfxRightHorizontalTableView setHidden:YES];
}

- (void)setupSmartFaderMixerJog {
    float width = _MainScreenSizeWidth_ * RatioMixerWidth;
    float height = _MainScreenSizeHeight_ * RatioMixerHeight;
    float constraintLR = _MainScreenSizeWidth_ * RatioLRMixConstraint;
    
    [self.view addSubview:smartFaderMixerLeftView];
    smartFaderMixerLeftView.delegate = self;
    smartFaderMixerLeftView.hidden = YES;
    smartFaderMixerLeftView.translatesAutoresizingMaskIntoConstraints = NO;
    [smartFaderMixerLeftView.leadingAnchor constraintEqualToAnchor:_padLeftButton.trailingAnchor constant: constraintLR].active = YES;
    [smartFaderMixerLeftView.centerYAnchor constraintEqualToAnchor:_padLeftButton.centerYAnchor constant: ZeroValue].active = YES;
    [smartFaderMixerLeftView.widthAnchor constraintEqualToConstant:width].active = YES;
    [smartFaderMixerLeftView.heightAnchor constraintEqualToConstant:height].active = YES;
    [smartFaderMixerLeftView setupSFUI];
    
    [self.view addSubview:smartFaderMixerRightView];
    smartFaderMixerRightView.delegate = self;
    smartFaderMixerRightView.hidden = YES;
    smartFaderMixerRightView.translatesAutoresizingMaskIntoConstraints = NO;
    [smartFaderMixerRightView.trailingAnchor constraintEqualToAnchor:_padRightButton.leadingAnchor constant: -constraintLR].active = YES;
    [smartFaderMixerRightView.centerYAnchor constraintEqualToAnchor:_padRightButton.centerYAnchor constant: ZeroValue].active = YES;
    [smartFaderMixerRightView.widthAnchor constraintEqualToConstant:width].active = YES;
    [smartFaderMixerRightView.heightAnchor constraintEqualToConstant:height].active = YES;
    [smartFaderMixerRightView setupSFUI];
    
    NSArray *listNameCFX = smartFaderMixerLeftView.listNameCFX;
    // Left Jog CFX Combobox
    cfxLeftJogTableView.delegateCFXCombobox = self;
    cfxLeftJogTableView = [[CFXComboboxTableView alloc]initWithData:listNameCFX scrollEnabled:YES selectHandler:^(NSInteger index) {
        [self->smartFaderMixerLeftView selectLeftJogCFXWithRow:index];
        [self->cfxLeftJogTableView hidden:YES];
    } toggleHandler:^(BOOL open) {
        [self->smartFaderMixerLeftView cfxComboboxLeftJogHidden:open];
    }];
    
    [self.view addSubview:cfxLeftJogTableView];
    [cfxLeftJogTableView setupLeftJogUIWithView:smartFaderMixerLeftView.LeftJogCFXButton_ maxVisibleItems:5];
    [cfxLeftJogTableView setHidden:YES];
    
    // Right Jog CFX Combobox
    cfxRightJogTableView.delegateCFXCombobox = self;
    cfxRightJogTableView = [[CFXComboboxTableView alloc]initWithData:listNameCFX scrollEnabled:YES selectHandler:^(NSInteger index) {
        [self->smartFaderMixerRightView selectRightJogCFXWithRow:index];
        [self->cfxRightJogTableView hidden:YES];
    } toggleHandler:^(BOOL open) {
        [self->smartFaderMixerRightView cfxComboboxRightJogHidden:open];
    }];
    
    [self.view addSubview:cfxRightJogTableView];
    [cfxRightJogTableView setupRightJogUIWithView:smartFaderMixerRightView.RightJogCFXButton_ maxVisibleItems:5];
    [cfxRightJogTableView setHidden:YES];
}

- (void)setupPadView:(UIView*)view Player:(int)player {
    float width = static_cast<float>(_MainScreenSizeWidth_ * 40 / 100);
    float height = static_cast<float>(_MainScreenSizeHeight_ * 55 / 100);
    [self.view addSubview:view];
    view.hidden = YES;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    if(player == PLAYER_A) {
        [view.topAnchor constraintEqualToAnchor:_leftJogView.topAnchor constant:0].active = YES;
        [view.leadingAnchor constraintEqualToAnchor:_leftJogView.leadingAnchor constant:0].active = YES;
        [view.widthAnchor constraintEqualToConstant:width].active = YES;
        [view.heightAnchor constraintEqualToConstant:height].active = YES;
    } else {
        [view.topAnchor constraintEqualToAnchor:_rightJogView.topAnchor constant:0].active = YES;
        [view.trailingAnchor constraintEqualToAnchor:_rightJogView.trailingAnchor constant:0].active = YES;
        [view.widthAnchor constraintEqualToConstant:width].active = YES;
        [view.heightAnchor constraintEqualToConstant:height].active = YES;
    }
    view.layer.borderColor = player == PLAYER_A ? kC_HotCue_16.CGColor : kC_HotCue_07.CGColor;
    view.layer.borderWidth = BORDER_WIDTH2_0;
    view.layer.cornerRadius = 5.0f;
    view.backgroundColor = kColor_Pad;
}

- (void)createTempoSlider {
    float heightSliderView  = static_cast<float>(_MainScreenSizeHeight_ * 0.526);
    float heightMasterTempo = static_cast<float>(_MainScreenSizeHeight_ * 0.113);
    float widthMasterTempo = static_cast<float>(_MainScreenSizeWidth_ * 0.455);
    float constraint = static_cast<float>(_MainScreenSizeWidth_ * 0.016);
    float widthSliderView = static_cast<float>(_MainScreenSizeWidth_ * 0.089);
    float heightMasterView = static_cast<float>(_MainScreenSizeHeight_ * 0.072);
    float heightBpmEdit = static_cast<float>(_MainScreenSizeHeight_ * 0.468);
    
    masterTempoLeftView.masterLabel.textColor = kColor_MixerButtonTitleOff;
    masterTempoLeftView.tempoLabel.textColor = kColor_MixerButtonTitleOff;
    masterTempoRightView.masterLabel.textColor = kColor_MixerButtonTitleOff;
    masterTempoRightView.tempoLabel.textColor = kColor_MixerButtonTitleOff;
    
    _TempoBpmLabel1_ = [[UILabel alloc] init];
    [self.view addSubview:masterTempoLeftView];
    masterTempoLeftView.translatesAutoresizingMaskIntoConstraints = NO;
    [masterTempoLeftView.heightAnchor constraintEqualToConstant:heightMasterTempo].active = YES;
    [masterTempoLeftView.widthAnchor constraintEqualToConstant:widthMasterTempo].active = YES;
    [masterTempoLeftView.centerYAnchor constraintEqualToAnchor:_tempoLButton.centerYAnchor].active = YES;
    [masterTempoLeftView.leadingAnchor constraintEqualToAnchor:_trackArtWorkLeftImageView.leadingAnchor constant:constraint].active = YES;
    masterTempoLeftView.bpmView.layer.borderWidth = OneValue;
    masterTempoLeftView.bpmView.layer.borderColor = kColor_EditSamplerOn.CGColor;
    masterTempoLeftView.bpmView.layer.cornerRadius = 3;
    masterTempoLeftView.hidden = YES;
    masterTempoLeftView.delegate = self;
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:PLAYER_A_MASTER_TEMPO_LBL]) {
        masterTempoLeftView.masterLabel.textColor = kColor_MasterTempoButton;
        masterTempoLeftView.tempoLabel.textColor = kColor_MasterTempoButton;
    } else {
        masterTempoLeftView.masterLabel.textColor = kColor_MixerButtonTitleOff;
        masterTempoLeftView.tempoLabel.textColor = kColor_MixerButtonTitleOff;
    }
    
    _masterLeftButton = [[UIButton alloc] init];
    [self.view addSubview: _masterLeftButton];
    [_masterLeftButton setTitle:kLSMASTER forState:UIControlStateNormal];
    [_masterLeftButton.titleLabel setFont:[UIFont systemFontOfSize:11.f]];
    [_masterLeftButton sizeToFit];
    _masterLeftButton.backgroundColor = kColor_MixerButtonBGOff;
    _masterLeftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_masterLeftButton.widthAnchor constraintEqualToConstant:widthSliderView].active = YES;
    [_masterLeftButton.leadingAnchor constraintEqualToAnchor:masterTempoLeftView.leadingAnchor constant:ZeroValue].active = YES;
    [_masterLeftButton.bottomAnchor constraintEqualToAnchor:masterTempoLeftView.topAnchor constant: -2].active = YES;
    [_masterLeftButton.heightAnchor constraintEqualToConstant:heightMasterView].active = YES;
    [_masterLeftButton setTitleColor:kColor_MixerButtonTitleOff forState:UIControlStateNormal];
    _masterLeftButton.tag = PLAYER_A;
    _masterLeftButton.hidden = YES;
    [_masterLeftButton addTarget:self action:@selector(masterLeftButtonDidPush:) forControlEvents: UIControlEventTouchUpInside];
    
    _TempoEditView1_ = [[TempoEditView alloc] init];
    _TempoEditView1_.userInteractionEnabled = YES;
    [self.view addSubview:_TempoEditView1_];
    _TempoEditView1_.translatesAutoresizingMaskIntoConstraints = NO;
    [_TempoEditView1_.leadingAnchor constraintEqualToAnchor:masterTempoLeftView.leadingAnchor constant:ZeroValue].active = YES;
    [_TempoEditView1_.topAnchor constraintEqualToAnchor:masterTempoLeftView.bottomAnchor constant:ZeroValue].active = YES;
    [_TempoEditView1_.bottomAnchor constraintEqualToAnchor:_fxLeftButton.bottomAnchor constant:ZeroValue].active = YES;
    [_TempoEditView1_.widthAnchor constraintEqualToConstant:widthSliderView].active = YES;
    _TempoEditView1_.backgroundColor = kColor_MixerButtonBGOff;
    [_TempoEditView1_ createView:PLAYER_A width: widthSliderView height:heightSliderView];
    _TempoEditView1_.hidden = YES;
    
    [self.view addSubview:masterTempoRightView];
    masterTempoRightView.translatesAutoresizingMaskIntoConstraints = NO;
    [masterTempoRightView.heightAnchor constraintEqualToConstant:heightMasterTempo].active = YES;
    [masterTempoRightView.widthAnchor constraintEqualToConstant:widthMasterTempo].active = YES;
    [masterTempoRightView.centerYAnchor constraintEqualToAnchor:_tempoRButton.centerYAnchor].active = YES;
    [masterTempoRightView.trailingAnchor constraintEqualToAnchor:_trackArtWorkRightImageView.trailingAnchor constant:-constraint].active = YES;
    masterTempoRightView.bpmView.layer.borderWidth = OneValue;
    masterTempoRightView.bpmView.layer.borderColor = kColor_EditSamplerOn.CGColor;
    masterTempoRightView.bpmView.layer.cornerRadius = 3;
    masterTempoRightView.hidden = YES;
    masterTempoRightView.delegate = self;
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:PLAYER_B_MASTER_TEMPO_LBL]) {
        masterTempoRightView.masterLabel.textColor = kColor_MasterTempoButton;
        masterTempoRightView.tempoLabel.textColor = kColor_MasterTempoButton;
    } else {
        masterTempoRightView.masterLabel.textColor = kColor_MixerButtonTitleOff;
        masterTempoRightView.tempoLabel.textColor = kColor_MixerButtonTitleOff;
    }
    
    _masterRightButton = [[UIButton alloc] init];
    [self.view addSubview:_masterRightButton];
    [_masterRightButton setTitle:kLSMASTER forState:UIControlStateNormal];
    [_masterRightButton.titleLabel setFont:[UIFont systemFontOfSize:11.f]];
    [_masterRightButton sizeToFit];
    _masterRightButton.backgroundColor = kColor_MixerButtonBGOff;
    _masterRightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_masterRightButton.widthAnchor constraintEqualToConstant:widthSliderView].active = YES;
    [_masterRightButton.trailingAnchor constraintEqualToAnchor:masterTempoRightView.trailingAnchor constant:ZeroValue].active = YES;
    [_masterRightButton.bottomAnchor constraintEqualToAnchor:masterTempoRightView.topAnchor constant: -2].active = YES;
    [_masterRightButton.heightAnchor constraintEqualToConstant:heightMasterView].active = YES;
    [_masterRightButton setTitleColor:kColor_MixerButtonTitleOff forState:UIControlStateNormal];
    _masterRightButton.tag = PLAYER_B;
    _masterRightButton.hidden = YES;
    [_masterRightButton addTarget:self action:@selector(masterRightButtonDidPush:) forControlEvents: UIControlEventTouchUpInside];
    
    _TempoBpmLabel2_ = [[UILabel alloc] init];
    _TempoEditView2_ = [[TempoEditView alloc] init];
    _TempoEditView2_.userInteractionEnabled = YES;
    [self.view addSubview:_TempoEditView2_];
    _TempoEditView2_.translatesAutoresizingMaskIntoConstraints = NO;
    [_TempoEditView2_.trailingAnchor constraintEqualToAnchor:masterTempoRightView.trailingAnchor constant:ZeroValue].active = YES;
    [_TempoEditView2_.topAnchor constraintEqualToAnchor:masterTempoRightView.bottomAnchor constant:ZeroValue].active = YES;
    [_TempoEditView2_.widthAnchor constraintEqualToConstant:widthSliderView].active = YES;
    [_TempoEditView2_.bottomAnchor constraintEqualToAnchor:_fxRightButton.bottomAnchor constant:ZeroValue].active = YES;
    _TempoEditView2_.backgroundColor = kColor_MixerButtonBGOff  ;
    [_TempoEditView2_ createView:PLAYER_B width: widthSliderView height:heightSliderView];
    _TempoEditView2_.hidden = YES;
    
    /// Bpm Edit View
    _BpmEditView1_ = [[BpmEditView alloc] init];
    _BpmEditView1_.userInteractionEnabled = YES;
    [self.view addSubview:_BpmEditView1_];
    _BpmEditView1_.translatesAutoresizingMaskIntoConstraints = NO;
    [_BpmEditView1_.topAnchor constraintEqualToAnchor:_TempoEditView1_.topAnchor constant:constraint/2].active = YES;
    [_BpmEditView1_.trailingAnchor constraintEqualToAnchor:_TempoEditView1_.trailingAnchor constant:ZeroValue].active = YES;
    [_BpmEditView1_.leadingAnchor constraintEqualToAnchor:_TempoEditView1_.leadingAnchor constant:ZeroValue].active = YES;
    [_BpmEditView1_.bottomAnchor constraintEqualToAnchor:_TempoEditView1_.GRIDButton.topAnchor constant:ZeroValue].active = YES;
    [_BpmEditView1_ createView:PLAYER_A width: widthSliderView height: heightBpmEdit];
    _BpmEditView1_.hidden = YES;
    
    _BpmEditView2_ = [[BpmEditView alloc] init];
    _BpmEditView2_.userInteractionEnabled = YES;
    [self.view addSubview:_BpmEditView2_];
    _BpmEditView2_.translatesAutoresizingMaskIntoConstraints = NO;
    [_BpmEditView2_.topAnchor constraintEqualToAnchor:_TempoEditView2_.topAnchor constant:constraint/2].active = YES;
    [_BpmEditView2_.leadingAnchor constraintEqualToAnchor:_TempoEditView2_.leadingAnchor constant:ZeroValue].active = YES;
    [_BpmEditView2_.trailingAnchor constraintEqualToAnchor:_TempoEditView2_.trailingAnchor constant:ZeroValue].active = YES;
    [_BpmEditView2_.bottomAnchor constraintEqualToAnchor:_TempoEditView2_.GRIDButton.topAnchor constant:ZeroValue].active = YES;
    [_BpmEditView2_ createView:PLAYER_B width:widthSliderView height:heightBpmEdit];
    _BpmEditView2_.hidden = YES;
    
    ///Original View
    OriginalLeftView = [[UIView alloc] init];
    [self.view addSubview:OriginalLeftView];
    OriginalLeftView.translatesAutoresizingMaskIntoConstraints = NO;
    [OriginalLeftView.leadingAnchor constraintEqualToAnchor:_BpmEditView1_.leadingAnchor constant:ZeroValue].active = YES;
    [OriginalLeftView.topAnchor constraintEqualToAnchor:_tempoLButton.topAnchor  constant:ZeroValue].active = YES;
    [OriginalLeftView.bottomAnchor constraintEqualToAnchor:_BpmEditView1_.topAnchor constant:ZeroValue].active = YES;
    [OriginalLeftView.trailingAnchor constraintEqualToAnchor:_tempoLButton.trailingAnchor constant:ZeroValue].active = YES;
    OriginalLeftView.backgroundColor = kColor_MixerButtonBGOff;
    OriginalLeftView.hidden = YES;
    
    UIView *backgroundLView = [[UIView alloc] init];
    [OriginalLeftView addSubview:backgroundLView];
    backgroundLView.translatesAutoresizingMaskIntoConstraints = NO;
    [backgroundLView.topAnchor constraintEqualToAnchor:OriginalLeftView.topAnchor constant:constraint/2.5].active = YES;
    [backgroundLView.leadingAnchor constraintEqualToAnchor:OriginalLeftView.leadingAnchor constant:constraint/2.5].active = YES;
    [backgroundLView.trailingAnchor constraintEqualToAnchor:OriginalLeftView.trailingAnchor constant:-constraint/2.5].active = YES;
    [backgroundLView.bottomAnchor constraintEqualToAnchor:OriginalLeftView.bottomAnchor constant:-constraint/2.5].active = YES;
    backgroundLView.backgroundColor = kC_Black;
    backgroundLView.layer.borderWidth = 0.5;
    backgroundLView.layer.borderColor = UIColor.redColor.CGColor;
    backgroundLView.layer.cornerRadius = 3;
    
    OriginalRightView = [[UIView alloc]init];
    [self.view addSubview: OriginalRightView];
    OriginalRightView.translatesAutoresizingMaskIntoConstraints = NO;
    [OriginalRightView.trailingAnchor constraintEqualToAnchor:_BpmEditView2_.trailingAnchor constant:ZeroValue].active = YES;
    [OriginalRightView.topAnchor constraintEqualToAnchor:_tempoRButton.topAnchor constant:ZeroValue].active = YES;
    [OriginalRightView.bottomAnchor constraintEqualToAnchor:_BpmEditView2_.topAnchor constant:ZeroValue].active = YES;
    [OriginalRightView.leadingAnchor constraintEqualToAnchor:_tempoRButton.leadingAnchor constant:ZeroValue].active = YES;
    OriginalRightView.backgroundColor = kColor_MixerButtonBGOff;
    OriginalRightView.hidden = YES;
    
    UIView *backgroundRView = [[UIView alloc] init];
    [OriginalRightView addSubview:backgroundRView];
    backgroundRView.translatesAutoresizingMaskIntoConstraints = NO;
    [backgroundRView.topAnchor constraintEqualToAnchor:OriginalRightView.topAnchor constant:constraint/2.5].active = YES;
    [backgroundRView.leadingAnchor constraintEqualToAnchor:OriginalRightView.leadingAnchor constant:constraint/2.5].active = YES;
    [backgroundRView.trailingAnchor constraintEqualToAnchor:OriginalRightView.trailingAnchor constant:-constraint/2.5].active = YES;
    [backgroundRView.bottomAnchor constraintEqualToAnchor:OriginalRightView.bottomAnchor constant:-constraint/2.5].active = YES;
    backgroundRView.backgroundColor = kC_Black;
    backgroundRView.layer.borderWidth = 0.5;
    backgroundRView.layer.borderColor = UIColor.redColor.CGColor;
    backgroundRView.layer.cornerRadius = 3;
    
    UILabel *originalLLable = [[UILabel alloc] init];
    originalLLable.text = kLSOriginal_BPM;
    originalLLable.textColor = kColor_White;
    originalLLable.textAlignment = NSTextAlignmentCenter;
    [backgroundLView addSubview:originalLLable];
    originalLLable.translatesAutoresizingMaskIntoConstraints = NO;
    [originalLLable.topAnchor constraintEqualToAnchor:backgroundLView.topAnchor constant:ZeroValue].active = YES;
    [originalLLable.leadingAnchor constraintEqualToAnchor:backgroundLView.leadingAnchor constant:ZeroValue].active = YES;
    [originalLLable.trailingAnchor constraintEqualToAnchor:backgroundLView.trailingAnchor constant:ZeroValue].active = YES;
    [originalLLable.heightAnchor constraintEqualToAnchor:backgroundLView.heightAnchor multiplier:0.4].active = YES;
    originalLLable.font = [UIFont fontWithName:kDefaultFont size:OriginalBPMEditText];
    
    UILabel *originalRLabel = [[UILabel alloc]init];
    [backgroundRView addSubview:originalRLabel];
    originalRLabel.text = kLSOriginal_BPM;
    originalRLabel.textColor = kColor_White;
    originalRLabel.textAlignment = NSTextAlignmentCenter;
    originalRLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [originalRLabel.topAnchor constraintEqualToAnchor:backgroundRView.topAnchor constant:ZeroValue].active = YES;
    [originalRLabel.leadingAnchor constraintEqualToAnchor:backgroundRView.leadingAnchor constant:ZeroValue].active = YES;
    [originalRLabel.trailingAnchor constraintEqualToAnchor:backgroundRView.trailingAnchor constant:ZeroValue].active = YES;
    [originalRLabel.heightAnchor constraintEqualToAnchor:backgroundRView.heightAnchor multiplier:0.4].active = YES;
    originalRLabel.font = [UIFont fontWithName:kDefaultFont size:OriginalBPMEditText];
    
    ///Text Field
    bpmLTextField = [[UITextField alloc]init];
    [backgroundLView addSubview:bpmLTextField];
    bpmLTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [bpmLTextField.topAnchor constraintEqualToAnchor:originalLLable.bottomAnchor constant:ZeroValue].active = YES;
    [bpmLTextField.leadingAnchor constraintEqualToAnchor:backgroundLView.leadingAnchor constant:ZeroValue].active = YES;
    [bpmLTextField.trailingAnchor constraintEqualToAnchor:backgroundLView.trailingAnchor constant:ZeroValue].active = YES;
    [bpmLTextField.bottomAnchor constraintEqualToAnchor:backgroundLView.bottomAnchor constant:ZeroValue].active = YES;
    bpmLTextField.text = _trackBpmLeftLabel.text;
    bpmLTextField.textColor = kColor_White;
    bpmLTextField.textAlignment = NSTextAlignmentCenter;
    bpmLTextField.userInteractionEnabled = NO;
    
    bpmRTextField = [[UITextField alloc]init];
    [backgroundRView addSubview:bpmRTextField];
    bpmRTextField.text = _trackBpmRightLabel.text;
    bpmRTextField.textAlignment = NSTextAlignmentCenter;
    bpmRTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [bpmRTextField.topAnchor constraintEqualToAnchor:originalRLabel.bottomAnchor constant:ZeroValue].active = YES;
    [bpmRTextField.leadingAnchor constraintEqualToAnchor:backgroundRView.leadingAnchor constant:ZeroValue].active = YES;
    [bpmRTextField.trailingAnchor constraintEqualToAnchor:backgroundRView.trailingAnchor constant:ZeroValue].active = YES;
    [bpmRTextField.bottomAnchor constraintEqualToAnchor:backgroundRView.bottomAnchor constant:ZeroValue].active = YES;
    bpmRTextField.textColor = kColor_White;
    bpmRTextField.userInteractionEnabled = NO;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *barSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnTap:)];
    toolbar.items = @[barSpace, doneBtn];
    [toolbar sizeToFit];
    bpmLTextField.inputAccessoryView = toolbar;
    bpmRTextField.inputAccessoryView = toolbar;
    bpmLTextField.tag = PLAYER_A;
    bpmRTextField.tag = PLAYER_B;
    
    //    bpmLTextField.delegate = self;
    [bpmLTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [bpmLTextField reloadInputViews];
    
    //    bpmRTextField.delegate = self;
    [bpmRTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [bpmRTextField reloadInputViews];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:PLAYER_A_MASTER_LBL]) {
        [_masterLeftButton setTitleColor:kColor_BpmButton forState:UIControlStateNormal];
        [_masterRightButton setTitleColor:kColor_MixerButtonTitleOff forState:UIControlStateNormal];
    }
    if ([[NSUserDefaults standardUserDefaults] integerForKey:PLAYER_B_MASTER_LBL]) {
        [_masterRightButton setTitleColor:kColor_BpmButton forState:UIControlStateNormal];
        [_masterLeftButton setTitleColor:kColor_MixerButtonTitleOff forState:UIControlStateNormal];
    }
}

#pragma mark TextField delegate

/**
 キーボード入力
 数値、小数点以外はダメ
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    if (string.length != 0 && [string rangeOfCharacterFromSet:set].location == NSNotFound) {
        return NO;
    }
    return YES;
}

- (void)doneBtnTap:(UIBarButtonItem *)sender {
    [bpmLTextField resignFirstResponder];
    [bpmRTextField resignFirstResponder];
}

/**
 キーボードリターン
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [bpmLTextField resignFirstResponder];
    [bpmRTextField resignFirstResponder];
    return YES;
}

/**
 テキスト編集終了
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BOOL ret = YES;
    ret = [self characterJudgment:textField.text tag:(int)textField.tag];
    if (ret) {
        [DJFunc getDJSystemFunction]->setTempBpm((int)textField.tag, [textField.text doubleValue]);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            float bpmValue = [DJFunc getDJSystemFunction]->getCurrentOutputBpm((int)textField.tag) / 100.0f;
            textField.text = [NSString stringWithFormat:@"%.2f", bpmValue];
            
            NSUInteger len = textField.text.length;
            NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:textField.text];
            if (len > 0) {
                CGFloat scale =  self->_MainScreenSizeWidth_ / 667.0f;
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:BpmLeftDot * scale] range:NSMakeRange(0, len - 1)];
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:BpmRightDot * scale] range:NSMakeRange(len - 1, 1)];
                
                if (textField.tag == PLAYER_A) {
                    self->_trackBpmLeftLabel.attributedText = str;
                    self->masterTempoLeftView.bpmLabel.attributedText = str;
                    self->bpmLTextField.attributedText = str;
                    self->PrevBpm1_ = bpmValue;
                } else {
                    self->_trackBpmRightLabel.attributedText = str;
                    self->masterTempoRightView.bpmLabel.attributedText = str;
                    self->bpmRTextField.attributedText = str;
                    self->PrevBpm2_ = bpmValue;
                }
            }
            
        });
    } else {
        textField.text = [NSString stringWithFormat:@"%.2f", ([DJFunc getDJSystemFunction]->getCurrentOutputBpm((int)textField.tag) / 100.0f)];
        if (textField.tag == PLAYER_A) {
            self->_trackBpmLeftLabel.text = textField.text;
            self->masterTempoLeftView.bpmLabel.text = textField.text;
        } else {
            self->_trackBpmRightLabel.text = textField.text;
            self->masterTempoRightView.bpmLabel.text = textField.text;
        }
    }
    if (ret) {
        [TrackingManager addEvent:TME_2bpm];
    }
    return ret;
}

- (BOOL)characterJudgment:(NSString *)str tag:(int)tag {
    BOOL ret = YES;
    
    int bpmx100 = [DJFunc getDJSystemFunction]->getBpmFromTime(tag);
    float originalBpm = bpmx100 / 100.0f;
    
    NSCharacterSet *textFieldCharacterSet = [NSCharacterSet characterSetWithCharactersInString:str];
    NSCharacterSet *stringCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    if ([stringCharacterSet isSupersetOfSet:textFieldCharacterSet]) {
        float changeBpm = [str floatValue];
        if (0 <= changeBpm && originalBpm * 2.0f < changeBpm) {
            NSString *message = kPLAYER_BPM_EDIT_EXCEED_ERROR;
            void (^okBlock)(void) = ^{
            };
            MessageAlertController *messageView = [[[MessageAlertController alloc] init] showWithTitle:@"" Message:message OKBlock:okBlock CancelBlock:nil];
            [self presentViewController:messageView.alertController animated:YES completion:nil];
            
            ret = NO;
        }
    } else {
        // TODO:ここには来ないと思われるけど数値じゃなかったら何か出す？
        ret = NO;
    }
    return ret;
}


#pragma mark - Mixer
- (void)setUpTapGesture {
    UITapGestureRecognizer *singleTapLeftView =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(ClearCurrentLoopLeft)];
    [deck1LoudWaveViewLandscape addGestureRecognizer:singleTapLeftView];
    UITapGestureRecognizer *singleTapRightView =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(ClearCurrentLoopRight)];
    [deck2LoudWaveViewLandscape addGestureRecognizer:singleTapRightView];
}

#pragma mark - Hot Cue Landscape
- (void)setupHotCueLandscape {
    /* set up notification hot cue left */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapCloseHotCueLeft) name:DidTapCloseHotCueLeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapDeleteHotCueLeft) name:DidTapDeleteHotCueLeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueALeft) name:DidTapHotCueALeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueBLeft) name:DidTapHotCueBLeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueCLeft) name:DidTapHotCueCLeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueDLeft) name:DidTapHotCueDLeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueELeft) name:DidTapHotCueELeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueFLeft) name:DidTapHotCueFLeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueGLeft) name:DidTapHotCueGLeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueHLeft) name:DidTapHotCueHLeft object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapBeatFxLeftScreen) name:DidTapBeatFxLeftScreen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupButtonPlayLHotcue:) name:SetupButtonPlayLeft object:nil];
    /* set up notification hot cue right */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapCloseHotCueRight) name:DidTapCloseHotCueRight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapDeleteHotCueRight) name:DidTapDeleteHotCueRight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueARight) name:DidTapHotCueARight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueBRight) name:DidTapHotCueBRight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueCRight) name:DidTapHotCueCRight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueDRight) name:DidTapHotCueDRight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueERight) name:DidTapHotCueERight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueFRight) name:DidTapHotCueFRight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueGRight) name:DidTapHotCueGRight object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapHotCueHRight) name:DidTapHotCueHRight object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapBeatFxRightScreen) name:DidTapBeatFxRightScreen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupButtonPlayRHotcue:) name:SetupButtonPlayRight object:nil];
}

#pragma mark - Notification Hot Cue
/* Hot cue left */
- (void) didTapCloseHotCueLeft {
    cueLeftView.hidden = YES;
    typeHotCueLeft = NO;
    [self changeSelectButton:true];
}

- (void) didTapDeleteHotCueLeft {
    typeHotCueLeft = !typeHotCueLeft;
}

- (void) didTapHotCueALeft {
    [self updateLoudWaveHotCue: PLAYER_A hotCueID:HOTCUEA];
    [self setupHotCue:PLAYER_A hotCue:HOTCUEA];
}

- (void) didTapHotCueBLeft {
    [self updateLoudWaveHotCue: PLAYER_A hotCueID:HOTCUEB];
    [self setupHotCue:PLAYER_A hotCue:HOTCUEB];
}

- (void) didTapHotCueCLeft {
    [self updateLoudWaveHotCue: PLAYER_A hotCueID:HOTCUEC];
    [self setupHotCue:PLAYER_A hotCue:HOTCUEC];
}

- (void) didTapHotCueDLeft {
    [self updateLoudWaveHotCue: PLAYER_A hotCueID:HOTCUED];
    [self setupHotCue:PLAYER_A hotCue:HOTCUED];
}

- (void) didTapHotCueELeft {
    [self updateLoudWaveHotCue: PLAYER_A hotCueID:HOTCUEE];
    [self setupHotCue:PLAYER_A hotCue:HOTCUEE];
}

- (void) didTapHotCueFLeft {
    [self updateLoudWaveHotCue: PLAYER_A hotCueID:HOTCUEF];
    [self setupHotCue:PLAYER_A hotCue:HOTCUEF];
}

- (void) didTapHotCueGLeft {
    [self updateLoudWaveHotCue: PLAYER_A hotCueID:HOTCUEG];
    [self setupHotCue:PLAYER_A hotCue:HOTCUEG];
}

- (void) didTapHotCueHLeft {
    [self updateLoudWaveHotCue: PLAYER_A hotCueID:HOTCUEH];
    [self setupHotCue:PLAYER_A hotCue:HOTCUEH];
}

/* Hot cue right */
- (void) didTapCloseHotCueRight {
    cueRightView.hidden = YES;
    typeHotCueRight = NO;
    [self changeSelectButton:false];
}

- (void) didTapDeleteHotCueRight {
    typeHotCueRight = !typeHotCueRight;
}

- (void) didTapHotCueARight {
    [self updateLoudWaveHotCue: PLAYER_B hotCueID:HOTCUEA];
    [self setupHotCue:PLAYER_B hotCue:HOTCUEA];
}

- (void) didTapHotCueBRight {
    [self updateLoudWaveHotCue: PLAYER_B hotCueID:HOTCUEB];
    [self setupHotCue:PLAYER_B hotCue:HOTCUEB];
}

- (void) didTapHotCueCRight {
    [self updateLoudWaveHotCue: PLAYER_B hotCueID:HOTCUEC];
    [self setupHotCue:PLAYER_B hotCue:HOTCUEC];
}

- (void) didTapHotCueDRight {
    [self updateLoudWaveHotCue: PLAYER_B hotCueID:HOTCUED];
    [self setupHotCue:PLAYER_B hotCue:HOTCUED];
}

- (void) didTapHotCueERight {
    [self updateLoudWaveHotCue: PLAYER_B hotCueID:HOTCUEE];
    [self setupHotCue:PLAYER_B hotCue:HOTCUEE];
}

- (void) didTapHotCueFRight {
    [self updateLoudWaveHotCue: PLAYER_B hotCueID:HOTCUEF];
    [self setupHotCue:PLAYER_B hotCue:HOTCUEF];
}

- (void) didTapHotCueGRight {
    [self updateLoudWaveHotCue: PLAYER_B hotCueID:HOTCUEG];
    [self setupHotCue:PLAYER_B hotCue:HOTCUEG];
}

- (void) didTapHotCueHRight {
    [self updateLoudWaveHotCue: PLAYER_B hotCueID:HOTCUEH];
    [self setupHotCue:PLAYER_B hotCue:HOTCUEH];
}

/* Set play button when click hotcue */
- (void) setupButtonPlayLHotcue:(NSNotification*)notification {
    NSDictionary *dictionary = [notification userInfo];
    BOOL boolValue =[[dictionary valueForKey:@"PlayButtonL"] boolValue];
    if (!boolValue) {
        [self didTapPlayLButton];
    }
}
- (void) setupButtonPlayRHotcue:(NSNotification*)notification {
    NSDictionary *dictionary = [notification userInfo];
    BOOL boolValue =[[dictionary valueForKey:@"PlayButtonR"] boolValue];
    if (!boolValue) {
        [self didTapPlayRButton];
    }
}
#pragma mark - Set up Current Cue
/**
 全体波形Current Cue更新
 */

- (void)setLoudWaveCurrentCueView {
    int inTimeA = (int) [[NSUserDefaults standardUserDefaults] integerForKey:InTime_LoudWave_CurrentCueA];
    int inTimeB = (int) [[NSUserDefaults standardUserDefaults] integerForKey:InTime_LoudWave_CurrentCueB];
    
    int posA = [self loudWavePositionPercents:(int)inTimeA totalTime:self.DJSystemFunction_->getTotalTime(PLAYER_A) player:PLAYER_A];
    if (0 <= posA && posA <= deck1LoudWaveViewLandscape.waveView.frame.size.width) {
        CGRect rectA = deck1LoudWaveViewLandscape.WaveLoudCueMarker_.frame;
        rectA.origin.x = posA - rectA.size.width / 2.0f - 1;
        rectA.origin.y = deck1LoudWaveViewLandscape.posUIView_.frame.size.height + 2;
        deck1LoudWaveViewLandscape.WaveLoudCueMarker_.frame = rectA;
        deck1LoudWaveViewLandscape.WaveLoudCueMarker_.hidden = NO;
    }
    
    int posB = [self loudWavePositionPercents:(int)inTimeB totalTime:self.DJSystemFunction_->getTotalTime(PLAYER_B)player:PLAYER_B];
    if (0 <= posB && posB <= deck2LoudWaveViewLandscape.waveView.frame.size.width) {
        CGRect rectB = deck2LoudWaveViewLandscape.WaveLoudCueMarker_.frame;
        rectB.origin.x = posB - rectB.size.width / 2.0f - 1;
        rectB.origin.y = deck2LoudWaveViewLandscape.posUIView_.frame.size.height + 2;
        deck2LoudWaveViewLandscape.WaveLoudCueMarker_.frame = rectB;
        deck2LoudWaveViewLandscape.WaveLoudCueMarker_.hidden = NO;
    }
}

- (void)ClearCurrentLoopLeft {
    [loopLeftView setUnSelectedButton];
    [loopLeftView changeWave];
}

- (void)ClearCurrentLoopRight {
    [loopRightView setUnSelectedButton];
    [loopRightView changeWave];
}

#pragma mark - Set up Hot Cue
/**
 全体波形Memory Cue更新
 */
- (void)updateLoudWaveMemoryCue:(int)playerID memorycueID:(int)memoryCueID {
    djplay::DJCueData data = [DJFunc getDJSystemFunction]->getMemoryCueItem(playerID, static_cast<uint32>(memoryCueID));
    int pos = [self loudWavePositionPercents:(int)data.inMsec totalTime:[DJFunc getDJSystemFunction]->getTotalTime(playerID) player:playerID];
    
    if (0 <= pos && pos <= deck2LoudWaveViewLandscape.waveView.frame.size.width) {
        if (data.hotCueStatusID != djplay::HotCueStatusID_None) {
            CGRect rect = deck2LoudWaveViewLandscape.memoryCueViews_A[static_cast<NSUInteger>(memoryCueID)].frame;
            rect.origin.x = pos - rect.size.width / 2.0f - 1;
            rect.size.height = deck2LoudWaveViewLandscape.posUIView_.frame.size.height;
            deck2LoudWaveViewLandscape.memoryCueViews_A[static_cast<NSUInteger>(memoryCueID)].frame = rect;
            deck2LoudWaveViewLandscape.memoryCueViews_A[static_cast<NSUInteger>(memoryCueID)].hidden = NO;
            
            if (data.hotCueStatusID == djplay::HotCueStatusID_ActiveLoop) {
                [deck2LoudWaveViewLandscape.memoryCueViews_A[static_cast<NSUInteger>(memoryCueID)] setMemCueActiveLoop:YES];
            } else {
                [deck2LoudWaveViewLandscape.memoryCueViews_A[static_cast<NSUInteger>(memoryCueID)] setMemCueActiveLoop:NO];
            }
        } else {
            deck2LoudWaveViewLandscape.memoryCueViews_A[static_cast<NSUInteger>(memoryCueID)].hidden = YES;
            deck2LoudWaveViewLandscape.memoryCueViews_A[static_cast<NSUInteger>(memoryCueID)].hidden = YES;
        }
    } else {
        deck2LoudWaveViewLandscape.memoryCueViews_A[static_cast<NSUInteger>(memoryCueID)].hidden = YES;
        deck2LoudWaveViewLandscape.memoryCueViews_A[static_cast<NSUInteger>(memoryCueID)].hidden = YES;
    }
}

/**
 全体波形Hot Cue更新
 */
- (void)updateLoudWaveHotCue:(int)playerID hotCueID:(int)hcID {
    djplay::DJCueData data = [DJFunc getDJSystemFunction]->getHotCueItem(playerID, static_cast<uint32>(hcID));
    UIColor *color = kC_HotCue_CDJ;
    if (data.hotCueStatusID == djplay::HotCueStatusID_Loop ||
        data.hotCueStatusID == djplay::HotCueStatusID_ActiveLoop) {
        color = kC_HotCue_Loop;
    }
    if (data.colorTblIdx > 0) {
        color = RB_HOTCUE_COLOR_ARRAY[data.colorTblIdx];
    }
    int pos = [self loudWavePositionPercents:(int)data.inMsec totalTime:[DJFunc getDJSystemFunction]->getTotalTime(playerID) player:playerID];
    if (playerID == PLAYER_A) {
        if (0 <= pos && pos <= deck1LoudWaveViewLandscape.waveView.frame.size.width) {
            if (data.hotCueStatusID == djplay::HotCueStatusID_Loop ||
                data.hotCueStatusID == djplay::HotCueStatusID_ActiveLoop) {
                CGRect rect = deck1LoudWaveViewLandscape.hotCueStringViews_A[hcID].frame;
                rect.origin.x = pos - rect.size.width / 2.0f;
                deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[hcID].frame = rect;
                deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[hcID].hidden = NO;
                deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[hcID].backgroundColor = color;
            } else if (data.hotCueStatusID == djplay::HotCueStatusID_Cue) {
                CGRect rect = deck1LoudWaveViewLandscape.hotCueStringViews_A[hcID].frame;
                rect.origin.x = pos - rect.size.width / 2.0f;
                deck1LoudWaveViewLandscape.hotCueStringViews_A[hcID].frame = rect;
                deck1LoudWaveViewLandscape.hotCueStringViews_A[hcID].hidden = NO;
                deck1LoudWaveViewLandscape.hotCueStringViews_A[hcID].backgroundColor = color;
            } else {
                deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[hcID].hidden = YES;
                deck1LoudWaveViewLandscape.hotCueStringViews_A[hcID].hidden = YES;
            }
        } else {
            deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[hcID].hidden = YES;
            deck1LoudWaveViewLandscape.hotCueStringViews_A[hcID].hidden = YES;
        }
    } else {
        if (0 <= pos && pos <= deck2LoudWaveViewLandscape.waveView.frame.size.width) {
            if (data.hotCueStatusID == djplay::HotCueStatusID_Loop ||
                data.hotCueStatusID == djplay::HotCueStatusID_ActiveLoop) {
                CGRect rect = deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[hcID].frame;
                rect.origin.x = pos - rect.size.width / 2.0f;
                deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[hcID].frame = rect;
                deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[hcID].hidden = NO;
                deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[hcID].backgroundColor = color;
            } else if (data.hotCueStatusID == djplay::HotCueStatusID_Cue) {
                CGRect rect = deck2LoudWaveViewLandscape.hotCueStringViews_B[hcID].frame;
                rect.origin.x = pos - rect.size.width / 2.0f;
                deck2LoudWaveViewLandscape.hotCueStringViews_B[hcID].frame = rect;
                deck2LoudWaveViewLandscape.hotCueStringViews_B[hcID].hidden = NO;
                deck2LoudWaveViewLandscape.hotCueStringViews_B[hcID].backgroundColor = color;
            } else {
                deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[hcID].hidden = YES;
                deck2LoudWaveViewLandscape.hotCueStringViews_B[hcID].hidden = YES;
            }
        } else {
            deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[hcID].hidden = YES;
            deck2LoudWaveViewLandscape.hotCueStringViews_B[hcID].hidden = YES;
        }
    }
}

/* Call hot cue in library */
- (void)setupHotCue:(int)player hotCue:(int)cue {
    if (player == PLAYER_A) {
        if (typeHotCueLeft) {
            [DJFunc getDJSystemFunction]->deleteHotcue(player, cue);
            for(int i=0; i<[listCueArrayLeft count]; i++) {
                if ([listCueArrayLeft[i] intValue] == cue) {
                    [listCueArrayLeft removeObjectAtIndex:i];
                }
            }
        } else  {
            [DJFunc getDJSystemFunction]->hotcueButtonDown(player, cue);
        }
    } else {
        if (typeHotCueRight) {
            [DJFunc getDJSystemFunction]->deleteHotcue(PLAYER_B, cue);
            for(int i=0; i<[listCueArrayRight count]; i++) {
                if ([listCueArrayRight[i] intValue] == cue) {
                    [listCueArrayRight removeObjectAtIndex:i];
                }
            }
        } else  {
            [DJFunc getDJSystemFunction]->hotcueButtonDown(PLAYER_B, cue);
        }
    }
}

/* Hidden hotcue when play screen */
- (void)updatePlayHotcue: (int)playerView {
    for (int i = 0; i < 8; i++) {
        djplay::DJCueData data = [DJFunc getDJSystemFunction]->getHotCueItem(playerView, i);
        int pos = [self loudWavePositionPercents:(int)data.inMsec totalTime:[DJFunc getDJSystemFunction]->getTotalTime(playerView) player:playerView];
        UIColor *color = kC_HotCue_CDJ;
        if (data.hotCueStatusID == djplay::HotCueStatusID_Loop ||
            data.hotCueStatusID == djplay::HotCueStatusID_ActiveLoop) {
            color = kC_HotCue_Loop;
        }
        if (data.colorTblIdx > 0) {
            color = RB_HOTCUE_COLOR_ARRAY[data.colorTblIdx];
        }
        if (playerView == PLAYER_A) {
            if (0 <= pos && pos <= deck1LoudWaveViewLandscape.waveView.frame.size.width) {
                if (data.hotCueStatusID == djplay::HotCueStatusID_Loop ||
                    data.hotCueStatusID == djplay::HotCueStatusID_ActiveLoop) {
                    CGRect rect = deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[i].frame;
                    rect.origin.x = pos - rect.size.width / 2.0f;
                    deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[i].frame = rect;
                    deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[i].hidden = NO;
                    deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[i].backgroundColor = color;
                    [self addListCue:i cueView: PLAYER_A];
                } else if (data.hotCueStatusID == djplay::HotCueStatusID_Cue) {
                    CGRect rect = deck1LoudWaveViewLandscape.hotCueStringViews_A[i].frame;
                    rect.origin.x = pos - rect.size.width / 2.0f;
                    deck1LoudWaveViewLandscape.hotCueStringViews_A[i].frame = rect;
                    deck1LoudWaveViewLandscape.hotCueStringViews_A[i].hidden = NO;
                    deck1LoudWaveViewLandscape.hotCueStringViews_A[i].backgroundColor = color;
                    [self addListCue:i cueView: PLAYER_A];
                } else {
                    deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[i].hidden = YES;
                    deck1LoudWaveViewLandscape.hotCueStringViews_A[i].hidden = YES;
                }
            } else {
                deck1LoudWaveViewLandscape.hotCueStringViews_A[i].hidden = YES;
                deck1LoudWaveViewLandscape.hotCueLoopStringViews_A[i].hidden = YES;
            }
        } else {
            if (0 <= pos && pos <= deck2LoudWaveViewLandscape.waveView.frame.size.width) {
                if (data.hotCueStatusID == djplay::HotCueStatusID_Loop ||
                    data.hotCueStatusID == djplay::HotCueStatusID_ActiveLoop) {
                    CGRect rect = deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[i].frame;
                    rect.origin.x = pos - rect.size.width / 2.0f;
                    deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[i].frame = rect;
                    deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[i].hidden = NO;
                    deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[i].backgroundColor = color;
                    [self addListCue:i cueView: PLAYER_B];
                } else if (data.hotCueStatusID == djplay::HotCueStatusID_Cue) {
                    CGRect rect = deck2LoudWaveViewLandscape.hotCueStringViews_B[i].frame;
                    rect.origin.x = pos - rect.size.width / 2.0f;
                    deck2LoudWaveViewLandscape.hotCueStringViews_B[i].frame = rect;
                    deck2LoudWaveViewLandscape.hotCueStringViews_B[i].hidden = NO;
                    deck2LoudWaveViewLandscape.hotCueStringViews_B[i].backgroundColor = color;
                    [self addListCue:i cueView: PLAYER_B];
                } else {
                    deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[i].hidden = YES;
                    deck2LoudWaveViewLandscape.hotCueStringViews_B[i].hidden = YES;
                }
            } else {
                deck2LoudWaveViewLandscape.hotCueStringViews_B[i].hidden = YES;
                deck2LoudWaveViewLandscape.hotCueLoopStringViews_B[i].hidden = YES;
            }
        }
    }
}

- (void) addListCue:(int) cue cueView:(int) view {
    NSNumber *cueNumber = @(cue);
    if (view == PLAYER_A) {
        [listCueArrayLeft addObject:cueNumber];
    } else {
        [listCueArrayRight addObject:cueNumber];
    }
}


#pragma mark - WaveView Landscape

- (void) setupData:(NSDictionary*)data forPlayerID:(int)playerID{
    
    NSArray* maxValue   = data[MaxValue];
    NSArray* minValue   = data[MinValue];
    NSArray* colorValue = data[ColorValue];
    NSArray* lowValue   = data[LowValue];
    NSArray* midValue   = data[MidValue];
    NSArray* highValue  = data[HighValue];
    int validDataNum    = [data[ValidDataNum] intValue];
    
    int *all_max   = new int[1200];       memset(all_max, 0, sizeof(int) * 1200);
    int *all_min   = new int[1200];       memset(all_min, 0, sizeof(int) * 1200);
    int *color_max = new int[1200];     memset(color_max, 0, sizeof(int) * 1200);
    int *low_max   = new int[1200];       memset(low_max, 0, sizeof(int) * 1200);
    int *mid_max   = new int[1200];       memset(mid_max, 0, sizeof(int) * 1200);
    int *high_max  = new int[1200];      memset(high_max, 0, sizeof(int) * 1200);
    
    for(int i = 0; i < validDataNum; i++) {
        all_max[i]      = [maxValue[i] intValue];
        all_min[i]      = [minValue[i] intValue];
        color_max[i]    = [colorValue[i] intValue];
        low_max[i]      = [lowValue[i] intValue];
        mid_max[i]      = [midValue[i] intValue];
        high_max[i]     = [highValue[i] intValue];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LoudWaveDataStruce loudWaveData = {all_max, all_min, color_max, low_max, mid_max, high_max, validDataNum, 0, 0, NO, 0, 0, 0, 1200};
        [self updateLoudWave:playerID LoudWaveData:loudWaveData];
        if (all_max) delete [] all_max;
        if (all_min) delete [] all_min;
        if (color_max) delete [] color_max;
        if (low_max) delete [] low_max;
        if (mid_max) delete [] mid_max;
        if (high_max) delete [] high_max;
    });
    
}

- (void)setupWaveViewLandscape {
    [self waveColorChange:self.waveColor];
    [self clearLoudWave:PLAYER_A];
    [self clearLoudWave:PLAYER_B];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDictionary* dataA = [prefs objectForKey:Loud_Data_A];
    [self setupData:dataA forPlayerID:PLAYER_A];
    [deck1LoudWaveViewLandscape createposUIView];
    
    NSDictionary* dataB = [prefs objectForKey:Loud_Data_B];
    [self setupData:dataB forPlayerID:PLAYER_B];
    [deck2LoudWaveViewLandscape createposUIView];
}

- (void)waveColorChange:(int)colorID {
    [deck1LoudWaveViewLandscape.waveView setNeedsDisplay];
    [deck2LoudWaveViewLandscape.waveView setNeedsDisplay];
}

- (void)clearLoudWave:(int)playerID {
    if (playerID == PLAYER_A) {
        [deck1LoudWaveViewLandscape clearLoud];
    } else if (playerID == PLAYER_B) {
        [deck2LoudWaveViewLandscape clearLoud];
    }
}

/**
 全体波形上の展開情報位置更新
 */
- (void)updateLoudWavePhrase:(int)playerID {
    int phraseTime = 0;
    int playTime = [DJFunc getDJSystemFunction]->getPlayingTime(playerID);
    
    NSUInteger count = playerID == 0 ? _PhraseArray1.count : _PhraseArray2.count;
    if (count > 0) {
        NSDictionary *dict = nil;
        for (int i = 0; i <= count; i++) {
            if (i == count) {
                if (playerID == 0) {
                    dict = _PhraseArray1[static_cast<NSUInteger>(i - 1)];
                    phraseTime = _beats1_[[dict[@"startPos"] intValue] - 1].Time;
                    
                } else {
                    dict = _PhraseArray2[static_cast<NSUInteger>(i - 1)];
                    phraseTime = _beats2_[[dict[@"startPos"] intValue] - 1].Time;
                }
            } else {
                if (playerID == 0) {
                    dict = _PhraseArray1[i];
                    phraseTime = _beats1_[[dict[@"startPos"] intValue] - 1].Time;
                    
                } else {
                    dict = _PhraseArray2[i];
                    phraseTime = _beats2_[[dict[@"startPos"] intValue] - 1].Time;
                }
            }
            
            if (playTime < phraseTime || i == count) {
                NSArray *colors;
                if ([dict[@"genre"] intValue] == 1) {
                    switch ([dict[@"phraseID"] intValue]) {
                        case 1: //INTRO
                            colors = @[@(128.f/255.f), @(32.f/255.f), @(0.f/255.f), @1.f];
                            break;
                            
                        case 2: //UP
                            colors = @[@(128.f/255.f), @(0.f/255.f), @(128.f/255.f), @1.f];
                            break;
                            
                        case 3: //DOWN
                            colors = @[@(128.f/255.f), @(104.f/255.f), @(64.f/255.f), @1.f];
                            break;
                            
                        case 5: //CHORUS
                            colors = @[@(11.f/255.f), @(128.f/255.f), @(0.f/255.f), @1.f];
                            break;
                            
                        case 6: //OUTRO
                            colors = @[@(0.f/255.f), @(128.f/255.f), @(128.f/255.f), @1.f];
                            break;
                            
                        default:
                            colors = @[@(255.f/255.f), @(255.f/255.f), @(255.f/255.f), @1.f];
                            break;
                    }
                } else if ([dict[@"genre"] intValue] == 2 || [dict[@"genre"] intValue] == 3) {
                    switch ([dict[@"phraseID"] intValue]) {
                        case 1: //INTRO
                            colors = @[@(128.f/255.f), @(32.f/255.f), @(0.f/255.f), @1.f];
                            break;
                            
                        case 2: //VERSE1
                            colors = @[@(0.f/255.f), @(0.f/255.f), @(128.f/255.f), @1.f];
                            break;
                            
                        case 3: //VERSE2
                            colors = @[@(0.f/255.f), @(0.f/255.f), @(128.f/255.f), @1.f];
                            break;
                            
                        case 4: //VERSE3
                            colors = @[@(0.f/255.f), @(0.f/255.f), @(128.f/255.f), @1.f];
                            break;
                            
                        case 5: //VERSE4
                            colors = @[@(0.f/255.f), @(0.f/255.f), @(128.f/255.f), @1.f];
                            break;
                            
                        case 6: //VERSE5
                            colors = @[@(0.f/255.f), @(0.f/255.f), @(128.f/255.f), @1.f];
                            break;
                            
                        case 7: //VERSE6
                            colors = @[@(0.f/255.f), @(0.f/255.f), @(128.f/255.f), @1.f];
                            break;
                            
                        case 8: //BRIDGE
                            colors = @[@(128.f/255.f), @(121.f/255.f), @(37.f/255.f), @1.f];
                            break;
                            
                        case 9: //CHORUS
                            colors = @[@(11.f/255.f), @(128.f/255.f), @(0.f/255.f), @1.f];
                            break;
                            
                        case 10: //OUTRO
                            colors = @[@(0.f/255.f), @(128.f/255.f), @(128.f/255.f), @1.f];
                            break;
                            
                        default:
                            colors = @[@(255.f/255.f), @(255.f/255.f), @(255.f/255.f), @1.f];
                            break;
                    }
                }
                
#if ENABLE_SONGSTRUCT_FUNCTION
                if (playerID == 0) {
                    deck1LoudWaveViewLandscape.WaveLoudPhraseMarker_.phraseColor = colors.copy;
                } else {
                    deck2LoudWaveViewLandscape.WaveLoudPhraseMarker_.phraseColor = colors.copy;
                }
#endif
                break;
            }
        }
    }
    
    //    [DeckDJSystemUpdateCUE updatePhrasePoint:playerID
    //                                     inPoint:phraseTime];
}

/**
 展開情報が更新されるたびに呼ばれる
 */
- (void)updatePhrase:(int)playerID isClear:(bool)isClear num:(int)num genre:(int)genre phraseID:(int)phraseID startPos:(int)startPos songEndPos:(int)songEndPos {
    
    //    if (playerID == 0 && num >= 0) {
    //        _DeckBtnBPM.isDisplayPhrase1_ = YES;
    //    } else if (playerID == 1 && num >= 0) {
    //        _DeckBtnBPM.isDisplayPhrase2_ = YES;
    //    }
    
    // DLog(@"num:%d genre:%d phraseID:%d startPos:%d songEndPos:%d", num, genre, phraseID, startPos, songEndPos);
    NSDictionary *dict = @{@"genre":[NSNumber numberWithInt:genre],
                           @"phraseID":[NSNumber numberWithInt:phraseID],
                           @"startPos":[NSNumber numberWithInt:startPos],
                           @"songEndPos":[NSNumber numberWithInt:songEndPos]};
    
    if (playerID == 0) {
        if (isClear) {
            [_PhraseArray1 removeAllObjects];
            if (num > 0) {
                [_PhraseArray1 addObject:dict];
            }
        }
        if (_PhraseArray1.count > 0) {
            NSDictionary *preAddDict = _PhraseArray1[_PhraseArray1.count - 1];
            int preGenre = [preAddDict[@"genre"] intValue];
            int prePhraseID = [preAddDict[@"phraseID"] intValue];
            if (preGenre != genre || prePhraseID != phraseID) {
                if (genre != 1 &&
                    (2 <= phraseID && phraseID <= 7) &&
                    (2 <= prePhraseID && prePhraseID <= 7)) {
                    return;
                }
                [_PhraseArray1 addObject:dict];
            }
        }
    } else {
        if (isClear) {
            [_PhraseArray2 removeAllObjects];
            if (num > 0) {
                [_PhraseArray2 addObject:dict];
            }
        }
        if (_PhraseArray2.count > 0) {
            NSDictionary *preAddDict = _PhraseArray2[_PhraseArray2.count - 1];
            int preGenre = [preAddDict[@"genre"] intValue];
            int prePhraseID = [preAddDict[@"phraseID"] intValue];
            if (preGenre != genre || prePhraseID != phraseID) {
                if (genre != 1 &&
                    (2 <= phraseID && phraseID <= 7) &&
                    (2 <= prePhraseID && prePhraseID <= 7)) {
                    return;
                }
                [_PhraseArray2 addObject:dict];
            }
        }
    }
}

#pragma mark - Update Wave
- (int)loudWavePositionPercents:(int)tm totalTime:(int)totalTime player:(int) player {
    if (tm < 0 || totalTime == 0) {
        return -1;
    }
    if ((totalTime - tm <= 50) && (![[NSUserDefaults standardUserDefaults] boolForKey:Flag_Display_Portrait])) {
        [DJFunc getDJSystemFunction]->playOFFButton(player);
        if(player == PLAYER_A) {
            _btnPlayLeft.selected = NO;
        } else {
            _btnPlayRight.selected = NO;
        }
    }
    float per = (float)tm / (float)totalTime;
    if (player == PLAYER_A) {
        int pos = (int)(deck1LoudWaveViewLandscape.posUIView_.frame.size.width * per);
        if (pos < 0) {
            pos = 0;
        }
        return pos;
    } else {
        int posB = (int)(deck2LoudWaveViewLandscape.posUIView_.frame.size.width * per);
        if (posB < 0) {
            posB = 0;
        }
        return posB;
    }
}

- (int)loudWavePositionPercent:(int)tm totalTime:(int)totalTIme {
    float per = (float)tm / (float)totalTIme;
    int pos = (int)(LOUD_VIEW_W * (_ScreenSize_.width / 667.0f) * per);
    if (pos < 0) {
        pos = 0;
    }
    return pos;
}

#pragma mark - Set up Loop

/**
 全体波形Loop更新
 */
- (void)updateLoudWaveLoopPoint {
    int inTimeA = (int) [[NSUserDefaults standardUserDefaults] integerForKey:InTime_LoudWave_LoopPointA];
    int outTimeA = (int) [[NSUserDefaults standardUserDefaults] integerForKey:OutTime_LoudWave_LoopPointA];
    int totalTimeA = (int) [[NSUserDefaults standardUserDefaults] integerForKey:TotalTime_LoudWave_LoopPointA];
    bool isActiveA = [[NSUserDefaults standardUserDefaults] boolForKey:IsAcvite_LoudWave_LoopPointA];
    int inTimeB = (int) [[NSUserDefaults standardUserDefaults] integerForKey:InTime_LoudWave_LoopPointB];
    int outTimeB = (int) [[NSUserDefaults standardUserDefaults] integerForKey:OutTime_LoudWave_LoopPointB];
    int totalTimeB = (int) [[NSUserDefaults standardUserDefaults] integerForKey:TotalTime_LoudWave_LoopPointB];
    bool isActiveB = [[NSUserDefaults standardUserDefaults] boolForKey:IsAcvite_LoudWave_LoopPointB];
    WaveLoudViewLandscape *loudWaveView;
    for (int i = 0; i < 2; i++) {
        int inPos = 0;
        int outPos = 0;
        if (i == PLAYER_A) {
            loudWaveView = deck1LoudWaveViewLandscape;
            inPos = [self loudWavePositionPercents:inTimeA totalTime:totalTimeA player:PLAYER_A];
            outPos = [self loudWavePositionPercents:outTimeA totalTime:totalTimeA player:PLAYER_A];
        } else {
            loudWaveView = deck2LoudWaveViewLandscape;
            inPos = [self loudWavePositionPercents:inTimeB totalTime:totalTimeB player:PLAYER_B];
            outPos = [self loudWavePositionPercents:outTimeB totalTime:totalTimeB player:PLAYER_B];
        }
        if (0 <= inPos && inPos <= loudWaveView.frame.size.width) {
            if (0 <= outPos && outPos <= loudWaveView.frame.size.width) {
                if (inPos <= outPos) {
                    if (i == PLAYER_A) {
                        if (isActiveA) {
                            loudWaveView.LoopView_.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:163.0f/255.0f blue:0.0f/255.0f alpha:0.3f];
                            [loopLeftView setSelectedLoopButton];
                        } else {
                            loudWaveView.LoopView_.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.2f];
                            [loopLeftView setUnSelectedLoopButton];
                        }
                    } else {
                        if (isActiveB) {
                            loudWaveView.LoopView_.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:163.0f/255.0f blue:0.0f/255.0f alpha:0.3f];
                            [loopRightView setSelectedLoopButton];
                        } else {
                            loudWaveView.LoopView_.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.2f];
                            [loopRightView setUnSelectedLoopButton];
                        }
                    }
                    CGRect rect = loudWaveView.LoopView_.frame;
                    rect.origin.x = inPos;
                    rect.size.width = outPos - inPos;
                    rect.size.height = loudWaveView.posUIView_.frame.size.height;
                    loudWaveView.LoopView_.frame = rect;
                    loudWaveView.LoopView_.hidden = NO;
                } else {
                    loudWaveView.LoopView_.hidden = YES;
                }
            } else {
                loudWaveView.LoopView_.hidden = YES;
            }
        } else {
            loudWaveView.LoopView_.hidden = YES;
        }
    }
}

#ifndef WAVE_DATA_STRUCT
- (void)updateLoudWave:(int)playerID
          LoudWaveData:(LoudWaveDataStruce)loudWaveData {
    if (playerID == PLAYER_A) {
        deck1LoudWaveViewLandscape.hidden = NO;
        [deck1LoudWaveViewLandscape onLoud:loudWaveData];
        [deck1LoudWaveViewLandscape minuteScaleDraw:[DJFunc getDJSystemFunction]->getTotalTime(playerID)];
    } else if (playerID == PLAYER_B) {
        deck2LoudWaveViewLandscape.hidden = NO;
        [deck2LoudWaveViewLandscape onLoud:loudWaveData];
        [deck2LoudWaveViewLandscape minuteScaleDraw:[DJFunc getDJSystemFunction]->getTotalTime(playerID)];
    }
}
#else // WAVE_DATA_STRUCT
- (void)updateLoudWave:(int)playerID
                 start:(int)startValue
                   end:(int)endValue
                   max:(int*)maxValue
                   min:(int*)minValue
                 color:(int*)colorValue
                   low:(int*)lowValue
                   mid:(int*)midValue
                  high:(int*)highValue
                   pos:(int*)posValue
                   num:(int)numValue
                remain:(bool)remainValue
                   fps:(int)fpsValue
                   len:(int)lenValue {
    if (playerID == PLAYER_A) {
        [deck1LoudWaveView onLoud:0
                              end:endValue
                              max:const_cast<int*>(maxValue)
                              min:const_cast<int*>(minValue)
                            color:const_cast<int*>(colorValue)
                              low:const_cast<int*>(lowValue)
                              mid:const_cast<int*>(midValue)
                             high:const_cast<int*>(highValue)
                              pos:0
                              num:0
                           remain:NO
                              fps:0
                              len:0];
    } else if (playerID == PLAYER_B) {
        [deck2LoudWaveView onLoud:0
                              end:endValue
                              max:const_cast<int*>(maxValue)
                              min:const_cast<int*>(minValue)
                            color:const_cast<int*>(colorValue)
                              low:const_cast<int*>(lowValue)
                              mid:const_cast<int*>(midValue)
                             high:const_cast<int*>(highValue)
                              pos:0
                              num:0
                           remain:NO
                              fps:0
                              len:0];
    }
}

#endif // WAVE_DATA_STRUCT

#pragma mark - Timer
/**
 いろいろな状態確認タイマー
 100msec周期
 */

- (void)playingTimer:(NSTimer *)tm {
    int totalPlayTimeA = [DJFunc getDJSystemFunction]->getTotalTime(PLAYER_A);
    int totalPlayTimeB = [DJFunc getDJSystemFunction]->getTotalTime(PLAYER_B);
    [self updatePlayingTime:PLAYER_A TotalPlayTime:totalPlayTimeA];
    [self updatePlayingTime:PLAYER_B TotalPlayTime:totalPlayTimeB];
}

- (void)stateConfirmTimer:(NSTimer *)tm {
    // Deck 1
    [self tempoRangeBtnState:nil state:[DJFunc getDJSystemFunction]->getTempoRangeValue(0) deck:0];
    // Deck 2
    [self tempoRangeBtnState:nil state:[DJFunc getDJSystemFunction]->getTempoRangeValue(1) deck:1];
    // BPM取得
    [self bpmConfirm:PLAYER_A];
    [self bpmConfirm:PLAYER_B];
    
    if (_PhraseArray1.count > 0) {
        [self updateLoudWavePhrase:0];
    }
    if (_PhraseArray2.count > 0) {
        [self updateLoudWavePhrase:1];
    }
    
    if (_PerformanceViewArray2_) {
        ConnectDevice connectedDevice = [PlayerStateRepository sharedInstance].connectedDeviceType;
        if ([PlayerStateRepository sharedInstance].hasConnectedToDevice && (connectedDevice == CONNECT_WeGO4 || connectedDevice == CONNECT_WeGO3)) {
            // TODO: not supported
        } else {
            if (_PerformanceViewDisp2_) {
                PerformanceLoopView* uv = _PerformancePanelArray2_[PERFORMANCE_LOOP];
                [uv confirmView:1];
            }
            PerformanceHeaderView* PfrmView2 = _PerformanceViewArray2_[0];
            if (DisplayMode_ == JOG) {
                if (_PerformanceViewDisp2_ &&
                    (PfrmView2.PullDwonListOpen_ ||
                     PfrmView2.SelectPerformance_ == PERFORMANCE_EQ ||
                     PfrmView2.SelectPerformance_ == PERFORMANCE_FX_XY ||
                     PfrmView2.SelectPerformance_ == PERFORMANCE_SAMPLER)) {
                    //                        _HorizontalWaveView_.ZoomTwinView_.touchView1.userInteractionEnabled = NO;
                } else {
                    //                        _HorizontalWaveView_.ZoomTwinView_.touchView1.userInteractionEnabled = YES;
                }
            } else if (DisplayMode_ == HORIZONTALWAVE) {
                if (_PerformanceViewDisp2_ &&
                    (!PfrmView2.PullDwonListOpen_ &&
                     (PfrmView2.SelectPerformance_ == PERFORMANCE_EQ ||
                      PfrmView2.SelectPerformance_ == PERFORMANCE_FX_XY ||
                      PfrmView2.SelectPerformance_ == PERFORMANCE_SAMPLER))) {
                    //                         _HorizontalWaveView_.ZoomTwinView_.touchView1.userInteractionEnabled = NO;
                } else {
                    //                         _HorizontalWaveView_.ZoomTwinView_.touchView1.userInteractionEnabled = YES;
                }
            } else if (DisplayMode_ == VERTICALWAVE) {
                if (_PerformanceViewDisp2_ &&
                    (!PfrmView2.PullDwonListOpen_ &&
                     (PfrmView2.SelectPerformance_ == PERFORMANCE_EQ ||
                      PfrmView2.SelectPerformance_ == PERFORMANCE_FX_XY ||
                      PfrmView2.SelectPerformance_ == PERFORMANCE_SAMPLER))) {
                    //                         _HorizontalWaveView_.ZoomTwinView_.touchView1.userInteractionEnabled = NO;
                } else {
                    //                         _HorizontalWaveView_.ZoomTwinView_.touchView1.userInteractionEnabled = YES;
                }
            }
        }
    }
    
    if (!DJSystemFunction_->isInLoop(0)) {
        [self loopStateSetting:0 state:NO ReDraw:NO];
    }
    
    if (!DJSystemFunction_->isInLoop(1)) {
        [self loopStateSetting:1 state:NO ReDraw:NO];
    }
    
}

/**
 全体波形PlayNeedle更新
 */
- (void)updateLoudWavePlayNeedle:(int)playerID PlayTime:(int)playTime TotalPlayTime:(int)totalTime {
    WaveLoudViewLandscape *loudWaveViewLandscape;
    int PrevBackPos_;
    int PrevPos_;
    if (playerID == PLAYER_A) {
        loudWaveViewLandscape = deck1LoudWaveViewLandscape;
        PrevBackPos_ = PrevBackPos_A;
        PrevPos_ = PrevPos_A;
    } else {
        loudWaveViewLandscape = deck2LoudWaveViewLandscape;
        PrevBackPos_ = PrevBackPos_B;
        PrevPos_ = PrevPos_B;
    }
    CGRect rect = loudWaveViewLandscape.BackgroundPlayNeedleBackView_.frame;
    rect.size.height = loudWaveViewLandscape.posUIView_.frame.size.height;
    loudWaveViewLandscape.BackgroundPlayNeedleBackView_.frame = rect;
    rect = loudWaveViewLandscape.PlayNeedleBackView_.frame;
    rect.size.height = loudWaveViewLandscape.posUIView_.frame.size.height;
    loudWaveViewLandscape.PlayNeedleBackView_.frame = rect;
    rect = loudWaveViewLandscape.PlayNeedleView_.frame;
    rect.size.height = loudWaveViewLandscape.posUIView_.frame.size.height;
    loudWaveViewLandscape.PlayNeedleView_.frame = rect;
    
    if ([DJFunc getDJSystemFunction]->isLoaded(playerID)) {
        int pos = [self loudWavePositionPercents:playTime totalTime:totalTime player:playerID];
        int backPos = -1;
        if (BackPlayTime_ > 0) {
            backPos = [self loudWavePositionPercents:(int)BackPlayTime_ totalTime:totalTime player:playerID];
        }
        
        // バックグラウンド再生位置ニードル
        if (PrevBackPos_ != backPos) {
            if (0 <= backPos && backPos <= loudWaveViewLandscape.posUIView_.frame.size.width) {
                loudWaveViewLandscape.BackgroundPlayNeedleBackView_.hidden = NO;
                rect = loudWaveViewLandscape.BackgroundPlayNeedleBackView_.frame;
                rect.origin.x = backPos - 2;
                loudWaveViewLandscape.BackgroundPlayNeedleBackView_.frame = rect;
            } else {
                loudWaveViewLandscape.BackgroundPlayNeedleBackView_.hidden = YES;
            }
            PrevBackPos_ = backPos;
        }
        
        // 再生位置ニードル
        if (PrevPos_ != pos) {
            float w = static_cast<float>(loudWaveViewLandscape.LoudEndViewWidthConstraint.constant);
            if (pos >= 1) {
                w = pos - 1;
            } else {
                w = pos;
            }
            loudWaveViewLandscape.LoudEndViewWidthConstraint.constant = w;
            
            rect = loudWaveViewLandscape.PlayNeedleBackView_.frame;
            rect.origin.x = pos - 2;
            loudWaveViewLandscape.PlayNeedleBackView_.frame = rect;
            
            PrevPos_ = pos;
        }
        
        if (pos == 0) {
            float w = static_cast<float>(loudWaveViewLandscape.LoudEndViewWidthConstraint.constant);
            w = pos;
            loudWaveViewLandscape.LoudEndViewWidthConstraint.constant = w;
            rect = loudWaveViewLandscape.PlayNeedleBackView_.frame;
            rect.origin.x = pos - 2;
            loudWaveViewLandscape.PlayNeedleBackView_.frame = rect;
            PrevPos_ = pos;
        }
        
        UIColor* needleColor;
        int playState = [DJFunc getDJSystemFunction]->getPlayState(playerID);
        if (playState == djplay::PlayStatus_Pause) {
            needleColor = kC_Needle_Red;
        } else {
            needleColor = kC_White;
        }
        loudWaveViewLandscape.PlayNeedleView_.backgroundColor = needleColor;
    }
}

/**
 Sliderの溝の色更新
 */
- (void)sliderColorMeter:(NSUInteger)n deck:(NSInteger)deck value:(float)value {
    BOOL sliderUp = NO;
    switch (n) {
        case JOG:
        {
            CGRect rect;
            if (deck == 0) {
                rect = self.TempoEditView1_.SliderView_.frame;
            } else {
                rect = self.TempoEditView2_.SliderView_.frame;
            }
            rect.size.height = rect.size.height / 2 * value;
            if (rect.size.height < 0) {
                rect.size.height *= -1;
                rect.origin.y = rect.origin.y + self.TempoEditView1_.SliderView_.frame.size.height / 2;
            } else if (rect.size.height == 0) {
                rect.size.height = 0.1f;
                rect.origin.y = rect.origin.y + self.TempoEditView1_.SliderView_.frame.size.height / 2;
            } else {
                rect.origin.y = rect.origin.y + self.TempoEditView1_.SliderView_.frame.size.height / 2 - rect.size.height;
                sliderUp = YES;
            }
            if (deck == 0) {
                self.TempoEditView1_.SliderChangeView_.frame = rect;
            } else {
                self.TempoEditView2_.SliderChangeView_.frame = rect;
            }
        }
            break;
        case HORIZONTALWAVE:
            break;
        case VERTICALWAVE:
            break;
        case JOGC:
            break;
        default:
            break;
    }
}

#pragma mark - Action Button
- (IBAction)didTapMusicLoadButton:(UIButton *)sender {
    [self showBrowserWindow:(int)sender.tag];
}

- (void)showBrowserWindow:(int)playerID {
    [PlayViewCtrl loadBtnDown2:playerID];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapPlayLeftButton:(UIButton *)sender {
    int deckID = (int)sender.tag;
    [self setStatusPlayButton:sender];
    if ([DJFunc getDJSystemFunction]->isLoaded(deckID)) {
        [DJFunc getDJSystemFunction]->playButtonDown(deckID);
    }
}

- (IBAction)didTapPlayRightButton:(UIButton *)sender {
    int deckID = (int)sender.tag;
    [self setStatusPlayButton:sender];
    if ([DJFunc getDJSystemFunction]->isLoaded(deckID)) {
        [DJFunc getDJSystemFunction]->playButtonDown(deckID);
    }
}

- (void)setStatusPlayButton:(UIButton *)sender {
    if (sender.selected==YES) {
        [sender setSelected:NO];
        [sender setImage:[UIImage imageNamed:kImgPlayOffLandscapeIcon] forState:UIControlStateNormal];
        //        if (sender.tag == 0) {
        //            [_BpmEditView1_ setBtnsEnable:NO];
        //        }else {
        //            [_BpmEditView2_ setBtnsEnable:NO];
        //        }
    } else {
        [sender setSelected:YES];
        [sender setImage:[UIImage imageNamed:kImgPlayOnLandIcon] forState:UIControlStateSelected];
        //        if (sender.tag == 0) {
        //            [_BpmEditView1_ setBtnsEnable:YES];
        //        }else {
        //            [_BpmEditView2_ setBtnsEnable:YES];
        //        }
    }
}

- (IBAction)didTapCueLeftButtonUp:(UIButton *)sender {
    int deckID = (int)sender.tag;
    [DJFunc getDJSystemFunction]->cueButtonUp(deckID);
    [self changeStatusPlayLeftButton:NO];
}

- (IBAction)didTapCueRightButtonUp:(UIButton *)sender {
    int deckID = (int)sender.tag;
    [DJFunc getDJSystemFunction]->cueButtonUp(deckID);
    [self changeStatusPlayRightButton:NO];
}

- (IBAction)didTapCueLeftButtonDown:(UIButton *)sender {
    int deckID = (int)sender.tag;
    if ([DJFunc getDJSystemFunction]->isLoaded(deckID)) {
        [DJFunc getDJSystemFunction]->cueButtonDown(deckID);
    }
    [self changeStatusPlayLeftButton:YES];
}

- (IBAction)didTapCueRightButtonDown:(UIButton *)sender {
    int deckID = (int)sender.tag;
    if ([DJFunc getDJSystemFunction]->isLoaded(deckID)) {
        [DJFunc getDJSystemFunction]->cueButtonDown(deckID);
    }
    [self changeStatusPlayRightButton:YES];
}

- (void)changeStatusPlayLeftButton:(BOOL)isCue {
    if(isCue) {
        [_btnPlayLeft setSelected:YES];
        [_btnPlayLeft setImage:[UIImage imageNamed:kImgPlayOnLandIcon] forState:UIControlStateSelected];
    } else {
        [_btnPlayLeft setSelected:NO];
        [_btnPlayLeft setImage:[UIImage imageNamed:kImgPlayOffLandscapeIcon] forState:UIControlStateNormal];
    }
}

- (void)changeStatusPlayRightButton:(BOOL)isCue {
    if(isCue) {
        [_btnPlayRight setSelected:YES];
        [_btnPlayRight setImage:[UIImage imageNamed:kImgPlayOnLandIcon] forState:UIControlStateSelected];
    } else {
        [_btnPlayRight setSelected:NO];
        [_btnPlayRight setImage:[UIImage imageNamed:kImgPlayOffLandscapeIcon] forState:UIControlStateNormal];
    }
}

- (IBAction)didTapSyncLeftButton:(UIButton *)sender {
    [DJFunc getDJSystemFunction]->syncButtonDown((int)sender.tag);
    [PlayViewCtrl buttonPressedForIdleCheck];
}

- (IBAction)didTapSyncRightButton:(UIButton *)sender {
    [DJFunc getDJSystemFunction]->syncButtonDown((int)sender.tag);
    [PlayViewCtrl buttonPressedForIdleCheck];
}

- (IBAction)didTapPadLeftButton:(UIButton *)sender {
    ConnectDevice connectedDevice = [PlayerStateRepository sharedInstance].connectedDeviceType;
    if(connectedDevice == CONNECT_WannaBe || connectedDevice == CONNECT_EP134){
        if (sender.selected==YES) {
            [sender setSelected:NO];
            _PerformanceWeGoView1_.hidden = YES;
            [_padLeftButton setImage:[UIImage imageNamed:kImgPerformance1_1Icon] forState:UIControlStateNormal];
            _padLeftButton.layer.borderColor = kC_Gray_x32.CGColor;
        } else {
            [sender setSelected:YES];
            _PerformanceWeGoView1_.hidden = NO;
            [_padLeftButton setImage:[UIImage imageNamed:kImgPerformance1_2Icon] forState:UIControlStateSelected];
            _padLeftButton.layer.borderColor = kC_HotCue_04.CGColor;
        }
    } else {
        if (sender.selected==YES) {
            [sender setSelected:NO];
            performancePadLeftView.hidden = YES;
            [_padLeftButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
            [self checkHiddenPad];
            dropListLeftView.hidden = YES;
        } else {
            [self setSelectButton];
            [sender setSelected:YES];
            performancePadLeftView.hidden = NO;
            [_padLeftButton setImage:[UIImage imageNamed:kImgPerformanceOnIcon] forState:UIControlStateNormal];
            [self setWaveHalf];
            
            smartFaderMixerLeftView.hidden = YES;
            smartFaderMixerRightView.hidden = YES;
            smartFaderMixerView.hidden =YES;
            [_smartFaderMixerButton setImage:[UIImage imageNamed:kImgSFMixerOffIcon] forState:UIControlStateNormal];
            cfxLeftHorizontalTableView.hidden = YES;
            cfxRightHorizontalTableView.hidden = YES;
            cfxLeftJogTableView.hidden = YES;
            cfxRightJogTableView.hidden = YES;
            
            cueLeftView.hidden = YES;
            loopLeftView.hidden = YES;
            beatJumpLeftView.hidden = YES;
            [self hiddenPadLeft:sender];
            [self hiddenSamplerView];
        }
    }
}

- (IBAction)didTapPadRightButton:(UIButton *)sender {
    ConnectDevice connectedDevice = [PlayerStateRepository sharedInstance].connectedDeviceType;
    if (connectedDevice == CONNECT_WannaBe || connectedDevice == CONNECT_EP134) {
        if (sender.selected==YES) {
            [sender setSelected:NO];
            _PerformanceWeGoView2_.hidden = YES;
            [_padRightButton setImage:[UIImage imageNamed:kImgPerformance1_1Icon] forState:UIControlStateNormal];
            _padRightButton.layer.borderColor = kC_Gray_x32.CGColor;
        } else {
            [sender setSelected:YES];
            _PerformanceWeGoView2_.hidden = NO;
            [_padRightButton setImage:[UIImage imageNamed:kImgPerformance1_2Icon] forState:UIControlStateSelected];
            _padRightButton.layer.borderColor = kC_HotCue_04.CGColor;
        }
    } else {
        if (sender.selected==YES) {
            [sender setSelected:NO];
            performancePadRightView.hidden = YES;
            [_padRightButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
            [self checkHiddenPad];
            dropListRightView.hidden = YES;
        } else {
            [self setSelectButton];
            [sender setSelected:YES];
            performancePadRightView.hidden = NO;
            [_padRightButton setImage:[UIImage imageNamed:kImgPerformanceOnIcon] forState:UIControlStateNormal];
            [self setWaveHalf];
            
            smartFaderMixerLeftView.hidden = YES;
            smartFaderMixerRightView.hidden = YES;
            smartFaderMixerView.hidden =YES;
            [_smartFaderMixerButton setImage:[UIImage imageNamed:kImgSFMixerOffIcon] forState:UIControlStateNormal];
            cfxLeftHorizontalTableView.hidden = YES;
            cfxRightHorizontalTableView.hidden = YES;
            cfxLeftJogTableView.hidden = YES;
            cfxRightJogTableView.hidden = YES;
            
            mixerRightView.hidden = YES;
            cueRightView.hidden = YES;
            loopRightView.hidden = YES;
            beatJumpRightView.hidden = YES;
            [self hiddenPadRight:sender];
            [self hiddenSamplerView];
        }
    }
}

- (IBAction)didTapFxLeftButton:(UIButton *)sender {
    if (sender.selected==YES) {
        [sender setSelected:NO];
        fxPanelLeftView.hidden = YES;
        [_fxLeftButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
        [beatFxLeftCombobox hidden:YES];
        [typeFxLeftCombobox hidden:YES];
        [self checkHiddenPad];
    } else {
        [self setSelectButton];
        [sender setSelected:YES];
        fxPanelLeftView.hidden = NO;
        [_fxLeftButton setImage:[UIImage imageNamed:kImgFXOnIcon] forState:UIControlStateNormal];
        performancePadLeftView.hidden = YES;
        [_padLeftButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
        performancePadRightView.hidden = YES;
        [_padRightButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
        
        smartFaderMixerLeftView.hidden = YES;
        smartFaderMixerRightView.hidden = YES;
        smartFaderMixerView.hidden =YES;
        [_smartFaderMixerButton setImage:[UIImage imageNamed:kImgSFMixerOffIcon] forState:UIControlStateNormal];
        cfxLeftHorizontalTableView.hidden = YES;
        cfxRightHorizontalTableView.hidden = YES;
        cfxLeftJogTableView.hidden = YES;
        cfxRightJogTableView.hidden = YES;
        
        cueLeftView.hidden = YES;
        loopLeftView.hidden = YES;
        beatJumpLeftView.hidden = YES;
        [self hiddenSamplerView];
        [self hiddenPadLeft:sender];
        [self setWaveHalf];
    }
}

- (IBAction)didTapFxRightButton:(UIButton *)sender {
    if (sender.selected==YES) {
        [sender setSelected:NO];
        fxPanelRightView.hidden = YES;
        [_fxRightButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
        [beatFxRightCombobox hidden:YES];
        [typeFxRightCombobox hidden:YES];
        [self checkHiddenPad];
    } else {
        [self setSelectButton];
        [sender setSelected:YES];
        fxPanelRightView.hidden = NO;
        [_fxRightButton setImage:[UIImage imageNamed:kImgFXOnIcon] forState:UIControlStateNormal];
        performancePadLeftView.hidden = YES;
        [_padLeftButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
        performancePadRightView.hidden = YES;
        [_padRightButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
        
        smartFaderMixerLeftView.hidden = YES;
        smartFaderMixerRightView.hidden = YES;
        smartFaderMixerView.hidden =YES;
        [_smartFaderMixerButton setImage:[UIImage imageNamed:kImgSFMixerOffIcon] forState:UIControlStateNormal];
        cfxLeftHorizontalTableView.hidden = YES;
        cfxRightHorizontalTableView.hidden = YES;
        cfxLeftJogTableView.hidden = YES;
        cfxRightJogTableView.hidden = YES;
        
        mixerRightView.hidden = YES;
        cueRightView.hidden = YES;
        loopRightView.hidden = YES;
        beatJumpRightView.hidden = YES;
        [self hiddenSamplerView];
        [self hiddenPadRight:sender];
        [self setWaveHalf];
    }
}
- (IBAction)didTapSamplerButton:(UIButton *)sender {
    [self hiddenViewOpenSampler];
    if (sender.selected==YES) {
        [sender setSelected:NO];
        [_samplerButton setImage:[UIImage imageNamed:kImgSamplerOffIcon] forState:UIControlStateNormal];
        [self hiddenSamplerView];
        samplerView.styleSamplerButton.selected = NO;
        [self checkHiddenPad];
    } else {
        [self setSelectButton];
        [sender setSelected:YES];
        [_samplerButton setImage:[UIImage imageNamed:kImgSamplerOnIcon] forState:UIControlStateNormal];
        samplerView.hidden = NO;
        [self setWaveHalf];
        fxPanelRightView.hidden = YES;
        [_fxRightButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
        fxPanelLeftView.hidden = YES;
        [_fxLeftButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
        [beatFxLeftCombobox hidden:YES];
        [typeFxLeftCombobox hidden:YES];
        [beatFxRightCombobox hidden:YES];
        [typeFxRightCombobox hidden:YES];
        
        performancePadLeftView.hidden = YES;
        [_padLeftButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
        performancePadRightView.hidden = YES;
        [_padRightButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
        
        smartFaderMixerLeftView.hidden = YES;
        smartFaderMixerRightView.hidden = YES;
        smartFaderMixerView.hidden =YES;
        [_smartFaderMixerButton setImage:[UIImage imageNamed:kImgSFMixerOffIcon] forState:UIControlStateNormal];
        cfxLeftHorizontalTableView.hidden = YES;
        cfxRightHorizontalTableView.hidden = YES;
        cfxLeftJogTableView.hidden = YES;
        cfxRightJogTableView.hidden = YES;
    }
}


- (void)checkHiddenPad {
    if ((fxPanelRightView.hidden)
        && (fxPanelLeftView.hidden)
        && (performancePadRightView.hidden)
        && (performancePadLeftView.hidden)
        && (smartFaderMixerView.hidden)
        && (smartFaderMixerLeftView.hidden)
        && (smartFaderMixerRightView.hidden)
        && (samplerView.hidden)
        && (samplerTableView.hidden)
        && (selectSamplerView.hidden)) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Set_Wave_Half];
        [self setSelectButton];
        [_HorizontalWaveView_ createView];
    }
}

- (void)setSelectButton {
    _headphoneLeft.selected         = NO;
    _headphoneRight.selected        = NO;
    _btnSyncLeft.selected           = NO;
    _btnSyncRight.selected          = NO;
    _padLeftButton.selected         = NO;
    _padRightButton.selected        = NO;
    _fxLeftButton.selected          = NO;
    _fxRightButton.selected         = NO;
    _samplerButton.selected         = NO;
    _smartFaderMixerButton.selected = NO;
}

- (void)setWaveHalf {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:Set_Wave_Half]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Set_Wave_Half];
        [_HorizontalWaveView_ createView];
    }
}

- (IBAction)didTapSmartFaderMixerButton:(UIButton *)sender {
    [self hiddenViewOpenSampler];
    NSInteger mode = [[NSUserDefaults standardUserDefaults] integerForKey:kStandaloneDisplayMode];
    if (sender.selected==YES) {
        [sender setSelected:NO];
        [_smartFaderMixerButton setImage:[UIImage imageNamed:kImgSFMixerOffIcon] forState:UIControlStateNormal];
        switch (mode) {
            case JOG:
                smartFaderMixerLeftView.hidden = YES;
                smartFaderMixerRightView.hidden = YES;
                cfxLeftHorizontalTableView.hidden = YES;
                cfxRightHorizontalTableView.hidden = YES;
                cfxLeftJogTableView.hidden = YES;
                cfxRightJogTableView.hidden = YES;
                break;
                
            case HORIZONTALWAVE:
                smartFaderMixerView.hidden = YES;
                cfxLeftHorizontalTableView.hidden = YES;
                cfxRightHorizontalTableView.hidden = YES;
                cfxLeftJogTableView.hidden = YES;
                cfxRightJogTableView.hidden = YES;
                break;
                
            case VERTICALWAVE:
                break;
                
            default:
                smartFaderMixerView.hidden = YES;
                cfxLeftHorizontalTableView.hidden = YES;
                cfxRightHorizontalTableView.hidden = YES;
                cfxLeftJogTableView.hidden = YES;
                cfxRightJogTableView.hidden = YES;
                break;
        }
        [self checkHiddenPad];
    } else {
        [self setSelectButton];
        [sender setSelected:YES];
        [_smartFaderMixerButton setImage:[UIImage imageNamed:kImgSFMixerOnIcon] forState:UIControlStateNormal];
        switch (mode) {
            case JOG:
                smartFaderMixerLeftView.hidden = NO;
                smartFaderMixerRightView.hidden = NO;
                break;
                
            case HORIZONTALWAVE:
                smartFaderMixerView.hidden = NO;
                break;
                
            case VERTICALWAVE:
                break;
                
            default:
                smartFaderMixerView.hidden = NO;
                break;
        }
        fxPanelRightView.hidden = YES;
        [_fxRightButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
        fxPanelLeftView.hidden = YES;
        [_fxLeftButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
        performancePadLeftView.hidden = YES;
        [_padLeftButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
        performancePadRightView.hidden = YES;
        [_padRightButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
        [self hiddenSamplerView];
        [beatFxLeftCombobox hidden:YES];
        [typeFxLeftCombobox hidden:YES];
        [beatFxRightCombobox hidden:YES];
        [typeFxRightCombobox hidden:YES];
        
        [self setWaveHalf];
    }
}

- (void)hiddenSmartFaderMixerHorizontal {
    smartFaderMixerView.hidden = YES;
    [_smartFaderMixerButton setSelected:NO];
    [_smartFaderMixerButton setImage:[UIImage imageNamed:kImgSFMixerOffIcon] forState:UIControlStateNormal];
    cfxLeftHorizontalTableView.hidden = YES;
    cfxRightHorizontalTableView.hidden = YES;
}

- (void)hiddenSmartFaderMixerJog{
    smartFaderMixerLeftView.hidden = YES;
    smartFaderMixerRightView.hidden = YES;
    [_smartFaderMixerButton setSelected:NO];
    [_smartFaderMixerButton setImage:[UIImage imageNamed:kImgSFMixerOffIcon] forState:UIControlStateNormal];
    cfxLeftJogTableView.hidden = YES;
    cfxRightJogTableView.hidden = YES;
}

- (void)hiddenPadLeft: (UIButton*)sender {
    if(sender.tag == ZeroValue) {
        fxPanelLeftView.hidden = YES;
        [_fxLeftButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
        [beatFxLeftCombobox hidden:YES];
        [typeFxLeftCombobox hidden:YES];
        [_fxLeftButton setSelected:NO];
    } else {
        performancePadLeftView.hidden = YES;
        dropListLeftView.hidden = YES;
        [_padLeftButton setSelected:NO];
        [_padLeftButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
    }
}

- (void)hiddenViewOpenSampler {
    _BpmEditView1_.hidden = YES;
    self.TempoEditView1_.hidden = YES;
    masterTempoLeftView.hidden = YES;
    self.masterLeftButton.hidden = YES;
    _BpmEditView2_.hidden = YES;
    self.TempoEditView2_.hidden = YES;
    masterTempoRightView.hidden = YES;
    self.masterRightButton.hidden = YES;
    OriginalLeftView.hidden = YES;
    OriginalRightView.hidden = YES;
}

- (void)hiddenPadRight: (UIButton*)sender {
    if(sender.tag == ZeroValue) {
        fxPanelRightView.hidden = YES;
        [_fxRightButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
        [beatFxRightCombobox hidden:YES];
        [typeFxRightCombobox hidden:YES];
        [_fxRightButton setSelected:NO];
    } else {
        performancePadRightView.hidden = YES;
        dropListRightView.hidden = YES;
        [_padRightButton setSelected:NO];
        [_padRightButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
    }
}

- (IBAction)didTapSlider:(UISlider *)sender {
    [self sliderColor: sender.value];
    [DJFunc getDJSystemFunction]->setCrossFaderPos(sender.value);
}

- (IBAction)didTapTempoLeftButton:(UIButton *)sender {
    _BpmEditView1_.hidden = YES;
    self.TempoEditView1_.hidden = NO;
    masterTempoLeftView.hidden = NO;
    self.masterLeftButton.hidden = NO;
    fxPanelLeftView.hidden = YES;
    [_fxLeftButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
    performancePadLeftView.hidden = YES;
    [_padLeftButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
    [self hiddenView];
}

- (IBAction)didTapTempoRightButton:(UIButton *)sender {
    _BpmEditView2_.hidden = YES;
    self.TempoEditView2_.hidden = NO;
    masterTempoRightView.hidden = NO;
    self.masterRightButton.hidden = NO;
    fxPanelRightView.hidden = YES;
    [_fxRightButton setImage:[UIImage imageNamed:kImgFXOffIcon] forState:UIControlStateNormal];
    performancePadRightView.hidden = YES;
    [_padRightButton setImage:[UIImage imageNamed:kImgPerformanceOffIcon] forState:UIControlStateNormal];
    [self hiddenView];
}

- (void)hiddenView {
    [self setSelectButton];
    smartFaderMixerView.hidden = YES;
    smartFaderMixerLeftView.hidden = YES;
    smartFaderMixerRightView.hidden = YES;
    samplerView.hidden = YES;
    samplerTableView.hidden = YES;
    selectSamplerView.hidden = YES;
    [self hiddenSamplerView];
    [_smartFaderMixerButton setImage:[UIImage imageNamed:kImgSFMixerOffIcon] forState:UIControlStateNormal];
}

- (void)sliderColor:(float)value {
    CGRect rect;
    rect = self.crossFader.frame;
    rect.size.width = rect.size.width / 2 * value;
    if (rect.size.width < ZeroValue) {
        rect.origin.x = rect.origin.x + self.crossFader.frame.size.width / 2;
    } else if (rect.size.width == ZeroValue) {
        rect.size.width = 0.1f;
        rect.origin.x = rect.origin.x + self.crossFader.frame.size.width / 2;
    } else {
        rect.origin.x = rect.origin.x + self.crossFader.frame.size.width / 2 ;
    }
    sliderView.frame = CGRectMake(rect.origin.x, ZeroValue, rect.size.width, HEIGHT_SLIDER);
}

- (void)masterLeftButtonDidPush:(UIButton *)sender {
    [_masterLeftButton setTitleColor:kColor_BpmButton forState:UIControlStateNormal];
    [_masterRightButton setTitleColor:kColor_MixerButtonTitleOff forState:UIControlStateNormal];
    self.DJSystemFunction_->masterButtonDown((int)sender.tag);
}

- (void)masterRightButtonDidPush:(UIButton *)sender {
    [_masterRightButton setTitleColor:kColor_BpmButton forState:UIControlStateNormal];
    [_masterLeftButton setTitleColor:kColor_MixerButtonTitleOff forState:UIControlStateNormal];
    self.DJSystemFunction_->masterButtonDown((int)sender.tag);
}

#pragma mark - Update Time Playing

/**
 再生時間更新
 */
- (void)updatePlayingTime:(int)playerID TotalPlayTime:(int)totalPlayTime {
    int64_t prevPlayTime = [DJFunc getDJSystemFunction]->getPlayingTime(playerID);
    NSInteger dispTime = labs(prevPlayTime);
    NSInteger min = dispTime / 60000;
    NSInteger sec = (dispTime / 1000) % 60;
    NSInteger msec = (dispTime % 1000) / 100;
    dispTime = totalPlayTime - prevPlayTime;
    min = dispTime / 60000;
    sec = (dispTime / 1000) % 60;
    msec = (dispTime % 1000) / 100;
    if (playerID == PLAYER_A) {
        self.timePlayingALabel.text = [NSString stringWithFormat:@"-%02zd:%02zd", min, sec];
        int64_t prevPlayTimeA = [DJFunc getDJSystemFunction]->getPlayingTime(PLAYER_A);
        [self updateLoudWavePlayNeedle:PLAYER_A PlayTime:(int)prevPlayTimeA TotalPlayTime:totalPlayTime];
    } else {
        self.timePlayingBLabel.text = [NSString stringWithFormat:@"-%02zd:%02zd", min, sec];
        int64_t prevPlayTimeB = [DJFunc getDJSystemFunction]->getPlayingTime(PLAYER_B);
        [self updateLoudWavePlayNeedle:PLAYER_B PlayTime:(int)prevPlayTimeB TotalPlayTime:totalPlayTime];
    }
}

#pragma mark - Slider

- (void) setupSlider {
    [_crossFader setThumbImage:[UIImage imageNamed:@"knob"] forState:UIControlStateNormal];
    sliderView = [[UIView alloc] init];
    sliderView.backgroundColor = kColor_SliderValue;
    [self.sliderBottomView addSubview: sliderView];
}

#pragma mark - Sync Button
/**
 Syncボタンタップ
 **/
- (void)setupButtonSync {
    bool isSync1_ = self.DJSystemFunction_->isSyncModeOn(0);
    bool isSync2_ = self.DJSystemFunction_->isSyncModeOn(1);
    if (isSync1_) {
        [_btnSyncLeft setSelected:YES];
        [_btnSyncLeft setImage:[UIImage imageNamed:kImgSyncOnIcon] forState:UIControlStateSelected];
    }
    
    if (isSync2_) {
        [_btnSyncRight setSelected:YES];
        [_btnSyncRight setImage:[UIImage imageNamed:kImgSyncOnIcon] forState:UIControlStateSelected];
    }
}

#pragma mark - Tempo Bpm

/**
 BPM編集表示ボタンタップ
 */
- (void)btnBpmDisplayDidPush:(UIButton *)sender {
    if (sender.tag == PLAYER_A) {
        if (self.TempoEditView1_.hidden) {
            [[NSUserDefaults standardUserDefaults] setInteger:TEMPO_EDIT forKey:kTempoBpmEditView1];
        } else {
            [[NSUserDefaults standardUserDefaults] setInteger:BPM_EDIT forKey:kTempoBpmEditView1];
        }
        self.TempoEditView1_.hidden = !self.TempoEditView1_.hidden;
        self.BpmEditView1_.hidden = !self.BpmEditView1_.hidden;
    } else {
        if (self.TempoEditView2_.hidden) {
            [[NSUserDefaults standardUserDefaults] setInteger:TEMPO_EDIT forKey:kTempoBpmEditView2];
        } else {
            [[NSUserDefaults standardUserDefaults] setInteger:BPM_EDIT forKey:kTempoBpmEditView2];
        }
        self.TempoEditView2_.hidden = !self.TempoEditView2_.hidden;
        self.BpmEditView2_.hidden = !self.BpmEditView2_.hidden;
    }
}

/**
 Tempo/BPM編集表示ボタンタップ
 */
- (void)btnTempoBpmDisplayDidPush:(UIButton *)sender {
    if (sender.tag == PLAYER_A) {
        if (self.TempoEditView1_.hidden && self.BpmEditView1_.hidden) {
            if ([[NSUserDefaults standardUserDefaults] integerForKey:kTempoBpmEditView1] == TEMPO_EDIT) {
                self.TempoEditView1_.hidden = NO;
            } else if ([[NSUserDefaults standardUserDefaults] integerForKey:kTempoBpmEditView1] == BPM_EDIT) {
                self.BpmEditView1_.hidden = NO;
            }
        } else {
            self.TempoEditView1_.hidden = YES;
            self.BpmEditView1_.hidden = YES;
        }
    } else {
        if (self.TempoEditView2_.hidden && self.BpmEditView2_.hidden) {
            if ([[NSUserDefaults standardUserDefaults] integerForKey:kTempoBpmEditView2] == TEMPO_EDIT) {
                self.TempoEditView2_.hidden = NO;
            } else if ([[NSUserDefaults standardUserDefaults] integerForKey:kTempoBpmEditView2] == BPM_EDIT) {
                self.BpmEditView2_.hidden = NO;
            }
        } else {
            self.TempoEditView2_.hidden = YES;
            self.BpmEditView2_.hidden = YES;
        }
    }
}

- (void)btnBeatDoubleDidPush:(UIButton *)sender {
    int tag_ = int(sender.tag);
    if ([DJFunc getDJSystemFunction]->isLoaded(tag_)) {
        bool isSuccessed = [DJFunc getDJSystemFunction]->setDoubleBeat(tag_);
        if (!isSuccessed) {
            AlertManager::getInstance()->showMessage(AlertType::OperateBpmRangeWord);
        }
    }
    [playerGridView setGridEnable];
}

- (void)btnBeatHalveDidPush:(UIButton *)sender {
    int tag_ = int(sender.tag);
    if ([DJFunc getDJSystemFunction]->isLoaded(tag_)) {
        bool isSuccessed = [DJFunc getDJSystemFunction]->setHalveBeat(tag_);
        if (!isSuccessed) {
            AlertManager::getInstance()->showMessage(AlertType::OperateBpmRangeWord);
        }
    }
    [playerGridView setGridEnable];
}

- (void)btnBeatTapDidPush:(UIButton *)sender {
    int tag_ = int(sender.tag);
    [playerGridView tapBpm:tag_];
    [playerGridView setGridEnable];
}

/**
 TempoSliderダブルタップ
 */
- (void)gestureDidSliderDoubleTap:(UITapGestureRecognizer *)gestureRecognizer {
    switch ([gestureRecognizer view].tag) {
        case TEMPO_SLIDER_1 + 1:
            [self resetTempoSlider1];
            break;
        case TEMPO_SLIDER_2 + 1:
            [self resetTempoSlider2];
            break;
        default:
            break;
    }
}

/**
 TempoSlider1 をリセットする
 */
- (void)resetTempoSlider1 {
    self.SliderValue12_ = 0.0f;
    self.TempoEditView1_.TempoSlider_.value = 0.0f;
    [self sliderTempoOperation:self.TempoEditView1_.TempoSlider_];
}

/**
 TempoSlider2 をリセットする
 */
- (void)resetTempoSlider2 {
    self.SliderValue22_ = 0.0f;
    self.TempoEditView2_.TempoSlider_.value = 0.0f;
    [self sliderTempoOperation:self.TempoEditView2_.TempoSlider_];
}

- (void)setTempo:(NSInteger)deck {
    self.DJSystemFunction_->setTempoRangeValue((int)deck - 1, 10);
}

/**
 TempoSlider操作終了(タッチアップ)
 */
- (void)sliderTempoOperationEnd:(UISlider *)sender {
    int deck = (int)sender.tag;
    if (deck == 0) {
        sender.value = _SliderValue12_;
        self.TempoEditView1_.TempoSlider_.value = sender.value;
    } else {
        sender.value = _SliderValue22_;
        self.TempoEditView2_.TempoSlider_.value = sender.value;
    }
    self.DJSystemFunction_->setTempoSliderPos(deck, sender.value);
    [self sliderColorMeter:JOG deck:deck value:sender.value];
    [self sliderColorMeter:HORIZONTALWAVE deck:deck value:sender.value];
    [self sliderColorMeter:VERTICALWAVE deck:deck value:sender.value];
}

/**
 TempoSlider操作
 */
- (void)sliderTempoOperation:(UISlider *)sender {
    int deck = (int)sender.tag;
    self.DJSystemFunction_->setTempoSliderPos(deck, sender.value);
    bool isMasterOn = self.DJSystemFunction_->isMasterOn(deck);
    if (deck == 0) {
        self.TempoEditView1_.TempoSlider_.value = sender.value;
        if(_btnSyncRight.selected==YES and isMasterOn) {
            self.TempoEditView2_.TempoSlider_.value = sender.value;
            [self sliderColorMeter:JOG deck:PLAYER_A value:sender.value];
            [self sliderColorMeter:HORIZONTALWAVE deck:PLAYER_A value:sender.value];
            [self sliderColorMeter:VERTICALWAVE deck:PLAYER_A value:sender.value];
        }
    } else {
        self.TempoEditView2_.TempoSlider_.value = sender.value;
        if(_btnSyncLeft.selected==YES and isMasterOn) {
            self.TempoEditView1_.TempoSlider_.value = sender.value;
            [self sliderColorMeter:JOG deck:PLAYER_B value:sender.value];
            [self sliderColorMeter:HORIZONTALWAVE deck:PLAYER_B value:sender.value];
            [self sliderColorMeter:VERTICALWAVE deck:PLAYER_B value:sender.value];
        }
    }
    [self sliderColorMeter:JOG deck:deck value:sender.value];
    [self sliderColorMeter:HORIZONTALWAVE deck:deck value:sender.value];
    [self sliderColorMeter:VERTICALWAVE deck:deck value:sender.value];
}

- (void)btnTempoRangeDidPush:(UIButton *)sender {
    int deck = (int)sender.tag;
    [DJFunc getDJSystemFunction]->tempoRangeButtonDown(deck);
}

- (void)btnTouchDown:(UIButton *)sender {
    if (sender.tag == PLAYER_A) {
        //        _TempoEditView1_.hidden = YES;
    } else {
        //        _TempoEditView2_.hidden = YES;
    }
}

- (void)btnGRIDButtonDidPush:(UIButton *)sender {
    int deck = (int)sender.tag;
    if (deck == PLAYER_A) {
        _BpmEditView1_.hidden = !_BpmEditView1_.hidden;
        masterTempoLeftView.hidden = !_BpmEditView1_.hidden;
        _TempoEditView1_.GRIDButton.layer.borderColor = masterTempoLeftView.hidden ? kColor_EditSamplerOn.CGColor : kColor_C203.CGColor;
        _TempoEditView1_.titleGRIDLabel.textColor = masterTempoLeftView.hidden ? kColor_EditSamplerOn : kColor_MixerButtonTitleOff;
        _masterLeftButton.hidden = !_BpmEditView1_.hidden;
        OriginalLeftView.hidden = _BpmEditView1_.hidden;
    } else {
        _BpmEditView2_.hidden = !_BpmEditView2_.hidden;
        masterTempoRightView.hidden = !_BpmEditView2_.hidden;
        _TempoEditView2_.GRIDButton.layer.borderColor = masterTempoRightView.hidden ? kColor_EditSamplerOn.CGColor : kColor_C203.CGColor;
        _TempoEditView2_.titleGRIDLabel.textColor = masterTempoRightView.hidden ? kColor_EditSamplerOn : kColor_MixerButtonTitleOff;
        _masterRightButton.hidden = !_BpmEditView2_.hidden;
        OriginalRightView.hidden = _BpmEditView2_.hidden;
    }
}

#pragma mark - MasterTempo Delegate
///Master Tempo Left View
- (void)didTapBpmMasterTempoLButton {
    self.TempoEditView1_.hidden     = YES;
    masterTempoLeftView.hidden      = YES;
    self.masterLeftButton.hidden    = YES;
}

- (void)didKeyResetMasterTempoLButton {
    int bpmx100 = [DJFunc getDJSystemFunction]->getBpmFromTime(PLAYER_A);
    float bpm = bpmx100 / 100.0f;
    self.DJSystemFunction_->setTempBpm(PLAYER_A, bpm);
    [self resetTempoSlider1];
    [self bpmConfirm:PLAYER_A];
    [TrackingManager addEvent:TME_2bpmreset];
}

- (void)didTapMasterTempoLButton {
    if (masterTempoLeftView.masterLabel.textColor == kColor_MixerButtonTitleOff) {
        masterTempoLeftView.masterLabel.textColor = kColor_MasterTempoButton;
        masterTempoLeftView.tempoLabel.textColor = kColor_MasterTempoButton;
    } else {
        masterTempoLeftView.masterLabel.textColor = kColor_MixerButtonTitleOff;
        masterTempoLeftView.tempoLabel.textColor = kColor_MixerButtonTitleOff;
    }
    self.DJSystemFunction_->masterTempoButtonDown(PLAYER_A);
}

- (void)didTapDownMasterTempoLButton {
    
}

- (void)didTapUpMasterTempoLButton {
    
}

///Master Tempo Right View
- (void)didTapBpmMasterTempoRButton {
    self.TempoEditView2_.hidden     = YES;
    masterTempoRightView.hidden     = YES;
    self.masterRightButton.hidden   = YES;
}

- (void)didKeyResetMasterTempoRButton {
    int bpmx100 = [DJFunc getDJSystemFunction]->getBpmFromTime(PLAYER_B);
    float bpm = bpmx100 / 100.0f;
    self.DJSystemFunction_->setTempBpm(PLAYER_B, bpm);
    [self resetTempoSlider2];
    [self bpmConfirm:PLAYER_B];
    [TrackingManager addEvent:TME_2bpmreset];
}

- (void)didTapMasterTempoRButton {
    if (masterTempoRightView.masterLabel.textColor == kColor_MixerButtonTitleOff) {
        masterTempoRightView.masterLabel.textColor = kColor_MasterTempoButton;
        masterTempoRightView.tempoLabel.textColor = kColor_MasterTempoButton;
    } else {
        masterTempoRightView.masterLabel.textColor = kColor_MixerButtonTitleOff;
        masterTempoRightView.tempoLabel.textColor = kColor_MixerButtonTitleOff;
    }
    self.DJSystemFunction_->masterTempoButtonDown(PLAYER_B);
}

- (void)didTapDownMasterTempoRButton {
    
}

- (void)didTapUpMasterTempoRButton {
    
}

/**
 ボタンON/OFF周期確認タイマー
 TempoRangeボタン状態
 */
- (void)tempoRangeBtnState:(UIButton *)btn state:(int)state deck:(int)deck {
    NSString* str;
    UIColor* strColor;
    if (deck == 0) {
        if (PrevTempoRange1_ != state) {
            switch (state) {
                case TEMPO_RANGE_STATE6:
                    str = NSLocalizedString(TempoRange6, nil);
                    strColor = kColor_TempoRange6;
                    break;
                case TEMPO_RANGE_STATE10:
                    str = NSLocalizedString(TempoRange10, nil);
                    strColor = kColor_TempoRange10;
                    break;
                case TEMPO_RANGE_STATE16:
                    str = NSLocalizedString(TempoRange16, nil);
                    strColor = kColor_TempoRange16;
                    break;
                case TEMPO_RANGE_STATE100:
                    str = NSLocalizedString(TempoRangeWide, nil);
                    strColor = kColor_MasterTempoButton;
                    break;
                default:
                    break;
            }
            _TempoEditView1_.TempoRangeLabel_.textColor = strColor;
            _TempoEditView1_.TempoRangeLabel_.text = str;
            PrevTempoRange1_ = static_cast<NSUInteger>(state);
        }
        
        CGFloat tempoSpeed = state * _TempoEditView1_.TempoSlider_.value * -1;
        if (-0.1 < tempoSpeed && tempoSpeed < 0.1) {
            _TempoPlaySpeedLeftLabel_.text = TempoRange0;
            masterTempoLeftView.valueLabel.text = TempoRange0;
        } else {
            _TempoPlaySpeedLeftLabel_.text = [NSString stringWithFormat:@"%0.1f%%", tempoSpeed];
            masterTempoLeftView.valueLabel.text = [NSString stringWithFormat:@"%0.1f%%", tempoSpeed];
        }
    } else {
        if (PrevTempoRange2_ != state) {
            switch (state) {
                case TEMPO_RANGE_STATE6:
                    str = NSLocalizedString(TempoRange6, nil);
                    strColor = kColor_TempoRange6;
                    break;
                case TEMPO_RANGE_STATE10:
                    str = NSLocalizedString(TempoRange10, nil);
                    strColor = kColor_TempoRange10;
                    break;
                case TEMPO_RANGE_STATE16:
                    str = NSLocalizedString(TempoRange16, nil);
                    strColor = kColor_TempoRange16;
                    break;
                case TEMPO_RANGE_STATE100:
                    str = NSLocalizedString(TempoRangeWide, nil);
                    strColor = kColor_MasterTempoButton;
                    break;
                default:
                    break;
            }
            _TempoEditView2_.TempoRangeLabel_.textColor = strColor;
            _TempoEditView2_.TempoRangeLabel_.text = str;
            PrevTempoRange1_ = static_cast<NSUInteger>(state);
            PrevTempoRange2_ = static_cast<NSUInteger>(state);
        }
        CGFloat tempoSpeed = state * _TempoEditView2_.TempoSlider_.value * -1;
        if (-0.1 < tempoSpeed && tempoSpeed < 0.1) {
            _TempoPlaySpeedRightLabel_.text = TempoRange0;
            masterTempoRightView.valueLabel.text = TempoRange0;
        } else {
            _TempoPlaySpeedRightLabel_.text = [NSString stringWithFormat:@"%0.1f%%", tempoSpeed];
            masterTempoRightView.valueLabel.text = [NSString stringWithFormat:@"%0.1f%%", tempoSpeed];
        }
    }
}

/**
 BPM周期確認
 */
- (void)bpmConfirm:(int)deck {
    float bpm = [DJFunc getDJSystemFunction]->getCurrentOutputBpm(deck);
    if (deck == 0) {
        if (PrevBpm1_ != bpm) {
            _trackBpmLeftLabel.text = [NSString stringWithFormat:@"%.1f", bpm / 100];
            masterTempoLeftView.bpmLabel.text = [NSString stringWithFormat:@"%.1f", bpm / 100];
            bpmLTextField.text = [NSString stringWithFormat:@"%.1f", bpm / 100];
            NSUInteger len = _trackBpmLeftLabel.text.length;
            NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:_trackBpmLeftLabel.text];
            NSMutableAttributedString* str_edit = [[NSMutableAttributedString alloc] initWithString:_trackBpmLeftLabel.text];
            if (len > 0) {
                CGFloat scale =  _MainScreenSizeWidth_ / 667.0f;
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:BpmLeftDot * scale] range:NSMakeRange(0, len - 1)];
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:BpmRightDot * scale] range:NSMakeRange(len - 1, 1)];
                [str_edit addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:BpmEditLeftDot * scale] range:NSMakeRange(0, len - 1)];
                [str_edit addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:BpmEditRightDot * scale] range:NSMakeRange(len - 1, 1)];
                _trackBpmLeftLabel.attributedText = str;
                masterTempoLeftView.bpmLabel.attributedText = str;
                bpmLTextField.attributedText = str_edit;
            }
            PrevBpm1_ = bpm;
        }
    } else {
        if (PrevBpm2_ != bpm) {
            _trackBpmRightLabel.text = [NSString stringWithFormat:@"%.1f", bpm / 100];
            masterTempoRightView.bpmLabel.text = [NSString stringWithFormat:@"%.1f", bpm / 100];
            bpmRTextField.text = [NSString stringWithFormat:@"%.1f", bpm / 100];
            NSUInteger len = _trackBpmRightLabel.text.length;
            NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:_trackBpmRightLabel.text];
            NSMutableAttributedString* str_edit = [[NSMutableAttributedString alloc] initWithString:_trackBpmRightLabel.text];
            if (len > 0) {
                CGFloat scale =  _MainScreenSizeWidth_ / 667.0f;
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:BpmLeftDot * scale] range:NSMakeRange(0, len - 1)];
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:BpmRightDot * scale] range:NSMakeRange(len - 1, 1)];
                [str_edit addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:BpmEditLeftDot * scale] range:NSMakeRange(0, len - 1)];
                [str_edit addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFont size:BpmEditRightDot * scale] range:NSMakeRange(len - 1, 1)];
                _trackBpmRightLabel.attributedText = str;
                masterTempoRightView.bpmLabel.attributedText = str;
                bpmRTextField.attributedText = str_edit;
            }
            PrevBpm2_ = bpm;
        }
    }
}

#pragma mark - PadFx View
- (void) setupPadFx {
    NSArray* titleAr;
    titleAr = @[FXRoll,
                FXSWEEP,
                FXFlanger,
                FXVBRAKE,
                FXEcho,
                FXEcho,
                FXReverb,
                FXRECHO];
    
    NSArray* valueAr;
    valueAr = @[Beat1Slash2,
                Beat80,
                Beat16Slash1,
                Beat3Slash4,
                Beat1Slash4,
                Beat1Slash2,
                Beat60,
                Beat1Slash2];
    
    for (int j=0; j < 2; j++) {
        for (NSInteger i = 0; i < 8; i++) {
            [self FxBtnSet:(int)i title:titleAr[i] value:valueAr[i] Deck:j];
        }
    }
}

- (void)FxBtnSet:(int)n title:(NSString*)title value:(NSString*)value Deck:(int) Deck_ {
    if (n < 0) {
        return;
    }
    int fxId = 0;
    int fxValue = 0;
    int plusminus = 1;
    
    if ([title isEqualToString:FXSlipLoop]) {
        fxId = DjSysFunc::PFX_SLIPLOOP;
    } else if ([title isEqualToString:FXFilterLFO]) {
        fxId = DjSysFunc::PFX_FILTER_LFO;
    } else if ([title isEqualToString:FXFlanger]) {
        fxId = DjSysFunc::PFX_FLANGER;
    } else if ([title isEqualToString:FXEcho]) {
        fxId = DjSysFunc::PFX_ECHO;
    } else if ([title isEqualToString:FXReverb]) {
        fxId = DjSysFunc::PFX_REVERB;
    } else if ([title isEqualToString:FXSpiral]) {
        fxId = DjSysFunc::PFX_SPIRAL;
    } else if ([title isEqualToString:FXPhaser]) {
        fxId = DjSysFunc::PFX_PHASER;
    } else if ([title isEqualToString:FXRoll]) {
        fxId = DjSysFunc::PFX_ROLL;
    } else if ([title isEqualToString:FXTrans]) {
        fxId = DjSysFunc::PFX_TRANS;
    } else if ([title isEqualToString:FXPitch]) {
        fxId = DjSysFunc::PFX_PITCH;
    } else if ([title isEqualToString:FXPitchDown]) {
        fxId = DjSysFunc::PFX_PITCH;
        plusminus = -1;
    } else if ([title isEqualToString:FXNoise]) {
        fxId = DjSysFunc::PFX_NOISE;
    } else if ([title isEqualToString:FXCrush]) {
        fxId = DjSysFunc::PFX_CRUSH;
    } else if ([title isEqualToString:FXHPF]) {
        fxId = DjSysFunc::PFX_HPF;
    } else if ([title isEqualToString:FXLPF]) {
        fxId = DjSysFunc::PFX_LPF;
    } else if ([title isEqualToString:RFXVinylBrake] || [title isEqualToString:FXVBRAKE]) {
        fxId = DjSysFunc::PFX_V_BREAKE;
    } else if ([title isEqualToString:RFXBackSpin]) {
        fxId = DjSysFunc::PFX_BACKSPIN;
    } else if ([title isEqualToString:RFXEcho] || [title isEqualToString: FXRECHO]) {
        fxId = DjSysFunc::PFX_R_ECHO;
    } else if ([title isEqualToString:FXSWEEP]) {
        fxId = DjSysFunc::PFX_SWEEP;
    }
    
    if ([value isEqualToString:Beat1Slash32]) {
        fxValue = DjSysFunc::PFX_BEAT_1_32;
    } else if ([value isEqualToString:Beat1Slash16]) {
        fxValue = DjSysFunc::PFX_BEAT_1_16;
    } else if ([value isEqualToString:Beat1Slash8]) {
        fxValue = DjSysFunc::PFX_BEAT_1_8;
    } else if ([value isEqualToString:Beat1Slash4]) {
        fxValue = DjSysFunc::PFX_BEAT_1_4;
    } else if ([value isEqualToString:Beat1Slash2]) {
        fxValue = DjSysFunc::PFX_BEAT_1_2;
    } else if ([value isEqualToString:Beat3Slash4]) {
        fxValue = DjSysFunc::PFX_BEAT_3_4;
    } else if ([value isEqualToString:Beat1Slash1]) {
        fxValue = DjSysFunc::PFX_BEAT_1_1;
    } else if ([value isEqualToString:Beat2Slash1]) {
        fxValue = DjSysFunc::PFX_BEAT_2_1;
    } else if ([value isEqualToString:Beat4Slash1]) {
        fxValue = DjSysFunc::PFX_BEAT_4_1;
    } else if ([value isEqualToString:Beat8Slash1]) {
        fxValue = DjSysFunc::PFX_BEAT_8_1;
    } else if ([value isEqualToString:Beat16Slash1]) {
        fxValue = DjSysFunc::PFX_BEAT_16_1;
    } else if ([value isEqualToString:Beat32Slash1]) {
        fxValue = DjSysFunc::PFX_BEAT_32_1;
    } else {
        fxValue = [value intValue];
    }
    self.DJSystemFunction_->selectPadFx(Deck_, n, fxId, fxValue * plusminus);
}

#pragma mark - Song Info
- (void)setupSongInfor {
    for (int i = 0; i < 2; i++) {
        [self updateSongInfo:i];
    }
}
/**
 楽曲情報更新
 */
- (void)updateSongInfo:(int)playerID {
    UIImageView *trackArtworkView = playerID == PLAYER_A ? _trackArtWorkLeftImageView : _trackArtWorkRightImageView;
    UILabel *trackArtistLbl = playerID == PLAYER_A ? _trackArtistLeftLabel : _trackArtistRightLabel;
    UILabel *trackTitleLbl = playerID == PLAYER_A ? _trackTitleLeftLabel : _trackTitleRightLabel;
    UILabel *trackBpmLbl = playerID == PLAYER_A ? _trackBpmLeftLabel : _trackBpmRightLabel;
    UILabel *trackKeyLbl = playerID == PLAYER_A ? _trackKeyLLabel : _trackKeyRLabel;
    UILabel *trackKey = playerID == PLAYER_A ?  masterTempoLeftView.styleLable : masterTempoRightView.styleLable;
    NSMutableDictionary *songInfo = [PlayViewCtrl getSongInfo:playerID];
    if (songInfo && ![songInfo isEqual:[NSNull null]]) {
        if ([songInfo[TrackInfoAudioID] longLongValue] > 0) {
            NSString *artwrokPath = songInfo[TrackInfoArtworkPath];
            if (artwrokPath.length) {
                trackArtworkView.image = [UIImage imageWithContentsOfFile:songInfo[TrackInfoArtworkPath]];
            } else {
                trackArtworkView.image = [UIImage imageNamed:kImgArtworkPlayer];
            }
            trackTitleLbl.text      = songInfo[TrackInfoTitle];
            trackArtistLbl.text     = songInfo[TrackInfoArtist];
            trackKeyLbl.text        = songInfo[TrackInfoKey];
            trackKey.text           = songInfo[TrackInfoKey];
        } else {
            [self initSongInfo:trackArtworkView Title:trackTitleLbl Artist:trackArtistLbl Bpm:trackBpmLbl];
        }
    } else {
        [self initSongInfo:trackArtworkView Title:trackTitleLbl Artist:trackArtistLbl Bpm:trackBpmLbl];
    }
    float bpmValue = [DJFunc getDJSystemFunction]->getBpmFromTime(playerID) / 100.0f;
    NSString *strBpm = [NSString stringWithFormat:@"%.2f", bpmValue];
    trackBpmLbl.text = strBpm;
    if ([[UIScreen mainScreen] bounds].size.height < 667) {
        trackTitleLbl.font = [UIFont fontWithName:FontHelvetica size:15.0f];
        trackArtistLbl.font = [UIFont fontWithName:FontHelvetica size:12.0f];
        trackBpmLbl.font = [UIFont fontWithName:FontHelvetica size:15.0f];
    }
}

- (void)initSongInfo:(UIImageView*)Image Title:(UILabel*)title Artist:(UILabel*)artist Bpm:(UILabel*)bpm {
    Image.image = [UIImage imageNamed:kImgArtworkPlayer];
    title.text = @"Tap to load";
    artist.text = Empty;
    bpm.text = Empty;
}

- (void)changeSelectButton: (bool) LeftButton {
    if (LeftButton) {
        [_padLeftButton setSelected:NO];
        //        padLeftView.hidden = YES;
    } else {
        [_padRightButton setSelected:NO];
        //        padRightView.hidden = YES;
    }
}

#pragma mark - Mixer Landscape
- (void)setupMixerLandscape {
    /* set up notification hot cue left */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapCloseMixerLeft) name:DidTapCloseMixerLeft object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapCloseMixerRight) name:DidTapCloseMixerRight object:nil];
}

- (void)didTapCloseMixerLeft {
    mixerLeftView.hidden = YES;
    [self changeSelectButton:true];
}

- (void)didTapCloseMixerRight {
    mixerRightView.hidden = YES;
    [self changeSelectButton:false];
}

#pragma mark - Loop Left View Delegate

- (void)didTapCloseLButton {
    loopLeftView.hidden = YES;
    [self changeSelectButton:true];
}

- (void)didTapINLButton {
    [DJFunc getDJSystemFunction]->loopInButtonDown(PLAYER_A);
}

- (void)didTapOUTLButton {
    [DJFunc getDJSystemFunction]->loopOutButtonDown(PLAYER_A);
}

- (void)didTapRELOOPLButton {
    [DJFunc getDJSystemFunction]->reloopExitButtonDown(PLAYER_A);
}

- (void)didTapPlayLButton {
    [_btnPlayLeft setSelected:YES];
    [_btnPlayLeft setImage:[UIImage imageNamed:kImgPlayOnIcon] forState:UIControlStateSelected];
    [DJFunc getDJSystemFunction]->playONButton(PLAYER_A);
}

#pragma mark - Loop Right View Delegate
- (void)didTapCloseRButton {
    loopRightView.hidden = YES;
    [self changeSelectButton:false];
}

- (void)didTapINRButton {
    [DJFunc getDJSystemFunction]->loopInButtonDown(PLAYER_B);
}

- (void)didTapOUTRButton {
    [DJFunc getDJSystemFunction]->loopOutButtonDown(PLAYER_B);
}

- (void)didTapRELOOPRButton {
    [DJFunc getDJSystemFunction]->reloopExitButtonDown(PLAYER_B);
}

- (void)didTapPlayRButton {
    [_btnPlayRight setSelected:YES];
    [_btnPlayRight setImage:[UIImage imageNamed:kImgPlayOnIcon] forState:UIControlStateSelected];
    [DJFunc getDJSystemFunction]->playONButton(PLAYER_B);
}

#pragma mark - PadFx Left View Delegate
- (void)btnFxDidPushL:(UIButton*)sender {
    self.DJSystemFunction_->padFxDown(PLAYER_A, (int)sender.tag);
}

- (void)btnFxDidUpL:(UIButton*)sender {
    self.DJSystemFunction_->padFxUp(PLAYER_A, (int)sender.tag);
}

#pragma mark - PadFx Right View Delegate
- (void)btnFxDidPushR:(UIButton*)sender {
    self.DJSystemFunction_->padFxDown(PLAYER_B, (int)sender.tag);
}

- (void)btnFxDidUpR:(UIButton*)sender {
    self.DJSystemFunction_->padFxUp(PLAYER_B, (int)sender.tag);
}

#pragma mark - BeatFx Left View Delegate

- (void)btnBeatFxDownL:(int)name value:(int)value {
    nameBeatFxL = name;
    valueBeatFxL = value;
    styleBeatOpenL = YES;
}

- (void)btnBeatFxUpL {
    self.DJSystemFunction_->selectBeatFx(PLAYER_A, nameBeatFxL);
    if (self.DJSystemFunction_->isBeatFxOn(PLAYER_A)) {
        self.DJSystemFunction_->turnBeatFxOff(PLAYER_A);
    } else {
        self.DJSystemFunction_->turnBeatFxOn(PLAYER_A);
    }
    styleBeatOpenL = NO;
}

- (void)btnBeatFxStyleDownL:(int)name value:(int)value {
    self.DJSystemFunction_->selectBeatFx(PLAYER_A, name);
    self.DJSystemFunction_->turnBeatFxOn(PLAYER_A);
}

- (void)btnBeatFxStyleUpL {
    self.DJSystemFunction_->turnBeatFxOff(PLAYER_A);
    styleBeatOpenL = NO;
}

- (void)didTapSliderL:(UISlider *)sender {
    self.DJSystemFunction_->setLevelDepth(PLAYER_A, sender.value);
    if (styleBeatOpenL) {
        self.DJSystemFunction_->turnBeatFxOn(PLAYER_A);
    }
}

#pragma mark - BeatFx Right View Delegate

- (void)btnBeatFxDownR:(int)name value:(int)value {
    nameBeatFxR = name;
    valueBeatFxR = value;
    styleBeatOpenR = YES;
}

- (void)btnBeatFxUpR {
    self.DJSystemFunction_->selectBeatFx(PLAYER_B, nameBeatFxR);
    if (self.DJSystemFunction_->isBeatFxOn(PLAYER_B)) {
        self.DJSystemFunction_->turnBeatFxOff(PLAYER_B);
    } else {
        self.DJSystemFunction_->turnBeatFxOn(PLAYER_B);
    }
    styleBeatOpenR = NO;
}

- (void)btnBeatFxStyleDownR:(int)name value:(int)value {
    self.DJSystemFunction_->selectBeatFx(PLAYER_B, name);
    self.DJSystemFunction_->turnBeatFxOn(PLAYER_B);
    nameBeatFxR = name;
    valueBeatFxR = value;
    styleBeatOpenR = YES;
}

- (void)btnBeatFxStyleUpR {
    self.DJSystemFunction_->turnBeatFxOff(PLAYER_B);
    styleBeatOpenR = NO;
}

- (void)didTapSliderR:(UISlider *)sender {
    self.DJSystemFunction_->setLevelDepth(PLAYER_B, sender.value);
    if (styleBeatOpenR) {
        self.DJSystemFunction_->turnBeatFxOn(PLAYER_B);
    }
}

#pragma mark - Beat Jump Left View Delegate

- (void)didTapBeatJumbCloseLButton {
    beatJumpLeftView.hidden = YES;
    [self changeSelectButton:true];
}

- (void)didTapOnBeatsPreLButton:(UIButton *)sender {
    int selectBeat = (int)sender.tag;
    uint32 range = [beats[static_cast<NSUInteger>(selectBeat)] unsignedIntValue];
    [DJFunc getDJSystemFunction]->selectbeatJump(PLAYER_A, range);
    [DJFunc getDJSystemFunction]->beatJumpButtonDown(PLAYER_A, NO);
}

- (void)didTapOnBeatsNextLButton:(UIButton *)sender {
    int selectBeat = (int)sender.tag;
    uint32 range = [beats[static_cast<NSUInteger>(selectBeat)] unsignedIntValue];
    [DJFunc getDJSystemFunction]->selectbeatJump(PLAYER_A, range);
    [DJFunc getDJSystemFunction]->beatJumpButtonDown(PLAYER_A, YES);
}

#pragma mark - Beat Jump Connect Left View Delegate

- (void)didTapOnBeatsPreLConnectButton:(UIButton *)sender {
    [self didTapOnBeatsPreLButton:sender];
}

- (void)didTapOnBeatsNextLConnectButton:(UIButton *)sender {
    [self didTapOnBeatsNextLButton:sender];
}

#pragma mark - Beat Jump Right View Delegate

- (void)didTapBeatJumpCloseRButton {
    beatJumpRightView.hidden = YES;
    [self changeSelectButton:false];
}

- (void)didTapOnBeatsPreRButton:(UIButton *)sender {
    int selectBeat = (int)sender.tag;
    uint32 range = [beats[static_cast<NSUInteger>(selectBeat)] unsignedIntValue];
    [DJFunc getDJSystemFunction]->selectbeatJump(PLAYER_B, range);
    [DJFunc getDJSystemFunction]->beatJumpButtonDown(PLAYER_B, NO);
}

- (void)didTapOnBeatsNextRButton:(UIButton *)sender {
    int selectBeat = (int)sender.tag;
    uint32 range = [beats[static_cast<NSUInteger>(selectBeat)] unsignedIntValue];
    [DJFunc getDJSystemFunction]->selectbeatJump(PLAYER_B, range);
    [DJFunc getDJSystemFunction]->beatJumpButtonDown(PLAYER_B, YES);
}

#pragma mark - Beat Jump Connect Right View Delegate

- (void)didTapOnBeatsPreRConnectButton:(UIButton *)sender {
    [self didTapOnBeatsPreRButton:sender];
}

- (void)didTapOnBeatsNextRConnectButton:(UIButton *)sender {
    [self didTapOnBeatsNextRButton:sender];
}

#pragma mark - Jog View
- (void)setupJogView {
    // Setup Jog View
    _baseJogView.userInteractionEnabled = YES;
    _baseJogView.backgroundColor = [UIColor clearColor];
    [_baseJogView createLeftViewInView:_leftJogView];
    [_baseJogView createRightViewInView:_rightJogView];
    [self setupJogCoverImage];
    [self scratchCancel];
    
    // Setup Vertical View Left
    _leftVerticalWaveView.userInteractionEnabled = YES;
    _VerticalWaveLeftView_ = [VerticalWaveLeftView sharedInstance];
    _VerticalWaveLeftView_.userInteractionEnabled = YES;
    _VerticalWaveLeftView_.PlayerView_ = PLAYER_A;
    _VerticalWaveLeftView_.c_WidhtBaseViewCenter = static_cast<float>(_leftVerticalWaveView.width);
    _VerticalWaveLeftView_.c_HeightBaseViewCenter = static_cast<float>(_leftVerticalWaveView.height);
    _VerticalWaveLeftView_.transform = CGAffineTransformMakeRotation(M_PI/2);
    _VerticalWaveLeftView_.frame = CGRectMake(0, 0, _leftVerticalWaveView.width, _leftVerticalWaveView.height);
    [_leftVerticalWaveView addSubview:_VerticalWaveLeftView_];
    [_VerticalWaveLeftView_ createView];
    _VerticalWaveLeftView_.hidden = NO;
    
    // Setup Vertical View Right
    _rightVerticalWaveView.userInteractionEnabled = YES;
    _VerticalWaveRightView_ = [VerticalWaveRightView sharedInstance];
    _VerticalWaveRightView_.userInteractionEnabled = YES;
    _VerticalWaveRightView_.PlayerView_ = PLAYER_B;
    _VerticalWaveRightView_.c_WidhtBaseViewCenter = static_cast<float>(_rightVerticalWaveView.width);
    _VerticalWaveRightView_.c_HeightBaseViewCenter = static_cast<float>(_rightVerticalWaveView.height);
    _VerticalWaveRightView_.transform = CGAffineTransformMakeRotation(M_PI/2);
    _VerticalWaveRightView_.frame = CGRectMake(0, 0, _rightVerticalWaveView.width, _rightVerticalWaveView.height);
    [_rightVerticalWaveView addSubview:_VerticalWaveRightView_];
    [_VerticalWaveRightView_ createView];
    _VerticalWaveRightView_.hidden = NO;
    
    // Setup HorizontalView
    float widthHorizontal   = static_cast<float>(_baseHorizontalWaveView_.width);
    float heightHorizontal  = static_cast<float>(_baseHorizontalWaveView_.height * RatioHeight);
    _baseHorizontalWaveView_.userInteractionEnabled = YES;
    _HorizontalWaveView_ = [HorizontalWaveView sharedInstance];
    _HorizontalWaveView_.userInteractionEnabled = YES;
    _HorizontalWaveView_.backgroundColor = [UIColor clearColor];
    _HorizontalWaveView_.c_WidhtBaseViewCenter = widthHorizontal;
    _HorizontalWaveView_.c_HeightBaseViewCenter = heightHorizontal;
    [_baseHorizontalWaveView_ addSubview:_HorizontalWaveView_];
    _HorizontalWaveView_.translatesAutoresizingMaskIntoConstraints = NO;
    [_HorizontalWaveView_.centerYAnchor constraintEqualToAnchor:_baseHorizontalWaveView_.centerYAnchor constant: ZeroValue].active = YES;
    [_HorizontalWaveView_.centerXAnchor constraintEqualToAnchor:_baseHorizontalWaveView_.centerXAnchor constant: ZeroValue].active = YES;
    [_HorizontalWaveView_.widthAnchor constraintEqualToConstant:widthHorizontal].active = YES;
    [_HorizontalWaveView_.heightAnchor constraintEqualToConstant:heightHorizontal].active = YES;
    
    _baseHorizontalWaveView_.hidden = YES;
    _HorizontalWaveView_.hidden = YES;
    
    NSInteger mode = [[NSUserDefaults standardUserDefaults] integerForKey:kStandaloneDisplayMode];
    switch (mode) {
        case JOG:
            [self btnJogDidPush:nil];
            break;
            
        case HORIZONTALWAVE:
            [self btnHorizontalWaveDidPush:nil];
            break;
            
        case VERTICALWAVE:
            [self btnVerticalWaveDidPush:nil];
            break;
            
        default:
            [self btnJogDidPush:nil];
            break;
    }
}

- (void)setupJogCoverImage {
    for (int i = 0; i < 2; i++) {
        [self updateJogCoverImage:i];
    }
}
/**
 楽曲情報更新
 */
- (void)updateJogCoverImage:(int)playerID {
    NSMutableDictionary *songInfo = [PlayViewCtrl getSongInfo:playerID];
    if (songInfo && ![songInfo isEqual:[NSNull null]]) {
        if ([songInfo[TrackInfoAudioID] longLongValue] > 0) {
            NSString *artworkPath = songInfo[TrackInfoArtworkPath];
            if (artworkPath.length) {
                [self setCoverArt:YES deck:playerID];
            } else {
                [self setCoverArt:NO deck:playerID];
            }
        } else {
            [self setCoverArt:NO deck:playerID];
        }
    } else {
        [self setCoverArt:NO deck:playerID];
    }
}

/**
 スクラッチ強制キャンセル
 */
- (void)scratchCancel {
    if (SlicerBackGroundPlaying1_) {
        [DJFunc getDJSystemFunction]->touchSlicerSlot(0, (int)SlicerBackGroundPlaying1_ - 1, NO);
        SlicerBackGroundPlaying1_ = 0;
    }
    if (SlicerBackGroundPlaying2_) {
        [DJFunc getDJSystemFunction]->touchSlicerSlot(1, (int)SlicerBackGroundPlaying2_ - 1, NO);
        SlicerBackGroundPlaying2_ = 0;
    }
    
    if (isScratching1_) {
        _baseJogView.panGesture1_.enabled = NO;
        _baseJogView.panGesture1_.enabled = YES;
        [DJFunc getDJSystemFunction]->releaseJog(0);
    }
    if (isScratching2_) {
        _baseJogView.panGesture2_.enabled = NO;
        _baseJogView.panGesture2_.enabled = YES;
        [DJFunc getDJSystemFunction]->releaseJog(1);
    }
}

/**
 ボタンON/OFF周期確認タイマー
 */
- (void)jogRotationTimer:(NSTimer *)tm {
    // 再生時間
    [DJFunc getDJSystemFunction]->getBeatGrid(PLAYER_A, _beats1_);
    [DJFunc getDJSystemFunction]->getBeatGrid(PLAYER_B, _beats2_);
    NSInteger playTime1, totalTime1;
    NSInteger playTime2, totalTime2;
    _PrevPlayTime1_ = [DJFunc getDJSystemFunction]->getPlayingTime(0);
    _BackPlayTime1_ = [DJFunc getDJSystemFunction]->getBackGroundPlayingTime(0);
    _PrevPlayTime2_ = [DJFunc getDJSystemFunction]->getPlayingTime(1);
    _BackPlayTime2_ = [DJFunc getDJSystemFunction]->getBackGroundPlayingTime(1);
    playTime1 = _PrevPlayTime1_;
    playTime2 = _PrevPlayTime2_;
    totalTime1 = [DJFunc getDJSystemFunction]->getTotalTime(0);
    totalTime2 = [DJFunc getDJSystemFunction]->getTotalTime(1);
    
    CGFloat rot = ((M_PI * 11) / 1000) * (_PrevPlayTime1_ / 10);
    _baseJogView.JogOuterRing1_.transform = CGAffineTransformMakeRotation(rot);
    
    if (!_JogTouchScratchSpinning1_ && !_NeedleSearching1_) {
        CGFloat per = (CGFloat)playTime1 / (CGFloat)totalTime1;
        NSInteger startBeat = (NSInteger)(per * _beats1_.size()) - 5;
        if (startBeat < 0) {
            startBeat = 0;
        }
        int beatNm = 0;
        NSInteger i = 0;
        for (i = startBeat; i < _beats1_.size(); i++) {
            unsigned int beatTm = _beats1_[(int)i].Time;
            if (PrevBeatTm1_ != beatTm &&
                beatTm - 20 < playTime1 &&
                playTime1 < beatTm + 20) {
                beatNm = _beats1_[(int)i].beatNum;
                PrevBeatTm1_ = beatTm;
                break;
            }
            
            if (playTime1 < beatTm + 40) {
                break;
            }
        }
        
        if (beatNm != 0) {
            CGFloat outBoundSize = 1.0f;
            CGFloat inBoundSize = 1.0f;
            
            if (isJogAnimation_) {
                outBoundSize = OUTNERBOUND234;
                inBoundSize = INNERBOUND234;
            }
            
            UIViewAnimationOptions myOption = UIViewAnimationOptionCurveLinear;
            [UIView animateWithDuration:OUTNERBOUND_TIME delay:0.0 options:myOption animations:^{
                self->_baseJogView.JogOuterRing1_.transform = CGAffineTransformScale(self->_baseJogView.JogOuterRing1_.transform, outBoundSize, outBoundSize);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:OUTNERBOUND_TIME delay:0.0 options:myOption animations:^{
                    self->_baseJogView.JogOuterRing1_.transform = CGAffineTransformScale(self->_baseJogView.JogOuterRing1_.transform, 1.0, 1.0);
                } completion:^(BOOL finished) {
                }];
            }];
        }
    }
    
    rot = ((M_PI * 11) / 1000) * (_PrevPlayTime2_ / 10);
    _baseJogView.JogOuterRing2_.transform = CGAffineTransformMakeRotation(rot);
    
    if (!_JogTouchScratchSpinning2_ && !_NeedleSearching2_) {
        CGFloat per = (CGFloat)playTime2 / (CGFloat)totalTime2;
        NSInteger startBeat = (NSInteger)(per * _beats2_.size()) - 5;
        if (startBeat < 0) {
            startBeat = 0;
        }
        int beatNm = 0;
        NSInteger i = 0;
        for (i = startBeat; i < _beats2_.size(); i++) {
            unsigned int beatTm = _beats2_[(int)i].Time;
            if (PrevBeatTm2_ != beatTm &&
                beatTm - 20 < playTime2 &&
                playTime2 < beatTm + 20) {
                beatNm = _beats2_[(int)i].beatNum;
                PrevBeatTm2_ = beatTm;
                break;
            }
            
            if (playTime2 < beatTm + 40) {
                break;
            }
        }
        
        if (beatNm != 0) {
            CGFloat outBoundSize = 1.0f;
            CGFloat inBoundSize = 1.0f;
            
            if (isJogAnimation_) {
                outBoundSize = OUTNERBOUND234;
                inBoundSize = INNERBOUND234;
            }
            
            UIViewAnimationOptions myOption = UIViewAnimationOptionCurveLinear;
            [UIView animateWithDuration:OUTNERBOUND_TIME delay:0.0 options:myOption animations:^{
                self->_baseJogView.JogOuterRing2_.transform = CGAffineTransformScale(self->_baseJogView.JogOuterRing2_.transform, outBoundSize, outBoundSize);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:OUTNERBOUND_TIME delay:0.0 options:myOption animations:^{
                    self->_baseJogView.JogOuterRing2_.transform = CGAffineTransformScale(self->_baseJogView.JogOuterRing2_.transform, 1.0, 1.0);
                } completion:^(BOOL finished) {
                }];
            }];
        }
    }
    
    // SLIP、Slicer時のバックグラウンド再生中
    if (playTime1 == _BackPlayTime1_) {
        _BackPlayTime1_ = 0;
    }
    
    // SLIP_BackPlayTime1_バックグラウンド再生中
    if (playTime2 == _BackPlayTime2_) {
        _BackPlayTime2_ = 0;
    }
    
#ifdef ENTIRE_WAVE_NEEDLE16ms
    if ([DJFunc getDJSystemFunction]->isLoaded(0)) {
        int pos = [self loudWavePositionPercent:(int)playTime1 totalTime:(int)totalTime1];
        int backPos = -1;
        if (BackPlayTime1_ > 0) {
            backPos = [self loudWavePositionPercent:(int)BackPlayTime1_ totalTime:(int)totalTime1];
        }
        
        CGRect rect = deck1LoudWaveViewLandscape.LoudEndView_.frame;
        
        // バックグラウンド再生位_BackPlayTime2_
        i_BackPlayTime2_1_ != backPos) {
            if (0 <= backPos && backPos <= deck1LoudWaveViewLandscape.frame.size.width) {
                deck1LoudWaveViewLandscape.BackgroundPlayNeedleBackView_.hidden = NO;
                rect = deck1LoudWaveViewLandscape.BackgroundPlayNeedleBackView_.frame;
                rect.origin.x = backPos - 2;
                deck1LoudWaveViewLandscape.BackgroundPlayNeedleBackView_.frame = rect;
            } else {
                deck1LoudWaveViewLandscape.BackgroundPlayNeedleBackView_.hidden = YES;
            }
            PrevBackPos1_ = backPos;
        }
        if (PrevPos1_ != pos) {
            // 再生済みView
            rect = deck1LoudWaveViewLandscape.LoudEndView_.frame;
            if (pos >= 1) {
                rect.size.width = pos - 1;
            } else {
                rect.size.width = pos;
            }
            deck1LoudWaveViewLandscape.LoudEndView_.frame = rect;
            
            if (0 < (int)totalTime1 - (int)playTime1 &&
                (int)totalTime1 - (int)playTime1 <= 30000) {
                if (![DJFunc getDJSystemFunction]->isPlayEnd(0)) {
                    if (!isEndViewAnimation1_) {
                        isEndViewAnimation1_ = YES;
                        [UIView animateWithDuration:0.45f delay:0.0f options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
                            deck1LoudWaveViewLandscape.LoudEndView_.alpha = 0.0f;
                        } completion:^(BOOL finished) {
                            isEndViewAnimation1_ = NO;
                            [deck1LoudWaveViewLandscape.LoudEndView_.layer removeAllAnimations];
                            deck1LoudWaveViewLandscape.LoudEndView_.alpha = 0.6f;
                        }];
                    }
                } else {
                    isEndViewAnimation1_ = NO;
                    [deck1LoudWaveViewLandscape.LoudEndView_.layer removeAllAnimations];
                    deck1LoudWaveViewLandscape.LoudEndView_.alpha = 0.6f;
                }
            } else if ((int)totalTime1 - (int)playTime1 > 30000) {
                isEndViewAnimation1_ = NO;
                [deck1LoudWaveViewLandscape.LoudEndView_.layer removeAllAnimations];
                deck1LoudWaveViewLandscape.LoudEndView_.alpha = 0.6f;
            } else if ((int)totalTime1 - (int)playTime1 <= 0) {
                isEndViewAnimation1_ = NO;
                [deck1LoudWaveViewLandscape.LoudEndView_.layer removeAllAnimations];
                deck1LoudWaveViewLandscape.LoudEndView_.alpha = 0.6f;
            }
            
            rect = deck1LoudWaveViewLandscape.PlayNeedleBackView_.frame;
            // 再生位置ニードル
            rect.origin.x = pos - 2;
            _LoudView1_.PlayNeedleBackView_.frame = rect;
            
            UIColor* needleColor;
            if ([DJFunc getDJSystemFunction]->isSlipModeOn(0)) {
                needleColor = kColor_Needle_Slip;
            } else if (_SlicerOn1_) {
                needleColor = kColor_Needle_SlipPanel;
            } else {
                int playState = [DJFunc getDJSystemFunction]->getPlayState(0);
                if (playState == PAUSE || playState == STOP) {
                    needleColor = kColor_Needle_Pause;
                } else {
                    if (_NeedleSearching1_ || _JogTouchScrachSpinning1_) {
                        needleColor = kColor_Needle_Pause;
                    } else {
                        needleColor = kColor_Needle_Playing;
                    }
                }
            }
            deck1LoudWaveViewLandscape.PlayNeedleView_.backgroundColor = needleColor;
            PrevPos1_ = pos;
        }
    }
    
    if ([DJFunc getDJSystemFunction]->isLoaded(1)) {
        int pos = [self loudWavePositionPercent:(int)playTime2 totalTime:(int)totalTime2];
        int backPos = -1;
        if (BackPlayTime2_ > 0) {
            backPos = [self loudWavePositionPercent:(int)BackPlayTime2_ totalTime:(int)totalTime2];
        }
        
        CGRect rect = deck2LoudWaveViewLandscape.LoudEndView_.frame;
        
        // バックグラウンド再生位置ニードル
        if (PrevBackPos2_ != backPos) {
            if (0 <= backPos && backPos <= deck2LoudWaveViewLandscape.frame.size.width) {
                deck2LoudWaveViewLandscape.BackgroundPlayNeedleBackView_.hidden = NO;
                rect = deck2LoudWaveViewLandscape.BackgroundPlayNeedleBackView_.frame;
                rect.origin.x = backPos - 2;
                deck2LoudWaveViewLandscape.BackgroundPlayNeedleBackView_.frame = rect;
            } else {
                deck2LoudWaveViewLandscape.BackgroundPlayNeedleBackView_.hidden = YES;
            }
            PrevBackPos2_ = backPos;
        }
        
        if (PrevPos2_ != pos) {
            // 再生済みView
            rect = deck2LoudWaveViewLandscape.LoudEndView_.frame;
            if (pos >= 1) {
                rect.size.width = pos - 1;
            } else {
                rect.size.width = pos;
            }
            deck2LoudWaveViewLandscape.LoudEndView_.frame = rect;
            
            if (0 < (int)totalTime2 - (int)playTime2 &&
                (int)totalTime2 - (int)playTime2 <= 30000) {
                if (![DJFunc getDJSystemFunction]->isPlayEnd(1)) {
                    if (!isEndViewAnimation2_) {
                        isEndViewAnimation2_ = YES;
                        [UIView animateWithDuration:0.45f delay:0.0f options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
                            deck2LoudWaveViewLandscape.LoudEndView_.alpha = 0.0f;
                        } completion:^(BOOL finished) {
                            isEndViewAnimation2_ = NO;
                            [deck2LoudWaveViewLandscape.LoudEndView_.layer removeAllAnimations];
                            deck2LoudWaveViewLandscape.LoudEndView_.alpha = 0.6f;
                        }];
                    }
                } else {
                    isEndViewAnimation2_ = NO;
                    [deck2LoudWaveViewLandscape.LoudEndView_.layer removeAllAnimations];
                    deck2LoudWaveViewLandscape.LoudEndView_.alpha = 0.6f;
                }
            } else if (totalTime2 - (int)playTime2 > 30000) {
                isEndViewAnimation2_ = NO;
                [deck2LoudWaveViewLandscape.LoudEndView_.layer removeAllAnimations];
                deck2LoudWaveViewLandscape.LoudEndView_.alpha = 0.6f;
            } else if (totalTime2 - (int)playTime2 <= 0) {
                isEndViewAnimation2_ = NO;
                [deck2LoudWaveViewLandscape.LoudEndView_.layer removeAllAnimations];
                deck2LoudWaveViewLandscape.LoudEndView_.alpha = 0.6f;
            }
            
            // 再生位置ニードル
            rect = deck2LoudWaveViewLandscape.PlayNeedleBackView_.frame;
            rect.origin.x = pos - 2;
            deck2LoudWaveViewLandscape.PlayNeedleBackView_.frame = rect;
            
            UIColor* needleColor;
            if ([DJFunc getDJSystemFunction]->isSlipModeOn(1)) {
                needleColor = kColor_Needle_Slip;
            } else if (_SlicerOn2_) {
                needleColor = kColor_Needle_SlipPanel;
            } else {
                int playState = [DJFunc getDJSystemFunction]->getPlayState(1);
                if (playState == PAUSE || playState == STOP) {
                    needleColor = kColor_Needle_Pause;
                } else {
                    if (_NeedleSearching2_ || _JogTouchScratchSpinning2_) {
                        needleColor = kColor_Needle_Pause;
                    } else {
                        needleColor = kColor_Needle_Playing;
                    }
                }
            }
            deck2LoudWaveViewLandscape.PlayNeedleView_.backgroundColor = needleColor;
            PrevPos2_ = pos;
        }
    }
#endif
    
    _SliderValue12_ = _SliderValue11_;
    _SliderValue22_ = _SliderValue21_;
    _SliderValue11_ = _TempoEditView1_.TempoSlider_.value;
    _SliderValue21_ = _TempoEditView2_.TempoSlider_.value;
}

- (void)setCueMarkerHotCue {
    NSInteger prevPlayTime1 = [DJFunc getDJSystemFunction]->getPlayingTime(0);
    NSInteger prevPlayTime2 = [DJFunc getDJSystemFunction]->getPlayingTime(1);
    
    CGFloat rot = ((M_PI * 11) / 1000) * (prevPlayTime1 / 10);
    _baseJogView.JogRingMarker1_.transform = CGAffineTransformMakeRotation(rot);
    
    rot = ((M_PI * 11) / 1000) * (prevPlayTime2 / 10);
    _baseJogView.JogRingMarker2_.transform = CGAffineTransformMakeRotation(rot);
}

/**
 設定：CoverArt有効／無効
 */
- (void)jogAnimationOnOff:(NSNotification*)center {
    isJogAnimation_ = [[PreferenceManager sharedManager] isOnJogAnimation];
}


/**
 カバーアートの色を取得
 */
- (void)setCoverArt:(BOOL)isCoverArt deck:(int)deck {
    if (deck == 0) {
        if (isCoverArt) {
            NSMutableDictionary *songInfo = [PlayViewCtrl getSongInfo:PLAYER_A];
            if (songInfo && ![songInfo isEqual:[NSNull null]]) {
                if ([songInfo[TrackInfoAudioID] longLongValue] > 0) {
                    NSString *artworkPath = songInfo[TrackInfoArtworkPath];
                    if (artworkPath.length) {
                        nonCoverArtImg_ = [UIImage imageWithContentsOfFile:songInfo[TrackInfoArtworkPath]];
                    } else {
                        nonCoverArtImg_ = [UIImage imageNamed:kImgArtworkLogo];
                    }
                }
            }
        } else {
            // ジャケ写なし
            nonCoverArtImg_ = [UIImage imageNamed:kImgArtworkLogo];
        }
        
        _baseJogView.CoverArtJog1_.image = [ImageMask maskImage:nonCoverArtImg_ ImgSize:_leftJogView.frame.size];
        _baseJogView.CoverArtJog1_.hidden = YES;
        _baseJogView.MonoCoverArtJog1_.image = [ImageMask maskImage:nonCoverArtImg_ ImgSize:_leftJogView.frame.size];
    }
    if (deck == 1) {
        if (isCoverArt) {
            NSMutableDictionary *songInfo = [PlayViewCtrl getSongInfo:PLAYER_B];
            if (songInfo && ![songInfo isEqual:[NSNull null]]) {
                if ([songInfo[TrackInfoAudioID] longLongValue] > 0) {
                    NSString *artworkPath = songInfo[TrackInfoArtworkPath];
                    if (artworkPath.length) {
                        nonCoverArtImg_ = [UIImage imageWithContentsOfFile:songInfo[TrackInfoArtworkPath]];
                    } else {
                        nonCoverArtImg_ = [UIImage imageNamed:kImgArtworkLogo];
                    }
                }
            }
        } else{
            // ジャケ写なし
            nonCoverArtImg_ = [UIImage imageNamed:kImgArtworkLogo];
        }
        
        _baseJogView.CoverArtJog2_.image = [ImageMask maskImage:nonCoverArtImg_ ImgSize:_rightJogView.frame.size];
        _baseJogView.CoverArtJog2_.hidden = YES;
        _baseJogView.MonoCoverArtJog2_.image = [ImageMask maskImage:nonCoverArtImg_ ImgSize:_rightJogView.frame.size];
    }
}

#pragma mark - Change Display Wave Style

/**
 JOGボタンタップ
 */
- (void)btnJogDidPush:(id)sender {
    _VerticalWaveLeftView_.hidden = NO;
    _VerticalWaveRightView_.hidden = NO;
    CGFloat SafeAreaInsets_Left_ = 0.0f;
    if (@available(iOS 11, *))
    {
        SafeAreaInsets_Left_ = self.view.safeAreaInsets.left;
    }
    
    [self scratchCancel];
    if (self.DisplayMode_ == JOG) {
        ModeChangeAnimationTime_ = ANIMATION_SEC;
    } else if (self.DisplayMode_ == VERTICALWAVE) {
    } else if (self.DisplayMode_ == HORIZONTALWAVE) {
        self.DisplayMode_ = JOG;
        [[NSUserDefaults standardUserDefaults] setInteger:JOG forKey:kStandaloneDisplayMode];
        float xJog = static_cast<float>(_baseJogView.x);
        float yJog = static_cast<float>(_baseJogView.y);
        self.JogbView_.frame = CGRectMake(self.view.bounds.size.width, self.JogbView_.frame.origin.y, self.JogbView_.frame.size.width, self.JogbView_.frame.size.height);
        
        [UIView animateWithDuration:ModeChangeAnimationTime_ delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.HorizontalWaveView_.frame = CGRectMake(-self.view.bounds.size.width, self.HorizontalWaveView_.frame.origin.y, self.HorizontalWaveView_.frame.size.width, self.HorizontalWaveView_.frame.size.height);
            self->JogbView_.frame = CGRectMake(xJog, yJog, self->JogbView_.frame.size.width, self->JogbView_.frame.size.height);
            
        } completion:^(BOOL finished) {
            ConnectDevice connectedDevice = [PlayerStateRepository sharedInstance].connectedDeviceType;
            if (connectedDevice == NON_DEVICE || connectedDevice == CONNECT_Unknown || connectedDevice == CONNECT_WannaBe || connectedDevice == CONNECT_EP134) {
                self.HorizontalWaveView_.hidden = YES;
                self.baseHorizontalWaveView_.hidden = YES;
            } else {
            }
            
            self->ModeChangeAnimationTime_ = ANIMATION_SEC;
        }];
        
    } else {
    }
    
    BOOL isJogZoomWave = NO;
    if ([DJFunc getDJSystemFunction]->isInLoop(0) || self.JogTouchScratchSpinning1_) {
        isJogZoomWave = YES;
        [self updateJogZoomWaveView:0 isShow:YES];
    }
    if ([DJFunc getDJSystemFunction]->isInLoop(1) || self.JogTouchScratchSpinning2_) {
        isJogZoomWave = YES;
        [self updateJogZoomWaveView:1 isShow:YES];
    }
    if (!isJogZoomWave) {
        [DJFunc getDJSystemFunction]->stopZoomWaveUpdate();
        [self stopZoomWaveUpdate];
    }
    
    [self setStatusForJogBtn:sender];
    [[NSUserDefaults standardUserDefaults] setInteger:JOG forKey:kStandaloneDisplayMode];
} 

/**
 横波形ボタンタップ
 */
- (void)btnHorizontalWaveDidPush:(id)sender {
    self.VerticalWaveLeftView_.hidden = YES;
    self.VerticalWaveRightView_.hidden = YES;
    [self stopZoomWaveUpdate];
#if IOS_METAL_KIT_VIEW && IOS_METAL_KIT_VIEW_THREAD
    [self.HorizontalWaveView_.ZoomTwinViewLandscape_ stopZoomWaveUpdate];
#endif
    [DJFunc getDJSystemFunction]->stopZoomWaveUpdate();
    
    CGFloat SafeAreaInsets_Left_ = 0.0f;
    if (@available(iOS 11, *))
    {
        SafeAreaInsets_Left_ = self.view.safeAreaInsets.left;
    }
    
    if (self.DisplayMode_ == JOG) {
        [self.HorizontalWaveView_ closeWaveEdit];
        self.DisplayMode_ = HORIZONTALWAVE;
        [[NSUserDefaults standardUserDefaults] setInteger:HORIZONTALWAVE forKey:kStandaloneDisplayMode];
        self.HorizontalWaveView_.frame = CGRectMake(-self.view.bounds.size.width, self.HorizontalWaveView_.frame.origin.y, self.HorizontalWaveView_.frame.size.width, self.HorizontalWaveView_.frame.size.height);
        
        [UIView animateWithDuration:ModeChangeAnimationTime_ delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.JogbView_.frame = CGRectMake(self.view.bounds.size.width, self.JogbView_.frame.origin.y, self.JogbView_.frame.size.width, self.JogbView_.frame.size.height);
            [self.baseHorizontalWaveView_ addSubview:self.HorizontalWaveView_];
            float widthHorizontal   = self.baseHorizontalWaveView_.width;
            float heightHorizontal  = self.baseHorizontalWaveView_.height * RatioHeight;
            self.HorizontalWaveView_.translatesAutoresizingMaskIntoConstraints = NO;
            [self.HorizontalWaveView_.centerYAnchor constraintEqualToAnchor:self.baseHorizontalWaveView_.centerYAnchor constant: ZeroValue].active = YES;
            [self.HorizontalWaveView_.centerXAnchor constraintEqualToAnchor:self.baseHorizontalWaveView_.centerXAnchor constant: ZeroValue].active = YES;
            [self.HorizontalWaveView_.widthAnchor constraintEqualToConstant:widthHorizontal].active = YES;
            [self.HorizontalWaveView_.heightAnchor constraintEqualToConstant:heightHorizontal].active = YES;
            
        } completion:^(BOOL finished) {
            ConnectDevice connectedDevice = [PlayerStateRepository sharedInstance].connectedDeviceType;
            if (connectedDevice == NON_DEVICE || connectedDevice == CONNECT_Unknown || connectedDevice == CONNECT_WannaBe || connectedDevice == CONNECT_EP134) {
                self.HorizontalWaveView_.hidden = NO;
                self.baseHorizontalWaveView_.hidden = NO;
            }
            self->ModeChangeAnimationTime_ = ANIMATION_SEC;
        }];
        [_HorizontalWaveView_ createView];
        
    } else if (self.DisplayMode_ == VERTICALWAVE) {
    } else if (self.DisplayMode_ == HORIZONTALWAVE) {
        ModeChangeAnimationTime_ = ANIMATION_SEC;
    }
    
    [self updateJogZoomWaveView:0 isShow:NO];
    [self updateJogZoomWaveView:1 isShow:NO];
    
    [self setStatusForHorizontalBtn:sender];
    [[NSUserDefaults standardUserDefaults] setInteger:HORIZONTALWAVE forKey:kStandaloneDisplayMode];
}
/**
 縦波形ボタンタップ
 */
- (void)btnVerticalWaveDidPush:(id)sender {
    // TODO
}

#pragma mark - Stop Zoom Wave Update
- (void)stopZoomWaveUpdate
{
    if ((DisplayMode_ == JOG &&
         (_JogTouchScratchSpinning1_ ||
          _JogTouchScratchSpinning2_ ||
          DJSystemFunction_->isInLoop(0) ||
          DJSystemFunction_->isInLoop(1))) ||
        DisplayMode_ == HORIZONTALWAVE ||
        DisplayMode_ == VERTICALWAVE) {
        // 波形描画止めない
    } else {
        [self stopZoomWaveUpdateDeck];
    }
}

- (void)stopZoomWaveUpdateDeck
{
#if IOS_METAL_KIT_VIEW && IOS_METAL_KIT_VIEW_THREAD
    [_HorizontalWaveView_.ZoomTwinViewLandscape_ stopZoomWaveUpdate];
    //    [controlHorizontalWave.ZoomTwinViewLandscape_ stopZoomWaveUpdate];
    //    [_VerticalWaveView_.ZoomTwinViewLandscape_ stopZoomWaveUpdate];
    //    [_VerticalWaveView_.WeGOZoomTwinViewLandscape_ stopZoomWaveUpdate];
#else
    _DJSystemFunction_->stopZoomWaveUpdate();
#endif
}

#pragma mark - Update Zoom Wave View
/**
 JOG画面波形表示変更通知
 */
- (void)updateJogZoomWaveView:(int)playerID isShow:(bool)isShow {
    //    DLog(@"playerID = %d isShow = %d", playerID, isShow);
    if (playerID == 0) {
        if (isShow) {
            [DJFunc getDJSystemFunction]->startZoomWaveUpdate();
            [UIView animateWithDuration:ANIMATION_SEC delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self->deck1LoudWaveViewLandscape.alpha = 1.0f;
#if RBXFWX_SUPPORT_SOUNDCLOUD || RBXFWX_SUPPORT_BEATPORT
                if (_deck1LoudWaveViewLandscape.hidden) {
                    _StreamingLoadPercentLabel1_.alpha = 0.0f;
                    _StreamingLoadProgressView1_.alpha = 0.0f;
                }
#endif // RBXFWX_SUPPORT_SOUNDCLOUD || RBXFWX_SUPPORT_BEATPORT
            } completion:^(BOOL finished) {
            }];
        } else {
            [DJFunc getDJSystemFunction]->stopZoomWaveUpdate();
            if (![DJFunc getDJSystemFunction]->isInLoop(0)) {
                [UIView animateWithDuration:ANIMATION_SEC delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self->deck1LoudWaveViewLandscape.alpha = 1.0f;
#if RBXFWX_SUPPORT_SOUNDCLOUD || RBXFWX_SUPPORT_BEATPORT
                    if (_deck1LoudWaveViewLandscape.hidden) {
                        _StreamingLoadPercentLabel1_.alpha = 1.0f;
                        _StreamingLoadProgressView1_.alpha = 1.0f;
                    }
#endif // RBXFWX_SUPPORT_SOUNDCLOUD || RBXFWX_SUPPORT_BEATPORT
                } completion:^(BOOL finished) {
                }];
            }
        }
    } else if (playerID == 1) {
        if (isShow) {
            [DJFunc getDJSystemFunction]->startZoomWaveUpdate();
            [UIView animateWithDuration:ANIMATION_SEC delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self->deck2LoudWaveViewLandscape.alpha = 1.0f;
#if RBXFWX_SUPPORT_SOUNDCLOUD || RBXFWX_SUPPORT_BEATPORT
                if (_deck2LoudWaveViewLandscape.hidden) {
                    _StreamingLoadPercentLabel2_.alpha = 0.0f;
                    _StreamingLoadProgressView2_.alpha = 0.0f;
                }
#endif // RBXFWX_SUPPORT_SOUNDCLOUD || RBXFWX_SUPPORT_BEATPORT
            } completion:^(BOOL finished) {
            }];
        } else {
            [DJFunc getDJSystemFunction]->stopZoomWaveUpdate();
            if (![DJFunc getDJSystemFunction]->isInLoop(1)) {
                [UIView animateWithDuration:ANIMATION_SEC delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self->deck2LoudWaveViewLandscape.alpha = 1.0f;
#if RBXFWX_SUPPORT_SOUNDCLOUD || RBXFWX_SUPPORT_BEATPORT
                    if (_deck2LoudWaveViewLandscape.hidden) {
                        _StreamingLoadPercentLabel2_.alpha = 1.0f;
                        _StreamingLoadProgressView2_.alpha = 1.0f;
                    }
#endif // RBXFWX_SUPPORT_SOUNDCLOUD || RBXFWX_SUPPORT_BEATPORT
                } completion:^(BOOL finished) {
                }];
            }
        }
    }
}

#pragma mark - Change Wave Style Header
- (void)setupCommonSettingView {
    // Action on Change Common Setting Button
    [_commonSettingBtn_ addTarget:self action:@selector(btnDisplaySettingDidPush:) forControlEvents:UIControlEventTouchDown];
    
    // Setup Change Wave Style Popup
    float center = static_cast<float>(self.view.bounds.size.width / PADSCREENHEIGHTRATIO);
    float xPopup = center - 134;
    float yPopup = static_cast<float>(_commonSettingBtn_.y + _commonSettingBtn_.height);
    
    _popupCommonSettingView_ = [[PopupDisplaySelectBtnView alloc] initWithFrame:CGRectMake(xPopup, yPopup, 270, 61)];
    _popupCommonSettingView_.delegate = self;
    [_popupCommonSettingView_ creatCommonSettingPopupView];
    _popupCommonSettingView_.backgroundColor = [UIColor clearColor];
    _popupCommonSettingView_.hidden = YES;
    [self.view insertSubview:_popupCommonSettingView_ aboveSubview:self.view];
}

- (void)btnDisplaySettingDidPush:(UIButton*)sender {
    if (sender.selected==YES) {
        [sender setSelected:NO];
        _popupCommonSettingView_.hidden = YES;
        _popupDisplaySelectView_.hidden = YES;
    } else {
        [sender setSelected:YES];
        _popupCommonSettingView_.hidden = NO;
    }
}

- (void)btnDisplaySelectDidPush:(UIButton*)sender {
    if (sender.selected==YES) {
        [sender setSelected:NO];
        _popupCommonSettingView_.hidden = YES;
        _popupDisplaySelectView_.hidden = YES;
    } else {
        [sender setSelected:YES];
        _popupCommonSettingView_.hidden = NO;
    }
}

- (void)setActionForJogBtn:(UIButton *)sender {
    _commonSettingBtn_.selected = NO;
    _popupCommonSettingView_.hidden = YES;
    [_popupCommonSettingView_.JogSetBtn_ setImage:[UIImage imageNamed:kImgJogBtnOn] forState:UIControlStateNormal];
    [_popupCommonSettingView_ selectButton];
    [self btnJogDidPush:sender];
    _popupDisplaySelectView_.hidden = YES;
}

- (void)setActionForHorizontalBtn:(UIButton *)sender {
    _commonSettingBtn_.selected = NO;
    _popupCommonSettingView_.hidden = YES;
    [_popupCommonSettingView_.JogSetBtn_ setImage:[UIImage imageNamed:kImgHorizontalBtnOn] forState:UIControlStateNormal];
    [_popupCommonSettingView_ selectButton];
    [self btnHorizontalWaveDidPush:sender];
    _popupDisplaySelectView_.hidden = YES;
}

- (void)setActionForVerticalBtn:(UIButton *)sender {
    _commonSettingBtn_.selected = NO;
    _popupCommonSettingView_.hidden = YES;
    //    [_popupCommonSettingView_.JogSetBtn_ setImage:[UIImage imageNamed:kImgVerticalBtnOn] forState:UIControlStateNormal];
    //    [_popupCommonSettingView_ selectButton];
    //    [self btnVerticalWaveDidPush:sender];
    _popupDisplaySelectView_.hidden = YES;
}

- (void)setActionForAutoMixBtn:(UIButton *)sender {
    // TODO
}

- (void)setActionForHintBtn:(UIButton *)sender {
    // TODO
}

- (void)setActionForSettingBtn:(UIButton *)sender {
    PreferenceMenuViewController* preference = [[PreferenceMenuViewController alloc] init];
    preference.title = kLSSettings;
    
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:preference];
    navi.popoverPresentationController.sourceView               = (UIButton*)sender;
    navi.modalPresentationStyle                                 = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
    
    //    navi.popoverPresentationController.backgroundColor          = RGB(185, 185, 185);
    //    navi.popoverPresentationController.delegate = self;
}

- (void)setActionForRecordBtn:(UIButton *)sender {
    // TODO
}

- (void)setActionForJogSetBtn:(UIButton *)sender {
    // Setup Change Wave Style Button
    UIButton *button = (UIButton*)sender;
    button.tag = JOG;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:kImgJogBtnOn] forState:UIControlStateNormal];
    
    // Action on Change Wave Style Button
    [button addTarget:self action:@selector(btnDisplaySelectDidPush:) forControlEvents:UIControlEventTouchDown];
    
    // Setup Change Wave Style Popup
    float center = static_cast<float>(self.view.bounds.size.width / PADSCREENHEIGHTRATIO);
    float xPopup = center - 81;
    float yPopup = static_cast<float>(_commonSettingBtn_.y + _commonSettingBtn_.height + 60);
    
    _popupDisplaySelectView_ = [[PopupDisplaySelectBtnView alloc] initWithFrame:CGRectMake(xPopup, yPopup, 162, 61)];
    _popupDisplaySelectView_.delegate = self;
    [_popupDisplaySelectView_ creatPopupChangeWaveView];
    _popupDisplaySelectView_.backgroundColor = [UIColor clearColor];
    _popupCommonSettingView_.hidden = NO;
    _popupDisplaySelectView_.hidden = NO;
    [self.view insertSubview:_popupDisplaySelectView_ aboveSubview:_popupCommonSettingView_];
    
    NSInteger mode = [[NSUserDefaults standardUserDefaults] integerForKey:kStandaloneDisplayMode];
    switch (mode) {
        case JOG:
            [self setStatusForJogBtn:sender];
            break;
        case HORIZONTALWAVE:
            [self setStatusForHorizontalBtn:sender];
            break;
        case VERTICALWAVE:
            [self setStatusForVerticalBtn:sender];
            break;
        default:
            [self setStatusForJogBtn:sender];
            break;
    }
}

- (void)setStatusForJogBtn:(UIButton *)sender {
    UIButton *button = sender;
    [button setImage:[UIImage imageNamed:kImgJogBtnOn] forState:UIControlStateNormal];
    [_popupDisplaySelectView_.JogBtn_ setImage:[UIImage imageNamed:kImgJogBtnOn] forState:UIControlStateNormal];
    [_popupDisplaySelectView_.HorizontalWaveBtn_ setImage:[UIImage imageNamed:kImgHorizontalBtnOff] forState:UIControlStateNormal];
    [_popupDisplaySelectView_.VerticalWaveBtn_ setImage:[UIImage imageNamed:kImgVerticalBtnOff] forState:UIControlStateNormal];
    [self hiddenSmartFaderMixerHorizontal];
}

- (void)setStatusForHorizontalBtn:(UIButton *)sender {
    UIButton *button = sender;
    [button setImage:[UIImage imageNamed:kImgHorizontalBtnOn] forState:UIControlStateNormal];
    [_popupDisplaySelectView_.HorizontalWaveBtn_ setImage:[UIImage imageNamed:kImgHorizontalBtnOn] forState:UIControlStateNormal];
    [_popupDisplaySelectView_.JogBtn_ setImage:[UIImage imageNamed:kImgJogBtnOff] forState:UIControlStateNormal];
    [_popupDisplaySelectView_.VerticalWaveBtn_ setImage:[UIImage imageNamed:kImgVerticalBtnOff] forState:UIControlStateNormal];
    [self hiddenSmartFaderMixerJog];
}

- (void)setStatusForVerticalBtn:(UIButton *)sender {
    UIButton *button = sender;
    [button setImage:[UIImage imageNamed:kImgVerticalBtnOn] forState:UIControlStateNormal];
    [_popupDisplaySelectView_.VerticalWaveBtn_ setImage:[UIImage imageNamed:kImgVerticalBtnOn] forState:UIControlStateNormal];
    [_popupDisplaySelectView_.HorizontalWaveBtn_ setImage:[UIImage imageNamed:kImgHorizontalBtnOff] forState:UIControlStateNormal];
    [_popupDisplaySelectView_.JogBtn_ setImage:[UIImage imageNamed:kImgJogBtnOff] forState:UIControlStateNormal];
}

#pragma mark DJSystemFunctionDelegate

- (void)updateCurrentCuePoint:(int)playerID
                      inPoint:(int)inTime
                     outPoint:(int)outTime
                        total:(int)totalTIme {
    if(playerID == 0) {
        int inTimeA = inTime;
        int posA = [self loudWavePositionPercents:inTimeA totalTime:[DJFunc getDJSystemFunction]->getTotalTime(PLAYER_A) player:PLAYER_A];
        if (0 <= posA && posA <= deck1LoudWaveViewLandscape.waveView.frame.size.width) {
            CGRect rectA = deck1LoudWaveViewLandscape.WaveLoudCueMarker_.frame;
            rectA.origin.x = posA - rectA.size.width / 2.0f - 1;
            rectA.origin.y = deck1LoudWaveViewLandscape.posUIView_.frame.size.height + 2;
            deck1LoudWaveViewLandscape.WaveLoudCueMarker_.frame = rectA;
            deck1LoudWaveViewLandscape.WaveLoudCueMarker_.hidden = NO;
        }
        
        // Set position for cue marker jog A
        CGFloat rotA = ((M_PI * 11) / 1000) * (inTimeA / 10);
        _baseJogView.JogRingMarker1_.transform = CGAffineTransformMakeRotation(rotA);
    }
    
    if(playerID == 1) {
        int inTimeB = inTime;
        int posB = [self loudWavePositionPercents:inTimeB totalTime:[DJFunc getDJSystemFunction]->getTotalTime(PLAYER_B) player:PLAYER_B];
        if (0 <= posB && posB <= deck2LoudWaveViewLandscape.waveView.frame.size.width) {
            CGRect rectB = deck2LoudWaveViewLandscape.WaveLoudCueMarker_.frame;
            rectB.origin.x = posB - rectB.size.width / 2.0f - 1;
            rectB.origin.y = deck2LoudWaveViewLandscape.posUIView_.frame.size.height + 2;
            deck2LoudWaveViewLandscape.WaveLoudCueMarker_.frame = rectB;
            deck2LoudWaveViewLandscape.WaveLoudCueMarker_.hidden = NO;
        }
        
        // Set position for cue marker jog B
        CGFloat rotB = ((M_PI * 11) / 1000) * (inTimeB / 10);
        _baseJogView.JogRingMarker2_.transform = CGAffineTransformMakeRotation(rotB);
    }
}

- (void)updateDeckButtonState:(int)playerID DbtnID:(int)deckButtonID State:(int)state {
    if (deckButtonID == DjSysFunc::DBTID_MASTER) {
        if (playerID == PLAYER_A) {
            [_masterLeftButton setTitleColor: state == 1 ? kColor_BpmButton : kColor_MixerButtonTitleOff forState:UIControlStateNormal];
        } else if (playerID == PLAYER_B) {
            [_masterRightButton setTitleColor: state == 1 ? kColor_BpmButton : kColor_MixerButtonTitleOff forState:UIControlStateNormal];
        }
    }
}

// set up popup loop
- (void)btnClickedAuto:(UIButton*)sender {
    if (sender.tag == PLAYER_A) {
        [[NSNotificationCenter defaultCenter] postNotificationName:DidTapAutoLoopLeftButton object:nil userInfo:nil];
        dropListLeftView.hidden = YES;
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:DidTapAutoLoopRightButton object:nil userInfo:nil];
        dropListRightView.hidden = YES;
    }
}

- (void)btnClickedManual:(UIButton*)sender {
    if (sender.tag == PLAYER_A) {
        [[NSNotificationCenter defaultCenter] postNotificationName:DidTapManualLoopLeftButton object:nil userInfo:nil];
        dropListLeftView.hidden = YES;
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:DidTapManualLoopRightButton object:nil userInfo:nil];
        dropListRightView.hidden = YES;
    }
}

- (void)btnClickedChangeLoopL {
    [dropListLeftView removeFromSuperview];
    dropListLeftView = [UIView new];
    [self.view addSubview:dropListLeftView];
    dropListLeftView.userInteractionEnabled = YES;
    dropListLeftView.layer.borderWidth = OneValue;
    dropListLeftView.layer.borderColor = UIColor.whiteColor.CGColor;
    
    dropListLeftView.translatesAutoresizingMaskIntoConstraints = NO;
    [dropListLeftView.bottomAnchor constraintEqualToAnchor:performancePadLeftView.loopTopView.topAnchor constant:ZeroValue].active = YES;
    [dropListLeftView.trailingAnchor constraintEqualToAnchor:performancePadLeftView.loopTopView.trailingAnchor constant:ZeroValue].active = YES;
    [dropListLeftView.leadingAnchor constraintEqualToAnchor:performancePadLeftView.loopTopView.leadingAnchor constant:ZeroValue].active = YES;
    
    manualButton = [UIButton new];
    autoButton = [UIButton new];
    
    [dropListLeftView addSubview:autoButton];
    autoButton.userInteractionEnabled = YES;
    autoButton.translatesAutoresizingMaskIntoConstraints = NO;
    [autoButton.bottomAnchor constraintEqualToAnchor:dropListLeftView.bottomAnchor constant:ZeroValue].active = YES;
    [autoButton.trailingAnchor constraintEqualToAnchor:dropListLeftView.trailingAnchor constant:ZeroValue].active = YES;
    [autoButton.leadingAnchor constraintEqualToAnchor:dropListLeftView.leadingAnchor constant:ZeroValue].active = YES;
    [autoButton.heightAnchor constraintEqualToConstant:25].active = YES;
    autoButton.backgroundColor = UIColor.blackColor;
    [autoButton setTitle: KAutoLoopButton forState:UIControlStateNormal];
    [autoButton setTintColor: UIColor.whiteColor];
    [autoButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [autoButton addTarget:self action:@selector(btnClickedAuto:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [UIView new];
    [dropListLeftView addSubview: lineView];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    [lineView.bottomAnchor constraintEqualToAnchor:autoButton.topAnchor constant:ZeroValue].active = YES;
    [lineView.trailingAnchor constraintEqualToAnchor:dropListLeftView.trailingAnchor constant:ZeroValue].active = YES;
    [lineView.leadingAnchor constraintEqualToAnchor:dropListLeftView.leadingAnchor constant:ZeroValue].active = YES;
    [lineView.heightAnchor constraintEqualToConstant:OneValue].active = YES;
    lineView.backgroundColor = kColor_GroupTabBackgroundOff;
    
    [dropListLeftView addSubview:manualButton];
    manualButton.userInteractionEnabled = YES;
    manualButton.translatesAutoresizingMaskIntoConstraints = NO;
    [manualButton.bottomAnchor constraintEqualToAnchor:lineView.topAnchor constant:ZeroValue].active = YES;
    [manualButton.leadingAnchor constraintEqualToAnchor:dropListLeftView.leadingAnchor constant:ZeroValue].active = YES;
    [manualButton.trailingAnchor constraintEqualToAnchor:dropListLeftView.trailingAnchor constant:ZeroValue].active = YES;
    [manualButton.topAnchor constraintEqualToAnchor:dropListLeftView.topAnchor constant:ZeroValue].active = YES;
    [manualButton.heightAnchor constraintEqualToConstant: 25].active = YES;
    manualButton.backgroundColor = UIColor.blackColor;
    [manualButton setTitle: KManualLoopButton forState:UIControlStateNormal];
    [manualButton setTintColor: UIColor.whiteColor];
    [manualButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [manualButton addTarget:self action:@selector(btnClickedManual:) forControlEvents:UIControlEventTouchUpInside];
    
    manualButton.tag = PLAYER_A;
    autoButton.tag = PLAYER_A;
}

- (void)btnClickedChangeLoopR {
    [dropListRightView removeFromSuperview];
    dropListRightView = [UIView new];
    [self.view addSubview:dropListRightView];
    dropListRightView.userInteractionEnabled = YES;
    dropListRightView.layer.borderWidth = OneValue;
    dropListRightView.layer.borderColor = UIColor.whiteColor.CGColor;
    
    dropListRightView.translatesAutoresizingMaskIntoConstraints = NO;
    [dropListRightView.bottomAnchor constraintEqualToAnchor:performancePadRightView.loopTopView.topAnchor constant:ZeroValue].active = YES;
    [dropListRightView.trailingAnchor constraintEqualToAnchor:performancePadRightView.loopTopView.trailingAnchor constant:ZeroValue].active = YES;
    [dropListRightView.leadingAnchor constraintEqualToAnchor:performancePadRightView.loopTopView.leadingAnchor constant:ZeroValue].active = YES;
    
    manualButton = [UIButton new];
    autoButton = [UIButton new];
    
    [dropListRightView addSubview:autoButton];
    autoButton.userInteractionEnabled = YES;
    autoButton.translatesAutoresizingMaskIntoConstraints = NO;
    [autoButton.bottomAnchor constraintEqualToAnchor:dropListRightView.bottomAnchor constant:ZeroValue].active = YES;
    [autoButton.trailingAnchor constraintEqualToAnchor:dropListRightView.trailingAnchor constant:ZeroValue].active = YES;
    [autoButton.leadingAnchor constraintEqualToAnchor:dropListRightView.leadingAnchor constant:ZeroValue].active = YES;
    [autoButton.heightAnchor constraintEqualToConstant:25].active = YES;
    autoButton.backgroundColor = UIColor.blackColor;
    [autoButton setTitle: KAutoLoopButton forState:UIControlStateNormal];
    [autoButton setTintColor: UIColor.whiteColor];
    [autoButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [autoButton addTarget:self action:@selector(btnClickedAuto:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [UIView new];
    [dropListRightView addSubview: lineView];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    [lineView.bottomAnchor constraintEqualToAnchor:autoButton.topAnchor constant:ZeroValue].active = YES;
    [lineView.trailingAnchor constraintEqualToAnchor:dropListRightView.trailingAnchor constant:ZeroValue].active = YES;
    [lineView.leadingAnchor constraintEqualToAnchor:dropListRightView.leadingAnchor constant:ZeroValue].active = YES;
    [lineView.heightAnchor constraintEqualToConstant:OneValue].active = YES;
    lineView.backgroundColor = kColor_GroupTabBackgroundOff;
    
    [dropListRightView addSubview:manualButton];
    manualButton.userInteractionEnabled = YES;
    manualButton.translatesAutoresizingMaskIntoConstraints = NO;
    [manualButton.bottomAnchor constraintEqualToAnchor:lineView.topAnchor constant:ZeroValue].active = YES;
    [manualButton.leadingAnchor constraintEqualToAnchor:dropListRightView.leadingAnchor constant:ZeroValue].active = YES;
    [manualButton.trailingAnchor constraintEqualToAnchor:dropListRightView.trailingAnchor constant:ZeroValue].active = YES;
    [manualButton.topAnchor constraintEqualToAnchor:dropListRightView.topAnchor constant:ZeroValue].active = YES;
    [manualButton.heightAnchor constraintEqualToConstant: 25].active = YES;
    manualButton.backgroundColor = UIColor.blackColor;
    [manualButton setTitle: KManualLoopButton forState:UIControlStateNormal];
    [manualButton setTintColor: UIColor.whiteColor];
    [manualButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [manualButton addTarget:self action:@selector(btnClickedManual:) forControlEvents:UIControlEventTouchUpInside];
    
    manualButton.tag = PLAYER_B;
    autoButton.tag = PLAYER_B;
}
#pragma mark - Pad Performance Left View Delegate

- (void)hiddenLoopPopupL {
    dropListLeftView.hidden = YES;
}
#pragma mark - Pad Performance Right View Delegate

- (void)hiddenLoopPopupR {
    dropListRightView.hidden = YES;
}

#pragma mark - Sampler View Delegate

- (void)hiddenSamplerView {
    samplerView.hidden          = YES;
    selectSamplerView.hidden    = YES;
    samplerTableView.hidden     = YES;
    [samplerView closeSamplerView];
    [self didTapEditSamplerButton:YES];
}

- (void)didTapSaveSampler:(NSString*)titleName {
    if(samplerTableView.selectCellPack < 4) {
        [self showPopupSaveSampler];
    }else {
        [self showPopupOverrideSampler:titleName];
    }
}

- (void)showPopupOverrideSampler:(NSString*)titleName {
    if([[NSUserDefaults standardUserDefaults] boolForKey:SaveNewSamplerPack]) {
        NSString* title = [kLSConfirmOverrideOrSaveNewSamplerPack stringByReplacingOccurrencesOfString:@"xxx" withString:[NSString stringWithFormat:@"%@", titleName]];
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:title
                                     preferredStyle:UIAlertControllerStyleAlert];
        //Add Buttons
        UIAlertAction* cancelButton = [UIAlertAction
                                       actionWithTitle:kCANCEL
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
            //Handle no button
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SaveNewSamplerPack];
        }];
        
        UIAlertAction* saveButton = [UIAlertAction
                                     actionWithTitle:kLSSaveAs
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction *action) {
            //Handle your yes please button action here
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SaveNewSamplerPack];
            [self createSampler];
        }];
        
        UIAlertAction* overrideButton = [UIAlertAction
                                         actionWithTitle:kLSSaveOverride
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action) {
            //Handle your yes please button action here
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SaveNewSamplerPack];
            [self overrideSampler];
        }];
        
        //Add your buttons to alert controller
        [alert addAction:overrideButton];
        [alert addAction:saveButton];
        [alert addAction:cancelButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)changeSampler:(NSString*)name deck:(NSInteger)deck number:(NSInteger)num {
    [self samplerLoad:name deck:deck num:num];
}

- (void)updateButtonState:(int)playerID DbtnID:(int)deckButtonID State:(int)state {
    [samplerView setupColorSampler: deckButtonID state:state player:playerID];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSamplerSetupLButtonsNotification object:self userInfo:@{
        @"deckID": @(deckButtonID),
        @"state":@(state),
        @"player":@(playerID)
    }];
}

- (void)didTapSamplerSlider:(UISlider*)sender {
    self.DJSystemFunction_->setSamplerVolumePos(sender.value);
}

- (void) didTapEditSamplerButton:(BOOL)priority {
    heightSamplerView.priority = priority ? PrioritySamplerHight : PrioritySamplerLow;
    heightSamplerEditView.priority = priority ? PrioritySamplerLow : PrioritySamplerHight;
    if (priority) {
        samplerTableView.hidden = YES;
    }
    [self showPopupSaveSampler];
}

- (void)renameSampler:(NSString*) title {
    
    NSUInteger index_ = [samplerTableView.listNameSampler indexOfObject:title];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil
                                                                message:kLSSamplerPackName
                                                         preferredStyle:UIAlertControllerStyleAlert];
    [ac addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = kLSSamplerPackName;
        textField.text = [NSString stringWithFormat:@"%@", title];
    }];
    UIAlertAction *alertActionSave = [UIAlertAction actionWithTitle:kOK
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
        NSString *tempName = ac.textFields[ZeroValue].text;
        if(!(tempName.length == ZeroValue)) {
            NSDictionary* userInfo = @{NameValue: tempName, IndexObject: [NSNumber numberWithInt:(int)index_]};
            [[NSNotificationCenter defaultCenter] postNotificationName:RenameSampler object:nil userInfo:userInfo];
        }
    }];
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:kCANCEL
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
    }];
    [ac addAction:cancelButton];
    [ac addAction:alertActionSave];
    [self presentViewController:ac animated:YES completion:nil];
}

- (void) showPopupSaveSampler {
    if([[NSUserDefaults standardUserDefaults] boolForKey:SaveNewSamplerPack]) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:kLSConfirmSaveNewSamplerPack
                                     preferredStyle:UIAlertControllerStyleAlert];
        //Add Buttons
        UIAlertAction* cancelButton = [UIAlertAction
                                       actionWithTitle:kCANCEL
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
            //Handle no button
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SaveNewSamplerPack];
        }];
        
        UIAlertAction* saveButton = [UIAlertAction
                                     actionWithTitle:kLSSave
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action) {
            //Handle your yes please button action here
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SaveNewSamplerPack];
            [self createSampler];
        }];
        
        //Add your buttons to alert controller
        [alert addAction:cancelButton];
        [alert addAction:saveButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)overrideSampler{
    
    NSString* existedName = samplerTableView.listNameSampler[samplerTableView.selectCellPack];
    NSString* title = [NSString stringWithFormat:@"%@%@", existedName, kLSSavedOverride];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil
                                                                message:title
                                                         preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertActionSave = [UIAlertAction actionWithTitle:kOK
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
        NSString *tempName = existedName;
        if(!(tempName.length == ZeroValue)) {
            NSDictionary* userInfo = @{NameValue: tempName};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"OverrideSampler" object:nil userInfo:userInfo];
        }
    }];
    
    [ac addAction:alertActionSave];
    [self presentViewController:ac animated:YES completion:nil];
    
}

- (void)createSampler {
    
    NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    outputFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSString* dateString = [outputFormatter stringFromDate:[NSDate date]];
    NSString* text = [NSString stringWithFormat:@"%@%@", kSamplerPackPresetCaution, dateString];
    NSString* title = [kLSSavedSamplerPack stringByReplacingOccurrencesOfString:@"xxx" withString:[NSString stringWithFormat:@"%@", text]];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil
                                                                message:title
                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertActionSave = [UIAlertAction actionWithTitle:kOK
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
        NSString *tempName = text;
        if(!(tempName.length == ZeroValue)) {
            NSDictionary* userInfo = @{NameValue: tempName};
            [[NSNotificationCenter defaultCenter] postNotificationName:SaveSampler object:nil userInfo:userInfo];
        }
    }];
    [ac addAction:alertActionSave];
    [self presentViewController:ac animated:YES completion:nil];
}

- (void)openTableViewInSampler:(BOOL)selected {
    samplerTableView.hidden = selected;
    samplerView.iconUpDownImageView.image = selected ? [UIImage imageNamed:kImgIconArrowDown] : [UIImage imageNamed:kImgIconArrowUp];
}

- (void)openSelectSamplePopup:(UIButton*)sender namePack: (UILabel*)name {
    samplerTableView.hidden = YES;
    selectSamplerView.hidden = NO;
    samplerView.iconUpDownImageView.image = [UIImage imageNamed:kImgIconArrowDown];
    [selectSamplerView reloadSelectCellDetail:name];
    selectSamplerView.nameCell = name;
    [selectSamplerView scrollToCell];
    [selectSamplerView.samplerPackTableView reloadData];
    [selectSamplerView.detailTableView reloadData];
}
///Sampler function
- (void)didTapButtonTag0Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Clapsnare);
}

- (void)didTapButtonTag1Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)ShortClapsnare);
}

- (void)didTapButtonTag2Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)DropFX);
}

- (void)didTapButtonTag3Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Horn);
}

- (void)didTapButtonTag4Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Kick);
}

- (void)didTapButtonTag5Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Hat);
}

- (void)didTapButtonTag6Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Razer);
}

- (void)didTapButtonTag7Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Siren);
}

- (void)didTapButtonTag8Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Clapsnare);
}

- (void)didTapButtonTag9Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)ShortClapsnare);
}

- (void)didTapButtonTag10Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)DropFX);
}

- (void)didTapButtonTag11Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Horn);
}

- (void)didTapButtonTag12Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Kick);
}

- (void)didTapButtonTag13Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Hat);
}

- (void)didTapButtonTag14Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Razer);
}

- (void)didTapButtonTag15Sampler {
    self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Siren);
}

///Sampler View Controller Left and Right Function
- (void)didTapButtonSamplerObj:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    [self didTapButtonSampler:[info[@"tag"] intValue] :[info[@"playerID"] intValue]];
}

- (void)didTapButtonSampler:(NSInteger)tag :(NSInteger)playerID {
    DJSystemFunction_->samplerButtonDown((int)playerID, (int)tag);
    switch (tag) {
        case samplerButtonTag0:
            [self checkPlayerA:playerID] ? self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Clapsnare) : self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Clapsnare);
            break;
        case samplerButtonTag1:
            [self checkPlayerA:playerID] ? self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)ShortClapsnare) : self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)ShortClapsnare);
            break;
        case samplerButtonTag2:
            [self checkPlayerA:playerID] ? self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)DropFX) : self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)DropFX);
            break;
        case samplerButtonTag3:
            [self checkPlayerA:playerID] ? self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Horn) : self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Horn);
            break;
        case samplerButtonTag4:
            [self checkPlayerA:playerID] ? self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Kick) : self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Kick);
            break;
        case samplerButtonTag5:
            [self checkPlayerA:playerID] ? self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Hat) : self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Hat);
            break;
        case samplerButtonTag6:
            [self checkPlayerA:playerID] ? self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Razer) : self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Razer);
            break;
        case samplerButtonTag7:
            [self checkPlayerA:playerID] ? self.DJSystemFunction_->samplerButtonDown((int)PLAYER_A, (int)Siren) : self.DJSystemFunction_->samplerButtonDown((int)PLAYER_B, (int)Siren);
            break;
        default:
            break;
    }
}

- (BOOL)checkPlayerA:(NSInteger)playerID {
    return playerID == samplerPlayerA;
}

#pragma mark - Sampler Table View Delegate

- (void)didTapTableViewCell:(NSString*)titleCell index:(NSInteger)index{
    samplerView.titleLabel.text = titleCell;
    switch (index) {
        case EssentialPack:
            samplerView.style = EssentialPack;
            [self setupSampler:index keyString:Empty];
            break;
        case S909Pack:
            samplerView.style = S909Pack;
            [self setupSampler:index keyString:Empty];
            break;
        case FXPack:
            samplerView.style = FXPack;
            [self setupSampler:index keyString:Empty];
            break;
        case VoicePack:
            samplerView.style = VoicePack;
            [self setupSampler:index keyString:Empty];
            break;
        default:
            samplerView.style = Default;
            samplerView.nameCurrentSampler = titleCell;
            [self setupSampler:index keyString:titleCell];
            break;
    }
    [samplerView updateNameSampler];
    samplerTableView.hidden = YES;
    samplerView.styleSamplerButton.selected = NO;
    samplerView.iconUpDownImageView.image = [UIImage imageNamed:kImgIconArrowDown];
}

- (void)didTapDeleteCellSampler:(UIButton*)sender title:(NSString*)title {
    //    NSString* message;
    //    message = [kLSConfirmDeleteSamplerPack stringByReplacingOccurrencesOfString:@"xxx" withString:[NSString stringWithFormat:@"%@", title]];
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle: nil
                                 message: nil
                                 preferredStyle:UIAlertControllerStyleAlert];
    //Add Buttons
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:kCANCEL
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
        //Handle no button
    }];
    
    UIAlertAction* renameButton = [UIAlertAction
                                   actionWithTitle:kchangeTitleName
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
        [self renameSampler:title];
    }];
    
    UIAlertAction* deleteButton = [UIAlertAction
                                   actionWithTitle:deleteTitleName
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
        //Handle your yes please button action here
        [self deleteSampler: sender title:title];
    }];
    
    //Add your buttons to alert controller
    
    [alert addAction:renameButton];
    [alert addAction:deleteButton];
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)deleteSampler:(UIButton*)sender title:(NSString*)title {
    NSString* message;
    message = [kLSConfirmDeleteSamplerPack stringByReplacingOccurrencesOfString:@"xxx" withString:[NSString stringWithFormat:@"%@", title]];
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    //Add Buttons
    UIAlertAction* cancelButton = [UIAlertAction
                                   actionWithTitle:kCANCEL
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
    }];
    
    UIAlertAction* saveButton = [UIAlertAction
                                 actionWithTitle:kDELETE
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action) {
        //Handle your yes please button action here
        [self->samplerTableView.listNameSampler removeObjectAtIndex: sender.tag];
        [[NSUserDefaults standardUserDefaults] setObject:self->samplerTableView.listNameSampler forKey:SaveListNameSampler];
        [self->samplerTableView.samplerTableView reloadData];
        [self didTapTableViewCell:kSamplerPackNameESSENTIALSPACK index:0];
    }];
    
    //Add your buttons to alert controller
    [alert addAction:cancelButton];
    [alert addAction:saveButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setupSampler: (NSInteger)index keyString:(NSString*)keyString{
    NSArray* ar;
    switch (index) {
        case EssentialPack:
            ar = @[kSamplerESSENTIALSPACK_Clapsnare,
                   kSamplerESSENTIALSPACK_Short_Clapsnare,
                   kSamplerESSENTIALSPACK_Drop_FX,
                   kSamplerESSENTIALSPACK_Horn,
                   kSamplerESSENTIALSPACK_Kick,
                   kSamplerESSENTIALSPACK_Hat,
                   kSamplerESSENTIALSPACK_Razer,
                   kSamplerESSENTIALSPACK_Siren];
            for(int j=0; j<2; j++) {
                for (NSInteger i = 0; i < 8; i++) {
                    [self samplerLoad:ar[i] deck:j num:i];
                }
            }
            break;
        case S909Pack:
            ar = @[kSampler909PACK_909_Snare,
                   kSampler909PACK_909_Clap,
                   kSampler909PACK_909_Rim,
                   kSampler909PACK_909_Mid_Tom,
                   kSampler909PACK_909_Kick_Mattack,
                   kSampler909PACK_909_Closed_Hat,
                   kSampler909PACK_909_Cymbals,
                   kSampler909PACK_909_Ride_Mid];
            for(int j=0; j<2; j++) {
                for (NSInteger i = 0; i < 8; i++) {
                    [self samplerLoad:ar[i] deck:j num:i];
                }
            }
            break;
        case FXPack:
            ar = @[kSamplerFXPACK_Guitar_Delay_Shot,
                   kSamplerFXPACK_Zap_Stutter,
                   kSamplerFXPACK_Rise_Up_FX,
                   kSamplerFXPACK_Zapp,
                   kSamplerFXPACK_Laser,
                   kSamplerFXPACK_Dub_Siren,
                   kSamplerFXPACK_Riser_FX,
                   kSamplerFXPACK_Noise];
            for(int j=0; j<2; j++) {
                for (NSInteger i = 0; i < 8; i++) {
                    [self samplerLoad:ar[i] deck:j num:i];
                }
            }
            break;
        case VoicePack:
            ar = @[kSamplerVOICEPACK_What,
                   kSamplerVOICEPACK_Awh,
                   kSamplerVOICEPACK_Yeah,
                   kSamplerVOICEPACK_Drop,
                   kSamplerVOICEPACK_Gangster_Music,
                   kSamplerVOICEPACK_Holla,
                   kSamplerVOICEPACK_Yall_Ready,
                   kSamplerVOICEPACK_Listen];
            for(int j=0; j<2; j++) {
                for (NSInteger i = 0; i < 8; i++) {
                    [self samplerLoad:ar[i] deck:j num:i];
                }
            }
            break;
        default:
            ar = [[NSUserDefaults standardUserDefaults] objectForKey:keyString];
            int deck = 0;
            NSInteger num = 0;
            for (NSInteger i = 0; i < ar.count; i++) {
                num = i;
                if (i >= ar.count / 2) {
                    deck = 1;
                    num = i - (ar.count / 2);
                }
                [self samplerLoad:ar[i] deck:deck num:num];
            }
            break;
    }
}

- (void)samplerLoad:(NSString*)sampler deck:(NSInteger)deck num:(NSInteger)n {
    NSString* strFilePath = [SamplerPackDef getSamplerFilePathInPack:sampler];
    const char *filepath = [strFilePath UTF8String];
    self.DJSystemFunction_->loadSamplerFile((int)deck, (int)n, filepath);
}

#pragma mark - Select Sampler Table View Delegate

- (void)didTapClosePopup {
    selectSamplerView.hidden = YES;
}

#pragma mark - BeatFx View Delegate

- (void)didTapLeftBeatFxCombobox {
    [beatFxLeftCombobox reloadData];
    if (beatFxLeftCombobox.hidden) {
        [beatFxLeftCombobox hidden:NO];
    } else {
        [beatFxLeftCombobox hidden:YES];
    }
    [typeFxLeftCombobox hidden:YES];
}

- (void)didTapLeftStyleFxCombobox {
    [typeFxLeftCombobox reloadData];
    if (typeFxLeftCombobox.hidden) {
        [typeFxLeftCombobox hidden:NO];
    } else {
        [typeFxLeftCombobox hidden:YES];
    }
    [beatFxLeftCombobox hidden:YES];
}

- (void)didTapRightBeatFxCombobox {
    [beatFxRightCombobox reloadData];
    if (beatFxRightCombobox.hidden) {
        [beatFxRightCombobox hidden:NO];
    } else {
        [beatFxRightCombobox hidden:YES];
    }
    [typeFxRightCombobox hidden:YES];
}

- (void)didTapRightStyleFxCombobox {
    [typeFxRightCombobox reloadData];
    if (typeFxRightCombobox.hidden) {
        [typeFxRightCombobox hidden:NO];
    } else {
        [typeFxRightCombobox hidden:YES];
    }
    [beatFxRightCombobox hidden:YES];
}

- (void)didTapCFxCombobox {
    [colorFxCombobox reloadData];
    if (colorFxCombobox.hidden) {
        [colorFxCombobox hidden:NO];
    } else {
        [colorFxCombobox hidden:YES];
    }
}

#pragma mark - Edit hot cue

- (void)openHotCueEditPanelWithHotCue:(int)hotCueID deck:(int)deckID frame:(CGRect)frame comment:(NSString *)comment {
    if (deckID == 1) {
        _leftOpenedHotCueButtonFrame = frame;
        _openedLeftHotCueEditViewHotCueID = hotCueID;
        _leftEditHotCueViewController = [[HotCueEditViewController alloc] initWithNibName:@"HotCueEditView" bundle:nil];
        _leftEditHotCueViewController.commentField.text = comment;
    } else {
        _rightOpenedHotCueButtonFrame = frame;
        _openedRightHotCueEditViewHotCueID = hotCueID;
        _rightEditHotCueViewController = [[HotCueEditViewController alloc] initWithNibName:@"HotCueEditView" bundle:nil];
        _rightEditHotCueViewController.commentField.text = comment;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:kHotCueButtonsUpdatedNotification object:self userInfo:@{@"deckID": @1}];
    [[NSNotificationCenter defaultCenter] postNotificationName:kHotCueButtonsUpdatedNotification object:self userInfo:@{@"deckID": @2}];

    if (deckID == 1) {
        [_leftEditHotCueViewController preloadWithHotCueID:hotCueID deckID:deckID];
        [self addChildViewController:_leftEditHotCueViewController];
        [self.view addSubview:_leftEditHotCueViewController.view];
        [_leftEditHotCueViewController didMoveToParentViewController:self];
    } else {
        [_rightEditHotCueViewController preloadWithHotCueID:hotCueID deckID:deckID];
        [self addChildViewController:_rightEditHotCueViewController];
        [self.view addSubview:_rightEditHotCueViewController.view];
        [_rightEditHotCueViewController didMoveToParentViewController:self];
    }
    
    djplay::DJCueData cueData = [DJFunc getDJSystemFunction]->getHotCueItem((deckID - 1), (uint32)hotCueID);
    if (deckID == 1) {
        [_leftEditHotCueViewController setHotCueData:[PlayViewCtrl getAudioContentID:(deckID - 1)] cueData:cueData index:hotCueID playerID:deckID];
    } else {
        [_rightEditHotCueViewController setHotCueData:[PlayViewCtrl getAudioContentID:(deckID - 1)] cueData:cueData index:hotCueID playerID:deckID];
    }
}

- (void)resizeHotCueEditPanel:(int)deckID newSize:(CGSize)newSize {
    if (deckID == 1) {
        if (_leftEditHotCueViewController != nil) {
            CGRect frame = _leftOpenedHotCueButtonFrame;
            _leftEditHotCueViewController.view.frame = CGRectMake(frame.origin.x, frame.origin.y - newSize.height, newSize.width, newSize.height);
        }
    } else {
        if (_rightEditHotCueViewController != nil) {
            CGRect frame = _rightOpenedHotCueButtonFrame;
            _rightEditHotCueViewController.view.frame = CGRectMake(frame.origin.x - newSize.width + frame.size.width, frame.origin.y - newSize.height, newSize.width, newSize.height);
        }
    }
}

- (void)closeHotCueEditPanel:(int)deckID {
    if (deckID == 1) {
        if (_leftEditHotCueViewController != nil) {
            [_leftEditHotCueViewController.view removeFromSuperview];
            [_leftEditHotCueViewController removeFromParentViewController];
            _leftEditHotCueViewController = nil;
        }
        self.openedLeftHotCueEditViewHotCueID = -1;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHotCueButtonsUpdatedNotification object:self userInfo:@{@"deckID": @1}];
    } else if (deckID == 2) {
        if (_rightEditHotCueViewController != nil) {
            [_rightEditHotCueViewController.view removeFromSuperview];
            [_rightEditHotCueViewController removeFromParentViewController];
            _rightEditHotCueViewController = nil;
        }
        self.openedRightHotCueEditViewHotCueID = -1;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHotCueButtonsUpdatedNotification object:self userInfo:@{@"deckID": @2}];
    }
}

- (void)updatePadButtonPressed:(int)playerID padEventID:(int)padEventID index:(int)index {
    switch (padEventID) {
        case DjSysFunc::PadEventID::ON_PADFX:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDevicePadFx1PressedNotification object:self userInfo:@{
                @"deckID": @(playerID),
                @"index": @(index)
            }];
            break;
        case DjSysFunc::PadEventID::OFF_PADFX:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDevicePadFx1ReleasedNotification object:self userInfo:@{
                @"deckID": @(playerID),
                @"index": @(index)
            }];
            break;
        case DjSysFunc::PadEventID::ON_PAD_FX_2:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDevicePadFx2PressedNotification object:self userInfo:@{
                @"deckID": @(playerID),
                @"index": @(index)
            }];
            break;
        case DjSysFunc::PadEventID::OFF_PAD_FX_2:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDevicePadFx2ReleasedNotification object:self userInfo:@{
                @"deckID": @(playerID),
                @"index": @(index)
            }];
            break;
        case DjSysFunc::PadEventID::ON_BEAT_JUMP:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDeviceBeatJumpPressedNotification object:self userInfo:@{
                @"deckID": @(playerID),
                @"index": @(index)
            }];
            break;
        case DjSysFunc::PadEventID::OFF_BEAT_JUMP:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDeviceBeatJumpReleasedNotification object:self userInfo:@{
                @"deckID": @(playerID),
                @"index": @(index)
            }];
            break;
        case DjSysFunc::PadEventID::ON_BEATLOOP:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDeviceBeatLoopPressedNotification object:self userInfo:@{
                @"deckID": @(playerID),
                @"index": @(index)
            }];
            break;
        case DjSysFunc::PadEventID::OFF_BEATLOOP:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDeviceBeatLoopReleasedNotification object:self userInfo:@{
                @"deckID": @(playerID),
                @"index": @(index)
            }];
            break;
        case DjSysFunc::PadEventID::ON_KEY_SHIFT_PAD:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDeviceKeyShiftPressedNotification object:self userInfo:@{
                @"deckID": @(playerID),
                @"index": @(index)
            }];
            break;
        case DjSysFunc::PadEventID::OFF_KEY_SHIFT_PAD:
            [[NSNotificationCenter defaultCenter] postNotificationName:kDevicekeyShiftReleasedNotification object:self userInfo:@{
                @"deckID": @(playerID),
                @"index": @(index)
            }];
        default:
            break;
    }
}

#pragma mark - Device Connection

- (void)updateWithDeviceConnectionState {
    if ([PlayerStateRepository sharedInstance].hasConnectedToDevice) {
        ConnectDevice connectedDevice = [PlayerStateRepository sharedInstance].connectedDeviceType;
        if (connectedDevice == CONNECT_WannaBe) {
            [self updateUIWithDDJ200Connected];
        } else if (connectedDevice == CONNECT_EP134) {
            [self updateUIWithDDJEP134Connected];
        } else {
            [self updateUIWithOtherDeviceConnected];
        }
    } else {
        [self updateUIWithNoDeviceConnected];
    }
}

- (void)updateUIWithDDJ200Connected {

    [self disposeConnectedBeatFXComboBox];

    [_JogbCommonView1_.PerformanceBtn_
     removeTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPush:)
     forControlEvents:UIControlEventTouchDown];
    
    [_JogbCommonView1_.PerformanceBtn_
     addTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPushConnectedCtrl:)
     forControlEvents:UIControlEventTouchDown];
    
    [_JogbCommonView2_.PerformanceBtn_
     removeTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPush:)
     forControlEvents:UIControlEventTouchDown];
    
    [_JogbCommonView2_.PerformanceBtn_
     addTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPushConnectedCtrl:)
     forControlEvents:UIControlEventTouchDown];
    
    _JogbCommonView1_.CfxSettingView_.hidden = NO;
    _JogbCommonView2_.CfxSettingView_.hidden = NO;
    _JogbCommonView1_.CfxSettingBtn_.hidden = NO;
    _JogbCommonView2_.CfxSettingBtn_.hidden = NO;
    
    _btnSyncLeft.hidden = NO;
    _btnSyncRight.hidden = NO;
    _fxLeftButton.hidden = NO;
    _fxRightButton.hidden = NO;
    _padLeftButton.hidden = NO;
    _padRightButton.hidden = NO;
    _headphoneLeft.hidden = NO;
    _headphoneRight.hidden = NO;
    _sliderLButton.hidden = NO;
    _sliderRButton.hidden = NO;
    _levelMeter.hidden = NO;
    
    _disconnectedBottomButtons.hidden = YES;
    _connectedBottomButtons.view.hidden = YES;
    _memoryCueLeftView.view.hidden = YES;
    _memoryCueRightView.view.hidden = YES;
    _cfxView.hidden = YES;
    _beatFXView.hidden = YES;
    
    _JogWannaBecView_.hidden = NO;
    _safeBottomPaddingArea.backgroundColor = kColor_Black;
    _safeLeftPaddingArea.backgroundColor = kColor_Black;
    _safeRightPaddingArea.backgroundColor = kColor_Black;
    
    [self resizeObject];
    
    if (!_JogWannaBecView_.HotCueBtn1_.selected) {
        _JogWannaBecView_.HotCueBtn1_.selected = YES;
        _JogWannaBecView_.LoopBtn1_.selected = NO;
        _JogWannaBecView_.PadFxBtn1_.selected = NO;
        _JogWannaBecView_.SamplerBtn1_.selected = NO;
        
        _JogWannaBecView_.HotCueBtnArrow1_.hidden = NO;
        _JogWannaBecView_.LoopBtnArrow1_.hidden = YES;
        _JogWannaBecView_.PadFxBtnArrow1_.hidden = YES;
        _JogWannaBecView_.SamplerBtnArrow1_.hidden = YES;
        
        if (DJSystemFunction_) {
            DJSystemFunction_->setPadMode(0, WDJPadModeHotCue);
        }
        
        [[NSUserDefaults standardUserDefaults]
         setInteger:PERFORMANCE_HOT_CUE
         forKey:kPerformancePanele11];
    }
    
    if (!_JogWannaBecView_.HotCueBtn2_.selected) {
        _JogWannaBecView_.HotCueBtn2_.selected = YES;
        _JogWannaBecView_.LoopBtn2_.selected = NO;
        _JogWannaBecView_.PadFxBtn2_.selected = NO;
        _JogWannaBecView_.SamplerBtn2_.selected = NO;
        
        _JogWannaBecView_.HotCueBtnArrow2_.hidden = NO;
        _JogWannaBecView_.LoopBtnArrow2_.hidden = YES;
        _JogWannaBecView_.PadFxBtnArrow2_.hidden = YES;
        _JogWannaBecView_.SamplerBtnArrow2_.hidden = YES;
        
        if (DJSystemFunction_) {
            DJSystemFunction_->setPadMode(1, WDJPadModeHotCue);
        }
        
        [[NSUserDefaults standardUserDefaults]
         setInteger:PERFORMANCE_HOT_CUE
         forKey:kPerformancePanele21];
    }
    
    [_JogWannaBecView_ initSelectedPadBtnImage];
    
    [self closeHotCueEditPanel:1];
    [self closeHotCueEditPanel:2];
}

- (void)updateUIWithDDJEP134Connected {
    Array<DjSysFunc::MultiAudioChannelInfo> list;
    if (self.DJSystemFunction_) {
        self.DJSystemFunction_->getOutputChannelInfoList(list);
        self.DJSystemFunction_->setOutputRouting(list);
    }

    [self setupConnectedBeatFXComboBox];

    [_JogbCommonView1_.PerformanceBtn_
     removeTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPush:)
     forControlEvents:UIControlEventTouchDown];
    
    [_JogbCommonView1_.PerformanceBtn_
     addTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPushConnectedCtrl:)
     forControlEvents:UIControlEventTouchDown];
    
    [_JogbCommonView2_.PerformanceBtn_
     removeTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPush:)
     forControlEvents:UIControlEventTouchDown];
    
    [_JogbCommonView2_.PerformanceBtn_
     addTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPushConnectedCtrl:)
     forControlEvents:UIControlEventTouchDown];
    
    _JogbCommonView1_.CfxSettingView_.hidden = NO;
    _JogbCommonView2_.CfxSettingView_.hidden = NO;
    _JogbCommonView1_.CfxSettingBtn_.hidden = NO;
    _JogbCommonView2_.CfxSettingBtn_.hidden = NO;
    
    _btnSyncLeft.hidden = YES;
    _btnSyncRight.hidden = YES;
    _fxLeftButton.hidden = YES;
    _fxRightButton.hidden = YES;
    _padLeftButton.hidden = YES;
    _padRightButton.hidden = YES;
    _headphoneLeft.hidden = YES;
    _headphoneRight.hidden = YES;
    _sliderLButton.hidden = YES;
    _sliderRButton.hidden = YES;
    _levelMeter.hidden = YES;
    samplerView.hidden = YES;
    
    _disconnectedBottomButtons.hidden = YES;
    _connectedBottomButtons.view.hidden = NO;
    _memoryCueLeftView.view.hidden = NO;
    _memoryCueRightView.view.hidden = NO;
    _cfxView.hidden = NO;
    _beatFXView.hidden = NO;
    
    _JogWannaBecView_.hidden = YES;
    
    [self closeHotCueEditPanel:1];
    [self closeHotCueEditPanel:2];
    
    [self resizeObject];
}

- (void)updateUIWithOtherDeviceConnected {
    [self updateUIWithNoDeviceConnected];
}

- (void)updateUIWithNoDeviceConnected {
    [_JogbCommonView1_.PerformanceBtn_
     removeTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPushConnectedCtrl:)
     forControlEvents:UIControlEventTouchDown];
    
    [_JogbCommonView1_.PerformanceBtn_
     addTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPush:)
     forControlEvents:UIControlEventTouchDown];
    
    [_JogbCommonView2_.PerformanceBtn_
     removeTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPushConnectedCtrl:)
     forControlEvents:UIControlEventTouchDown];
    
    [_JogbCommonView2_.PerformanceBtn_
     addTarget:_DeckBtnPerfAndCtrl
     action:@selector(btnPerformanceDidPush:)
     forControlEvents:UIControlEventTouchDown];
    
    _btnSyncLeft.hidden = NO;
    _btnSyncRight.hidden = NO;
    _fxLeftButton.hidden = NO;
    _fxRightButton.hidden = NO;
    _padLeftButton.hidden = NO;
    _padRightButton.hidden = NO;
    _headphoneLeft.hidden = NO;
    _headphoneRight.hidden = NO;
    _sliderLButton.hidden = NO;
    _sliderRButton.hidden = NO;
    _levelMeter.hidden = NO;
    
    _disconnectedBottomButtons.hidden = NO;
    _connectedBottomButtons.view.hidden = YES;
    _memoryCueLeftView.view.hidden = YES;
    _memoryCueRightView.view.hidden = YES;
    _cfxView.hidden = YES;
    _beatFXView.hidden = YES;
    
    _JogWannaBecView_.hidden = YES;
    
    [self resizeObject];
    
    _JogbCommonView1_.CfxSettingView_.hidden = YES;
    _JogbCommonView2_.CfxSettingView_.hidden = YES;
    _JogbCommonView1_.CfxSettingBtn_.hidden = YES;
    _JogbCommonView2_.CfxSettingBtn_.hidden = YES;
    
    [self closeHotCueEditPanel:1];
    [self closeHotCueEditPanel:2];
}

#pragma mark - CFX View Delegate

- (void)didTapLeftCFXHorizontal {
    [cfxLeftHorizontalTableView reloadData];
    if (cfxLeftHorizontalTableView.hidden) {
        [cfxLeftHorizontalTableView hidden:NO];
    } else {
        [cfxLeftHorizontalTableView hidden:YES];
    }
}

- (void)didTapRightCFXHorizontal {
    [cfxRightHorizontalTableView reloadData];
    if (cfxRightHorizontalTableView.hidden) {
        [cfxRightHorizontalTableView hidden:NO];
    } else {
        [cfxRightHorizontalTableView hidden:YES];
    }
}

- (void)didTapLeftCFXJog {
    [cfxLeftJogTableView reloadData];
    if (cfxLeftJogTableView.hidden) {
        [cfxLeftJogTableView hidden:NO];
    } else {
        [cfxLeftJogTableView hidden:YES];
    }
}

- (void)didTapRightCFXJog {
    [cfxRightJogTableView reloadData];
    if (cfxRightJogTableView.hidden) {
        [cfxRightJogTableView hidden:NO];
    } else {
        [cfxRightJogTableView hidden:YES];
    }
}
#pragma LevelMeter
- (void)setupLevelMeter {
    [levelMeter1 addSubview:levelMeterView1_];
    levelMeterView1_.frame = CGRectMake(0, 0, levelMeter1.width, levelMeter1.height);
    [levelMeter2 addSubview:levelMeterView2_];
    levelMeterView2_.frame = CGRectMake(0, 0, levelMeter2.width, levelMeter2.height);
}

#ifndef CPUFUKA
- (void)levelMeterTimer:(NSTimer *)tm {
    [self updatePeaklevel:1];
    [self updatePeaklevel:2];
}
#endif // CPUFUKA

- (void)updatePeaklevel:(int)deck {
    float level_l;
    float level_r;
    float peaklevel_l;
    float peaklevel_r;
    [DJFunc getDJSystemFunction]->getCurrentLRChannelLevel(deck - 1, level_l, peaklevel_l, level_r, peaklevel_r);
    
    if (deck == 1) {
        levelMeterView1_.valueL_ = level_l;
        levelMeterView1_.valueR_ = level_r;
        [levelMeterView1_ updateLevelMeter];
        [levelMeterView1_ hideLevelMeter:PLAYER_A];
    } else {
        levelMeterView2_.valueL_ = level_l;
        levelMeterView2_.valueR_ = level_r;
        [levelMeterView2_ updateLevelMeter];
        [levelMeterView2_ hideLevelMeter:PLAYER_B];
    }
}

#pragma mark - SmartCFX Function Delegate

- (void)updateSmartCFXState:(BOOL)isOn {
    [_cfxView updateSmartCFXState:isOn];
    [colorFxCombobox setUserInteractionEnabled:!isOn];
    [colorFxCombobox setCurrentSelection:[NSIndexPath indexPathForRow:0 inSection: isOn ? 1 : 0]]; //Set default selection UI SmartCFX <-> CFX
}

- (void)setSmartCFXSelect:(int)index {
    bool currentSmartCFXStatus = [DJFunc getDJSystemFunction] -> getSmartCFXStatus();
    [colorFxCombobox setCurrentSelection:[NSIndexPath indexPathForRow:index inSection:currentSmartCFXStatus ? 1 : 0]];
    [colorFxCombobox hidden:NO];
    [_cfxView selectItem:colorFxCombobox withIndex:index];
    if (colorFxTimer.isValid) {
        [colorFxTimer invalidate];
    }
    colorFxTimer = nil;
    [self setupColorFxComboboxBlockTimer];
}

- (void)hideColorFxCombobox {
    [colorFxCombobox hidden:YES];
}

///Dealloc
- (void)dealloc {    
    // Notification of SamplerViewController
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSamplerTabButtonsNotification object:nil];
}

- (void)openBrowser:(NSNotification *)notification {
    [self hidePlayer];
}

- (void)loadReleatedTracks:(NSNotification *)notification {
    [self hidePlayer];
}

// iPhoneX系のホームインジケータの挙動を変更（クロスフェーダー動作時に誤作動しないようにする）
- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures
{
    return UIRectEdgeBottom;
}

@end
