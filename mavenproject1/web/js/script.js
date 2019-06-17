// TODO: define urls 2019-06-13 19:14:32
// /mavenproject1/Ajax
var $ = jQuery;

$( document ).ready(function() {
    // $.post({
    //     url: "/mavenproject1/Ajax",
    //     data: { "medidores": "medidores" },
    //     success: function(data){
    //         $('#selectMedida').empty();
    //         var options = $.parseJSON(data);
    //         $.each(options, function(i, data) {
    //             $('#selectMedida').append('<option value="' + data.value + '">' + data.name + '</option>');
    //         });
    //     }
    // });

    $("#botaoLer").click(function (e) { 
        e.preventDefault();
        var medidor = $("#selectMedida").children("option:selected")[0].value;
        var periodo = $("#selectPeriodo").children("option:selected")[0].value;
        var datafinal = $("#start")[0].value;
        // var tabela = $("#selectTabela")[0].value;
        $.post({
            url: "/mavenproject1/Ajax",
            data: {
                "medidor": medidor,
                "periodo": periodo,
                "datafinal": datafinal,
                // "tabela": tabela
            },
            success: function(data){
                $('#tabelaMedidas tbody').remove();
                $.each(data, function(i, data) {
                    // TODO: fix this, most likely 2019-06-13 21:52:49
                    $('#tabelaMedidas').append("<tbody><tr><td>" + data["medidor"] + "</td><td>" +  + data["temperatura"] + "</td><td>" + data["umidade"] + "</td><td>" + data["datahora"] + "</td><td>" + data["serial"] + "</td></tr></tbody>");
                });
            }
        });
    });

    // TODO: lista de sensores 2019-06-13 21:53:16
    // $.post({
    //     url: "/mavenproject1/Ajax",
    //     data: { "medidores": "medidores" },
    //     success: function(data){
    //         var options = $.parseJSON(data);
    //         $.each(options, function(i, data) {
    //             $('#selectMedida').append('<option value="' + data.value + '">' + data.name + '</option>');
    //         });
    //     }
    // });

    // TODO: gráfico 2019-06-13 21:53:30
    // $.post({
    //     url: "/mavenproject1/Ajax",
    //     data: { "medidores": "medidores" },
    //     success: function(data){
    //         var options = $.parseJSON(data);
    //         $.each(options, function(i, data) {
    //             $('#selectMedida').append('<option value="' + data.value + '">' + data.name + '</option>');
    //         });
    //     }
    // });





});