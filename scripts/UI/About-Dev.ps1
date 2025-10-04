function About {
    $aboutPopup = $itt['window'].FindName('AboutPopup')
    $aboutPopup.FindName('ver').Text = "Latest build $($itt.lastupdate)"
    $aboutPopup.IsOpen = $true
}