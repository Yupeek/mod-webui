%if 'app' not in locals(): app = None

<!-- Fixed navbar -->
<div class="navbar navbar-inverse navbar-fixed-top">
  <div class="container" style="margin-left:0; padding-left: 0; padding-right: 0; max-width: 100%;">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="nav-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>

    <div>
      <ul class="nav navbar-nav">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle brand" data-toggle="dropdown">Shinken <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href=":7767">Shinken UI </a></li>
            <!-- We will add also others UIs on the global menu -->
            %if app:
            %other_uis = app.get_external_ui_link()
            <!-- If we add others UIs, we separate them from the inner ones-->
            %if len(other_uis) > 0:
            <li class="divider"></li>
            %end
            %for c in other_uis:
            <li><a href="{{c['uri']}}">{{c['label']}}</a></li>
            %end
            %end
          </ul>
        </li>
      </ul>
      <ul class="nav navbar-nav">
        %menu = [ ('/dashboard', 'Dashboard'), ('/impacts','Impacts'), ('/problems','IT problems'), ('/all', 'All'), ('/wall', 'Wall')]
        %for (key, value) in menu:
        %# Check for the selected element, if there is one
        %if menu_part == key:
        <li class="active"><a href="{{key}}">{{value}}</a></li>
        %else:
        <li><a href="{{key}}">{{value}}</a></li>
        %end
        %end
      </ul>
      <ul class="nav navbar-nav pull-right">
        <script>  
          $(function ()  
            { $("#searchhelp").popover({trigger: 'click', placement:'bottom', html: 'true', animation: 'true'});  
          });  
        </script> 
        <!--
        <form name="global_search" class="navbar-search pull-right topmmargin1" action='#'>
          <input type="text" class="search-query typeahead no-bottommargin" autocomplete="off" placeholder="Search" name="global_search">
          <a id="searchhelp" href="http://www.shinken-monitoring.org/wiki/webui_search" target="_blank"><i class="icon-question-sign font-white topmmargin2"></i></a>  
        </form>
        -->
        <li class="divider-vertical"></li>
        %# Check for the selected element, if there is one
        %if menu_part == '/dashboard':
        <li><a class="quickinfo" data-original-title='Currently' href="/dashboard/currently"><i class="nav-icon icon-fullscreen"></i></a></li>
        %else:
        <li></li>
        %end

        %if app:
        %overall_itproblem = app.datamgr.get_overall_it_state()
        %if overall_itproblem == 0:
        <li><a href="/problems" class="quickinfo" data-original-title='IT Problems'><i class="icon-ambulance"></i><span class="pulsate badger badger-ok">OK!</span> </a></li>
        %elif overall_itproblem == 1:
        <li><a href="/problems" class="quickinfo" data-original-title='IT Problems'><i class="icon-ambulance"></i><span class="pulsate badger badger-warning">{{app.datamgr.get_nb_all_problems(app.get_user_auth())}}</span> </a></li>
        %elif overall_itproblem == 2:
        <li><a href="/problems" class="quickinfo" data-original-title='IT Problems'><i class="icon-ambulance"></i><span class="pulsate badger badger-critical">{{app.datamgr.get_nb_all_problems(app.get_user_auth())}}</span> </a></li>
        %end
        %end

        %if app:
        %overall_state = app.datamgr.get_overall_state()
        %if overall_state == 2:
        <li><a href="/impacts" class="quickinfo" data-original-title='Impacts'><i class="icon-impact"></i><span class="pulsate badger badger-critical">{{app.datamgr.get_len_overall_state()}}</span> </a></li>
        %elif overall_state == 1:
        <li><a href="/impacts" class="quickinfo" data-original-title='Impacts'><i class="icon-impact"></i><span class="pulsate badger badger-warning">{{app.datamgr.get_len_overall_state()}}</span> </a></li>
        %end
        %end
        <!-- <li><a href="#" class="quickinfo" data-original-title='Settings'><i class="icon-setting"></i></a></li>-->
        <!-- <li><a href="/user/logout" class="quickinfo" data-original-title='Logout'><i class="nav-icon icon-off"></i></a></li> -->
        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Hi {{user.get_name().capitalize()}} <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li> <a class="disabled-link" href="#"><i class="icon-pencil"></i> Edit profile</a> </li>
            <li> <a class="" href="http://www.shinken-monitoring.org/wiki/"><i class="icon-external-link"></i> Help</a></li>
            <li class="divider"></li>
            <li> <a href="/user/logout" data-original-title='Logout'><i class="icon-off"></i> Logout</a></li>
          </ul>
        </li>
        
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</div>
