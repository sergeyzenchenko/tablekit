Pod::Spec.new do |s|
   s.name	= 'DXTableFramework'
   s.version	= '0.1'
   s.platform = :ios, "5.0"

   s.summary	= 'For creating custom tableViews.'
   s.homepage	= 'http://111minutes.com/'
   s.author	= "111minutes"
   s.license	= ""
   s.source	= { :git => 'http://git.111min.com/the111minutes/dxtableframework.git' }
   s.source_files = 'DXTableKit/Code/**/*.{h,m}'
   s.requires_arc = true
   
   s.prefix_header_file = "DXTableKit/DXTableFramework.pch"

   s.dependency     'DXFoundation'
   s.dependency     'MBProgressHUD'
   s.dependency     'PSTCollectionView'
end
