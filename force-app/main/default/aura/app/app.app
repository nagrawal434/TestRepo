<aura:application >
    
  <link href='/resource/bootstrap/' 
          rel="stylesheet">
    </link>
    
    <div class="navbar navbar-default navbar-static-top"
         role="navigation">
    
           <div class="container">
               <div class="navbar-header">
                <a href="#" class="navbar-brand">Lightning Contacts</a>
                   
               </div>
           
           </div>
    </div>
    <div class="container">
        <div class="row">
               <div class="col-sm-12">
                   <c:searchbar_comp />
                   <c:SearchBarAccountWithContact />
              </div>
                   
        </div>
    </div>    
</aura:application>