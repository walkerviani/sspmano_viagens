// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ExcursoesTable extends Excursoes
    with TableInfo<$ExcursoesTable, ExcursaoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExcursoesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataHoraMeta = const VerificationMeta(
    'dataHora',
  );
  @override
  late final GeneratedColumn<DateTime> dataHora = GeneratedColumn<DateTime>(
    'data_hora',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtdAssentosMeta = const VerificationMeta(
    'qtdAssentos',
  );
  @override
  late final GeneratedColumn<int> qtdAssentos = GeneratedColumn<int>(
    'qtd_assentos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idStatusMeta = const VerificationMeta(
    'idStatus',
  );
  @override
  late final GeneratedColumn<int> idStatus = GeneratedColumn<int>(
    'id_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nome,
    dataHora,
    qtdAssentos,
    idStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'excursoes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExcursaoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('data_hora')) {
      context.handle(
        _dataHoraMeta,
        dataHora.isAcceptableOrUnknown(data['data_hora']!, _dataHoraMeta),
      );
    } else if (isInserting) {
      context.missing(_dataHoraMeta);
    }
    if (data.containsKey('qtd_assentos')) {
      context.handle(
        _qtdAssentosMeta,
        qtdAssentos.isAcceptableOrUnknown(
          data['qtd_assentos']!,
          _qtdAssentosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_qtdAssentosMeta);
    }
    if (data.containsKey('id_status')) {
      context.handle(
        _idStatusMeta,
        idStatus.isAcceptableOrUnknown(data['id_status']!, _idStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_idStatusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExcursaoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExcursaoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      dataHora: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_hora'],
      )!,
      qtdAssentos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qtd_assentos'],
      )!,
      idStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_status'],
      )!,
    );
  }

  @override
  $ExcursoesTable createAlias(String alias) {
    return $ExcursoesTable(attachedDatabase, alias);
  }
}

class ExcursaoData extends DataClass implements Insertable<ExcursaoData> {
  final int id;
  final String nome;
  final DateTime dataHora;
  final int qtdAssentos;
  final int idStatus;
  const ExcursaoData({
    required this.id,
    required this.nome,
    required this.dataHora,
    required this.qtdAssentos,
    required this.idStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['data_hora'] = Variable<DateTime>(dataHora);
    map['qtd_assentos'] = Variable<int>(qtdAssentos);
    map['id_status'] = Variable<int>(idStatus);
    return map;
  }

  ExcursoesCompanion toCompanion(bool nullToAbsent) {
    return ExcursoesCompanion(
      id: Value(id),
      nome: Value(nome),
      dataHora: Value(dataHora),
      qtdAssentos: Value(qtdAssentos),
      idStatus: Value(idStatus),
    );
  }

  factory ExcursaoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExcursaoData(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      dataHora: serializer.fromJson<DateTime>(json['dataHora']),
      qtdAssentos: serializer.fromJson<int>(json['qtdAssentos']),
      idStatus: serializer.fromJson<int>(json['idStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'dataHora': serializer.toJson<DateTime>(dataHora),
      'qtdAssentos': serializer.toJson<int>(qtdAssentos),
      'idStatus': serializer.toJson<int>(idStatus),
    };
  }

  ExcursaoData copyWith({
    int? id,
    String? nome,
    DateTime? dataHora,
    int? qtdAssentos,
    int? idStatus,
  }) => ExcursaoData(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    dataHora: dataHora ?? this.dataHora,
    qtdAssentos: qtdAssentos ?? this.qtdAssentos,
    idStatus: idStatus ?? this.idStatus,
  );
  ExcursaoData copyWithCompanion(ExcursoesCompanion data) {
    return ExcursaoData(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      dataHora: data.dataHora.present ? data.dataHora.value : this.dataHora,
      qtdAssentos: data.qtdAssentos.present
          ? data.qtdAssentos.value
          : this.qtdAssentos,
      idStatus: data.idStatus.present ? data.idStatus.value : this.idStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExcursaoData(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('dataHora: $dataHora, ')
          ..write('qtdAssentos: $qtdAssentos, ')
          ..write('idStatus: $idStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, dataHora, qtdAssentos, idStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExcursaoData &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.dataHora == this.dataHora &&
          other.qtdAssentos == this.qtdAssentos &&
          other.idStatus == this.idStatus);
}

class ExcursoesCompanion extends UpdateCompanion<ExcursaoData> {
  final Value<int> id;
  final Value<String> nome;
  final Value<DateTime> dataHora;
  final Value<int> qtdAssentos;
  final Value<int> idStatus;
  const ExcursoesCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.dataHora = const Value.absent(),
    this.qtdAssentos = const Value.absent(),
    this.idStatus = const Value.absent(),
  });
  ExcursoesCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required DateTime dataHora,
    required int qtdAssentos,
    required int idStatus,
  }) : nome = Value(nome),
       dataHora = Value(dataHora),
       qtdAssentos = Value(qtdAssentos),
       idStatus = Value(idStatus);
  static Insertable<ExcursaoData> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<DateTime>? dataHora,
    Expression<int>? qtdAssentos,
    Expression<int>? idStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (dataHora != null) 'data_hora': dataHora,
      if (qtdAssentos != null) 'qtd_assentos': qtdAssentos,
      if (idStatus != null) 'id_status': idStatus,
    });
  }

  ExcursoesCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<DateTime>? dataHora,
    Value<int>? qtdAssentos,
    Value<int>? idStatus,
  }) {
    return ExcursoesCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      dataHora: dataHora ?? this.dataHora,
      qtdAssentos: qtdAssentos ?? this.qtdAssentos,
      idStatus: idStatus ?? this.idStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (dataHora.present) {
      map['data_hora'] = Variable<DateTime>(dataHora.value);
    }
    if (qtdAssentos.present) {
      map['qtd_assentos'] = Variable<int>(qtdAssentos.value);
    }
    if (idStatus.present) {
      map['id_status'] = Variable<int>(idStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExcursoesCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('dataHora: $dataHora, ')
          ..write('qtdAssentos: $qtdAssentos, ')
          ..write('idStatus: $idStatus')
          ..write(')'))
        .toString();
  }
}

class $PessoasTable extends Pessoas with TableInfo<$PessoasTable, PessoaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PessoasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _cpfMeta = const VerificationMeta('cpf');
  @override
  late final GeneratedColumn<String> cpf = GeneratedColumn<String>(
    'cpf',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _telefoneMeta = const VerificationMeta(
    'telefone',
  );
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
    'telefone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nome, cpf, telefone];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pessoas';
  @override
  VerificationContext validateIntegrity(
    Insertable<PessoaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('cpf')) {
      context.handle(
        _cpfMeta,
        cpf.isAcceptableOrUnknown(data['cpf']!, _cpfMeta),
      );
    } else if (isInserting) {
      context.missing(_cpfMeta);
    }
    if (data.containsKey('telefone')) {
      context.handle(
        _telefoneMeta,
        telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta),
      );
    } else if (isInserting) {
      context.missing(_telefoneMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PessoaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PessoaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      cpf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cpf'],
      )!,
      telefone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefone'],
      )!,
    );
  }

  @override
  $PessoasTable createAlias(String alias) {
    return $PessoasTable(attachedDatabase, alias);
  }
}

class PessoaData extends DataClass implements Insertable<PessoaData> {
  final int id;
  final String nome;
  final String cpf;
  final String telefone;
  const PessoaData({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.telefone,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['cpf'] = Variable<String>(cpf);
    map['telefone'] = Variable<String>(telefone);
    return map;
  }

  PessoasCompanion toCompanion(bool nullToAbsent) {
    return PessoasCompanion(
      id: Value(id),
      nome: Value(nome),
      cpf: Value(cpf),
      telefone: Value(telefone),
    );
  }

  factory PessoaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PessoaData(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      cpf: serializer.fromJson<String>(json['cpf']),
      telefone: serializer.fromJson<String>(json['telefone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'cpf': serializer.toJson<String>(cpf),
      'telefone': serializer.toJson<String>(telefone),
    };
  }

  PessoaData copyWith({int? id, String? nome, String? cpf, String? telefone}) =>
      PessoaData(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        cpf: cpf ?? this.cpf,
        telefone: telefone ?? this.telefone,
      );
  PessoaData copyWithCompanion(PessoasCompanion data) {
    return PessoaData(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      cpf: data.cpf.present ? data.cpf.value : this.cpf,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PessoaData(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('cpf: $cpf, ')
          ..write('telefone: $telefone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, cpf, telefone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PessoaData &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.cpf == this.cpf &&
          other.telefone == this.telefone);
}

class PessoasCompanion extends UpdateCompanion<PessoaData> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> cpf;
  final Value<String> telefone;
  const PessoasCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.cpf = const Value.absent(),
    this.telefone = const Value.absent(),
  });
  PessoasCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String cpf,
    required String telefone,
  }) : nome = Value(nome),
       cpf = Value(cpf),
       telefone = Value(telefone);
  static Insertable<PessoaData> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? cpf,
    Expression<String>? telefone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (cpf != null) 'cpf': cpf,
      if (telefone != null) 'telefone': telefone,
    });
  }

  PessoasCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<String>? cpf,
    Value<String>? telefone,
  }) {
    return PessoasCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      telefone: telefone ?? this.telefone,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (cpf.present) {
      map['cpf'] = Variable<String>(cpf.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PessoasCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('cpf: $cpf, ')
          ..write('telefone: $telefone')
          ..write(')'))
        .toString();
  }
}

class $PassageirosTable extends Passageiros
    with TableInfo<$PassageirosTable, PassageiroData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PassageirosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idExcursaoMeta = const VerificationMeta(
    'idExcursao',
  );
  @override
  late final GeneratedColumn<int> idExcursao = GeneratedColumn<int>(
    'id_excursao',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES excursoes (id)',
    ),
  );
  static const VerificationMeta _idPessoaMeta = const VerificationMeta(
    'idPessoa',
  );
  @override
  late final GeneratedColumn<int> idPessoa = GeneratedColumn<int>(
    'id_pessoa',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pessoas (id)',
    ),
  );
  static const VerificationMeta _numeroAssentoMeta = const VerificationMeta(
    'numeroAssento',
  );
  @override
  late final GeneratedColumn<int> numeroAssento = GeneratedColumn<int>(
    'numero_assento',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idStatusAssentoMeta = const VerificationMeta(
    'idStatusAssento',
  );
  @override
  late final GeneratedColumn<int> idStatusAssento = GeneratedColumn<int>(
    'id_status_assento',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foiPagoMeta = const VerificationMeta(
    'foiPago',
  );
  @override
  late final GeneratedColumn<bool> foiPago = GeneratedColumn<bool>(
    'foi_pago',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("foi_pago" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idExcursao,
    idPessoa,
    numeroAssento,
    idStatusAssento,
    foiPago,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'passageiros';
  @override
  VerificationContext validateIntegrity(
    Insertable<PassageiroData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_excursao')) {
      context.handle(
        _idExcursaoMeta,
        idExcursao.isAcceptableOrUnknown(data['id_excursao']!, _idExcursaoMeta),
      );
    } else if (isInserting) {
      context.missing(_idExcursaoMeta);
    }
    if (data.containsKey('id_pessoa')) {
      context.handle(
        _idPessoaMeta,
        idPessoa.isAcceptableOrUnknown(data['id_pessoa']!, _idPessoaMeta),
      );
    }
    if (data.containsKey('numero_assento')) {
      context.handle(
        _numeroAssentoMeta,
        numeroAssento.isAcceptableOrUnknown(
          data['numero_assento']!,
          _numeroAssentoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numeroAssentoMeta);
    }
    if (data.containsKey('id_status_assento')) {
      context.handle(
        _idStatusAssentoMeta,
        idStatusAssento.isAcceptableOrUnknown(
          data['id_status_assento']!,
          _idStatusAssentoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idStatusAssentoMeta);
    }
    if (data.containsKey('foi_pago')) {
      context.handle(
        _foiPagoMeta,
        foiPago.isAcceptableOrUnknown(data['foi_pago']!, _foiPagoMeta),
      );
    } else if (isInserting) {
      context.missing(_foiPagoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PassageiroData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PassageiroData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idExcursao: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_excursao'],
      )!,
      idPessoa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_pessoa'],
      ),
      numeroAssento: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero_assento'],
      )!,
      idStatusAssento: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_status_assento'],
      )!,
      foiPago: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}foi_pago'],
      )!,
    );
  }

  @override
  $PassageirosTable createAlias(String alias) {
    return $PassageirosTable(attachedDatabase, alias);
  }
}

class PassageiroData extends DataClass implements Insertable<PassageiroData> {
  final int id;
  final int idExcursao;
  final int? idPessoa;
  final int numeroAssento;
  final int idStatusAssento;
  final bool foiPago;
  const PassageiroData({
    required this.id,
    required this.idExcursao,
    this.idPessoa,
    required this.numeroAssento,
    required this.idStatusAssento,
    required this.foiPago,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_excursao'] = Variable<int>(idExcursao);
    if (!nullToAbsent || idPessoa != null) {
      map['id_pessoa'] = Variable<int>(idPessoa);
    }
    map['numero_assento'] = Variable<int>(numeroAssento);
    map['id_status_assento'] = Variable<int>(idStatusAssento);
    map['foi_pago'] = Variable<bool>(foiPago);
    return map;
  }

  PassageirosCompanion toCompanion(bool nullToAbsent) {
    return PassageirosCompanion(
      id: Value(id),
      idExcursao: Value(idExcursao),
      idPessoa: idPessoa == null && nullToAbsent
          ? const Value.absent()
          : Value(idPessoa),
      numeroAssento: Value(numeroAssento),
      idStatusAssento: Value(idStatusAssento),
      foiPago: Value(foiPago),
    );
  }

  factory PassageiroData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PassageiroData(
      id: serializer.fromJson<int>(json['id']),
      idExcursao: serializer.fromJson<int>(json['idExcursao']),
      idPessoa: serializer.fromJson<int?>(json['idPessoa']),
      numeroAssento: serializer.fromJson<int>(json['numeroAssento']),
      idStatusAssento: serializer.fromJson<int>(json['idStatusAssento']),
      foiPago: serializer.fromJson<bool>(json['foiPago']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idExcursao': serializer.toJson<int>(idExcursao),
      'idPessoa': serializer.toJson<int?>(idPessoa),
      'numeroAssento': serializer.toJson<int>(numeroAssento),
      'idStatusAssento': serializer.toJson<int>(idStatusAssento),
      'foiPago': serializer.toJson<bool>(foiPago),
    };
  }

  PassageiroData copyWith({
    int? id,
    int? idExcursao,
    Value<int?> idPessoa = const Value.absent(),
    int? numeroAssento,
    int? idStatusAssento,
    bool? foiPago,
  }) => PassageiroData(
    id: id ?? this.id,
    idExcursao: idExcursao ?? this.idExcursao,
    idPessoa: idPessoa.present ? idPessoa.value : this.idPessoa,
    numeroAssento: numeroAssento ?? this.numeroAssento,
    idStatusAssento: idStatusAssento ?? this.idStatusAssento,
    foiPago: foiPago ?? this.foiPago,
  );
  PassageiroData copyWithCompanion(PassageirosCompanion data) {
    return PassageiroData(
      id: data.id.present ? data.id.value : this.id,
      idExcursao: data.idExcursao.present
          ? data.idExcursao.value
          : this.idExcursao,
      idPessoa: data.idPessoa.present ? data.idPessoa.value : this.idPessoa,
      numeroAssento: data.numeroAssento.present
          ? data.numeroAssento.value
          : this.numeroAssento,
      idStatusAssento: data.idStatusAssento.present
          ? data.idStatusAssento.value
          : this.idStatusAssento,
      foiPago: data.foiPago.present ? data.foiPago.value : this.foiPago,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PassageiroData(')
          ..write('id: $id, ')
          ..write('idExcursao: $idExcursao, ')
          ..write('idPessoa: $idPessoa, ')
          ..write('numeroAssento: $numeroAssento, ')
          ..write('idStatusAssento: $idStatusAssento, ')
          ..write('foiPago: $foiPago')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    idExcursao,
    idPessoa,
    numeroAssento,
    idStatusAssento,
    foiPago,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PassageiroData &&
          other.id == this.id &&
          other.idExcursao == this.idExcursao &&
          other.idPessoa == this.idPessoa &&
          other.numeroAssento == this.numeroAssento &&
          other.idStatusAssento == this.idStatusAssento &&
          other.foiPago == this.foiPago);
}

class PassageirosCompanion extends UpdateCompanion<PassageiroData> {
  final Value<int> id;
  final Value<int> idExcursao;
  final Value<int?> idPessoa;
  final Value<int> numeroAssento;
  final Value<int> idStatusAssento;
  final Value<bool> foiPago;
  const PassageirosCompanion({
    this.id = const Value.absent(),
    this.idExcursao = const Value.absent(),
    this.idPessoa = const Value.absent(),
    this.numeroAssento = const Value.absent(),
    this.idStatusAssento = const Value.absent(),
    this.foiPago = const Value.absent(),
  });
  PassageirosCompanion.insert({
    this.id = const Value.absent(),
    required int idExcursao,
    this.idPessoa = const Value.absent(),
    required int numeroAssento,
    required int idStatusAssento,
    required bool foiPago,
  }) : idExcursao = Value(idExcursao),
       numeroAssento = Value(numeroAssento),
       idStatusAssento = Value(idStatusAssento),
       foiPago = Value(foiPago);
  static Insertable<PassageiroData> custom({
    Expression<int>? id,
    Expression<int>? idExcursao,
    Expression<int>? idPessoa,
    Expression<int>? numeroAssento,
    Expression<int>? idStatusAssento,
    Expression<bool>? foiPago,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idExcursao != null) 'id_excursao': idExcursao,
      if (idPessoa != null) 'id_pessoa': idPessoa,
      if (numeroAssento != null) 'numero_assento': numeroAssento,
      if (idStatusAssento != null) 'id_status_assento': idStatusAssento,
      if (foiPago != null) 'foi_pago': foiPago,
    });
  }

  PassageirosCompanion copyWith({
    Value<int>? id,
    Value<int>? idExcursao,
    Value<int?>? idPessoa,
    Value<int>? numeroAssento,
    Value<int>? idStatusAssento,
    Value<bool>? foiPago,
  }) {
    return PassageirosCompanion(
      id: id ?? this.id,
      idExcursao: idExcursao ?? this.idExcursao,
      idPessoa: idPessoa ?? this.idPessoa,
      numeroAssento: numeroAssento ?? this.numeroAssento,
      idStatusAssento: idStatusAssento ?? this.idStatusAssento,
      foiPago: foiPago ?? this.foiPago,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idExcursao.present) {
      map['id_excursao'] = Variable<int>(idExcursao.value);
    }
    if (idPessoa.present) {
      map['id_pessoa'] = Variable<int>(idPessoa.value);
    }
    if (numeroAssento.present) {
      map['numero_assento'] = Variable<int>(numeroAssento.value);
    }
    if (idStatusAssento.present) {
      map['id_status_assento'] = Variable<int>(idStatusAssento.value);
    }
    if (foiPago.present) {
      map['foi_pago'] = Variable<bool>(foiPago.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PassageirosCompanion(')
          ..write('id: $id, ')
          ..write('idExcursao: $idExcursao, ')
          ..write('idPessoa: $idPessoa, ')
          ..write('numeroAssento: $numeroAssento, ')
          ..write('idStatusAssento: $idStatusAssento, ')
          ..write('foiPago: $foiPago')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExcursoesTable excursoes = $ExcursoesTable(this);
  late final $PessoasTable pessoas = $PessoasTable(this);
  late final $PassageirosTable passageiros = $PassageirosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    excursoes,
    pessoas,
    passageiros,
  ];
}

typedef $$ExcursoesTableCreateCompanionBuilder =
    ExcursoesCompanion Function({
      Value<int> id,
      required String nome,
      required DateTime dataHora,
      required int qtdAssentos,
      required int idStatus,
    });
typedef $$ExcursoesTableUpdateCompanionBuilder =
    ExcursoesCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<DateTime> dataHora,
      Value<int> qtdAssentos,
      Value<int> idStatus,
    });

final class $$ExcursoesTableReferences
    extends BaseReferences<_$AppDatabase, $ExcursoesTable, ExcursaoData> {
  $$ExcursoesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PassageirosTable, List<PassageiroData>>
  _passageirosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.passageiros,
    aliasName: 'excursoes__id__passageiros__id_excursao',
  );

  $$PassageirosTableProcessedTableManager get passageirosRefs {
    final manager = $$PassageirosTableTableManager(
      $_db,
      $_db.passageiros,
    ).filter((f) => f.idExcursao.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_passageirosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExcursoesTableFilterComposer
    extends Composer<_$AppDatabase, $ExcursoesTable> {
  $$ExcursoesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataHora => $composableBuilder(
    column: $table.dataHora,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qtdAssentos => $composableBuilder(
    column: $table.qtdAssentos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idStatus => $composableBuilder(
    column: $table.idStatus,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> passageirosRefs(
    Expression<bool> Function($$PassageirosTableFilterComposer f) f,
  ) {
    final $$PassageirosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.passageiros,
      getReferencedColumn: (t) => t.idExcursao,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageirosTableFilterComposer(
            $db: $db,
            $table: $db.passageiros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExcursoesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExcursoesTable> {
  $$ExcursoesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataHora => $composableBuilder(
    column: $table.dataHora,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qtdAssentos => $composableBuilder(
    column: $table.qtdAssentos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idStatus => $composableBuilder(
    column: $table.idStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExcursoesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExcursoesTable> {
  $$ExcursoesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<DateTime> get dataHora =>
      $composableBuilder(column: $table.dataHora, builder: (column) => column);

  GeneratedColumn<int> get qtdAssentos => $composableBuilder(
    column: $table.qtdAssentos,
    builder: (column) => column,
  );

  GeneratedColumn<int> get idStatus =>
      $composableBuilder(column: $table.idStatus, builder: (column) => column);

  Expression<T> passageirosRefs<T extends Object>(
    Expression<T> Function($$PassageirosTableAnnotationComposer a) f,
  ) {
    final $$PassageirosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.passageiros,
      getReferencedColumn: (t) => t.idExcursao,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageirosTableAnnotationComposer(
            $db: $db,
            $table: $db.passageiros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExcursoesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExcursoesTable,
          ExcursaoData,
          $$ExcursoesTableFilterComposer,
          $$ExcursoesTableOrderingComposer,
          $$ExcursoesTableAnnotationComposer,
          $$ExcursoesTableCreateCompanionBuilder,
          $$ExcursoesTableUpdateCompanionBuilder,
          (ExcursaoData, $$ExcursoesTableReferences),
          ExcursaoData,
          PrefetchHooks Function({bool passageirosRefs})
        > {
  $$ExcursoesTableTableManager(_$AppDatabase db, $ExcursoesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExcursoesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExcursoesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExcursoesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<DateTime> dataHora = const Value.absent(),
                Value<int> qtdAssentos = const Value.absent(),
                Value<int> idStatus = const Value.absent(),
              }) => ExcursoesCompanion(
                id: id,
                nome: nome,
                dataHora: dataHora,
                qtdAssentos: qtdAssentos,
                idStatus: idStatus,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required DateTime dataHora,
                required int qtdAssentos,
                required int idStatus,
              }) => ExcursoesCompanion.insert(
                id: id,
                nome: nome,
                dataHora: dataHora,
                qtdAssentos: qtdAssentos,
                idStatus: idStatus,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExcursoesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({passageirosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (passageirosRefs) db.passageiros],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (passageirosRefs)
                    await $_getPrefetchedData<
                      ExcursaoData,
                      $ExcursoesTable,
                      PassageiroData
                    >(
                      currentTable: table,
                      referencedTable: $$ExcursoesTableReferences
                          ._passageirosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ExcursoesTableReferences(
                            db,
                            table,
                            p0,
                          ).passageirosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.idExcursao == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ExcursoesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExcursoesTable,
      ExcursaoData,
      $$ExcursoesTableFilterComposer,
      $$ExcursoesTableOrderingComposer,
      $$ExcursoesTableAnnotationComposer,
      $$ExcursoesTableCreateCompanionBuilder,
      $$ExcursoesTableUpdateCompanionBuilder,
      (ExcursaoData, $$ExcursoesTableReferences),
      ExcursaoData,
      PrefetchHooks Function({bool passageirosRefs})
    >;
typedef $$PessoasTableCreateCompanionBuilder =
    PessoasCompanion Function({
      Value<int> id,
      required String nome,
      required String cpf,
      required String telefone,
    });
typedef $$PessoasTableUpdateCompanionBuilder =
    PessoasCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<String> cpf,
      Value<String> telefone,
    });

final class $$PessoasTableReferences
    extends BaseReferences<_$AppDatabase, $PessoasTable, PessoaData> {
  $$PessoasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PassageirosTable, List<PassageiroData>>
  _passageirosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.passageiros,
    aliasName: 'pessoas__id__passageiros__id_pessoa',
  );

  $$PassageirosTableProcessedTableManager get passageirosRefs {
    final manager = $$PassageirosTableTableManager(
      $_db,
      $_db.passageiros,
    ).filter((f) => f.idPessoa.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_passageirosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PessoasTableFilterComposer
    extends Composer<_$AppDatabase, $PessoasTable> {
  $$PessoasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cpf => $composableBuilder(
    column: $table.cpf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefone => $composableBuilder(
    column: $table.telefone,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> passageirosRefs(
    Expression<bool> Function($$PassageirosTableFilterComposer f) f,
  ) {
    final $$PassageirosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.passageiros,
      getReferencedColumn: (t) => t.idPessoa,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageirosTableFilterComposer(
            $db: $db,
            $table: $db.passageiros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PessoasTableOrderingComposer
    extends Composer<_$AppDatabase, $PessoasTable> {
  $$PessoasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cpf => $composableBuilder(
    column: $table.cpf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefone => $composableBuilder(
    column: $table.telefone,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PessoasTableAnnotationComposer
    extends Composer<_$AppDatabase, $PessoasTable> {
  $$PessoasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get cpf =>
      $composableBuilder(column: $table.cpf, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  Expression<T> passageirosRefs<T extends Object>(
    Expression<T> Function($$PassageirosTableAnnotationComposer a) f,
  ) {
    final $$PassageirosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.passageiros,
      getReferencedColumn: (t) => t.idPessoa,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PassageirosTableAnnotationComposer(
            $db: $db,
            $table: $db.passageiros,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PessoasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PessoasTable,
          PessoaData,
          $$PessoasTableFilterComposer,
          $$PessoasTableOrderingComposer,
          $$PessoasTableAnnotationComposer,
          $$PessoasTableCreateCompanionBuilder,
          $$PessoasTableUpdateCompanionBuilder,
          (PessoaData, $$PessoasTableReferences),
          PessoaData,
          PrefetchHooks Function({bool passageirosRefs})
        > {
  $$PessoasTableTableManager(_$AppDatabase db, $PessoasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PessoasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PessoasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PessoasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> cpf = const Value.absent(),
                Value<String> telefone = const Value.absent(),
              }) => PessoasCompanion(
                id: id,
                nome: nome,
                cpf: cpf,
                telefone: telefone,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required String cpf,
                required String telefone,
              }) => PessoasCompanion.insert(
                id: id,
                nome: nome,
                cpf: cpf,
                telefone: telefone,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PessoasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({passageirosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (passageirosRefs) db.passageiros],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (passageirosRefs)
                    await $_getPrefetchedData<
                      PessoaData,
                      $PessoasTable,
                      PassageiroData
                    >(
                      currentTable: table,
                      referencedTable: $$PessoasTableReferences
                          ._passageirosRefsTable(db),
                      managerFromTypedResult: (p0) => $$PessoasTableReferences(
                        db,
                        table,
                        p0,
                      ).passageirosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.idPessoa == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PessoasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PessoasTable,
      PessoaData,
      $$PessoasTableFilterComposer,
      $$PessoasTableOrderingComposer,
      $$PessoasTableAnnotationComposer,
      $$PessoasTableCreateCompanionBuilder,
      $$PessoasTableUpdateCompanionBuilder,
      (PessoaData, $$PessoasTableReferences),
      PessoaData,
      PrefetchHooks Function({bool passageirosRefs})
    >;
typedef $$PassageirosTableCreateCompanionBuilder =
    PassageirosCompanion Function({
      Value<int> id,
      required int idExcursao,
      Value<int?> idPessoa,
      required int numeroAssento,
      required int idStatusAssento,
      required bool foiPago,
    });
typedef $$PassageirosTableUpdateCompanionBuilder =
    PassageirosCompanion Function({
      Value<int> id,
      Value<int> idExcursao,
      Value<int?> idPessoa,
      Value<int> numeroAssento,
      Value<int> idStatusAssento,
      Value<bool> foiPago,
    });

final class $$PassageirosTableReferences
    extends BaseReferences<_$AppDatabase, $PassageirosTable, PassageiroData> {
  $$PassageirosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExcursoesTable _idExcursaoTable(_$AppDatabase db) =>
      db.excursoes.createAlias('passageiros__id_excursao__excursoes__id');

  $$ExcursoesTableProcessedTableManager get idExcursao {
    final $_column = $_itemColumn<int>('id_excursao')!;

    final manager = $$ExcursoesTableTableManager(
      $_db,
      $_db.excursoes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idExcursaoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PessoasTable _idPessoaTable(_$AppDatabase db) =>
      db.pessoas.createAlias('passageiros__id_pessoa__pessoas__id');

  $$PessoasTableProcessedTableManager? get idPessoa {
    final $_column = $_itemColumn<int>('id_pessoa');
    if ($_column == null) return null;
    final manager = $$PessoasTableTableManager(
      $_db,
      $_db.pessoas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idPessoaTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PassageirosTableFilterComposer
    extends Composer<_$AppDatabase, $PassageirosTable> {
  $$PassageirosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numeroAssento => $composableBuilder(
    column: $table.numeroAssento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idStatusAssento => $composableBuilder(
    column: $table.idStatusAssento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get foiPago => $composableBuilder(
    column: $table.foiPago,
    builder: (column) => ColumnFilters(column),
  );

  $$ExcursoesTableFilterComposer get idExcursao {
    final $$ExcursoesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idExcursao,
      referencedTable: $db.excursoes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExcursoesTableFilterComposer(
            $db: $db,
            $table: $db.excursoes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PessoasTableFilterComposer get idPessoa {
    final $$PessoasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idPessoa,
      referencedTable: $db.pessoas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PessoasTableFilterComposer(
            $db: $db,
            $table: $db.pessoas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PassageirosTableOrderingComposer
    extends Composer<_$AppDatabase, $PassageirosTable> {
  $$PassageirosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numeroAssento => $composableBuilder(
    column: $table.numeroAssento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idStatusAssento => $composableBuilder(
    column: $table.idStatusAssento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get foiPago => $composableBuilder(
    column: $table.foiPago,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExcursoesTableOrderingComposer get idExcursao {
    final $$ExcursoesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idExcursao,
      referencedTable: $db.excursoes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExcursoesTableOrderingComposer(
            $db: $db,
            $table: $db.excursoes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PessoasTableOrderingComposer get idPessoa {
    final $$PessoasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idPessoa,
      referencedTable: $db.pessoas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PessoasTableOrderingComposer(
            $db: $db,
            $table: $db.pessoas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PassageirosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PassageirosTable> {
  $$PassageirosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get numeroAssento => $composableBuilder(
    column: $table.numeroAssento,
    builder: (column) => column,
  );

  GeneratedColumn<int> get idStatusAssento => $composableBuilder(
    column: $table.idStatusAssento,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get foiPago =>
      $composableBuilder(column: $table.foiPago, builder: (column) => column);

  $$ExcursoesTableAnnotationComposer get idExcursao {
    final $$ExcursoesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idExcursao,
      referencedTable: $db.excursoes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExcursoesTableAnnotationComposer(
            $db: $db,
            $table: $db.excursoes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PessoasTableAnnotationComposer get idPessoa {
    final $$PessoasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idPessoa,
      referencedTable: $db.pessoas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PessoasTableAnnotationComposer(
            $db: $db,
            $table: $db.pessoas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PassageirosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PassageirosTable,
          PassageiroData,
          $$PassageirosTableFilterComposer,
          $$PassageirosTableOrderingComposer,
          $$PassageirosTableAnnotationComposer,
          $$PassageirosTableCreateCompanionBuilder,
          $$PassageirosTableUpdateCompanionBuilder,
          (PassageiroData, $$PassageirosTableReferences),
          PassageiroData,
          PrefetchHooks Function({bool idExcursao, bool idPessoa})
        > {
  $$PassageirosTableTableManager(_$AppDatabase db, $PassageirosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PassageirosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PassageirosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PassageirosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> idExcursao = const Value.absent(),
                Value<int?> idPessoa = const Value.absent(),
                Value<int> numeroAssento = const Value.absent(),
                Value<int> idStatusAssento = const Value.absent(),
                Value<bool> foiPago = const Value.absent(),
              }) => PassageirosCompanion(
                id: id,
                idExcursao: idExcursao,
                idPessoa: idPessoa,
                numeroAssento: numeroAssento,
                idStatusAssento: idStatusAssento,
                foiPago: foiPago,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int idExcursao,
                Value<int?> idPessoa = const Value.absent(),
                required int numeroAssento,
                required int idStatusAssento,
                required bool foiPago,
              }) => PassageirosCompanion.insert(
                id: id,
                idExcursao: idExcursao,
                idPessoa: idPessoa,
                numeroAssento: numeroAssento,
                idStatusAssento: idStatusAssento,
                foiPago: foiPago,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PassageirosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({idExcursao = false, idPessoa = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (idExcursao) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.idExcursao,
                                referencedTable: $$PassageirosTableReferences
                                    ._idExcursaoTable(db),
                                referencedColumn: $$PassageirosTableReferences
                                    ._idExcursaoTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (idPessoa) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.idPessoa,
                                referencedTable: $$PassageirosTableReferences
                                    ._idPessoaTable(db),
                                referencedColumn: $$PassageirosTableReferences
                                    ._idPessoaTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PassageirosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PassageirosTable,
      PassageiroData,
      $$PassageirosTableFilterComposer,
      $$PassageirosTableOrderingComposer,
      $$PassageirosTableAnnotationComposer,
      $$PassageirosTableCreateCompanionBuilder,
      $$PassageirosTableUpdateCompanionBuilder,
      (PassageiroData, $$PassageirosTableReferences),
      PassageiroData,
      PrefetchHooks Function({bool idExcursao, bool idPessoa})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExcursoesTableTableManager get excursoes =>
      $$ExcursoesTableTableManager(_db, _db.excursoes);
  $$PessoasTableTableManager get pessoas =>
      $$PessoasTableTableManager(_db, _db.pessoas);
  $$PassageirosTableTableManager get passageiros =>
      $$PassageirosTableTableManager(_db, _db.passageiros);
}
