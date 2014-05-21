Pod::Spec.new do |spec|
  spec.name         = 'DXTableKit'
  spec.version      = '0.5'
  spec.license      = 'MIT'
  spec.summary      = 'iOS UITableView and UICollectionView framework'
  spec.author       = 'Sergey Zenchenko & Volodymyr Shevchenko'
  spec.source       =  :git => 'https://github.com/TheSantaClaus/tablekit', :branch => 'fetchResultsControllers'
  spec.source_files = 'DXTableKit/Code/*'
  spec.requires_arc = true
  spec.dependency 'LBDelegateMatrioska'
end
