<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/views/common/jsp-header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>调度管理中心</title>
<link rel="stylesheet" href="<e:url value='/static/styles/bootstrap-dialog.min.css' />">
<style type="text/css">
body {
  padding-top: 50px;
  min-width: 1000px;
}
.table-hover > tbody > .expand-row:hover > td, .table-hover > tbody > .expand-row:hover > th {
  background-color: #FFF;
}
.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td {
  vertical-align: middle;
}
.expand-row > td {
  border: none !important;
}
.expand-row > td > pre {
  border: none;
}

.td-label {
  text-align: right;
  font-weight: bold;
}

.workspace {
  margin: 10px 20px 10px 20px;
}
.workspace .wb {
  word-break: break-all;
}

#config-tab-content {
  margin: 0px 5px 0px 5px;
}
#runtime-tab-content {
  margin: 0px 5px 0px 5px;
}

.pajx-dialog .modal-body {
  padding: 0px;
}
.pajx-dialog-body {
  padding: 15px;
}
.pajx-dialog-footer {
  padding: 15px;
  text-align: right;
  border-top: 1px solid #e5e5e5;
}
.pajx-dialog-footer .btn+.btn {
  margin-left: 5px;
}

</style>
</head>
<body>
<header class="navbar navbar-inverse navbar-fixed-top" role="banner">
  <div class="container">
    <div class="navbar-header">
      <div class="navbar-brand">调度管理中心</div>
    </div>
    <nav class="collapse navbar-collapse" role="navigation">
      <ul class="nav navbar-nav navbar-right">
        <li><a class="glyphiconlink nav-item-label" href="#" title="消息"><span class="glyphicon glyphicon-envelope"></span></a></li>
      </ul>
    </nav>
  </div>
</header>
<div class="workspace">
  <div class="row">
    <table class="table table-hover">
      <thead>
        <tr>
          <th>#</th>
          <th>调度器名称</th>
          <th>实例名称</th>
          <th>状态</th>
          <th>开始运行时间</th>
          <th>已执行任务</th>
          <th>线程池大小</th>
          <th>持久化</th>
          <th>集群</th>
          <th>远程调度</th>
          <th>版本</th>
          <th>&nbsp;</th>
        </tr>
      </thead>
      <tbody id="scheduler-list-box">
      </tbody>
      <script id="scheduler-list-item-tpl" type="text/x-jquery-tmpl">
        <tr title="${'$'}{summary }" data-id="${'$'}{schedulerName}" class="${'$'}{cssClass}">
          <td>${'$'}{index }</td>
          <td>${'$'}{schedulerName }</td>
          <td>${'$'}{schedulerInstanceId }</td>
          <td>${'$'}{status }</td>
          <td>${'$'}{runningSince }</td>
          <td>${'$'}{numberOfJobsExecuted }</td>
          <td>${'$'}{threadPoolSize }</td>
          <td>${'$'}{jobStoreSupportsPersistence }</td>
          <td>${'$'}{jobStoreClustered }</td>
          <td>${'$'}{schedulerRemote }</td>
          <td>${'$'}{version }</td>
          <td>
            <div class="btn-toolbar pull-right" role="toolbar">
              <div class="btn-group btn-group-sm">
                <button type="button" class="btn btn-default" title="启动" onclick="execSchedulerCmd('${'$'}{schedulerName}', 'start')"><span class="glyphicon glyphicon-play"></span></button>
                <button type="button" class="btn btn-default" title="暂停" onclick="execSchedulerCmd('${'$'}{schedulerName}', 'standby')"><span class="glyphicon glyphicon-pause"></span></button>
                <button type="button" class="btn btn-default" title="停止" onclick="execSchedulerCmd('${'$'}{schedulerName}', 'stop')"><span class="glyphicon glyphicon-stop"></span></button>
                <button type="button" class="btn btn-default" title="立即停止" onclick="execSchedulerCmd('${'$'}{schedulerName}', 'forceStop')"><span class="glyphicon glyphicon-off"></span></button>
              </div>
            </div>
          </td>
        </tr>
      </script>
    </table>
  </div>
  <div class="row" id="scheduler-detail-panel">
    <ul class="nav nav-tabs" role="tablist">
      <li id="runtime-tab" class="active"><a href="#runtime-tab-content" role="tab" data-toggle="tab" data-id="runtime">运行时</a></li>
      <li id="config-tab"><a href="#config-tab-content" role="tab" data-toggle="tab" data-id="config">配置</a></li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active" id="runtime-tab-content">
        <table class="table table-hover">
          <thead>
            <tr>
              <th>#</th>
              <th>实例ID</th>
              <th>任务组</th>
              <th>任务名称</th>
              <th>计划组</th>
              <th>计划名称</th>
              <th>状态</th>
              <th>开始时间</th>
              <th>结束时间</th>
              <th>时间表达式</th>
              <th>上次执行时间</th>
              <th>下次执行时间</th>
              <th>运行耗时</th>
              <th>重试次数</th>
              <th>可恢复</th>
            </tr>
          </thead>
          <tbody id="currently-executing-job-list-box">
          </tbody>
          <script id="currently-executing-job-list-item-tpl" type="text/x-jquery-tmpl">
            <tr>
              <td>${'$'}{index }</td>
              <td class="wb">${'$'}{fireInstanceId }</td>
              <td class="wb">${'$'}{jobDetailVO.group }</td>
              <td class="wb">${'$'}{jobDetailVO.name }</td>
              <td class="wb">${'$'}{triggerVO.group }</td>
              <td class="wb">${'$'}{triggerVO.name }</td>
              <td>${'$'}{triggerVO.status }</td>
              <td>${'$'}{triggerVO.startTime }</td>
              <td>${'$'}{triggerVO.endTime}</td>
              <td>${'$'}{triggerVO.cronEx }</td>
              <td>${'$'}{triggerVO.previousFireTime }</td>
              <td>${'$'}{triggerVO.nextFireTime }</td>
              <td>${'$'}{jobRunTime }</td>
              <td>${'$'}{refireCount }</td>
              <td>${'$'}{recovering }</td>
            </tr>
          </script>
        </table>
      </div>
      <div class="tab-pane fade" id="config-tab-content">
        <h5>任务列表
          <button type="button" class="btn btn-default btn-xs" title="添加任务" onclick="showEditJobDialog()"><span class="glyphicon glyphicon-plus"></span></button>
        </h5>
        <table class="table table-hover">
          <thead>
            <tr>
              <th>#</th>
              <th>任务组</th>
              <th>任务名称</th>
              <th>任务Java类</th>
              <th>描述</th>
              <th>&nbsp;</th>
            </tr>
          </thead>
          <tbody id="job-list-box">
          </tbody>
          <script id="job-list-item-tpl" type="text/x-jquery-tmpl">
            <tr data-id="${'$'}{group }-_-${'$'}{name }" class="main-row ${'$'}{cssClass}">
              <td>${'$'}{index }</td>
              <td class="wb">${'$'}{group }</td>
              <td class="wb">${'$'}{name }</td>
              <td class="wb">${'$'}{jobClass }</td>
              <td class="wb">${'$'}{description }</td>
              <td>
                <div class="btn-toolbar pull-right" role="toolbar">
                  <div class="btn-group btn-group-sm">
                    <button type="button" class="btn btn-default" title="立即执行任务" onclick="execJobCmd('${'$'}{group }', '${'$'}{name }', 'run')"><span class="glyphicon glyphicon-fire"></span></button>
                    <button type="button" class="btn btn-default" title="启动任务" onclick="execJobCmd('${'$'}{group }', '${'$'}{name }', 'resume')"><span class="glyphicon glyphicon-play"></span></button>
                    <button type="button" class="btn btn-default" title="暂停任务" onclick="execJobCmd('${'$'}{group }', '${'$'}{name }', 'pause')"><span class="glyphicon glyphicon-pause"></span></button>
                    <button type="button" class="btn btn-default" title="编辑任务" onclick="showEditJobDialog('${'$'}{group }', '${'$'}{name }')"><span class="glyphicon glyphicon-pencil"></span></button>
                    <button type="button" class="btn btn-default expand-btn ${'$'}{expandBtnCssClass}" data-id="${'$'}{group }-_-${'$'}{name }" title="查看任务详细"><span class="glyphicon glyphicon-th-large"></span></button>
                    <button type="button" class="btn btn-default" title="删除任务" onclick="execJobCmd('${'$'}{group }', '${'$'}{name }', 'delete')"><span class="glyphicon glyphicon-remove"></span></button>
                  </div>
                </div>
              </td>
            </tr>
            <tr data-id="${'$'}{group }-_-${'$'}{name }" class="expand-row" style="${'$'}{expandRowCssStyle}">
              <td colspan="1">&nbsp;</td>
              <td colspan="5">
                <table class="table table-bordered">
                  <tbody>
                    <tr>
                      <td class="td-label">可恢复</td>
                      <td>${'$'}{shouldRecover }</td>
                      <td class="td-label">持久化</td>
                      <td>${'$'}{durability }</td>
                      <td class="td-label">串行执行</td>
                      <td>${'$'}{concurrentExectionDisallowed }</td>
                      <td class="td-label">可更新数据</td>
                      <td>${'$'}{persistJobDataAfterExecution }</td>
                    </tr>
                    <tr>
                      <td class="td-label">描述</td>
                      <td colspan="7" class="wb">${'$'}{description }</td>
                    </tr>
                    <tr>
                      <td class="td-label">参数(JSON)</td>
                      <td colspan="7" class="wb">${'$'}{jobParams }</td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </script>
        </table>
        <h5>计划列表
          <button type="button" class="btn btn-default btn-xs" title="添加计划" onclick="showEditTriggerDialog()"><span class="glyphicon glyphicon-plus"></span></button>
        </h5>
        <table class="table table-hover">
          <thead>
            <tr>
              <th>#</th>
              <th>计划组</th>
              <th>计划名称</th>
              <th>状态</th>
              <th>时间表达式</th>
              <th>上次执行时间</th>
              <th>下次执行时间</th>
              <th>描述</th>
              <th>&nbsp;</th>
            </tr>
          </thead>
          <tbody id="trigger-list-box">
          </tbody>
          <script id="trigger-list-item-tpl" type="text/x-jquery-tmpl">
            <tr data-id="${'$'}{group }-_-${'$'}{name }" class="main-row ${'$'}{cssClass}">
              <td>${'$'}{index }</td>
              <td class="wb">${'$'}{group }</td>
              <td class="wb">${'$'}{name }</td>
              <td>${'$'}{status }</td>
              <td>${'$'}{cronEx }</td>
              <td>${'$'}{previousFireTime }</td>
              <td>${'$'}{nextFireTime }</td>
              <td class="wb">${'$'}{description }</td>
              <td>
                <div class="btn-toolbar pull-right" role="toolbar">
                  <div class="btn-group btn-group-sm">
                    <button type="button" class="btn btn-default" title="启动计划" onclick="execTriggerCmd('${'$'}{group }', '${'$'}{name }', 'resume')"><span class="glyphicon glyphicon-play"></span></button>
                    <button type="button" class="btn btn-default" title="暂停计划" onclick="execTriggerCmd('${'$'}{group }', '${'$'}{name }', 'pause')"><span class="glyphicon glyphicon-pause"></span></button>
                    <button type="button" class="btn btn-default" title="编辑计划" onclick="showEditTriggerDialog('${'$'}{group }', '${'$'}{name }')"><span class="glyphicon glyphicon-pencil"></span></button>
                    <button type="button" class="btn btn-default expand-btn ${'$'}{expandBtnCssClass}" data-id="${'$'}{group }-_-${'$'}{name }" title="查看计划详细"><span class="glyphicon glyphicon-th-large"></span></button>
                    <button type="button" class="btn btn-default" title="删除计划" onclick="execTriggerCmd('${'$'}{group }', '${'$'}{name }', 'delete')"><span class="glyphicon glyphicon-remove"></span></button>
                  </div>
                </div>
              </td>
            </tr>
            <tr data-id="${'$'}{group }-_-${'$'}{name }" class="expand-row" style="${'$'}{expandRowCssStyle}">
              <td colspan="1">&nbsp;</td>
              <td colspan="8">
                <table class="table table-bordered">
                  <tbody>
                    <tr>
                      <td class="td-label">开始时间</td>
                      <td>${'$'}{startTime }</td>
                      <td class="td-label">结束时间</td>
                      <td>${'$'}{endTime }</td>
                      <td class="td-label">优先级</td>
                      <td>${'$'}{priority }</td>
                      <td class="td-label">mayFireAgain</td>
                      <td>${'$'}{mayFireAgain }</td>
                      <td class="td-label">misfireInstruction</td>
                      <td>${'$'}{misfireInstruction }</td>
                    </tr>
                    <tr>
                      <td class="td-label">描述</td>
                      <td colspan="9" class="wb">${'$'}{description }</td>
                    </tr>
                    <tr>
                      <td class="td-label">参数(JSON)</td>
                      <td colspan="9" class="wb">${'$'}{jobParams }</td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </script>
        </table>
      </div>
    </div>
  </div>
</div>
<script src="<e:url value='/static/lib/bootstrap-3.2.0/js/bootstrap.min.js' />"></script>
<script src="<e:url value='/static/scripts/jquery.bootstrap.min.js' />"></script>
<script src="<e:url value='/static/scripts/jquery.tmpl.min.js' />"></script>
<script src="<e:url value='/static/scripts/jquery.form.min.js' />"></script>
<script src="<e:url value='/static/scripts/bootstrap-dialog.min.js' />"></script>
<script type="text/javascript">
  var SESSION = {
    schedulerName: '${currentScheduler}',
    interval: {
      loadSchedulerListTask: 3000,
      loadCurrentlyExecutingJobListTask: 3000,
      loadJobListTask: 3000,
      loadTriggerListTask: 3000
    }
  };
  
  function ajax(options) {
    $.ajax($.extend({
      dataType: 'json',
      type: 'GET',
      cache: false
    }, options));
  }
  
  function setFormData(form, formData) {
    var form = $(form);
    for (var fieldName in formData) {
      var fieldValue = formData[fieldName];
      form.find('[name="' +fieldName + '"]').each(function(i, field) {
        var f = $(field);
        if (f.is(':radio,:checkbox')) {
          if (f.val() == fieldValue || eval(f.val()) == fieldValue) {
            f.attr('checked', true);
          } else {
            f.attr('checked', false);
          }
        } else {
          f.val(fieldValue);
        }
      });
    }
  }
  
  
  var Timer = {
    tasks: {}
  };
  Timer.start = function(taskId, subTaskId, taskFn, interval, delay) {
    if (typeof subTaskId == 'function') {
      delay = interval;
      interval = taskFn;
      taskFn = subTaskId;
      subTaskId = null;
    }
    
    if (delay) {
      setTimeout(taskFn, delay);
    }
    
    this.stop(taskId, subTaskId);
    if (subTaskId) {
      var subTasks = (this['subTasks-' + taskId] || {});
      subTasks[subTaskId] = setInterval(taskFn, interval);
      
      this['subTasks-' + taskId] = subTasks;
    } else {
      this.tasks[taskId] = setInterval(taskFn, interval);
    }
  };
  Timer.stop = function(taskId, subTaskId) {
    if (subTaskId) {
      var subTasks = this['subTasks-' + taskId], 
        subTask = subTasks ? subTasks[subTaskId] : null;
      if (subTask) {
        clearInterval(subTask);
        delete this['subTasks-' + taskId][subTaskId];
      }
    } else {
      var task = this.tasks[taskId];
      if (task) {
        var subTasks = this['subTasks-' + taskId];
        for (var _subTaskId in subTasks) {
          clearInterval(subTasks[_subTaskId]);
        }
        delete this['subTasks-' + taskId];
        
        clearInterval(task);
        this.tasks = {};
      }
    }
  };
  
  $(function() {
    
    function loadTabPanel(schedulerName, tab) {
      Timer.start('loadTabPanelTask', function() {
        eval('loadTabPanel_' + tab)(schedulerName);
      }, SESSION.interval.loadTabPanelTask, true);
    };
    $('#scheduler-detail-panel .nav-tabs').on('click', 'a', function(e) {
      var schedulerName = SESSION.schedulerName;
      if (schedulerName) {
        var currTab = $(e.currentTarget).attr('data-id');
        SESSION[schedulerName].currTab = currTab;
        
        //loadTabPanel(schedulerName, currTab);
        eval('loadTabPanel_' + currTab)(schedulerName);
      }
    });
    
    
    var schedulerListBox = $('#scheduler-list-box'),
      currentlyExecutingJobListBox = $('#currently-executing-job-list-box'),
      jobListBox = $('#job-list-box'),
      triggerListBox = $('#trigger-list-box');
    
    function loadSchedulerList(callback) {
      ajax({
        url: '<e:url value="${P.CONSOLE_SCHEDULING_GETSCHEDULERMETADATALIST}" />',
        data: {},
        success: function(response) {
          var data = response.result;
          $.each(data, function(index, item) {
            item.index = (index + 1);
          });
          
          var notFind = true;
          if (SESSION.schedulerName) {
            $.each(data, function(index, item) {
              if (item.schedulerName == SESSION.schedulerName) {
                item.cssClass = 'active';
                notFind = false;
                return false;
              }
            });
          }
          if (notFind) {
            SESSION.schedulerName = '';
          }
          
          schedulerListBox.empty();
          $('#scheduler-list-item-tpl').tmpl(data).appendTo(schedulerListBox);
          
          callback && callback();
        },
        error: function(xhr, textStatus, errorThrown) {
          Timer.stop('loadSchedulerListTask');
          Timer.stop('loadTabPanelTask');
        }
      });
    }
    window.execSchedulerCmd = function(schedulerName, cmd) {
      ajax({
        url: '<e:url value="${P.CONSOLE_SCHEDULING_EXECSCHEDULERCMD}" />',
        data: {scheduler: schedulerName, cmd: cmd},
        success: function(response) {
          loadSchedulerList();
        }
      });
      
      return false;
    }
    schedulerListBox.on('click', 'tr', function(e) {
      schedulerListBox.find('tr.active').removeClass('active');
      
      var item = $(e.currentTarget);
      item.addClass('active');
      
      var schedulerName = item.attr('data-id');
      SESSION.schedulerName = schedulerName;
      SESSION[schedulerName] = {
        currTab: 'runtime',
        config: {
          currJob: '',
          expandJobRows: [],
          currTrigger: '',
          expandTriggerRows: []
        }
      };
      
      $('#runtime-tab a[data-id="runtime"]').trigger('click');
    
      return false;
    });
    Timer.start('loadSchedulerListTask', loadSchedulerList, SESSION.interval.loadSchedulerListTask, true);
    
    
    function loadCurrentlyExecutingJobList(schedulerName) {
      ajax({
        url: '<e:url value="${P.CONSOLE_SCHEDULING_GETSCHEDULEREXECUTINGJOBLIST}"/>',
        data: {scheduler: schedulerName},
        success: function(response) {
          var data = response.result;
          $.each(data, function(index, item) {
            item.index = (index + 1);
          });
          
          currentlyExecutingJobListBox.empty();
          $('#currently-executing-job-list-item-tpl').tmpl(data).appendTo(currentlyExecutingJobListBox);
        }
      });
    }
    function loadTabPanel_runtime(schedulerName) {
      Timer.start('loadTabPanelTask', function() {
        loadCurrentlyExecutingJobList(schedulerName);
      }, SESSION.interval.loadCurrentlyExecutingJobListTask, true);
    }
    
    
    function loadJobList(schedulerName) {
      ajax({
        url: '<e:url value="${P.CONSOLE_SCHEDULING_GETSCHEDULERJOBDETAILLIST}"/>',
        data: {scheduler: schedulerName},
        success: function(response) {
          var data = response.result;
          $.each(data, function(index, item) {
            item.index = (index + 1);
          });
          
          var currJob = SESSION[schedulerName].config.currJob;
          if (currJob) {
            var notFind = true;
            $.each(data, function(index, item) {
              if ((item.group + '-_-' + item.name)  == currJob) {
                item.cssClass = 'active';
                notFind = false;
              }
            });
            if (notFind) {
              SESSION[schedulerName].config.currJob = '';
              triggerListBox.empty();
            }
          } else {
            triggerListBox.empty();
          }
          
          var expandRows = SESSION[schedulerName].config.expandJobRows;
          $.each(data, function(index, item) {
            if ((item.group + '-_-' + item.name) in expandRows) {
              item.expandBtnCssClass = 'active';
              item.expandRowCssStyle = 'display:';
            } else {
              item.expandBtnCssClass = '';
              item.expandRowCssStyle = 'display:none';
            }
          });
          
          jobListBox.empty();
          $('#job-list-item-tpl').tmpl(data).appendTo(jobListBox);
        }
      });
    }
    window.execJobCmd = function(jobGroup, jobName, cmd) {
      ajax({
        url: '<e:url value="${P.CONSOLE_SCHEDULING_EXECJOBCMD}"/>',
        data: {scheduler: SESSION.schedulerName, jobGroup: jobGroup, jobName: jobName, cmd: cmd},
        success: function(response) {
          loadJobList(SESSION.schedulerName)
        }
      });
    }
    jobListBox.on('click', 'tr.main-row', function(e) {
      jobListBox.find('tr.active').removeClass('active');
      
      var item = $(e.currentTarget);
      item.addClass('active');
      
      var currJob = item.attr('data-id'),
        currJobArray = currJob.split('-_-');
      SESSION[SESSION.schedulerName].config.currJob = currJob;
      
      Timer.start('loadTabPanelTask', 'loadTriggerListTask', function() {
        loadTriggerList(SESSION.schedulerName, currJobArray[0], currJobArray[1]);
      }, SESSION.interval.loadTriggerListTask, true);
      
      return false;
    });
    jobListBox.on('click', '.expand-btn', function(e) {
      var expandBtn = $(e.currentTarget),
        isExpand = expandBtn.hasClass('active'),
        currJob = expandBtn.attr('data-id'),
        expandRows = SESSION[SESSION.schedulerName].config.expandJobRows,
        expandRowEl = jobListBox.find('.expand-row[data-id="' + currJob + '"]');
        
        if (isExpand) {
          expandBtn.removeClass('active');
          expandRowEl.hide();
          
          delete expandRows[currJob];
        } else {
          expandBtn.addClass('active');
          expandRowEl.show();
          
          if (!expandRows[currJob]) {
            expandRows[currJob] = true;
          }
        }
    });
    window.showEditJobDialog = function(jobGroup, jobName) {
      if (!SESSION.schedulerName) {
        alert('请选择调度器');
        return false;
      }
      
      BootstrapDialog.show({
        title: '编辑任务',
        cssClass: 'pajx-dialog',
        draggable: true,
        message: $('<div />').load('<e:url value="${P.CONSOLE_SCHEDULING_EDITJOB}" />', {scheduler: SESSION.schedulerName, jobGroup: jobGroup, jobName: jobName})
      });
    }
    
    function loadTriggerList(schedulerName, jobGroup, jobName) {
      ajax({
        url: '<e:url value="${P.CONSOLE_SCHEDULING_GETSCHEDULERTRIGGERLIST}" />',
        data: {scheduler: schedulerName, jobGroup: jobGroup, jobName: jobName},
        success: function(response) {
          var data = response.result;
          $.each(data, function(index, item) {
            item.index = (index + 1);
          });
          
          var currTrigger = SESSION[schedulerName].config.currTrigger;
          if (currTrigger) {
            var notFind = true;
            $.each(data, function(index, item) {
              if ((item.group + '-_-' + item.name)  == currTrigger) {
                item.cssClass = 'active';
                notFind = false;
              }
            });
            if (notFind) {
              SESSION[schedulerName].config.currTrigger = '';
            }
          }
          var expandRows = SESSION[schedulerName].config.expandTriggerRows;
          $.each(data, function(index, item) {
            if ((item.group + '-_-' + item.name) in expandRows) {
              item.expandBtnCssClass = 'active';
              item.expandRowCssStyle = 'display:';
            } else {
              item.expandBtnCssClass = '';
              item.expandRowCssStyle = 'display:none';
            }
          });
          
          triggerListBox.empty();
          $('#trigger-list-item-tpl').tmpl(data).appendTo(triggerListBox);
        }
      });
    }
    window.execTriggerCmd = function(triggerGroup, triggerName, cmd) {
      ajax({
        url: '<e:url value="${P.CONSOLE_SCHEDULING_EXECTRIGGERCMD}" />',
        data: {scheduler: SESSION.schedulerName, triggerGroup: triggerGroup, triggerName: triggerName, cmd: cmd},
        success: function(response) {
          var jobIdArray = SESSION[SESSION.schedulerName].config.currJob.split('-_-');
          loadTriggerList(SESSION.schedulerName, jobIdArray[0], jobIdArray[1]);
        }
      });
    }
    triggerListBox.on('click', 'tr.main-row', function(e) {
      triggerListBox.find('tr.active').removeClass('active');
     
      var item = $(e.currentTarget);
      item.addClass('active');
      
      var currTrigger = item.attr('data-id');
      SESSION[SESSION.schedulerName].config.currTrigger = currTrigger;
      
      return false;
    });
    triggerListBox.on('click', '.expand-btn', function(e) {
      var expandBtn = $(e.currentTarget),
        isExpand = expandBtn.hasClass('active'),
        currTrigger = expandBtn.attr('data-id'),
        expandRows = SESSION[SESSION.schedulerName].config.expandTriggerRows,
        expandRowEl = triggerListBox.find('.expand-row[data-id="' + currTrigger + '"]');
        
        if (isExpand) {
          expandBtn.removeClass('active');
          expandRowEl.hide();
          
          delete expandRows[currTrigger];
        } else {
          expandBtn.addClass('active');
          expandRowEl.show();
        
          if (!expandRows[currTrigger]) {
            expandRows[currTrigger] = true;
          }
        }
	});
    window.showEditTriggerDialog = function(triggerGroup, triggerName) {
        if (!SESSION.schedulerName) {
          alert('请选择调度器');
          return false;
        }
        
        var currJob = SESSION[SESSION.schedulerName].config.currJob;
        if (!currJob) {
          alert('请选择任务');
          return false;
        }
        var currJobArray = currJob.split('-_-');
        
        BootstrapDialog.show({
          title: '编辑计划',
          cssClass: 'pajx-dialog',
          draggable: true,
          message: $('<div />').load('<e:url value="${P.CONSOLE_SCHEDULING_EDITTRIGGER}" />', 
            {scheduler: SESSION.schedulerName, jobGroup: currJobArray[0], jobName: currJobArray[1], triggerGroup: triggerGroup, triggerName: triggerName}
          )
        });
      }
    
    function loadTabPanel_config(schedulerName) {
      Timer.start('loadTabPanelTask', function() {
        loadJobList(schedulerName);
      }, SESSION.interval.loadJobListTask, true);
    }
    
    $.messager.model = {
      ok:{ text: '确认', classed: 'btn-primary' },
      cancel: { text: "取消", classed: 'btn-default' }
    };
  });
</script>
</body>
</html>