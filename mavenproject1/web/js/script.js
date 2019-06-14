// TODO: define urls 2019-06-13 19:14:32
// urlmedidores


$( document ).ready(function() {
    $('#selectMedida').empty();
    $.post({
        url: "#urlmedidores",
        data: { "medidores": "medidores" },
        success: function(data){
            var options = $.parseJSON(data);
            $.each(options, function(i, d) {
                $('#selectMedida').append('<option value="' + d.value + '">' + d.name + '</option>');
            });
        }
    });

    $("botaoLer").click(function (e) { 
        e.preventDefault();
        var medidor = $("#selectMedida").children("option:selected")[0].value;
        var periodo = $("#selectPeriodo").children("option:selected")[0].value;
        var datafinal = $("#start").children("option:selected")[0].value;
        var tabela = $("#selectTabela").children("option:selected")[0].value;
        $.post({
            url: "#urlmedidores",
            data: {
                "medidor": medidor,
                "periodo": periodo,
                "datafinal": datafinal,
                "tabela": tabela
            },
            success: function(data){
                var options = $.parseJSON(data);
                $.each(options, function(i, d) {
                    // TODO: fix this, most likely 2019-06-13 21:52:49
                    $('#tabelaMedidas').append("<tr><td>" + d + "</td></tr>");
                });
            }
        });
    });

    // TODO: lista de sensores 2019-06-13 21:53:16
    $('#selectMedida').empty();
    $.post({
        url: "#urlmedidores",
        data: { "medidores": "medidores" },
        success: function(data){
            var options = $.parseJSON(data);
            $.each(options, function(i, d) {
                $('#selectMedida').append('<option value="' + d.value + '">' + d.name + '</option>');
            });
        }
    });

    // TODO: gráfico 2019-06-13 21:53:30
    $('#selectMedida').empty();
    $.post({
        url: "#urlmedidores",
        data: { "medidores": "medidores" },
        success: function(data){
            var options = $.parseJSON(data);
            $.each(options, function(i, d) {
                $('#selectMedida').append('<option value="' + d.value + '">' + d.name + '</option>');
            });
        }
    });





});