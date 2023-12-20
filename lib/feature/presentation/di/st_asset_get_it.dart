// import 'package:get_it/get_it.dart';

// import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/st_dd_assetdetail_datasource.dart';
// import 'package:suja_shoie_app/feature/data/data_source/Remote/reomote_data_source/st_dd_assetdetail_datasourceimpl.dart';
// import 'package:suja_shoie_app/feature/data/repository/st_dd_assetdetail_repository.dart';
// import 'package:suja_shoie_app/feature/domain/repository/st_dd_assetdetail_repository.dart';
// import 'package:suja_shoie_app/feature/domain/usecase/st_dd_assetdetail_usecase.dart';

// import '../../data/core/st_dd_assetdetail_apiclient.dart';
// import '../../domain/usecase/datapoint_usecase.dart';

// final getAssetInstance = GetIt.instance;

// Future init() async{
  
// getAssetInstance.registerLazySingleton<SupportTicketAssetDetailApiclient>(()=>SupportTicketAssetDetailApiclient());

// getAssetInstance.registerLazySingleton<SupportTicketAssetDetailDatasource>(() =>SupportTicketAssetDetailDatasourceImpl(getAssetInstance()) );

// getAssetInstance.registerLazySingleton<SupportTicketAssetDetailRepository>(() => SupportTicketAssetDetailRepositoryImpl(getAssetInstance()));

// getAssetInstance.registerLazySingleton<SupportTicketAssetDetailUsecase>(() =>SupportTicketAssetDetailUsecase(getAssetInstance()));
// }