<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/views/common/jsp-header.jsp"%>
<form id="editTriggerForm" action="<e:url value='${P.CONSOLE_SCHEDULING_ADDTRIGGER }' />" method="post" autocomplete="off" class="form-horizontal pajx-dialog-body">
  <input type="hidden" name="scheduler">
  <div class="form-group">
    <label for="jobGroup" class="col-sm-3 control-label">任务组</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="jobGroup" name="jobGroup" readonly>
    </div>
  </div>
  <div class="form-group">
    <label for="jobName" class="col-sm-3 control-label">任务名称</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="jobName" name="jobName" readonly>
    </div>
  </div>
  <div class="form-group">
    <label for="group" class="col-sm-3 control-label">计划组</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="group" name="group">
    </div>
  </div>
  <div class="form-group">
    <label for="name" class="col-sm-3 control-label">计划名称</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="name" name="name">
    </div>
  </div>
  <div class="form-group">
    <label for="cronEx" class="col-sm-3 control-label">时间表达式</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="cronEx" name="cronEx">
    </div>
  </div>
  <div class="form-group">
    <label for="startTime" class="col-sm-3 control-label">开始时间</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="startTime" name="startTime" placeholder="yyyy-MM-dd HH:mm:ss">
    </div>
  </div>
  <div class="form-group">
    <label for="endTime" class="col-sm-3 control-label">结束时间</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="endTime" name="endTime" placeholder="yyyy-MM-dd HH:mm:ss">
    </div>
  </div>
  <div class="form-group">
    <label for="priority" class="col-sm-3 control-label">优先级</label>
    <div class="col-sm-9">
      <select class="form-control" id="priority" name="priority">
        <option value="1">1(低)</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5(中)</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
        <option value="9">9</option>
        <option value="10">10(高)</option>
      </select>
    </div>
  </div>
  <div class="form-group">
    <label for="misfireInstruction" class="col-sm-3 control-label">MisfireInstruction</label>
    <div class="col-sm-9">
      <select class="form-control" id="misfireInstruction" name="misfireInstruction">
        <option value="-1">-1:IGNORE_MISFIRE_POLICY</option>
        <option value="0">0:SMART_POLICY</option>
        <option value="1">1:FIRE_ONCE_NOW</option>
        <option value="2">2:DO_NOTHING</option>
      </select>
    </div>
  </div>
  <div class="form-group">
    <label for="description" class="col-sm-3 control-label">描述</label>
    <div class="col-sm-9">
      <textarea rows="5" class="form-control" id="description" name="description"></textarea>
    </div>
  </div>
  <div class="form-group">
    <label for="jobParams" class="col-sm-3 control-label">参数(JSON)</label>
    <div class="col-sm-9">
      <textarea rows="5" class="form-control" id="jobParams" name="jobParams"></textarea>
    </div>
  </div>
</form>
<div class="pajx-dialog-footer">
  <button id="editTriggerForm-cannelBtn" type="button" class="btn btn-default">取消</button>
  <button id="editTriggerForm-saveBtn" type="button" class="btn btn-default">保存</button>
</div>
<script type="text/javascript">
  var scheduler = '${scheduler}', jobGroup = '${jobGroup}', jobName = '${jobName}', triggerGroup = '${triggerGroup}', triggerName = '${triggerName}';
  
  $(function() {
    var editTriggerForm = $('#editTriggerForm');
    editTriggerForm.ajaxForm({
      success: function(data, status, xhr, f) {
        var result = data.result;
        if (result == true) {
          closeEditTriggerFormDialog();
        } else {
          alert(result);
        }
      }
    });
    
    function closeEditTriggerFormDialog() {
      var dialogId = editTriggerForm.parents('[role="dialog"]').attr('id');
      if (dialogId) {
        var dialog = BootstrapDialog.dialogs[dialogId];
        dialog && dialog.close();
      }
    }
    
    $('#editTriggerForm-cannelBtn').on('click', function(e) {
    	closeEditTriggerFormDialog();
    });
    $('#editTriggerForm-saveBtn').on('click', function(e) {
      editTriggerForm.submit();
    });
    
    if (triggerGroup && triggerName) {
      $('#group').attr('readonly', 'true');
      $('#name').attr('readonly', 'true');
      ajax({
        url: '<e:url value="${P.CONSOLE_SCHEDULING_GETTRIGGER}" />', 
        data: {scheduler: scheduler, jobGroup: jobGroup, jobName: jobName, triggerGroup: triggerGroup, triggerName: triggerName}, 
        success: function(response) {
          var formData = response.result || {};
          formData = $.extend({scheduler: scheduler, jobGroup: jobGroup, jobName: jobName}, formData);
          setFormData(editTriggerForm, formData);
        }
      });
    } else {
      setFormData(editTriggerForm, {scheduler: scheduler, jobGroup: jobGroup, jobName: jobName, group: 'DEFAULT', priority: '5', misfireInstruction: '0', jobParams: '{}'});
    }
  });
</script>