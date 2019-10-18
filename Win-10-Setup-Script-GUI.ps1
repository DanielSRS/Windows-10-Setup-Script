Add-Type -AssemblyName "PresentationCore", "PresentationFramework", "WindowsBase"

[xml]$xamlMarkup = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"                        
        Name="Window"
        Title="Windows 10 Setup Script" Height="795" Width="940" MinHeight="795" MinWidth="940"
        Background="#FFFFFF"        
        FontFamily="Calibri" FontSize="18" TextOptions.TextFormattingMode="Display" WindowStartupLocation="CenterScreen"
        SnapsToDevicePixels="True" 
        ShowInTaskbar="True" Foreground="#000000">
    <Window.Resources>

        <!--#region Brushes -->

        <SolidColorBrush x:Key="RadioButton.Static.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.Static.Border" Color="#FF333333"/>
        <SolidColorBrush x:Key="RadioButton.Static.Glyph" Color="#FF333333"/>

        <SolidColorBrush x:Key="RadioButton.MouseOver.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.Border" Color="#FF000000"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.Glyph" Color="#FF000000"/>

        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Background" Color="#FF4C91C8"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Border" Color="#FF4C91C8"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Glyph" Color="#FFFFFFFF"/>

        <SolidColorBrush x:Key="RadioButton.Disabled.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.Border" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.Glyph" Color="#FF999999"/>

        <SolidColorBrush x:Key="RadioButton.Disabled.On.Background" Color="#FFCCCCCC"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.On.Border" Color="#FFCCCCCC"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.On.Glyph" Color="#FFA3A3A3"/>

        <SolidColorBrush x:Key="RadioButton.Pressed.Background" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Pressed.Border" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Pressed.Glyph" Color="#FFFFFFFF"/>

        <SolidColorBrush x:Key="RadioButton.Checked.Background" Color="#FF0063B1"/>
        <SolidColorBrush x:Key="RadioButton.Checked.Border" Color="#FF0063B1"/>
        <SolidColorBrush x:Key="RadioButton.Checked.Glyph" Color="#FFFFFFFF"/>

        <!--#endregion-->

        <Style x:Key="TitleButtonCanvasRed" TargetType="Canvas">
            <Setter Property="Height" Value="35"/>
            <Setter Property="Width" Value="35"/>
            <Style.Triggers>
                <Trigger Property="Canvas.IsMouseOver" Value="True">
                    <Setter Property="Canvas.Background" Value="#FF1744"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="TitleButtonCanvasGrey" TargetType="Canvas" BasedOn="{StaticResource TitleButtonCanvasRed}">
            <Style.Triggers>
                <Trigger Property="Canvas.IsMouseOver" Value="True">
                    <Setter Property="Canvas.Background" Value="#ACABAB"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="ToggleBorder" TargetType="Border">
            <Setter Property="BorderBrush" Value="#DADADA"/>
            <Setter Property="BorderThickness" Value="0 1 0 0"/>
            <Setter Property="Margin" Value="0 0 0 0"/>
            <Setter Property="Background" Value="#FFFFFF"/>
        </Style>        

        <Style x:Key="ToggleHeaderBorder" TargetType="Border" BasedOn="{StaticResource ToggleBorder}">
            <Setter Property="Height" Value="40"/>
        </Style>

        <Style x:Key="ToggleHeaderTextBlock" TargetType="TextBlock">
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="Margin" Value="25 10 0 10"/>
            <Setter Property="FontSize" Value="20"/>
        </Style>

        <Style x:Key="ToggleSwitchLeftStyle" TargetType="{x:Type ToggleButton}">
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="Background" Value="{StaticResource RadioButton.Static.Background}"/>
            <Setter Property="BorderBrush" Value="{StaticResource RadioButton.Static.Border}"/>
            <Setter Property="Foreground" Value="{DynamicResource {x:Static SystemColors.ControlTextBrushKey}}"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="SnapsToDevicePixels" Value="True"/>
            <Setter Property="FocusVisualStyle" Value="{x:Null}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ToggleButton}">
                        <Grid x:Name="templateRoot" 
							  Background="Transparent" 
							  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}">
                            <VisualStateManager.VisualStateGroups>
                                <VisualStateGroup x:Name="CommonStates">
                                    <VisualState x:Name="Normal"/>
                                    <VisualState x:Name="MouseOver">
                                        <Storyboard>
                                            <DoubleAnimation To="0" Duration="0:0:0.2" Storyboard.TargetName="normalBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0:0:0.2" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Pressed">
                                        <Storyboard>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="pressedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Pressed.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Disabled">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="CheckStates">
                                    <VisualState x:Name="Unchecked"/>
                                    <VisualState x:Name="Checked">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Static.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimationUsingKeyFrames Duration="0:0:0.5" Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[3].(TranslateTransform.X)" Storyboard.TargetName="optionMark">
                                                <EasingDoubleKeyFrame KeyTime="0" Value="12"/>
                                            </DoubleAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Checked.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Indeterminate"/>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="FocusStates">
                                    <VisualState x:Name="Unfocused"/>
                                    <VisualState x:Name="Focused"/>
                                </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Grid.RowDefinitions>
                                <RowDefinition />
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>
                            <ContentPresenter x:Name="contentPresenter" 
											  Focusable="False" RecognizesAccessKey="True" 
											  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" 
											  Margin="{TemplateBinding Padding}" 
											  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" 
											  VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                            <Grid x:Name="markGrid" Grid.Row="1" Margin="10 0 10 0" Width="44" Height="20"
								  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}">
                                <Border x:Name="normalBorder" Opacity="1" BorderThickness="2" CornerRadius="10"
										BorderBrush="{TemplateBinding BorderBrush}" Background="{StaticResource RadioButton.Static.Background}"/>
                                <Border x:Name="checkedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource  RadioButton.Checked.Border}" Background="{StaticResource RadioButton.Checked.Background}"/>
                                <Border x:Name="hoverBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.MouseOver.Border}" Background="{StaticResource RadioButton.MouseOver.Background}"/>
                                <Border x:Name="pressedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Pressed.Border}" Background="{StaticResource RadioButton.Pressed.Background}"/>
                                <Border x:Name="disabledBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Disabled.Border}" Background="{StaticResource RadioButton.Disabled.Background}"/>
                                <Ellipse x:Name="optionMark"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Static.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="-12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                                <Ellipse x:Name="optionMarkOn" Opacity="0"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Checked.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                            </Grid>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="ToggleSwitchLeftWhiteStyle" TargetType="{x:Type ToggleButton}">
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="Background" Value="{StaticResource RadioButton.Static.Background}"/>
            <Setter Property="BorderBrush" Value="#FFFFFF"/>
            <Setter Property="Foreground" Value="{DynamicResource {x:Static SystemColors.ControlTextBrushKey}}"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="SnapsToDevicePixels" Value="True"/>
            <Setter Property="FocusVisualStyle" Value="{x:Null}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ToggleButton}">
                        <Grid x:Name="templateRoot" 
							  Background="Transparent" 
							  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}">
                            <VisualStateManager.VisualStateGroups>
                                <VisualStateGroup x:Name="CommonStates">
                                    <VisualState x:Name="Normal"/>
                                    <VisualState x:Name="Pressed">
                                        <Storyboard>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="pressedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Pressed.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Disabled">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="CheckStates">
                                    <VisualState x:Name="Unchecked"/>
                                    <VisualState x:Name="Checked">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Static.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimationUsingKeyFrames Duration="0:0:0.5" Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[3].(TranslateTransform.X)" Storyboard.TargetName="optionMark">
                                                <EasingDoubleKeyFrame KeyTime="0" Value="12"/>
                                            </DoubleAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Checked.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Indeterminate"/>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="FocusStates">
                                    <VisualState x:Name="Unfocused"/>
                                    <VisualState x:Name="Focused"/>
                                </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Grid.RowDefinitions>
                                <RowDefinition />
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>
                            <ContentPresenter x:Name="contentPresenter" 
											  Focusable="False" RecognizesAccessKey="True" 
											  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" 
											  Margin="{TemplateBinding Padding}" 
											  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" 
											  VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                            <Grid x:Name="markGrid" Grid.Row="1" Margin="10 0 10 0" Width="44" Height="20"
								  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}">
                                <Border x:Name="normalBorder" Opacity="1" BorderThickness="2" CornerRadius="10"
										BorderBrush="{TemplateBinding BorderBrush}" Background="Transparent"/>
                                <Border x:Name="checkedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="#FFFFFF" Background="Transparent"/>
                                <Border x:Name="hoverBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="#FFFFFF" Background="Transparent"/>
                                <Border x:Name="pressedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="#FFFFFF" Background="Transparent"/>
                                <Border x:Name="disabledBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Disabled.Border}" Background="{StaticResource RadioButton.Disabled.Background}"/>
                                <Ellipse x:Name="optionMark"
										 Height="10" Width="10" Fill="#FFFFFF" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="-12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                                <Ellipse x:Name="optionMarkOn" Opacity="0"
										 Height="10" Width="10" Fill="#FFFFFF" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                            </Grid>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="ViewboxCategoryButton" TargetType="{x:Type Viewbox}">
            <Setter Property="Width" Value="24"/>
            <Setter Property="Height" Value="24"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalAlignment" Value="Left"/>
            <Setter Property="Margin" Value="13 0 13 3"/>
        </Style>

        <Style x:Key="ViewboxFooter" TargetType="{x:Type Viewbox}">
            <Setter Property="Width" Value="22"/>
            <Setter Property="Height" Value="22"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalAlignment" Value="Center"/>
            <Setter Property="Margin" Value="5 0 5 0"/>
        </Style>

        <Style x:Key="TextblockCategoryButton" TargetType="TextBlock">
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Foreground" Value="#FFFFFF"/>
        </Style>

        <Style x:Key="TextblockActionButton" TargetType="TextBlock" BasedOn="{StaticResource TextblockCategoryButton}">
            <Setter Property="HorizontalAlignment" Value="Center"/>            
            <Setter Property="Margin" Value="30 0 30 0"/>
        </Style>

    </Window.Resources>

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="50"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="30"/>
        </Grid.RowDefinitions>

        <!--#region Group Buttons-->
        <Grid Name="PanelGroupButton" Grid.Row="0" Background="#414242">            

            <!--#region Category Buttons-->
            <StackPanel Orientation="Horizontal" VerticalAlignment="Center" HorizontalAlignment="Center" Height="50" >

                <!--#region Privacy & Telemetry Button-->
                <StackPanel Name="ButtonAction_Privacy">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="180" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M18,20V10H6V20H18M18,8A2,2 0 0,1 20,10V20A2,2 0 0,1 18,22H6C4.89,22 4,21.1 4,20V10A2,2 0 0,1 6,8H15V6A3,3 0 0,0 12,3A3,3 0 0,0 9,6H7A5,5 0 0,1 12,1A5,5 0 0,1 17,6V8H18M12,17A2,2 0 0,1 10,15A2,2 0 0,1 12,13A2,2 0 0,1 14,15A2,2 0 0,1 12,17Z" 
                                  Fill="#FFFFFF"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_Privacy" Text="Privacy &amp; Telemetry" Style="{StaticResource TextblockCategoryButton}"/>
                </StackPanel>
                <!--#endregion Privacy & Telemetry Button-->

                <!--#region UI & Personalization Button-->
                <StackPanel Name="ButtonAction_Ui">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="180" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M4 4C2.89 4 2 4.89 2 6V18C2 19.11 2.9 20 4 20H12V18H4V8H20V12H22V8C22 6.89 21.1 6 20 6H12L10 4M18 14C17.87 14 17.76 14.09 17.74 14.21L17.55 15.53C17.25 15.66 16.96 15.82 16.7 16L15.46 15.5C15.35 15.5 15.22 15.5 15.15 15.63L14.15 17.36C14.09 17.47 14.11 17.6 14.21 17.68L15.27 18.5C15.25 18.67 15.24 18.83 15.24 19C15.24 19.17 15.25 19.33 15.27 19.5L14.21 20.32C14.12 20.4 14.09 20.53 14.15 20.64L15.15 22.37C15.21 22.5 15.34 22.5 15.46 22.5L16.7 22C16.96 22.18 17.24 22.35 17.55 22.47L17.74 23.79C17.76 23.91 17.86 24 18 24H20C20.11 24 20.22 23.91 20.24 23.79L20.43 22.47C20.73 22.34 21 22.18 21.27 22L22.5 22.5C22.63 22.5 22.76 22.5 22.83 22.37L23.83 20.64C23.89 20.53 23.86 20.4 23.77 20.32L22.7 19.5C22.72 19.33 22.74 19.17 22.74 19C22.74 18.83 22.73 18.67 22.7 18.5L23.76 17.68C23.85 17.6 23.88 17.47 23.82 17.36L22.82 15.63C22.76 15.5 22.63 15.5 22.5 15.5L21.27 16C21 15.82 20.73 15.65 20.42 15.53L20.23 14.21C20.22 14.09 20.11 14 20 14M19 17.5C19.83 17.5 20.5 18.17 20.5 19C20.5 19.83 19.83 20.5 19 20.5C18.16 20.5 17.5 19.83 17.5 19C17.5 18.17 18.17 17.5 19 17.5Z"
                                  Fill="#FFFFFF"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_Ui" Text="UI &amp; Personalization" Style="{StaticResource TextblockCategoryButton}"/>
                </StackPanel>
                
                <!--#endregion UI & Personalization Button-->

                <!--#region OneDrive Button-->
                <StackPanel Name="ButtonAction_OneDrive">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="120" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M19,18H6A4,4 0 0,1 2,14A4,4 0 0,1 6,10H6.71C7.37,7.69 9.5,6 12,6A5.5,5.5 0 0,1 17.5,11.5V12H19A3,3 0 0,1 22,15A3,3 0 0,1 19,18M19.35,10.03C18.67,6.59 15.64,4 12,4C9.11,4 6.6,5.64 5.35,8.03C2.34,8.36 0,10.9 0,14A6,6 0 0,0 6,20H19A5,5 0 0,0 24,15C24,12.36 21.95,10.22 19.35,10.03Z"
                                  Fill="#FFFFFF"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_OneDrive" Text="OneDrive" Style="{StaticResource TextblockCategoryButton}" />
                </StackPanel>
                <!--#endregion OneDrive Button-->

                <!--#region System Button-->
                <StackPanel Name="ButtonAction_System" >
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="110" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M12,8A4,4 0 0,1 16,12A4,4 0 0,1 12,16A4,4 0 0,1 8,12A4,4 0 0,1 12,8M12,10A2,2 0 0,0 10,12A2,2 0 0,0 12,14A2,2 0 0,0 14,12A2,2 0 0,0 12,10M10,22C9.75,22 9.54,21.82 9.5,21.58L9.13,18.93C8.5,18.68 7.96,18.34 7.44,17.94L4.95,18.95C4.73,19.03 4.46,18.95 4.34,18.73L2.34,15.27C2.21,15.05 2.27,14.78 2.46,14.63L4.57,12.97L4.5,12L4.57,11L2.46,9.37C2.27,9.22 2.21,8.95 2.34,8.73L4.34,5.27C4.46,5.05 4.73,4.96 4.95,5.05L7.44,6.05C7.96,5.66 8.5,5.32 9.13,5.07L9.5,2.42C9.54,2.18 9.75,2 10,2H14C14.25,2 14.46,2.18 14.5,2.42L14.87,5.07C15.5,5.32 16.04,5.66 16.56,6.05L19.05,5.05C19.27,4.96 19.54,5.05 19.66,5.27L21.66,8.73C21.79,8.95 21.73,9.22 21.54,9.37L19.43,11L19.5,12L19.43,13L21.54,14.63C21.73,14.78 21.79,15.05 21.66,15.27L19.66,18.73C19.54,18.95 19.27,19.04 19.05,18.95L16.56,17.95C16.04,18.34 15.5,18.68 14.87,18.93L14.5,21.58C14.46,21.82 14.25,22 14,22H10M11.25,4L10.88,6.61C9.68,6.86 8.62,7.5 7.85,8.39L5.44,7.35L4.69,8.65L6.8,10.2C6.4,11.37 6.4,12.64 6.8,13.8L4.68,15.36L5.43,16.66L7.86,15.62C8.63,16.5 9.68,17.14 10.87,17.38L11.24,20H12.76L13.13,17.39C14.32,17.14 15.37,16.5 16.14,15.62L18.57,16.66L19.32,15.36L17.2,13.81C17.6,12.64 17.6,11.37 17.2,10.2L19.31,8.65L18.56,7.35L16.15,8.39C15.38,7.5 14.32,6.86 13.12,6.62L12.75,4H11.25Z"
                                  Fill="#FFFFFF" />
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_System" Text="System" Style="{StaticResource TextblockCategoryButton}" />
                </StackPanel>
                <!--#endregion System Button-->

                <!--#region Start Menu Button-->
                <StackPanel Name="ButtonAction_StartMenu" >
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="130" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M3,12V6.75L9,5.43V11.91L3,12M20,3V11.75L10,11.9V5.21L20,3M3,13L9,13.09V19.9L3,18.75V13M20,13.25V22L10,20.09V13.1L20,13.25Z"
                                  Fill="#FFFFFF"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_StartMenu" Text="Start Menu" Style="{StaticResource TextblockCategoryButton}" />
                </StackPanel>
                <!--#endregion Start Menu Button-->

                <!--#region Microsoft Edge Button-->
                <StackPanel Name="ButtonAction_Edge" >
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="155" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M2.74,10.81C3.83,-1.36 22.5,-1.36 21.2,13.56H8.61C8.61,17.85 14.42,19.21 19.54,16.31V20.53C13.25,23.88 5,21.43 5,14.09C5,8.58 9.97,6.81 9.97,6.81C9.97,6.81 8.58,8.58 8.54,10.05H15.7C15.7,2.93 5.9,5.57 2.74,10.81Z"
                                  Fill="#FFFFFF"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_Edge" Text="Microsoft Edge" Style="{StaticResource TextblockCategoryButton}" />
                </StackPanel>
                <!--#endregion Microsoft Edge Button-->

                <!--#region UWP Apps Button-->
                <StackPanel Name="ButtonAction_Uwp">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="130" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M3,13A9,9 0 0,0 12,22A9,9 0 0,0 3,13M5.44,15.44C7.35,16.15 8.85,17.65 9.56,19.56C7.65,18.85 6.15,17.35 5.44,15.44M12,22A9,9 0 0,0 21,13A9,9 0 0,0 12,22M14.42,19.57C15.11,17.64 16.64,16.11 18.57,15.42C17.86,17.34 16.34,18.86 14.42,19.57M12,14A6,6 0 0,0 18,8V3C17.26,3 16.53,3.12 15.84,3.39C15.29,3.62 14.8,3.96 14.39,4.39L12,2L9.61,4.39C9.2,3.96 8.71,3.62 8.16,3.39C7.47,3.12 6.74,3 6,3V8A6,6 0 0,0 12,14M8,5.61L9.57,7.26L12,4.83L14.43,7.26L16,5.61V8A4,4 0 0,1 12,12A4,4 0 0,1 8,8V5.61Z"
                                  Fill="#FFFFFF"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_Uwp" Text="UWP Apps" Style="{StaticResource TextblockCategoryButton}" />
                </StackPanel>
                <!--#endregion UWP Apps Button-->

                <!--#region Windows Game Recording Button-->
                <StackPanel Name="ButtonAction_Game">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="220" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M6.43,3.72C6.5,3.66 6.57,3.6 6.62,3.56C8.18,2.55 10,2 12,2C13.88,2 15.64,2.5 17.14,3.42C17.25,3.5 17.54,3.69 17.7,3.88C16.25,2.28 12,5.7 12,5.7C10.5,4.57 9.17,3.8 8.16,3.5C7.31,3.29 6.73,3.5 6.46,3.7M19.34,5.21C19.29,5.16 19.24,5.11 19.2,5.06C18.84,4.66 18.38,4.56 18,4.59C17.61,4.71 15.9,5.32 13.8,7.31C13.8,7.31 16.17,9.61 17.62,11.96C19.07,14.31 19.93,16.16 19.4,18.73C21,16.95 22,14.59 22,12C22,9.38 21,7 19.34,5.21M15.73,12.96C15.08,12.24 14.13,11.21 12.86,9.95C12.59,9.68 12.3,9.4 12,9.1C12,9.1 11.53,9.56 10.93,10.17C10.16,10.94 9.17,11.95 8.61,12.54C7.63,13.59 4.81,16.89 4.65,18.74C4.65,18.74 4,17.28 5.4,13.89C6.3,11.68 9,8.36 10.15,7.28C10.15,7.28 9.12,6.14 7.82,5.35L7.77,5.32C7.14,4.95 6.46,4.66 5.8,4.62C5.13,4.67 4.71,5.16 4.71,5.16C3.03,6.95 2,9.35 2,12A10,10 0 0,0 12,22C14.93,22 17.57,20.74 19.4,18.73C19.4,18.73 19.19,17.4 17.84,15.5C17.53,15.07 16.37,13.69 15.73,12.96Z"
                                  Fill="#FFFFFF"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_Game" Text="Windows Game Recording" Style="{StaticResource TextblockCategoryButton}" />
                </StackPanel>
                <!--#endregion Windows Game Recording Button-->

                <!--#region Scheduled Tasks Button-->
                <StackPanel Name="ButtonAction_Tasks">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="160" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M19,19H5V8H19M19,3H18V1H16V3H8V1H6V3H5C3.89,3 3,3.9 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V5A2,2 0 0,0 19,3M16.53,11.06L15.47,10L10.59,14.88L8.47,12.76L7.41,13.82L10.59,17L16.53,11.06Z"
                                  Fill="#FFFFFF"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_Tasks" Text="Scheduled Tasks" Style="{StaticResource TextblockCategoryButton}" />
                </StackPanel>
                <!--#endregion Scheduled Tasks Button-->

                <!--#region Microsoft Defender Button-->
                <StackPanel Name="ButtonAction_Defender">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="180" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}">
                        <Canvas Width="24" Height="24">
                            <Path Data="M21,11C21,16.55 17.16,21.74 12,23C6.84,21.74 3,16.55 3,11V5L12,1L21,5V11M12,21C15.75,20 19,15.54 19,11.22V6.3L12,3.18V21Z"
                                  Fill="#FFFFFF"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_Defender" Text="Microsoft Defender" Style="{StaticResource TextblockCategoryButton}" />
                </StackPanel>
                <!--#endregion Microsoft Defender Button-->

                <!--#region Context Menu Button-->
                <StackPanel Name="ButtonAction_ContextMenu">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Setter Property="Orientation" Value="Horizontal"/>
                            <Setter Property="Width" Value="50"/>                            
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="150" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="50" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="0 0 0 0" To="0 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Style="{StaticResource ViewboxCategoryButton}" >
                        <Canvas Width="24" Height="24">
                            <Path Data="M3,3H9V7H3V3M15,10H21V14H15V10M15,17H21V21H15V17M13,13H7V18H13V20H7L5,20V9H7V11H13V13Z"
                                  Fill="#FFFFFF"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ButtonText_ContextMenu" Text="Context Menu" Style="{StaticResource TextblockCategoryButton}" />
                </StackPanel>
                <!--#endregion Context Menu Button-->

                <!--#region Apply Button-->
                <Border Name="ButtonText_Apply" BorderThickness="1" BorderBrush="#FFFFFF" 
                    Height="35" Margin="10 0 0 0" HorizontalAlignment="Right" VerticalAlignment="Center">
                    <Border.Style>
                        <Style TargetType="{x:Type Border}">
                            <Style.Triggers>
                                <Trigger  Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#666667"/>
                                </Trigger>
                                <Trigger  Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="#414242"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" From="10 0 0 0" To="10 5 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </Border.Style>
                    <TextBlock Text="Apply" Style="{StaticResource TextblockActionButton}" />
                </Border>
                <!--#endregion Apply Button-->

                <!--#region Change Language Toggle-->
                <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" Margin="10 0 0 0">
                    <Grid>
                        <ToggleButton Name="ToggleSwitch_Language" Style="{DynamicResource ToggleSwitchLeftWhiteStyle}" IsChecked="False"/>
                        <TextBlock Name="TextBlock_Language" Foreground="#FFFFFF" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                            <TextBlock.Style>
                                <Style TargetType="{x:Type TextBlock}">
                                    <Style.Triggers>
                                        <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Language, Path=IsChecked}" Value="True">
                                            <Setter Property="Text" Value="RU"/>
                                            <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                        </DataTrigger>
                                        <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Language, Path=IsChecked}" Value="false">
                                            <Setter Property="Text" Value="EN"/>
                                            <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                        </DataTrigger>
                                        <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Language, Path=IsEnabled}" Value="false">
                                            <Setter Property="Opacity" Value="0.2" />
                                        </DataTrigger>
                                    </Style.Triggers>
                                </Style>
                            </TextBlock.Style>
                        </TextBlock>
                    </Grid>
                </StackPanel>
                <!--#endregion Change Language Toggle-->

            </StackPanel>
            <!--#endregion Category Buttons-->

               

        </Grid>
        <!--#endregion Group Buttons-->        

        <!--#region Toggle Button-->
        <ScrollViewer Name="ScrollToggle" Grid.Row="1" HorizontalScrollBarVisibility="Disabled" VerticalScrollBarVisibility="Auto">
            <StackPanel Orientation="Vertical">

                <!--#region Privacy & Telemetry-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_Privacy" Text="Privacy &amp; Telemetry" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_0" Text="Turn off &quot;Connected User Experiences and Telemetry&quot; service" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_1" Text="Turn off per-user services" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_1, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_1, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_2" Text="Turn off the Autologger session at the next computer restart" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_2, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_2, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_3" Text="Turn off the SQMLogger session at the next computer restart" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_3, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_3, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_4" Text="Set the operating system diagnostic data level to &quot;Basic&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_4, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_4, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_5" Text="Turn off Windows Error Reporting" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_5, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_5, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_6" Text="Change Windows Feedback frequency to &quot;Never&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_6, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_6, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_7" Text="Turn off diagnostics tracking scheduled tasks" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_7, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_7, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_8" Text="Do not offer tailored experiences based on the diagnostic data setting" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_8, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_8, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_9" Text="Do not let apps on other devices open and message apps on this device, and vice versa" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_9, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_9, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_10" Text="Do not allow apps to use advertising ID" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_10, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_10, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_11" Text="Do not use sign-in info to automatically finish setting up device after an update or restart" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_11, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_11, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_12" Text="Do not let websites provide locally relevant content by accessing language list" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_12, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_12, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_13" Text="Turn on tip, trick, and suggestions as you use Windows" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_13, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_13, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_14" Text="Turn off app suggestions on Start menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_14, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_14, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_15" Text="Turn off suggested content in the Settings" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_15, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_15, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_16" Text="Turn off automatic installing suggested apps" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_16, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_16, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Privacy_17" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Privacy_17" Text="Turn off app launch tracking to improve Start menu and search results" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_17, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Privacy_17, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion Privacy & Telemetry-->

                <!--#region UI & Personalization-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_UI" Text="UI &amp; Personalization" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_0" Text="Set File Explorer to open to This PC by default" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_1" Text="Show Hidden Files, Folders, and Drives" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_1, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_1, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_2" Text="Show File Name Extensions" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_2, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_2, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_3" Text="Hide Task View button on taskbar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_3, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_3, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_4" Text="Show folder merge conflicts" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_4, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_4, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_5" Text="Turn off Snap Assist" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_5, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_5, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_6" Text="Turn off check boxes to select items" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_6, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_6, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_7" Text="Show seconds on taskbar clock" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_7, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_7, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_8" Text="Hide People button on the taskbar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_8, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_8, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_9" Text="Hide all folders in the navigation pane" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_9, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_9, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_10" Text="Remove 3D Objects folder in &quot;This PC&quot; and in the navigation pane" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_10, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_10, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_11" Text="Hide &quot;Frequent folders&quot; in Quick access" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_11, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_11, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_12" Text="Hide &quot;Recent files&quot; in Quick access" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_12, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_12, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_13" Text="Turn on acrylic taskbar transparency" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_13, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_13, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_14" Text="Show &quot;This PC&quot; on Desktop" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_14, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_14, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_15" Text="Show more details in file transfer dialog" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_15, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_15, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_16" Text="Remove the &quot;Previous Versions&quot; tab from properties context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_16, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_16, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_17" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_17" Text="Always show all icons in the notification area" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_17, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_17, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_18" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_18" Text="Set the Control Panel view by large icons" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_18, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_18, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_19" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_19" Text="Hide &quot;Windows Ink Workspace&quot; button in taskbar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_19, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_19, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_20" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_20" Text="Hide search box or search icon on taskbar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_20, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_20, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_21" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_21" Text="Turn on recycle bin files delete confirmation" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_21, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_21, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_22" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_22" Text="Turn on ribbon in File Explorer" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_22, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_22, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_23" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_23" Text="Choose theme color for default Windows mode" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_23, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_23, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_24" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_24" Text="Choose theme color for default app mode" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_24, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_24, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_25" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_25" Text="Turn off &quot;New App Installed&quot; notification" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_25, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_25, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_26" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_26" Text="Turn off recently added apps on Start menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_26, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_26, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_27" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_27" Text="Turn off user first sign-in animation" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_27, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_27, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_28" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_28" Text="Turn off JPEG desktop wallpaper import quality reduction" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_28, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_28, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_29" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_29" Text="Show Task Manager details" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_29, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_29, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_30" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_30" Text="Unpin Microsoft Edge and Microsoft Store from taskbar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_30, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_30, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_31" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_31" Text="Remove Microsoft Edge shortcut from the Desktop" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_31, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_31, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_32" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_32" Text="Show accent color on the title bars and window borders" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_32, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_32, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_33" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_33" Text="Turn off automatically hiding scroll bars" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_33, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_33, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_34" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_34" Text="Save screenshots by pressing Win+PrtScr to the Desktop" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_34, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_34, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_35" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_35" Text="Show more Windows Update restart notifications about restarting" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_35, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_35, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_36" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_36" Text="Turn off the &quot;- Shortcut&quot; name extension for new shortcuts" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_36, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_36, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_37" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_37" Text="Use the PrtScn button to open screen snipping" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_37, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_37, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UI_38" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UI_38" Text="Automatically adjust active hours for me based on daily usage" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_38, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UI_38, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion UI & Personalization-->

                <!--#region One Drive-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_OneDrive" Text="OneDrive" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_OneDrive_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_OneDrive_0" Text="Uninstall OneDrive" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_OneDrive_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_OneDrive_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion One Drive-->

                <!--#region System-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_System" Text="System" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_0" Text="Turn on Storage Sense to automatically free up space" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_1" Text="Run Storage Sense every month" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_1, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_1, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_2" Text="Delete temporary files that apps aren't using" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_2, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_2, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_3" Text="Delete files in recycle bin if they have been there for over 30 days" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_3, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_3, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_4" Text="Never delete files in &quot;Downloads&quot; folder" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_4, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_4, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_5" Text="Let Windows try to fix apps so they're not blurry" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_5, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_5, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_6" Text="Turn off hibernate" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_6, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_6, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_7" Text="Turn off location for this device" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_7, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_7, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_8" Text="Change environment variable for &quot;%TEMP%&quot; to &quot;%SystemDrive%\Temp&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_8, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_8, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_9" Text="Remove &quot;%LOCALAPPDATA%\Temp&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_9, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_9, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_10" Text="Remove &quot;%SYSTEMROOT%\Temp&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_10, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_10, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_11" Text="Turn on Win32 long paths" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_11, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_11, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_12" Text="Group svchost.exe processes" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_12, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_12, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_13" Text="Turn on Retpoline patch against Spectre v2" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_13, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_13, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_14" Text="Turn on the display of stop error information on the BSoD" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_14, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_14, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_15" Text="Do not preserve zone information" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_15, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_15, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_16" Text="Turn off Admin Approval Mode for administrators" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_16, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_16, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_17" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_17" Text="Turn on access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_17, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_17, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_18" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_18" Text="Set download mode for delivery optization on &quot;HTTP only&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_18, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_18, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_19" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_19" Text="Always wait for the network at computer startup and logon" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_19, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_19, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_20" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_20" Text="Turn off Cortana" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_20, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_20, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_21" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_21" Text="Do not allow Windows 10 to manage default printer" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_21, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_21, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_22" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_22" Text="Turn off Windows features" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_22, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_22, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_23" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_23" Text="Remove Windows capabilities" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_23, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_23, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_24" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_24" Text="Turn on updates for other Microsoft products" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_24, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_24, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_25" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_25" Text="Enable System Restore" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_25, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_25, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_26" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_26" Text="Turn off Windows Script Host" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_26, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_26, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_27" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_27" Text="Turn off default background apps except" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_27, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_27, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_28" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_28" Text="Set power management scheme for desktop and laptop" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_28, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_28, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_29" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_29" Text="Turn on .NET 4 runtime for all apps" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_29, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_29, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_30" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_30" Text="Turn on firewall &amp; network protection" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_30, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_30, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_31" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_31" Text="Do not allow the computer to turn off the device to save power for desktop" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_31, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_31, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_32" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_32" Text="Set the default input method to the English language" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_32, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_32, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_33" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_33" Text="Turn on Windows Sandbox" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_33, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_33, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_34" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_34" Text="Set location of the &quot;Desktop&quot;, &quot;Documents&quot; &quot;Downloads&quot; &quot;Music&quot;, &quot;Pictures&quot;, and &quot;Videos&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_34, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_34, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_35" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_35" Text="Turn on automatic recommended troubleshooting and tell when problems get fixed" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_35, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_35, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_36" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_36" Text="Set &quot;High performance&quot; in graphics performance preference for apps" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_36, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_36, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_37" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_37" Text="Launch folder in a separate process" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_37, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_37, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_38" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_38" Text="Turn off and delete reserved storage after the next update installation" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_38, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_38, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_39" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_39" Text="Turn on automatic backup the system registry to the &quot;%SystemRoot%\System32\config\RegBack&quot; folder" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_39, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_39, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_40" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_40" Text="Turn off &quot;The Windows Filtering Platform has blocked a connection&quot; message" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_40, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_40, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_41" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_41" Text="Turn off SmartScreen for apps and files" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_41, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_41, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_42" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_42" Text="Turn off F1 Help key" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_42, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_42, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_43" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_43" Text="Turn on Num Lock at startup" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_43, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_43, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_44" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_44" Text="Turn off sticky Shift key after pressing 5 times" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_44, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_44, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_45" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_45" Text="Turn off AutoPlay for all media and devices" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_45, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_45, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_46" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_46" Text="Turn off creation of an Edge shortcut on the desktop for each user profile" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_46, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_46, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_47" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_47" Text="Turn off thumbnail cache removal" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_47, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_47, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_System_48" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_System_48" Text="Turn On automatically save my restartable apps when sign out and restart them after sign in" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_48, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_System_48, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion System-->

                <!--#region Start Menu-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_StartMenu" Text="Start Menu" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_StartMenu_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_StartMenu_0" Text="Open shortcut to the Command Prompt from Start menu as Administrator" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_StartMenu_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_StartMenu_1" Text="Create old style shortcut for &quot;Devices and Printers&quot; in&#x0a;&quot;%APPDATA%\Microsoft\Windows\Start menu\Programs\System Tools&quot;" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_1, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_1, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_StartMenu_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_StartMenu_2" Text="Import Start menu layout from pre-saved reg file" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_2, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_StartMenu_2, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion Start Menu-->

                <!--#region Microsoft Edge-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_Edge" Text="Microsoft Edge" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Edge_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Edge_0" Text="Turn off Windows Defender SmartScreen for Microsoft Edge" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Edge_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Edge_1" Text="Do not allow Microsoft Edge to start and load the Start and New Tab page&#x0a;at Windows startup and each time Microsoft Edge is closed" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_1, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_1, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_Edge_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_Edge_2" Text="Do not allow Microsoft Edge to pre-launch at Windows startup,&#x0a;when the system is idle, and each time Microsoft Edge is closed" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_2, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_Edge_2, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion Microsoft Edge-->

                <!--#region UWP Apps-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_UWPApps" Text="UWP Apps" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UWPApps_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UWPApps_0" Text="Uninstall all UWP apps from all accounts except" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UWPApps_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UWPApps_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_UWPApps_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_UWPApps_1" Text="Uninstall all provisioned UWP apps from all accounts except" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UWPApps_1, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_UWPApps_1, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion UWP Apps-->

                <!--#region Windows Game Recording-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_WindowsGameRecording" Text="Windows Game Recording" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_WindowsGameRecording_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_WindowsGameRecording_0" Text="Turn off Windows Game Recording and Broadcasting" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_WindowsGameRecording_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_WindowsGameRecording_1" Text="Turn off Game Bar" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_1, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_1, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_WindowsGameRecording_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_WindowsGameRecording_2" Text="Turn off Game Mode" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_2, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_2, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_WindowsGameRecording_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_WindowsGameRecording_3" Text="Turn off Game Bar tips" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_3, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_WindowsGameRecording_3, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion Windows Game Recording-->

                <!--#region Scheduled Tasks-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_ScheduledTasks" Text="Scheduled Tasks" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ScheduledTasks_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ScheduledTasks_0" Text="Create a task in the Task Scheduler to start Windows cleaning up. The task runs every 90 days" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ScheduledTasks_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ScheduledTasks_1" Text="Create a task in the Task Scheduler to clear the &quot;$env:SystemRoot\SoftwareDistribution\Download&quot; folder.&#x0a;The task runs on Thursdays every 4 weeks" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_1, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_1, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ScheduledTasks_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ScheduledTasks_2" Text="Create a task in the Task Scheduler to clear the $env:TEMP folder. The task runs every 62 days" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_2, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ScheduledTasks_2, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion Scheduled Tasks-->

                <!--#region Microsoft Defender-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_MicrosoftDefender" Text="Microsoft Defender" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_MicrosoftDefender_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_MicrosoftDefender_0" Text="Add folder to exclude from Windows Defender Antivirus scan" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_MicrosoftDefender_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_MicrosoftDefender_1" Text="Turn on Controlled folder access and add protected folders" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_1, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_1, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_MicrosoftDefender_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_MicrosoftDefender_2" Text="Allow an app through Controlled folder access" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_2, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_2, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_MicrosoftDefender_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_MicrosoftDefender_3" Text="Turn on Windows Defender Exploit Guard Network Protection" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_3, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_3, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_MicrosoftDefender_4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_MicrosoftDefender_4" Text="Turn on Windows Defender PUA Protection" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_4, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_4, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_MicrosoftDefender_5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_MicrosoftDefender_5" Text="Turn on Windows Defender Sandbox" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_5, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_5, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_MicrosoftDefender_6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_MicrosoftDefender_6" Text="Hide notification about sign in with Microsoft in the Windows Security" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_6, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_6, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_MicrosoftDefender_7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_MicrosoftDefender_7" Text="Hide notification about disabled Smartscreen for Microsoft Edge" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_7, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_MicrosoftDefender_7, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion Microsoft Defender-->

                <!--#region Context Menu-->
                <StackPanel Orientation="Horizontal">
                    <TextBlock Name="Header_ContextMenu" Text="Context Menu" Style="{StaticResource ToggleHeaderTextBlock}"/>
                </StackPanel>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_0" Text="Add &quot;Extract&quot; to MSI file type context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_0, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_0, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_1" Text="Add &quot;Run as different user&quot; from context menu for .exe file type" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_1, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_1, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_2" Text="Add &quot;Install&quot; to CAB file type context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_2, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_2, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_3" Text="Remove &quot;Cast to Device&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_3, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_3, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_4" Text="Remove &quot;Share&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_4, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_4, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_5" Text="Remove &quot;Previous Versions&quot; from file context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_5, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_5, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_6" Text="Remove &quot;Edit with Paint 3D&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_6, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_6, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_7" Text="Remove &quot;Include in Library&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_7, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_7, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_8" Text="Remove &quot;Turn on BitLocker&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_8, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_8, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_9" Text="Remove &quot;Edit with Photos&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_9, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_9, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_10" Text="Remove &quot;Create a new video&quot; from Context Menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_10, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_10, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_11" Text="Remove &quot;Edit&quot; from Context Menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_11, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_11, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_12" Text="Remove &quot;Print&quot; from batch and cmd files context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_12, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_12, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_13" Text="Remove &quot;Compressed (zipped) Folder&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_13, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_13, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_14" Text="Remove &quot;Rich Text Document&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_14, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_14, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_15" Text="Remove &quot;Bitmap image&quot; from context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_15, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_15, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_16" Text="Remove &quot;Send to&quot; from folder context menu" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_16, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_16, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_17" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_17" Text="Make the &quot;Open&quot;, &quot;Print&quot;, &quot;Edit&quot; context menu items available, when more than 15 selected" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_17, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_17, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <Border Style="{StaticResource ToggleBorder}">
                    <StackPanel Orientation="Horizontal" Margin="5">
                        <Grid HorizontalAlignment="Left">
                            <ToggleButton Name="ToggleSwitch_ContextMenu_18" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                            <TextBlock Name="TextBlock_ContextMenu_18" Text="Turn off &quot;Look for an app in the Microsoft Store&quot; in &quot;Open with&quot; dialog" Margin="65 2 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                <TextBlock.Style>
                                    <Style TargetType="{x:Type TextBlock}">
                                        <Style.Triggers>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_18, Path=IsChecked}" Value="True">
                                                <Setter Property="Foreground" Value="#0078d7"/>
                                            </DataTrigger>
                                            <DataTrigger Binding="{Binding ElementName=ToggleSwitch_ContextMenu_18, Path=IsEnabled}" Value="false">
                                                <Setter Property="Opacity" Value="0.2" />
                                            </DataTrigger>
                                        </Style.Triggers>
                                    </Style>
                                </TextBlock.Style>
                            </TextBlock>
                        </Grid>
                    </StackPanel>
                </Border>
                <!--#region Category End Placeholder-->
                <Border Style="{StaticResource ToggleBorder}"/>
                <!--#endregion Category End Placeholder-->
                <!--#endregion Context Menu-->

            </StackPanel>
        </ScrollViewer>
        <!--#endregion Toggle Button-->

        <!--#region Footer-->
        <StackPanel Grid.Row="2" Orientation="Horizontal" Background="{Binding ElementName=PanelGroupButton, Path=Background}">
            <Viewbox Style="{StaticResource ViewboxFooter}">
                <Canvas Width="24" Height="24">
                    <Path Data="M12,2A10,10 0 0,0 2,12C2,16.42 4.87,20.17 8.84,21.5C9.34,21.58 9.5,21.27 9.5,21C9.5,20.77 9.5,20.14 9.5,19.31C6.73,19.91 6.14,17.97 6.14,17.97C5.68,16.81 5.03,16.5 5.03,16.5C4.12,15.88 5.1,15.9 5.1,15.9C6.1,15.97 6.63,16.93 6.63,16.93C7.5,18.45 8.97,18 9.54,17.76C9.63,17.11 9.89,16.67 10.17,16.42C7.95,16.17 5.62,15.31 5.62,11.5C5.62,10.39 6,9.5 6.65,8.79C6.55,8.54 6.2,7.5 6.75,6.15C6.75,6.15 7.59,5.88 9.5,7.17C10.29,6.95 11.15,6.84 12,6.84C12.85,6.84 13.71,6.95 14.5,7.17C16.41,5.88 17.25,6.15 17.25,6.15C17.8,7.5 17.45,8.54 17.35,8.79C18,9.5 18.38,10.39 18.38,11.5C18.38,15.32 16.04,16.16 13.81,16.41C14.17,16.72 14.5,17.33 14.5,18.26C14.5,19.6 14.5,20.68 14.5,21C14.5,21.27 14.66,21.59 15.17,21.5C19.14,20.16 22,16.42 22,12A10,10 0 0,0 12,2Z" Fill="#FFFFFF" />
                </Canvas>
            </Viewbox>
            <TextBlock Name="TextBlock_GitHub" Foreground="#FFFFFF" VerticalAlignment="Center" Padding="5 3 5 3">
                <TextBlock.Style>
                    <Style TargetType="{x:Type TextBlock}">
                        <Style.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Text" Value="https://github.com/farag2/Windows-10-Setup-Script"/>
                                <Setter Property="TextDecorations" Value="Underline"/>
                                <Setter Property="Cursor" Value="Hand"/>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="False">
                                <Setter Property="Text" Value="Follow on GitHub"/>
                            </Trigger>
                        </Style.Triggers>
                    </Style>
                </TextBlock.Style>
            </TextBlock>
        </StackPanel>
        <!--#endregion Footer-->
    </Grid>
</Window>
'@

$xamlGui = [System.Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $xamlMarkup))
$xamlMarkup.SelectNodes('//*[@Name]') | ForEach-Object {
    New-Variable -Name $_.Name -Value $xamlGui.FindName($_.Name)
        
}

#region Script Functions
function Hide-Console {
    <#
    .SYNOPSIS
    Hide Powershell console before show WPF GUI.    
    #>

    [CmdletBinding()]
    param ()

    Add-Type -Name Window -Namespace Console -MemberDefinition '
    [DllImport("Kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
    [Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0)
}

#endregion

#region Controls Events





#endregion

Hide-Console
$Window.ShowDialog() | Out-Null