var $ = jQuery;

$( document ).ready(function() {
    $.post({
        url: "/mavenproject1/Ajax",
        data: { "medidores": "medidores" },
        success: function(data) {
            if ($('#selectMedida')) {
                $('#selectMedida').empty();
                $.each(data, function(i, data) {
                    $('#selectMedida').append('<option value="' + data["tabela"] + '">' + data["nome"] + '</option>');
                });
            } else {
                $('#tabelaMedidores tbody').remove();
                $.each(data, function(i, data) {
                    $('#tabelaMedidores').append("<tbody><tr><td>" + data["serialno_medidores"] + "</td><td>" +  data["nome"] +
                    "</td><td>" + data["tabela"] + "</td><td>" + '<form action="/mavenproject1/requestcontroller" method="post">' +
                    '<input type="hidden" value="' + data["serialno_medidores"] + " id=" + i + '_serial" name="serialno_medidores" />' +
                    '<input type="hidden" value="' + data["nome"] + ' id="' + i + '_nome" name="nome" />' +
                    '<input type="hidden" value="' + data["tabela"] + '" id="' + i + '" name="tabela" />' +
                    '<input type="hidden" value="edit" name="operation" />' + '<button class="btn btn-success fas fa-check-circle"></button>' +
                    '<script>' +
                        'document.getElementById("' + i + '_serial_editavel").addEventListener("keyup", function() {' +
                            'document.getElementById("' + i + '_serial").value = document.getElementById("' +
                            i + '_serial_editavel").innerHTML;});' +
                        'document.getElementById("' + i + '_nome_editavel").addEventListener("keyup", function() {' +
                            'document.getElementById("' + i + '_nome").value = document.getElementById("' + i + '_nome_editavel").innerHTML;});' +
                    '</script></form></td><td><form action="/mavenproject1/requestcontroller" method="post">' +
                    '<input type="hidden" value="' + data["tabela"] + '" name="tabela" />' +
                    '<input type="hidden" value="delete" name="operation" /><button class="btn btn-danger fas fa-times-circle" ></button>' +
                    '</form></td></tr></tbody>');
                });
            }
        }
    });

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
                    $('#tabelaMedidas').append("<tbody><tr><td>" + data["medidor"] + "</td><td>" +  + data["temperatura"] + "</td><td>" + data["umidade"] + "</td><td>" + data["datahora"] + "</td><td>" + data["serial"] + "</td></tr></tbody>");
                });
            }
        });
    });


    // TODO: gráfico 2019-06-13 21:53:30
    // $.post({
    //     url: "/mavenproject1/Ajax",
    //     data: { "medidores": "medidores" },
    //     success: function(data){
    //         $.each(options, function(i, data) {
    //             $('#selectMedida').append('<option value="' + data.value + '">' + data.name + '</option>');
    //         });
    //     }
    // });

});