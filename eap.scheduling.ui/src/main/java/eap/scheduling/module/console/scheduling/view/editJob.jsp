<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@include file="/WEB-INF/views/common/jsp-header.jsp"%>
<form id="editJobForm" action="<e:url value='${P.CONSOLE_SCHEDULING_ADDJOB }' />" method="post" autocomplete="off" class="form-horizontal pajx-dialog-body">
  <input type="hidden" name="scheduler">
  <div class="form-group">
    <label for="group" class="col-sm-3 control-label">任务组</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="group" name="group">
    </div>
  </div>
  <div class="form-group">
    <label for="name" class="col-sm-3 control-label">任务名称</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="name" name="name">
    </div>
  </div>
  <div class="form-group">
    <label for="jobClass" class="col-sm-3 control-label">任务Java类</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="jobClass" name="jobClass">
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-3 control-label">任务配置</label>
    <div class="col-sm-9 checkbox">
      <label>
        <input type="checkbox" id="shouldRecover" name="shouldRecover" value="true">可恢复
      </label>
      <label>
        <input type="checkbox" id="durability" name="durability" value="true">持久化
      </label>
      <label>
        <input type="checkbox" id="concurrentExectionDisallowed" name="concurrentExectionDisallowed" value="true">串行执行
      </label>
      <label>
        <input type="checkbox" id="persistJobDataAfterExecution" name="persistJobDataAfterExecution" value="true">可更新数据
      </label>
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
  <button id="editJobForm-cannelBtn" type="button" class="btn btn-default">取消</button>
  <button id="editJobForm-saveBtn" type="button" class="btn btn-default">保存</button>
</div>
<script type="text/javascript">
  var scheduler = '${scheduler}', jobGroup = '${jobGroup}', jobName = '${jobName}';
  
  $(function() {
    var editJobForm = $('#editJobForm');
    editJobForm.ajaxForm({
      success: function(data, status, xhr, f) {
        var result = data.result;
        if (result == true) {
          closeEditJobFormDialog();
        } else {
          alert(result);
        }
      }
    });
    
    function closeEditJobFormDialog() {
      var dialogId = editJobForm.parents('[role="dialog"]').attr('id');
      if (dialogId) {
        var dialog = BootstrapDialog.dialogs[dialogId];
        dialog && dialog.close();
      }
    }
    
    $('#editJobForm-cannelBtn').on('click', function(e) {
      closeEditJobFormDialog();
    });
    $('#editJobForm-saveBtn').on('click', function(e) {
      editJobForm.submit();
    });
    
    if (jobName && jobGroup) {
      $('#group').attr('readonly', 'true');
      $('#name').attr('readonly', 'true');
      ajax({
        url: '<e:url value="${P.CONSOLE_SCHEDULING_GETJOBDETAIL}" />', 
        data: {scheduler: scheduler, jobName: jobName, jobGroup: jobGroup}, 
        success: function(response) {
          var formData = response.result || {};
          formData = $.extend({scheduler: scheduler}, formData);
          setFormData(editJobForm, formData);
        }
      });
    } else {
      setFormData(editJobForm, {scheduler: scheduler, group: 'DEFAULT', shouldRecover: 'true', durability: 'true', jobParams: '{}'});
    }
  });
</script>