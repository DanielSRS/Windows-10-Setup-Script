﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using W10SS_GUI.Controls;
using W10SS_GUI.Classes;

namespace W10SS_GUI
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        
        private AppCulture AppCulture = new AppCulture();
        private Gui Gui;
        
        public MainWindow()
        {
            InitializeComponent();            
        }

        private void InitializeVariables()
        {
            Gui = new Gui();
        }

        private void InitializeToggles()
        {
            //AppDomain.CurrentDomain.BaseDirectory
        }        

        private void SetUiLanguage()
        {
            Resources.MergedDictionaries.Add(AppCulture.CurrentCulture);                
        }

        private void ButtonHamburger_Click(object sender, MouseButtonEventArgs e)
        {            
            Gui.SetActivePanel(sender as HamburgerCategoryButton);
        }

        private void ButtonHamburgerLanguageSettings_Click(object sender, MouseButtonEventArgs e)
        {            
            Resources.MergedDictionaries.Add(AppCulture.ChangeCulture());
            textTogglesHeader.Text = Convert.ToString(Resources[Gui.LastClickedButtonName]);
            Gui.SetHamburgerWidth(AppCulture.CurrentCultureName);
        }

        private void Window_Initialized(object sender, EventArgs e)
        {
            InitializeVariables();
            SetUiLanguage();
            Gui.SetHamburgerWidth(AppCulture.CurrentCultureName);
            InitializeToggles();
            Gui.SetActivePanel(HamburgerPrivacy);
        }        
    }
}
