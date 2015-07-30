/**
author:zhugl
date:2015-05-15
*/
(function($) {
            $(document).ready(function() {
                /**
                set operation type
                */
                $("fieldset.workflow input[type='radio']").on('click',function(){
                    operation = $(this).val();
                    next = "approve/"+operation;
                    $("#workflow_approve").attr("href",next);
                });
                try{
                    $("div.inline-group table tbody tr.form-row").removeClass('has_original');
                    $("div.inline-group table tbody tr.form-row td:first-child").find('p').hide();
                }catch(e){

                }
            });
})(django.jQuery);